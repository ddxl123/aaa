import 'package:aaa/single_dialog/showSelectMemoryModelInMemoryGroupDialog.dart';
import 'package:flutter/material.dart';
import 'package:tools/tools.dart';

import 'MemoryGroupGizmoEditPageAbController.dart';

class BasicConfigWidget extends StatelessWidget {
  const BasicConfigWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AbBuilder<MemoryGroupGizmoEditPageAbController>(
      builder: (c, abw) {
        return SliverToBoxAdapter(
          child: Theme(
            data: Theme.of(c.context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              maintainState: true,
              title: AbwBuilder(
                builder: (abw) {
                  return Text(
                    '基础配置：',
                    style: TextStyle(color: c.isBasicConfigRedErr(abw) ? Colors.red : null),
                  );
                },
              ),
              children: [
                _titleWidget(),
                _memoryModelWidget(),
                _selectFragmentWidget(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _titleWidget() {
    return AbBuilder<MemoryGroupGizmoEditPageAbController>(
      builder: (c, abw) {
        return CardCustom(
          verifyAb: c.bTitle.abObj,
          child: Row(
            children: [
              const Text('名称：', style: TextStyle(fontSize: 16)),
              Expanded(
                child: TextField(
                  controller: c.bcTitleTextEditingController,
                  decoration: const InputDecoration(border: InputBorder.none, hintText: '请输入...'),
                  onChanged: (v) {
                    c.bTitle.abObj.refreshEasy((oldValue) => v);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _memoryModelWidget() {
    return AbBuilder<MemoryGroupGizmoEditPageAbController>(
      builder: (c, abw) {
        return CardCustom(
          verifyAb: c.bSelectedMemoryModel.abObj,
          child: Row(
            children: [
              const Text('记忆模型：', style: TextStyle(fontSize: 16)),
              TextButton(
                child: AbBuilder<MemoryGroupGizmoEditPageAbController>(
                  builder: (gzC, gzAbw) {
                    return Text(gzC.bSelectedMemoryModel.abObj(gzAbw)?.title ?? '点击选择');
                  },
                ),
                onPressed: () {
                  showSelectMemoryModelInMemoryGroupDialog(selectedMemoryModelAb: c.bSelectedMemoryModel.abObj);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _selectFragmentWidget() {
    return AbBuilder<MemoryGroupGizmoEditPageAbController>(
      builder: (c, abw) {
        return CardCustom(
          verifyAb: null,
          child: Row(
            children: [
              const Text('已选碎片：', style: TextStyle(fontSize: 16)),
              TextButton(
                child: Text('点击查看（共 ${c.bSelectedFragments(abw).length} 个）', style: const TextStyle(fontSize: 16)),
                onPressed: () {
                  Navigator.of(c.context).push(
                    DefaultSheetRoute(
                      bodySliver0: () {
                        return SliverToBoxAdapter(
                          child: AbBuilder<MemoryGroupGizmoEditPageAbController>(
                            builder: (sController, sAbw) {
                              return Material(
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  child: SingleChildScrollView(
                                    physics: const NeverScrollableScrollPhysics(),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        ...(sController.bSelectedFragments(sAbw).isEmpty
                                            ? [Container()]
                                            : sController.bSelectedFragments(sAbw).map(
                                                  (e) => Row(
                                                    children: [
                                                      SizedBox(
                                                        height: 200,
                                                        child: Text(e(abw).content.toString()),
                                                      )
                                                    ],
                                                  ),
                                                )),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
