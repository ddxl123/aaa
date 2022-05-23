import 'dart:developer';

import 'package:aaa/drift/DriftDb.dart';
import 'package:aaa/drift/tool/DriftViewer.dart';
import 'package:aaa/tool/Toaster.dart';
import 'package:aaa/tool/freebox/FreeBox.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import 'fragmenthome/FragmentHome.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final PageController _pageController = PageController();
  int _currentPageIndex = 0;

  // 双击返回键才会退出应用。
  int? _lastBackTime;

  @override
  void initState() {
    super.initState();
    Toaster.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        floatingActionButton: _floatingActionButton(),
        body: _body(),
        bottomNavigationBar: _bottomNavigationBar(),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    // 双击返回键才会退出应用。
    int now = DateTime.now().millisecondsSinceEpoch;
    if (_lastBackTime != null && now - _lastBackTime! < 1500) {
      return true;
    }
    _lastBackTime = now;
    Toaster.show(content: '再按一次退出！', milliseconds: 1500);
    await Future.delayed(
      const Duration(milliseconds: 1500),
      () {
        _lastBackTime = null;
      },
    );
    return false;
  }

  final FreeBoxController _freeBoxController = FreeBoxController(isKeepCameraState: true);

  Widget _floatingActionButton() => FloatingActionButton(
        onPressed: () async {
          await DriftDb.instance.singleDAO.a();
          await DriftDb.instance.singleDAO.b();
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) {
                return DriftViewer(database: DriftDb.instance);
              },
            ),
          );
        },
      );

  Widget _body() => PageView(
        controller: _pageController,
        children: const [
          Text('data1'),
          FragmentHome(),
          Text('data3'),
          Text('data4'),
        ],
        onPageChanged: (int toIndex) {
          _currentPageIndex = toIndex;
          setState(() {});
        },
      );

  Widget _bottomNavigationBar() => Container(
        color: Colors.white,
        child: SalomonBottomBar(
          currentIndex: _currentPageIndex,
          onTap: (int tapIndex) => setState(() {
            _currentPageIndex = tapIndex;
            _pageController.jumpToPage(tapIndex);
          }),
          items: [
            SalomonBottomBarItem(icon: const Icon(Icons.home), title: const Text('主页')),
            SalomonBottomBarItem(icon: const Icon(Icons.person), title: const Text('碎片')),
            SalomonBottomBarItem(icon: const Icon(Icons.person), title: const Text('记忆')),
            SalomonBottomBarItem(icon: const Icon(Icons.person), title: const Text('我的')),
          ],
        ),
      );
}
