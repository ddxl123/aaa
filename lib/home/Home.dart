import 'package:aaa/home/HomeAbController.dart';
import 'package:aaa/home/findhome/FindHome.dart';
import 'package:aaa/home/memoryhome/MemoryHome.dart';
import 'package:aaa/home/minehome/MineHome.dart';
import 'package:aaa/page/edit/FragmentGizmoEditPage.dart';
import 'package:aaa/push_page/push_page.dart';
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
            await pushToFragmentEditPage(
              context: c.context,
              initSomeBefore: [],
              initSomeAfter: [],
              initFragmentAb: null,
            );
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
            KeepStateWidget(builder: (ctx) => const FindHome()),
            KeepStateWidget(builder: (ctx) => const MemoryHome()),
            KeepStateWidget(builder: (ctx) => const FragmentHome()),
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
      builder: (c, abw) {
        return AnimatedBottomNavigationBar.builder(
          itemCount: 4,
          activeIndex: c.currentPageIndex(abw),
          gapLocation: GapLocation.center,
          splashColor: Colors.blue,
          tabBuilder: (index, isActive) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  c.iconDatas[index],
                  size: isActive ? 20 : 24,
                  color: isActive ? Colors.blue : Colors.black,
                ),
                isActive
                    ? Text(
                        c.labels[index],
                        style: TextStyle(fontSize: 12, color: isActive ? Colors.blue : Colors.black),
                      )
                    : Container(),
              ],
            );
          },
          onTap: (value) {
            c.currentPageIndex.refreshEasy((oldValue) => value);
            c.pageController.jumpToPage(value);
          },
        );
      },
    );
  }
}
