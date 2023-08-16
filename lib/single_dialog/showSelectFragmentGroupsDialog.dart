import 'package:aaa/page/list/FragmentGroupListPageController.dart';
import 'package:aaa/push_page/push_page.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:drift_main/drift/DriftDb.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tools/tools.dart';

/// [selectedDynamicFragmentGroup]：已选的碎片组，
Future<void> showSelectFragmentGroupsDialog({required List<(FragmentGroup?, RFragment2FragmentGroup?)> selectedDynamicFragmentGroup}) async {
  await showCustomDialog(builder: (_) => SelectFragmentGroupDialogWidget(selectedDynamicFragmentGroup: selectedDynamicFragmentGroup));
}

class SelectFragmentGroupDialogWidget extends StatefulWidget {
  const SelectFragmentGroupDialogWidget({Key? key, required this.selectedDynamicFragmentGroup}) : super(key: key);
  final List<(FragmentGroup?, RFragment2FragmentGroup?)> selectedDynamicFragmentGroup;

  @override
  State<SelectFragmentGroupDialogWidget> createState() => _SelectFragmentGroupDialogWidgetState();
}

class _SelectFragmentGroupDialogWidgetState extends State<SelectFragmentGroupDialogWidget> {
  @override
  Widget build(BuildContext context) {
    return OkAndCancelDialogWidget(
      dialogSize: DialogSize(width: kDialogFixedWidth, height: null),
      title: '存放位置：(已选 ${widget.selectedDynamicFragmentGroup.length} 处)',
      columnChildren: [
        ...widget.selectedDynamicFragmentGroup.isEmpty
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
                  (e) => MaterialButton(
                    padding: EdgeInsets.zero,
                    child: Row(
                      children: [
                        e.$1 == null
                            ? Icon(Icons.circle, size: 8)
                            : Expanded(
                                child: Text(
                                  e.$1!.title,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                      ],
                    ),
                    onPressed: () async {
                      showCustomDialog(
                        builder: (ctx) {
                          return OkAndCancelDialogWidget(
                            title: "是否移除？",
                            cancelText: "返回",
                            okText: "移除",
                            onOk: () async {
                              widget.selectedDynamicFragmentGroup.remove(e);
                              setState(() {});
                              SmartDialog.dismiss(status: SmartStatus.dialog);
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
      ],
      topKeepWidget: Text("相同碎片可以被存放到多个位置", style: TextStyle(color: Colors.grey)),
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
          final result = await pushToFragmentGroupSelectView(context: context);
          if (result != null) {
            widget.selectedDynamicFragmentGroup.add((result.$1, null));
            setState(() {});
          }
        },
      ),
      okText: '确定',
      onOk: () {
        SmartDialog.dismiss(status: SmartStatus.dialog);
      },
      crossAxisAlignment: CrossAxisAlignment.start,
    );
  }
}
