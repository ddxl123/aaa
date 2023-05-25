import 'package:aaa/page/stage/InAppStage.dart';
import 'package:drift_main/drift/DriftDb.dart';
import 'package:drift_main/share_common/share_enum.dart';
import 'package:tools/tools.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class MemoryGroupGizmoEditPageAbController extends AbController {
  /// 把 gizmo 内所以信息打包成一个对象进行传入。
  /// 如果只传入 [originalMemoryGroupAb] 的话，会缺少 [bSelectedMemoryModelStorage]、[selectedFragmentCountAb] 等，修改它们后， gizmo 外的数据并没有被刷新。
  MemoryGroupGizmoEditPageAbController({required this.originalMemoryGroupAb});

  final Ab<MemoryGroup> originalMemoryGroupAb;

  late final Ab<MemoryGroup> copyMemoryGroupAb;

  final selectedMemoryModelAb = Ab<MemoryModel?>(null);

  final titleTextEditingController = TextEditingController();

  final reviewIntervalTextEditingController = TextEditingController();

  final selectedFragmentCountAb = 0.ab;

  /// 当前记忆组剩余未学习的数量。
  final Ab<int> remainNeverFragmentsCount = 0.ab;

  /// 是否全部展开
  final isExpandAll = false.ab;

  @override
  void onInit() {
    super.onInit();
    copyMemoryGroupAb = originalMemoryGroupAb().copyWith().ab;
    titleTextEditingController.text = copyMemoryGroupAb().title;
    reviewIntervalTextEditingController.text = timeDifference(target: copyMemoryGroupAb().review_interval, start: DateTime.now()).toString();
  }

  @override
  void onDispose() {
    super.onDispose();
    titleTextEditingController.dispose();
    reviewIntervalTextEditingController.dispose();
  }

  @override
  Future<bool> backListener(bool hasRoute) async {
    if (copyMemoryGroupAb() == originalMemoryGroupAb()) {
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
    final fsCount = await db.generalQueryDAO.queryFragmentsCountInMemoryGroup(memoryGroup: originalMemoryGroupAb());
    selectedFragmentCountAb.refreshInevitable((obj) => fsCount);

    final count = await DriftDb.instance.generalQueryDAO.queryFragmentsCountByStudyStatus(memoryGroup: originalMemoryGroupAb(), studyStatus: StudyStatus.never);
    remainNeverFragmentsCount.refreshEasy((oldValue) => count);

    final mm = await db.generalQueryDAO.queryMemoryModelInMemoryGroup(memoryGroup: copyMemoryGroupAb());
    selectedMemoryModelAb.refreshInevitable((obj) => mm);
  }

  /// 只进行存储。
  Future<bool> save() async {
    if (copyMemoryGroupAb().title.trim() == "") {
      SmartDialog.showToast("名称不能为空");
      return false;
    }
    if (originalMemoryGroupAb() == copyMemoryGroupAb()) {
      SmartDialog.showToast("无修改");
      return true;
    }
    final st = await SyncTag.create();
    await originalMemoryGroupAb().resetByEntity(memoryGroup: copyMemoryGroupAb(), syncTag: st);
    originalMemoryGroupAb.refreshForce();
    SmartDialog.showToast("保存成功");
    return true;
  }

  Future<void> clickContinue() async {
    final isSavedSuccess = await save();
    // TODO: 提示是否模拟。
    if (copyMemoryGroupAb().review_interval.difference(DateTime.now()).inSeconds < 600) {
      SmartDialog.showToast("复习区间至少10分钟(600秒)以上哦~");
      return;
    }
    if (!isSavedSuccess) {
      return;
    }
    Navigator.push(context, MaterialPageRoute(builder: (_) => InAppStage(memoryGroupGizmo: originalMemoryGroupAb)));
  }

  Future<void> clickStart() async {
    copyMemoryGroupAb.refreshEasy((oldValue) => oldValue..start_time = DateTime.now());
    final isSavedSuccess = await save();
    // TODO: 提示是否模拟。
    if (copyMemoryGroupAb().review_interval.difference(DateTime.now()).inSeconds < 600) {
      SmartDialog.showToast("复习区间至少10分钟(600秒)以上哦~");
      return;
    }
    if (!isSavedSuccess) {
      return;
    }
    Navigator.push(context, MaterialPageRoute(builder: (_) => InAppStage(memoryGroupGizmo: originalMemoryGroupAb)));
  }

  /// 模拟记忆模型的准确性。
  Future<void> simulate() async {
    // TODO:
  }
}
