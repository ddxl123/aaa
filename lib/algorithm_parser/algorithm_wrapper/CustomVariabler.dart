part of algorithm_parser;

class CustomVariabler {
  CustomVariabler({
    required this.name,
    required this.content,
    required this.explain,
  });

  String name;
  String content;
  String? explain;

  Function? refresh;

  KnownAlgorithmException? nameAlgorithmException;
  KnownAlgorithmException? contentAlgorithmException;

  void setNameAlgorithmException({required KnownAlgorithmException? algorithmException}) {
    if (algorithmException == nameAlgorithmException) return;
    nameAlgorithmException = algorithmException;
    refresh?.call();
  }

  void setContentAlgorithmException({required KnownAlgorithmException? algorithmException}) {
    if (algorithmException == contentAlgorithmException) return;
    contentAlgorithmException = algorithmException;
    refresh?.call();
  }

  void cancelAllException() {
    setNameAlgorithmException(algorithmException: null);
    setContentAlgorithmException(algorithmException: null);
  }

  factory CustomVariabler.fromJson(Map<String, dynamic> json) => CustomVariabler(
        name: json["name"],
        content: json["content"],
        explain: json["explain"],
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        "name": this.name,
        "content": this.content,
        "explain": this.explain,
      };

  CustomVariabler copy() => CustomVariabler.fromJson(toJson());

  static CustomVariabler emptyCustomVariabler = CustomVariabler(name: "throw 未处理", content: "throw 未处理", explain: null);

  void resetToEmpty() {
    name = "throw 未处理";
    content = "throw 未处理";
    explain = null;
  }

  Widget toWidget({required AlgorithmWrapper algorithmWrapper}) {
    return AbwBuilder(
      builder: (abw) {
        refresh = abw.refresh;
        return ListTile(
          title: Card(
            elevation: 0,
            child: Row(
              children: [
                _settingWidget(algorithmWrapper: algorithmWrapper),
                Expanded(child: _bodyWidget(algorithmWrapper: algorithmWrapper)),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _settingWidget({required AlgorithmWrapper algorithmWrapper}) {
    return IconButton(
      icon: Icon(Icons.settings_outlined),
      onPressed: () {
        showCustomDialog(
          builder: (_) => DialogWidget(
            fullPadding: EdgeInsets.zero,
            mainVerticalWidgetsAlignment: CrossAxisAlignment.center,
            mainVerticalWidgets: [
              Padding(
                padding: EdgeInsets.all(10),
                child: Text("对变量 $name 的操作"),
              ),
              Row(
                children: [
                  Expanded(
                    child: MaterialButton(
                      child: Text("上移", style: TextStyle(color: Colors.blue)),
                      onPressed: () {
                        final index = algorithmWrapper.customVariables.indexOf(this);
                        if (index != 0) {
                          final before = algorithmWrapper.customVariables[index - 1];
                          final after = algorithmWrapper.customVariables[index];
                          algorithmWrapper.customVariables.removeRange(index - 1, index + 1);
                          algorithmWrapper.customVariables.insertAll(index - 1, [after, before]);
                        }
                        algorithmWrapper.refresh?.call();
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
                        final index = algorithmWrapper.customVariables.indexOf(this);
                        if (index != algorithmWrapper.customVariables.length - 1) {
                          final before = algorithmWrapper.customVariables[index];
                          final after = algorithmWrapper.customVariables[index + 1];
                          algorithmWrapper.customVariables.removeRange(index, index + 2);
                          algorithmWrapper.customVariables.insertAll(index, [after, before]);
                        }
                        algorithmWrapper.refresh?.call();
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
                              algorithmWrapper.customVariables.remove(this);
                              algorithmWrapper.refresh?.call();
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
    );
  }

  Widget _bodyWidget({required AlgorithmWrapper algorithmWrapper}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        AlgorithmExceptionBackgroundWidget(
          algorithmException: nameAlgorithmException,
          child: GestureDetector(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  Text("变量名：$name"),
                  ...algorithmExceptionTextWidgetList(algorithmException: nameAlgorithmException),
                ],
              ),
            ),
            onLongPress: () {
              showCustomDialog(
                builder: (_) => TextField1DialogWidget(
                  textEditingController: TextEditingController(text: name),
                  text: "变量名：$name",
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
                    name = tc.text;
                    SmartDialog.dismiss(status: SmartStatus.dialog);
                    refresh?.call();
                  },
                ),
              );
            },
          ),
        ),
        AlgorithmExceptionBackgroundWidget(
          algorithmException: contentAlgorithmException,
          child: GestureDetector(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  Text("变量值：$content"),
                  ...algorithmExceptionTextWidgetList(algorithmException: contentAlgorithmException),
                ],
              ),
            ),
            onLongPress: () {
              showCustomDialog(
                builder: (_) => TextField1DialogWidget(
                  textEditingController: TextEditingController(text: content),
                  text: "变量值：$content",
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
                    content = tc.text;
                    SmartDialog.dismiss(status: SmartStatus.dialog);
                    refresh?.call();
                  },
                ),
              );
            },
          ),
        ),
        GestureDetector(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                Text("说明：${explain ?? "无"}"),
              ],
            ),
          ),
          onLongPress: () {
            showCustomDialog(
              builder: (_) => TextField1DialogWidget(
                textEditingController: TextEditingController(text: explain),
                text: "说明：$explain",
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
                  explain = tc.text;
                  SmartDialog.dismiss(status: SmartStatus.dialog);
                  refresh?.call();
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
