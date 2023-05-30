part of drift_db;

abstract class ClientTableBase extends Table {
  @override
  bool get withoutRowId => true;
}

abstract class CloudTableBase extends Table {
  @override
  bool get withoutRowId => true;
}
