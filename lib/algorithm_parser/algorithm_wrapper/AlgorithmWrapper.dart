part of algorithm_parser;

class AlgorithmWrapper {
  AlgorithmWrapper({
    required this.customVariables,
    required this.ifUseElseWrapper,
  });

  final List<CustomVariabler> customVariables;
  final IfUseElseWrapper ifUseElseWrapper;

  final customVariablesMap = <String, String>{};

  Function? refresh;

  factory AlgorithmWrapper.fromJson(Map<String, dynamic> json) => AlgorithmWrapper(
        customVariables: (json["custom_variables"] as List<dynamic>).map((e) => CustomVariabler.fromJson(e as Map<String, dynamic>)).toList(),
        ifUseElseWrapper: IfUseElseWrapper.fromJson(json["if_else_use_wrapper"]),
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        "custom_variables": this.customVariables.map((e) => e.toJson()).toList(),
        "if_else_use_wrapper": this.ifUseElseWrapper.toJson(),
      };

  static fromJsonString(String content) => AlgorithmWrapper.fromJson(jsonDecode(content));

  /// 将 Map 格式转换成 jsonString 格式，可以以文本的方式保存到数据库。
  String toJsonString() => jsonEncode(toJson());

  AlgorithmWrapper copy() => AlgorithmWrapper.fromJson(this.toJson());

  static AlgorithmWrapper emptyAlgorithmWrapper = AlgorithmWrapper(
    customVariables: [],
    ifUseElseWrapper: IfUseElseWrapper(
      ifers: [Ifer.emptyIfer],
      elser: Elser.emptyElser,
    ),
  );

  void clearCustomVariable() {
    customVariables.clear();
    customVariablesMap.clear();
  }

  void clearIfElseUseWrapper() {
    ifUseElseWrapper.ifers.clear();
    ifUseElseWrapper.ifers.add(Ifer.emptyIfer);
    ifUseElseWrapper.elser.resetToEmpty();
  }

  void cancelAllException() {
    customVariables.forEach((element) {
      element.cancelAllException();
    });
    ifUseElseWrapper.cancelAllException();
  }

  Widget toWidget() {
    return AbBuilder<MemoryModelGizmoEditPageAbController>(
      tag: Aber.single,
      builder: (c, abw) {
        refresh = abw.refresh;
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _customVariablesWidget(abw),
            _ifElseUsesWidget(abw),
          ],
        );
      },
    );
  }

  Widget _customVariablesWidget(Abw abw) {
    return Theme(
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
        children: customVariables.map((e) => e.toWidget(algorithmWrapper: this)).toList()
          ..add(
            ListTile(
              title: Card(
                elevation: 0,
                child: MaterialButton(
                  child: Row(
                    children: [
                      Icon(Icons.add, color: Colors.blue),
                      SizedBox(width: 10),
                      Text("增加自定义变量", style: TextStyle(color: Colors.blue)),
                    ],
                  ),
                  onPressed: () {
                    customVariables.add(CustomVariabler.emptyCustomVariabler);
                    abw.refresh();
                  },
                ),
              ),
            ),
          ),
      ),
    );
  }

  Widget _ifElseUsesWidget(Abw abw) {
    return Theme(
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
          ...ifUseElseWrapper.toWidget(algorithmWrapper: this),
        ],
      ),
    );
  }
}
