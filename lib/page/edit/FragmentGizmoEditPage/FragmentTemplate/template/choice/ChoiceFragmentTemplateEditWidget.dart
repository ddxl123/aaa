import 'package:flutter/material.dart';
import '../../base/FragmentTemplateEditWidget.dart';
import '../../base/QuillEditableWidget.dart';
import '../../base/SingleEditableQuill.dart';
import '../../base/SingleFragmentTemplateChunk.dart';
import 'ChoiceFragmentTemplate.dart';

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
        SingleFragmentTemplateChunk(
          chunkTitle: "问题",
          children: [
            QuillEditableWidget(
              singleEditableQuill: widget.choiceFragmentTemplate.question,
              isEditable: widget.isEditable,
            ),
          ],
        ),
        SingleFragmentTemplateChunk(
          chunkTitle: "选项",
          children: [
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
                          widget.choiceFragmentTemplate.removeChoice(e);
                          setState(() {});
                        },
                      ),
                      Expanded(
                        child: QuillEditableWidget(singleEditableQuill: e, isEditable: widget.isEditable),
                      ),
                      Checkbox(
                        value: widget.choiceFragmentTemplate.isCorrect(e),
                        onChanged: (v) {
                          widget.choiceFragmentTemplate.changeCorrect(e);
                          setState(() {});
                        },
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
                    widget.choiceFragmentTemplate.addChoice(SingleEditableQuill());
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
