import 'package:collection/collection.dart';

void main() async {
  print(
    DeepCollectionEquality().equals(
      {
        "a": 1,
        "b": {"cc": 111, "c": "aaa"},
      },
      {
        "b": {"c": "aaa", "cc": 111},
        "a": 1,
      },
    ),
  );
}
