import 'package:aaa/single_dialog/showCreateFragmentGroupDialog.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:drift_main/drift/DriftDb.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:tools/tools.dart';

Future<void> showSelectFragmentGroupDialog({required Ab<List<FragmentGroup>?> selectedFragmentGroupChainAb}) async {
  await showCustomDialog(builder: (_) => SelectFragmentGroupDialogWidget(selectedFragmentGroupChainAb: selectedFragmentGroupChainAb));
}

class SelectFragmentGroupDialogWidget extends StatefulWidget {
  const SelectFragmentGroupDialogWidget({Key? key, required this.selectedFragmentGroupChainAb}) : super(key: key);
  final Ab<List<FragmentGroup>?> selectedFragmentGroupChainAb;

  @override
  State<SelectFragmentGroupDialogWidget> createState() => _SelectFragmentGroupDialogWidgetState();
}

class _SelectFragmentGroupDialogWidgetState extends State<SelectFragmentGroupDialogWidget> {
  final groupChain = <FragmentGroup>[];
  final currentFragment = <Fragment>[];
  final currentFragmentGroup = <FragmentGroup>[];

  @override
  void dispose() {
    groupChain.clear();
    currentFragment.clear();
    currentFragmentGroup.clear();
    BackButtonInterceptor.remove(_homeBack);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    BackButtonInterceptor.add(_homeBack, context: context);
    groupChain.addAll(widget.selectedFragmentGroupChainAb() ?? []);
    refreshPage();
  }

  /// 注意按照顺序。
  ///
  /// 返回 true 则拦截，否则不拦截，拦截意味着当前 route 不触发 pop。
  Future<bool> _homeBack(bool stopDefaultButtonEvent, RouteInfo routeInfo) async {
    if (groupChain.isEmpty) {
      return false;
    }
    groupChain.removeLast();
    if (groupChain.isEmpty) {
      enter(whichFragmentGroup: null);
    } else {
      enter(whichFragmentGroup: groupChain.last);
    }
    return true;
  }

  Future<void> enter({required FragmentGroup? whichFragmentGroup}) async {
    if (whichFragmentGroup == null) {
      groupChain.clear();
      await refreshPage();
      return;
    }

    final index = groupChain.indexOf(whichFragmentGroup);
    if (index != -1) {
      final newGroupChain = groupChain.sublist(0, index + 1);
      groupChain.clear();
      groupChain.addAll(newGroupChain);
      await refreshPage();
      return;
    }

    groupChain.add(whichFragmentGroup);
    await refreshPage();
  }

  Future<void> refreshPage() async {
    currentFragmentGroup.clear();
    currentFragment.clear();
    currentFragmentGroup.addAll(
      (await db.generalQueryDAO.queryFragmentGroupsInFragmentGroupById(targetFragmentGroupId: groupChain.isEmpty ? null : groupChain.last.id)).map((e) => e.fragmentGroup),
    );
    currentFragment.addAll(
      await db.generalQueryDAO.queryFragmentsInFragmentGroupById(targetFragmentGroupId: groupChain.isEmpty ? null : groupChain.last.id),
    );
    if (mounted) setState(() {});
  }

  Widget _topRightAction() {
    return IconButton(
      icon: const Icon(Icons.add),
      style: ButtonStyle(padding: MaterialStateProperty.all(EdgeInsets.zero), tapTargetSize: MaterialTapTargetSize.shrinkWrap),
      onPressed: () async {
        await showCreateFragmentGroupDialog(fragmentGroup: groupChain.isEmpty ? null : groupChain.last);
        await refreshPage();
      },
    );
  }

  Widget _topKeepWidget() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
      reverse: true,
      child: Row(
        children: [
          TextButton(
            child: const Text('~>'),
            onPressed: () {
              enter(whichFragmentGroup: null);
            },
          ),
          ...groupChain.isEmpty
              ? []
              : groupChain
                  .map(
                    (e) => TextButton(
                      child: Text('${e.title}>'),
                      onPressed: () {
                        enter(whichFragmentGroup: e);
                      },
                    ),
                  )
                  .toList(),
        ],
      ),
    );
  }

  List<Widget> _columnChildren() {
    return currentFragment.isEmpty && currentFragmentGroup.isEmpty
        ? [
            Row(
              children: [
                Expanded(
                  child: MaterialButton(
                    child: const Text('什么都没有~'),
                    onPressed: () {},
                  ),
                )
              ],
            )
          ]
        : [
            ...currentFragmentGroup.map(
              (e) => Row(
                children: [
                  Expanded(
                    child: TextButton(
                      child: Text(e.title),
                      onPressed: () {
                        enter(whichFragmentGroup: e);
                      },
                    ),
                  ),
                ],
              ),
            ),
            ...currentFragment.map(
              (e) => Row(
                children: [
                  Expanded(
                    child: MaterialButton(
                      child: Text(e.title),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          ];
  }

  Future<void> _onOk() async {
    widget.selectedFragmentGroupChainAb()?.clear();
    widget.selectedFragmentGroupChainAb.refreshEasy((oldValue) => (oldValue ?? [])..addAll(groupChain.map((e) => e.copyWith()).toList()));
    widget.selectedFragmentGroupChainAb.refreshForce();
    SmartDialog.showToast('选择成功！');
    SmartDialog.dismiss();
  }

  @override
  Widget build(BuildContext context) {
    return OkAndCancelDialogWidget(
      title: '选择位置：',
      topRightAction: _topRightAction(),
      columnChildren: _columnChildren(),
      cancelText: '取消',
      okText: '确定',
      onCancel: () async {
        SmartDialog.dismiss();
      },
      onOk: _onOk,
      topKeepWidget: _topKeepWidget(),
      crossAxisAlignment: CrossAxisAlignment.start,
    );
  }
}
