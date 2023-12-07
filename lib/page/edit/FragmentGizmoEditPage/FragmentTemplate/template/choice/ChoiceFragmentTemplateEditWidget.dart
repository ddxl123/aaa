import 'package:aaa/page/edit/FragmentGizmoEditPage/FragmentTemplate/template/choice/ChoicePrefixType.dart';
import 'package:flutter/material.dart';
import 'package:tools/tools.dart';
import '../../base/FragmentTemplateEditWidget.dart';
import '../../base/SingleQuillEditableWidget.dart';
import '../../base/SingleQuillController.dart';
import '../../base/TemplateViewChunkWidget.dart';
import 'ChoiceFragmentTemplate.dart';

/// 选择题模板的编辑 Widget。
class ChoiceFragmentTemplateEditWidget extends StatefulWidget {
  const ChoiceFragmentTemplateEditWidget({
    super.key,
    required this.choiceFragmentTemplate,
    required this.isEditable,
  });

  final ChoiceFragmentTemplate choiceFragmentTemplate;

  final bool isEditable;

  @override
  State<ChoiceFragmentTemplateEditWidget> createState() => _ChoiceFragmentTemplateEditWidgetState();
}

class _ChoiceFragmentTemplateEditWidgetState extends State<ChoiceFragmentTemplateEditWidget> {
  @override
  Widget build(BuildContext context) {
    return FragmentTemplateEditWidget(
      fragmentTemplate: widget.choiceFragmentTemplate,
      isEditable: widget.isEditable,
      children: [
        TemplateViewChunkWidget(
          chunkTitle: "问题",
          children: [
            SingleQuillEditableWidget(
              singleQuillController: widget.choiceFragmentTemplate.question,
              isEditable: widget.isEditable,
            ),
          ],
        ),
        TemplateViewChunkWidget(
          chunkTitle: "选项",
          children: [
            Padding(
              padding: EdgeInsets.all(5),
              child: Row(
                children: [
                  Expanded(
                    child: CustomDropdownBodyButton(
                      primaryButton: Row(
                        children: [
                          Text("前缀类型："),
                          Spacer(),
                          Text(widget.choiceFragmentTemplate.choicePrefixType.displayName),
                          Icon(Icons.arrow_right_outlined, color: Colors.grey),
                        ],
                      ),
                      initValue: widget.choiceFragmentTemplate.choicePrefixType,
                      items: ChoicePrefixType.values.map(
                        (e) {
                          return CustomItem(value: e, text: e.displayName);
                        },
                      ).toList(),
                      onChanged: (v) {
                        setState(() {
                          widget.choiceFragmentTemplate.choicePrefixType = v!;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: Row(
                children: [
                  Expanded(
                    child: CustomDropdownBodyButton(
                      primaryButton: Row(
                        children: [
                          Text("选择类型："),
                          Spacer(),
                          Text(widget.choiceFragmentTemplate.choiceType == ChoiceType.simple ? "单选" : "多选"),
                          Icon(Icons.arrow_right_outlined, color: Colors.grey),
                        ],
                      ),
                      initValue: widget.choiceFragmentTemplate.choiceType,
                      items: [
                        CustomItem(value: ChoiceType.simple, text: "单选"),
                        CustomItem(value: ChoiceType.multiple_perfect_match, text: "多选"),
                      ],
                      onChanged: (v) {
                        setState(() {
                          widget.choiceFragmentTemplate.cancelAllCorrect();
                          widget.choiceFragmentTemplate.choiceType = v!;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: Row(
                children: [
                  Text("是否可乱序："),
                  Spacer(),
                  Checkbox(
                    visualDensity: kMinVisualDensity,
                    value: widget.choiceFragmentTemplate.canDisorderly,
                    onChanged: (v) {
                      setState(() {
                        widget.choiceFragmentTemplate.canDisorderly = v!;
                      });
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: Row(
                children: [
                  Spacer(),
                  Text("随机抽取展示："),？todo
                ],
              ),
            ),
            const SizedBox(height: 5),
            ...widget.choiceFragmentTemplate.choices.map(
              (e) {
                return Container(
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: const BorderRadius.all(Radius.circular(5))),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.playlist_remove, color: Colors.red),
                        onPressed: () {
                          widget.choiceFragmentTemplate.removeItem(e);
                          setState(() {});
                        },
                      ),
                      Text(
                        widget.choiceFragmentTemplate.choicePrefixType.toTypeFrom(widget.choiceFragmentTemplate.choices.indexOf(e) + 1),
                        style: TextStyle(color: Colors.amber),
                      ),
                      widget.choiceFragmentTemplate.choicePrefixType == ChoicePrefixType.none ? Container() : const Text("  "),
                      Expanded(
                        child: SingleQuillEditableWidget(singleQuillController: e, isEditable: widget.isEditable),
                      ),
                      Checkbox(
                        value: widget.choiceFragmentTemplate.isCorrect(e),
                        onChanged: (v) {
                          widget.choiceFragmentTemplate.invertCorrect(e);
                          setState(() {});
                        },
                        shape: widget.choiceFragmentTemplate.choiceType == ChoiceType.simple ? const CircleBorder() : null,
                      ),
                    ],
                  ),
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(widget.choiceFragmentTemplate.choices.isEmpty ? "请添加选项" : "右侧勾选正确选项", style: const TextStyle(color: Colors.grey)),
              ],
            ),
            Row(
              children: [
                const Spacer(),
                RawMaterialButton(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  child: const Row(
                    children: [
                      Text("添加选项"),
                      SizedBox(width: 5),
                      Icon(Icons.add_circle_outline),
                    ],
                  ),
                  onPressed: () {
                    widget.choiceFragmentTemplate.addItem(SingleQuillController());
                    setState(() {});
                  },
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
