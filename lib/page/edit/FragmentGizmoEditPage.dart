import 'package:aaa/page/edit/FragmentGizmoEditPageAbController.dart';
import 'package:aaa/single_dialog/showPrivatePublishDialog.dart';
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
  }) : super(key: key);

  final List<Ab<Fragment>> initSomeBefore;

  final List<Ab<Fragment>> initSomeAfter;

  final Ab<Fragment>? initFragmentAb;

  @override
  Widget build(BuildContext context) {
    return AbBuilder<FragmentGizmoEditPageAbController>(
      putController: FragmentGizmoEditPageAbController(
        initFragmentAb: initFragmentAb,
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
        onPressed: () async {
          final result = await c.currentPerformer().isExistModified(fragmentGizmoEditPageAbController: c);
          if (result != null) {
            SmartDialog.showToast(result);
          } else {
            Navigator.pop(c.context);
          }
        },
      ),
      actions: [
        // UnconstrainedBox(
        //   child: TextButton(onPressed: () {}, child: const Text('存草稿')),
        // ),
        // const SizedBox(width: 10),
      ],
    );
  }

  Widget _body() {
    return AbBuilder<FragmentGizmoEditPageAbController>(
      builder: (c, cAbw) {
        return Column(
          children: [
            Expanded(
              child: AbwBuilder(
                builder: (abw) {
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: q.QuillEditor.basic(
                      controller: c.quillController,
                      readOnly: !c.isEditable(abw), // true for view only mode
                    ),
                  );
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                    child: IntrinsicHeight(
                      child: Row(
                        children: [
                          const SizedBox(width: 10),
                          // 存放位置
                          AbwBuilder(
                            builder: (abwSingle) {
                              return IconButton(
                                style: c.currentPerformer(abwSingle).fragmentGroupChains.isEmpty
                                    ? const ButtonStyle(
                                        backgroundColor: MaterialStatePropertyAll(Color.fromARGB(50, 255, 69, 0)),
                                      )
                                    : null,
                                icon: const FaIcon(FontAwesomeIcons.folder, color: Colors.blue),
                                onPressed: () {
                                  c.showSaveGroup();
                                },
                              );
                            },
                          ),
                          const Padding(padding: EdgeInsets.symmetric(vertical: 15), child: VerticalDivider()),
                          // 使用模板
                          IconButton(
                            icon: const FaIcon(FontAwesomeIcons.codepen, color: Colors.blue),
                            onPressed: () {},
                          ),
                          const Padding(padding: EdgeInsets.symmetric(vertical: 15), child: VerticalDivider()),
                          // 公开/私密/发布
                          IconButton(
                            icon: AbwBuilder(
                              builder: (abw) {
                                final bePrivate = c.currentPerformer(abw).bePrivate;
                                final bePublish = c.currentPerformer(abw).bePublish;
                                final privateColor = bePrivate ? Colors.amber : Colors.green;
                                final publishColor = bePublish ? Colors.green : Colors.amber;
                                return Row(
                                  children: [
                                    Text(bePrivate ? "已私密 " : "已公开 ", style: TextStyle(color: privateColor)),
                                    Icon(Icons.circle, size: 8, color: (!bePrivate && bePublish) ? Colors.green : Colors.grey),
                                    Text(bePublish ? " 将发布" : " 不发布", style: TextStyle(color: publishColor)),
                                  ],
                                );
                              },
                            ),
                            onPressed: () {
                              showPrivatePublishDialog();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // 上一个
                AbwBuilder(
                  builder: (abw) {
                    return IconButton(
                      icon: c.isExistLast(abw) ? const FaIcon(FontAwesomeIcons.chevronLeft, color: Colors.blue) : const FaIcon(FontAwesomeIcons.chevronLeft, color: Colors.grey),
                      onPressed: () {
                        c.goTo(lastOrNext: 0);
                      },
                    );
                  },
                ),
                // 下一个
                AbwBuilder(
                  builder: (abw) {
                    return IconButton(
                      icon: c.isExistNext(abw) ? const FaIcon(FontAwesomeIcons.chevronRight, color: Colors.blue) : const FaIcon(FontAwesomeIcons.chevronRight, color: Colors.grey),
                      onPressed: () {
                        c.goTo(lastOrNext: 1);
                      },
                    );
                  },
                ),
                const SizedBox(width: 5),
                AbwBuilder(
                  builder: (abw) {
                    if (c.isEditable(abw)) {
                      return TextButton(
                        style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(Colors.amber),
                        ),
                        child: const Text('保存', style: TextStyle(color: Colors.white)),
                        onPressed: () {
                          c.saveOrNext();
                        },
                      );
                    }
                    return TextButton(
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Colors.tealAccent),
                      ),
                      child: const Text('修改'),
                      onPressed: () {
                        c.isEditable.refreshEasy((oldValue) => true);
                      },
                    );
                  },
                ),
                const SizedBox(width: 10),
              ],
            ),
            AbwBuilder(
              builder: (abw) {
                return c.isEditable(abw)
                    ? q.QuillToolbar.basic(
                        multiRowsDisplay: false,
                        controller: c.quillController,
                      )
                    : Container();
              },
            ),
          ],
        );
      },
    );
  }
}
