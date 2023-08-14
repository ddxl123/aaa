import 'package:aaa/single_dialog/showCreateFragmentGroupDialog.dart';
import 'package:aaa/single_dialog/showSelectFragmentGroupDialog.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:drift_main/drift/DriftDb.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tools/tools.dart';

/// [selectedDynamicFragmentGroup]：已选的碎片组，
Future<void> showSelectFragmentGroupsDialog({required List<FragmentGroup?> selectedDynamicFragmentGroup}) async {
  await showCustomDialog(builder: (_) => SelectFragmentGroupDialogWidget(selectedDynamicFragmentGroup: selectedDynamicFragmentGroup));
}

class SelectFragmentGroupDialogWidget extends StatefulWidget {
  const SelectFragmentGroupDialogWidget({Key? key, required this.selectedDynamicFragmentGroup}) : super(key: key);
  final List<FragmentGroup?> selectedDynamicFragmentGroup;

  @override
  State<SelectFragmentGroupDialogWidget> createState() => _SelectFragmentGroupDialogWidgetState();
}

class _SelectFragmentGroupDialogWidgetState extends State<SelectFragmentGroupDialogWidget> {
  List<Widget> _columnChildren() {
    return widget.selectedDynamicFragmentGroup.isEmpty
        ? [
            Row(
              children: [
                Expanded(
                  child: MaterialButton(
                    child: const Text('未选择位置'),
                    onPressed: () {},
                  ),
                )
              ],
            )
          ]
        : [
            ...widget.selectedDynamicFragmentGroup.map(
              (e) => Row(
                children: [
                  Expanded(
                    child: MaterialButton(
                      padding: EdgeInsets.zero,
                      child: Row(
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  Icon(Icons.circle, size: 8),
                                  // Text('> ${e.map((e) => e.title).join(' > ')}', style: const TextStyle(color: Colors.blue)),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                        ],
                      ),
                      onPressed: () async {
                        // await showSelectFragmentGroupDialog(
                        //   selectedDynamicFragmentGroupAb: Ab<FragmentGroup?>(e),
                        //   isWithFragments: false,
                        //   isOnlySelectSynced: true,
                        // );
                        if (mounted) setState(() {});
                      },
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.clear, color: Colors.red),
                    onPressed: () {
                      widget.selectedDynamicFragmentGroup.remove(e);
                      if (mounted) setState(() {});
                    },
                  ),
                ],
              ),
            ),
          ];
  }

  Future<void> _onOk() async {
    SmartDialog.showToast('选择成功！');
    SmartDialog.dismiss();
  }

  @override
  Widget build(BuildContext context) {
    return OkAndCancelDialogWidget(
      dialogSize: DialogSize(width: kDialogFixedWidth, height: null),
      title: '存放位置：',
      columnChildren: [
        ..._columnChildren(),
      ],
      topKeepWidget: Text("相同碎片可能被存放到多个位置", style: TextStyle(color: Colors.grey)),
      bottomKeepWidget: TextButton(
        style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Color.fromARGB(50, 30, 144, 255))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text('添加新位置 '),
            Icon(Icons.add),
          ],
        ),
        onPressed: () async {
          final result = Ab<FragmentGroup?>(null);
          // await showSelectFragmentGroupDialog(
          //   selectedDynamicFragmentGroupAb: result,
          //   isWithFragments: false,
          //   isOnlySelectSynced: true,
          // );
          if (result() == null) {
          } else {
            // widget.selectedDynamicFragmentGroup.add(result()!);
            if (mounted) setState(() {});
          }
        },
      ),
      okText: '确定',
      onOk: _onOk,
      crossAxisAlignment: CrossAxisAlignment.start,
    );
  }
}
