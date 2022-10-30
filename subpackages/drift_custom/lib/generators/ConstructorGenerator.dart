import 'dart:async';
import 'package:drift_custom/tools.dart';
import 'package:source_gen/source_gen.dart';
import 'package:build/build.dart';

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
        static $className $camelClassName({${params.map(
                    (e) {
                      final isWriteBlank = e.name == 'id' || e.name == 'createdAt' || e.name == 'updatedAt';
                      return isWriteBlank ? '' : 'required ${e.type} ${e.name}';
                    },
                  ).where(
                    (element) => element != '',
                  ).join(',')},}){
           return $className(${params.map(
                    (e) {
                      final isWriteBlank = e.name == 'id' || e.name == 'createdAt' || e.name == 'updatedAt';
                      return isWriteBlank ? '' : '${e.name}: ${e.isRequired ? 'Value(${e.name})' : e.name}';
                    },
                  ).where(
                    (element) => element != '',
                  ).join(',')},);
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

/// 这个类在创建表对象时，可以让每个 column 都能被编辑器提示，以防遗漏。
/// 
/// id createdAt updatedAt 已经在 [DriftSyncExt.insertReturningWith] 中自动更新了。
///
/// 使用方式查看 [withRefs]。
class WithCrts {
  $allContent
}
    ''';
  }
}
