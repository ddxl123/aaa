import 'package:aaa/drift/DriftDb.dart';
import 'package:aaa/drift/tool/DriftViewer.dart';
import 'package:aaa/home/HomeAbController.dart';
import 'package:aaa/tool/Toaster.dart';
import 'package:aaa/tool/aber/Aber.dart';
import 'package:aaa/tool/freebox/FreeBox.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import 'fragmenthome/FragmentHome.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AbBuilder<HomeAbController>(
      controller: HomeAbController(),
      builder: (controller, abw) {
        return Scaffold(
          floatingActionButton: _floatingActionButton(controller.context),
          body: _body(),
          bottomNavigationBar: _bottomNavigationBar(),
        );
      },
    );
  }

  // Future<bool> _onWillPop() async {
  //   // 双击返回键才会退出应用。
  //   int now = DateTime.now().millisecondsSinceEpoch;
  //   if (lastBackTime != null && now - lastBackTime! < 1500) {
  //     return true;
  //   }
  //   lastBackTime = now;
  //   Toaster.show(content: '再按一次退出！', milliseconds: 1500);
  //   await Future.delayed(
  //     const Duration(milliseconds: 1500),
  //     () {
  //       lastBackTime = null;
  //     },
  //   );
  //   return false;
  // }

  Widget _floatingActionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async {
        Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => DriftViewer(database: DriftDb.instance)));
      },
    );
  }

  Widget _body() {
    return AbBuilder<HomeAbController>(
      builder: (controller, abw) {
        return PageView(
          controller: controller.pageController,
          children: const [
            Text('data1'),
            FragmentHome(),
            Text('data3'),
            Text('data4'),
          ],
          onPageChanged: (int toIndex) {
            controller.currentPageIndex.refreshEasy((oldValue) => toIndex);
          },
        );
      },
    );
  }

  Widget _bottomNavigationBar() {
    return AbBuilder<HomeAbController>(builder: (controller, abw) {
      return Container(
        color: Colors.white,
        child: SalomonBottomBar(
          currentIndex: controller.currentPageIndex(abw),
          onTap: (int tapIndex) {
            controller.currentPageIndex.refreshEasy((oldValue) => tapIndex);
            controller.pageController.jumpToPage(tapIndex);
          },
          items: [
            SalomonBottomBarItem(icon: const Icon(Icons.home), title: const Text('主页')),
            SalomonBottomBarItem(icon: const Icon(Icons.person), title: const Text('碎片')),
            SalomonBottomBarItem(icon: const Icon(Icons.person), title: const Text('记忆')),
            SalomonBottomBarItem(icon: const Icon(Icons.person), title: const Text('我的')),
          ],
        ),
      );
    });
  }
}
