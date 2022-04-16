part of drift_db;


class Users extends TableBase {
  TextColumn get username => text().nullable()();

  TextColumn get password => text().nullable()();

  TextColumn get email => text().nullable()();

  IntColumn get age => integer().nullable()();
}

class FragmentGroups extends TableBase {
  TextColumn get name => text().nullable()();
}

class Fragments extends TableBase {
  TextColumn get content => text().nullable()();
}

class MemoryGroups extends TableBase {
  TextColumn get name => text().nullable()();
}
