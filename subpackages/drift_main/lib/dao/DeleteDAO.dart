part of drift_db;

/// TODO: 所有curd函数体都要包裹上事务。
@DriftAccessor(
  tables: [
    ...cloudTableClass,
    ...rTableClass,
  ],
)
class DeleteDAO extends DatabaseAccessor<DriftDb> with _$DeleteDAOMixin {
  DeleteDAO(DriftDb attachedDatabase) : super(attachedDatabase);
}
