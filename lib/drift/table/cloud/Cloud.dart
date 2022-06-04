part of drift_db;

const List<Type> cloudTableClass = [
  Users,
  Fragments,
  FragmentGroups,
  MemoryGroups,
];

class Users extends CloudTableBase {
  TextColumn get username => text().nullable()();

  TextColumn get password => text().nullable()();

  TextColumn get email => text().nullable()();

  IntColumn get age => integer().nullable()();
}

class Fragments extends CloudTableBase {
  TextColumn get title => text().nullable()();
}

class FragmentGroups extends CloudTableBase {
  TextColumn get title => text().nullable()();
}

class MemoryGroups extends CloudTableBase {
  TextColumn get title => text().nullable()();
}
