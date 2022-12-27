import 'package:aaa/home/HomeAbController.dart';
import 'package:aaa/page/login_register/LoginPage.dart';
import 'package:drift_main/drift/DriftDb.dart';
import 'package:drift_main/tool/DriftViewer.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:tools/tools.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import '../../global/GlobalAbController.dart';
import 'TestHomeAbController.dart';

class TestHome extends StatelessWidget {
  const TestHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AbBuilder<GlobalAbController>(builder: (hc, hAbw) {
      return AbBuilder<TestHomeAbController>(
        putController: TestHomeAbController(),
        builder: (c, abw) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('开发者模块'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20),
              child: CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                slivers: [
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('当前用户 id：${hc.loggedInUser(abw)?.id}'),
                            Text('用户名：${hc.loggedInUser(abw)?.username}'),
                            Text('密码：${hc.loggedInUser(abw)?.password}'),
                            Text('邮箱：${hc.loggedInUser(abw)?.email}'),
                            Text('年龄：${hc.loggedInUser(abw)?.age}'),
                            ElevatedButton(
                              child: const Text('查看本地数据库'),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => DriftViewer(database: DriftDb.instance)));
                              },
                            ),
                            ElevatedButton(
                              child: const Text('插入测试数据'),
                              onPressed: () async {
                                SmartDialog.showToast('插入中...');
                                await c.inserts();
                                SmartDialog.showToast('插入成功');
                              },
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: TextField(controller: c.textEditingController),
                                ),
                                ElevatedButton(
                                  child: const Text('    分析    '),
                                  onPressed: () async {
                                    final ContextModel cm = ContextModel();
                                    cm.bindVariable(Variable('大苏打1'), Number(123));
                                    print(Parser().parse(c.textEditingController.text).evaluate(EvaluationType.REAL, cm));
                                  },
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(c.analysisResult(abw)),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                TextButton(
                                  child: Text('data'),
                                  onPressed: () {
                                    showDialog(context: Aber.find<GlobalAbController>().context, builder: (_) => IconButton(onPressed: () {}, icon: Icon(Icons.add)));
                                  },
                                ),
                              ],
                            ),
                            TextButton(
                              child: const Text('登录'),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(builder: (_) => const LoginPage()));
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }
}
