import 'dart:async';
import 'package:drift_reference/ReferenceTo.dart';

import 'package:source_gen/source_gen.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';

class ReferenceGenerator extends GeneratorForAnnotation<ReferenceTo> {
  /// key - 所引用的类名
  /// values - 当前类名
  /// key 被 values 所引用
  /// 当 value 与 key 相同时，会自动对 value 添加前缀：child_
  final father2Children = <String, Set<String>>{};

  @override
  generateForAnnotatedElement(Element element, ConstantReader annotation, BuildStep buildStep) {
    if (element is ClassElement) {
      // 当前类名
      final currentClassName = element.name;

      if (!father2Children.containsKey(currentClassName)) {
        father2Children.addAll({currentClassName: <String>{}});
      }

      final currentClassNameValues = [];
      for (var element in annotation.read('referenceTable').listValue) {
        currentClassNameValues.add(element.toTypeValue()!.getDisplayString(withNullability: false));
      }
      for (var currentClassNameValue in currentClassNameValues) {
        if (!father2Children.containsKey(currentClassNameValue)) {
          father2Children.addAll({currentClassNameValue: <String>{}});
        }
        father2Children[currentClassNameValue]!.add(currentClassName);
      }

      // 迭代类中全部 getter/setter 成员。
      for (var accessor in element.accessors) {
        // 迭代 accessor 的全部注解。
        for (var annotationData in accessor.metadata) {
          // 所引用的类名，如 Users
          final referenceTableValues = [];
          annotationData.computeConstantValue()?.getField('referenceTable')?.toListValue()?.forEach((element) {
            referenceTableValues.add(element.toTypeValue()!.getDisplayString(withNullability: false));
          });
          for (var referenceTableValue in referenceTableValues) {
            if (!father2Children.containsKey(referenceTableValue)) {
              father2Children.addAll({referenceTableValue: <String>{}});
            }
            father2Children[referenceTableValue]!.add(currentClassName);
          }
        }
      }
    }
    return '';
  }

  @override
  FutureOr<String> generate(LibraryReader library, BuildStep buildStep) async {
    try {
      await super.generate(library, buildStep);
      print(father2Children);
    } catch (e, st) {
      print('start ----------------------------------');
      print(e);
      print(st);
      print('end ----------------------------------');
    }
    return withRefsContent();
  }

  String withRefsContent() {
    final StringBuffer bodyContent = StringBuffer();
    father2Children.forEach(
      (father, children) {
        final StringBuffer funcContent = StringBuffer();

        // 得到主要的 users/userInfos
        final fatherCC = toCamelCase(father);

        final StringBuffer childrenRequiredContent = StringBuffer();
        final StringBuffer childrenAwaitContent = StringBuffer();
        for (var child in children) {
          // 得到次要的 users/userInfos
          String childCC = toCamelCase(child);
          String constChildCC = childCC;
          // 处理外键为自身的情况。
          if (child == father) {
            childCC = 'child_$childCC';
          }
          childrenRequiredContent.writeln('required Future<void> Function(TableInfo table) $childCC,');
          childrenAwaitContent.writeln('await $childCC(DriftDb.instance.$constChildCC);');
        }

        funcContent.writeln('''
  static Future<void> $fatherCC({
    required Future<void> Function(TableInfo table) $fatherCC,
    $childrenRequiredContent
  }) async {
    await $fatherCC(DriftDb.instance.$fatherCC);
    $childrenAwaitContent
  }
          ''');

        bodyContent.writeln(funcContent);
      },
    );

    return '''
// ignore_for_file: non_constant_identifier_names
part of drift_db;

class WithRefs {
  ${bodyContent.toString()}
}
    ''';
  }

  String toCamelCase(String value) => value[0].toLowerCase() + value.substring(1, value.length);
}

/// 示例：
// ignore_for_file: non_constant_identifier_names
// part of drift_db;

// class WithRefs {
//   static Future<void> users({
//     required Future<void> Function(TableInfo table) users,
//   }) async {
//     await users(DriftDb.instance.users);
//   }
// }
