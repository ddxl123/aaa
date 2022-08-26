import 'package:flutter/material.dart';

class KeepStateWidget extends StatefulWidget {
  const KeepStateWidget({Key? key, required this.builder}) : super(key: key);
  final Widget Function(BuildContext context) builder;

  @override
  State<KeepStateWidget> createState() => _KeepStateWidgetState();
}

class _KeepStateWidgetState extends State<KeepStateWidget> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.builder(context);
  }

  @override
  bool get wantKeepAlive => true;
}
