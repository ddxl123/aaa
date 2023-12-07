import 'dart:convert';

import 'package:aaa/global/GlobalAbController.dart';
import 'package:aaa/single_dialog/showSelectFragmentGroupsDialog.dart';
import 'package:drift_main/drift/DriftDb.dart';
import 'package:drift_main/httper/httper.dart';
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

  /// [fragmentTemplate] 是根据 [fragment.content] 解析而来。
  ///
  /// [fragment] 为 null，[fragmentTemplate] 也为 null。
  FragmentTemplate fragmentTemplate;

  /// [FragmentGizmoEditPageAbController.enterDynamicFragmentGroups]
  final dynamicFragmentGroups = <(FragmentGroup?, RFragment2FragmentGroup?)>[];

  bool get isCreateStatus => fragment == null;

  // final fragmentTag = <String>[];

  /// 从本地数据库中重新加载当前 [fragment]。
  ///
  /// [recent] 表示最近一个操作的 [FragmentPerformer]，若为 null，则表示没有最近的。
  ///
  /// 返回重新加载前与重新加载后是否存在变动。
  // TODO: 增加 loading
  Future<void> reload({required FragmentGizmoEditPageAbController fragmentGizmoEditPageAbController, required FragmentPerformer? recent}) async {
    if (isCreateStatus) {
      // 保留上一次设置。
      if (recent != null) {
        dynamicFragmentGroups
          ..clear()
          ..addAll(recent.dynamicFragmentGroups);
        fragmentTemplate = recent.fragmentTemplate.emptyTransferableInstance();
      } else {
        fragmentTemplate = fragmentTemplate.emptyInitInstance();
      }
    } else {
      print("-111---------------");
      final queryFragment = await request(
        path: HttpPath.POST__LOGIN_REQUIRED_SINGLE_ROW_QUERY,
        dtoData: SingleRowQueryDto(
          table_name: driftDb.fragments.actualTableName,
          row_id: fragment!.id,
        ),
        parseResponseVoData: SingleRowQueryVo.fromJson,
      );
      await queryFragment.handleCode(
        code90101: (String showMessage, SingleRowQueryVo vo) async {
          fragment = Fragment.fromJson(vo.row);
          fragmentTemplate.resetFromJson(jsonDecode(fragment!.content));
        },
        otherException: (a, b, c) async {
          logger.outErrorHttp(code: a, showMessage: b.showMessage, debugMessage: b.debugMessage, st: c);
        },
      );

      final queryFgWithR = await request(
        path: HttpPath.GET__NO_LOGIN_REQUIRED_FRAGMENT_HANDLE_QUERY_FRAGMENT_GROUP_WITH_R,
        dtoData: FragmentQueryFragmentGroupWithRDto(
          fragment_id: fragment!.id,
          user_id: Aber.find<GlobalAbController>().loggedInUser()!.id,
        ),
        parseResponseVoData: FragmentQueryFragmentGroupWithRVo.fromJson,
      );
      await queryFgWithR.handleCode(
        code140101: (String showMessage, FragmentQueryFragmentGroupWithRVo vo) async {
          dynamicFragmentGroups.clear();
          dynamicFragmentGroups.addAll(vo.fragment_group_with_r_list.map((e) => (e.fragment_group, e.r_fragment_2_fragment_groups)));
        },
        otherException: (a, b, c) async {
          logger.outErrorHttp(code: a, showMessage: b.showMessage, debugMessage: b.debugMessage, st: c);
        },
      );
    }
  }

  /// 返回是否保存成功。
  Future<bool> save({
    required FragmentGizmoEditPageAbController fragmentGizmoEditPageAbController,
  }) async {
    if (dynamicFragmentGroups.isEmpty) {
      SmartDialog.showToast('未选择存放位置！');
      return false;
    }

    final isMustContentEmpty = fragmentTemplate.isMustContentEmpty();
    if (isMustContentEmpty.$1) {
      SmartDialog.showToast(isMustContentEmpty.$2);
      return false;
    }

    if (dynamicFragmentGroups.isEmpty) {
      if (!isCreateStatus) {
        bool isReturn = false;
        await showCustomDialog(
          builder: (ctx) {
            return OkAndCancelDialogWidget(
              text: "你移除了所有存储位置，等同于你从你的碎片组中移除了该碎片，确认要这样做吗？\n"
                  "注意：其他用户所复用的该碎片并不会同时被移除掉。",
              okText: "确定",
              cancelText: "返回",
              onOk: () async {
                isReturn = false;
                SmartDialog.dismiss(status: SmartStatus.dialog);
              },
              onCancel: () {
                isReturn = true;
                SmartDialog.dismiss(status: SmartStatus.dialog);
              },
            );
          },
        );
        if (isReturn) return false;
      } else {
        SmartDialog.showToast("请选择要保存的位置！");
        return false;
      }
    }

    bool isSaveSuccess = false;
    // 若碎片是新建的，则进行插入
    if (isCreateStatus) {
      final insertResult = await request(
        // TODO: 整理好哪些请求需要登录，哪些不需要。
        path: HttpPath.POST__NO_LOGIN_REQUIRED_FRAGMENT_HANDLE_INSERT_FRAGMENT,
        dtoData: FragmentInsertFragmentDto(
          fragment: Crt.fragmentEntity(
            content: jsonEncode(fragmentTemplate.toJson()),
            creator_user_id: Aber.find<GlobalAbController>().loggedInUser()!.id,
            father_fragment_id: null,
            title: fragmentTemplate.getTitle(),
            be_sep_publish: false,
          ),
          fragment_group_ids_list: dynamicFragmentGroups.map((e) => e.$1?.id).toList(),
        ),
        parseResponseVoData: FragmentInsertFragmentVo.fromJson,
      );
      await insertResult.handleCode(
        code140201: (String showMessage, FragmentInsertFragmentVo vo) async {
          // 插入到本地
          await driftDb.insertDAO.insertFragment(f: vo.fragment);

          fragment = vo.fragment;
          isSaveSuccess = true;
          SmartDialog.showToast("创建成功！");
        },
        otherException: (a, b, c) async {
          isSaveSuccess = false;
          logger.outErrorHttp(code: a, showMessage: b.showMessage, debugMessage: b.debugMessage, st: c);
        },
      );
    } else {
      final newF = fragment!
        ..content = jsonEncode(fragmentTemplate.toJson())
        // 因为本身就是 now
        ..title = fragmentTemplate.getTitle()
        ..be_sep_publish = false;
      final modifyResult = await request(
        path: HttpPath.POST__NO_LOGIN_REQUIRED_FRAGMENT_HANDLE_MODIFY_FRAGMENT,
        dtoData: FragmentModifyFragmentDto(
          fragment: newF,
          fragment_group_ids_list: dynamicFragmentGroups.map((e) => e.$1?.id).toList(),
        ),
        parseResponseVoData: FragmentModifyFragmentVo.fromJson,
      );
      await modifyResult.handleCode(
        code140301: (String showMessage) async {
          // 更新到本地
          await driftDb.insertDAO.insertFragment(f: newF);

          isSaveSuccess = true;
          SmartDialog.showToast("修改成功！");
        },
        otherException: (a, b, c) async {
          isSaveSuccess = false;
          logger.outErrorHttp(code: a, showMessage: b.showMessage, debugMessage: b.debugMessage, st: c);
        },
      );
    }
    if (isSaveSuccess) {
      fragmentGizmoEditPageAbController.isEditable.refreshEasy((oldValue) => false);
    }
    return isSaveSuccess;
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
  Future<bool> backListener(bool hasRoute) async {
    if (hasRoute) {
      return false;
    }
    if (isEditable()) {
      bool isBack = false;
      await showCustomDialog(
        builder: (ctx) {
          return OkAndCancelDialogWidget(
            title: "是否保存？",
            okText: "保存",
            cancelText: "不保存",
            cancelLeftText: "继续编辑",
            onCancelLeft: () {
              SmartDialog.dismiss(status: SmartStatus.dialog);
              isBack = false;
            },
            onOk: () async {
              // TODO: loading
              final isSuccess = await currentPerformerAb().save(fragmentGizmoEditPageAbController: this);
              SmartDialog.dismiss(status: SmartStatus.dialog);
              isBack = isSuccess;
            },
            onCancel: () async {
              SmartDialog.dismiss(status: SmartStatus.dialog);
              isBack = true;
            },
          );
        },
      );
      return !isBack;
    }
    return false;
  }

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
    if (isEditable()) {
      bool isContinue = false;
      await showCustomDialog(
        builder: (ctx) {
          return OkAndCancelDialogWidget(
            title: "是否保存？",
            okText: "保存",
            cancelText: "不保存",
            cancelLeftText: "继续编辑",
            onCancelLeft: () {
              isContinue = false;
              SmartDialog.dismiss(status: SmartStatus.dialog);
            },
            onOk: () async {
              // TODO: loading
              final isSuccess = await currentPerformerAb().save(fragmentGizmoEditPageAbController: this);
              SmartDialog.dismiss(status: SmartStatus.dialog);
              isContinue = isSuccess;
            },
            onCancel: () async {
              isContinue = true;
              SmartDialog.dismiss(status: SmartStatus.dialog);
            },
          );
        },
      );
      if (!isContinue) {
        return;
      }
    }

    final currentIndex = records.indexOf(currentPerformerAb());
    if (lastOrNext == LastOrNext.last) {
      if (!isExistLast()) return;
      // 再加载上一个
      final last = records[currentIndex - 1];
      print("last-${last.fragment}");
      await last.reload(fragmentGizmoEditPageAbController: this, recent: records[currentIndex]);
      currentPerformerAb.refreshEasy((oldValue) => last);
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
    final iSavedSuccess = await currentPerformerAb().save(fragmentGizmoEditPageAbController: this);
    if (iSavedSuccess && isGotoNext) {
      await goTo(lastOrNext: LastOrNext.next, isTailNew: true);
    }
  }

  Future<void> showSaveGroup() async {
    await showSelectFragmentGroupsDialog(selectedDynamicFragmentGroup: currentPerformerAb().dynamicFragmentGroups);
    currentPerformerAb.refreshForce();
  }
}
