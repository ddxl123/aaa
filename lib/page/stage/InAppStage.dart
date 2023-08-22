import 'package:aaa/page/edit/FragmentGizmoEditPage/FragmentTemplate/base/FragmentTemplate.dart';
import 'package:aaa/page/edit/FragmentGizmoEditPage/FragmentTemplate/template/choice/ChoiceFragmentTemplate.dart';
import 'package:aaa/page/edit/FragmentGizmoEditPage/FragmentTemplate/template/choice/ChoiceFragmentTemplateInAppStageWidget.dart';
import 'package:aaa/page/edit/FragmentGizmoEditPage/FragmentTemplate/template/question_answer/QAFragmentTemplate.dart';
import 'package:aaa/page/edit/FragmentGizmoEditPage/FragmentTemplate/template/question_answer/QAFragmentTemplateInAppStageWidget.dart';
import 'package:aaa/page/stage/InAppStageAbController.dart';
import 'package:flutter_quill/flutter_quill.dart' as q;
import 'package:tools/tools.dart';
import 'package:flutter/material.dart';

class InAppStage extends StatefulWidget {
  const InAppStage({Key? key, required this.memoryGroupId}) : super(key: key);

  final int memoryGroupId;

  @override
  State<InAppStage> createState() => _InAppStageState();
}

// Dart
class _InAppStageState extends State<InAppStage> {
  @override
  Widget build(BuildContext context) {
    return AbBuilder<InAppStageAbController>(
      putController: InAppStageAbController(memoryGroupId: widget.memoryGroupId),
      builder: (c, abw) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            actions: [_moreButtonWidget()],
          ),
          body: _body(),
          bottomNavigationBar: _bottomWidget(),
         );
      },
    );
  }

  Widget _moreButtonWidget() {
    return AbBuilder<InAppStageAbController>(
      builder: (c, abw) {
        return CustomDropdownBodyButton(
          initValue: 0,
          primaryButton: const Icon(Icons.more_horiz),
          items: [
            Item(value: 0, text: c.isButtonDataShowValue(abw) ? '按钮显示时间' : '按钮显示算法数值'),
          ],
          onChanged: (v) {
            c.isButtonDataShowValue.refreshEasy((oldValue) => !oldValue);
          },
        );
      },
    );
  }

  Widget _bottomWidget() {
    return AbBuilder<InAppStageAbController>(
      builder: (c, abw) {
        if (c.currentPerformer(abw) == null) return const SizedBox(height: 0);
        if (c.currentButtonDatas(abw).isEmpty) return Row(children: const [Expanded(child: Text('获取按钮数据分配为空！'))]);
        return Row(
          children: c.currentButtonDatas().map(
            (e) {
              final parseTime = e.parseTimeToFixView(c.memoryGroupAb().start_time!);
              if (parseTime == null) {
                return const SizedBox(height: 0);
              }
              return Expanded(
                child: AbwBuilder(
                  builder: (abw) {
                    return TextButton(
                      child: Text(c.isButtonDataShowValue(abw) ? e.value.toString() : parseTime),
                      onPressed: () async {
                        // TODO:
                        await c.finishAndNext(clickValue: e.value, contentValue: []);
                      },
                    );
                  },
                ),
              );
            },
          ).toList(),
        );
      },
    );
  }

  Widget _body() {
    return AbBuilder<InAppStageAbController>(
      builder: (c, abw) {
        return c.currentPerformer(abw) == null
            ? const Center(
                child: Text('任务已全部完成！'),
              )
            : FragmentTemplate.templateSwitch(
                c.currentPerformer(abw)!.fragmentTemplate.fragmentTemplateType,
                questionAnswer: () {
                  return QAFragmentTemplateInAppStageWidget(
                    qaFragmentTemplate: c.currentPerformer(abw)!.fragmentTemplate as QAFragmentTemplate,
                  );
                },
                choice: () {
                  return ChoiceFragmentTemplateInAppStageWidget(
                    choiceFragmentTemplate: c.currentPerformer(abw)!.fragmentTemplate as ChoiceFragmentTemplate,
                  );
                },
              );
      },
    );
  }
}
