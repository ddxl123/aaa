import 'package:aaa/page/edit/FragmentGizmoEditPage/FragmentTemplate/base/FragmentTemplate.dart';
import 'package:aaa/page/edit/FragmentGizmoEditPage/FragmentTemplate/template/choice/ChoiceFragmentTemplate.dart';
import 'package:aaa/push_page/push_page.dart';
import 'package:drift_main/drift/DriftDb.dart';
import 'package:tools/tools.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import 'FragmentGizmoEditPageAbController.dart';
import 'FragmentTemplate/template/choice/ChoiceFragmentTemplateEditWidget.dart';
import 'FragmentTemplate/template/question_answer/QAFragmentTemplate.dart';
import 'FragmentTemplate/template/question_answer/QAFragmentTemplateEditWidget.dart';

/// 创建或编辑。
class FragmentGizmoEditPage extends StatelessWidget {
  const FragmentGizmoEditPage({
    Key? key,
    required this.initFragment,
    required this.initFragmentTemplate,
    required this.initSomeBefore,
    required this.initSomeAfter,
    required this.initFragmentGroupChain,
    required this.isEditableAb,
    required this.isTailNew,
  }) : super(key: key);

  final Fragment? initFragment;

  final FragmentTemplate initFragmentTemplate;

  final List<Fragment> initSomeBefore;

  final List<Fragment> initSomeAfter;

  final List<FragmentGroup>? initFragmentGroupChain;

  final Ab<bool> isEditableAb;

  final bool isTailNew;

  @override
  Widget build(BuildContext context) {
    return AbBuilder<FragmentGizmoEditPageAbController>(
      putController: FragmentGizmoEditPageAbController(
        initFragment: initFragment,
        initFragmentTemplate: initFragmentTemplate,
        initSomeBefore: initSomeBefore,
        initSomeAfter: initSomeAfter,
        initFragmentGroupChain: initFragmentGroupChain,
        isEditable: isEditableAb,
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
        TextButton(
          child: const Icon(Icons.remove_red_eye_outlined),
          onPressed: () {
            pushToSingleFragmentTemplateView(context: c.context, fragmentTemplate: c.currentPerformerAb().fragmentTemplate);
          },
        ),
        CustomDropdownBodyButton(
          initValue: 0,
          primaryButton: const IconButton(
            onPressed: null,
            icon: Icon(Icons.more_horiz, color: Colors.blue),
          ),
          itemAlignment: Alignment.centerLeft,
          items: [
            Item(value: 0, text: "存草稿"),
          ],
          onChanged: (v) {},
        ),
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
                  return FragmentTemplate.templateSwitch(
                    c.currentPerformerAb(abw).fragmentTemplate.fragmentTemplateType,
                    questionAnswer: () {
                      return QAFragmentTemplateEditWidget(
                        qaFragmentTemplate: c.currentPerformerAb(abw).fragmentTemplate as QAFragmentTemplate,
                        isEditable: c.isEditable(abw),
                      );
                    },
                    choice: () {
                      return ChoiceFragmentTemplateEditWidget(
                        choiceFragmentTemplate: c.currentPerformerAb(abw).fragmentTemplate as ChoiceFragmentTemplate,
                        isEditable: c.isEditable(abw),
                      );
                    },
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
                      icon: Icon(Icons.u_turn_left),
                      onPressed: () async {
                        final result = await c.currentPerformerAb().reload(fragmentGizmoEditPageAbController: c, recent: null);
                        c.currentPerformerAb.refreshForce();
                        if (result) {
                          logger.outNormal(show: "已恢复至修改前");
                        } else {
                          logger.outNormal(show: "无修改，无需恢复");
                        }
                      },
                    );
                  },
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
                    if (c.isEditable(abw)) {
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
                        c.isEditable.refreshEasy((oldValue) => true);
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
