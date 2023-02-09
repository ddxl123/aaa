import 'dart:convert';

void main() async {
  print((json.decode('["1",false,null]') as List).last.runtimeType);
}
