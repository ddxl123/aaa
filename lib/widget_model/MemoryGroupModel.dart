import 'package:aaa/page/create/CreateMemoryGroupPage.dart';
import 'package:aaa/page/normal/FragmentInMemoryGroupPage.dart';
import 'package:aaa/tool/aber/Aber.dart';
import 'package:aaa/widget_model/MemoryGroupModelAbController.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MemoryGroupModel extends StatelessWidget {
  const MemoryGroupModel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AbBuilder<MemoryGroupModelAbController>(
      putController: MemoryGroupModelAbController(),
      tag: Aber.hashCodeTag,
      builder: (putController, putAbw) {
        return Scaffold(
          appBar: PreferredSize(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                DropdownButtonHideUnderline(
                  child: DropdownButton2<int>(
                    dropdownDecoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
                    dropdownWidth: 150,
                    customButton: const Padding(
                      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: Icon(Icons.more_horiz),
                    ),
                    items: const [
                      DropdownMenuItem(
                        child: Text('添加记忆组'),
                        value: 0,
                      )
                    ],
                    onChanged: (value) {
                      if (value == 0) {
                        Navigator.push(context, MaterialPageRoute(builder: (ctx) => const CreateMemoryGroupPage()));
                      }
                    },
                  ),
                ),
              ],
            ),
            preferredSize: const Size.fromHeight(kMinInteractiveDimension),
          ),
          body: AbBuilder<MemoryGroupModelAbController>(
            tag: Aber.hashCodeTag,
            builder: (c, abw) {
              return SmartRefresher(
                controller: c.refreshController,
                physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                child: CustomScrollView(
                  slivers: [
                    ..._generalMemoryGroup(context),
                    SliverToBoxAdapter(child: Divider(height: 20)),
                    ..._fullFloating(context),
                  ],
                ),
                onRefresh: () async {
                  await Future.delayed(const Duration(milliseconds: 200));
                  await c.refreshPage();
                  c.refreshController.refreshCompleted();
                },
              );
            },
          ),
        );
      },
    );
  }

  List<Widget> _generalMemoryGroup(BuildContext context) {
    return [
      _sliverAppBar(context, text: '常规碎片组：'),
      _memoryGroup(),
    ];
  }

  List<Widget> _fullFloating(BuildContext context) {
    return [
      _sliverAppBar(context, text: '全悬浮碎片组：'),
      _memoryGroup(),
    ];
  }

  Widget _sliverAppBar(BuildContext context, {required String text}) {
    return SliverAppBar(
      title: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
        child: Text(text),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    );
  }

  Widget _memoryGroup() {
    return AbBuilder<MemoryGroupModelAbController>(
      tag: Aber.hashCodeTag,
      builder: (controller, abw) {
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return GestureDetector(
                child: Container(
                  margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: Text(
                              controller.memoryGroupVOs()[index]().memoryGroup(abw).title.toString(),
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          TextButton(
                            child: const Text('部分悬浮', style: TextStyle(color: Colors.grey)),
                            onPressed: () {},
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RichText(
                                    text: const TextSpan(
                                      children: [
                                        TextSpan(text: '已记 ', style: TextStyle(fontSize: 12, color: Colors.grey)),
                                        TextSpan(text: '1', style: TextStyle(fontSize: 14, color: Colors.black)),
                                        TextSpan(text: '  |  ', style: TextStyle(fontSize: 12, color: Colors.grey)),
                                        TextSpan(text: '记过 ', style: TextStyle(fontSize: 12, color: Colors.grey)),
                                        TextSpan(text: '12', style: TextStyle(fontSize: 14, color: Colors.black)),
                                        TextSpan(text: '  |  ', style: TextStyle(fontSize: 12, color: Colors.grey)),
                                        TextSpan(text: '未记 ', style: TextStyle(fontSize: 12, color: Colors.grey)),
                                        TextSpan(text: '332', style: TextStyle(fontSize: 14, color: Colors.black)),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          height: 5,
                                          color: Colors.green,
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          height: 5,
                                          color: Colors.amber,
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                          height: 5,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      RichText(
                                        text: const TextSpan(
                                          children: [
                                            TextSpan(text: '今日 11/50', style: TextStyle(fontSize: 12, color: Colors.grey)),
                                            TextSpan(text: '  |  ', style: TextStyle(fontSize: 12, color: Colors.grey)),
                                            TextSpan(text: '总共 50/200', style: TextStyle(fontSize: 12, color: Colors.grey)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: Material(
                              child: InkWell(
                                borderRadius: const BorderRadius.all(Radius.circular(50)),
                                splashColor: Colors.green,
                                child: Ink(
                                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                  decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(50)), color: Colors.grey),
                                  child: const Text('未开始', style: TextStyle(color: Colors.white)),
                                ),
                                onTap: () {
                                  print('object');
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => FragmentInMemoryGroupPage(memoryGroupAb: controller.memoryGroupVOs()[index]().memoryGroup),
                    ),
                  );
                },
              );
            },
            childCount: controller.memoryGroupVOs(abw).length,
          ),
        );
      },
    );
  }
}
