part of drift_db;

extension DriftSyncExt on DatabaseConnectionUser {
  ///

  /// 前 7 个字符
  /// 1. 最大时间点：4453-04-05 23:21:35
  /// 2. 最大 10 进制时间戳（单位s）：783 6416 4095
  /// 3. 最大 36 进制时间戳：'zzz zzzz'
  ///
  /// 中间 7 字符：
  /// 1. 用户 id(10进制) 转 36进制：
  /// 2. 最大值 10 进制值：783 6416 4095
  /// 3. 最大 36 进制值：'zzz zzzz'
  ///
  /// 最后 3 字符：
  /// 1. 随机值
  /// 2. 最大 10 进制值：46655
  /// 3. 最大 36 进制值：'zzz'
  ///
  /// 整体：
  /// 000 0000 - 000 0000 - 000
  String createId({required int userId}) {
    String prefix = (DateTime.now().millisecondsSinceEpoch ~/ 1000).toRadixString(36);
    String center = userId.toRadixString(36);
    String suffix = Random().nextInt(46655).toRadixString(36);
    prefix = '0' * (7 - prefix.length) + prefix;
    center = '0' * (7 - center.length) + center;
    suffix = '0' * (3 - suffix.length) + suffix;
    return prefix + center + suffix;
  }

  /// 插入一条数据，并自动插入 createdAt/updatedAt，以及 id。
  ///
  /// 如果[T] 是 [CloudTableBase] 的话，还会自动插入一条对应的 [Sync]。
  ///
  /// 对 [Users] 的插入不能使用该函数，但可以使用 [updateReturningWith] 函数对 user 进行更新。
  ///
  /// 返回插入的行(带有插入的id)，与传入的 [entity] 不是一个对象。
  ///
  /// 如果外部没有事务，内部会自动创建事务。
  ///
  /// [T] - 表类型 [Table]，如 [Users]
  ///
  /// [DC] - 数据类类型 [DataClass]，如 [User]（不包括 [UsersCompanion]）
  ///
  /// [E] - Companion 类类型，如 [UsersCompanion]（不包括 [User]）
  ///
  /// [table] - 要对哪个表进行操作
  ///
  /// [entity] - 要插入的 [UsersCompanion] 的实体，不能使用 [User]
  ///
  /// [syncTag] - 见 [SyncTag] 的注释
  ///
  /// [mode] 和 [onConflict] - [InsertStatement.insertReturning] 的参数。
  ///
  /// 必须搭配 [withRefs] 与 []使用。
  Future<DC> insertReturningWith<T extends Table, DC extends DataClass, E extends UpdateCompanion<DC>>(
    TableInfo<T, DC> table, {
    required E entity,
    required SyncTag syncTag,
    InsertMode? mode,
    UpsertClause<T, DC>? onConflict,
  }) async {
    return await transaction(
      () async {
        if (table is Users) {
          throw '对 [Users] 的插入不能使用该函数';
        }
        // 设置时间 - 每个插入语句都要设置（local/cloud）
        final dynamic entityDynamic = entity;
        entityDynamic.createdAt = DateTime.now().toValue();
        entityDynamic.updatedAt = DateTime.now().toValue();

        // 仅对 CloudTableBase 类型表生成 id，
        // LocalTableBase 类型表全部都是自增主键。
        if (table is CloudTableBase) {
          final mulUsers = await select(DriftDb.instance.users).get();
          if (mulUsers.length != 1) {
            throw 'users 行数不为1';
          }

          entityDynamic.id = createId(userId: mulUsers.first.id).toValue();
        }

        // 插入
        final newInto = into(table);
        print(entityDynamic);
        final dynamic returningEntityDynamic = await newInto.insertReturning(entityDynamic, mode: mode, onConflict: onConflict);

        // 增加一条 sync 记录 - 仅对 cloud
        if (table is CloudTableBase) {
          await insertReturningWith(
            DriftDb.instance.syncs,
            entity: SyncsCompanion(
              syncTableName: table.actualTableName.toValue(),
              rowId: (returningEntityDynamic.id as String).toValue(),
              syncCurdType: SyncCurdType.c.toValue(),
              tag: syncTag.tag.toValue(),
            ),
            syncTag: syncTag,
          );
        }

        return returningEntityDynamic;
      },
    );
  }

  /// 根据 [entity] 的 id，修改一条数据，并自动修改 updatedAt。
  ///
  /// 必须搭配 [withRefs] 与 [UserExt.reset] 使用。
  ///
  /// 如果[T] 是 [CloudTableBase] 的话，还会自动插入一条对应的 [Sync]。
  ///
  /// TODO: 测试：返回已被更新的行，返回 null 表示将更新的行不存在，或新旧值相同未发生更新。
  ///
  /// 如果外部没有事务，内部会自动创建事务。
  ///
  /// [entity] - 要替换的 [UsersCompanion] 的实体，不能为 [User]。
  ///
  /// 注意：该函数不能修改 id。
  Future<DC?> updateReturningWith<T extends Table, DC extends DataClass, E extends UpdateCompanion<DC>>(
    TableInfo<T, DC> table, {
    required E entity,
    required SyncTag syncTag,
  }) async {
    return await transaction(
      () async {
        // 设置时间 - 每个更新语句都要设置（local/cloud）
        final dynamic entityDynamic = entity;
        // TODO: 如果之后执行失败的话，下面所修改的时间需要恢复。
        entityDynamic.updatedAt = DateTime.now().toValue();

        // 修改某行
        final newUpdate = update(table);
        final bool replaceResult = await newUpdate.replace(entityDynamic);
        if (!replaceResult) {
          return null;
        }
        // 获取已被修改的行
        final DC returningEntity = await (select(table)..where((tbl) => (tbl as dynamic).id.equals(entityDynamic.id.value))).getSingle();

        // 增加一条 sync 记录 - 仅对 cloud
        if (table is CloudTableBase) {
          await insertReturningWith(
            DriftDb.instance.syncs,
            entity: SyncsCompanion(
              syncTableName: table.actualTableName.toValue(),
              rowId: ((returningEntity as dynamic).id as String).toValue(),
              syncCurdType: SyncCurdType.u.toValue(),
              tag: syncTag.tag.toValue(),
            ),
            syncTag: syncTag,
          );
        }

        return returningEntity;
      },
    );
  }

  /// 删除一条数据。
  ///
  /// 必须搭配 [withRefs] 与 [DriftSyncExt.deleteWith] 使用。
  ///
  /// 如果[T] 是 [CloudTableBase] 的话，还会自动插入一条对应的 [Sync]。
  ///
  /// 返回已被删除的行，返回 null 表示将删除的行不存在。
  ///
  /// 如果外部没有事务，内部会自动创建事务。
  ///
  /// [filter] - 删除 row 时的 where 语句
  ///
  /// [entity] - 要替换的 [User]/[UsersCompanion] 的实体
  Future<DC?> deleteWith<T extends Table, DC extends DataClass, E extends Insertable<DC>>(
    TableInfo<T, DC> table, {
    required Expression<bool> Function(T tbl) filter,
    required SyncTag syncTag,
  }) async {
    return await transaction(
      () async {
        // 查询要删除的行
        final selectEntities = await (select(table)..where(filter)).get();
        if (selectEntities.isEmpty) {
          return null;
        } else if (selectEntities.length == 1) {
        } else {
          throw '单次操作只能删除零行或一行!';
        }
        final dynamic selectEntity = selectEntities.first;

        // 执行删除操作
        final int deleteCount = await (delete(table).delete(selectEntity));
        if (deleteCount != 1) {
          throw '获取到的将删除的行数不为1!';
        }

        // 增加一条 sync 记录 - 仅对 cloud
        if (table is CloudTableBase) {
          await insertReturningWith(
            DriftDb.instance.syncs,
            entity: SyncsCompanion(
              syncTableName: table.actualTableName.toValue(),
              rowId: (selectEntity.id as String).toValue(),
              syncCurdType: SyncCurdType.d.toValue(),
              tag: syncTag.tag.toValue(),
            ),
            syncTag: syncTag,
          );
        }
        return selectEntity;
      },
    );
  }
}
