import 'package:aaa/page/list/FragmentGroupListPageAbController.dart';
import 'package:aaa/tool/aber/Aber.dart';
import 'package:aaa/tool/dialog.dart';
import 'package:drift_main/DriftDb.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

Future<void> showDialogForCreateMemoryGroup({
  required BuildContext context,
}) async {
  final textEditingController = TextEditingController();
  await showDialogCustom(
    context: context,
    title: '创建记忆组：',
    titleSize: TitleSize.medium,
    okText: '创建',
    cancelText: '取消',
    customWidget: Row(
      children: [
        Expanded(
          child: TextField(
            focusNode: FocusNode()..requestFocus(),
            controller: textEditingController,
            decoration: const InputDecoration(hintText: '请输入名称'),
          ),
        ),
      ],
    ),
    okBack: () async {
      if (textEditingController.text.trim().isEmpty) {
        SmartDialog.showToast('名称不能为空！');
        return OkBackType.none;
      }
      await DriftDb.instance.singleDAO.insertMemoryGroupWithOther(
        willMemoryGroup: WithCrts.memoryGroupsCompanion(
          id: 0.absent(),
          createdAt: 0.absent(),
          updatedAt: 0.absent(),
          memoryModelId: '',
          title: textEditingController.text,
          type: MemoryGroupType.inApp,
          status: MemoryGroupStatus.notInit,
          newLearnCount: 0,
          reviewInterval: DateTime.now(),
          filterOut: '-',
          newReviewDisplayOrder: NewReviewDisplayOrder.mix,
          newDisplayOrder: NewDisplayOrder.random,
        ),
        willFragments: await DriftDb.instance.singleDAO.queryFragmentsByIds(
          Aber.findOrNullLast<FragmentGroupListPageAbController>()?.selectedFragmentIds().toList() ?? [],
        ),
      );

      SmartDialog.showToast('创建成功！');
      return OkBackType.onlyDismiss;
    },
  );
}
