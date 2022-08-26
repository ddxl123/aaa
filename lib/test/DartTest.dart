
import 'dart:io';

void main() async {
  var result = await Process.run('pub', [
    'run',
    'import_path',
    'aaa.dart',
    'package:aaa/theme.dart'
  ]);
  print(result.stdout);
}