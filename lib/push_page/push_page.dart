import 'package:aaa/page/edit/FragmentGizmoEditPage/FragmentTemplate/FragmentTemplate.dart';
import 'package:aaa/page/edit/ShorthandGizmoEditPage.dart';
import 'package:aaa/page/login_register/LoginPage.dart';
import 'package:aaa/page/other/TemplateChoice.dart';
import 'package:aaa/page/stage/InAppStage.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:drift_main/drift/DriftDb.dart';
import 'package:flutter/material.dart';
import 'package:tools/tools.dart';

import '../page/edit/FragmentGizmoEditPage/FragmentGizmoEditPage.dart';
import '../page/edit/FragmentGizmoEditPage/FragmentTemplate/QAFragmentTemplate.dart';
import '../page/edit/MemoryGroupGizmoEditPage/MemoryGroupGizmoEditPage.dart';
import '../page/edit/MemoryModelGizomoEditPage/MemoryModelGizmoEditPage.dart';
import '../page/edit/edit_page_type.dart';

Future<void> pushToMemoryModelGizmoEditPage({
  required BuildContext context,
  required Ab<MemoryModel> memoryModelAb,
}) async {
  await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (ctx) => MemoryModelGizmoEditPage(
        memoryModelAb: memoryModelAb,
      ),
    ),
  );
}

Future<void> pushToMemoryGroupGizmoEditPageOfModify({
  required BuildContext context,
  required String memoryGroupId,
}) async {
  await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => MemoryGroupGizmoEditPage(
        editPageType: MemoryGroupGizmoEditPageType.modify,
        memoryGroupId: memoryGroupId,
      ),
    ),
  );
}

/// 返回选择的模板类型。
///
/// 返回 null 表示取消选择。
Future<FragmentTemplate?> pushToTemplateChoice({required BuildContext context}) async {
  return await Navigator.push<FragmentTemplate>(
    context,
    MaterialPageRoute(builder: (ctx) => const TemplateChoice()),
  );
}

Future<void> pushToFragmentPerformerPage({
  required BuildContext context,
  required Fragment? initFragmentAb,
  required FragmentTemplate initFragmentTemplate,
  required List<Fragment> initSomeBefore,
  required List<Fragment> initSomeAfter,
  required List<FragmentGroup>? initFragmentGroupChain,
  required Ab<bool> isEditableAb,
  required bool isTailNew,
}) async {
  await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (ctx) => FragmentGizmoEditPage(
        initSomeBefore: initSomeBefore,
        initSomeAfter: initSomeAfter,
        initFragment: initFragmentAb,
        initFragmentGroupChain: initFragmentGroupChain,
        isEditableAb: isEditableAb,
        isTailNew: isTailNew,
        initFragmentTemplate: initFragmentTemplate,
      ),
    ),
  );
}

Future<void> pushToLoginPage({required BuildContext context}) async {
  await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => const LoginPage(),
    ),
  );
}

Future<void> pushToShorthandGizmoEditPage({
  required BuildContext context,
  required Shorthand? initShorthand,
}) async {
  await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => ShorthandGizmoEditPage(initShorthand: initShorthand),
    ),
  );
}

Future<void> pushToInAppStage({
  required BuildContext context,
  required String memoryGroupId,
}) async {
  await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => InAppStage(memoryGroupId: memoryGroupId),
    ),
  );
}

Future<void> pushToSingleFragmentTemplateView({
  required BuildContext context,
  required FragmentTemplate fragmentTemplate,
}) async {
  await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (ctx) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("预览"),
          ),
          body: FragmentTemplate.templateSwitch(
            fragmentTemplate.fragmentTemplateType,
            qa: () {
              return QAFragmentTemplateViewWidget(
                qaFragmentTemplate: fragmentTemplate as QAFragmentTemplate,
              );
            },
          ),
        );
      },
    ),
  );
}

Future<void> pushToMultiFragmentTemplateView({
  required BuildContext context,
  required FragmentTemplate fragmentTemplate,
}) async {
  await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (ctx) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("预览"),
            actions: [
              IconButton(
                icon: const Icon(Icons.edit_outlined),
                onPressed: () {},
              ),
            ],
          ),
          body: CarouselSlider.builder(
            itemCount: 3,
            itemBuilder: (BuildContext context, int index, int realIndex) {
              return FragmentTemplate.templateSwitch(
                fragmentTemplate.fragmentTemplateType,
                qa: () {
                  return QAFragmentTemplateViewWidget(
                    qaFragmentTemplate: fragmentTemplate as QAFragmentTemplate,
                  );
                },
              );
            },
            options: CarouselOptions(
              viewportFraction: 1,
              enlargeCenterPage: true,
              height: MediaQuery.of(context).size.height,
            ),
          ),
        );
      },
    ),
  );
}
