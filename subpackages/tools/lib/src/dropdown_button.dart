import 'dart:math';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:tools/src/other.dart';

/// 自定义带有主要按钮的 dropdown。
class CustomDropdownBodyButton<T> extends StatefulWidget {
  const CustomDropdownBodyButton({
    Key? key,
    required this.initValue,
    this.primaryButton,
    required this.items,
    required this.onChanged,
    this.itemAlignment = Alignment.center,
    this.isShowUnderLine = true,
  }) : super(key: key);

  final T initValue;
  final Widget? primaryButton;
  final List<Item<T>> items;
  final void Function(T? value) onChanged;
  final Alignment itemAlignment;
  final bool isShowUnderLine;

  @override
  State<CustomDropdownBodyButton<T>> createState() => _CustomDropdownBodyButtonState<T>();
}

class _CustomDropdownBodyButtonState<T> extends State<CustomDropdownBodyButton<T>> {
  double maxWidth = 0;

  @override
  void initState() {
    super.initState();
    for (var value in widget.items) {
      maxWidth = max(maxWidth, value.text.length * 20 + 60);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton2<T>(
      value: widget.initValue,
      customButton: widget.primaryButton == null
          ? null
          : Container(
              child: widget.primaryButton,
            ),
      underline: const SizedBox(),
      barrierColor: Colors.black26,
      items: [
        ...widget.items.map(
          (e) => DropdownMenuItem<T>(
            alignment: Alignment.center,
            value: e.value,
            child: Container(
              padding: Theme.of(context).buttonTheme.padding,
              alignment: widget.itemAlignment,
              child: Text(e.text),
            ),
          ),
        ),
      ],
      dropdownStyleData: DropdownStyleData(width: maxWidth),
      onChanged: widget.onChanged,
    );
  }
}

class Item<T> {
  final T value;
  final String text;

  Item({required this.value, required this.text});
}
