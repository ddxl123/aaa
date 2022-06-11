import 'package:aaa/drift/DriftDb.dart';
import 'package:aaa/drift/tool/DriftViewer.dart';
import 'package:aaa/home/HomeAbController.dart';
import 'package:aaa/home/memoryhome/MemoryHome.dart';
import 'package:aaa/home/minehome/MineHome.dart';
import 'package:aaa/page/create/CreateFragmentPage.dart';
import 'package:aaa/tool/Toaster.dart';
import 'package:aaa/tool/WidgetWrapper.dart';
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
      putController: HomeAbController(),
      builder: (controller, abw) {
        return WillPopScope(
          onWillPop: controller.onWillPop,
          child: Scaffold(
            floatingActionButton: _floatingActionButton(context),
            body: SafeArea(child: _body()),
            bottomNavigationBar: _bottomNavigationBar(),
          ),
        );
      },
    );
  }

  Widget _floatingActionButton(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () async {
        Navigator.push(context, MaterialPageRoute(builder: (ctx) => const CreateFragmentPage()));
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
            SalomonBottomBarItem(icon: const Icon(Icons.home), title: const Text('首页')),
            SalomonBottomBarItem(icon: const Icon(Icons.person), title: const Text('碎片')),
            SalomonBottomBarItem(icon: const Icon(Icons.person), title: const Text('记忆')),
            SalomonBottomBarItem(icon: const Icon(Icons.person), title: const Text('我的')),
          ],
        ),
      );
    });
  }
}
