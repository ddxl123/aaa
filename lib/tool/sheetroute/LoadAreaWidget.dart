import 'package:flutter/material.dart';

import 'LoadAreaController.dart';

class LoadAreaWidget<T> extends StatefulWidget {
  const LoadAreaWidget(this.loadAreaController, {Key? key}) : super(key: key);

  final LoadAreaController loadAreaController;

  @override
  _LoadAreaWidgetState<T> createState() => _LoadAreaWidgetState<T>();
}

class _LoadAreaWidgetState<T> extends State<LoadAreaWidget<T>> {
  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      child: widget.loadAreaController.currentStatusWidget(),
    );
  }
}
