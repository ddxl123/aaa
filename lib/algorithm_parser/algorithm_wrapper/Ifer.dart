part of algorithm_parser;

/// [use] 和 [ifElseUseWrapper] 二选一。
class Ifer {
  Ifer({
    required this.condition,
    required this.use,
    required this.ifElseUseWrapper,
    required this.explain,
  });

  String condition;
  String? use;
  IfUseElseWrapper? ifElseUseWrapper;
  String? explain;

  Function? refresh;

  KnownAlgorithmException? conditionAlgorithmException;
  KnownAlgorithmException? useAlgorithmException;

  void setConditionAlgorithmException({required KnownAlgorithmException? algorithmException}) {
    if (algorithmException == conditionAlgorithmException) return;
    conditionAlgorithmException = algorithmException;
    refresh?.call();
  }

  void setUseAlgorithmException({required KnownAlgorithmException? algorithmException}) {
    if (algorithmException == useAlgorithmException) return;
    useAlgorithmException = algorithmException;
    refresh?.call();
  }

  void cancelAllException() {
    setUseAlgorithmException(algorithmException: null);
    setConditionAlgorithmException(algorithmException: null);
  }

  factory Ifer.fromJson(Map<String, dynamic> json) => Ifer(
        condition: json["condition"] as String,
        use: json["use"] as String?,
        ifElseUseWrapper: json["if_else_use_wrapper"] == null ? null : IfUseElseWrapper.fromJson(json["if_else_use_wrapper"]),
        explain: json["explain"] as String?,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        "condition": this.condition,
        "use": this.use,
        "if_else_use_wrapper": this.ifElseUseWrapper?.toJson(),
        "explain": this.explain,
      };

  static Ifer emptyIfer = Ifer(condition: "throw 未处理", use: "throw 未处理", ifElseUseWrapper: null, explain: null);

  void resetToEmpty() {
    condition = "throw 未处理";
    use = "throw 未处理";
    ifElseUseWrapper = null;
    explain = null;
  }

  void clearChildren() {
    use = "throw 未处理";
    ifElseUseWrapper = null;
  }

  Future<bool> handle({
    required Future<bool> Function(Ifer ifer, String condition) conditionChecker,
    required Future<void> Function(Ifer ifer, String use) useChecker,
    required Future<void> Function(Elser elser, String use) elseChecker,
  }) async {
    final isTrue = await conditionChecker(this, condition);
    if (isTrue) {
      if (use != null) {
        await useChecker(this, use!);
      } else {
        final childrenIfer = ifElseUseWrapper!.ifers;
        for (int i = 0; i < childrenIfer.length; i++) {
          final childrenIferResult = await childrenIfer[i].handle(conditionChecker: conditionChecker, useChecker: useChecker, elseChecker: elseChecker);
          if (childrenIferResult) {
            return childrenIferResult;
          }
        }
        return await ifElseUseWrapper!.elser.handle(conditionChecker: conditionChecker, useChecker: useChecker, elseChecker: elseChecker);
      }
    }

    return isTrue;
  }

  Widget toWidget({required bool isElseIf, required IfUseElseWrapper father, required AlgorithmWrapper algorithmWrapper}) {
    return AbwBuilder(
      builder: (abw) {
        refresh = abw.refresh;
        return Container(
          decoration: BoxDecoration(border: Border(left: BorderSide())),
          child: ExpansionTile(
            initiallyExpanded: true,
            controlAffinity: ListTileControlAffinity.leading,
            childrenPadding: EdgeInsets.fromLTRB(25, 0, 0, 0),
            title: _titleWidget(isElseIf: isElseIf, father: father, algorithmWrapper: algorithmWrapper),
            children: _childrenWidget(isElseIf: isElseIf, father: father, algorithmWrapper: algorithmWrapper),
          ),
        );
      },
    );
  }

  Widget _titleWidget({required bool isElseIf, required IfUseElseWrapper father, required AlgorithmWrapper algorithmWrapper}) {
    return AlgorithmExceptionBackgroundWidget(
      algorithmException: conditionAlgorithmException,
      child: GestureDetector(
        child: Row(
          children: [
            Text("${isElseIf ? "else if" : "if"}: ${condition}"),
            ...algorithmExceptionTextWidgetList(algorithmException: conditionAlgorithmException),
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
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
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
                                refresh?.call();
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
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        child: Text("添加子 if-else 语句"),
                        onPressed: () {
                          ifElseUseWrapper = IfUseElseWrapper.emptyIfUseElseWrapperWithInit(
                            Ifer(condition: "throw 未处理", use: use, ifElseUseWrapper: null, explain: explain),
                          );
                          use = null;
                          refresh?.call();
                          SmartDialog.dismiss(status: SmartStatus.dialog);
                          SmartDialog.dismiss(status: SmartStatus.dialog);
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        child: Text("增加一个与当前并列 if"),
                        onPressed: () {
                          father.ifers.insert(father.ifers.indexOf(this) + 1, Ifer.emptyIfer);
                          algorithmWrapper.refresh?.call();
                          SmartDialog.dismiss(status: SmartStatus.dialog);
                          SmartDialog.dismiss(status: SmartStatus.dialog);
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
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
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
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
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        child: Text("移除当前 ${isElseIf ? "else if" : "if"}", style: TextStyle(color: Colors.red)),
                        onPressed: () {
                          father.remove(ifer: this);
                          algorithmWrapper.refresh?.call();
                          SmartDialog.dismiss(status: SmartStatus.dialog);
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: ifElseUseWrapper == null
                          ? Container()
                          : TextButton(
                              child: Text("清空全部子项", style: TextStyle(color: Colors.red)),
                              onPressed: () {
                                clearChildren();
                                refresh?.call();
                                SmartDialog.dismiss(status: SmartStatus.dialog);
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
    );
  }

  List<Widget> _childrenWidget({required bool isElseIf, required IfUseElseWrapper father, required AlgorithmWrapper algorithmWrapper}) {
    return use == null
        ? ifElseUseWrapper!.toWidget(algorithmWrapper: algorithmWrapper)
        : [
            ListTile(
              leading: Text(""),
              title: AlgorithmExceptionBackgroundWidget(
                algorithmException: useAlgorithmException,
                child: GestureDetector(
                  child: Row(
                    children: [
                      Text("use: ${use!}"),
                      ...algorithmExceptionTextWidgetList(algorithmException: useAlgorithmException),
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
                          refresh?.call();
                          SmartDialog.dismiss(status: SmartStatus.dialog);
                          SmartDialog.dismiss(status: SmartStatus.dialog);
                        },
                      ),
                    );
                  },
                ),
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
                        refresh?.call();
                        SmartDialog.dismiss(status: SmartStatus.dialog);
                        SmartDialog.dismiss(status: SmartStatus.dialog);
                      },
                    ),
                  );
                },
              ),
            ),
          ];
  }
}
