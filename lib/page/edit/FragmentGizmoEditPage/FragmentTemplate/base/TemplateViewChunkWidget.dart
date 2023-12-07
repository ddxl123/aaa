import 'package:aaa/page/edit/FragmentGizmoEditPage/FragmentTemplate/base/FragmentTemplate.dart';
import 'package:aaa/page/edit/FragmentGizmoEditPage/FragmentTemplate/base/SingleQuillController.dart';
import 'package:flutter/material.dart';

import 'SingleQuillPreviewWidget.dart';

/// 单个块 Widget
class TemplateViewChunkWidget extends StatelessWidget {
  const TemplateViewChunkWidget({
    super.key,
    this.head,
    this.chunkTitle,
    this.action,
    required this.children,
  });

  /// 块名称，若为 null，则无名称。
  final Widget? head;
  final String? chunkTitle;
  final List<Widget>? action;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Row(
                children: [
                  head ?? Container(),
                  head == null ? Container() : SizedBox(width: 10),
                  chunkTitle == null ? Container() : Text(chunkTitle!, style: const TextStyle(color: Colors.grey)),
                  Spacer(),
                  ...(action ?? []),
                ],
              ),
              chunkTitle == null ? Container() : const SizedBox(height: 10),
              ...children,
            ],
          ),
        ),
      ),
    );
  }
}

class TemplateViewExtendChunksWidgets extends StatelessWidget {
  const TemplateViewExtendChunksWidgets({
    super.key,
    required this.extendChunks,
    required this.displayWhere,
  });

  final List<ExtendChunk> extendChunks;

  final bool Function(ExtendChunk ec) displayWhere;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: extendChunks.map(
        (e) {
          if (displayWhere(e)) {
            return TemplateViewChunkWidget(
              chunkTitle: e.chunkName,
              children: [
                SingleQuillPreviewWidget(singleQuillController: e.singleQuillController),
              ],
            );
          } else {
            return Container();
          }
        },
      ).toList(),
    );
  }
}
