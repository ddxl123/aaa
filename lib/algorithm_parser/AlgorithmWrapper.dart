part of algorithm_parser;

/// [conditionUse] 和 [ifElseUseWrapper] 二选一。
@JsonSerializable()
class Ifer {
  Ifer({
    required this.condition,
    required this.use,
    required this.ifElseUseWrapper,
    required this.explain,
  });

  final String condition;
  final String? use;
  final IfElseUseWrapper? ifElseUseWrapper;
  final String? explain;

  factory Ifer.fromJson(Map<String, dynamic> json) => Ifer(
        condition: json["condition"] as String,
        use: json["use"] as String?,
        ifElseUseWrapper: json["if_else_use_wrapper"] == null ? null : IfElseUseWrapper.fromJson(json["if_else_use_wrapper"]),
        explain: json["explain"] as String?,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        "condition": this.condition,
        "use": this.use,
        "if_else_use_wrapper": this.ifElseUseWrapper,
        "explain": this.explain,
      };

  Future<bool> handle({
    required Future<bool> Function(String condition) conditionChecker,
    required Future<void> Function(String use) useChecker,
  }) async {
    final isTrue = await conditionChecker(condition);
    if (isTrue) {
      if (use != null) {
        await useChecker(use!);
      } else {
        final childrenIfer = ifElseUseWrapper!.ifers;
        for (int i = 0; i < childrenIfer.length; i++) {
          final childrenIferResult = await childrenIfer[i].handle(conditionChecker: conditionChecker, useChecker: useChecker);
          if (childrenIferResult) {
            return childrenIferResult;
          }
        }
        return await ifElseUseWrapper!.elser.handle(conditionChecker: conditionChecker, useChecker: useChecker);
      }
    }

    return isTrue;
  }

  Widget toWidget({required bool isElseIf}) {
    return Container(
      decoration: BoxDecoration(border: Border(left: BorderSide())),
      child: ExpansionTile(
        initiallyExpanded: true,
        controlAffinity: ListTileControlAffinity.leading,
        childrenPadding: EdgeInsets.fromLTRB(25, 0, 0, 0),
        title: GestureDetector(
          onLongPress: () {},
          child: Row(children: [Expanded(child: Text("${isElseIf ? "else if" : "if"}: ${condition}"))]),
        ),
        children: use == null
            ? ifElseUseWrapper!.toWidget()
            : [
                ListTile(
                  leading: Text(""),
                  title: Text("use: ${use!}"),
                ),
                ListTile(
                  leading: Text(""),
                  title: Text("解释: ${explain ?? "无"}"),
                ),
              ],
      ),
    );
  }
}

/// [use] 和 [ifElseUseWrapper] 二选一。
@JsonSerializable()
class Elser {
  Elser({
    required this.use,
    required this.ifElseUseWrapper,
    required this.explain,
  });

  final String? use;
  final IfElseUseWrapper? ifElseUseWrapper;
  final String? explain;

  factory Elser.fromJson(Map<String, dynamic> json) => Elser(
        use: json["use"] as String?,
        ifElseUseWrapper: json["if_else_use_wrapper"] == null ? null : IfElseUseWrapper.fromJson(json["if_else_use_wrapper"]),
        explain: json["explain"] as String?,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        "use": this.use,
        "if_else_use_wrapper": this.ifElseUseWrapper,
        "explain": this.explain,
      };

  Future<bool> handle({
    required Future<bool> Function(String condition) conditionChecker,
    required Future<void> Function(String use) useChecker,
  }) async {
    if (use != null) {
      await useChecker(use!);
      return true;
    } else {
      final childrenIfer = ifElseUseWrapper!.ifers;
      for (int i = 0; i < childrenIfer.length; i++) {
        final childrenIferResult = await childrenIfer[i].handle(conditionChecker: conditionChecker, useChecker: useChecker);
        if (childrenIferResult) {
          return childrenIferResult;
        }
      }
      return ifElseUseWrapper!.elser.handle(conditionChecker: conditionChecker, useChecker: useChecker);
    }
  }

  Widget toWidget() {
    return Container(
      decoration: BoxDecoration(border: Border(left: BorderSide())),
      child: ExpansionTile(
        initiallyExpanded: true,
        controlAffinity: ListTileControlAffinity.leading,
        childrenPadding: EdgeInsets.fromLTRB(25, 0, 0, 0),
        title: GestureDetector(
          onLongPress: () {},
          child: Row(
            children: [
              Expanded(
                child: Text("else"),
              ),
            ],
          ),
        ),
        children: use == null
            ? ifElseUseWrapper!.toWidget()
            : [
                ListTile(
                  leading: Text(""),
                  title: GestureDetector(
                    onLongPress: () {},
                    child: Row(
                      children: [
                        Expanded(
                          child: Text("use: ${use!}"),
                        ),
                      ],
                    ),
                  ),
                ),
                ListTile(
                  leading: Text(""),
                  title: GestureDetector(
                    onLongPress: () {},
                    child: Row(
                      children: [
                        Expanded(
                          child: Text("解释: ${explain ?? "无"}"),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
      ),
    );
  }
}

@JsonSerializable()
class IfElseUseWrapper {
  IfElseUseWrapper({
    required this.ifers,
    required this.elser,
  });

  final List<Ifer> ifers;
  final Elser elser;

  factory IfElseUseWrapper.fromJson(Map<String, dynamic> json) => IfElseUseWrapper(
        ifers: (json["ifers"] as List<dynamic>).map((e) => Ifer.fromJson(e as Map<String, dynamic>)).toList(),
        elser: Elser.fromJson(json["elser"]),
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        "ifers": this.ifers,
        "elser": this.elser,
      };

  Future<void> handle({
    required Future<bool> Function(String condition) conditionChecker,
    required Future<void> Function(String use) useChecker,
  }) async {
    for (int i = 0; i < ifers.length; i++) {
      final iferResult = await ifers[i].handle(conditionChecker: conditionChecker, useChecker: useChecker);
      if (iferResult) {
        return;
      }
    }
    await elser.handle(conditionChecker: conditionChecker, useChecker: useChecker);
  }

  List<Widget> toWidget() {
    return [
      for (int i = 0; i < ifers.length; i++) ifers[i].toWidget(isElseIf: i != 0),
      // ...ifers.map((e) => e.toWidget()).toList(),
      elser.toWidget(),
    ];
  }
}

@JsonSerializable()
class CustomVariable {
  CustomVariable({
    required this.name,
    required this.content,
    required this.explain,
  });

  String name;
  String content;
  String? explain;

  factory CustomVariable.fromJson(Map<String, dynamic> json) => CustomVariable(
        name: json["name"],
        content: json["content"],
        explain: json["explain"],
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        "name": this.name,
        "content": this.content,
        "explain": this.explain,
      };

  CustomVariable copy() => CustomVariable.fromJson(toJson());
}

@JsonSerializable()
class AlgorithmWrapper {
  AlgorithmWrapper({
    required this.customVariables,
    required this.ifElseUseWrapper,
  });

  final List<CustomVariable> customVariables;
  final IfElseUseWrapper ifElseUseWrapper;

  final customVariablesMap = <String, String>{};

  factory AlgorithmWrapper.fromJson(Map<String, dynamic> json) => AlgorithmWrapper(
        customVariables: (json["custom_variables"] as List<dynamic>).map((e) => CustomVariable.fromJson(e as Map<String, dynamic>)).toList(),
        ifElseUseWrapper: IfElseUseWrapper.fromJson(json["if_else_use_wrapper"]),
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        "custom_variables": this.customVariables,
        "if_else_use_wrapper": this.ifElseUseWrapper,
      };

  static fromJsonString(String content) => AlgorithmWrapper.fromJson(jsonDecode(content));

  String toJsonString() => jsonEncode(toJson());

  AlgorithmWrapper copy() => AlgorithmWrapper.fromJson(this.toJson());

  Widget toWidget() {
    return AbBuilder<MemoryModelGizmoEditPageAbController>(
      tag: Aber.single,
      builder: (c, abw) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Theme(
              data: ThemeData(
                dividerColor: Colors.transparent,
                splashFactory: NoSplash.splashFactory,
              ),
              child: ExpansionTile(
                controlAffinity: ListTileControlAffinity.leading,
                title: Text("自定义变量部分"),
                children: customVariables
                    .map(
                      (e) => ListTile(
                        title: Card(
                          elevation: 0,
                          color: Colors.lightGreenAccent,
                          child: Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.settings_outlined),
                                onPressed: () {
                                  showCustomDialog(
                                    builder: (_) => DialogWidget(
                                      fullPadding: EdgeInsets.zero,
                                      mainVerticalWidgetsAlignment: CrossAxisAlignment.center,
                                      mainVerticalWidgets: [
                                        Padding(
                                          padding: EdgeInsets.all(10),
                                          child: Text("对变量 ${e.name} 的操作"),
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: MaterialButton(
                                                child: Text("上移", style: TextStyle(color: Colors.blue)),
                                                onPressed: () {
                                                  final index = customVariables.indexOf(e);
                                                  if (index != 0) {
                                                    final before = customVariables[index - 1];
                                                    final after = customVariables[index];
                                                    customVariables.removeRange(index - 1, index + 1);
                                                    customVariables.insertAll(index - 1, [after, before]);
                                                  }
                                                  abw.refresh();
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: MaterialButton(
                                                child: Text("下移", style: TextStyle(color: Colors.blue)),
                                                onPressed: () {
                                                  final index = customVariables.indexOf(e);
                                                  if (index != customVariables.length - 1) {
                                                    final before = customVariables[index];
                                                    final after = customVariables[index + 1];
                                                    customVariables.removeRange(index, index + 2);
                                                    customVariables.insertAll(index, [after, before]);
                                                  }
                                                  abw.refresh();
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: MaterialButton(
                                                child: Text("删除", style: TextStyle(color: Colors.red)),
                                                onPressed: () {
                                                  customVariables.remove(e);
                                                  abw.refresh();
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                      bottomHorizontalButtonWidgets: [],
                                    ),
                                  );
                                },
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    GestureDetector(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(vertical: 10),
                                        child: Row(
                                          children: [
                                            Text("变量名：${e.name}"),
                                          ],
                                        ),
                                      ),
                                      onLongPress: () {
                                        showCustomDialog(
                                          builder: (_) => TextField1DialogWidget(
                                            textEditingController: TextEditingController(text: e.name),
                                            text: "变量名：${e.name}",
                                            inputDecoration: InputDecoration(
                                              hintText: "请输入变量名",
                                              prefix: Text(
                                                "修改为：",
                                                style: TextStyle(fontSize: 16),
                                              ),
                                            ),
                                            cancelText: "取消",
                                            okText: "确定",
                                            onOk: (tc) {
                                              e.name = tc.text;
                                              SmartDialog.dismiss(status: SmartStatus.dialog);
                                              abw.refresh();
                                            },
                                          ),
                                        );
                                      },
                                    ),
                                    GestureDetector(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(vertical: 10),
                                        child: Row(
                                          children: [
                                            Text("变量值：${e.content}"),
                                          ],
                                        ),
                                      ),
                                      onLongPress: () {
                                        showCustomDialog(
                                          builder: (_) => TextField1DialogWidget(
                                            textEditingController: TextEditingController(text: e.content),
                                            text: "变量值：${e.content}",
                                            inputDecoration: InputDecoration(
                                              hintText: "请输入变量值",
                                              prefix: Text(
                                                "修改为：",
                                                style: TextStyle(fontSize: 16),
                                              ),
                                            ),
                                            cancelText: "取消",
                                            okText: "确定",
                                            onOk: (tc) {
                                              e.content = tc.text;
                                              SmartDialog.dismiss(status: SmartStatus.dialog);
                                              abw.refresh();
                                            },
                                          ),
                                        );
                                      },
                                    ),
                                    GestureDetector(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(vertical: 10),
                                        child: Row(
                                          children: [
                                            Text("说明：${e.explain ?? "无"}"),
                                          ],
                                        ),
                                      ),
                                      onLongPress: () {
                                        showCustomDialog(
                                          builder: (_) => TextField1DialogWidget(
                                            textEditingController: TextEditingController(text: e.explain),
                                            text: "说明：${e.explain}",
                                            inputDecoration: InputDecoration(
                                              hintText: "请输入说明",
                                              prefix: Text(
                                                "修改为：",
                                                style: TextStyle(fontSize: 16),
                                              ),
                                            ),
                                            cancelText: "取消",
                                            okText: "确定",
                                            onOk: (tc) {
                                              e.explain = tc.text;
                                              SmartDialog.dismiss(status: SmartStatus.dialog);
                                              abw.refresh();
                                            },
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList()
                  ..add(
                    ListTile(
                      title: Card(
                        elevation: 0,
                        color: Colors.lightGreenAccent,
                        child: MaterialButton(
                          child: Row(
                            children: [
                              Icon(Icons.add, color: Colors.blue),
                              SizedBox(width: 10),
                              Text("增加自定义变量", style: TextStyle(color: Colors.blue)),
                            ],
                          ),
                          onPressed: () {
                            customVariables.add(
                              CustomVariable(name: "throw 未处理变量名", content: "throw 未处理变量值", explain: "无"),
                            );
                            abw.refresh();
                          },
                        ),
                      ),
                    ),
                  ),
              ),
            ),
            Theme(
              data: ThemeData(
                dividerColor: Colors.transparent,
                splashFactory: NoSplash.splashFactory,
              ),
              child: ExpansionTile(
                controlAffinity: ListTileControlAffinity.leading,
                initiallyExpanded: true,
                childrenPadding: EdgeInsets.fromLTRB(25, 0, 0, 0),
                title: Text("if-else-use 部分"),
                children: [
                  ...ifElseUseWrapper.toWidget(),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
