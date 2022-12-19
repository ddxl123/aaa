import 'dart:convert';

import 'package:aaa/global/GlobalAbController.dart';
import 'package:aaa/single_dialog/showSelectFragmentGroupDialog.dart';
import 'package:drift_main/drift/DriftDb.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_quill/flutter_quill.dart' as q;
import 'package:tools/tools.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class ThreeStorageAb<V> {
  ThreeStorageAb({
    required this.currentValueAb,
    required this.createValue,
    required this.saveValue,
  });

  final Ab<V> currentValueAb;
  V createValue;
  V saveValue;
}

/// createValue 保存着初始化为 [创建] 的数据。
///
/// saveValue 保存着已保存过的数据，如果它不为 null，则表示该碎片已经保存过，反之未保存过。
///
/// currentValue 保存着当前数据，可能为 initValue、saveValue，以及修改后但未保存的数据。
class CurrentPerformerStorage {
  Ab<Fragment>? current;

  /// 当前操作碎片的内容。
  final contentStorage = ThreeStorageAb<String?>(
    currentValueAb: Ab<String?>(null),
    createValue: null,
    saveValue: null,
  );

  /// 当前操作碎片所存放的碎片组位置。
  final selectedFragmentGroupChainsStorage = ThreeStorageAb<List<List<FragmentGroup>>>(
    currentValueAb: Ab<List<List<FragmentGroup>>>([]),
    createValue: [],
    saveValue: [],
  );

  /// 当前操作碎片所使用的模板。
  final selectedFragmentTemplateStorage = ThreeStorageAb<FragmentTemplate?>(
    currentValueAb: Ab<FragmentTemplate?>(null),
    createValue: null,
    saveValue: null,
  );

  /// 初始化。
  Future<void> init({required Ab<Fragment>? fragmentAb, required Ab<FragmentGroup>? fragmentGroupAb}) async {
    current = fragmentAb;
    if (current == null) {
      contentStorage
        ..createValue = null
        ..saveValue = null
        ..currentValueAb.refreshEasy((oldValue) => null);

      selectedFragmentTemplateStorage
        ..createValue = null
        ..saveValue = null
        ..currentValueAb.refreshEasy((oldValue) => null);

      selectedFragmentGroupChainsStorage
        ..createValue.clear()
        ..saveValue.clear()
        ..currentValueAb.refreshEasy((oldValue) => oldValue..clear());
      if (fragmentGroupAb != null) {
        final chain = await db.generalQueryDAO.queryFragmentGroupInWhichFragmentGroupChain(fragmentGroup: fragmentGroupAb());
        selectedFragmentGroupChainsStorage.createValue.add(chain);
        selectedFragmentGroupChainsStorage.currentValueAb.refreshEasy((oldValue) => oldValue..add(chain));
      }
    } else {
      contentStorage
        ..createValue = null
        ..saveValue = fragmentAb!().content
        ..currentValueAb.refreshEasy((oldValue) => fragmentAb().content);

      FragmentTemplate? ft;
      if (current!().fragmentTemplateId != null) {
        ft = await db.generalQueryDAO.queryFragmentTemplateById(fragmentTemplateId: current!().fragmentTemplateId!);
      }
      selectedFragmentTemplateStorage
        ..createValue = null
        ..saveValue = ft
        ..currentValueAb.refreshEasy((oldValue) => ft);

      final chains = await db.generalQueryDAO.queryFragmentInWhichFragmentGroupChain(fragment: current!());
      selectedFragmentGroupChainsStorage
        ..createValue.clear()
        ..saveValue.clear()
        ..saveValue.addAll(chains)
        ..currentValueAb.refreshEasy((oldValue) => oldValue
          ..clear()
          ..addAll(chains));
    }
  }

  /// 检查 [非创建] 的碎片是否被修改。
  ///
  /// 若检查成功，则返回 null，否则返回失败消息。
  String? isDataModified() {
    if (current != null) {
      if (contentStorage.currentValueAb() != contentStorage.saveValue) {
        return '内容发生修改，请先保存！';
      }
      if (selectedFragmentTemplateStorage.currentValueAb() != selectedFragmentTemplateStorage.saveValue) {
        return '模板发生了改变，请先保存！';
      }
      if (selectedFragmentGroupChainsStorage.currentValueAb() != selectedFragmentGroupChainsStorage.saveValue) {
        return '存放位置发生了改变，请先保存！';
      }
    }
    return null;
  }

  /// 改变到已有的碎片。
  ///
  /// 返回值见 [isDataModified]。
  Future<String?> to({required Ab<Fragment>? fragmentAb}) async {
    final isDataModifiedMessage = isDataModified();
    if (isDataModifiedMessage != null) return isDataModifiedMessage;

    current = fragmentAb;

    if (current == null) {
      contentStorage.currentValueAb.refreshEasy((oldValue) => contentStorage.createValue);

      selectedFragmentTemplateStorage.currentValueAb.refreshEasy((oldValue) => selectedFragmentTemplateStorage.createValue);

      selectedFragmentGroupChainsStorage.currentValueAb.refreshEasy((oldValue) => oldValue
        ..clear()
        ..addAll(selectedFragmentGroupChainsStorage.createValue));
    } else {
      contentStorage
        ..saveValue = fragmentAb!().content
        ..currentValueAb.refreshEasy((oldValue) => fragmentAb().content);

      FragmentTemplate? ft;
      if (current!().fragmentTemplateId != null) {
        ft = await db.generalQueryDAO.queryFragmentTemplateById(fragmentTemplateId: current!().fragmentTemplateId!);
      }
      selectedFragmentTemplateStorage
        ..saveValue = ft
        ..currentValueAb.refreshEasy((oldValue) => ft);

      final chains = await db.generalQueryDAO.queryFragmentInWhichFragmentGroupChain(fragment: current!());
      selectedFragmentGroupChainsStorage
        ..saveValue.clear()
        ..saveValue.addAll(chains)
        ..currentValueAb.refreshEasy((oldValue) => oldValue
          ..clear()
          ..addAll(chains));
    }

    return null;
  }

  /// 保存修改，或者保存创建且自动下一个创建。
  ///
  /// 保存创建时，会跳到下一个创建。
  ///
  /// 保存修改时，不会跳到下一个。
  Future<void> saveOrNext({required FragmentGizmoEditPageAbController fragmentGizmoEditPageAbController}) async {
    if (current == null) {
      final newFragment = await db.insertDAO.insertFragment(
        willFragmentsCompanion: Crt.fragmentsCompanion(
          content: contentStorage.currentValueAb()!,
          creatorUserId: Aber.find<GlobalAbController>().loggedInUser()!.id,
          fatherFragmentId: null.toValue(),
          fragmentTemplateId: selectedFragmentTemplateStorage.currentValueAb()!.id.toValue(),
          local_isSelected: false,
          noteId: null.toValue(),
          title: fragmentGizmoEditPageAbController.parseTitle(),
        ),
        whichFragmentGroups: selectedFragmentGroupChainsStorage.currentValueAb().map((e) => e.isEmpty ? null : e.last).toList(),
        syncTag: null,
      );
      fragmentGizmoEditPageAbController.records.refreshEasy(
        (oldValue) {
          final index = oldValue.indexOf(null);
          oldValue.replaceRange(index, index + 1, [newFragment.ab]);
          oldValue.add(null);
          return oldValue;
        },
      );
      current = null;

    } else {
      final isDataModifiedMessage = isDataModified();
      if (isDataModifiedMessage == null) {
        throw '数据没有被修改，但却调用了存储函数！';
      }
      await db.updateDAO.resetFragment(
        originalFragmentReset: (st) async {
          return await current!().reset(
            content: contentStorage.currentValueAb()!.toValue(),
            creatorUserId: toAbsent(),
            fatherFragmentId: toAbsent(),
            fragmentTemplateId: selectedFragmentTemplateStorage.currentValueAb()!.id.toValue(),
            local_isSelected: toAbsent(),
            noteId: toAbsent(),
            title: fragmentGizmoEditPageAbController.parseTitle().toValue(),
            syncTag: st,
          );
        },
        syncTag: null,
      );
      current!.refreshForce();
    }
  }
}

class FragmentGizmoEditPageAbController extends AbController {
  FragmentGizmoEditPageAbController({
    required this.initFragment,
    required this.initFragmentGroup,
    required this.initSomeBefore,
    required this.initSomeAfter,
  }) {
    if (initFragment != null && initFragmentGroup != null) {
      throw '请看 initFragmentGroup 注释！';
    }
  }

  /// 仅用来初始化赋值，若没有的话为 []。
  final List<Ab<Fragment>> initSomeBefore;

  /// 仅用来初始化赋值，若没有的话为 []。
  final List<Ab<Fragment>> initSomeAfter;

  /// 仅用来初始化赋值，若为 null，则初始化时为创建。
  final Ab<Fragment>? initFragment;

  /// 仅用来初始化赋值。
  ///
  /// 当 [initFragment] 为 null 时，在某个组内进行创建组时，需要传递这个。
  /// 当 [initFragment] 不为 null 时，内部会自行获取 [initFragmentGroup]，因此无需赋初始化值。
  final Ab<FragmentGroup>? initFragmentGroup;

  /// 用来记录操作的碎片，存放 [initSomeBefore]、[initFragment]、[initSomeAfter] 的对象。
  ///
  /// 只允许存在一个元素为 null，否则检索 index 时只会检索到第一个 null。
  /// 而相同的 [Fragment] 并不是同一个 [FragmentAbAndFragmentGroupAb] 对象，所有不需要关心对象是否相同。
  final records = <Ab<Fragment>?>[].ab;

  /// 当前 [records] 的数据仓库。
  final CurrentPerformerStorage currentPerformer = CurrentPerformerStorage();

  late final q.QuillController quillController;

  @override
  bool get isEnableLoading => true;

  @override
  Future<void> loadingFuture() async {
    await _init();
  }

  Future<void> _init() async {
    records().addAll(initSomeBefore);
    records().add(initFragment);
    records().addAll(initSomeAfter);
    records.refreshForce();
    await currentPerformer.changeTo(performer: initFragment);
  }

  void _createInit() {
    quillController = q.QuillController.basic();
  }

  void _updateInit() {
    quillController = q.QuillController(
      document: q.Document.fromJson(jsonDecode(currentFragmentAb!().content)),
      selection: const TextSelection.collapsed(offset: 0),
    );
  }

  String richToJson() => jsonEncode(quillController.document.toDelta().toJson());

  String parseTitle() {
    final text = quillController.document.toPlainText().trim();
    return text.substring(0, text.length > 10 ? 11 : text.length);
  }

  Future<void> showSaveGroup() async {
    await showSelectFragmentGroupDialog(selectedFragmentGroupChainAb: selectedFragmentGroupChainsStorage);
  }

  Future<void> create() async {
    if (currentFragmentAb != null) {
      throw '碎片已存在，但却调用了创建函数！';
    }
    if (selectedFragmentGroupChainsStorage() == null) {
      SmartDialog.showToast('请选择存放位置！');
      return;
    }
    await db.insertDAO.insertFragment(
      willFragmentsCompanion: Crt.fragmentsCompanion(
        content: richToJson(),
        creatorUserId: Aber.find<GlobalAbController>().loggedInUser()!.id,
        fatherFragmentId: null.toValue(),
        fragmentTemplateId: (selectedFragmentTemplateStorage()?.id).toValue(),
        local_isSelected: false,
        noteId: null.toValue(),
        title: parseTitle(),
      ),
      whichFragmentGroups: selectedFragmentGroupChainsStorage()!.last,
      syncTag: null,
    );

    SmartDialog.showToast('保存成功！');
  }
}
