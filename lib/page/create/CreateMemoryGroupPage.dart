import 'package:aaa/drift/DriftDb.dart';
import 'package:aaa/page/create/CreateMemoryGroupPageAbController.dart';
import 'package:aaa/page/transition/MemoryModelChoosePage.dart';
import 'package:aaa/tool/aber/Aber.dart';
import 'package:aaa/tool/sheetroute/DefaultSheetRoute.dart';
import 'package:aaa/tool/sheetroute/SheetRoute.dart';
import 'package:aaa/tool/sheetroute/SheetRouteController.dart';
import 'package:aaa/widget_model/FragmentGroupModelAbController.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CreateMemoryGroupPage extends StatelessWidget {
  const CreateMemoryGroupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AbBuilder<CreateMemoryGroupPageAbController>(
      putController: CreateMemoryGroupPageAbController(),
      builder: (putController, putAbw) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white12,
            leading: IconButton(
              icon: const FaIcon(FontAwesomeIcons.xmark, color: Colors.red),
              onPressed: () {
                putController.cancel();
              },
            ),
            title: const Text('创建记忆组'),
            actions: [
              IconButton(
                icon: const FaIcon(FontAwesomeIcons.check, color: Colors.green),
                onPressed: () {
                  putController.commit();
                },
              )
            ],
          ),
          body: Container(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text('名称：', style: TextStyle(fontSize: 16)),
                    Expanded(
                      child: TextField(
                        minLines: null,
                        maxLines: null,
                        autofocus: true,
                        decoration: const InputDecoration(border: InputBorder.none, hintText: '请输入...'),
                        onChanged: (text) {
                          putController.title.refreshEasy((oldValue) => text);
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text('记忆模型：', style: TextStyle(fontSize: 16)),
                    StatefulBuilder(
                      builder: (ctx, s) {
                        return TextButton(
                          child: AbBuilder<CreateMemoryGroupPageAbController>(
                            builder: (gzC, gzAbw) {
                              return Text(gzC.selectedMemoryModel(gzAbw)?.title ?? '点击选择');
                            },
                          ),
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (_) => const MemoryModelChoosePage()));
                          },
                        );
                      },
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text('展示类型：', style: TextStyle(fontSize: 16)),
                    StatefulBuilder(
                      builder: (ctx, s) {
                        return AbBuilder<CreateMemoryGroupPageAbController>(
                          builder: (gzC, gzAbw) {
                            return DropdownButton2<MemoryGroupType>(
                              value: gzC.type(gzAbw),
                              customItemsIndexes: const [1, 3, 5],
                              customItemsHeight: 10,
                              dropdownDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                              ),
                              items: [
                                DropdownMenuItem(
                                  child: Text('  暂不设置                 '),
                                  value: MemoryGroupType.none,
                                ),
                                DropdownMenuItem(
                                  enabled: false,
                                  child: Divider(),
                                ),
                                DropdownMenuItem(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('  常规类型'),
                                      IconButton(
                                        icon: Icon(
                                          Icons.info_outline,
                                          color: Colors.grey,
                                        ),
                                        onPressed: () {},
                                      ),
                                    ],
                                  ),
                                  value: MemoryGroupType.normal,
                                ),
                                DropdownMenuItem(
                                  enabled: false,
                                  child: Divider(),
                                ),
                                DropdownMenuItem(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('  全悬浮类型'),
                                      IconButton(
                                          icon: Icon(
                                            Icons.info_outline,
                                            color: Colors.grey,
                                          ),
                                          onPressed: () {}),
                                    ],
                                  ),
                                  value: MemoryGroupType.fullFloating,
                                ),
                              ],
                              onChanged: (value) {
                                gzC.type.refreshEasy((oldValue) => value!);
                              },
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text('已选碎片：', style: TextStyle(fontSize: 16)),
                    AbBuilder<CreateMemoryGroupPageAbController>(
                      builder: (cController, sAbw) {
                        return TextButton(
                          child: Text('点击查看（共 ${cController.selectedFragments(sAbw).length} 个）', style: const TextStyle(fontSize: 16)),
                          onPressed: () {
                            Navigator.of(context).push(
                              DefaultSheetRoute(bodySliver0: () {
                                return SliverToBoxAdapter(
                                  child: AbBuilder<CreateMemoryGroupPageAbController>(
                                    builder: (sController, sAbw) {
                                      return Material(
                                        child: Container(
                                          padding: const EdgeInsets.all(10),
                                          child: SingleChildScrollView(
                                            physics: const NeverScrollableScrollPhysics(),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                ...(sController.selectedFragments(sAbw).isEmpty
                                                    ? [Container()]
                                                    : sController.selectedFragments(sAbw).map(
                                                          (e) => Row(
                                                            children: [
                                                              SizedBox(
                                                                height: 200,
                                                                child: Text(e.title.toString()),
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
                              }),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
