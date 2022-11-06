import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:tools/src/other.dart';

/// 自定义带有主要按钮的 dropdown。
class CustomDropdownBodyButton<T> extends StatelessWidget {
  const CustomDropdownBodyButton({
    Key? key,
    required this.value,
    this.customButton,
    this.dropdownWidth,
    required this.item,
    required this.onChanged,
    this.itemAlignment = Alignment.center,
  }) : super(key: key);

  final T value;
  final Widget? customButton;
  final double? dropdownWidth;
  final List<Tuple2<String, T>> item;
  final void Function(T? value) onChanged;
  final Alignment itemAlignment;

  @override
  Widget build(BuildContext context) {
    return DropdownButton2<T>(
      value: value,
      customButton: customButton == null
          ? null
          : Container(
              padding: Theme.of(context).buttonTheme.padding,
              alignment: Alignment.center,
              child: customButton,
            ),
      underline: customButton == null ? null : Container(),
      dropdownElevation: 2,
      dropdownWidth: dropdownWidth,
      barrierColor: Colors.black26,
      dropdownDecoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      itemPadding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      items: [
        ...item.map(
          (e) => DropdownMenuItem<T>(
            alignment: Alignment.center,
            value: e.t2,
            child: Container(
              padding: Theme.of(context).buttonTheme.padding,
              alignment: itemAlignment,
              child: Text(e.t1),
            ),
          ),
        ),
      ],
      onChanged: onChanged,
    );
  }
}
