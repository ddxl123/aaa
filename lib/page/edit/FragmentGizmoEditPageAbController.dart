import 'dart:convert';

import 'package:aaa/global/GlobalAbController.dart';
import 'package:aaa/single_dialog/showSelectFragmentGroupDialog.dart';
import 'package:drift_main/drift/DriftDb.dart';
import 'package:flutter_quill/flutter_quill.dart' as q;
import 'package:tools/tools.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class FragmentPerformer {
  FragmentPerformer({required this.fragmentAb});

  /// 为 null 表示创建模式，否则为阅读或修改模式。
  final Ab<Fragment>? fragmentAb;

  /// 当前操作碎片的内容，只是用来存储创建模式时的内容，其他模式都是用 document 中提取。
  String content = '';

  /// 当前操作碎片所存放的碎片组位置。
  List<List<FragmentGroup>> fragmentGroupChains = [];

  /// 当前操作碎片所使用的模板。
  FragmentTemplate? fragmentTemplate;

  Future<String?> isExistModified({required FragmentGizmoEditPageAbController fragmentGizmoEditPageAbController}) async {
    final isEqualContentOk = isEqualContent(fragmentGizmoEditPageAbController: fragmentGizmoEditPageAbController);
    final isEqualFragmentGroupChainsOk = await isEqualFragmentGroupChains(fragmentGizmoEditPageAbController: fragmentGizmoEditPageAbController);
    final isEqualFragmentTemplateOk = await isEqualFragmentTemplate();
    if (!isEqualContentOk) {
      return '内容存在修改！';
    }
    if (!isEqualFragmentGroupChainsOk) {
      return '碎片组存在修改！';
    }
    if (!isEqualFragmentTemplateOk) {
      return '碎片模型存在修改！';
    }
    return null;
  }

  Future<void> reload({required FragmentGizmoEditPageAbController fragmentGizmoEditPageAbController}) async {
    if (fragmentAb != null) {
      content = fragmentAb!().content;
      fragmentGizmoEditPageAbController.quillController.document = q.Document.fromJson(jsonDecode(content));

      final chains = await db.generalQueryDAO.queryFragmentInWhichFragmentGroupChain(fragment: fragmentAb!());
      fragmentGroupChains.clear();
      fragmentGroupChains.addAll(chains);

      fragmentTemplate = await db.generalQueryDAO.queryFragmentTemplateById(fragmentTemplateId: fragmentAb!().fragmentTemplateId!);
    }
  }

  /// 若返回空表示数据没有变化。
  Future<Fragment?> save({required FragmentGizmoEditPageAbController fragmentGizmoEditPageAbController}) async {
    // TODO: 检查是否可以进行保存。
    if (fragmentAb == null) {
      final newFragment = await db.insertDAO.insertFragment(
        willFragmentsCompanion: Crt.fragmentsCompanion(
          content: content,
          creatorUserId: Aber.find<GlobalAbController>().loggedInUser()!.id,
          fatherFragmentId: null.toValue(),
          fragmentTemplateId: (fragmentTemplate?.id).toValue(),
          local_isSelected: false,
          noteId: null.toValue(),
          title: fragmentGizmoEditPageAbController.parseTitle(),
        ),
        whichFragmentGroups: fragmentGroupChains.map((e) => e.isEmpty ? null : e.last).toList(),
        syncTag: null,
      );
      return newFragment;
    } else {
      await db.updateDAO.resetFragment(
        originalFragmentReset: (st) async {
          return await fragmentAb!().reset(
            content: content.toValue(),
            creatorUserId: toAbsent(),
            fatherFragmentId: toAbsent(),
            fragmentTemplateId: fragmentTemplate!.id.toValue(),
            local_isSelected: toAbsent(),
            noteId: toAbsent(),
            title: fragmentGizmoEditPageAbController.parseTitle().toValue(),
            syncTag: st,
          );
        },
        syncTag: null,
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

    final nowT = now == '' ? '[{"insert":"\\n"}]' : now;
    final savedT = saved == '' ? '[{"insert":"\\n"}]' : saved;
    return nowT == savedT;
  }

  Future<bool> isEqualFragmentTemplate() async {
    final FragmentTemplate? now;
    final FragmentTemplate? saved;
    if (fragmentAb != null) {
      now = fragmentTemplate;
      saved = await db.generalQueryDAO.queryFragmentTemplateById(fragmentTemplateId: fragmentAb!().fragmentTemplateId!);
    } else {
      now = fragmentTemplate;
      saved = null;
    }
    return now?.id == saved?.id;
  }

  Future<bool> isEqualFragmentGroupChains({required FragmentGizmoEditPageAbController fragmentGizmoEditPageAbController}) async {
    final List<List<FragmentGroup>> now;
    final List<List<FragmentGroup>> saved;
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
      final nowResult = now[i].map((e) => e.id).join('');
      final savedResult = saved[i].map((e) => e.id).join('');
      if (nowResult != savedResult) {
        return false;
      }
    }
    return true;
  }

// /// 初始化。
// /// 若 [fragmentGroupAb] 为 null，且 [isRoot] 为 true，则为 root 组。
// /// 若 [fragmentGroupAb] 为 null，且 [isRoot] 为 false，则传递为空。
// Future<void> init({required Ab<Fragment>? fragmentAb, required Ab<FragmentGroup>? fragmentGroupAb, bool isRoot = true}) async {
//   current = fragmentAb;
//   if (current == null) {
//     contentStorage
//       ..createValue = null
//       ..saveValue = null
//       ..currentValueAb.refreshEasy((oldValue) => null);
//
//     selectedFragmentTemplateStorage
//       ..createValue = null
//       ..saveValue = null
//       ..currentValueAb.refreshEasy((oldValue) => null);
//
//     selectedFragmentGroupChainsStorage
//       ..createValue.clear()
//       ..saveValue.clear()
//       ..currentValueAb.refreshEasy((oldValue) => oldValue..clear());
//     if (fragmentGroupAb != null) {
//       final chain = await db.generalQueryDAO.queryFragmentGroupInWhichFragmentGroupChain(fragmentGroup: fragmentGroupAb());
//       selectedFragmentGroupChainsStorage.createValue.add(chain);
//       selectedFragmentGroupChainsStorage.currentValueAb.refreshEasy((oldValue) => oldValue..add(chain));
//     }
//   } else {
//     contentStorage
//       ..createValue = null
//       ..saveValue = fragmentAb!().content
//       ..currentValueAb.refreshEasy((oldValue) => fragmentAb().content);
//
//     FragmentTemplate? ft;
//     if (current!().fragmentTemplateId != null) {
//       ft = await db.generalQueryDAO.queryFragmentTemplateById(fragmentTemplateId: current!().fragmentTemplateId!);
//     }
//     selectedFragmentTemplateStorage
//       ..createValue = null
//       ..saveValue = ft
//       ..currentValueAb.refreshEasy((oldValue) => ft);
//
//     final chains = await db.generalQueryDAO.queryFragmentInWhichFragmentGroupChain(fragment: current!());
//     selectedFragmentGroupChainsStorage
//       ..createValue.clear()
//       ..saveValue.clear()
//       ..saveValue.addAll(chains)
//       ..currentValueAb.refreshEasy((oldValue) => oldValue
//         ..clear()
//         ..addAll(chains));
//
//     if (contentStorage.currentValueAb() != null) {
//       fragmentGizmoEditPageAbController.quillController.document = q.Document.fromJson(jsonDecode(contentStorage.currentValueAb()!));
//     }
//   }
// }
//
// /// 检查的碎片是否被修改。
// ///
// /// 若检查成功，则返回 null，否则返回失败消息。
// String? isDataModified() {
//   if (current == null) {
//     // 先保存
//     contentStorage.currentValueAb.refreshEasy((oldValue) => jsonEncode(fragmentGizmoEditPageAbController.quillController.document.toDelta().toJson()));
//     if (!isEqualContent(one: contentStorage.currentValueAb(), two: contentStorage.createValue)) {
//       return '存在修改内容';
//     }
//     if (!isEqualFragmentTemplate(one: selectedFragmentTemplateStorage.currentValueAb(), two: selectedFragmentTemplateStorage.createValue)) {
//       return '存在修改内容：模板';
//     }
//     if (!isEqualFragmentGroupChains(one: selectedFragmentGroupChainsStorage.currentValueAb(), two: selectedFragmentGroupChainsStorage.createValue)) {
//       return '存在修改内容：碎片组';
//     }
//   } else {
//     if (!isEqualContent(one: contentStorage.currentValueAb(), two: contentStorage.saveValue)) {
//       return '内容发生修改，请先保存！';
//     }
//     if (!isEqualFragmentTemplate(one: selectedFragmentTemplateStorage.currentValueAb(), two: selectedFragmentTemplateStorage.saveValue)) {
//       return '模板发生了改变，请先保存！';
//     }
//     if (!isEqualFragmentGroupChains(one: selectedFragmentGroupChainsStorage.currentValueAb(), two: selectedFragmentGroupChainsStorage.saveValue)) {
//       return '存放位置发生了改变，请先保存！';
//     }
//   }
//   return null;
// }
//
// /// 跳转到已有的碎片。
// ///
// /// 返回值见 [isDataModified]。
// Future<String?> to({required Ab<Fragment>? fragmentAb}) async {
//   final isDataModifiedResult = isDataModified();
//   if (current != null) {
//     if (isDataModifiedResult != null) return isDataModifiedResult;
//   }
//
//   current = fragmentAb;
//
//   if (current == null) {
//     contentStorage.currentValueAb.refreshEasy((oldValue) => contentStorage.createValue);
//
//     selectedFragmentTemplateStorage.currentValueAb.refreshEasy((oldValue) => selectedFragmentTemplateStorage.createValue);
//
//     selectedFragmentGroupChainsStorage.currentValueAb.refreshEasy((oldValue) => oldValue
//       ..clear()
//       ..addAll(selectedFragmentGroupChainsStorage.createValue));
//   } else {
//     contentStorage
//       ..saveValue = fragmentAb!().content
//       ..currentValueAb.refreshEasy((oldValue) => fragmentAb().content);
//
//     FragmentTemplate? ft;
//     if (current!().fragmentTemplateId != null) {
//       ft = await db.generalQueryDAO.queryFragmentTemplateById(fragmentTemplateId: current!().fragmentTemplateId!);
//     }
//     selectedFragmentTemplateStorage
//       ..saveValue = ft
//       ..currentValueAb.refreshEasy((oldValue) => ft);
//
//     final chains = await db.generalQueryDAO.queryFragmentInWhichFragmentGroupChain(fragment: current!());
//     selectedFragmentGroupChainsStorage
//       ..saveValue.clear()
//       ..saveValue.addAll(chains)
//       ..currentValueAb.refreshEasy((oldValue) => oldValue
//         ..clear()
//         ..addAll(chains));
//   }
//
//   return null;
// }
//
// /// 保存修改，或者保存创建且自动下一个创建。
// ///
// /// 保存创建时，会跳到下一个创建。
// ///
// /// 保存修改时，不会跳到下一个。
// Future<void> save() async {
//   if (current == null) {
//     final newFragment = await db.insertDAO.insertFragment(
//       willFragmentsCompanion: Crt.fragmentsCompanion(
//         content: contentStorage.currentValueAb() ?? '',
//         creatorUserId: Aber.find<GlobalAbController>().loggedInUser()!.id,
//         fatherFragmentId: null.toValue(),
//         fragmentTemplateId: (selectedFragmentTemplateStorage.currentValueAb()?.id).toValue(),
//         local_isSelected: false,
//         noteId: null.toValue(),
//         title: fragmentGizmoEditPageAbController.parseTitle(),
//       ),
//       whichFragmentGroups: selectedFragmentGroupChainsStorage.currentValueAb().map((e) => e.isEmpty ? null : e.last).toList(),
//       syncTag: null,
//     );
//     fragmentGizmoEditPageAbController.records.refreshEasy(
//       (oldValue) {
//         final index = oldValue.indexOf(null);
//         oldValue.replaceRange(index, index + 1, [newFragment.ab]);
//         oldValue.add(null);
//         return oldValue;
//       },
//     );
//     current = null;
//     contentStorage
//       ..saveValue = null
//       ..createValue = null
//       ..currentValueAb.refreshEasy((o ldValue) => null);
//     selectedFragmentTemplateStorage
//       ..saveValue = null
//       ..createValue = selectedFragmentTemplateStorage.currentValueAb();
//     selectedFragmentGroupChainsStorage
//       ..saveValue.clear()
//       ..createValue.clear()
//       ..createValue.addAll(selectedFragmentGroupChainsStorage.currentValueAb());
//   } else {
//     final isDataModifiedMessage = isDataModified();
//     if (isDataModifiedMessage == null) {
//       throw '数据没有被修改，但却调用了存储函数！';
//     }
//     await db.updateDAO.resetFragment(
//       originalFragmentReset: (st) async {
//         return await current!().reset(
//           content: contentStorage.currentValueAb()!.toValue(),
//           creatorUserId: toAbsent(),
//           fatherFragmentId: toAbsent(),
//           fragmentTemplateId: selectedFragmentTemplateStorage.currentValueAb()!.id.toValue(),
//           local_isSelected: toAbsent(),
//           noteId: toAbsent(),
//           title: fragmentGizmoEditPageAbController.parseTitle().toValue(),
//           syncTag: st,
//         );
//       },
//       syncTag: null,
//     );
//     current!.refreshForce();
//   }
// }
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
  final records = <FragmentPerformer>[].ab;

  /// 当前碎片的数据仓库。
  ///
  /// 根据 [records] 跳动。
  final currentPerformer = Ab<FragmentPerformer?>(null);

  final q.QuillController quillController = q.QuillController.basic();

  @override
  bool get isEnableLoading => true;

  @override
  Future<void> loadingFuture() async {
    final current = FragmentPerformer(fragmentAb: initFragmentAb);
    await current.reload(fragmentGizmoEditPageAbController: this);

    records().addAll(initSomeBefore.map((e) => FragmentPerformer(fragmentAb: e)));
    records().add(current);
    records().addAll(initSomeAfter.map((e) => FragmentPerformer(fragmentAb: e)));

    currentPerformer.refreshEasy((oldValue) => current);
    records.refreshForce();
  }

  String richToJson() => jsonEncode(quillController.document.toDelta().toJson());

  String parseTitle() {
    final text = quillController.document.toPlainText().trim();
    return text.substring(0, text.length > 10 ? 11 : text.length);
  }

  bool isExistLast([Abw? abw]) {
    final currentIndex = records(abw).indexOf(currentPerformer(abw)!);
    if (currentIndex == 0) {
      return false;
    }
    return true;
  }

  bool isExistNext([Abw? abw]) {
    final currentIndex = records(abw).indexOf(currentPerformer(abw)!);
    if (currentIndex == records().length - 1) {
      return false;
    }
    return true;
  }

  /// 当 [lastOrNext] 为 0 时，进入到上一个，否则进入到下一个。
  Future<void> goTo({required int lastOrNext}) async {
    if (!records().contains(currentPerformer()!)) {
      throw '记录不包含当前碎片，无法获取 index！';
    }
    final currentIndex = records().indexOf(currentPerformer()!);
    if (lastOrNext == 0) {
      if (currentIndex == 0) return;
      // 先检查
      final modifyMessage = await currentPerformer()!.isExistModified(fragmentGizmoEditPageAbController: this);
      if (modifyMessage != null) {
        if (currentPerformer()!.fragmentAb != null) {
          SmartDialog.showToast(modifyMessage);
          return;
        } else {
          currentPerformer()!.content = richToJson();
        }
      }
      // 再加载
      final last = records()[currentIndex - 1];
      await last.reload(fragmentGizmoEditPageAbController: this);
      // 后重建
      currentPerformer.refreshEasy((oldValue) => last);
    } else {
      if (currentIndex == records().length - 1) return;
      // 先检查
      final modifyMessage = await currentPerformer()!.isExistModified(fragmentGizmoEditPageAbController: this);
      if (modifyMessage != null) {
        if (currentPerformer()!.fragmentAb != null) {
          SmartDialog.showToast(modifyMessage);
          return;
        } else {
          currentPerformer()!.content = richToJson();
        }
      }
      // 先加载
      final next = records()[currentIndex + 1];
      await next.reload(fragmentGizmoEditPageAbController: this);
      // 后重建
      currentPerformer.refreshEasy((oldValue) => next);
    }
  }

  Future<void> saveOrNext() async {
    final result = await currentPerformer()!.save(fragmentGizmoEditPageAbController: this);
    if (currentPerformer()!.fragmentAb == null) {
      currentPerformer()!.fragmentAb = result;
      SmartDialog.showToast('保存成功！');
    } else {
      SmartDialog.showToast('修改成功！');
    }
  }

  Future<void> showSaveGroup() async {
    // await showSelectFragmentGroupDialog(selectedFragmentGroupChainAb: currentPerformer.selectedFragmentGroupChainsStorage.currentValueAb);
  }
}
