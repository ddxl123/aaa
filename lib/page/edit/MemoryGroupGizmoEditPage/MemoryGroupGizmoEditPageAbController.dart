import 'package:aaa/page/stage/InAppStage.dart';
import 'package:aaa/push_page/push_page.dart';
import 'package:drift_main/drift/DriftDb.dart';
import 'package:drift_main/share_common/share_enum.dart';
import 'package:tools/tools.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class MemoryGroupGizmoEditPageAbController extends AbController {
  /// 把 gizmo 内所以信息打包成一个对象进行传入。
  /// 如果只传入 [memoryGroupId] 的话，会缺少 [bSelectedMemoryModelStorage]、[selectedFragmentCountAb] 等，修改它们后， gizmo 外的数据并没有被刷新。
  MemoryGroupGizmoEditPageAbController({required this.memoryGroupId});

  final int memoryGroupId;

  late final MemoryGroup oMemoryGroup;

  late final Ab<MemoryGroup> memoryGroupAb;

  final selectedMemoryModelAb = Ab<MemoryModel?>(null);

  final titleTextEditingController = TextEditingController();

  final reviewIntervalTextEditingController = TextEditingController();

  final selectedFragmentCountAb = 0.ab;

  /// 当前记忆组剩余未学习的数量。
  final Ab<int> remainNeverFragmentsCount = 0.ab;

  /// 是否全部展开
  final isExpandAll = false.ab;

  @override
  void onDispose() {
    super.onDispose();
    titleTextEditingController.dispose();
    reviewIntervalTextEditingController.dispose();
  }

  @override
  Future<bool> backListener(bool hasRoute) async {
    if (memoryGroupAb() == oMemoryGroup) {
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
    throw "TODO";
    // memoryGroupAb = (await db.generalQueryDAO.queryMemoryGroupById(id: memoryGroupId))!.ab;
    // oMemoryGroup = memoryGroupAb().copyWith();
    // titleTextEditingController.text = memoryGroupAb().title;
    // reviewIntervalTextEditingController.text = timeDifference(target: memoryGroupAb().review_interval, start: DateTime.now()).toString();
    //
    // final fsCount = await db.generalQueryDAO.queryFragmentsCountInMemoryGroup(memoryGroup: memoryGroupAb());
    // selectedFragmentCountAb.refreshInevitable((obj) => fsCount);
    //
    // await refreshNeverStudyCount();
    //
    // final mm = await db.generalQueryDAO.queryMemoryModelInMemoryGroup(memoryGroup: memoryGroupAb());
    // selectedMemoryModelAb.refreshInevitable((obj) => mm);
  }

  Future<void> refreshNeverStudyCount() async {
    // final count = await DriftDb.instance.generalQueryDAO.queryFragmentsCountByStudyStatus(memoryGroup: memoryGroupAb(), studyStatus: StudyStatus.never);
    // remainNeverFragmentsCount.refreshEasy((oldValue) => count);
  }

  /// 只进行存储。
  Future<bool> save() async {
    if (memoryGroupAb().title.trim() == "") {
      SmartDialog.showToast("名称不能为空");
      return false;
    }
    if (oMemoryGroup == memoryGroupAb()) {
      SmartDialog.showToast("无修改");
      return true;
    }
    final st = await SyncTag.create();
    // await oMemoryGroup.resetByEntity(
    //   memoryGroup: memoryGroupAb(),
    //   syncTag: st,
    //   isCloudTableWithSync: true,
    // );
    throw "TODO";
    SmartDialog.showToast("保存成功");
    return true;
  }

  Future<void> clickContinue() async {
    final isSavedSuccess = await save();
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
    memoryGroupAb.refreshEasy((oldValue) => oldValue..start_time = DateTime.now());
    final isSavedSuccess = await save();
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

  /// 模拟记忆模型的准确性。
  Future<void> simulate() async {
    // TODO:
  }
}
