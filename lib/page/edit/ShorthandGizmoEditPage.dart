import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:drift_main/drift/DriftDb.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:tools/tools.dart';

import 'ShorthandGizmoEditPageAbController.dart';

class ShorthandGizmoEditPage extends StatelessWidget {
  const ShorthandGizmoEditPage({Key? key, required this.initShorthand}) : super(key: key);

  final Shorthand? initShorthand;

  @override
  Widget build(BuildContext context) {
    return AbBuilder<ShorthandGizmoEditPageAbController>(
      putController: ShorthandGizmoEditPageAbController(initShorthand: initShorthand),
      builder: (c, abw) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                c.abBack();
              },
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.check),
                onPressed: () async {
                  await c.save();
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          body: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: QuillEditor.basic(
                    controller: c.quillController,
                    readOnly: false,
                  ),
                ),
              ),
              QuillToolbar.basic(
                controller: c.quillController,
                multiRowsDisplay: false,
              ),
            ],
          ),
        );
      },
    );
  }
}
