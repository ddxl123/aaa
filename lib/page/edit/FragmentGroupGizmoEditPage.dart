import 'dart:convert';

import 'package:aaa/page/edit/FragmentGroupGizmoEditPageAbController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as q;
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';
import 'package:tools/tools.dart';

class DemoEmbed extends q.CustomBlockEmbed {
  DemoEmbed(String data) : super(demo, data);
  static const String demo = "demo";

  static DemoEmbed fromDocument(q.Document document) => DemoEmbed(jsonEncode(document.toDelta().toJson()));

  q.Document get document => q.Document.fromJson(jsonDecode(data));
}

class DemoEmbedBuilder extends q.EmbedBuilder {
  @override
  Widget build(BuildContext context, q.QuillController controller, q.Embed node, bool readOnly, bool inline) {
    return TextButton(
      child: Text("data"),
      onPressed: () {
        add(context: context, document: DemoEmbed(node.value.data).document);
      },
    );
  }

  @override
  String get key => DemoEmbed.demo;

  Future<void> add({required BuildContext context, required q.Document document}) async {}
}

class FragmentGroupGizmoEditPage extends StatelessWidget {
  const FragmentGroupGizmoEditPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AbBuilder<FragmentGroupGizmoEditPageAbController>(
      putController: FragmentGroupGizmoEditPageAbController(),
      builder: (c, abw) {
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Expanded(
                child: Container(
                  child: q.QuillEditor.basic(
                    controller: c.quillController,
                    readOnly: false,
                    embedBuilders: FlutterQuillEmbeds.builders()..add(DemoEmbedBuilder()),
                  ),
                ),
              ),
              q.QuillToolbar.basic(
                controller: c.quillController,
                embedButtons: FlutterQuillEmbeds.buttons(),
              ),
            ],
          ),
        );
      },
    );
  }
}
