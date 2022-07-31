import 'package:flutter/material.dart';

class FlutterTest extends StatelessWidget {
  const FlutterTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: Navigator(
          initialRoute: '/',
          onGenerateRoute: (rs) {
            return MaterialPageRoute(builder: (ctx) => const FirstPage());
          },
        ),
      ),
    );
  }
}

class FirstPage extends StatelessWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('this first page'),
        TextButton(
          child: const Text('pop in first page'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        TextButton(
          child: const Text('push second page'),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (ctx) => const SecondPage()));
          },
        ),
      ],
    );
  }
}

class SecondPage extends StatelessWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('this second page'),
        TextButton(
          child: const Text('pop in second page'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
