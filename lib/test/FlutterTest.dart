import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class FlutterTest extends StatelessWidget {
  const FlutterTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: TextButton(
          child: const Text('to B'),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const B()));
          },
        ),
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
            child: const Text('正常的 material 的 showDialog'),
            onPressed: () {
              showDialog(context: context, builder: (_) => const Center(child: Material(child: Text('按物理返回键后，会关闭该 dialog！'))));
            },
          ),
          OutlinedButton(
            child: const Text('使用 SmartDialog.show '),
            onPressed: () {
              SmartDialog.show(
                builder: (_) => const Center(child: Material(child: Text('按物理返回键后，应该也会关闭该 dialog，但并没有！'))),
                backDismiss: true,
                useSystem: true,
              );
            },
          ),
        ],
      ),
    );
  }
}
