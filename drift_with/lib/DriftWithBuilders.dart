import 'package:drift_with/DriftWithGenerator.dart';
import 'package:source_gen/source_gen.dart';
import 'package:build/build.dart';

Builder driftWithBuilder(BuilderOptions options) {
  return LibraryBuilder(DriftWithGenerator(), generatedExtension: '.driftWith.dart');
}
