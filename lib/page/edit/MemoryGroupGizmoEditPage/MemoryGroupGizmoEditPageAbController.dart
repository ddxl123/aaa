import 'dart:ffi';

import 'package:aaa/page/stage/InAppStage.dart';
import 'package:aaa/push_page/push_page.dart';
import 'package:drift_main/drift/DriftDb.dart';
import 'package:drift_main/httper/httper.dart';
import 'package:drift_main/share_common/share_enum.dart';
import 'package:tools/tools.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

enum FragmentAndMemoryInfoStatus {
  /// 本地和云端数量都为 0
  zero,

  /// 本地和云端数量都不为 0，且数量相同
  allDownloaded,

  /// 本地数量为 0，云端数量不为 0
  neverDownloaded,

  /// 本地和云端数量都不为 0，但数量不一致
  /// 1. 已下载过，但是云端存在一些未下载的，需要下载云端未下载的
  /// 2. 需要删除本地多余的，只删除记忆信息，不删除碎片，因为其他记忆组内可能使用了。
  differentDownload,
}

class MemoryGroupGizmoEditPageAbController extends AbController {
  /// 把 gizmo 内所以信息打包成一个对象进行传入。
  /// 如果只传入 [memoryGroupId] 的话，会缺少 [bSelectedMemoryModelStorage]、[fragmentCountAb] 等，修改它们后， gizmo 外的数据并没有被刷新。
  MemoryGroupGizmoEditPageAbController({required this.memoryGroupId});

  final int memoryGroupId;

  final memoryGroupAb = Ab<MemoryGroup>.late();

  final memoryModelAb = Ab<MemoryModel?>(null);

  final titleTextEditingController = TextEditingController();

  final reviewIntervalTextEditingController = TextEditingController();

  final fragmentCountAb = 0.ab;

  /// 当前记忆组剩余未学习的数量。
  final Ab<int> remainNeverFragmentsCount = 0.ab;

  /// 是否全部展开
  final isExpandAll = false.ab;

  final fragmentAndMemoryInfoStatus = FragmentAndMemoryInfoStatus.zero.ab;

  @override
  void onDispose() {
    super.onDispose();
    titleTextEditingController.dispose();
    reviewIntervalTextEditingController.dispose();
  }

  @override
  Future<bool> backListener(bool hasRoute) async {
    if (!await checkIsExistModify()) {
      return false;
    }
    bool isBack = false;
    await showCustomDialog(
      builder: (_) => OkAndCancelDialogWidget(
        title: '内容存在修改，是否要丢弃？',
        okText: '丢弃',
        cancelText: '继续编辑',
        text: null,
        onOk: () async {
          SmartDialog.dismiss();
          isBack = true;
        },
        onCancel: () {
          SmartDialog.dismiss();
        },
      ),
    );
    return !isBack;
  }

  @override
  bool get isEnableLoading => true;

  @override
  Widget loadingWidget() => const Material(child: Center(child: Text('加载中...')));

  @override
  Future<void> loadingFuture() async {
    await checkLocalMgAndMm();
    final localCount = await checkLocalFragmentAndMemoryInfos();

    // 不需要 await
    checkCloudCount(localCount: localCount);
  }

  /// 只从本地获取。
  Future<void> checkLocalMgAndMm() async {
    // 查询本地记忆组和算法组
    var mg = (await driftDb.generalQueryDAO.queryOrNullMemoryGroup(memoryGroupId: memoryGroupId))!;
    var mm = mg.memory_model_id == null ? null : await driftDb.generalQueryDAO.queryOrNullMemoryModel(memoryModelId: mg.memory_model_id!);

    memoryGroupAb.lateAssign(mg);
    memoryGroupAb.refreshForce();
    memoryModelAb.refreshEasy((oldValue) => mm);
    titleTextEditingController.text = memoryGroupAb().title;
    reviewIntervalTextEditingController.text = timeDifference(target: memoryGroupAb().review_interval, start: DateTime.now()).toString();
  }

  Future<int> checkLocalFragmentAndMemoryInfos() async {
    final localCount = await driftDb.generalQueryDAO.queryFragmentInMemoryGroupCount(memoryGroupId: memoryGroupId);
    if (localCount == 0) {
      fragmentAndMemoryInfoStatus.refreshEasy((oldValue) => FragmentAndMemoryInfoStatus.zero);
    }
    fragmentCountAb.refreshEasy((oldValue) => localCount);
    fragmentAndMemoryInfoStatus.refreshEasy((oldValue) => FragmentAndMemoryInfoStatus.allDownloaded);
    await queryLocalNeverStudyCount();

    return localCount;
  }

  Future<void> checkCloudCount({required int localCount}) async {
    final result = await request(
      path: HttpPath.GET__LOGIN_REQUIRED_MEMORY_GROUP_HANDLE_FRAGMENTS_COUNT_QUERY,
      dtoData: MemoryGroupFragmentsCountQueryDto(
        memory_group_id: memoryGroupId,
        memory_group_ids_list: null,
      ),
      parseResponseVoData: MemoryGroupFragmentsCountQueryVo.fromJson,
    );
    await result.handleCode(
      code160201: (String showMessage, vo) async {
        if (!state.mounted) return;

        // 进行覆盖
        await driftDb.insertDAO.insertMemoryGroup(memoryGroup: vo.memory_group);
        if (vo.memory_model != null) {
          await driftDb.insertDAO.insertMemoryModel(memoryModel: vo.memory_model!);
        }
        // 再本地查询一遍
        await checkLocalMgAndMm();

        // 数量相关
        if (localCount == 0 && vo.count == 0) {
          fragmentAndMemoryInfoStatus.refreshEasy((oldValue) => FragmentAndMemoryInfoStatus.zero);
          return;
        }
        if (localCount == 0 && vo.count > 0) {
          fragmentAndMemoryInfoStatus.refreshEasy((oldValue) => FragmentAndMemoryInfoStatus.neverDownloaded);
          return;
        }
        if (localCount != vo.count) {
          fragmentAndMemoryInfoStatus.refreshEasy((oldValue) => FragmentAndMemoryInfoStatus.differentDownload);
          return;
        }
      },
      otherException: (a, b, c) async {
        logger.outErrorHttp(code: a, showMessage: b.showMessage, debugMessage: b.debugMessage, st: c);
      },
    );

    // 再查询一遍
    await queryLocalNeverStudyCount();

    final otherResult = await request(
      path: HttpPath.GET__LOGIN_REQUIRED_MEMORY_GROUP_HANDLE_MEMORY_GROUP_PAGE_OTHER_QUERY,
      dtoData: MemoryGroupPageOtherQueryDto(
        memory_group_id: memoryGroupId,
        dto_padding_1: null,
      ),
      parseResponseVoData: MemoryGroupPageOtherQueryVo.fromJson,
    );

    await otherResult.handleCode(
      code160701: (String showMessage, MemoryGroupPageOtherQueryVo vo) async {
        //TODO: 次要查询？
      },
    );
  }

  Future<void> queryLocalNeverStudyCount() async {
    final count = await driftDb.generalQueryDAO.queryManyFragmentByStudyStatus(
      memoryGroupId: memoryGroupId,
      studyStatus: StudyStatus.never,
    );
    remainNeverFragmentsCount.refreshEasy((oldValue) => count.length);
  }

  Future<void> allDownloadFragmentAndMemoryInfos({required int memoryGroupId}) async {
    //TODO: 加载框
    SmartDialog.showLoading(msg: "下载中...");
    final result = await request(
      path: HttpPath.GET__LOGIN_REQUIRED_MEMORY_GROUP_HANDLE_MEMORY_GROUP_MEMORY_INFO_DOWNLOAD,
      dtoData: MemoryGroupMemoryInfoDownloadDto(
        memory_group_id: memoryGroupId,
        dto_padding_1: null,
      ),
      parseResponseVoData: MemoryGroupMemoryInfoDownloadVo.fromJson,
      onReceiveProgress: (a, b) {
        //TODO: 为什么 onReceiveProgress 不被调用
        print("~~~~ $a-$b");
      },
    );
    await result.handleCode(
      code160801: (message, vo) async {
        await driftDb.insertDAO.insertManyFragmentAndMemoryInfos(fragmentAndMemoryInfos: vo.fragment_and_memory_infos_list);
        await checkLocalFragmentAndMemoryInfos();
        SmartDialog.showToast("下载成功！");
      },
      otherException: (a, b, c) async {
        logger.outErrorHttp(code: a, showMessage: b.showMessage, debugMessage: b.debugMessage, st: c);
      },
    );

    SmartDialog.dismiss(status: SmartStatus.loading);
    SmartDialog.dismiss(status: SmartStatus.dialog);
  }

  Future<void> differentFragmentAndMemoryInfos() async {
    //TODO: 加载框
    SmartDialog.showLoading(msg: "下载中...");
    final result = await request(
      path: HttpPath.GET__LOGIN_REQUIRED_MEMORY_GROUP_HANDLE_MEMORY_INFO_DOWNLOAD_ONLY_ID,
      dtoData: MemoryInfoDownloadOnlyIdDto(
        memory_group_id: memoryGroupId,
        dto_padding_1: null,
      ),
      parseResponseVoData: MemoryInfoDownloadOnlyIdVo.fromJson,
    );
    await result.handleCode(
      code151601: (String showMessage, vo) async {
        final localAll = (await driftDb.generalQueryDAO.queryMemoryInfoIdAndVersion(memoryGroupId: memoryGroupId)).toSet();
        final cloudAll = vo.memory_info_id_list.toSet();
        // 定义三个空列表，用来存储结果
        List<int> onlyLocal = []; // 仅存在于本地
        List<int> onlyCloud = []; // 仅存在于云端
        onlyLocal.addAll(localAll.difference(cloudAll));
        onlyCloud.addAll(cloudAll.difference(localAll));

        // 处理仅存在于本地
        await driftDb.batch(
          (batch) async {
            batch.deleteWhere(driftDb.fragmentMemoryInfos, (tbl) => tbl.id.isIn(onlyLocal));
          },
        );

        // 处理仅存在于云端
        final result = await request(
          path: HttpPath.POST__LOGIN_REQUIRED_MEMORY_GROUP_HANDLE_MEMORY_GROUP_MEMORY_INFO_DOWNLOAD_BY_IDS,
          dtoData: MemoryGroupMemoryInfoDownloadByIdsDto(
            memory_info_ids_list: onlyCloud,
            dto_padding_1: null,
          ),
          onReceiveProgress: (count, total) {
            // TODO: 下载中...
          },
          parseResponseVoData: MemoryGroupMemoryInfoDownloadByIdsVo.fromJson,
        );
        await result.handleCode(
          code161701: (String showMessage, MemoryGroupMemoryInfoDownloadByIdsVo vo) async {
            await driftDb.insertDAO.insertManyFragmentAndMemoryInfos(fragmentAndMemoryInfos: vo.fragment_and_memory_infos_list);
          },
        );
      },
      otherException: (a, b, c) async {
        logger.outErrorHttp(code: a, showMessage: b.showMessage, debugMessage: b.debugMessage, st: c);
      },
    );
    SmartDialog.dismiss(status: SmartStatus.loading);
  }

  /// 返回 true 则存在修改
  Future<bool> checkIsExistModify() async {
    final mg = await driftDb.generalQueryDAO.queryOrNullMemoryGroup(memoryGroupId: memoryGroupId);
    if (mg != memoryGroupAb()) {
      return true;
    } else {
      return false;
    }
  }

  /// 只进行存储。
  Future<bool> onlySave() async {
    if (memoryGroupAb().title.trim() == "") {
      SmartDialog.showToast("名称不能为空");
      return false;
    }
    if (!await checkIsExistModify()) {
      SmartDialog.showToast("无修改");
      return true;
    }
    await driftDb.updateDAO.resetMemoryGroupAutoSyncVersion(entity: memoryGroupAb());
    return true;
  }

  Future<void> clickStart() async {
    if (memoryGroupAb().review_interval.difference(DateTime.now()).inSeconds < 600) {
      SmartDialog.showToast("复习区间至少10分钟(600秒)以上哦~");
      return;
    }
    if (memoryModelAb() == null) {
      SmartDialog.showToast("必须选择一个记忆算法！");
      return;
    }
    if (fragmentCountAb() == 0) {
      SmartDialog.showToast("碎片数量不能为 0");
      return;
    }

    memoryGroupAb.refreshEasy((oldValue) => oldValue..start_time = DateTime.now());
    final isSavedSuccess = await onlySave();
    if (!isSavedSuccess) {
      return;
    }
    Navigator.pop(context);
    await pushToInAppStage(context: context, memoryGroupId: memoryGroupAb().id);
  }

  /// 模拟记忆模型的准确性。
  Future<void> simulate() async {
    // TODO:
  }
}
