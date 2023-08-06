import 'dart:async';

import 'package:source_gen/source_gen.dart';
import 'package:build/build.dart';
import 'package:drift_custom/tools.dart';

class ResetGenerator extends Generator {
  @override
  FutureOr<String?> generate(LibraryReader library, BuildStep buildStep) {
    final allContent = StringBuffer();
    // 不带 s
    final localTableClasses = <String>[];
    try {
      for (var value in library.classes) {
        if (value.allSupertypes.first.getDisplayString(withNullability: false).contains('ClientTableBase')) {
          localTableClasses.add(value.displayName.substring(0, value.displayName.length - 1));
        }
      }
      for (var cls in library.classes) {
        if (cls.allSupertypes.first.getDisplayString(withNullability: false).contains('DataClass')) {
          // 不带s
          final className = cls.displayName;
          final camelClassName = className.toCamelCase;
          final params = cls.unnamedConstructor!.parameters;
          final singleContent = '''
        /// [${className}s]
        extension ${className}Ext on $className {

          Future<void> delete({required SyncTag syncTag${localTableClasses.contains(className) ? "" : ", required bool isCloudTableWithSync"}}) async {
            final ins = DriftDb.instance;
            await ins.deleteWith(
              ins.${camelClassName}s,
              entity: this,
              syncTag: syncTag,
              isCloudTableWithSync: ${localTableClasses.contains(className) ? "false" : "isCloudTableWithSync"},
            );
          }
            
          Future<void> resetByEntity({
            required $className $camelClassName,
            required SyncTag syncTag,
            ${localTableClasses.contains(className) ? "" : "required bool isCloudTableWithSync,"}
          }) async {
            await reset(
            ${params.map(
                    (e) {
                      final isWriteBlank = e.name == 'id' || e.name == 'created_at' || e.name == 'updated_at';
                      return isWriteBlank ? '' : '${e.name}: $camelClassName.${e.name}.toValue()';
                    },
                  ).where(
                    (element) => element != '',
                  ).join(',')},
              syncTag: syncTag,
              ${localTableClasses.contains(className) ? "" : "isCloudTableWithSync: isCloudTableWithSync"}
            );
          }
          
          /// 将传入的新数据覆盖掉旧数据类实例。
          ///
          /// 值覆写方式：[DriftValueExt]
          /// 
          /// 只能修改当前 id 的行。
          /// 
          /// created_at updated_at 已经在 [DriftSyncExt.updateReturningWith] 中自动更新了。
          FutureOr<$className> reset({
          ${params.map(
                    (e) {
                      final isWriteBlank = e.name == 'id' || e.name == 'created_at' || e.name == 'updated_at';
                      return isWriteBlank ? '' : 'required Value<${e.type}> ${e.name}';
                    },
                  ).where(
                    (element) => element != '',
                  ).join(',')}, 
            required SyncTag syncTag,
            ${localTableClasses.contains(className) ? "" : "required bool isCloudTableWithSync,"}
            }) async {
           bool isCloudModify = false;
           bool isLocalModify = false;
            ${params.map(
                    (e) {
                      final isWriteBlank = e.name == 'id' || e.name == 'created_at' || e.name == 'updated_at';
                      return isWriteBlank
                          ? ''
                          : """
                      if (${e.name}.present && this.${e.name} != ${e.name}.value) {
                        ${e.name.contains(RegExp(r'^(local_)')) || localTableClasses.contains(className) ? 'isLocalModify' : 'isCloudModify'} = true;
                        this.${e.name} = ${e.name}.value;
                      }
                      """;
                    },
                  ).where(
                    (element) => element != '',
                  ).join('\n')}
          if (isCloudModify || isLocalModify) {
            final ins = DriftDb.instance;
            await ins.updateReturningWith(ins.${camelClassName}s, entity: toCompanion(false), syncTag: syncTag, isCloudTableWithSync: ${localTableClasses.contains(className) ? "false" : "isCloudTableWithSync && isCloudModify"});
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

extension DriftValueExt<T> on T {
  /// 赋予新值
  ///
  /// drift.Value('value') 的快捷方法。
  ///
  /// 使用方法： '123'.toValue()。
  Value<T> toValue() {
    return Value<T>(this);
  }

  /// 保持原值不变。
  ///
  /// drift.Value.absent() 的快捷方法。
  ///
  /// 使用方法：直接在任意对象中调用 toAbsent()。
  Value<A> toAbsent<A>() {
    return Value<A>.absent();
  }
}

$allContent
    ''';
  }
}
