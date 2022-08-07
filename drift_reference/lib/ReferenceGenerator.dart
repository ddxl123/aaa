import 'dart:async';
import 'package:drift_reference/ReferenceTo.dart';

import 'package:source_gen/source_gen.dart';
import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';

class ReferenceGenerator extends GeneratorForAnnotation<ReferenceTo> {
  /// key - 所引用的类名
  /// values - 当前类名
  /// key 被 values 所引用
  /// 当 value 与 key 相同时，会自动对 value 添加前缀：child_
  final father2Children = <String, List<String>>{};

  @override
  FutureOr<String> generate(LibraryReader library, BuildStep buildStep) async {
    try {
      await super.generate(library, buildStep);
    } catch (e, st) {
      print('error start ----------------------------------');
      print(e);
      print(st);
      print('error end ----------------------------------');
    }
    print('生成 reference 完成。');
    return withRefsContent();
  }

  @override
  generateForAnnotatedElement(Element element, ConstantReader annotation, BuildStep buildStep) {
    if (element is ClassElement) {
      // 当前类名
      final currentClassName = element.name;

      _add(currentClassName, annotation.read('referenceTable').listValue);

      // 迭代类中全部 getter/setter 成员。
      for (var accessor in element.accessors) {
        // 迭代 accessor 的全部注解。
        for (var annotationData in accessor.metadata) {
          _add(currentClassName, annotationData.computeConstantValue()!.getField('referenceTable')!.toListValue()!);
        }
      }

      _addR(currentClassName);
    }
    return '';
  }

  /// 把 [value]，添加到 [keys] 的每个元素中
  void _add(String value, List<DartObject> keys) {
    final classNameKeys = [];
    for (var key in keys) {
      classNameKeys.add(key.toTypeValue()!.getDisplayString(withNullability: false));
    }
    for (var classNameKey in classNameKeys) {
      if (!father2Children.containsKey(classNameKey)) {
        father2Children.addAll({classNameKey: <String>[]});
      }
      father2Children[classNameKey]!.add(value);
    }
  }

  /// [_add] 函数只会让存在引用类的父类创建 [father2Children] 的 key。
  /// 例如，并不存在引用关联表的表，因此并不会在 [father2Children] 中创建它的 key。
  /// 因此，该函数的目的即是让不存在引用类的父类创建 [father2Children] 的 key。
  void _addR(String currentClassName) {
    if (!father2Children.containsKey(currentClassName)) {
      father2Children.addAll({currentClassName: <String>[]});
    }
  }

  String withRefsContent() {
    final StringBuffer bodyContent = StringBuffer();
    father2Children.forEach(
      (father, children) {
        final StringBuffer funcContent = StringBuffer();

        // 得到主要的 users/userInfos
        final fatherCamel = toCamelCase(father);

        final StringBuffer childrenRequiredContent = StringBuffer();
        final StringBuffer childrenAwaitContent = StringBuffer();

        final tempChildren = <String>[];

        // child 为 UserInfos 类型。
        for (var child in children) {
          // 始终为 userInfos 类型。
          String childKeep = toCamelCase(child);

          // 当 child !=  father 时，为 userInfos 类型。
          // 当 child == father 时，为 child_userInfos 类型。
          String childCamel = toCamelCase(child);
          if (child == father) {
            childCamel = 'child_$childCamel';
          }

          // 一个类被其他多个类指向时，对其他多个类分配后缀，以防重复。
          if (children.where((element) => element == child).toList().length != 1) {
            tempChildren.add(childCamel);
            final tempChildrenLength = tempChildren.where((element) => element == childCamel).toList().length;
            childCamel = '${childCamel}_$tempChildrenLength';
          }

          childrenRequiredContent.writeln('required Future<void> Function(\$${child}Table table)? $childCamel,');
          childrenAwaitContent.writeln('await $childCamel?.call(DriftDb.instance.$childKeep);');
        }

        funcContent.writeln('''
  static Future<void> $fatherCamel(
    Future<void> Function(\$${father}Table table) $fatherCamel,
  ${childrenRequiredContent.isEmpty ? '' : '{$childrenRequiredContent}'}
  ) async {
    await $fatherCamel(DriftDb.instance.$fatherCamel);
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

  /// 把 UserInfos 转成 userInfos。
  String toCamelCase(String value) => value[0].toLowerCase() + value.substring(1, value.length);
}
