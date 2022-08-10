import 'package:drift_custom/generators/ConstructorGenerator.dart';
import 'package:drift_custom/generators/ReferenceGenerator.dart';
import 'package:drift_custom/generators/ResetGenerator.dart';
import 'package:source_gen/source_gen.dart';
import 'package:build/build.dart';

Builder referenceBuilder(BuilderOptions options) {
  return LibraryBuilder(ReferenceGenerator(), generatedExtension: '.ref.dart');
}

Builder constructorBuilder(BuilderOptions options) {
  return LibraryBuilder(ConstructorGenerator(), generatedExtension: '.ctr.dart');
}


Builder resetBuilder(BuilderOptions options) {
  return LibraryBuilder(ResetGenerator(), generatedExtension: '.reset.dart');
}