import 'package:aaa/page/edit/FragmentGizmoEditPageAbController.dart';
import 'package:drift_main/drift/DriftDb.dart';
import 'package:flutter_quill/flutter_quill.dart' as q;
import 'package:tools/tools.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

/// 创建或编辑。
class FragmentGizmoEditPage extends StatelessWidget {
  const FragmentGizmoEditPage({
    Key? key,
    required this.initSomeBefore,
    required this.initSomeAfter,
    required this.initFragmentAb,
    required this.initFragmentGroup,
  }) : super(key: key);

  final List<Ab<Fragment>> initSomeBefore;

  final List<Ab<Fragment>> initSomeAfter;

  final Ab<Fragment>? initFragmentAb;

  final Ab<FragmentGroup>? initFragmentGroup;

  @override
  Widget build(BuildContext context) {
    return AbBuilder<FragmentGizmoEditPageAbController>(
      putController: FragmentGizmoEditPageAbController(
        initFragmentAb: initFragmentAb,
        initFragmentGroup: initFragmentGroup,
        initSomeBefore: initSomeBefore,
        initSomeAfter: initSomeAfter,
      ),
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
        onPressed: () {
          final result = c.currentPerformer.isDataModified();
          if (result != null) {
            SmartDialog.showToast(result);
          } else {
            Navigator.pop(c.context);
          }
        },
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
                // 存放位置
                AbwBuilder(
                  builder: (abwSingle) {
                    return IconButton(
                      // style: c.selectedFragmentGroupChainsStorage(abwSingle) == null
                      //     ? const ButtonStyle(
                      //         backgroundColor: MaterialStatePropertyAll(Color.fromARGB(50, 255, 69, 0)),
                      //       )
                      //     : null,
                      icon: const FaIcon(FontAwesomeIcons.folder, color: Colors.blue),
                      onPressed: () {
                        c.showSaveGroup();
                      },
                    );
                  },
                ),
                // AbwBuilder(
                //   builder: (abwSingle) {
                //     if (c.selectedFragmentGroupChainsStorage(abwSingle) == null) {
                //       return Container();
                //     }
                //     if (c.selectedFragmentGroupChainsStorage(abwSingle)!.isEmpty) {
                //       return const Text('~');
                //     }
                //     return Text(c.selectedFragmentGroupChainsStorage(abwSingle)!.last.title);
                //   },
                // ),
                const SizedBox(width: 10),
                // 使用模板
                IconButton(
                  icon: const FaIcon(FontAwesomeIcons.codepen, color: Colors.blue),
                  onPressed: () {},
                ),
                const Spacer(),
                // 上一个
                IconButton(
                  icon: const FaIcon(FontAwesomeIcons.chevronLeft, color: Colors.blue),
                  onPressed: () {},
                ),
                // 下一个
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
                  onPressed: () {
                    // c.create();
                  },
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
