part of drift_db;

@DriftAccessor(
  tables: tableClasses,
)
class RawInsertDAO extends DatabaseAccessor<DriftDb> with _$InsertDAOMixin {
  RawInsertDAO(DriftDb attachedDatabase) : super(attachedDatabase);

  /// [newUser] 可以使用 [Crt.usersCompanion]，需要手动输入 id、createAt、updateAt。
  Future<User> rawInsertUser({required UsersCompanion newUser}) async {
    final findUser = await db.generalQueryDAO.queryUserOrNull();
    if (findUser != null) throw '本地已存在用户！';
    if (!newUser.id.present) throw "为对以下进行赋值: UsersCompanion.id";
    if (!newUser.createdAt.present) throw "为对以下进行赋值: UsersCompanion.createdAt";
    if (!newUser.updatedAt.present) throw "为对以下进行赋值: UsersCompanion.updatedAt";
    return await into(db.users).insertReturning(newUser);
  }
}
