import 'package:aaa/page/list/FragmentGroupListPageAbController.dart';
import 'package:drift_main/DriftDb.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:tools/tools.dart';

void showDialogForCreateMemoryGroup({
  required BuildContext context,
}) {
  showTextField1(
    context: context,
    title: '创建记忆组：',
    okText: '创建',
    cancelText: '取消',
    hintText: '请输入名称',
    text: null,
    onCancel: () {
      SmartDialog.dismiss();
    },
    onOk: (tec) async {
      if (tec.text.trim().isEmpty) {
        SmartDialog.showToast('名称不能为空！');
        return;
      }
      await DriftDb.instance.insertDAO.insertMemoryGroupWithOther(
        willMemoryGroup: WithCrts.memoryGroupsCompanion(
          id: 0.absent(),
          createdAt: 0.absent(),
          updatedAt: 0.absent(),
          memoryModelId: '',
          title: tec.text,
          type: MemoryGroupType.inApp,
          status: MemoryGroupStatus.notStart,
          newLearnCount: 0,
          reviewInterval: DateTime.now(),
          filterOut: '-',
          newReviewDisplayOrder: NewReviewDisplayOrder.mix,
          newDisplayOrder: NewDisplayOrder.random,
        ),
        willFragments: await DriftDb.instance.queryDAO.queryFragmentsByIds(
          Aber.findOrNullLast<FragmentGroupListPageAbController>()?.selectedFragmentIds().toList() ?? [],
        ),
      );

      SmartDialog.dismiss();
      SmartDialog.showToast('创建成功！');
    },
  );
}
