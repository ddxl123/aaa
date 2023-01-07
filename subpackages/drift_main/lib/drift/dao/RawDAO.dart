part of drift_db;

@DriftAccessor(
  tables: tableClasses,
)
class RawDAO extends DatabaseAccessor<DriftDb> with _$RawDAOMixin {
  RawDAO(DriftDb attachedDatabase) : super(attachedDatabase);

  /// [newUsersCompanion] 可以使用 [Crt.usersCompanion]。
  Future<User> rawInsertUser({required UsersCompanion newUsersCompanion}) async {
    final findUser = await db.generalQueryDAO.queryUserOrNull();
    if (findUser != null) throw "本地已存在用户！";
    return await into(db.users).insertReturning(newUsersCompanion);
  }


  // Future<User> rawInsertUserAndToken({
  //   required UsersCompanion newUsersCompanion,
  //   required ClientSyncInfo originalClientSyncInfo,
  //   required String token,
  // }) async {
  //   late User user;
  //   await transaction(
  //     () async {
  //       user = await rawInsertUser(newUsersCompanion: newUsersCompanion);
  //       await db.updateDAO.resetClientSyncInfo(
  //         originalClientSyncInfoReset: (SyncTag resetSyncTag) async {
  //           return originalClientSyncInfo.reset(
  //             deviceInfo: toAbsent(),
  //             recentSyncTime: toAbsent(),
  //             token: token.toValue(),
  //             syncTag: resetSyncTag,
  //           );
  //         },
  //         syncTag: null,
  //       );
  //     },
  //   );
  //   return user;
  // }

  /// 注销当前账户,注销前需要请求服务器端注销.
  // Future<void> rawLogoutCurrentUser() async {
  //   await transaction(
  //     () async {
  //       final clientSyncInfoOrNull = await db.generalQueryDAO.queryClientSyncInfoOrNull();
  //       if (clientSyncInfoOrNull == null) return;
  //       await db.updateDAO.resetClientSyncInfo(
  //         originalClientSyncInfoReset: (SyncTag resetSyncTag) async {
  //           return clientSyncInfoOrNull.reset(
  //             deviceInfo: toAbsent(),
  //             recentSyncTime: toAbsent(),
  //             token: null.toValue(),
  //             syncTag: resetSyncTag,
  //           );
  //         },
  //         syncTag: null,
  //       );
  //     },
  //   );
  // }
}
