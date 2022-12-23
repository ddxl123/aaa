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
  late final FragmentGizmoEditPageAbController fragmentGizmoEditPageAbController;
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

  bool isEqualContent({
    required String? one,
    required String? two,
  }) {
    final oneT = one ?? '[{"insert":"\\n"}]';
    final twoT = two ?? '[{"insert":"\\n"}]';
    return oneT == twoT;
  }

  bool isEqualFragmentTemplate({
    required FragmentTemplate? one,
    required FragmentTemplate? two,
  }) {
    return one?.id == two?.id;
  }

  bool isEqualFragmentGroupChains({
    required List<List<FragmentGroup>> one,
    required List<List<FragmentGroup>> two,
  }) {
    if (one.isEmpty && two.isEmpty) {
      return true;
    }
    if (one.length != two.length) {
      return false;
    }
    for (int i = 0; i < one.length; i++) {
      final oneResult = one[i].map((e) => e.id).join('');
      final twoResult = two[i].map((e) => e.id).join('');
      if (oneResult != twoResult) {
        return false;
      }
    }
    return true;
  }

  /// 初始化。
  /// 若 [fragmentGroupAb] 为 null，且 [isRoot] 为 true，则为 root 组。
  /// 若 [fragmentGroupAb] 为 null，且 [isRoot] 为 false，则传递为空。
  Future<void> init({required Ab<Fragment>? fragmentAb, required Ab<FragmentGroup>? fragmentGroupAb, bool isRoot = true}) async {
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

      if (contentStorage.currentValueAb() != null) {
        fragmentGizmoEditPageAbController.quillController.document = q.Document.fromJson(jsonDecode(contentStorage.currentValueAb()!));
      }
    }
  }

  /// 检查的碎片是否被修改。
  ///
  /// 若检查成功，则返回 null，否则返回失败消息。
  String? isDataModified() {
    if (current == null) {
      // 先保存
      contentStorage.currentValueAb.refreshEasy((oldValue) => jsonEncode(fragmentGizmoEditPageAbController.quillController.document.toDelta().toJson()));
      if (!isEqualContent(one: contentStorage.currentValueAb(), two: contentStorage.createValue)) {
        logger.d(contentStorage.currentValueAb());
        logger.d(contentStorage.createValue);
        return '存在修改内容';
      }
      if (!isEqualFragmentTemplate(one: selectedFragmentTemplateStorage.currentValueAb(), two: selectedFragmentTemplateStorage.createValue)) {
        return '存在修改内容：模板';
      }
      if (!isEqualFragmentGroupChains(one: selectedFragmentGroupChainsStorage.currentValueAb(), two: selectedFragmentGroupChainsStorage.createValue)) {
        return '存在修改内容：碎片组';
      }
    } else {
      if (!isEqualContent(one: contentStorage.currentValueAb(), two: contentStorage.saveValue)) {
        return '内容发生修改，请先保存！';
      }
      if (!isEqualFragmentTemplate(one: selectedFragmentTemplateStorage.currentValueAb(), two: selectedFragmentTemplateStorage.saveValue)) {
        return '模板发生了改变，请先保存！';
      }
      if (!isEqualFragmentGroupChains(one: selectedFragmentGroupChainsStorage.currentValueAb(), two: selectedFragmentGroupChainsStorage.saveValue)) {
        return '存放位置发生了改变，请先保存！';
      }
    }
    return null;
  }

  /// 跳转到已有的碎片。
  ///
  /// 返回值见 [isDataModified]。
  Future<String?> to({required Ab<Fragment>? fragmentAb}) async {
    final isDataModifiedResult = isDataModified();
    if (current != null) {
      if (isDataModifiedResult != null) return isDataModifiedResult;
    }

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
  Future<void> save() async {
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
      contentStorage
        ..saveValue = null
        ..createValue = null
        ..currentValueAb.refreshEasy((oldValue) => null);
      selectedFragmentTemplateStorage
        ..saveValue = null
        ..createValue = selectedFragmentTemplateStorage.currentValueAb();
      selectedFragmentGroupChainsStorage
        ..saveValue.clear()
        ..createValue.clear()
        ..createValue.addAll(selectedFragmentGroupChainsStorage.currentValueAb());
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
    required this.initFragmentAb,
    required this.initFragmentGroup,
    required this.initSomeBefore,
    required this.initSomeAfter,
  }) {
    if (initFragmentAb != null && initFragmentGroup != null) {
      throw '请看 initFragmentGroup 注释！';
    }
  }

  /// 仅用来初始化赋值，若没有的话为 []。
  final List<Ab<Fragment>> initSomeBefore;

  /// 仅用来初始化赋值，若没有的话为 []。
  final List<Ab<Fragment>> initSomeAfter;

  /// 仅用来初始化赋值，若为 null，则初始化时为创建。
  final Ab<Fragment>? initFragmentAb;

  /// 仅用来初始化赋值。
  ///
  /// 当 [initFragmentAb] 为 null 时，在某个组内进行创建组时，需要传递这个。
  /// 当 [initFragmentAb] 不为 null 时，内部会自行获取 [initFragmentGroup]，因此无需赋初始化值。
  final Ab<FragmentGroup>? initFragmentGroup;

  /// 用来记录操作的碎片，存放 [initSomeBefore]、[initFragmentAb]、[initSomeAfter] 的对象。
  ///
  /// 只允许存在一个元素为 null，否则检索 index 时只会检索到第一个 null。
  /// 而相同的 [Fragment] 并不是同一个 [FragmentAbAndFragmentGroupAb] 对象，所有不需要关心对象是否相同。
  final records = <Ab<Fragment>?>[].ab;

  /// 当前碎片的数据仓库。
  ///
  /// 根据 [records] 跳动。
  final CurrentPerformerStorage currentPerformer = CurrentPerformerStorage();

  final q.QuillController quillController = q.QuillController.basic();

  @override
  void onInit() {
    super.onInit();
    currentPerformer.fragmentGizmoEditPageAbController = this;
  }

  @override
  bool get isEnableLoading => true;

  @override
  Future<void> loadingFuture() async {
    records().addAll(initSomeBefore);
    records().add(initFragmentAb);
    records().addAll(initSomeAfter);
    records.refreshForce();
    await currentPerformer.init(fragmentAb: initFragmentAb, fragmentGroupAb: initFragmentGroup);
  }

  String richToJson() => jsonEncode(quillController.document.toDelta().toJson());

  String parseTitle() {
    final text = quillController.document.toPlainText().trim();
    return text.substring(0, text.length > 10 ? 11 : text.length);
  }

  Future<void> showSaveGroup() async {
    // await showSelectFragmentGroupDialog(selectedFragmentGroupChainAb: currentPerformer.selectedFragmentGroupChainsStorage.currentValueAb);
  }
}
