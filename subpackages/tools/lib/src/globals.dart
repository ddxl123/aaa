import 'dart:async';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:tools/src/classes.dart';

/// [from] - 输入要筛选的值。
///
/// [targets] - {[value1,value2]:returnValue}，如果 [from] 的值为 value1 或 value2，则返回 returnValue。
///
/// [orElse] - 当 [targets] 未通过时，会返回 [orElse]。如果 [orElse] 为 null，则抛出异常。
R filter<E, R>({
  required E from,
  required Map<List<E>, R Function()?> targets,
  required R Function()? orElse,
}) {
  bool isEver = false;
  for (var key in targets.keys) {
    if (key.contains(from)) {
      if (isEver) throw '不能在不同的key中多次使用相同的值！';
      isEver = true;
      if (targets[key] == null) throw '筛查的返回值为 null！';
      return targets[key]!();
    }
  }
  if (orElse == null) throw '存在未处理筛查。';
  return orElse();
}

Future<R> filterFuture<E, R>({
  required E from,
  required Map<List<E>, Future<R> Function()?> targets,
  required Future<R> Function()? orElse,
}) async {
  bool isEver = false;
  for (var key in targets.keys) {
    if (key.contains(from)) {
      if (isEver) throw '不能在不同的key中多次使用相同的值！';
      isEver = true;
      if (targets[key] == null) throw '筛查的返回值为 null';
      return await targets[key]!();
    }
  }
  if (orElse == null) throw '存在未处理筛查。';
  return await orElse();
}

Widget dropdownButton2<T>({required T value, required List<Tuple2<String, T>> item, required void Function(T? value) onChanged}) {
  final inserts = item.asMap().keys.map((e) => (e + 1) * 2 - 1).toList();
  final itemNullable = <Tuple2<String, T>?>[...item];
  for (var insert in inserts) {
    itemNullable.insert(insert, null);
  }
  return DropdownButton2<T>(
    value: value,
    alignment: Alignment.center,
    customItemsIndexes: inserts,
    customItemsHeight: 10,
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
