import 'package:aaa/tool/DriftViewer.dart';
import 'package:aaa/tool/aber/Aber.dart';
import 'package:catcher/catcher.dart';
import 'package:drift_main/DriftDb.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import 'TestHomeAbController.dart';

class TestHome extends StatelessWidget {
  const TestHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AbBuilder<TestHomeAbController>(
      putController: TestHomeAbController(),
      builder: (c, abw) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('开发者模块'),
          ),
          body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('当前用户 id：${c.user(abw)?.id}'),
                Text('用户名：${c.user(abw)?.username}'),
                Text('密码：${c.user(abw)?.password}'),
                Text('邮箱：${c.user(abw)?.email}'),
                Text('年龄：${c.user(abw)?.age}'),
                TextButton(
                  child: const Text('查看本地数据库'),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => DriftViewer(database: DriftDb.instance)));
                  },
                ),
                TextButton(
                  child: const Text('插入测试数据'),
                  onPressed: () async {
                    SmartDialog.showToast('插入中...');
                    await c.inserts();
                    SmartDialog.showToast('插入成功');
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
