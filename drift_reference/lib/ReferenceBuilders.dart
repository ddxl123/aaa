import 'package:drift_reference/ReferenceGenerator.dart';
import 'package:source_gen/source_gen.dart';
import 'package:build/build.dart';

Builder referenceBuilder(BuilderOptions options) {
  return LibraryBuilder(ReferenceGenerator(), generatedExtension: '.ref.dart');
}
