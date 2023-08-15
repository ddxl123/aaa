import 'dart:convert';

import 'package:aaa/global/GlobalAbController.dart';
import 'package:aaa/single_dialog/showSelectFragmentGroupsDialog.dart';
import 'package:drift_main/drift/DriftDb.dart';
import 'package:tools/tools.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:collection/collection.dart';

import 'FragmentTemplate/base/FragmentTemplate.dart';

enum LastOrNext {
  last,
  next,
}

class FragmentPerformer {
  FragmentPerformer({required this.fragment, required this.fragmentTemplate});

  /// 为 null 表示为创建碎片。
  Fragment? fragment;

  /// 当前操作碎片所存放的碎片组。
  ///   - 若为空数组，则没有选择组。
  final dynamicFragmentGroups = <(FragmentGroup?, RFragment2FragmentGroup?)>[];

  /// [fragmentTemplate] 是根据 [fragment.content] 解析而来。
  ///
  /// [fragment] 为 null，[fragmentTemplate] 也为 null。
  FragmentTemplate fragmentTemplate;

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
        dynamicFragmentGroups
          ..clear()
          ..addAll(recent.dynamicFragmentGroups);
        fragmentTemplate = recent.fragmentTemplate.emptyTransferableInstance();
      } else {
        fragmentTemplate = fragmentTemplate.emptyInitInstance();
      }
      return false;
    } else {
      final resultAll = await equalAll(fragmentGizmoEditPageAbController: fragmentGizmoEditPageAbController);
      if (!resultAll.isExistModified) {
        return false;
      }

      if (resultAll.template.isModified) {
        fragment!.content = jsonEncode(resultAll.template.saved.toJson());
        fragmentTemplate.resetFromJson(jsonDecode(fragment!.content));
      }
      if (resultAll.fragmentGroupChains.isModified) {
        dynamicFragmentGroups.clear();
        dynamicFragmentGroups.addAll(resultAll.fragmentGroupChains.saved);
      }
      return true;
    }
  }

  /// 返回是否存在修改。
  Future<bool> saveAll({
    required FragmentGizmoEditPageAbController fragmentGizmoEditPageAbController,
    required SyncTag syncTag,
  }) async {
    final result = await equalAll(fragmentGizmoEditPageAbController: fragmentGizmoEditPageAbController);
    if (!result.isExistModified) {
      return false;
    }
    // 若碎片是新建的，则进行插入
    if (fragment == null) {
      final newFragment = await db.insertDAO.insertFragmentAndR(
        willFragmentsCompanion: Crt.fragmentsCompanion(
          content: jsonEncode(result.template.now.toJson()),
          creator_user_id: Aber.find<GlobalAbController>().loggedInUser()!.id,
          father_fragment_id: null.toValue(),
          title: fragmentTemplate.getTitle(),
          be_sep_publish: false,
        ),
        dynamicFragmentGroups: result.fragmentGroupChains.now.map((e) => e.$1).toList(),
        syncTag: syncTag,
        isCloudTableWithSync: true,
      );
      fragment = newFragment;
      final dynamicFragmentGroupReset = await db.generalQueryDAO.queryFragmentGroupAndRs(fragment: newFragment);
      dynamicFragmentGroups
        ..clear()
        ..addAll(dynamicFragmentGroupReset);
    } else {
      await RefFragments(
        self: () async {
          await fragment!.reset(
            content: jsonEncode(result.template.now.toJson()).toValue(),
            creator_user_id: toAbsent(),
            father_fragment_id: toAbsent(),
            // 因为本身就是 now
            title: fragmentTemplate.getTitle().toValue(),
            syncTag: syncTag,
            be_sep_publish: false.toValue(),
            isCloudTableWithSync: true,
          );
        },
        rFragment2FragmentGroups: RefRFragment2FragmentGroups(
          self: () async {
            final user = Aber.find<GlobalAbController>().loggedInUser()!;
            final saved = result.fragmentGroupChains.saved;
            final now = result.fragmentGroupChains.now;
            // 删除 saved
            for (var value in saved) {
              await value.$2?.delete(
                syncTag: syncTag,
                isCloudTableWithSync: SyncTag.parseToUserId(value.$2!.id) == user.id,
              );
            }
            print("------------------");
            print(saved);
            print(now);

            // 存储 now
            for (var value in now) {
              await RefRFragment2FragmentGroups(
                self: () async {
                  await Crt.rFragment2FragmentGroupsCompanion(
                    client_be_selected: false,
                    creator_user_id: user.id,
                    fragment_group_id: (value.$1?.id).toValue(),
                    fragment_id: fragment!.id,
                  ).insert(
                    syncTag: syncTag,
                    isCloudTableWithSync: true,
                    isCloudTableAutoId: true,
                    isReplaceWhenIdSame: false,
                  );
                },
                order: 0,
              ).run();
            }

            await db.deleteDAO.deleteAllFreeFragment(syncTag: syncTag, userId: user.id);

            final dynamicFragmentGroupReset = await db.generalQueryDAO.queryFragmentGroupAndRs(fragment: fragment!);
            dynamicFragmentGroups
              ..clear()
              ..addAll(dynamicFragmentGroupReset);
          },
          order: 0,
        ),
        fragmentMemoryInfos: null,
        fragments_father_fragment_id: null,
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
        ({bool isModified, FragmentTemplate now, FragmentTemplate saved}) template,
        ({
          bool isModified,
          List<(FragmentGroup?, RFragment2FragmentGroup?)> now,
          List<(FragmentGroup?, RFragment2FragmentGroup?)> saved,
        }) fragmentGroupChains,
        bool isExistModified,
      })> equalAll({
    required FragmentGizmoEditPageAbController fragmentGizmoEditPageAbController,
  }) async {
    final resultTemplate = await equalTemplate(fragmentGizmoEditPageAbController: fragmentGizmoEditPageAbController);
    final resultFragmentGroupChains = await equalFragmentGroupChains(fragmentGizmoEditPageAbController: fragmentGizmoEditPageAbController);
    bool isExistModified = false;
    if (fragment == null) {
      if (resultTemplate.isModified) {
        isExistModified = true;
      }
    } else {
      if (resultTemplate.isModified || resultFragmentGroupChains.isModified) {
        isExistModified = true;
      }
    }
    return (
      isExistModified: isExistModified,
      template: resultTemplate,
      fragmentGroupChains: resultFragmentGroupChains,
    );
  }

  Future<({bool isModified, FragmentTemplate now, FragmentTemplate saved})> equalTemplate({required FragmentGizmoEditPageAbController fragmentGizmoEditPageAbController}) async {
    final FragmentTemplate now = fragmentTemplate;
    late final FragmentTemplate saved;
    if (fragment != null) {
      saved = FragmentTemplate.newInstanceFromContent((await db.generalQueryDAO.queryFragmentById(id: fragment!.id)).content);
    } else {
      saved = fragmentTemplate.emptyTransferableInstance();
    }
    final isModified = !FragmentTemplate.equalFrom(now, saved);
    if (isModified) {
      logger.outNormal(print: "equalContent 存在修改：\nnow:${now.toJson()}\nsaved:${saved.toJson()}");
    }
    return (isModified: isModified, now: now, saved: saved);
  }

  /// 比较当前的是否与存储的相同。
  ///
  /// 返回值
  ///   - 是否不同
  ///   - 最新结果
  Future<
      ({
        bool isModified,
        List<(FragmentGroup?, RFragment2FragmentGroup?)> now,
        List<(FragmentGroup?, RFragment2FragmentGroup?)> saved,
      })> equalFragmentGroupChains({required FragmentGizmoEditPageAbController fragmentGizmoEditPageAbController}) async {
    final List<(FragmentGroup?, RFragment2FragmentGroup?)> now;
    final List<(FragmentGroup?, RFragment2FragmentGroup?)> saved;
    if (fragment != null) {
      now = dynamicFragmentGroups;
      saved = await db.generalQueryDAO.queryFragmentGroupAndRs(fragment: fragment!);
    } else {
      now = dynamicFragmentGroups;
      saved = [];
    }

    // 但当前 perform 为创建时，并且无内容时，返回未修改。
    if (fragment == null) {
      return (isModified: false, now: now, saved: saved);
    }
    final isModified = !const DeepCollectionEquality().equals(
      now.map((e) => "${e.$1?.id}+${e.$2?.id}"),
      saved.map((e) => "${e.$1?.id}+${e.$2?.id}"),
    );
    if (isModified) {
      logger.outNormal(print: "equalFragmentGroupChains 存在修改：$isModified\nnow:\n$now\nsaved:\n$saved");
    }

    return (isModified: isModified, now: now, saved: saved);
  }
}

class FragmentGizmoEditPageAbController extends AbController {
  FragmentGizmoEditPageAbController({
    required this.isEditable,
    required this.initFragment,
    required this.initFragmentTemplate,
    required this.initSomeBefore,
    required this.initSomeAfter,
    required this.enterDynamicFragmentGroups,
  });

  final Ab<bool> isEditable;

  /// 仅用来初始化赋值，若没有的话为 []。
  final List<Fragment> initSomeBefore;

  /// 仅用来初始化赋值，若没有的话为 []。
  final List<Fragment> initSomeAfter;

  /// 仅用来初始化赋值，若为 null，则初始化时为创建。
  final Fragment? initFragment;

  /// 仅用来初始化赋值.
  final FragmentTemplate initFragmentTemplate;

  /// 从哪个碎片组进入到该页面的。
  ///
  /// [RFragment2FragmentGroup]? - 为 null 时表示是新增的没有被保存的，不为 null 则是被保存过的。
  ///
  /// [FragmentGroup]? - 为 null 时表示选择了 root。
  ///
  /// [enterDynamicFragmentGroups] 为 null 时表示进入该页面时，没有组。
  final (FragmentGroup?, RFragment2FragmentGroup?)? enterDynamicFragmentGroups;

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
    final initPerformer = FragmentPerformer(fragment: initFragment, fragmentTemplate: initFragmentTemplate);

    initPerformer.dynamicFragmentGroups.clear();
    // 当创建时
    if (initFragment == null) {
      if (enterDynamicFragmentGroups != null) {
        initPerformer.dynamicFragmentGroups.add(enterDynamicFragmentGroups!);
      }
    }

    await initPerformer.reload(fragmentGizmoEditPageAbController: this, recent: null);

    records.addAll(initSomeBefore.map((e) => FragmentPerformer(fragment: e, fragmentTemplate: FragmentTemplate.newInstanceFromContent(e.content))));
    records.add(initPerformer);
    records.addAll(initSomeAfter.map((e) => FragmentPerformer(fragment: e, fragmentTemplate: FragmentTemplate.newInstanceFromContent(e.content))));

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
      currentPerformerAb.refreshEasy((oldValue) => last);
      await last.reload(fragmentGizmoEditPageAbController: this, recent: records[currentIndex]);
      isEditable.refreshEasy((oldValue) => false);
    } else {
      if (!isExistNext()) {
        if (!isTailNew) {
          SmartDialog.showToast("已经是最后一个了~");
          return;
        }
        records.add(
          FragmentPerformer(
            fragment: null,
            fragmentTemplate: currentPerformerAb().fragmentTemplate.emptyTransferableInstance(),
          ),
        );
      }
      // 再加载下一个
      final next = records[currentIndex + 1];
      currentPerformerAb.refreshEasy((oldValue) => next);
      await next.reload(fragmentGizmoEditPageAbController: this, recent: records[currentIndex]);
      if (next.fragment == null) {
        isEditable.refreshEasy((oldValue) => true);
      } else {
        isEditable.refreshEasy((oldValue) => false);
      }
    }
  }

  Future<void> save(bool isGotoNext) async {
    if (currentPerformerAb().dynamicFragmentGroups.isEmpty) {
      SmartDialog.showToast('未选择存放位置！');
      return;
    }

    final isMustContentEmpty = currentPerformerAb().fragmentTemplate.isMustContentEmpty();
    if (isMustContentEmpty.$1) {
      SmartDialog.showToast(isMustContentEmpty.$2);
      return;
    }

    final st = await SyncTag.create();

    // 若当前不是创建碎片，且存储的路径为空数组，则提示是否删除当前碎片
    if (initFragment != null && currentPerformerAb().dynamicFragmentGroups.isEmpty) {
      await showCustomDialog(
        builder: (ctx) {
          return OkAndCancelDialogWidget(
            text: "你移除了所有位置，保存后将会删除当前碎片，确认要这样做吗？",
            okText: "删除",
            cancelText: "返回",
            onOk: () async {
              final saveResult = await currentPerformerAb().saveAll(fragmentGizmoEditPageAbController: this, syncTag: st);
              if (saveResult) {
                SmartDialog.showToast('删除成功！');
              } else {
                throw "不应该执行到这里";
              }
              SmartDialog.dismiss(status: SmartStatus.dialog);
            },
          );
        },
      );
    } else {
      final saveResult = await currentPerformerAb().saveAll(fragmentGizmoEditPageAbController: this, syncTag: st);
      if (saveResult) {
        SmartDialog.showToast('保存成功！');
      } else {
        // 无修改
      }
      if (isGotoNext) {
        await goTo(lastOrNext: LastOrNext.next, isTailNew: true);
      }
    }
  }

  Future<void> showSaveGroup() async {
    await showSelectFragmentGroupsDialog(selectedDynamicFragmentGroup: currentPerformerAb().dynamicFragmentGroups);
    currentPerformerAb.refreshForce();
  }
}
