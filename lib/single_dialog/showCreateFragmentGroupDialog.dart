import 'package:aaa/page/list/FragmentGroupListPageController.dart';
import 'package:aaa/page/list/MemoryGroupListPageAbController.dart';
import 'package:drift_main/drift/DriftDb.dart';
import 'package:drift_main/share_common/share_enum.dart';
import 'package:tools/tools.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import '../global/GlobalAbController.dart';

/// 向 [fragmentGroupAb] 中添加新的碎片组。
Future<void> showCreateFragmentGroupDialog({required FragmentGroup? fragmentGroupAb}) async {
  await showCustomDialog(
    builder: (_) {
      return TextField1DialogWidget(
        title: '创建碎片组：',
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
          await db.insertDAO.insertFragmentGroup(
            willFragmentGroupsCompanion: Crt.fragmentGroupsCompanion(
              creator_user_id: Aber.find<GlobalAbController>().loggedInUser()!.id,
              father_fragment_groups_id: (fragmentGroupAb?.id).toValue(),
              client_be_selected: false,
              title: tec.text,
            ),
            syncTag: null,
          );

          await Aber.findOrNullLast<FragmentGroupListPageController>()?.refreshCurrentGroup();

          SmartDialog.dismiss();
          SmartDialog.showToast('创建成功！');
        },
      );
    },
  );
}
