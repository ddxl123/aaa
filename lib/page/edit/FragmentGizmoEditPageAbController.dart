import 'dart:convert';

import 'package:aaa/global/GlobalAbController.dart';
import 'package:aaa/single_dialog/showSelectFragmentGroupDialog.dart';
import 'package:drift_main/drift/DriftDb.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_quill/flutter_quill.dart' as q;
import 'package:tools/tools.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class FragmentAbAndFragmentGroupAb {
  FragmentAbAndFragmentGroupAb({required this.fragmentAb, required this.fragmentGroupAb,});

  final Ab<Fragment> fragmentAb;
  final Ab<FragmentGroup> fragmentGroupAb;
}

class FragmentGizmoEditPageAbController extends AbController {
  FragmentGizmoEditPageAbController({
    required this.currentPerformer,
    required this.initSomeBefore,
    required this.initSomeAfter,
  });

  /// 若没有的话为 []。
  final List<Ab<Fragment>> initSomeBefore;

  /// 若没有的话为 []。
  final List<Ab<Fragment>> initSomeAfter;

  /// 用来记录操作的碎片。
  final fragmentRecord = <Ab<Fragment?>>[].ab;

  /// 当前操作的碎片，及其所属的碎片组。
  ///
  /// 若为 null，则当前为创建碎片的操作。
  final FragmentAbAndFragmentGroupAb? currentPerformer;

  late final q.QuillController quillController;

  /// 当前操作碎片所存放的碎片组位置。
  final selectedFragmentGroupChainAb = Ab<List<FragmentGroup>?>(null);

  /// 当前操作碎片所使用的模板。
  final selectedFragmentTemplateAb = Ab<FragmentTemplate?>(null);

  @override
  void onInit() {
    super.onInit();
    _init();
  }

  Future<void> _init() async {
    fragmentRecord().addAll(initSomeBefore);
    fragmentRecord().add(currentPerformer?.fragmentAb ?? Ab(null));
    fragmentRecord().addAll(initSomeAfter);
    fragmentRecord.refreshForce();

    if (currentPerformer == null) {
      selectedFragmentGroupChainAb.refreshEasy((oldValue) => null);
      selectedFragmentTemplateAb.refreshEasy((oldValue) => null);
    } else {
      await db.generalQueryDAO.queryFragmentInWhichFragmentGroupChain(rFragment2FragmentGroup: rFragment2FragmentGroup)
      selectedFragmentGroupChainAb.refreshEasy((oldValue) =>)
    }
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
    await showSelectFragmentGroupDialog(selectedFragmentGroupChainAb: selectedFragmentGroupChainAb);
  }

  Future<void> create() async {
    if (currentFragmentAb != null) {
      throw '碎片已存在，但却调用了创建函数！';
    }
    if (selectedFragmentGroupChainAb() == null) {
      SmartDialog.showToast('请选择存放位置！');
      return;
    }
    await db.insertDAO.insertFragment(
      willFragmentsCompanion: Crt.fragmentsCompanion(
        content: richToJson(),
        creatorUserId: Aber.find<GlobalAbController>().loggedInUser()!.id,
        fatherFragmentId: null.toValue(),
        fragmentTemplateId: (selectedFragmentTemplateAb()?.id).toValue(),
        local_isSelected: false,
        noteId: null.toValue(),
        title: parseTitle(),
      ),
      whichFragmentGroup: selectedFragmentGroupChainAb()!.last,
      syncTag: null,
    );

    SmartDialog.showToast('保存成功！');
  }
}
