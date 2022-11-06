import 'package:aaa/single_dialog/single_dialog.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:tools/tools.dart';

class FlutterTest extends StatelessWidget {
  const FlutterTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const A(),
    );
  }
}

class A extends StatelessWidget {
  const A({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        child: const Text('to B'),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const B()));
        },
      ),
    );
  }
}

class B extends StatefulWidget {
  const B({Key? key}) : super(key: key);

  @override
  State<B> createState() => _BState();
}

class _BState extends State<B> {
  @override
  void initState() {
    super.initState();
    BackButtonInterceptor.add(myInterceptor, context: context);
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    if (info.ifRouteChanged(context)) {
      print('false');
      return false;
    }
    print('true');
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          OutlinedButton(
            child: const Text('正常的 material 的 showAboutDialog 按钮'),
            onPressed: () {
              showDialog(context: context, builder: (_) => const Center(child: Material(child: Text('按物理返回键后，会先关闭该 dialog！'))));
            },
          ),
          OutlinedButton(
            child: const Text('使用 SmartDialog.show'),
            onPressed: () {
              showAboutDialog(context: context);
              // showDialogForCreateMemoryGroup(context: context);
              // SmartDialog.show(builder: (_) => const Center(child: Material(child: Text('按物理返回键后，会先关闭该 dialog！'))),backDismiss: true);
              // showDialogCustom(textsBody: [Text('data')], buttonsBody: [Text('data')]);
            },
          ),
        ],
      ),
    );
  }
}
