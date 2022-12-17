import 'package:aaa/page/edit/FragmentGizmoEditPageAbController.dart';
import 'package:drift_main/drift/DriftDb.dart';
import 'package:flutter_quill/flutter_quill.dart' as q;
import 'package:tools/tools.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// 创建或编辑。
class FragmentGizmoEditPage extends StatelessWidget {
  const FragmentGizmoEditPage({Key? key, required this.fragmentAb}) : super(key: key);
  final Ab<Fragment>? fragmentAb;

  @override
  Widget build(BuildContext context) {
    return AbBuilder<FragmentGizmoEditPageAbController>(
      putController: FragmentGizmoEditPageAbController(fragmentAb: fragmentAb),
      builder: (controller, abw) {
        return Scaffold(
          appBar: _appBar(),
          body: _body(),
        );
      },
    );
  }

  PreferredSizeWidget _appBar() {
    final c = Aber.find<FragmentGizmoEditPageAbController>();
    return AppBar(
      leading: IconButton(
        icon: const FaIcon(FontAwesomeIcons.xmark, color: Colors.red),
        onPressed: () {},
      ),
      actions: [
        UnconstrainedBox(
          child: TextButton(onPressed: () {}, child: const Text('存草稿')),
        ),
        const SizedBox(width: 10),
      ],
    );
  }

  Widget _body() {
    return AbBuilder<FragmentGizmoEditPageAbController>(
      builder: (c, abw) {
        return Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: q.QuillEditor.basic(
                  controller: c.quillController,
                  readOnly: false, // true for view only mode
                ),
              ),
            ),
            Row(
              children: [
                const SizedBox(width: 10),
                IconButton(
                  icon: const FaIcon(FontAwesomeIcons.folder, color: Colors.blue),
                  onPressed: () {},
                ),
                const SizedBox(width: 10),
                IconButton(
                  icon: const FaIcon(FontAwesomeIcons.codepen, color: Colors.blue),
                  onPressed: () {},
                ),
                const Spacer(),
                IconButton(
                  icon: const FaIcon(FontAwesomeIcons.chevronLeft, color: Colors.blue),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const FaIcon(FontAwesomeIcons.chevronRight, color: Colors.blue),
                  onPressed: () {},
                ),
                const SizedBox(width: 5),
                TextButton(
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.tealAccent),
                  ),
                  child: const Text('保存'),
                  onPressed: () {},
                ),
                const SizedBox(width: 10),
              ],
            ),
            q.QuillToolbar.basic(
              multiRowsDisplay: false,
              controller: c.quillController,
            ),
          ],
        );
      },
    );
  }
}
