import 'package:drift_main/httper/httper.dart';
import 'package:flutter/material.dart';
import 'package:tools/tools.dart';

Future<void> showKnowledgeBaseCategory({
  required BuildContext context,
  required Ab<List<String>> initSelectedSubCategories,
}) async {
  await Navigator.of(context).push(
    DialogRoute(
      context: context,
      builder: (c) => KnowledgeBaseCategoryWidget(initSelectedSubCategories: initSelectedSubCategories),
    ),
  );
}

class KnowledgeBaseCategoryWidget extends StatefulWidget {
  const KnowledgeBaseCategoryWidget({super.key, required this.initSelectedSubCategories});

  final Ab<List<String>> initSelectedSubCategories;

  @override
  State<KnowledgeBaseCategoryWidget> createState() => _KnowledgeBaseCategoryWidgetState();
}

class _KnowledgeBaseCategoryWidgetState extends State<KnowledgeBaseCategoryWidget> {
  final nKey = GlobalKey<NavigatorState>();
  final selectedSubCategories = <String>[];

  bool isSelectedFor(String name) {
    return selectedSubCategories.contains(name);
  }

  void changeSelect(String name) {
    if (isSelectedFor(name)) {
      selectedSubCategories.remove(name);
    } else {
      selectedSubCategories.add(name);
    }
  }

  /// 不会触发 [WillPopScope]
  void closeDialog(bool isConfirm) {
    if (isConfirm) {
      widget.initSelectedSubCategories.refreshInevitable(
        (obj) => obj
          ..clear()
          ..addAll(selectedSubCategories),
      );
      Navigator.pop(context);
    } else {
      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    super.initState();
    selectedSubCategories.addAll(widget.initSelectedSubCategories());
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Dialog(
        child: Navigator(
          key: nKey,
          initialRoute: "/",
          onGenerateRoute: (settings) {
            late Widget page;
            switch (settings.name) {
              case "/":
                page = _Init(homeState: this);
              case "/sub":
                page = _Sub(bigName: settings.arguments.toString(), firstState: this);
              default:
                throw "未处理：${settings.name}";
            }
            return MaterialPageRoute(
              builder: (c) => page,
              settings: settings,
            );
          },
        ),
      ),
      onWillPop: () async {
        final canPop = nKey.currentState?.canPop();
        if (canPop ?? false) {
          nKey.currentState?.pop();
          return false;
        } else {
          return true;
        }
      },
    );
  }
}

class _Init extends StatefulWidget {
  const _Init({super.key, required this.homeState});

  final _KnowledgeBaseCategoryWidgetState homeState;

  @override
  State<_Init> createState() => _InitState();
}

class _InitState extends State<_Init> {
  /// 精选子类别
  final fines = <String>[];

  /// 大类别
  final bigs = <String>[];

  @override
  void initState() {
    super.initState();
    _queryInit();
  }

  Future<void> _queryInit() async {
    final result = await request(
      path: HttpPath.POST__NO_LOGIN_REQUIRED_KNOWLEDGE_BASE_QUERY_KNOWLEDGE_BASE_CATEGORYS,
      dtoData: KnowledgeBaseCategoryQueryDto(
        big_category: null,
        dto_padding_1: null,
      ),
      parseResponseVoData: KnowledgeBaseCategoryQueryVo.fromJson,
    );
    await result.handleCode(
      code30101: (String showMessage, KnowledgeBaseCategoryQueryVo vo) async {
        fines.addAll(vo.selected_sub_categorys_list!);
        bigs.addAll(vo.big_categorys_list!);
        setState(() {});
      },
      code30102: (String showMessage, KnowledgeBaseCategoryQueryVo vo) async {
        logger.outErrorShouldNot();
      },
      otherException: (int? code, HttperException httperException, StackTrace st) async {
        logger.outErrorHttp(
          code: code,
          showMessage: httperException.showMessage,
          debugMessage: httperException.debugMessage,
          st: st,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DialogWidget(
      mainVerticalWidgets: [
        Row(
          children: [Text("精选", style: Theme.of(context).textTheme.titleMedium)],
        ),
        SizedBox(height: 10),
        Wrap(
          children: [
            fines.isEmpty ? Text("正在获取...") : Container(),
            ...fines.map(
              (e) => _SingleCard(
                text: e,
                isSelect: widget.homeState.isSelectedFor(e),
                onTap: () {
                  widget.homeState.changeSelect(e);
                  setState(() {});
                },
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        Row(
          children: [Text("大类别", style: Theme.of(context).textTheme.titleMedium)],
        ),
        Wrap(
          children: [
            bigs.isEmpty ? Text("正在获取...") : Container(),
            ...bigs.map(
              (e) => TextButton(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [Text("$e"), Icon(Icons.chevron_right)],
                ),
                onPressed: () async {
                  await Navigator.pushNamed(context, "/sub", arguments: e);
                  setState(() {});
                },
              ),
            ),
          ],
        ),
      ],
      bottomHorizontalButtonWidgets: [
        TextButton(
          child: Row(
            children: [
              Text(
                "清空(${widget.homeState.selectedSubCategories.length})",
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
          onPressed: () {
            widget.homeState.selectedSubCategories.clear();
            setState(() {});
          },
        ),
        Spacer(),
        TextButton(
          child: Text("取消"),
          onPressed: () {
            widget.homeState.closeDialog(false);
          },
        ),
        TextButton(
          child: Text("确定"),
          onPressed: () {
            widget.homeState.closeDialog(true);
          },
        ),
      ],
    );
  }
}

class _Sub extends StatefulWidget {
  const _Sub({super.key, required this.bigName, required this.firstState});

  final String bigName;
  final _KnowledgeBaseCategoryWidgetState firstState;

  @override
  State<_Sub> createState() => _SubState();
}

class _SubState extends State<_Sub> {
  final subs = <String>[];

  @override
  void initState() {
    super.initState();
    _querySub();
  }

  Future<void> _querySub() async {
    final resultSubs = await request(
      path: HttpPath.POST__NO_LOGIN_REQUIRED_KNOWLEDGE_BASE_QUERY_KNOWLEDGE_BASE_CATEGORYS,
      dtoData: KnowledgeBaseCategoryQueryDto(
        big_category: widget.bigName,
        dto_padding_1: null,
      ),
      parseResponseVoData: KnowledgeBaseCategoryQueryVo.fromJson,
    );
    await resultSubs.handleCode(
      code30101: (String showMessage, KnowledgeBaseCategoryQueryVo vo) async {
        logger.outErrorShouldNot();
      },
      code30102: (String showMessage, KnowledgeBaseCategoryQueryVo vo) async {
        subs.addAll(vo.sub_categorys_list!);
        setState(() {});
      },
      otherException: (int? code, HttperException httperException, StackTrace st) async {
        logger.outErrorHttp(
          code: code,
          showMessage: httperException.showMessage,
          debugMessage: httperException.debugMessage,
          st: st,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DialogWidget(
      mainVerticalWidgets: [
        Row(
          children: [
            BackButton(),
            Text(
              widget.bigName,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
        SizedBox(height: 10),
        Wrap(
          children: [
            ...subs.map(
              (e) => _SingleCard(
                text: e,
                isSelect: widget.firstState.isSelectedFor(e),
                onTap: () {
                  widget.firstState.changeSelect(e);
                  setState(() {});
                },
              ),
            ),
          ],
        )
      ],
      bottomHorizontalButtonWidgets: [],
    );
  }
}

class _SingleCard extends StatelessWidget {
  const _SingleCard({
    super.key,
    required this.text,
    required this.isSelect,
    required this.onTap,
  });

  final String text;
  final bool isSelect;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          border: Border.all(color: isSelect ? Colors.blue : Colors.grey),
        ),
        child: Text(text, style: TextStyle(color: isSelect ? Colors.blue : Colors.black)),
      ),
      onTap: onTap,
    );
  }
}
