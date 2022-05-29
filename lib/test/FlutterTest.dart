import 'package:aaa/tool/aber/Aber.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TestController extends GetxController {
  int a = 1;
  int b = 10;

  void add() {
    a++;
    update();
  }
}

class FlutterTest extends StatefulWidget {
  const FlutterTest({Key? key}) : super(key: key);

  @override
  State<FlutterTest> createState() => _FlutterTestState();
}

class _FlutterTestState extends State<FlutterTest> {
  @override
  Widget build(BuildContext context) {
    print(context.hashCode);
    return Scaffold(
      body: TextButton(
        child: const Text('push'),
        onPressed: () {},
      ),
    );
  }
}
