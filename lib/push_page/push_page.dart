import 'package:aaa/home/personal_home_page/PersonalHomePage.dart';
import 'package:aaa/page/edit/FragmentGizmoEditPage/FragmentTemplate/base/FragmentTemplate.dart';
import 'package:aaa/page/edit/ShorthandGizmoEditPage.dart';
import 'package:aaa/page/fragment_group_view/FragmentGroupListView.dart';
import 'package:aaa/page/fragment_group_view/FragmentGroupSelectView.dart';
import 'package:aaa/page/login_register/LoginPage.dart';
import 'package:aaa/page/other/TemplateChoicePage.dart';
import 'package:aaa/page/stage/InAppStage.dart';
import 'package:aaa/page/stage/fragment_template_pages/MultiFragmentTemplatePage.dart';
import 'package:aaa/page/stage/fragment_template_pages/SingleFragmentTemplatePage.dart';
import 'package:drift_main/drift/DriftDb.dart';
import 'package:flutter/material.dart';
import 'package:tools/tools.dart';

import '../page/edit/FragmentGizmoEditPage/FragmentGizmoEditPage.dart';
import '../page/edit/FragmentGroupGizmoEditPage.dart';
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
  required int memoryGroupId,
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

Future<void> pushToFragmentEditView({
  required BuildContext context,
  required Fragment? initFragmentAb,
  required FragmentTemplate initFragmentTemplate,
  required List<Fragment> initSomeBefore,
  required List<Fragment> initSomeAfter,
  required (FragmentGroup?, RFragment2FragmentGroup?)? enterDynamicFragmentGroups,
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
        enterDynamicFragmentGroups: enterDynamicFragmentGroups,
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
  required int memoryGroupId,
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
      builder: (ctx) => SingleFragmentTemplatePage(fragmentTemplate: fragmentTemplate),
    ),
  );
}

Future<void> pushToMultiFragmentTemplateView({
  required BuildContext context,
  required List<Fragment> allFragments,
  required Fragment fragment,
}) async {
  await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (ctx) => MultiFragmentTemplatePage(
        allFragments: allFragments,
        fragment: fragment,
      ),
    ),
  );
}

Future<void> pushToFragmentGroupListView({
  required BuildContext context,
  required int userId,
  required FragmentGroup? enterFragmentGroup,
}) async {
  await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (ctx) => FragmentGroupListView(
        enterFragmentGroup: enterFragmentGroup,
        userId: userId,
      ),
    ),
  );
}

Future<void> pushToFragmentGroupGizmoEditPage({
  required BuildContext context,
  required Ab<FragmentGroup?> fragmentGroupAb,
}) async {
  await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (ctx) => FragmentGroupGizmoEditPage(currentDynamicFragmentGroupAb: fragmentGroupAb),
    ),
  );
}

Future<void> pushToPersonalHomePage({
  required BuildContext context,
  required int userId,
}) async {
  await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (ctx) => PersonalHomePage(userId: userId),
    ),
  );
}

/// 返回空 - 取消选择
///
/// FragmentGroup? - dynamicFragmentGroup?
Future<(FragmentGroup?, void)?> pushToFragmentGroupSelectView({
  required BuildContext context,
}) async {
  return await Navigator.push<(FragmentGroup?, void)>(
    context,
    MaterialPageRoute(
      builder: (ctx) => FragmentGroupSelectView(),
    ),
  );
}
