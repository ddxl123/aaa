part of drift_db;

@DriftAccessor(
  tables: tableClasses,
)
class RawDAO extends DatabaseAccessor<DriftDb> with _$InsertDAOMixin {
  RawDAO(DriftDb attachedDatabase) : super(attachedDatabase);

  /// [newUsersCompanion] 可以使用 [Crt.usersCompanion]。
  Future<User> rawInsertUser({required UsersCompanion newUsersCompanion}) async {
    final findUser = await db.generalQueryDAO.queryUserOrNull();
    if (findUser != null) throw "本地已存在用户！";
    return await into(db.users).insertReturning(newUsersCompanion);
  }

  /// 返回是否本地登录成功.
  ///
  /// [loginTypeName] - 登录类型名称: phone email 等.
  ///
  /// [loginEditContent] - 所编辑的 phone 或 email 等的值.
  ///
  /// [isClearDbWhenUserDiff] 内部应该弹出"本地原有的用户与将要登录的用户不相同,登录新用户需要清空旧用户数据,是否要清空?"
  /// 若 [isClearDbWhenUserDiff] 返回 true,则清除数据库,并且继续执行登录成功; 若返回 false,则不清楚数据库,并且执行登录失败.
  Future<bool> clientLogin({
    required UsersCompanion usersCompanion,
    required String deviceInfo,
    required String token,
    required String loginTypeName,
    required String loginEditContent,
    required Future<bool> Function() isClearDbWhenUserDiff,
  }) async {
    return await transaction<bool>(
      () async {
        var userOrNull = await db.generalQueryDAO.queryUserOrNull();
        var clientSyncInfoOrNull = await db.generalQueryDAO.queryClientSyncInfoOrNull();

        Future<void> clearDbAndDoLogin() async {
          await db.deleteDAO.clearDb();
          userOrNull = await rawInsertUser(newUsersCompanion: usersCompanion);
          clientSyncInfoOrNull = await db.insertDAO.insertClientSyncInfo(
            newClientSyncInfoCompanion: Crt.clientSyncInfosCompanion(
              deviceInfo: deviceInfo,
              recentSyncTime: null.toAbsent(),
              token: token.toValue(),
            ),
          );
        }

        // 如果不存在用户,则清空数据库后插入用户
        if (userOrNull == null) {
          await clearDbAndDoLogin();
          return true;
        }

        // 在执行 login 前,如果本地存在已登录用户数据,必须先注销用户,否则抛出异常.
        if (clientSyncInfoOrNull!.token != null) {
          throw "不应该执行登录,但却执行了登录!";
        }

        Future<bool> ifs({required String savedLoginTypeValue}) async {
          if (savedLoginTypeValue == loginEditContent) {
            await db.updateDAO.resetClientSyncInfo(
              syncTag: null,
              originalClientSyncInfoReset: (SyncTag resetSyncTag) async {
                return clientSyncInfoOrNull!.reset(
                  // 实际上可更换可不更换
                  deviceInfo: deviceInfo.toValue(),
                  recentSyncTime: toAbsent(),
                  // 必须更换
                  token: token.toValue(),
                  syncTag: resetSyncTag,
                );
              },
            );
            return true;
          } else {
            final isClearDb = await isClearDbWhenUserDiff();
            if (isClearDb) {
              await clearDbAndDoLogin();
              return true;
            } else {
              return false;
            }
          }
        }

        if (loginTypeName == "email") {
          return await ifs(savedLoginTypeValue: userOrNull!.email!);
        } else if (loginEditContent == "phone") {
          return await ifs(savedLoginTypeValue: userOrNull!.phone!);
        } else {
          throw "未处理类型: $loginTypeName";
        }
      },
    );
  }

  Future<User> rawInsertUserAndToken({
    required UsersCompanion newUsersCompanion,
    required ClientSyncInfo originalClientSyncInfo,
    required String token,
  }) async {
    late User user;
    await transaction(
      () async {
        user = await rawInsertUser(newUsersCompanion: newUsersCompanion);
        await db.updateDAO.resetClientSyncInfo(
          originalClientSyncInfoReset: (SyncTag resetSyncTag) async {
            return originalClientSyncInfo.reset(
              deviceInfo: toAbsent(),
              recentSyncTime: toAbsent(),
              token: token.toValue(),
              syncTag: resetSyncTag,
            );
          },
          syncTag: null,
        );
      },
    );
    return user;
  }

  /// 注销当前账户,注销前需要请求服务器端注销.
  Future<void> rawLogoutCurrentUser() async {
    await transaction(
      () async {
        final clientSyncInfoOrNull = await db.generalQueryDAO.queryClientSyncInfoOrNull();
        if (clientSyncInfoOrNull == null) return;
        await db.updateDAO.resetClientSyncInfo(
          originalClientSyncInfoReset: (SyncTag resetSyncTag) async {
            return clientSyncInfoOrNull.reset(
              deviceInfo: toAbsent(),
              recentSyncTime: toAbsent(),
              token: null.toValue(),
              syncTag: resetSyncTag,
            );
          },
          syncTag: null,
        );
      },
    );
  }
}
