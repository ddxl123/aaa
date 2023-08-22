import 'dart:async';

import 'package:drift_custom/ReferenceTo.dart';
import 'package:source_gen/source_gen.dart';
import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:drift_custom/tools.dart';

class ClassNameAndFieldName {
  const ClassNameAndFieldName({required this.className, required this.fieldName});

  final String className;
  final String fieldName;

  String get combine => "${className}_$fieldName";
}

class ReferenceGenerator extends GeneratorForAnnotation<ReferenceTo> {
  /// key - 所引用的类名
  /// values - 当前类名
  /// key 被 values 所引用
  /// 当 value 与 key 相同时，会自动对 value 添加前缀：child_
  final father2Children = <String, List<ClassNameAndFieldName>>{};

  @override
  FutureOr<String> generate(LibraryReader library, BuildStep buildStep) async {
    try {
      await super.generate(library, buildStep);
    } catch (e, st) {
      print('》》》》》》》》 error start ----------------------------------');
      print(e);
      print(st);
      print('》》》》》》》》 error end ----------------------------------');
    }
    print('生成 reference 完成。');
    return _referenceContent();
  }

  @override
  generateForAnnotatedElement(Element element, ConstantReader annotation, BuildStep buildStep) {
    if (element is ClassElement) {
      // 当前类名
      final currentClassName = element.name;
      _reference(currentElement: element, currentClassName: currentClassName, annotation: annotation);
    }
    return '';
  }

  void _reference({
    required ClassElement currentElement,
    required String currentClassName,
    required ConstantReader annotation,
  }) {
    _referenceAdd(currentClassName, annotation.read('referenceTable').listValue, "_class");

    // 迭代类中全部 getter/setter 成员。
    for (var accessor in currentElement.accessors) {
      // 迭代 accessor 的全部注解。
      for (var annotationData in accessor.metadata) {
        if (annotationData.computeConstantValue()?.type?.getDisplayString(withNullability: false) == const ReferenceTo([]).runtimeType.toString()) {
          // 获取注解的 referenceTable 的值。
          var r = annotationData.computeConstantValue()!.getField('referenceTable')!.toListValue()!;
          _referenceAdd(currentClassName, r, accessor.name);
        }
      }
    }

    _referenceAddR(currentClassName);
  }

  /// 把 [value]，添加到 [keys] 的每个元素中
  void _referenceAdd(String value, List<DartObject> keys, String fieldName) {
    final classNameKeys = <String>[];
    for (var key in keys) {
      classNameKeys.add(key.toTypeValue()!.getDisplayString(withNullability: false));
    }
    for (var classNameKey in classNameKeys) {
      if (!father2Children.containsKey(classNameKey)) {
        father2Children.addAll({classNameKey: <ClassNameAndFieldName>[]});
      }
      father2Children[classNameKey]!.add(ClassNameAndFieldName(className: value, fieldName: fieldName));
    }
  }

  /// [_add] 函数只会让存在引用类的父类创建 [father2Children] 的 key。
  /// 例如，并不存在引用关联表的表，因此并不会在 [father2Children] 中创建它的 key。
  /// 因此，该函数的目的即是让不存在引用类的父类创建 [father2Children] 的 key。
  void _referenceAddR(String currentClassName) {
    if (!father2Children.containsKey(currentClassName)) {
      father2Children.addAll({currentClassName: <ClassNameAndFieldName>[]});
    }
  }

  String _referenceContent() {
    final StringBuffer bodyContent = StringBuffer();
    father2Children.forEach(
      (father, children) {
        final StringBuffer classContent = StringBuffer();

        // 得到主要的 users/userInfos
        final fatherCamel = father.toCamelCase;

        final StringBuffer childrenFutureContent = StringBuffer();
        final StringBuffer childrenRequiredContent = StringBuffer();
        final StringBuffer childrenRunCallContent = StringBuffer();

        final tempChildren = <String>[];

        // child 为 UserInfos-field 类型。
        for (var child in children) {
          // 始终为 userInfos 类型。
          String childKeep = child.className.toCamelCase;

          // 当 child !=  father 时，为 userInfos 类型。
          // 当 child == father 时，为 child_userInfos 类型。
          String childCamel = child.className.toCamelCase;
          if (child.className == father) {
            childCamel = '${childCamel}_${child.fieldName}';
          }

          // 一个类被其他多个类指向时，对其他多个类分配后缀，以防重复。
          // 生成 userInfos_1 userInfos_2 child_userInfos_1 child_userInfos_2
          if (children.where((element) => element == child).toList().length != 1) {
            tempChildren.add(childCamel);
            childCamel = childCamel;
          }

          childrenFutureContent.writeln('Ref${child.className}? $childCamel;');
          childrenRequiredContent.writeln('required this.$childCamel,');
          childrenRunCallContent.writeln('$childCamel, ');
        }
        classContent.writeln('''
/// [$father]
class Ref$father extends Ref {
  Future<void> Function() self;
  $childrenFutureContent

  Ref$father({required this.self, $childrenRequiredContent required super.order,});
    
  @override
  Future<void> run() async {
    final list = <Ref?>[this, $childrenRunCallContent]..sort((a, b) => (a?.order ?? 99).compareTo(b?.order ?? 99));
    await Future.forEach<Ref?>(
      list,
      (element) async {
        if (element == this) {
          await self();
        } else {
          await element?.run();
        }
      },
    );
  }
}
        ''');
        bodyContent.writeln(classContent);
      },
    );

    return '''
// ignore_for_file: non_constant_identifier_names
part of drift_db;

abstract class Ref {
  Ref({required this.order});

  final int order;
    
  Future<void> run();
}

${bodyContent.toString()}
    ''';
  }
}
