import 'package:aaa/home/HomeAbController.dart';
import 'package:aaa/home/findhome/FindHome.dart';
import 'package:aaa/home/memoryhome/MemoryHome.dart';
import 'package:aaa/home/minehome/MineHome.dart';
import 'package:aaa/push_page/push_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:tools/tools.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'fragmenthome/FragmentHome.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AbBuilder<HomeAbController>(
      putController: HomeAbController(),
      builder: (c, abw) {
        return Scaffold(
          extendBody: true,
          body: SafeArea(child: _body()),
          bottomNavigationBar: c.isShowFloating(abw) ? _bottomNavigationBar() : null,
          floatingActionButton: c.isShowFloating(abw) ? _floatingActionButton() : null,
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        );
      },
    );
  }

  Widget _floatingActionButton() {
    return AbBuilder<HomeAbController>(
      builder: (c, abw) {
        return FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () async {
            showMaterialModalBottomSheet(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))),
              context: c.context,
              builder: (BuildContext context) {
                return Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.black12,
                            ),
                            width: 30,
                            height: 5,
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Card(
                        elevation: 0,
                        color: Color.fromRGBO(240, 240, 240, 1),
                        margin: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                behavior: HitTestBehavior.translucent,
                                child: Column(
                                  children: [
                                    SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 10),
                                          child: Text("笔记", style: TextStyle(fontWeight: FontWeight.bold)),
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 10),
                                          child: Text("在这里快速写下知识点...", style: TextStyle(color: Colors.grey)),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 20),
                                  ],
                                ),
                                onTap: () {
                                  pushToShorthandGizmoEditPage(context: context, initShorthand: null);
                                },
                              ),
                            ),
                            SizedBox(
                              child: MaterialButton(
                                child: Icon(Icons.mic, color: Colors.blue, size: 38),
                                onPressed: () {},
                              ),
                              height: 100,
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          MaterialButton(
                            child: Row(
                              children: [
                                Transform.translate(offset: Offset(0, -2), child: FaIcon(FontAwesomeIcons.puzzlePiece, size: 20, color: Colors.orange)),
                                SizedBox(width: 5),
                                Text("制作碎片"),
                              ],
                            ),
                            onPressed: () async {
                              final result = await pushToTemplateChoice(context: context);
                              if (result != null) {
                                await pushToFragmentTemplateEditView(
                                  context: context,
                                  initFragmentAb: null,
                                  initFragmentTemplate: result,
                                  initSomeBefore: [],
                                  initSomeAfter: [],
                                  initFragmentGroupChain: null,
                                  isEditableAb: true.ab,
                                  isTailNew: true,
                                );
                              }
                            },
                          ),
                          MaterialButton(
                            onPressed: () {},
                            child: Row(
                              children: [
                                Icon(Icons.camera_rear, size: 24, color: Colors.redAccent),
                                SizedBox(width: 5),
                                Text("制作模板"),
                              ],
                            ),
                          ),
                          MaterialButton(
                            onPressed: () {},
                            child: Row(
                              children: [
                                Icon(Icons.science_sharp, size: 24, color: Colors.greenAccent),
                                SizedBox(width: 5),
                                Text("制作算法"),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          MaterialButton(
                            onPressed: () {},
                            child: Row(
                              children: [
                                Icon(Icons.eco_outlined, color: Colors.green),
                                SizedBox(width: 5),
                                Text("发表想法"),
                              ],
                            ),
                          ),
                          MaterialButton(
                            onPressed: () {},
                            child: Row(
                              children: [
                                Icon(Icons.article_outlined, color: Colors.blueGrey),
                                SizedBox(width: 5),
                                Text("发表文章"),
                              ],
                            ),
                          ),
                          MaterialButton(
                            onPressed: () {},
                            child: Row(
                              children: [
                                Icon(
                                  Icons.live_help_outlined,
                                  color: Colors.lightBlueAccent,
                                ),
                                SizedBox(width: 5),
                                Text("求助制作"),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                );
              },
            );
            // await pushToFragmentEditPage(
            //   context: c.context,
            //   initSomeBefore: [],
            //   initSomeAfter: [],
            //   initFragmentAb: null,
            // );
          },
        );
      },
    );
  }

  Widget _body() {
    return AbBuilder<HomeAbController>(
      builder: (controller, abw) {
        return PageView(
          controller: controller.pageController,
          children: [
            KeepStateWidget(child: const FindHome()),
            KeepStateWidget(child: const MemoryHome()),
            KeepStateWidget(child: const FragmentHome()),
            const MineHome(),
          ],
          onPageChanged: (int toIndex) {
            controller.currentPageType.refreshEasy((oldValue) => PageType.values[toIndex]);
          },
        );
      },
    );
  }

  Widget _bottomNavigationBar() {
    return AbBuilder<HomeAbController>(
      builder: (c, abw) {
        return AnimatedBottomNavigationBar.builder(
          itemCount: 4,
          activeIndex: c.currentPageType(abw).index,
          gapLocation: GapLocation.center,
          splashColor: Colors.blue,
          tabBuilder: (index, isActive) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  PageType.values[index].icon,
                  size: isActive ? 24 : 20,
                  color: isActive ? Colors.blue : Colors.black,
                ),
                isActive
                    ? Text(
                        PageType.values[index].text,
                        style: TextStyle(fontSize: 12, color: isActive ? Colors.blue : Colors.black),
                      )
                    : Container(),
              ],
            );
          },
          onTap: (value) {
            c.currentPageType.refreshEasy((oldValue) => PageType.values[value]);
            c.pageController.jumpToPage(value);
          },
        );
      },
    );
  }
}
