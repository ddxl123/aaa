import 'dart:convert';

import 'package:aaa/page/edit/FragmentGroupGizmoEditPageAbController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as q;
import 'package:tools/tools.dart';

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
                  ),
                ),
              ),
              q.QuillToolbar.basic(
                controller: c.quillController,
              ),
            ],
          ),
        );
      },
    );
  }
}
