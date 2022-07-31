import 'package:flutter/material.dart';

class StatefulInitBuilder extends StatefulWidget {
  const StatefulInitBuilder({required this.init, required this.builder, Key? key}) : super(key: key);

  final void Function(StatefulInitBuilderState state) init;
  final Widget Function(StatefulInitBuilderState state) builder;

  @override
  StatefulInitBuilderState createState() => StatefulInitBuilderState();
}

class StatefulInitBuilderState extends State<StatefulInitBuilder> {
  @override
  void initState() {
    super.initState();
    widget.init(this);
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(this);
  }

  void refresh() {
    if (mounted) {
      setState(() {});
    }
  }
}
