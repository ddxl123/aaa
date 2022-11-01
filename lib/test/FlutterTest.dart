import 'dart:math';

import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';

class FlutterTest extends StatelessWidget {
  const FlutterTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: const A(),
      ),
    );
  }
}

class A extends StatefulWidget {
  const A({Key? key}) : super(key: key);

  @override
  State<A> createState() => _AState();
}

class _AState extends State<A> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        child: const Text('to 2'),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => B()));
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
    BackButtonInterceptor.add(myInterceptor,name: 'a',context: context);
  }

  @override
  void dispose() {
    BackButtonInterceptor.removeByName('a');
    super.dispose();
  }

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {

    print("BACK BUTTON!:${Random().nextInt(100)}"); // Do some stuff.
    print('stopDefaultButtonEvent:$stopDefaultButtonEvent');
    print('aaa:${info.ifRouteChanged(context)}');
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: TextButton(
        child: const Text('back'),
        onPressed: () {
          showAboutDialog(context: context);
        },
      ),
    );
  }
}
