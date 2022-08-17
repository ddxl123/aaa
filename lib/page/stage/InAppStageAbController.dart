import 'package:aaa/tool/aber/Aber.dart';
import 'package:flutter/material.dart';

class InAppStageAbController extends AbController {
  @override
  bool get isEnableLoading => true;

  @override
  Future<void> loadingFuture() async {
    await Future.delayed(const Duration(seconds: 2));
  }

  @override
  Widget loadingWidget() {
    return const Material(
      child: Center(
        child: Text('加载中...'),
      ),
    );
  }
}
