import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:tools/src/other.dart';

Widget dropdownButton2<T>({required T value, required List<Tuple2<String, T>> item, required void Function(T? value) onChanged}) {
  final inserts = item.asMap().keys.map((e) => (e + 1) * 2 - 1).toList();
  final itemNullable = <Tuple2<String, T>?>[...item];
  for (var insert in inserts) {
    itemNullable.insert(insert, null);
  }
  return DropdownButton2<T>(
    value: value,
    alignment: Alignment.center,
    customItemsHeights: const [10],
    // customItemsIndexes: inserts,
    // customItemsHeight: 10,
    dropdownElevation: 2,
    dropdownDecoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
    ),
    items: itemNullable
        .map((e) => e == null
            ? DropdownMenuItem<T>(
                enabled: false,
                child: const Divider(),
              )
            : DropdownMenuItem<T>(
                alignment: Alignment.center,
                value: e.t2,
                child: Text(e.t1),
              ))
        .toList(),
    onChanged: onChanged,
  );
}
