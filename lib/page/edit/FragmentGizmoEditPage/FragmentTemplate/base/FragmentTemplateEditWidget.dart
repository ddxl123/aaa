import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as q;
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:tools/tools.dart';

import '../../custom_embeds/DemoEmbed.dart';
import 'FragmentTemplate.dart';
import 'SingleQuillEditableWidget.dart';
import 'TemplateViewChunkWidget.dart';

/// 可编辑状态下的基本 Widget。
class FragmentTemplateEditWidget extends StatefulWidget {
  const FragmentTemplateEditWidget({
    super.key,
    required this.fragmentTemplate,
    required this.isEditable,
    required this.children,
  });

  final FragmentTemplate fragmentTemplate;

  final bool isEditable;

  final List<Widget> children;

  @override
  State<FragmentTemplateEditWidget> createState() => _FragmentTemplateEditWidgetState();
}

class _FragmentTemplateEditWidgetState extends State<FragmentTemplateEditWidget> {
  @override
  void initState() {
    super.initState();
    widget.fragmentTemplate.currentFocusSingleEditableQuill.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(15),
            physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
            child: Column(
              children: [
                ...widget.children,
                ...widget.fragmentTemplate.extendChunks.map(
                  (e) {
                    return TemplateViewChunkWidget(
                      action: [
                        widget.fragmentTemplate.isHideExtendChunkTypeOption()
                            ? Container()
                            : CustomDropdownBodyButton(
                                initValue: e.extendChunkDisplayType,
                                items: ExtendChunkDisplayType.values.map(
                                  (e) {
                                    return CustomItem(value: e, text: e.displayName);
                                  },
                                ).toList(),
                                onChanged: (v) {
                                  setState(() {
                                    e.extendChunkDisplayType = v!;
                                  });
                                },
                              ),
                        SizedBox(width: 10),
                        CustomDropdownBodyButton(
                          primaryButton: Icon(Icons.settings, size: 20, color: Colors.grey),
                          initValue: 0,
                          items: [
                            CustomItem(
                              value: 0,
                              item: Text("修改块名称"),
                            ),
                            CustomItem(
                              value: 1,
                              item: Text("移除块", style: TextStyle(color: Colors.red)),
                            ),
                          ],
                          onChanged: (v) async {
                            if (v == 0) {
                              await showCustomDialog(
                                builder: (ctx) {
                                  return TextField1DialogWidget(
                                    textEditingController: TextEditingController(text: e.chunkName),
                                    cancelText: "取消",
                                    okText: "确定",
                                    onOk: (c) {
                                      setState(() {
                                        e.chunkName = c.text;
                                      });
                                      SmartDialog.dismiss(status: SmartStatus.dialog);
                                    },
                                  );
                                },
                              );
                            }
                            if (v == 1) {
                              await showCustomDialog(
                                builder: (ctx) {
                                  return OkAndCancelDialogWidget(
                                    text: "确认移除当前块？",
                                    cancelText: "取消",
                                    okText: "确定",
                                    onOk: () {
                                      setState(() {
                                        widget.fragmentTemplate.removeExtendChunk(e);
                                      });
                                      SmartDialog.dismiss(status: SmartStatus.dialog);
                                    },
                                  );
                                },
                              );
                            }
                          },
                        ),
                      ],
                      chunkTitle: e.chunkName.isEmpty ? null : e.chunkName,
                      children: [
                        SingleQuillEditableWidget(
                          singleQuillController: e.singleQuillController,
                          isEditable: widget.isEditable,
                        ),
                      ],
                    );
                  },
                ),
                TextButton(
                  child: Text("＋ 添加块"),
                  onPressed: () {
                    showCustomDialog(
                      builder: (BuildContext context) {
                        return TextField1DialogWidget(
                          textEditingController: TextEditingController(),
                          inputDecoration: const InputDecoration(hintText: "请输入块的名称，不输入则无名称"),
                          cancelText: "取消",
                          okText: "创建块",
                          onOk: (c) {
                            widget.fragmentTemplate.addExtendChunk(chunkName: c.text, extendsChunkDisplayType: ExtendChunkDisplayType.only_end);
                            setState(() {});
                            SmartDialog.dismiss(status: SmartStatus.dialog);
                            Focus.of(context).unfocus();
                          },
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        widget.fragmentTemplate.currentFocusSingleEditableQuill.value == null || !widget.isEditable
            ? Container()
            : q.QuillToolbar.basic(
                multiRowsDisplay: false,
                controller: widget.fragmentTemplate.currentFocusSingleEditableQuill.value!.quillController,
                embedButtons: [
                  ...FlutterQuillEmbeds.buttons(),
                  (controller, toolbarIconSize, iconTheme, dialogTheme) => DemoToolBar(controller),
                ],
              ),
      ],
    );
  }
}
