// import 'package:aaa/single_dialog/showCreateFragmentGroupDialog.dart';
// import 'package:back_button_interceptor/back_button_interceptor.dart';
// import 'package:drift_main/drift/DriftDb.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
// import 'package:tools/tools.dart';
//
// /// [selectedDynamicFragmentGroupAb] 表示将要选择的碎片组。
// ///   - bool: 是否取消选择。
// ///   - FragmentGroup：为 null 时，表示 root
// Future<void> showSelectFragmentGroupDialog({
//   required Ab<(bool, FragmentGroup?)> selectedDynamicFragmentGroupAb,
//   required bool isWithFragments,
//   required bool isOnlySelectSynced,
// }) async {
//   await showCustomDialog(
//     builder: (_) => SelectFragmentGroupDialogWidget(
//       selectedDynamicFragmentGroupAb: selectedDynamicFragmentGroupAb,
//       isWithFragments: isWithFragments,
//       isOnlySelectSynced: isOnlySelectSynced,
//     ),
//   );
// }
//
// class SelectFragmentGroupDialogWidget extends StatefulWidget {
//   const SelectFragmentGroupDialogWidget({
//     Key? key,
//     required this.selectedDynamicFragmentGroupAb,
//     required this.isWithFragments,
//     required this.isOnlySelectSynced,
//   }) : super(key: key);
//   final Ab<(bool, FragmentGroup?)> selectedDynamicFragmentGroupAb;
//   final bool isWithFragments;
//   final bool isOnlySelectSynced;
//
//   @override
//   State<SelectFragmentGroupDialogWidget> createState() => _SelectFragmentGroupDialogWidgetState();
// }
//
// class _SelectFragmentGroupDialogWidgetState extends State<SelectFragmentGroupDialogWidget> {
//   final groupChain = <FragmentGroup>[];
//   final fragments = <Fragment>[];
//   final fragmentGroups = <FragmentGroup>[];
//   final fragmentGroupIsSyncedMap = <FragmentGroup, bool>{};
//   final scrollController = ScrollController();
//
//   @override
//   void dispose() {
//     groupChain.clear();
//     fragments.clear();
//     fragmentGroups.clear();
//     BackButtonInterceptor.remove(_homeBack);
//     super.dispose();
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     BackButtonInterceptor.add(_homeBack, context: context);
//     refreshPage();
//   }
//
//   /// 注意按照顺序。
//   ///
//   /// 返回 true 则拦截，否则不拦截，拦截意味着当前 route 不触发 pop。
//   Future<bool> _homeBack(bool stopDefaultButtonEvent, RouteInfo routeInfo) async {
//     if (groupChain.isEmpty) {
//       return false;
//     }
//     groupChain.removeLast();
//     if (groupChain.isEmpty) {
//       enter(whichFragmentGroup: null);
//     } else {
//       enter(whichFragmentGroup: groupChain.last);
//     }
//     return true;
//   }
//
//   Future<void> enter({required FragmentGroup? whichFragmentGroup}) async {
//     if (whichFragmentGroup == null) {
//       groupChain.clear();
//       await refreshPage();
//       return;
//     }
//
//     final index = groupChain.indexOf(whichFragmentGroup);
//     if (index != -1) {
//       final newGroupChain = groupChain.sublist(0, index + 1);
//       groupChain.clear();
//       groupChain.addAll(newGroupChain);
//       await refreshPage();
//       return;
//     }
//
//     groupChain.add(whichFragmentGroup);
//     await refreshPage();
//
//     Future.delayed(Duration(milliseconds: 100), () {
//       scrollController.animateTo(
//         scrollController.position.maxScrollExtent,
//         duration: const Duration(milliseconds: 500),
//         curve: Curves.easeOutCirc,
//       );
//     });
//   }
//
//   Future<void> refreshPage() async {
//     fragmentGroups.clear();
//     fragments.clear();
//     fragmentGroups.addAll(
//       await db.generalQueryDAO.queryFragmentGroupsInFragmentGroupById(surfaceFragmentGroup: groupChain.isEmpty ? null : groupChain.last),
//     );
//     if (widget.isWithFragments) {
//       final fs = await db.generalQueryDAO.queryFragmentsInFragmentGroupById(surfaceFragmentGroup: groupChain.isEmpty ? null : groupChain.last, set: {});
//       fragments.addAll(fs.values.map((e) => e.$1));
//     }
//     _taskIsSynced().ignore();
//     if (mounted) setState(() {});
//   }
//
//   Future<void> _taskIsSynced() async {
//     await Future.forEach<FragmentGroup>(
//       fragmentGroups,
//       (element) async {
//         final result = await db.generalQueryDAO.queryFragmentGroupIsSynced(fragmentGroupId: element.id);
//         fragmentGroupIsSyncedMap[element] = result;
//         setState(() {});
//       },
//     );
//   }
//
//   Widget _topRightAction() {
//     return IconButton(
//       icon: const Icon(Icons.add),
//       style: ButtonStyle(padding: MaterialStateProperty.all(EdgeInsets.zero), tapTargetSize: MaterialTapTargetSize.shrinkWrap),
//       onPressed: () async {
//         await showCreateFragmentGroupDialog(dynamicGroupEntity: groupChain.isEmpty ? null : groupChain.last);
//         await refreshPage();
//       },
//     );
//   }
//
//   Widget _topKeepWidget() {
//     return Container(
//       height: kMinInteractiveDimension,
//       child: ListView.separated(
//         controller: scrollController,
//         shrinkWrap: true,
//         scrollDirection: Axis.horizontal,
//         physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
//         itemCount: groupChain.length + 1,
//         itemBuilder: (BuildContext context, int index) {
//           return Row(
//             children: [
//               TextButton(
//                 style: ButtonStyle(
//                   visualDensity: kMinVisualDensity,
//                 ),
//                 child: Text(
//                   index == 0 ? '~' : groupChain[index - 1].title,
//                   style: TextStyle(color: (index == 0 || fragmentGroupIsSyncedMap[groupChain[index - 1]] == true) ? null : Colors.grey),
//                 ),
//                 onPressed: () async {
//                   await enter(whichFragmentGroup: index == 0 ? null : groupChain[index - 1]);
//                 },
//               ),
//             ],
//           );
//         },
//         separatorBuilder: (BuildContext context, int index) {
//           return Icon(Icons.chevron_right);
//         },
//       ),
//     );
//   }
//
//   List<Widget> _columnChildren() {
//     return fragments.isEmpty && fragmentGroups.isEmpty
//         ? [
//             Row(
//               children: [
//                 Expanded(
//                   child: MaterialButton(
//                     child: const Text('什么都没有~'),
//                     onPressed: () {},
//                   ),
//                 )
//               ],
//             )
//           ]
//         : [
//             ...fragmentGroups.map(
//               (e) => Row(
//                 children: [
//                   Expanded(
//                     child: TextButton(
//                       child: Text(
//                         e.title,
//                         style: TextStyle(color: fragmentGroupIsSyncedMap[e] == true ? null : Colors.grey),
//                       ),
//                       onPressed: () {
//                         enter(whichFragmentGroup: e);
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             ...fragments.map(
//               (e) => Row(
//                 children: [
//                   Expanded(
//                     child: MaterialButton(
//                       child: Text(e.title),
//                       onPressed: () {},
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ];
//   }
//
//   Future<void> _onOk() async {
//     if (widget.isOnlySelectSynced && groupChain.isNotEmpty && fragmentGroupIsSyncedMap[groupChain.last] == false) {
//       logger.outNormal(show: "不能选择未上传的碎片组！");
//       return;
//     }
//     if (widget.selectedDynamicFragmentGroupAb == null) {}
//     widget.selectedDynamicFragmentGroupAb?.refreshEasy(
//       (oldValue) => (oldValue ?? [])..addAll(groupChain.map((e) => e.copyWith()).toList()),
//     );
//     logger.outNormal(show: "选择成功！");
//     SmartDialog.dismiss();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return OkAndCancelDialogWidget(
//       dialogSize: DialogSize(width: kDialogFixedWidth, height: null),
//       title: '选择位置：',
//       topRightAction: _topRightAction(),
//       columnChildren: _columnChildren(),
//       cancelText: '取消',
//       okText: '确定',
//       onCancel: () async {
//         widget.selectedDynamicFragmentGroupAb.refreshEasy((oldValue) => (true, null));
//         SmartDialog.dismiss();
//       },
//       onOk: _onOk,
//       topKeepWidget: _topKeepWidget(),
//       crossAxisAlignment: CrossAxisAlignment.start,
//     );
//   }
// }
