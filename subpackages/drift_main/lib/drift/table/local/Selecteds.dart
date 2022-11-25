part of drift_db;

enum SelectedType {
  /// [Fragments]
  fragments,

  /// [FragmentGroups]
  fragmentGroups,
}

@ReferenceTo([])
class Selecteds extends LocalTableBase {
  IntColumn get selectedType => intEnum()();

  TextColumn get selectedId => text()();
}
