import 'dart:async';
import 'package:drift_custom/tools.dart';
import 'package:source_gen/source_gen.dart';
import 'package:build/build.dart';

class CrtGenerator extends Generator {
  @override
  FutureOr<String?> generate(LibraryReader library, BuildStep buildStep) {
    final allContent = StringBuffer();
    try {
      // 不带 s
      final localTableClasses = <String>[];
      for (var value in library.classes) {
        if (value.allSupertypes.first.getDisplayString(withNullability: false).contains('ClientTableBase')) {
          localTableClasses.add(value.displayName.substring(0, value.displayName.length - 1));
        }
      }

      for (var cls in library.classes) {
        if (cls.allSupertypes.first.getDisplayString(withNullability: false).contains('DataClass')) {
          final requiredContent = StringBuffer();
          final returnContent = StringBuffer();
          for (var element in cls.fields) {
            if (element.name == "hashCode") {
            } else if (element.name == "id") {
              returnContent.writeln("${element.name}: -1,");
            } else if (element.name == "created_at" || element.name == "updated_at") {
              returnContent.writeln("${element.name}: DateTime(0),");
            } else {
              requiredContent.writeln("  required ${element.getDisplayString(withNullability: true)},");
              returnContent.writeln("     ${element.name}: ${element.name},");
            }
          }

          allContent.writeln(" static ${cls.name} ${cls.name[0].toLowerCase() + cls.name.substring(1, cls.name.length)}Entity({");
          allContent.writeln(requiredContent);
          allContent.writeln(" }) {");
          allContent.writeln("   return ${cls.name}(");
          allContent.writeln(returnContent);
          allContent.writeln("   );");
          allContent.writeln(" }");
        }
      }
    } catch (e, st) {
      print('error start ----------------------------------');
      print(e);
      print(st);
      print('error end ----------------------------------');
    }

    if (allContent.isEmpty) {
      print(
        'err: allContent==null请检查如下：'
        '\n 1. DriftDb.dart 是否引入 part "DriftDb._.dart";'
        '\n 2. DriftDb._.dart 文件内容是否解除注释',
      );
    }

    print('生成 constructor 完成。');
    return '''
// ignore_for_file: non_constant_identifier_names
part of drift_db;

class Crt {
  Crt._();
  $allContent
}
    ''';
  }
}
