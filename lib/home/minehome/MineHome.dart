import 'package:aaa/tool/DriftViewer.dart';
import 'package:drift_main/DriftDb.dart';
import 'package:flutter/material.dart';

class MineHome extends StatelessWidget {
  const MineHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              child: const Text('本地数据库'),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => DriftViewer(database: DriftDb.instance)));
              },
            ),
          ],
        ),
      ),
    );
  }
}
