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

  String condition;
  String? use;
  IfElseUseWrapper? ifElseUseWrapper;
  String? explain;

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

  Widget toWidget({required bool isElseIf, required IfElseUseWrapper father, required AlgorithmWrapper algorithmWrapper}) {
    return AbwBuilder(
      builder: (abw) {
        return Container(
          decoration: BoxDecoration(border: Border(left: BorderSide())),
          child: ExpansionTile(
            initiallyExpanded: true,
            controlAffinity: ListTileControlAffinity.leading,
            childrenPadding: EdgeInsets.fromLTRB(25, 0, 0, 0),
            title: GestureDetector(
              child: Row(
                children: [
                  Expanded(
                    child: Text("${isElseIf ? "else if" : "if"}: ${condition}"),
                  ),
                ],
              ),
              onLongPress: () {
                showCustomDialog(
                  builder: (_) => DialogWidget(
                    mainVerticalWidgets: [
                      Row(
                        children: [
                          Expanded(
                            child: Text("${isElseIf ? "else if" : "if"}: ${condition}"),
                          ),
                        ],
                      ),
                      TextButton(
                        child: Text("编辑当前 ${isElseIf ? "else if" : "if"}"),
                        onPressed: () {
                          showCustomDialog(
                            builder: (_) => TextField1DialogWidget(
                              textEditingController: TextEditingController(text: condition),
                              text: "当前： $condition",
                              cancelText: "取消",
                              okText: "确定",
                              onOk: (tec) {
                                condition = tec.text;
                                abw.refresh();
                                SmartDialog.dismiss(status: SmartStatus.dialog);
                                SmartDialog.dismiss(status: SmartStatus.dialog);
                              },
                            ),
                          );
                        },
                      ),
                      TextButton(
                        child: Text("增加一个与当前并列 if"),
                        onPressed: () {
                          father.ifers.insert(
                            father.ifers.indexOf(this) + 1,
                            Ifer(condition: "throw 未处理", use: "throw 未处理", ifElseUseWrapper: null, explain: "无"),
                          );
                          algorithmWrapper.refresh?.call();
                          SmartDialog.dismiss(status: SmartStatus.dialog);
                          SmartDialog.dismiss(status: SmartStatus.dialog);
                        },
                      ),
                      TextButton(
                        child: Text("if 上移"),
                        onPressed: () {
                          final index = father.ifers.indexOf(this);
                          if (index != 0) {
                            final before = father.ifers[index - 1];
                            final after = father.ifers[index];
                            father.ifers.removeRange(index - 1, index + 1);
                            father.ifers.insertAll(index - 1, [after, before]);
                          }
                          algorithmWrapper.refresh?.call();
                          SmartDialog.dismiss(status: SmartStatus.dialog);
                          SmartDialog.dismiss(status: SmartStatus.dialog);
                        },
                      ),
                      TextButton(
                        child: Text("if 下移"),
                        onPressed: () {
                          final index = father.ifers.indexOf(this);
                          if (index != father.ifers.length - 1) {
                            final before = father.ifers[index];
                            final after = father.ifers[index + 1];
                            father.ifers.removeRange(index, index + 2);
                            father.ifers.insertAll(index, [after, before]);
                          }
                          algorithmWrapper.refresh?.call();
                          SmartDialog.dismiss(status: SmartStatus.dialog);
                          SmartDialog.dismiss(status: SmartStatus.dialog);
                        },
                      ),
                      TextButton(
                        child: Text("移除当前 ${isElseIf ? "else if" : "if"}", style: TextStyle(color: Colors.red)),
                        onPressed: () {
                          father.remove(ifer: this);
                          algorithmWrapper.refresh?.call();
                          SmartDialog.dismiss(status: SmartStatus.dialog);
                        },
                      ),
                      ifElseUseWrapper == null
                          ? Container()
                          : TextButton(
                              child: Text("清空全部子项", style: TextStyle(color: Colors.red)),
                              onPressed: () {
                                ifElseUseWrapper = null;
                                use = "throw 未处理";
                                abw.refresh();
                                SmartDialog.dismiss(status: SmartStatus.dialog);
                              },
                            ),
                    ],
                    bottomHorizontalButtonWidgets: [],
                  ),
                );
              },
            ),
            children: use == null
                ? ifElseUseWrapper!.toWidget(algorithmWrapper: algorithmWrapper)
                : [
                    ListTile(
                      leading: Text(""),
                      title: GestureDetector(
                        child: Text("use: ${use!}"),
                        onLongPress: () {
                          showCustomDialog(
                            builder: (_) => TextField1DialogWidget(
                              textEditingController: TextEditingController(text: use),
                              text: "当前： $use",
                              cancelText: "取消",
                              okText: "确定",
                              onOk: (tec) {
                                use = tec.text;
                                abw.refresh();
                                SmartDialog.dismiss(status: SmartStatus.dialog);
                                SmartDialog.dismiss(status: SmartStatus.dialog);
                              },
                            ),
                          );
                        },
                      ),
                    ),
                    ListTile(
                      leading: Text(""),
                      title: GestureDetector(
                        child: Text("解释: ${explain ?? "无"}"),
                        onLongPress: () {
                          showCustomDialog(
                            builder: (_) => TextField1DialogWidget(
                              textEditingController: TextEditingController(text: explain),
                              text: "当前： $explain",
                              cancelText: "取消",
                              okText: "确定",
                              onOk: (tec) {
                                explain = tec.text;
                                abw.refresh();
                                SmartDialog.dismiss(status: SmartStatus.dialog);
                                SmartDialog.dismiss(status: SmartStatus.dialog);
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ],
          ),
        );
      },
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

  String? use;
  IfElseUseWrapper? ifElseUseWrapper;
  String? explain;

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

  Widget toWidget({required IfElseUseWrapper father, required AlgorithmWrapper algorithmWrapper}) {
    return AbwBuilder(
      builder: (abw) {
        return Container(
          decoration: BoxDecoration(border: Border(left: BorderSide())),
          child: ExpansionTile(
            initiallyExpanded: true,
            controlAffinity: ListTileControlAffinity.leading,
            childrenPadding: EdgeInsets.fromLTRB(25, 0, 0, 0),
            title: GestureDetector(
              child: Row(
                children: [
                  Expanded(
                    child: Text("else"),
                  ),
                ],
              ),
              onLongPress: () {
                showCustomDialog(
                  builder: (_) => DialogWidget(
                    mainVerticalWidgets: [
                      TextButton(
                        child: Text("增加一个与当前并列 if"),
                        onPressed: () {
                          father.ifers.add(
                            Ifer(condition: "throw 未处理", use: "throw 未处理", ifElseUseWrapper: null, explain: "无"),
                          );
                          algorithmWrapper.refresh?.call();
                          SmartDialog.dismiss(status: SmartStatus.dialog);
                          SmartDialog.dismiss(status: SmartStatus.dialog);
                        },
                      ),
                      TextButton(
                        child: Text("清空当前 else", style: TextStyle(color: Colors.red)),
                        onPressed: () {
                          use = "throw 未处理";
                          explain = "无";
                          ifElseUseWrapper = null;
                          abw.refresh();
                          SmartDialog.dismiss(status: SmartStatus.dialog);
                        },
                      ),
                    ],
                    bottomHorizontalButtonWidgets: [],
                  ),
                );
              },
            ),
            children: use == null
                ? ifElseUseWrapper!.toWidget(algorithmWrapper: algorithmWrapper)
                : [
                    ListTile(
                      leading: Text(""),
                      title: GestureDetector(
                        child: Row(
                          children: [
                            Expanded(
                              child: Text("use: ${use!}"),
                            ),
                          ],
                        ),
                        onLongPress: () {
                          showCustomDialog(
                            builder: (_) => TextField1DialogWidget(
                              textEditingController: TextEditingController(text: use),
                              text: "当前： $use",
                              cancelText: "取消",
                              okText: "确定",
                              onOk: (tec) {
                                use = tec.text;
                                abw.refresh();
                                SmartDialog.dismiss(status: SmartStatus.dialog);
                                SmartDialog.dismiss(status: SmartStatus.dialog);
                              },
                            ),
                          );
                        },
                      ),
                    ),
                    ListTile(
                      leading: Text(""),
                      title: GestureDetector(
                        child: Row(
                          children: [
                            Expanded(
                              child: Text("解释: ${explain ?? "无"}"),
                            ),
                          ],
                        ),
                        onLongPress: () {
                          showCustomDialog(
                            builder: (_) => TextField1DialogWidget(
                              textEditingController: TextEditingController(text: explain),
                              text: "当前： $explain",
                              cancelText: "取消",
                              okText: "确定",
                              onOk: (tec) {
                                explain = tec.text;
                                abw.refresh();
                                SmartDialog.dismiss(status: SmartStatus.dialog);
                                SmartDialog.dismiss(status: SmartStatus.dialog);
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ],
          ),
        );
      },
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

  List<Widget> toWidget({required AlgorithmWrapper algorithmWrapper}) {
    return [
      for (int i = 0; i < ifers.length; i++) ifers[i].toWidget(isElseIf: i != 0, father: this, algorithmWrapper: algorithmWrapper),
      // ...ifers.map((e) => e.toWidget()).toList(),
      elser.toWidget(father: this, algorithmWrapper: algorithmWrapper),
    ];
  }

  void remove({required Ifer ifer}) {
    ifers.remove(ifer);
    if (ifers.isEmpty) {
      ifers.add(Ifer(condition: "throw 未处理", use: "未处理", ifElseUseWrapper: null, explain: "无"));
    }
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

  Function? refresh;

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

  void clearCustomVariable() {
    customVariables.clear();
    customVariablesMap.clear();
  }

  void clearIfElseUseWrapper() {
    ifElseUseWrapper.ifers.clear();
    ifElseUseWrapper.ifers.add(
      Ifer(
        condition: "throw 未处理",
        use: "throw 未处理",
        ifElseUseWrapper: null,
        explain: null,
      ),
    );
    ifElseUseWrapper.elser.explain = null;
    ifElseUseWrapper.elser.ifElseUseWrapper = null;
    ifElseUseWrapper.elser.use = "throw 未处理";
  }

  Widget toWidget() {
    return AbBuilder<MemoryModelGizmoEditPageAbController>(
      tag: Aber.single,
      builder: (c, abw) {
        refresh = abw.refresh;
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
                initiallyExpanded: true,
                title: GestureDetector(
                  child: Text("自定义变量部分"),
                  onLongPress: () {
                    showCustomDialog(
                      builder: (_) => DialogWidget(
                        mainVerticalWidgets: [
                          TextButton(
                            child: Text("清空自定义变量", style: TextStyle(color: Colors.red)),
                            onPressed: () {
                              showCustomDialog(
                                builder: (_) => OkAndCancelDialogWidget(
                                  title: "确定清空？",
                                  okText: "确定",
                                  cancelText: "取消",
                                  onOk: () {
                                    clearCustomVariable();
                                    abw.refresh();
                                    SmartDialog.dismiss(status: SmartStatus.dialog);
                                    SmartDialog.dismiss(status: SmartStatus.dialog);
                                  },
                                ),
                              );
                            },
                          ),
                          SizedBox(height: 10),
                        ],
                        bottomHorizontalButtonWidgets: [],
                      ),
                    );
                  },
                ),
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
                                                onPressed: () async {
                                                  await showCustomDialog(
                                                    builder: (_) => OkAndCancelDialogWidget(
                                                      title: "确定删除？",
                                                      okText: "确定",
                                                      cancelText: "取消",
                                                      onOk: () {
                                                        customVariables.remove(e);
                                                        abw.refresh();
                                                        SmartDialog.dismiss(status: SmartStatus.dialog);
                                                        SmartDialog.dismiss(status: SmartStatus.dialog);
                                                      },
                                                    ),
                                                  );
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
                title: GestureDetector(
                  child: Text("if-else-use 部分"),
                  onLongPress: () {
                    showCustomDialog(
                      builder: (_) => DialogWidget(
                        mainVerticalWidgets: [
                          TextButton(
                            child: Text("清空自定义变量", style: TextStyle(color: Colors.red)),
                            onPressed: () {
                              showCustomDialog(
                                builder: (_) => OkAndCancelDialogWidget(
                                  title: "确定清空？",
                                  okText: "确定",
                                  cancelText: "取消",
                                  onOk: () {
                                    clearIfElseUseWrapper();
                                    abw.refresh();
                                    SmartDialog.dismiss(status: SmartStatus.dialog);
                                    SmartDialog.dismiss(status: SmartStatus.dialog);
                                  },
                                ),
                              );
                            },
                          ),
                          SizedBox(height: 10),
                        ],
                        bottomHorizontalButtonWidgets: [],
                      ),
                    );
                  },
                ),
                children: [
                  ...ifElseUseWrapper.toWidget(algorithmWrapper: this),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
