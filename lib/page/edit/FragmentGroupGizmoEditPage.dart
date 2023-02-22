import 'package:aaa/page/edit/FragmentGroupGizmoEditPageAbController.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';
import 'package:tools/tools.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vsc_quill_delta_to_html/vsc_quill_delta_to_html.dart';

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
                  child: QuillEditor.basic(
                    controller: c.quillController,
                    readOnly: false,
                    embedBuilders: FlutterQuillEmbeds.builders(),
                  ),
                ),
              ),
              QuillToolbar.basic(controller: c.quillController),
            ],
          ),
        );
      },
    );
  }
}
