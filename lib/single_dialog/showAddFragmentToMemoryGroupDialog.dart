import 'package:aaa/single_dialog/showCreateMemoryGroupDialog.dart';
import 'package:drift_main/drift/DriftDb.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:tools/tools.dart';

Future<void> showAddFragmentToMemoryGroupDialog() async {
  // 检测是否存在已选碎片。
  final fCount = await db.generalQueryDAO.querySelectedFragmentCount();
  if (fCount != 0) {
    await showCustomDialog(builder: (_) => AddFragmentToMemoryGroupDialogWidget(selectFragmentCount: fCount));
  } else {
    SmartDialog.showToast('没有碎片被选择！');
  }
}

class AddFragmentToMemoryGroupDialogWidget extends StatefulWidget {
  const AddFragmentToMemoryGroupDialogWidget({Key? key, required this.selectFragmentCount}) : super(key: key);
  final int selectFragmentCount;

  @override
  State<AddFragmentToMemoryGroupDialogWidget> createState() => _AddFragmentToMemoryGroupDialogWidgetState();
}

class _AddFragmentToMemoryGroupDialogWidgetState extends State<AddFragmentToMemoryGroupDialogWidget> {
  /// 记忆组 -> 现有碎片数量。
  final Map<MemoryGroup, int> mgsMap = {};
  MemoryGroup? selectedMg;

  int repeatCount = 0;

  bool isRemoveDuplication = true;

  Future<void> getMgs() async {
    final mgs = await db.generalQueryDAO.queryMemoryGroups();
    await Future.forEach<MemoryGroup>(
      mgs,
      (element) async {
        final count = await db.generalQueryDAO.queryFragmentsCountInMemoryGroup(memoryGroup: element);
        mgsMap.addAll({element: count});
      },
    );
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getMgs();
  }

  Widget _topRightAction() {
    return IconButton(
      icon: const Icon(Icons.add),
      style: ButtonStyle(padding: MaterialStateProperty.all(EdgeInsets.zero), tapTargetSize: MaterialTapTargetSize.shrinkWrap),
      onPressed: () async {
        await showCreateMemoryGroupDialog();
        mgsMap.clear();
        selectedMg = null;
        await getMgs();
      },
    );
  }

  List<Widget> _columnChildren() {
    return mgsMap.keys.map(
      (e) {
        return TextButton(
          style: ButtonStyle(padding: MaterialStateProperty.all(EdgeInsets.zero)),
          child: Row(
            children: [
              Expanded(child: Text(e.title)),
              const SizedBox(width: 10),
              Text('${mgsMap[e]}', style: const TextStyle(color: Colors.grey)),
              selectedMg == e ? Text(' +${widget.selectFragmentCount - repeatCount}', style: const TextStyle(color: Colors.green)) : Container(),
              const SizedBox(width: 10),
              if (selectedMg == e) const SolidCircleIcon() else const SolidCircleGreyIcon(),
            ],
          ),
          onPressed: () async {
            if (selectedMg == e) {
              selectedMg = null;
            } else {
              selectedMg = e;
              if (isRemoveDuplication) {
                repeatCount = await db.generalQueryDAO.querySelectedFragmentsRepeatCount(memoryGroup: selectedMg!);
              } else {
                repeatCount = 0;
              }
            }
            setState(() {});
          },
        );
      },
    ).toList();
  }

  Future<void> _onOk() async {
    if (selectedMg == null) {
      SmartDialog.showToast('未选择！');
    } else {
      await db.insertDAO.insertSelectedFragmentToMemoryGroup(
        memoryGroup: selectedMg!,
        isRemoveRepeat: isRemoveDuplication,
        syncTag: await SyncTag.create(),
        isCloudTableWithSync: true,
      );
      SmartDialog.dismiss();
      SmartDialog.showToast('添加成功！');
    }
  }

  @override
  Widget build(BuildContext context) {
    return OkAndCancelDialogWidget(
      dialogSize: DialogSize(width: globalDialogFixedWidth, height: null),
      title: '添加至记忆组：',
      topRightAction: _topRightAction(),
      columnChildren: mgsMap.isEmpty ? const [Text('未创建记忆组', style: TextStyle(color: Colors.grey))] : _columnChildren(),
      cancelText: '再选选(${widget.selectFragmentCount})',
      okText: '添加',
      onCancel: () async {
        SmartDialog.dismiss();
      },
      onOk: _onOk,
      topKeepWidget: Row(
        children: [
          Text(
            "请选择记忆组",
            style: TextStyle(color: Colors.grey),
          )
        ],
      ),
      bottomKeepWidget: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Text('去除重复'),
          Switch(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            value: isRemoveDuplication,
            onChanged: (v) async {
              if (selectedMg != null) {
                if (v) {
                  repeatCount = await db.generalQueryDAO.querySelectedFragmentsRepeatCount(memoryGroup: selectedMg!);
                } else {
                  repeatCount = 0;
                }
              }
              isRemoveDuplication = v;
              if (mounted) setState(() {});
            },
          ),
        ],
      ),
    );
  }
}
