import 'package:aaa/drift/table/Base.dart';
import 'package:drift/drift.dart';

class AppInfo extends TableLocalBase {
  TextColumn get token => text()();

  BoolColumn get hasDownloadedInitData => boolean().withDefault(const Constant(false))();
}
