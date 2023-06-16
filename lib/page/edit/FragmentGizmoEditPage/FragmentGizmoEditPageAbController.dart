import 'dart:convert';

import 'package:aaa/global/GlobalAbController.dart';
import 'package:aaa/single_dialog/showSelectFragmentGroupsDialog.dart';
import 'package:drift_main/drift/DriftDb.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as q;
import 'package:tools/tools.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

enum FragmentPerformerType {
  editable,
  readonly,
  perform,
}

enum LastOrNext {
  last,
  next,
}

class FragmentPerformer {
  FragmentPerformer({required this.fragment});

  /// 为 null 表示为创建碎片。
  Fragment? fragment;

  /// 当前操作碎片所存放的碎片组位置，root 组无需存放。
  ///
  /// 使用嵌套数组的原因：一个碎片可能被存放、拷贝到多个碎片组内。
  final List<List<FragmentGroup>> fragmentGroupChains = [];

  /// 当前操作碎片所使用的模板。
  FragmentTemplate? fragmentTemplate;

  // static const String richContent = '[{"insert":"\\n"}]';
  //
  // /// 当前操作碎片的内容，只是用来存储创建模式时的内容，其他模式都是用 document 中提取。
  // String content = richContent;

  // final fragmentTag = <String>[];

  /// 从本地数据库中重新加载当前 [fragment]。
  ///
  /// [recent] 表示最近一个操作的 [FragmentPerformer]，若为 null，则表示没有最近的。
  ///
  /// 返回是否存在变动。
  Future<bool> reload({required FragmentGizmoEditPageAbController fragmentGizmoEditPageAbController, required FragmentPerformer? recent}) async {
    if (fragment == null) {
      // 保留上一次设置。
      if (recent != null) {
        fragmentGroupChains.addAll(recent.fragmentGroupChains);
        fragmentTemplate = recent.fragmentTemplate;
        return true;
      }
      return false;
    } else {
      final newFragment = await db.generalQueryDAO.queryFragmentById(id: fragment!.id);
      if (fragment == newFragment) {
        return false;
      }

      fragment = newFragment;
      fragmentGizmoEditPageAbController.quillController.clear();
      fragmentGizmoEditPageAbController.quillController.document = q.Document.fromJson(jsonDecode(fragment!.content));

      final chains = await db.generalQueryDAO.queryFragmentInWhichFragmentGroupChain(fragment: fragment!);
      fragmentGroupChains.clear();
      fragmentGroupChains.addAll(chains);

      if (fragment!.fragment_template_id == null) {
        fragmentTemplate = null;
      } else {
        fragmentTemplate = await db.generalQueryDAO.queryFragmentTemplateById(fragmentTemplateId: fragment!.fragment_template_id!);
      }
      return true;
    }
  }

  /// 将当前 [fragment]、[fragmentTemplate] 等进行插入、更新。
  ///
  /// 如果 [fragment] 为 null，则插入。
  ///
  /// 如果存在修改，则更新。
  ///
  /// 如果不存在修改，则不修改。
  ///
  /// 返回是否存在修改。
  Future<bool> save({required FragmentGizmoEditPageAbController fragmentGizmoEditPageAbController}) async {
    final modifyMessage = await isExistModified(fragmentGizmoEditPageAbController: fragmentGizmoEditPageAbController);
    if (modifyMessage == null) {
      return false;
    }
    final st = await SyncTag.create();
    if (fragment == null) {
      final newFragment = await db.insertDAO.insertFragment(
        willFragmentsCompanion: Crt.fragmentsCompanion(
          content: jsonEncode(fragmentGizmoEditPageAbController.quillController.document.toDelta().toJson()),
          creator_user_id: Aber.find<GlobalAbController>().loggedInUser()!.id,
          father_fragment_id: null.toValue(),
          fragment_template_id: (fragmentTemplate?.id).toValue(),
          client_be_selected: false,
          title: fragmentGizmoEditPageAbController.parseTitle(),
          tags: jsonEncode([]),
          be_sep_publish: false,
        ),
        whichFragmentGroups: fragmentGroupChains.map((e) => e.isEmpty ? null : e.last).toList(),
        syncTag: st,
      );
      fragment = newFragment;
      return true;
    } else {
      await db.updateDAO.resetFragment(
        originalFragmentReset: () async {
          await fragment!.reset(
            content: jsonEncode(fragmentGizmoEditPageAbController.quillController.document.toDelta().toJson()).toValue(),
            creator_user_id: toAbsent(),
            father_fragment_id: toAbsent(),
            fragment_template_id: (fragmentTemplate?.id).toValue(),
            client_be_selected: toAbsent(),
            title: fragmentGizmoEditPageAbController.parseTitle().toValue(),
            tags: jsonEncode([]).toValue(),
            syncTag: st,
            be_sep_publish: false.toValue(),
          );
        },
        syncTag: st,
      );
      fragment!.refreshForce();
      return fragment!();
    }
  }

  /// 如果存在修改，则返回"xxx存在修改"。
  ///
  /// 如果不存在修改，则返回 null。
  Future<String?> isExistModified({required FragmentGizmoEditPageAbController fragmentGizmoEditPageAbController}) async {
    final isEqualContentOk = equalContent(fragmentGizmoEditPageAbController: fragmentGizmoEditPageAbController);
    final isEqualFragmentGroupChainsOk = await equalFragmentGroupChains(fragmentGizmoEditPageAbController: fragmentGizmoEditPageAbController);
    final isEqualFragmentTemplateOk = await equalFragmentTemplate();
    if (!isEqualContentOk) {
      return "内容存在修改！";
    }
    if (!isEqualFragmentGroupChainsOk) {
      return "碎片组存在修改！";
    }
    if (!isEqualFragmentTemplateOk) {
      return "碎片模型存在修改！";
    }
    return null;
  }

  bool equalContent({required FragmentGizmoEditPageAbController fragmentGizmoEditPageAbController}) {
    final String now = jsonEncode(fragmentGizmoEditPageAbController.quillController.document.toDelta().toJson());
    late final String saved;
    if (fragment != null) {
      saved = fragment!.content;
    } else {
      saved = jsonEncode(q.Delta().toJson());
    }
    return now == saved;
  }

  Future<bool> equalFragmentTemplate() async {
    final FragmentTemplate? now;
    final FragmentTemplate? saved;
    if (fragment != null) {
      now = fragmentTemplate;
      if (fragment!.fragment_template_id == null) {
        saved = null;
      } else {
        saved = await db.generalQueryDAO.queryFragmentTemplateById(fragmentTemplateId: fragment!.fragment_template_id!);
      }
    } else {
      now = fragmentTemplate;
      saved = null;
    }
    return now?.id == saved?.id;
  }

  Future<bool> equalFragmentGroupChains({required FragmentGizmoEditPageAbController fragmentGizmoEditPageAbController}) async {
    final List<List<FragmentGroup?>> now;
    final List<List<FragmentGroup?>> saved;
    if (fragment != null) {
      now = fragmentGroupChains;
      saved = await db.generalQueryDAO.queryFragmentInWhichFragmentGroupChain(fragment: fragment!);
    } else {
      now = fragmentGroupChains;
      saved = [];
    }

    if (now.isEmpty && saved.isEmpty) {
      return true;
    }
    if (now.length != saved.length) {
      return false;
    }
    for (int i = 0; i < now.length; i++) {
      final nowResult = now[i].map((e) => e?.id).join('');
      final savedResult = saved[i].map((e) => e?.id).join('');
      if (nowResult != savedResult) {
        return false;
      }
    }
    return true;
  }
}

class FragmentGizmoEditPageAbController extends AbController {
  FragmentGizmoEditPageAbController({
    required this.fragmentPerformerTypeAb,
    required this.initFragment,
    required this.initSomeBefore,
    required this.initSomeAfter,
    required this.initFragmentGroupChain,
  });

  final Ab<FragmentPerformerType> fragmentPerformerTypeAb;

  /// 仅用来初始化赋值，若没有的话为 []。
  final List<Fragment> initSomeBefore;

  /// 仅用来初始化赋值，若没有的话为 []。
  final List<Fragment> initSomeAfter;

  /// 仅用来初始化赋值，若为 null，则初始化时为创建。
  final Fragment? initFragment;

  /// 当在碎片组中创建碎片时，会将当前所在碎片组设为初始化碎片组。
  ///
  /// 为 null 表示当 [initFragment] 为 null 时，即没有分配初始化选择组。
  ///
  /// 当 [initFragment] 不为 null 时，这个字段无效。
  final List<FragmentGroup>? initFragmentGroupChain;

  /// 用来记录操作的碎片，存放 [initSomeBefore]、[initFragment]、[initSomeAfter] 的对象。
  ///
  /// 若为新建碎片(即没有如何内容)，则 [FragmentPerformer.fragment] 为 null。
  final records = <FragmentPerformer>[];

  /// 当前碎片表演者。
  ///
  /// 它属于 [records] 中的某个元素，会在 [records] 集合上跳动。
  ///
  /// 必然不为空，因此使用 [Ab.late] 进行初始化。
  final currentPerformerAb = Ab<FragmentPerformer>.late();

  final q.QuillController quillController = q.QuillController.basic();

  final contentScrollController = ScrollController();

  @override
  bool get isEnableLoading => true;

  @override
  Future<void> loadingFuture() async {
    final initPerformer = FragmentPerformer(fragment: initFragment);
    if (initFragment == null && initFragmentGroupChain != null) {
      initPerformer.fragmentGroupChains.add(initFragmentGroupChain!);
    }
    await initPerformer.reload(fragmentGizmoEditPageAbController: this, recent: null);

    records.addAll(initSomeBefore.map((e) => FragmentPerformer(fragment: e)));
    records.add(initPerformer);
    records.addAll(initSomeAfter.map((e) => FragmentPerformer(fragment: e)));

    currentPerformerAb.lateAssign(initPerformer);
  }

  String parseTitle() {
    final text = quillController.document.toPlainText().trim();
    return text.substring(0, text.length > 20 ? 21 : text.length);
  }

  bool isExistLast([Abw? abw]) {
    final currentIndex = records(abw).indexOf(currentPerformerAb(abw));
    if (currentIndex == 0) {
      return false;
    }
    return true;
  }

  bool isExistNext([Abw? abw]) {
    final currentIndex = records(abw).indexOf(currentPerformerAb(abw));
    if (currentIndex == records().length - 1) {
      return false;
    }
    return true;
  }

  Future<void> goTo({required LastOrNext lastOrNext}) async {
    if (!records().contains(currentPerformerAb())) {
      throw '记录不包含当前碎片，无法获取 index！';
    }
    final currentIndex = records().indexOf(currentPerformerAb());
    if (lastOrNext == LastOrNext.last) {
      if (currentIndex == 0) return;
      // 先检查当前
      final modifyMessage = await currentPerformerAb().isExistModified(fragmentGizmoEditPageAbController: this);
      if (modifyMessage != null) {
        if (currentPerformerAb().fragment != null) {
          SmartDialog.showToast(modifyMessage);
          return;
        } else {
          currentPerformerAb().content = richToJson();
        }
      }
      // 再加载下一个
      final last = records()[currentIndex - 1];
      await last.reload(fragmentGizmoEditPageAbController: this, recent: currentPerformerAb());
      // 后构建下一个
      if (last.fragment == null) {
        quillController.document = q.Document.fromJson(jsonDecode(last.content));
        isEditable.refreshEasy((oldValue) => true);
      } else {
        isEditable.refreshEasy((oldValue) => false);
      }
      currentPerformerAb.refreshEasy((oldValue) => last);
    } else {
      if (currentIndex == records().length - 1) return;
      // 先检查当前
      final modifyMessage = await currentPerformerAb().isExistModified(fragmentGizmoEditPageAbController: this);
      if (modifyMessage != null) {
        if (currentPerformerAb().fragment != null) {
          SmartDialog.showToast(modifyMessage);
          return;
        } else {
          currentPerformerAb().content = richToJson();
        }
      }
      // 再加载下一个
      final next = records()[currentIndex + 1];
      await next.reload(fragmentGizmoEditPageAbController: this, recent: currentPerformerAb());
      // 后构建下一个
      if (next.fragment == null) {
        quillController.document = q.Document.fromJson(jsonDecode(next.content));
        isEditable.refreshEasy((oldValue) => true);
      } else {
        isEditable.refreshEasy((oldValue) => false);
      }
      currentPerformerAb.refreshEasy((oldValue) => next);
    }
  }

  Future<void> saveOrNext() async {
    if (currentPerformerAb().fragmentGroupChains.isEmpty) {
      SmartDialog.showToast('未选择存放位置！');
      return;
    }
    final result = await currentPerformerAb().save(fragmentGizmoEditPageAbController: this);
    if (result == null) {
      SmartDialog.showToast('没有修改内容！');
      isEditable.refreshEasy((oldValue) => false);
      return;
    }
    if (currentPerformerAb().fragment == null) {
      final resultAb = result.ab;
      currentPerformerAb().fragment = resultAb;
      records.refreshEasy((oldValue) => oldValue..add(FragmentPerformer(fragment: null)));
      await goTo(lastOrNext: 1);
      SmartDialog.showToast('保存成功！');
    } else {
      SmartDialog.showToast('修改成功！');
      isEditable.refreshEasy((oldValue) => false);
    }
  }

  Future<void> showSaveGroup() async {
    await showSelectFragmentGroupsDialog(selectedFragmentGroupChainsAb: currentPerformerAb().fragmentGroupChains.ab);
    currentPerformerAb.refreshForce();
  }
}
