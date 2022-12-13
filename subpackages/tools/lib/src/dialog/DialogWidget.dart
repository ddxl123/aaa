import 'package:flutter/material.dart';

/// 一个可扩展的 dialog widget。
class DialogWidget extends StatelessWidget {
  const DialogWidget({
    Key? key,
    this.title,
    this.topRightAction,
    this.bottomLiftAction,
    required this.mainVerticalWidgets,
    required this.bottomHorizontalButtonWidgets,
    this.bottomKeepWidget,
  }) : super(key: key);
  final String? title;
  final Widget? topRightAction;
  final Widget? bottomLiftAction;
  final List<Widget> mainVerticalWidgets;
  final List<Widget> bottomHorizontalButtonWidgets;
  final Widget? bottomKeepWidget;

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      padding: MediaQuery.of(context).viewInsets + MediaQuery.of(context).padding,
      duration: const Duration(milliseconds: 100),
      child: Container(
        padding: const EdgeInsets.fromLTRB(30, 20, 30, 5),
        constraints: const BoxConstraints(maxHeight: 800, maxWidth: 300),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [BoxShadow(spreadRadius: -5, offset: Offset(3, 3), blurRadius: 8)],
        ),
        child: IntrinsicHeight(
          child: IntrinsicWidth(
            child: Column(
              mainAxisSize: MainAxisSize.min,
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
                                  style: TextStyle(fontSize: Theme.of(_).textTheme.titleMedium!.fontSize, fontWeight: FontWeight.bold),
                                );
                              },
                            ),
                          ),
                          topRightAction == null ? Container() : topRightAction!,
                        ],
                      ),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
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
            ),
          ),
        ),
      ),
    );
  }
}
