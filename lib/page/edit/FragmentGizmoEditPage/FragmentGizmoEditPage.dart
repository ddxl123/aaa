import 'package:aaa/page/edit/FragmentGroupGizmoEditPage.dart';
import 'package:drift_main/drift/DriftDb.dart';
import 'package:flutter_quill/flutter_quill.dart' as q;
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';
import 'package:tools/tools.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import 'FragmentGizmoEditPageAbController.dart';
import 'custom_embeds/DemoEmbed.dart';

/// 创建或编辑。
class FragmentGizmoEditPage extends StatelessWidget {
  const FragmentGizmoEditPage({
    Key? key,
    required this.initSomeBefore,
    required this.initSomeAfter,
    required this.initFragment,
    required this.initFragmentGroupChain,
    required this.fragmentPerformerTypeAb,
    required this.isTailNew,
  }) : super(key: key);

  final List<Fragment> initSomeBefore;

  final List<Fragment> initSomeAfter;

  final Fragment? initFragment;

  final List<FragmentGroup>? initFragmentGroupChain;

  final Ab<FragmentPerformerType> fragmentPerformerTypeAb;

  final bool isTailNew;

  @override
  Widget build(BuildContext context) {
    return AbBuilder<FragmentGizmoEditPageAbController>(
      putController: FragmentGizmoEditPageAbController(
        initFragment: initFragment,
        initSomeBefore: initSomeBefore,
        initSomeAfter: initSomeAfter,
        initFragmentGroupChain: initFragmentGroupChain,
        fragmentPerformerTypeAb: fragmentPerformerTypeAb,
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
          final result = await c.currentPerformerAb().equalAll(fragmentGizmoEditPageAbController: c);
          if (result.isExistModified) {
            SmartDialog.showToast("存在修改未保存！");
          } else {
            Navigator.pop(c.context);
          }
        },
      ),
      actions: [
        TextButton(onPressed: () {}, child: const Icon(Icons.remove_red_eye_outlined)),
        TextButton(onPressed: () {}, child: const Text('存草稿')),
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
                  return q.QuillEditor(
                    scrollController: c.contentScrollController,
                    scrollPhysics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                    controller: c.quillController,
                    readOnly: c.fragmentPerformerTypeAb(abw) == FragmentPerformerType.readonly || c.fragmentPerformerTypeAb(abw) == FragmentPerformerType.perform,
                    showCursor: c.fragmentPerformerTypeAb(abw) == FragmentPerformerType.editable,
                    autoFocus: true,
                    expands: true,
                    focusNode: FocusNode(),
                    padding: const EdgeInsets.all(10),
                    scrollable: true,
                    embedBuilders: [
                      ...FlutterQuillEmbeds.builders(),
                      DemoEmbedBuilder(),
                    ],
                  );
                },
              ),
            ),
            AbwBuilder(
              builder: (abw) {
                return c.fragmentPerformerTypeAb(abw) == FragmentPerformerType.editable
                    ? q.QuillToolbar.basic(
                        multiRowsDisplay: false,
                        controller: c.quillController,
                        embedButtons: [
                          ...FlutterQuillEmbeds.buttons(),
                          (controller, toolbarIconSize, iconTheme, dialogTheme) => DemoToolBar(controller),
                        ],
                      )
                    : Container();
              },
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
                                style: c.currentPerformerAb(abwSingle).fragmentGroupChains.isEmpty
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
                        if (c.isExistLast()) {
                          c.goTo(lastOrNext: LastOrNext.last, isTailNew: isTailNew);
                        }
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
                        if (c.isExistNext()) {
                          c.goTo(lastOrNext: LastOrNext.next, isTailNew: isTailNew);
                        }
                      },
                    );
                  },
                ),
                const SizedBox(width: 5),
                AbwBuilder(
                  builder: (abw) {
                    if (c.fragmentPerformerTypeAb(abw) == FragmentPerformerType.editable) {
                      return TextButton(
                        style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(Colors.amber),
                        ),
                        child: const Text('保存', style: TextStyle(color: Colors.white)),
                        onPressed: () {
                          c.save(true);
                        },
                      );
                    }
                    return TextButton(
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Colors.tealAccent),
                      ),
                      child: const Text('修改'),
                      onPressed: () {
                        c.fragmentPerformerTypeAb.refreshEasy((oldValue) => FragmentPerformerType.editable);
                      },
                    );
                  },
                ),
                const SizedBox(width: 10),
              ],
            ),
          ],
        );
      },
    );
  }
}
