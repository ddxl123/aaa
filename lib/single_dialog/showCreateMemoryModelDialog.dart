import 'package:aaa/global/GlobalAbController.dart';
import 'package:aaa/page/list/MemoryModeListPageAbController.dart';
import 'package:drift_main/drift/DriftDb.dart';
import 'package:tools/tools.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

/// 创建记忆模型的 dialog。
Future<void> showCreateMemoryModelDialog() async {
  await showCustomDialog(
    builder: () {
      return TextField1DialogWidget(
        title: '创建记忆模型：',
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
          await db.insertDAO.insertMemoryModel(
            memoryModelsCompanion: Crt.memoryModelsCompanion(
              creatorUserId: Aber.find<GlobalAbController>().loggedInUser()!.id,
              fatherMemoryModelId: null.toValue(),
              buttonAlgorithm: '',
              familiarityAlgorithm: '',
              nextTimeAlgorithm: '',
              title: tec.text,
            ),
            syncTag: null,
          );
          Aber.findOrNullLast<MemoryModeListPageAbController>()?.refreshMemoryModels();

          SmartDialog.dismiss();
          SmartDialog.showToast('创建成功！');
        },
      );
    },
  );
}