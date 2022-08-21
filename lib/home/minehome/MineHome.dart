import 'package:aaa/home/HomeAbController.dart';
import 'package:aaa/home/test/TestHome.dart';
import 'package:aaa/tool/DriftViewer.dart';
import 'package:aaa/tool/aber/Aber.dart';
import 'package:drift_main/DriftDb.dart';
import 'package:flutter/material.dart';

class MineHome extends StatelessWidget {
  const MineHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AbBuilder<HomeAbController>(
      builder: (c, abw) {
        return Scaffold(
          body: Center(
            child: TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const TestHome()));
              },
              child: const Text('开发者模块'),
            ),
          ),
        );
      },
    );
  }
}
