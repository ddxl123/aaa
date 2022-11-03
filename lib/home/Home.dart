import 'package:aaa/home/HomeAbController.dart';
import 'package:aaa/home/memoryhome/MemoryHome.dart';
import 'package:aaa/home/minehome/MineHome.dart';
import 'package:aaa/page/edit/FragmentGizmoEditPage.dart';
import 'package:aaa/single_dialog/single_dialog.dart';
import 'package:tools/tools.dart';
import 'package:aaa/page/list/FragmentGroupListPageAbController.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'fragmenthome/FragmentHome.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AbBuilder<HomeAbController>(
      putController: HomeAbController(),
      builder: (controller, abw) {
        return Scaffold(
          extendBody: true,
          body: SafeArea(child: _body()),
          bottomNavigationBar: _bottomNavigationBar(),
          floatingActionButton: _floatingActionButton(),
          floatingActionButtonLocation: controller.isFragmentSelecting(abw) ? FloatingActionButtonLocation.endFloat : FloatingActionButtonLocation.centerDocked,
        );
      },
    );
  }

  Widget _floatingActionButton() {
    return AbBuilder<HomeAbController>(
      builder: (putController, putAbw) {
        if (putController.isFragmentSelecting(putAbw)) {
          return Stack(
            alignment: Alignment.centerLeft,
            children: [
              FloatingActionButton(
                backgroundColor: Colors.amber,
                child: const Text('记'),
                onPressed: () async {
                  showDialogForCreateMemoryGroup(context: putController.context);
                },
              ),
              AbBuilder<FragmentGroupListPageAbController>(
                tag: Aber.nearest,
                builder: (countController, countAbw) {
                  return Transform.translate(
                    offset: Offset(putController.selectedCountDistance(countController, countAbw), 0),
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.amber),
                      child: Text(countController.selectedFragmentIds(countAbw).length.toString()),
                    ),
                  );
                },
              ),
            ],
          );
        }
        return FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () async {
            Navigator.push(putController.context, MaterialPageRoute(builder: (ctx) => const FragmentGizmoEditPage()));
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
            const Text('data1'),
            KeepStateWidget(builder: (ctx) => const FragmentHome()),
            KeepStateWidget(builder: (ctx) => const MemoryHome()),
            const MineHome(),
          ],
          onPageChanged: (int toIndex) {
            controller.currentPageIndex.refreshEasy((oldValue) => toIndex);
          },
        );
      },
    );
  }

  Widget _bottomNavigationBar() {
    return AbBuilder<HomeAbController>(
      builder: (hController, hAbw) {
        if (hController.isFragmentSelecting(hAbw)) {
          Widget button({required IconData iconData, required String label, required Function() onPressed, Color? color}) {
            return MaterialButton(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FaIcon(iconData, size: 22, color: color),
                  const SizedBox(height: 5),
                  Text(label, style: TextStyle(fontSize: 12, color: color)),
                ],
              ),
              onPressed: onPressed,
            );
          }

          return Container(
            margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
            decoration: const BoxDecoration(color: Colors.amber, borderRadius: BorderRadius.all(Radius.circular(10))),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  button(iconData: FontAwesomeIcons.penToSquare, label: '编辑', onPressed: () {}),
                  button(iconData: FontAwesomeIcons.copy, label: '复制', onPressed: () {}),
                  button(iconData: FontAwesomeIcons.paste, label: '粘贴', onPressed: () {}),
                  button(iconData: FontAwesomeIcons.arrowRightFromBracket, label: '移动', onPressed: () {}),
                  button(iconData: FontAwesomeIcons.trashCan, label: '删除', color: Colors.red, onPressed: () {}),
                ],
              ),
            ),
          );
        }
        return AnimatedBottomNavigationBar.builder(
          itemCount: 4,
          activeIndex: hController.currentPageIndex(hAbw),
          gapLocation: GapLocation.center,
          splashColor: Colors.blue,
          tabBuilder: (index, isActive) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  hController.iconDatas[index],
                  size: isActive ? 20 : 24,
                  color: isActive ? Colors.blue : Colors.black,
                ),
                isActive
                    ? Text(
                        hController.labels[index],
                        style: TextStyle(fontSize: 12, color: isActive ? Colors.blue : Colors.black),
                      )
                    : Container(),
              ],
            );
          },
          onTap: (value) {
            hController.currentPageIndex.refreshEasy((oldValue) => value);
            hController.pageController.jumpToPage(value);
          },
        );
      },
    );
  }
}
