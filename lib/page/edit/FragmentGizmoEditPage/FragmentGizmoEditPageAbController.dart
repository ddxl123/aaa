import 'dart:convert';

import 'package:aaa/global/GlobalAbController.dart';
import 'package:aaa/single_dialog/showSelectFragmentGroupsDialog.dart';
import 'package:drift_main/drift/DriftDb.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as q;
import 'package:tools/tools.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class FragmentPerformer {
  FragmentPerformer({required this.fragmentAb});

  /// 为 null 表示创建模式，否则为阅读或修改模式。
  Ab<Fragment>? fragmentAb;

  static const String richContent = '[{"insert":"\\n"}]';

  /// 当前操作碎片的内容，只是用来存储创建模式时的内容，其他模式都是用 document 中提取。
  String content = richContent;

  /// 当前操作碎片所存放的碎片组位置，root 组无需存放。
  ///
  /// 使用嵌套数组的原因：一个碎片可能被存放、拷贝到多个碎片组内。
  List<List<FragmentGroup>> fragmentGroupChains = [];

  /// 当前操作碎片所使用的模板。
  FragmentTemplate? fragmentTemplate;

  final fragmentTag = <String>[];

  Future<String?> isExistModified({required FragmentGizmoEditPageAbController fragmentGizmoEditPageAbController}) async {
    final isEqualContentOk = isEqualContent(fragmentGizmoEditPageAbController: fragmentGizmoEditPageAbController);
    final isEqualFragmentGroupChainsOk = await isEqualFragmentGroupChains(fragmentGizmoEditPageAbController: fragmentGizmoEditPageAbController);
    final isEqualFragmentTemplateOk = await isEqualFragmentTemplate();
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

  Future<void> reload({required FragmentGizmoEditPageAbController fragmentGizmoEditPageAbController, required FragmentPerformer? recent}) async {
    if (fragmentAb == null) {
      // 保留上一次设置(当全为空时才会保留)
      if (fragmentGroupChains.isEmpty && fragmentTemplate == null) {
        if (recent != null) {
          fragmentGroupChains.addAll(recent.fragmentGroupChains);
          fragmentTemplate = recent.fragmentTemplate;
        }
      }
    } else {
      content = fragmentAb!().content;
      fragmentGizmoEditPageAbController.quillController.document = q.Document.fromJson(jsonDecode(content));

      final chains = await db.generalQueryDAO.queryFragmentInWhichFragmentGroupChain(fragment: fragmentAb!());
      fragmentGroupChains.clear();
      fragmentGroupChains.addAll(chains);

      fragmentTemplate = fragmentAb!().fragment_template_id == null
          ? null
          : await db.generalQueryDAO.queryFragmentTemplateById(
              fragmentTemplateId: fragmentAb!().fragment_template_id!,
            );
    }
  }

  /// 若返回空表示数据没有变化。
  Future<Fragment?> save({required FragmentGizmoEditPageAbController fragmentGizmoEditPageAbController}) async {
    final modifyMessage = await isExistModified(fragmentGizmoEditPageAbController: fragmentGizmoEditPageAbController);
    if (modifyMessage == null) {
      return null;
    }
    final st = await SyncTag.create();
    if (fragmentAb == null) {
      final newFragment = await db.insertDAO.insertFragment(
        willFragmentsCompanion: Crt.fragmentsCompanion(
          content: fragmentGizmoEditPageAbController.richToJson(),
          creator_user_id: Aber.find<GlobalAbController>().loggedInUser()!.id,
          father_fragment_id: null.toValue(),
          fragment_template_id: (fragmentTemplate?.id).toValue(),
          client_be_selected: false,
          title: fragmentGizmoEditPageAbController.parseTitle(),
          tags: fragmentTag.join(","),
          be_sep_publish: false,
        ),
        whichFragmentGroups: fragmentGroupChains.map((e) => e.isEmpty ? null : e.last).toList(),
        syncTag: st,
      );
      return newFragment;
    } else {
      await db.updateDAO.resetFragment(
        originalFragmentReset: () async {
          await fragmentAb!().reset(
            content: fragmentGizmoEditPageAbController.richToJson().toValue(),
            creator_user_id: toAbsent(),
            father_fragment_id: toAbsent(),
            fragment_template_id: (fragmentTemplate?.id).toValue(),
            client_be_selected: toAbsent(),
            title: fragmentGizmoEditPageAbController.parseTitle().toValue(),
            tags: "".toValue(),
            syncTag: st,
            be_sep_publish: false.toValue(),
          );
        },
        syncTag: st,
      );
      fragmentAb!.refreshForce();
      return fragmentAb!();
    }
  }

  bool isEqualContent({required FragmentGizmoEditPageAbController fragmentGizmoEditPageAbController}) {
    final String now;
    final String saved;
    if (fragmentAb != null) {
      now = fragmentGizmoEditPageAbController.richToJson();
      saved = fragmentAb!().content;
    } else {
      now = fragmentGizmoEditPageAbController.richToJson();
      saved = '';
    }

    final nowT = now == '' ? richContent : now;
    final savedT = saved == '' ? richContent : saved;
    return nowT == savedT;
  }

  Future<bool> isEqualFragmentTemplate() async {
    final FragmentTemplate? now;
    final FragmentTemplate? saved;
    if (fragmentAb != null) {
      now = fragmentTemplate;
      saved = fragmentAb!().fragment_template_id == null
          ? null
          : await db.generalQueryDAO.queryFragmentTemplateById(
              fragmentTemplateId: fragmentAb!().fragment_template_id!,
            );
    } else {
      now = fragmentTemplate;
      saved = null;
    }
    return now?.id == saved?.id;
  }

  Future<bool> isEqualFragmentGroupChains({required FragmentGizmoEditPageAbController fragmentGizmoEditPageAbController}) async {
    final List<List<FragmentGroup?>> now;
    final List<List<FragmentGroup?>> saved;
    if (fragmentAb != null) {
      now = fragmentGroupChains;
      saved = await db.generalQueryDAO.queryFragmentInWhichFragmentGroupChain(fragment: fragmentAb!());
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
    required this.initFragmentAb,
    required this.initSomeBefore,
    required this.initSomeAfter,
    required this.initFragmentGroupChain,
  });

  /// 仅用来初始化赋值，若没有的话为 []。
  final List<Ab<Fragment>> initSomeBefore;

  /// 仅用来初始化赋值，若没有的话为 []。
  final List<Ab<Fragment>> initSomeAfter;

  /// 仅用来初始化赋值，若为 null，则初始化时为创建。
  final Ab<Fragment>? initFragmentAb;

  /// 为 null 表示没有选择组。
  final List<FragmentGroup>? initFragmentGroupChain;

  /// 用来记录操作的碎片，存放 [initSomeBefore]、[initFragmentAb]、[initSomeAfter] 的对象。
  ///
  /// 只允许存在一个元素为 null，否则检索 index 时只会检索到第一个 null。
  /// 而相同的 [Fragment] 并不是同一个 [FragmentAbAndFragmentGroupAb] 对象，所有不需要关心对象是否相同。
  final records = <FragmentPerformer>[].ab;

  /// 当前碎片的数据仓库。
  ///
  /// 根据 [records] 跳动。
  final currentPerformer = Ab<FragmentPerformer>.late();
  final q.QuillController quillController = q.QuillController.basic();

  final contentScrollController = ScrollController();

  final isEditable = false.ab;

  @override
  bool get isEnableLoading => true;

  @override
  Future<void> loadingFuture() async {
    final current = FragmentPerformer(fragmentAb: initFragmentAb);
    if (initFragmentGroupChain != null) {
      current.fragmentGroupChains.add(initFragmentGroupChain!);
    }
    await current.reload(fragmentGizmoEditPageAbController: this, recent: null);

    records().addAll(initSomeBefore.map((e) => FragmentPerformer(fragmentAb: e)));
    records().add(current);
    records().addAll(initSomeAfter.map((e) => FragmentPerformer(fragmentAb: e)));

    currentPerformer.lateAssign(current);
    records.refreshForce();
    if (initFragmentAb == null) {
      isEditable.refreshEasy((oldValue) => true);
    } else {
      isEditable.refreshEasy((oldValue) => false);
    }
  }

  String richToJson() => jsonEncode(quillController.document.toDelta().toJson());

  String parseTitle() {
    final text = quillController.document.toPlainText().trim();
    return text.substring(0, text.length > 20 ? 21 : text.length);
  }

  bool isExistLast([Abw? abw]) {
    final currentIndex = records(abw).indexOf(currentPerformer(abw));
    if (currentIndex == 0) {
      return false;
    }
    return true;
  }

  bool isExistNext([Abw? abw]) {
    final currentIndex = records(abw).indexOf(currentPerformer(abw));
    if (currentIndex == records().length - 1) {
      return false;
    }
    return true;
  }

  /// 当 [lastOrNext] 为 0 时，进入到上一个，否则进入到下一个。
  Future<void> goTo({required int lastOrNext}) async {
    if (!records().contains(currentPerformer())) {
      throw '记录不包含当前碎片，无法获取 index！';
    }
    final currentIndex = records().indexOf(currentPerformer());
    if (lastOrNext == 0) {
      if (currentIndex == 0) return;
      // 先检查当前
      final modifyMessage = await currentPerformer().isExistModified(fragmentGizmoEditPageAbController: this);
      if (modifyMessage != null) {
        if (currentPerformer().fragmentAb != null) {
          SmartDialog.showToast(modifyMessage);
          return;
        } else {
          currentPerformer().content = richToJson();
        }
      }
      // 再加载下一个
      final last = records()[currentIndex - 1];
      await last.reload(fragmentGizmoEditPageAbController: this, recent: currentPerformer());
      // 后构建下一个
      if (last.fragmentAb == null) {
        quillController.document = q.Document.fromJson(jsonDecode(last.content));
        isEditable.refreshEasy((oldValue) => true);
      } else {
        isEditable.refreshEasy((oldValue) => false);
      }
      currentPerformer.refreshEasy((oldValue) => last);
    } else {
      if (currentIndex == records().length - 1) return;
      // 先检查当前
      final modifyMessage = await currentPerformer().isExistModified(fragmentGizmoEditPageAbController: this);
      if (modifyMessage != null) {
        if (currentPerformer().fragmentAb != null) {
          SmartDialog.showToast(modifyMessage);
          return;
        } else {
          currentPerformer().content = richToJson();
        }
      }
      // 再加载下一个
      final next = records()[currentIndex + 1];
      await next.reload(fragmentGizmoEditPageAbController: this, recent: currentPerformer());
      // 后构建下一个
      if (next.fragmentAb == null) {
        quillController.document = q.Document.fromJson(jsonDecode(next.content));
        isEditable.refreshEasy((oldValue) => true);
      } else {
        isEditable.refreshEasy((oldValue) => false);
      }
      currentPerformer.refreshEasy((oldValue) => next);
    }
  }

  Future<void> saveOrNext() async {
    if (currentPerformer().fragmentGroupChains.isEmpty) {
      SmartDialog.showToast('未选择存放位置！');
      return;
    }
    final result = await currentPerformer().save(fragmentGizmoEditPageAbController: this);
    if (result == null) {
      SmartDialog.showToast('没有修改内容！');
      isEditable.refreshEasy((oldValue) => false);
      return;
    }
    if (currentPerformer().fragmentAb == null) {
      final resultAb = result.ab;
      currentPerformer().fragmentAb = resultAb;
      records.refreshEasy((oldValue) => oldValue..add(FragmentPerformer(fragmentAb: null)));
      await goTo(lastOrNext: 1);
      SmartDialog.showToast('保存成功！');
    } else {
      SmartDialog.showToast('修改成功！');
      isEditable.refreshEasy((oldValue) => false);
    }
  }

  Future<void> showSaveGroup() async {
    await showSelectFragmentGroupsDialog(selectedFragmentGroupChainsAb: currentPerformer().fragmentGroupChains.ab);
    currentPerformer.refreshForce();
  }
}
