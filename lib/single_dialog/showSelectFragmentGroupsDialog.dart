import 'package:aaa/single_dialog/showCreateFragmentGroupDialog.dart';
import 'package:aaa/single_dialog/showSelectFragmentGroupDialog.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:drift_main/drift/DriftDb.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tools/tools.dart';

Future<void> showSelectFragmentGroupsDialog({required List<List<FragmentGroup>> selectedFragmentGroupChains}) async {
  await showCustomDialog(builder: (_) => SelectFragmentGroupDialogWidget(selectedFragmentGroupChains: selectedFragmentGroupChains));
}

class SelectFragmentGroupDialogWidget extends StatefulWidget {
  const SelectFragmentGroupDialogWidget({Key? key, required this.selectedFragmentGroupChains}) : super(key: key);
  final List<List<FragmentGroup>> selectedFragmentGroupChains;

  @override
  State<SelectFragmentGroupDialogWidget> createState() => _SelectFragmentGroupDialogWidgetState();
}

class _SelectFragmentGroupDialogWidgetState extends State<SelectFragmentGroupDialogWidget> {
  List<Widget> _columnChildren() {
    return widget.selectedFragmentGroupChains.isEmpty
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
            ...widget.selectedFragmentGroupChains.map(
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
                              child: Text('~ > ${e.map((e) => e.title).join(' > ')}', style: const TextStyle(color: Colors.blue)),
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Icon(Icons.edit, color: Colors.blue),
                        ],
                      ),
                      onPressed: () async {
                        await showSelectFragmentGroupDialog(selectedFragmentGroupChainAb: Ab<List<FragmentGroup>?>(e));
                        if (mounted) setState(() {});
                      },
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.clear, color: Colors.red),
                    onPressed: () {
                      widget.selectedFragmentGroupChains.remove(e);
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
          final result = Ab<List<FragmentGroup>?>(null);
          await showSelectFragmentGroupDialog(selectedFragmentGroupChainAb: result);
          if (result() == null) {
          } else {
            widget.selectedFragmentGroupChains.add(result()!);
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
