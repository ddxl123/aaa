import 'package:flutter/material.dart';

class KeepStateWidget extends StatefulWidget {
  const KeepStateWidget({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  State<KeepStateWidget> createState() => _KeepStateWidgetState();
}

class _KeepStateWidgetState extends State<KeepStateWidget> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }

  @override
  bool get wantKeepAlive => true;
}
