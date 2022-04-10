import 'package:drift_db_viewer/drift_db_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import 'drift/DriftDb.dart';
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
    EasyLoading.showToast('再按一次退出！');
    await Future.delayed(
      const Duration(milliseconds: 1500),
      () {
        _lastBackTime = null;
      },
    );
    return false;
  }

  Widget _floatingActionButton() => FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => DriftDbViewer(DriftDb.instance)));
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
