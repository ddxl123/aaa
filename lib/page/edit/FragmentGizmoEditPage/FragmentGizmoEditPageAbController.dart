import 'dart:convert';
import 'dart:ffi';

import 'package:aaa/global/GlobalAbController.dart';
import 'package:aaa/page/edit/FragmentGizmoEditPage/FragmentTemplate/FragmentTemplater.dart';
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
  FragmentPerformer({required this.fragment, required this.fragmentTemplater});

  static const emptyContent = r'[{"insert":"\n"}]';

  /// 为 null 表示为创建碎片。
  Fragment? fragment;

  /// 当前操作碎片所存放的碎片组位置，root 组无需存放。
  ///
  /// 使用嵌套数组的原因：一个碎片可能被存放、拷贝到多个碎片组内。
  final List<List<FragmentGroup>> fragmentGroupChains = [];

  /// [fragmentTemplater] 是根据 [fragment.content] 解析而来。
  ///
  /// [fragment] 为 null，[fragmentTemplater] 也为 null。
  FragmentTemplater fragmentTemplater;

  // final fragmentTag = <String>[];

  /// 从本地数据库中重新加载当前 [fragment]。
  ///
  /// [recent] 表示最近一个操作的 [FragmentPerformer]，若为 null，则表示没有最近的。
  ///
  /// 返回重新加载前与重新加载后是否存在变动。
  Future<bool> reload({required FragmentGizmoEditPageAbController fragmentGizmoEditPageAbController, required FragmentPerformer? recent}) async {
    if (fragment == null) {
      // 保留上一次设置。
      if (recent != null) {
        fragmentGroupChains.addAll(recent.fragmentGroupChains);
        fragmentTemplater = recent.fragmentTemplater.empty();
      }
      fragmentGizmoEditPageAbController.quillController.clear();
      fragmentGizmoEditPageAbController.quillController.document = q.Document.fromJson(jsonDecode(emptyContent));
      return false;
    } else {
      final resultAll = await equalAll(fragmentGizmoEditPageAbController: fragmentGizmoEditPageAbController);
      if (!resultAll.isExistModified) {
        return false;
      }

      if (resultAll.content.isModified) {
        fragment!.content = resultAll.content.saved;
        fragmentGizmoEditPageAbController.quillController.clear();
        fragmentGizmoEditPageAbController.quillController.document = q.Document.fromJson(jsonDecode(resultAll.content.saved));
      }
      if (resultAll.fragmentGroupChains.isModified) {
        fragmentGroupChains.clear();
        fragmentGroupChains.addAll(resultAll.fragmentGroupChains.saved);
      }
      if (resultAll.fragmentTemplate.isModified) {
        fragmentTemplate = resultAll.fragmentTemplate.saved;
      }
      return true;
    }
  }

  /// 返回是否存在修改。
  Future<bool> saveAll({
    required FragmentGizmoEditPageAbController fragmentGizmoEditPageAbController,
    required SyncTag syncTag,
  }) async {
    final resultFragment = await saveFragment(fragmentGizmoEditPageAbController: fragmentGizmoEditPageAbController, syncTag: syncTag);
    final resultFragmentTemplate = await saveFragmentTemplate(fragmentGizmoEditPageAbController: fragmentGizmoEditPageAbController, syncTag: syncTag);
    return resultFragment || resultFragmentTemplate;
  }

  /// 将当前 [fragment] 进行插入、更新。
  ///
  /// 如果 [fragment] 为 null，则插入，会插入 [Fragment] 和 [FragmentGroups]。
  ///
  /// 如果存在修改，则更新。
  ///
  /// 如果不存在修改，则不修改。
  ///
  /// 返回是否存在修改。
  Future<bool> saveFragment({
    required FragmentGizmoEditPageAbController fragmentGizmoEditPageAbController,
    required SyncTag syncTag,
  }) async {
    final resultContent = await equalContent(fragmentGizmoEditPageAbController: fragmentGizmoEditPageAbController);
    if (!resultContent.isModified) {
      return false;
    }
    if (fragment == null) {
      final newFragment = await db.insertDAO.insertFragment(
        willFragmentsCompanion: Crt.fragmentsCompanion(
          content: resultContent.now,
          creator_user_id: Aber.find<GlobalAbController>().loggedInUser()!.id,
          father_fragment_id: null.toValue(),
          fragment_template_id: (fragmentTemplate?.id).toValue(),
          client_be_selected: false,
          title: fragmentGizmoEditPageAbController.parseTitle(),
          tags: jsonEncode([]),
          be_sep_publish: false,
        ),
        whichFragmentGroupChains: fragmentGroupChains,
        syncTag: syncTag,
      );
      fragment = newFragment;
    } else {
      // 已经存储过当前碎片时，fragmentGroupChains 的修改单独进行。
      await RefFragments(
        self: () async {
          await fragment!.reset(
            content: resultContent.now.toValue(),
            creator_user_id: toAbsent(),
            father_fragment_id: toAbsent(),
            // 已经存储过当前碎片时，模板的修改单独进行。
            fragment_template_id: toAbsent(),
            client_be_selected: toAbsent(),
            // 因为本身就是 now
            title: fragmentGizmoEditPageAbController.parseTitle().toValue(),
            tags: toAbsent(),
            syncTag: syncTag,
            be_sep_publish: false.toValue(),
          );
        },
        fragmentMemoryInfos: null,
        rFragment2FragmentGroups: null,
        child_fragments: null,
        memoryModels: null,
        userComments: null,
        userLikes: null,
        order: 0,
      ).run();
    }
    return true;
  }

  /// 对当前 [fragment] 的 [FragmentTemplate] 进行增加、更新。
  ///
  /// 只会保存与 [fragment] 的关联，
  Future<bool> saveFragmentTemplate({
    required FragmentGizmoEditPageAbController fragmentGizmoEditPageAbController,
    required SyncTag syncTag,
  }) async {
    final resultFragmentTemplate = await equalFragmentTemplate();
    if (!resultFragmentTemplate.isModified) {
      return false;
    }
    if (fragment != null) {
      await RefFragments(
        self: () async {
          await fragment!.reset(
            content: toAbsent(),
            creator_user_id: toAbsent(),
            father_fragment_id: toAbsent(),
            fragment_template_id: (resultFragmentTemplate.now?.id).toValue(),
            client_be_selected: toAbsent(),
            title: toAbsent(),
            tags: toAbsent(),
            syncTag: syncTag,
            be_sep_publish: toAbsent(),
          );
        },
        fragmentMemoryInfos: null,
        rFragment2FragmentGroups: null,
        child_fragments: null,
        memoryModels: null,
        userComments: null,
        userLikes: null,
        order: 0,
      ).run();
    }
    return true;
  }

  /// 比较当前的是否与存储的相同。
  Future<
      ({
        bool isExistModified,
        ({bool isModified, String now, String saved}) content,
        ({bool isModified, List<List<FragmentGroup>> now, List<List<FragmentGroup>> saved}) fragmentGroupChains,
        ({bool isModified, FragmentTemplate? now, FragmentTemplate? saved}) fragmentTemplate,
      })> equalAll({
    required FragmentGizmoEditPageAbController fragmentGizmoEditPageAbController,
  }) async {
    final resultContent = equalContent(fragmentGizmoEditPageAbController: fragmentGizmoEditPageAbController);
    final resultFragmentGroupChains = await equalFragmentGroupChains(fragmentGizmoEditPageAbController: fragmentGizmoEditPageAbController);
    final resultFragmentTemplate = await equalFragmentTemplate();
    bool isExistModified = false;
    if (resultContent.isModified || resultFragmentGroupChains.isModified || resultFragmentTemplate.isModified) {
      isExistModified = true;
    }
    return (
      isExistModified: isExistModified,
      content: resultContent,
      fragmentGroupChains: resultFragmentGroupChains,
      fragmentTemplate: resultFragmentTemplate,
    );
  }

  /// 比较当前的是否与存储的相同。
  ///
  /// 返回值
  ///   - 是否不同
  ///   - 最新结果
  ({bool isModified, String now, String saved}) equalContent({required FragmentGizmoEditPageAbController fragmentGizmoEditPageAbController}) {
    final String now = jsonEncode(fragmentGizmoEditPageAbController.quillController.document.toDelta().toJson());
    late final String saved;
    if (fragment != null) {
      saved = fragment!.content;
    } else {
      saved = emptyContent;
    }
    if (now != saved) {
      logger.outNormal(print: "equalContent:\n$now\n$saved");
    }
    return (isModified: now != saved, now: now, saved: saved);
  }

  /// 比较当前的是否与存储的相同。
  ///
  /// 返回值
  ///   - 是否不同
  ///   - 最新结果
  Future<({bool isModified, FragmentTemplate? now, FragmentTemplate? saved})> equalFragmentTemplate() async {
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

    // 但当前 perform 为创建时，并且无内容时，返回未修改。
    if (fragment == null) {
      return (isModified: false, now: now, saved: saved);
    }

    if (now?.id != saved?.id) {
      logger.outNormal(print: "equalFragmentTemplate:\n${now?.id}\n${saved?.id}");
    }
    return (isModified: now?.id != saved?.id, now: now, saved: saved);
  }

  /// 比较当前的是否与存储的相同。
  ///
  /// 返回值
  ///   - 是否不同
  ///   - 最新结果
  Future<({bool isModified, List<List<FragmentGroup>> now, List<List<FragmentGroup>> saved})> equalFragmentGroupChains(
      {required FragmentGizmoEditPageAbController fragmentGizmoEditPageAbController}) async {
    final List<List<FragmentGroup>> now;
    final List<List<FragmentGroup>> saved;
    if (fragment != null) {
      now = fragmentGroupChains;
      saved = await db.generalQueryDAO.queryFragmentInWhichFragmentGroupChain(fragment: fragment!);
    } else {
      now = fragmentGroupChains;
      saved = [];
    }

    // 但当前 perform 为创建时，并且无内容时，返回未修改。
    if (fragment == null) {
      return (isModified: false, now: now, saved: saved);
    }

    if (now.isEmpty && saved.isEmpty) {
      return (isModified: false, now: now, saved: saved);
    }
    if (now.length != saved.length) {
      logger.outNormal(print: "equalFragmentGroupChains");
      return (isModified: true, now: now, saved: saved);
    }
    for (int i = 0; i < now.length; i++) {
      final nowResult = now[i].map((e) => e.id).join('');
      final savedResult = saved[i].map((e) => e.id).join('');
      if (nowResult != savedResult) {
        logger.outNormal(print: "equalFragmentGroupChains");
        return (isModified: true, now: now, saved: saved);
      }
    }
    return (isModified: false, now: now, saved: saved);
  }
}

class FragmentGizmoEditPageAbController extends AbController {
  FragmentGizmoEditPageAbController({
    required this.fragmentPerformerTypeAb,
    required this.initFragment,
    required this.initFragmentTemplater,
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

  /// 仅用来初始化赋值.
  final FragmentTemplater initFragmentTemplater;

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

  @override
  bool get isEnableLoading => true;

  @override
  Future<void> loadingFuture() async {
    final initPerformer = FragmentPerformer(fragment: initFragment);
    // 当创建时
    if (initFragment == null && initFragmentGroupChain != null) {
      initPerformer.fragmentGroupChains.add(initFragmentGroupChain!);
    }

    await initPerformer.reload(fragmentGizmoEditPageAbController: this, recent: null);

    records.addAll(initSomeBefore.map((e) => FragmentPerformer(fragment: e)));
    records.add(initPerformer);
    records.addAll(initSomeAfter.map((e) => FragmentPerformer(fragment: e)));

    currentPerformerAb.lateAssign(initPerformer);
  }

  bool isExistLast([Abw? abw]) {
    final currentIndex = records.indexOf(currentPerformerAb(abw));
    if (currentIndex == 0) {
      return false;
    }
    return true;
  }

  bool isExistNext([Abw? abw]) {
    final currentIndex = records.indexOf(currentPerformerAb(abw));
    if (currentIndex == records.length - 1) {
      return false;
    }
    return true;
  }

  /// [isTailNew] 当当前为最后一个时，下一个是否出现创建。
  Future<void> goTo({required LastOrNext lastOrNext, required bool isTailNew}) async {
    if (!records.contains(currentPerformerAb())) {
      throw '记录不包含当前碎片，无法获取 index！';
    }

    // 先检查当前
    final resultAll = await currentPerformerAb().equalAll(fragmentGizmoEditPageAbController: this);
    if (resultAll.isExistModified) {
      SmartDialog.showToast("存在修改未保存！");
      return;
    }

    final currentIndex = records.indexOf(currentPerformerAb());
    if (lastOrNext == LastOrNext.last) {
      if (!isExistLast()) return;
      // 再加载上一个
      final last = records[currentIndex - 1];
      await last.reload(fragmentGizmoEditPageAbController: this, recent: currentPerformerAb());
      // 后构建上一个
      quillController.document = q.Document.fromJson(jsonDecode(last.fragment!.content));
      fragmentPerformerTypeAb.refreshEasy((oldValue) => FragmentPerformerType.readonly);
      currentPerformerAb.refreshEasy((oldValue) => last);
    } else {
      if (!isExistNext()) {
        if (!isTailNew) {
          SmartDialog.showToast("已经是最后一个了~");
          return;
        }
        records.add(FragmentPerformer(fragment: null));
      }
      // 再加载下一个
      final next = records[currentIndex + 1];
      await next.reload(fragmentGizmoEditPageAbController: this, recent: currentPerformerAb());
      // 后构建下一个
      if (next.fragment == null) {
        // TODO: 模板内容也复制到新的上来。
        fragmentPerformerTypeAb.refreshEasy((oldValue) => FragmentPerformerType.editable);
      } else {
        quillController.document = q.Document.fromJson(jsonDecode(next.fragment!.content));
        fragmentPerformerTypeAb.refreshEasy((oldValue) => FragmentPerformerType.readonly);
      }
      currentPerformerAb.refreshEasy((oldValue) => next);
    }
  }

  Future<void> save(bool isGotoNext) async {
    if (currentPerformerAb().fragmentGroupChains.isEmpty) {
      SmartDialog.showToast('未选择存放位置！');
      return;
    }

    if (currentPerformerAb().fragment == null && jsonEncode(quillController.document.toDelta().toJson()) == FragmentPerformer.emptyContent) {
      SmartDialog.showToast('内容不能为空！');
      return;
    }

    final st = await SyncTag.create();
    final saveResult = await currentPerformerAb().saveAll(fragmentGizmoEditPageAbController: this, syncTag: st);
    if (saveResult) {
      SmartDialog.showToast('保存成功！');
    }
    if (isGotoNext) {
      await goTo(lastOrNext: LastOrNext.next, isTailNew: true);
    }
  }

  Future<void> showSaveGroup() async {
    await showSelectFragmentGroupsDialog(selectedFragmentGroupChains: currentPerformerAb().fragmentGroupChains);
    currentPerformerAb.refreshForce();
  }
}
