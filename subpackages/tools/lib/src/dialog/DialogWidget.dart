import 'package:flutter/material.dart';

class DialogSize {
  DialogSize({
    required this.width,
    required this.height,
  });

  /// 若为空则自适应宽度
  final double? width;

  /// 若为空则自适应高度
  final double? height;
}

/// 一个可扩展的 dialog widget。
class DialogWidget extends StatelessWidget {
  const DialogWidget({
    Key? key,
    this.title,
    this.topRightAction,
    this.bottomLiftAction,
    required this.mainVerticalWidgets,
    required this.bottomHorizontalButtonWidgets,
    this.topKeepWidget,
    this.bottomKeepWidget,
    this.allCrossAxisAlignment,
    this.dialogSize,
    this.mainVerticalWidgetsAlignment,
    this.fullPadding = const EdgeInsets.fromLTRB(30, 20, 30, 5),
  }) : super(key: key);
  final String? title;
  final Widget? topRightAction;
  final Widget? bottomLiftAction;
  final List<Widget> mainVerticalWidgets;
  final List<Widget> bottomHorizontalButtonWidgets;
  final Widget? topKeepWidget;
  final Widget? bottomKeepWidget;
  final CrossAxisAlignment? allCrossAxisAlignment;
  final CrossAxisAlignment? mainVerticalWidgetsAlignment;
  final DialogSize? dialogSize;
  final EdgeInsets fullPadding;

  @override
  Widget build(BuildContext context) {
    final inner = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: allCrossAxisAlignment ?? CrossAxisAlignment.center,
      children: [
        title == null
            ? Container()
            : Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Builder(
                      builder: (_) {
                        return Text(
                          title!,
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        );
                      },
                    ),
                  ),
                  topRightAction == null ? Container() : topRightAction!,
                ],
              ),
        topKeepWidget == null ? Container() : const SizedBox(height: 5),
        topKeepWidget == null ? Container() : topKeepWidget!,
        Expanded(
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: mainVerticalWidgetsAlignment ?? CrossAxisAlignment.start,
              // 文字部分
              children: mainVerticalWidgets,
            ),
          ),
        ),
        bottomKeepWidget == null ? Container() : const SizedBox(height: 5),
        bottomKeepWidget == null ? Container() : bottomKeepWidget!,
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          // 按钮部分
          children: [
            bottomLiftAction == null ? Container() : bottomLiftAction!,
            ...bottomHorizontalButtonWidgets,
          ],
        ),
      ],
    );
    return AnimatedPadding(
      padding: MediaQuery.of(context).viewInsets + MediaQuery.of(context).padding,
      duration: const Duration(milliseconds: 100),
      child: Container(
        padding: fullPadding,
        constraints: dialogSize == null
            ? BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.8,
                maxWidth: MediaQuery.of(context).size.width * 0.8,
              )
            : BoxConstraints(
                minWidth: dialogSize?.width ?? 0,
                maxWidth: dialogSize?.width ?? MediaQuery.of(context).size.width * 0.8,
                minHeight: dialogSize?.height ?? 0,
                maxHeight: dialogSize?.height ?? MediaQuery.of(context).size.width * 0.8,
              ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [BoxShadow(spreadRadius: -5, offset: Offset(3, 3), blurRadius: 8)],
        ),
        child: IntrinsicHeight(
          child: IntrinsicWidth(
            child: inner,
          ),
        ),
      ),
    );
  }
}
