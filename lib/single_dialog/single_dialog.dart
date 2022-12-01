import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:tools/tools.dart';

void showDialogForCreateMemoryGroup() {
  showTextField1(
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
      // await DriftDb.instance.insertDAO.insertMemoryGroupWithOtherWithRef(
      //   willMemoryGroup: WithCrts.memoryGroupsCompanion(
      //     startTime: null.toValue(),
      //     memoryModelId: null.toValue(),
      //     title: tec.text,
      //     willNewLearnCount: 0,
      //     reviewInterval: DateTime.now(),
      //     newReviewDisplayOrder: NewReviewDisplayOrder.mix,
      //     newDisplayOrder: NewDisplayOrder.random,
      //     isEnableFilterOutAlgorithm: false,
      //     isFilterOutAlgorithmFollowMemoryModel: false,
      //     filterOutAlgorithm: '',
      //     isEnableFloatingAlgorithm: false,
      //     isFloatingAlgorithmFollowMemoryModel: false,
      //     floatingAlgorithm: '',
      //   ),
      //   willFragments: await DriftDb.instance.generalQueryDAO.queryFragmentsByIds(
      //     Aber.findOrNullLast<FragmentGroupListPageAbController>()?.selectedFragmentIds().toList() ?? [],
      //   ),
      // );

      SmartDialog.dismiss();
      SmartDialog.showToast('创建成功！');
    },
  );
}
