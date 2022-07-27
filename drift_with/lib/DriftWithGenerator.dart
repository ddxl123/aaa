import 'dart:async';

import 'package:drift_with/DriftWithAnnotation.dart';
import 'package:source_gen/source_gen.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';

class DriftWithGenerator extends GeneratorForAnnotation<DriftWithAnnotation> {
  @override
  generateForAnnotatedElement(Element element, ConstantReader annotation, BuildStep buildStep) {
    StringBuffer stringBuffer = StringBuffer();
    if(element is ClassElement){
      stringBuffer.writeln(element.documentationComment);
    }
    return stringBuffer.toString();
  }
}
