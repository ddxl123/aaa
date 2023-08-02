import 'package:flutter/material.dart';
import 'package:tools/tools.dart';

Future<void> showKnowledgeBaseCategory({
  required BuildContext context,
}) async {
  await Navigator.of(context).push(DialogRoute(context: context, builder: (c) => KnowledgeBaseCategoryWidget()));
  // await showCustomDialog(
  //   builder: (BuildContext context) {
  //     return KnowledgeBaseCategoryWidget();
  //   },
  // );
}

class KnowledgeBaseCategoryWidget extends StatefulWidget {
  const KnowledgeBaseCategoryWidget({super.key});

  @override
  State<KnowledgeBaseCategoryWidget> createState() => _KnowledgeBaseCategoryWidgetState();
}

class _KnowledgeBaseCategoryWidgetState extends State<KnowledgeBaseCategoryWidget> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Navigator(
        initialRoute: "/",
        onGenerateRoute: (settings) {
          late Widget page;
          switch (settings.name) {
            case "/":
              page = _Init();
            case "/sub":
              page = _Init();
            default:
              throw "未处理：${settings.name}";
          }
          return MaterialPageRoute(
            builder: (c) => page,
            settings: settings,
          );
        },
      ),
    );
  }
}

class _Init extends StatefulWidget {
  const _Init({super.key});

  @override
  State<_Init> createState() => _InitState();
}

class _InitState extends State<_Init> {
  @override
  Widget build(BuildContext context) {
    return DialogWidget(
      // dialogSize: DialogSize(width: MediaQuery.of(context).size.width - 20, height: null),
      mainVerticalWidgets: [
        Row(
          children: [Text("精选", style: Theme.of(context).textTheme.titleMedium)],
        ),
        Wrap(
          children: [
            TextButton(
              onPressed: () {},
              child: Text("data"),
            ),
            TextButton(
              onPressed: () {},
              child: Text("data"),
            ),
            TextButton(
              onPressed: () {},
              child: Text("dsfsdfasdasdsadasd"),
            ),
            TextButton(
              onPressed: () {},
              child: Text("dadddta"),
            ),
          ],
        ),
        SizedBox(height: 20),
        Row(
          children: [Text("大类别", style: Theme.of(context).textTheme.titleMedium)],
        ),
        Wrap(
          children: [
            TextButton(
              onPressed: () {},
              child: Text("ddddddddd"),
            ),
            TextButton(
              onPressed: () {},
              child: Text("dsfsdfasdasdsadasd"),
            ),
            TextButton(
              onPressed: () {},
              child: Text("dsfsdfasdasdsadasd"),
            ),
            TextButton(
              onPressed: () {},
              child: Text("dadddta"),
            ),
          ],
        ),
      ],
      bottomHorizontalButtonWidgets: [],
    );
  }
}
