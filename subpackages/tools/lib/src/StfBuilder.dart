import 'package:flutter/material.dart';

typedef ResetValue<V> = void Function(V value, bool isWithRefresh);

class StfBuilder1<V> extends StatefulWidget {
  const StfBuilder1({
    Key? key,
    required this.initValue,
    this.onInit,
    this.onReady,
    required this.builder,
    this.onDispose,
  }) : super(key: key);

  final V initValue;

  final void Function(V extra, BuildContext context, ResetValue<V> resetValue)? onInit;
  final void Function(V extra, BuildContext context, ResetValue<V> resetValue)? onReady;
  final Widget Function(V extra, BuildContext context, ResetValue<V> resetValue) builder;
  final void Function(V extra, BuildContext context, ResetValue<V> resetValue)? onDispose;

  @override
  State<StfBuilder1<V>> createState() => _StfBuilder1State<V>();
}

class _StfBuilder1State<V> extends State<StfBuilder1<V>> {
  late V value;

  void resetValue(V newValue, bool isWithRefresh) {
    if (isWithRefresh) {
      if (mounted) {
        setState(() {
          value = newValue;
        });
      }
    } else {
      value = newValue;
    }
  }

  @override
  void initState() {
    super.initState();
    value = widget.initValue;
    widget.onInit?.call(value, context, resetValue);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget.onReady?.call(value, context, resetValue);
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(value, context, resetValue);
  }

  @override
  void dispose() {
    widget.onDispose?.call(value, context, resetValue);
    super.dispose();
  }
}
