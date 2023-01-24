import 'package:flutter/material.dart';

/// 自定义 tab 类型 appbar
class CustomTabAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomTabAppBar({Key? key, required this.tabController, required this.tabs, this.otherWidgets}) : super(key: key);
  final TabController tabController;
  final List<Tab> tabs;
  final List<Widget>? otherWidgets;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            // flex: 2,
            child: TabBar(
              isScrollable: true,
              indicatorWeight: 5,
              controller: tabController,
              tabs: [
                ...tabs,
              ],
            ),
          ),
          ...(otherWidgets ?? []),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kMinInteractiveDimension);
}

/// 自定义狭窄类型 appbar
class CustomNarrowAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomNarrowAppBar({
    Key? key,
    this.child,
    this.actions,
    this.isDivider = false,
  }) : super(key: key);
  final Widget? child;
  final List<Widget>? actions;
  final bool isDivider;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: isDivider ? const EdgeInsets.fromLTRB(0, 1, 0, 10) : null,
      color: Colors.white,
      child: Row(
        children: [
          Expanded(child: child ?? Container()),
          ...(actions ?? []),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kMinInteractiveDimension + (isDivider ? (1 + 10) : 0));
}
