import 'package:drift_main/DriftViewer.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:tools/tools.dart';
import 'package:drift_main/DriftDb.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'dart:math';

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
                          Text('当前用户 id：${c.user(abw)?.id}'),
                          Text('用户名：${c.user(abw)?.username}'),
                          Text('密码：${c.user(abw)?.password}'),
                          Text('邮箱：${c.user(abw)?.email}'),
                          Text('年龄：${c.user(abw)?.age}'),
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
                                onPressed: () {
                                  Variable x = Variable('x');
                                  Variable y = Variable('y');
                                  ContextModel cm = ContextModel()
                                    ..bindVariable(x, Number(2.0))
                                    ..bindVariable(y, Number(5));
                                  Expression exp = Parser().parse(c.textEditingController.text);
                                  // print(exp.evaluate(EvaluationType.REAL, cm));

                                  print(exp);
                                },
                              ),
                            ],
                          )
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
  }
}
