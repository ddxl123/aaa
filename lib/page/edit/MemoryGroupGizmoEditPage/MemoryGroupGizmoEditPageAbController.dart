import 'dart:ffi';

import 'package:aaa/page/stage/InAppStage.dart';
import 'package:aaa/push_page/push_page.dart';
import 'package:drift_main/drift/DriftDb.dart';
import 'package:drift_main/httper/httper.dart';
import 'package:drift_main/share_common/share_enum.dart';
import 'package:tools/tools.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

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

  final hasFragmentAndMemoryInfo = false.ab;

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
    await checkMg();
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
      otherException: (a, b, c) async {
        logger.outErrorHttp(code: a, showMessage: b.showMessage, debugMessage: b.debugMessage, st: c);
      },
    );

    checkFragmentAndMemoryInfos();
  }

  Future<void> checkMg() async {
    // 查询本地是否存在记忆组和算法组
    var mg = await driftDb.generalQueryDAO.queryOrNullMemoryGroup(memoryGroupId: memoryGroupId);
    var mm = await driftDb.generalQueryDAO.queryOrNullMemoryModel(memoryGroupId: memoryGroupId);

    // 云端获取
    final result = await request(
      path: HttpPath.GET__LOGIN_REQUIRED_MEMORY_GROUP_HANDLE_MEMORY_GROUP_PAGE_FIRST_QUERY,
      dtoData: MemoryGroupPageFirstQueryDto(
        memory_group_id: memoryGroupId,
        dto_padding_1: null,
      ),
      parseResponseVoData: MemoryGroupPageFirstQueryVo.fromJson,
    );
    await result.handleCode(
      code160601: (String showMessage, MemoryGroupPageFirstQueryVo vo) async {
        if (mg == null) {
          mg = vo.memory_group;
          mm = vo.memory_model;

          await driftDb.insertDAO.insertMemoryGroup(memoryGroup: mg!);
          if (mm != null) {
            await driftDb.insertDAO.insertMemoryModel(memoryModel: mm!);
          }
        } else {
          if (mg?.sync_version != vo.memory_group.sync_version) {
            showCustomDialog(
              builder: (BuildContext context) {
                return OkAndCancelDialogWidget(
                  text: "记忆组配置 本地和云端数据不一致，是否进行同步？",
                  columnChildren: [
                    Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            child: Text("本地覆盖至云端"),
                            onPressed: () {
                              // TODO
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            child: Text("云端覆盖至本地"),
                            onPressed: () {
                              // TODO
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            child: Text("不进行同步"),
                            onPressed: () {
                              SmartDialog.dismiss(status: SmartStatus.dialog);
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            );
          }
        }
      },
      otherException: (a, b, c) async {
        logger.outErrorHttp(code: a, showMessage: b.showMessage, debugMessage: b.debugMessage, st: c);
      },
    );
    memoryGroupAb.lateAssign(mg!);
    memoryModelAb.refreshEasy((oldValue) => mm);
    titleTextEditingController.text = memoryGroupAb().title;
    reviewIntervalTextEditingController.text = timeDifference(target: memoryGroupAb().review_interval, start: DateTime.now()).toString();
  }

  Future<void> checkFragmentAndMemoryInfos() async {
    final localCount = await driftDb.generalQueryDAO.queryFragmentInMemoryGroupCount(memoryGroupId: memoryGroupId);
    if (localCount == 0) {
      hasFragmentAndMemoryInfo.refreshEasy((oldValue) => false);
      SmartDialog.showToast("碎片数量不能为 0");
    }
    fragmentCountAb.refreshEasy((oldValue) => localCount);
    refreshNeverStudyCount();

    final result = await request(
      path: HttpPath.GET__LOGIN_REQUIRED_MEMORY_GROUP_HANDLE_FRAGMENTS_COUNT_QUERY,
      dtoData: MemoryGroupFragmentsCountQueryDto(
        memory_group_id: memoryGroupId,
        dto_padding_1: null,
      ),
      parseResponseVoData: MemoryGroupFragmentsCountQueryVo.fromJson,
    );
    await result.handleCode(
      code160201: (String showMessage, vo) async {
        if (localCount != vo.count) {
          if (localCount == 0) {
            await showCustomDialog(
              builder: (ctx) => OkAndCancelDialogWidget(
                text: "未下载碎片，是否进行下载？",
                okText: "下载",
                cancelText: "等会下",
                onOk: () {
                  syncFragmentAndMemoryInfos(memoryGroupId: memoryGroupId, syncFAndMi: SyncFAndMi.only_download);
                },
              ),
            );
          } else {
            await showCustomDialog(
              builder: (ctx) => OkAndCancelDialogWidget(
                text: "碎片数量 本地与云端不一致，是否进行同步？",
                columnChildren: [
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          child: Text("本地覆盖至云端"),
                          onPressed: () {
                            // TODO
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          child: Text("云端覆盖至本地"),
                          onPressed: () {
                            // TODO
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          child: Text("不进行同步"),
                          onPressed: () {
                            SmartDialog.dismiss(status: SmartStatus.dialog);
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
        }
      },
      otherException: (a, b, c) async {
        logger.outErrorHttp(code: a, showMessage: b.showMessage, debugMessage: b.debugMessage, st: c);
      },
    );
  }

  Future<void> refreshNeverStudyCount() async {
    final count = await DriftDb.instance.generalQueryDAO.queryManyMemoryInfoByStudyStatus(
      memoryGroupId: memoryGroupId,
      studyStatus: StudyStatus.never,
    );
    remainNeverFragmentsCount.refreshEasy((oldValue) => count.length);
  }

  Future<void> syncFragmentAndMemoryInfos({required int memoryGroupId, required SyncFAndMi syncFAndMi}) async {
    if (syncFAndMi == SyncFAndMi.only_download) {
      final result = await request(
        path: HttpPath.GET__LOGIN_REQUIRED_MEMORY_GROUP_HANDLE_MEMORY_GROUP_SYNC_F_AND_MI,
        dtoData: MemoryGroupSyncFAndMiDto(
          memory_group_id: memoryGroupId,
          sync_f_and_mi: syncFAndMi,
        ),
        parseResponseVoData: MemoryGroupSyncFAndMiVo.fromJson,
        onReceiveProgress: (a, b) {
          //TODO
          print("~~~~ $a-$b");
        },
      );
      await result.handleCode(
        code160801: (MemoryGroupSyncFAndMiVo vo) async {
          //TODO
          print(vo.toJson());
        },
        otherException: (a, b, c) async {
          logger.outErrorHttp(code: a, showMessage: b.showMessage, debugMessage: b.debugMessage, st: c);
        },
      );
    }
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

  Future<void> clickContinue() async {
    final isSavedSuccess = await onlySave();
    // TODO: 提示是否模拟。
    if (memoryGroupAb().review_interval.difference(DateTime.now()).inSeconds < 600) {
      SmartDialog.showToast("复习区间至少10分钟(600秒)以上哦~");
      return;
    }
    if (!isSavedSuccess) {
      return;
    }
    Navigator.pop(context);
    await pushToInAppStage(context: context, memoryGroupId: memoryGroupAb().id);
  }

  Future<void> clickStart() async {
    if (memoryGroupAb().review_interval.difference(DateTime.now()).inSeconds < 600) {
      SmartDialog.showToast("复习区间至少10分钟(600秒)以上哦~");
      return;
    }
    if (fragmentCountAb() == 0) {
      SmartDialog.showToast("碎片数量不能为 0");
      await checkFragmentAndMemoryInfos();
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
