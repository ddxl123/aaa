import 'dart:async';

import 'package:source_gen/source_gen.dart';
import 'package:build/build.dart';
import 'package:tools/tools.dart';

class ResetGenerator extends Generator {
  @override
  FutureOr<String?> generate(LibraryReader library, BuildStep buildStep) {
    final allContent = StringBuffer();
    try {
      for (var cls in library.classes) {
        if (cls.allSupertypes.first.getDisplayString(withNullability: false).contains('DataClass')) {
          final className = cls.displayName;
          final camelClassName = className.toCamelCase;
          final params = cls.unnamedConstructor!.parameters;
          final singleContent = '''
        extension ${className}Ext on $className {
          /// 若 [writeSyncTag] == null，则不执行写入，否则执行写入。
          FutureOr<$className> reset({${params.map((e) => 'required Value<${e.type}> ${e.name}').join(',')}, 
            required SyncTag? writeSyncTag,}) async {
            ${params.map((e) => 'this.${e.name} = ${e.name}.present ? ${e.name}.value : this.${e.name}').join(';\n')};   
          if(writeSyncTag!=null){
            final ins = DriftDb.instance;
            await ins.updateReturningWith(ins.${camelClassName}s, entity: toCompanion(false), syncTag: writeSyncTag);
          }
            return this;
          }
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

    print('生成 reset 完成。');
    return '''
// ignore_for_file: non_constant_identifier_names
part of drift_db;
$allContent
    ''';
  }
}
