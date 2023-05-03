part of algorithm_parser;

/// [use] 和 [ifElseUseWrapper] 二选一。
class Elser {
  Elser({
    required this.use,
    required this.ifElseUseWrapper,
    required this.explain,
  });

  String? use;
  IfUseElseWrapper? ifElseUseWrapper;
  String? explain;

  Function? refresh;

  KnownAlgorithmException? useAlgorithmException;

  void setUseAlgorithmException({required KnownAlgorithmException? algorithmException}) {
    if (algorithmException == useAlgorithmException) return;
    useAlgorithmException = algorithmException;
    refresh?.call();
  }

  void cancelAllException() {
    setUseAlgorithmException(algorithmException: null);
  }

  factory Elser.fromJson(Map<String, dynamic> json) => Elser(
        use: json["use"] as String?,
        ifElseUseWrapper: json["if_else_use_wrapper"] == null ? null : IfUseElseWrapper.fromJson(json["if_else_use_wrapper"]),
        explain: json["explain"] as String?,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        "use": this.use,
        "if_else_use_wrapper": this.ifElseUseWrapper?.toJson(),
        "explain": this.explain,
      };

  static Elser emptyElser = Elser(use: "throw 未处理", ifElseUseWrapper: null, explain: null);

  void resetToEmpty() {
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
    if (use != null) {
      await elseChecker(this, use!);
      return true;
    } else {
      final childrenIfer = ifElseUseWrapper!.ifers;
      for (int i = 0; i < childrenIfer.length; i++) {
        final childrenIferResult = await childrenIfer[i].handle(conditionChecker: conditionChecker, useChecker: useChecker, elseChecker: elseChecker);
        if (childrenIferResult) {
          return childrenIferResult;
        }
      }
      return ifElseUseWrapper!.elser.handle(conditionChecker: conditionChecker, useChecker: useChecker, elseChecker: elseChecker);
    }
  }

  Widget toWidget({required IfUseElseWrapper father, required AlgorithmWrapper algorithmWrapper}) {
    return AbwBuilder(
      builder: (abw) {
        refresh = abw.refresh;
        return Container(
          decoration: BoxDecoration(border: Border(left: BorderSide())),
          child: ExpansionTile(
            initiallyExpanded: true,
            controlAffinity: ListTileControlAffinity.leading,
            childrenPadding: EdgeInsets.fromLTRB(25, 0, 0, 0),
            title: _titleWidget(father: father, algorithmWrapper: algorithmWrapper),
            children: _childrenWidget(father: father, algorithmWrapper: algorithmWrapper),
          ),
        );
      },
    );
  }

  Widget _titleWidget({required IfUseElseWrapper father, required AlgorithmWrapper algorithmWrapper}) {
    return GestureDetector(
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
                  father.ifers.add(Ifer.emptyIfer);
                  algorithmWrapper.refresh?.call();
                  SmartDialog.dismiss(status: SmartStatus.dialog);
                  SmartDialog.dismiss(status: SmartStatus.dialog);
                },
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
              TextButton(
                child: Text("清空当前 else", style: TextStyle(color: Colors.red)),
                onPressed: () {
                  resetToEmpty();
                  refresh?.call();
                  SmartDialog.dismiss(status: SmartStatus.dialog);
                },
              ),
            ],
            bottomHorizontalButtonWidgets: [],
          ),
        );
      },
    );
  }

  List<Widget> _childrenWidget({required IfUseElseWrapper father, required AlgorithmWrapper algorithmWrapper}) {
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
