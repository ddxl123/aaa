import 'dart:async';

import 'package:source_gen/source_gen.dart';
import 'package:build/build.dart';
import 'package:tools/tools.dart';

class ConstructorGenerator extends Generator {
  @override
  FutureOr<String?> generate(LibraryReader library, BuildStep buildStep) {
    final allContent = StringBuffer();
    try {
      for (var cls in library.classes) {
        if (cls.allSupertypes.first.getDisplayString(withNullability: false).contains('UpdateCompanion')) {
          final className = cls.displayName;
          final camelClassName = className.toCamelCase;
          final params = cls.getNamedConstructor('insert')!.parameters;
          final singleContent = '''
        static $className $camelClassName({${params.map((e) => 'required ${e.name == 'id' && e.type.getDisplayString(withNullability: false) != 'Value<int>' ? 'Value<${e.type}>' : e.type} ${e.name}').join(',')},}){
           return $className(${params.map((e) => '${e.name}: ${e.isRequired ? (e.name == 'id' ? e.name : 'Value(${e.name})') : e.name}').join(',')},);
        }
        ''';

          allContent.writeln(singleContent);
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

class WithCrts {
  $allContent
}
    ''';
  }
}
