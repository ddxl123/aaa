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
              childrenPadding: EdgeInsets.all(10),
              title: Text('基础配置：'),
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
        return Card(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                const Text('名称：', style: TextStyle(fontSize: 16)),
                Expanded(
                  child: TextField(
                    controller: c.titleTextEditingController,
                    decoration: const InputDecoration(border: InputBorder.none, hintText: '请输入...'),
                    onChanged: (v) {
                      c.memoryGroupAb.refreshInevitable((obj) => obj..title = v);
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _memoryModelWidget() {
    return AbBuilder<MemoryGroupGizmoEditPageAbController>(
      builder: (c, abw) {
        return Card(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                const Text('记忆算法：', style: TextStyle(fontSize: 16)),
                TextButton(
                  child: AbBuilder<MemoryGroupGizmoEditPageAbController>(
                    builder: (gzC, gzAbw) {
                      return Text(gzC.memoryModelAb(gzAbw)?.title ?? '点击选择');
                    },
                  ),
                  onPressed: () async {
                    await showSelectMemoryModelInMemoryGroupDialog(mg: c.memoryGroupAb, selectedMemoryModelAb: c.memoryModelAb);
                    c.memoryGroupAb.refreshInevitable((obj) => obj..memory_model_id = c.memoryModelAb()?.id);
                  },
                ),
                Text("模拟(验证算法的正确性)"),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _selectFragmentWidget() {
    return AbBuilder<MemoryGroupGizmoEditPageAbController>(
      builder: (c, abw) {
        return Card(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                const Text('已选碎片：', style: TextStyle(fontSize: 16)),
                TextButton(
                  child: Text('点击查看（共 ${c.fragmentCountAb(abw)} 个）', style: const TextStyle(fontSize: 16)),
                  onPressed: () {
                    // Navigator.of(c.context).push(
                    //   DefaultSheetRoute(
                    //     bodySliver0: () {
                    //       return SliverToBoxAdapter(
                    //         child: AbBuilder<MemoryGroupGizmoEditPageAbController>(
                    //           builder: (sController, sAbw) {
                    //             return Material(
                    //               child: Container(
                    //                 padding: const EdgeInsets.all(10),
                    //                 child: SingleChildScrollView(
                    //                   physics: const NeverScrollableScrollPhysics(),
                    //                   child: Column(
                    //                     mainAxisSize: MainAxisSize.max,
                    //                     children: [
                    //                       ...(sController.selectedFragmentCountAb(sAbw).isEmpty
                    //                           ? [Container()]
                    //                           : sController.selectedFragmentCountAb(sAbw).map(
                    //                                 (e) => Row(
                    //                                   children: [
                    //                                     SizedBox(
                    //                                       height: 200,
                    //                                       child: Text(e(abw).content.toString()),
                    //                                     )
                    //                                   ],
                    //                                 ),
                    //                               )),
                    //                     ],
                    //                   ),
                    //                 ),
                    //               ),
                    //             );
                    //           },
                    //         ),
                    //       );
                    //     },
                    //   ),
                    // );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
