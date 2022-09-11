import 'package:flutter/material.dart';

void main() {
  const regExpOne = r'It is a dog\!';
  const regExpTwo = r'dog \(or cat\)';
  const content = 'It is a dog! ... dog (or cat)';
  for (var value in RegExp('($regExpOne)|($regExpTwo)').allMatches(content)) {
    print(content.substring(value.start, value.end));
  }
}
