import 'package:aaa/test/Nb.dart';
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
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => FlutterTest1()));
        },
      ),
    );
  }
}

class FlutterTest1 extends StatelessWidget {
  FlutterTest1({Key? key}) : super(key: key);
  final TestNbController testNbController = TestNbController();

  @override
  Widget build(BuildContext context) {
    print('build');
    return Scaffold(
      body: Column(
        children: [
          NbWidget<TestNbController>(
            controller: testNbController,
            builder: (TestNbController controller, Nbw<TestNbController> nbw) {
              print('aaaaaaaaaaaaaaaaaaa');
              return TextButton(
                child: Text(controller.a(nbw).toString()),
                onPressed: () {
                  controller.a.updateTo((oldValue) => oldValue * 2);
                },
              );
            },
          ),
          NbWidget(
            controller: testNbController,
            builder: (TestNbController controller, Nbw<TestNbController> nbw) {
              print('bbbbbbbbbbbbbbbbbbb');
              return TextButton(
                child: Text(controller.b(nbw).toString()),
                onPressed: () {},
              );
            },
          ),
          NbWidget(
            controller: testNbController,
            builder: (TestNbController controller, Nbw<TestNbController> nbw) {
              print('ccccccccccccccccccc');
              return TextButton(
                child: Text(controller.a(nbw).toString()),
                onPressed: () {},
              );
            },
          ),
        ],
      ),
    );
  }
}

class TestNbController extends NbController {
  final a = 1.nb;
  final b = 11.nb;
  final c = 111.nb;
}
