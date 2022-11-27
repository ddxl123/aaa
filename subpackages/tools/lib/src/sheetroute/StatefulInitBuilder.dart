import 'package:flutter/material.dart';

class StatefulInitBuilder extends StatefulWidget {
  const StatefulInitBuilder({required this.onInit, required this.builder, Key? key}) : super(key: key);

  final void Function(StatefulInitBuilderState state) onInit;
  final Widget Function(StatefulInitBuilderState state) builder;

  @override
  StatefulInitBuilderState createState() => StatefulInitBuilderState();
}

class StatefulInitBuilderState extends State<StatefulInitBuilder> {
  @override
  void initState() {
    super.initState();
    widget.onInit(this);
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
