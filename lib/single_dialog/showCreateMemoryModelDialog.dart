import 'package:aaa/global/GlobalAbController.dart';
import 'package:aaa/page/list/MemoryModeListPageAbController.dart';
import 'package:drift_main/drift/DriftDb.dart';
import 'package:drift_main/share_common/share_enum.dart';
import 'package:flutter/material.dart';
import 'package:tools/tools.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

/// 创建记忆模型的 dialog。
Future<void> showCreateMemoryModelDialog() async {
  await showCustomDialog(
    builder: (_) {
      return TextField1DialogWidget(
        title: '创建记忆模型：',
        okText: '创建',
        cancelText: '取消',
        text: null,
        inputDecoration: InputDecoration(hintText: '请输入名称'),
        onCancel: () {
          SmartDialog.dismiss();
        },
        onOk: (tec) async {
          if (tec.text.trim().isEmpty) {
            SmartDialog.showToast('名称不能为空！');
            return;
          }
          throw "todo";
          // await db.insertDAO.insertMemoryModel(
          //   memoryModelsCompanion: Crt.memoryModelsCompanion(
          //     creator_user_id: Aber.find<GlobalAbController>().loggedInUser()!.id,
          //     title: tec.text,
          //     father_memory_model_id: null.toValue(),
          //     button_algorithm_a: null.toValue(),
          //     button_algorithm_b: null.toValue(),
          //     button_algorithm_c: null.toValue(),
          //     button_algorithm_remark: null.toValue(),
          //     button_algorithm_usage_status: AlgorithmUsageStatus.a,
          //     familiarity_algorithm_a: null.toValue(),
          //     familiarity_algorithm_b: null.toValue(),
          //     familiarity_algorithm_c: null.toValue(),
          //     familiarity_algorithm_remark: null.toValue(),
          //     familiarity_algorithm_usage_status: AlgorithmUsageStatus.a,
          //     next_time_algorithm_a: null.toValue(),
          //     next_time_algorithm_b: null.toValue(),
          //     next_time_algorithm_c: null.toValue(),
          //     next_time_algorithm_remark: null.toValue(),
          //     next_time_algorithm_usage_status: AlgorithmUsageStatus.a,
          //   ),
          //   syncTag: await SyncTag.create(),
          //   isCloudTableWithSync: true,
          // );
          Aber.findOrNullLast<MemoryModeListPageAbController>()?.refreshMemoryModels();

          SmartDialog.dismiss();
          SmartDialog.showToast('创建成功！');
        },
      );
    },
  );
}
