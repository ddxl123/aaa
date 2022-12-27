import 'package:flutter/material.dart';

class CustomTabAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomTabAppBar({Key? key, required this.tabController, required this.tabs, this.otherWidgets}) : super(key: key);
  final TabController tabController;
  final List<Tab> tabs;
  final List<Widget>? otherWidgets;

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kMinInteractiveDimension);
}

class CustomNarrowAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomNarrowAppBar({
    Key? key,
    this.actions,
  }) : super(key: key);
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        ...(actions ?? []),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kMinInteractiveDimension);
}
