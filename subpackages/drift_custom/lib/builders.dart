import 'package:drift_custom/generators/CrtGenerator.dart';
import 'package:drift_custom/generators/ReferenceGenerator.dart';
import 'package:drift_custom/generators/ResetGenerator.dart';
import 'package:source_gen/source_gen.dart';
import 'package:build/build.dart';

// Builder referenceBuilder(BuilderOptions options) {
//   return LibraryBuilder(ReferenceGenerator(), generatedExtension: '.ref.dart');
// }

Builder crtBuilder(BuilderOptions options) {
  return LibraryBuilder(CrtGenerator(), generatedExtension: '.crt.dart');
}


// Builder resetBuilder(BuilderOptions options) {
//   return LibraryBuilder(ResetGenerator(), generatedExtension: '.reset.dart');
// }