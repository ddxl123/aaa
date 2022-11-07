import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({Key? key, required this.tabController, required this.tabs, this.otherWidgets}) : super(key: key);
  final TabController tabController;
  final List<Tab> tabs;
  final List<Widget>? otherWidgets;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: TabBar(
            isScrollable: true,
            indicatorWeight: 5,
            controller: tabController,
            tabs: [
              ...tabs,
            ],
          ),
        ),
        const Spacer(),
        ...(otherWidgets ?? []),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kMinInteractiveDimension);
}
