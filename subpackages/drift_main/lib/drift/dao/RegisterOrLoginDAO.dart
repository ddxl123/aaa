part of drift_db;

@DriftAccessor(
  tables: tableClasses,
)
class RegisterOrLoginDAO extends DatabaseAccessor<DriftDb> with _$RegisterOrLoginDAOMixin {
  RegisterOrLoginDAO(DriftDb attachedDatabase) : super(attachedDatabase);

  /// 返回是否本地登录成功。
  ///
  /// [loginTypeName] - 登录类型名称: phone email 等.
  ///
  /// [loginEditContent] - 所编辑的 phone 或 email 等的值.
  ///
  /// [isClearDbWhenUserDiff] - 见 [showExistClientLoggedInHandleDialog]。
  ///                         - 若返回 true,则将清除数据库,并且继续执行登录成功；
  ///                         - 若返回 false,则不清除数据库,并且执行登录失败。
  ///
  /// 登录后，本地数据库 [Users] 和 [ClientSyncInfos] 表中，必然各存在一条数据。
  Future<bool> clientLogin({
    required UsersCompanion usersCompanion,
    required String deviceInfo,
    required String token,
    required String loginTypeName,
    required String loginEditContent,
    required Future<bool> Function() isClearDbWhenUserDiff,
    required SyncTag syncTag,
  }) async {
    return await transaction<bool>(
      () async {
        var userOrNull = await db.generalQueryDAO.queryUserOrNull();
        var clientSyncInfoOrNull = await db.generalQueryDAO.queryClientSyncInfoOrNull();

        Future<void> clearDbAndDoLogin() async {
          await db.deleteDAO.clearDb();
          userOrNull = await db.rawDAO.rawInsertUser(newUsersCompanion: usersCompanion);
          await db.insertDAO.insertClientSyncInfo(
            newClientSyncInfoCompanion: Crt.clientSyncInfosCompanion(
              device_info: deviceInfo,
              recent_sync_time: null.toAbsent(),
              token: token.toValue(),
            ),
            syncTag: syncTag,
          );
        }

        // 如果不存在用户,则清空数据库后插入用户
        if (userOrNull == null || clientSyncInfoOrNull == null) {
          await clearDbAndDoLogin();
          return true;
        }

        // 在执行 login 前,如果本地存在已登录用户数据,必须先下线用户,否则抛出异常.
        if (clientSyncInfoOrNull.token != null) {
          logger.outError(show: "请先下线本地已登录账户！", print: "不应该执行到这里。因为在登录用户前，必须先注销本地已登录的用户！");
          return false;
        }

        Future<bool> ifs({required String savedLoginTypeValue}) async {
          if (savedLoginTypeValue == loginEditContent) {
            await db.updateDAO.resetClientSyncInfo(
              syncTag: syncTag,
              originalClientSyncInfoReset: (SyncTag resetSyncTag) async {
                return clientSyncInfoOrNull.reset(
                  // 实际上可更换可不更换
                  device_info: deviceInfo.toValue(),
                  recent_sync_time: toAbsent(),
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

  Future<void> clientLogout({required SyncTag syncTag}) async {
    final result = await db.generalQueryDAO.queryClientSyncInfoOrNull();
    if (result != null) {
      await db.updateDAO.resetClientSyncInfo(
        originalClientSyncInfoReset: (SyncTag resetSyncTag) async {
          return await result.reset(
            device_info: toAbsent(),
            recent_sync_time: toAbsent(),
            token: null.toValue(),
            syncTag: resetSyncTag,
          );
        },
        syncTag: syncTag,
      );
    }
  }
}
