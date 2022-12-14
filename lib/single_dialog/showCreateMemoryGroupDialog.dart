import 'package:aaa/page/list/MemoryGroupListPageAbController.dart';
import 'package:drift_main/drift/DriftDb.dart';
import 'package:drift_main/share_common/share_enum.dart';
import 'package:tools/tools.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import '../global/GlobalAbController.dart';

/// 创建记忆组的 dialog。
Future<void> showCreateMemoryGroupDialog() async {
  await showCustomDialog(
    builder: () {
      return TextField1DialogWidget(
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
          await db.insertDAO.insertMemoryGroup(
            newMemoryGroup: Crt.memoryGroupsCompanion(
              startTime: null.toValue(),
              memoryModelId: null.toValue(),
              title: tec.text.trim(),
              willNewLearnCount: 0,
              reviewInterval: DateTime.now(),
              newReviewDisplayOrder: NewReviewDisplayOrder.mix,
              newDisplayOrder: NewDisplayOrder.random,
              creatorUserId: Aber.find<GlobalAbController>().loggedInUser()!.id,
            ),
          );

          Aber.findLast<MemoryGroupListPageAbController>().refreshPage();

          SmartDialog.dismiss();
          SmartDialog.showToast('创建成功！');
        },
      );
    },
  );
}
