part of drift_db;

@DriftAccessor(
  tables: tableClasses,
)
class RawInsertDAO extends DatabaseAccessor<DriftDb> with _$InsertDAOMixin {
  RawInsertDAO(DriftDb attachedDatabase) : super(attachedDatabase);

  /// [newUser] 可以使用 [Crt.usersCompanion]。
  Future<User> rawInsertUser({required UsersCompanion newUser}) async {
    final findUser = await db.generalQueryDAO.queryUserOrNull();
    if (findUser != null) throw '本地已存在用户！';
    return await into(db.users).insertReturning(newUser);
  }
}
