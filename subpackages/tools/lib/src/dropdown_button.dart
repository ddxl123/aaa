import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:tools/src/other.dart';

Widget dropdownButton2<T>({required T value, required List<Tuple2<String, T>> item, required void Function(T? value) onChanged}) {
  return DropdownButton2<T>(
    value: value,
    alignment: Alignment.center,
    dropdownElevation: 2,
    barrierColor: Colors.black26,
    dropdownDecoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
    ),
    itemPadding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
    items: [
      ...item.map(
        (e) => DropdownMenuItem<T>(
          alignment: Alignment.center,
          value: e.t2,
          child: Text(e.t1),
        ),
      ),
    ],
    onChanged: onChanged,
  );
}
