part of drift_db;

extension DriftSyncExt on DatabaseConnectionUser {
  ///

  /// 插入一条数据，并自动插入 createdAt/updatedAt，以及 id。
  ///
  /// 1. 如果[T] 是 [CloudTableBase] 的话，还会自动插入一条对应的 [Sync]。
  ///
  /// 2. 对 [Users] 的插入是直接调用 into。
  ///
  /// 3. 返回插入的行(带有插入的id)，与传入的 [entity] 不是一个对象。
  ///
  /// 4. 如果外部没有事务，内部会自动创建事务。
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
  /// [syncTag] - 只有 [table] 为 [CloudTableBase] 类型时才会生效，否则将其置为 null（意味着为 local类型）。
  ///   - [Users] 表无需进行 sync，因此也应该让 [syncTag] 设为 null。
  ///
  /// 必须搭配 [withRefs] 使用。
  Future<DC> insertReturningWith<T extends Table, DC extends DataClass, E extends UpdateCompanion<DC>>(
    TableInfo<T, DC> table, {
    required E entity,
    required SyncTag? syncTag,
  }) async {
    return await transaction(
      () async {
        SyncTag? innerSyncTag = syncTag;

        if (table is Users) {
          if (innerSyncTag != null) throw '插入 User 实体无需进行 sync！';
          return await into(table).insertReturning(entity);
        }
        // 设置时间 - 每个插入语句都要设置（local/cloud）
        final dynamic entityDynamic = entity;
        entityDynamic.createdAt = DateTime.now().toValue();
        entityDynamic.updatedAt = DateTime.now().toValue();

        // CloudTableBase 类型表生成 String 类型 id，需要手动配置。
        //
        // LocalTableBase 类型表全部都是自增主键，不需要手动配置。
        if (table is CloudTableBase) {
          innerSyncTag = innerSyncTag ?? await SyncTag.create();
          // TODO: 可以使用全局获取 user。
          final mulUsers = await select(DriftDb.instance.users).get();
          if (mulUsers.length != 1) {
            throw 'users 行数不为1';
          }

          entityDynamic.id = innerSyncTag.createCloudId(userId: mulUsers.first.id).toValue();
        }

        // 插入
        final newInto = into(table);
        final dynamic returningEntityDynamic = await newInto.insertReturning(entityDynamic);

        // CloudTableBase 类型表需要添加一条 sync 记录。
        //
        // LocalTableBase 类型表不需要添加 sync。
        if (table is CloudTableBase) {
          await insertReturningWith(
            DriftDb.instance.syncs,
            entity: SyncsCompanion(
              syncTableName: table.actualTableName.toValue(),
              rowId: (returningEntityDynamic.id as String).toValue(),
              syncCurdType: SyncCurdType.c.toValue(),
              tag: innerSyncTag!.tag.toValue(),
            ),
            syncTag: innerSyncTag,
          );
        }

        return returningEntityDynamic;
      },
    );
  }

  /// 根据 [entity] 的 id，修改一条数据，并自动修改 updatedAt。
  ///
  /// 如果 [T] 是 [CloudTableBase] 且 [isSync] 为 true 的话，还会自动插入一条对应的 [Sync]。
  ///
  /// TODO: 测试：返回已被更新的行，返回 null 表示将更新的行不存在，或新旧值相同未发生更新。
  ///
  /// 如果外部没有事务，内部会自动创建事务。
  ///
  /// 对 [Users] 的更新是直接调用 update.replace。
  ///
  /// 注意：该函数不能修改 id。
  ///
  /// [entity] - 要替换的 [UsersCompanion] 的实体，不能为 [User]。
  ///
  /// [syncTag] - 若为空，则内部将自动创建一个。
  ///
  /// [isSync] - 是否进行同步。当新旧实体只有本地字段被修改时，应设为 false，当新旧实体存在同步字段被修改，因设为 true。
  ///
  /// 必须搭配 [withRefs] 与 [UserExt.reset] 使用。
  Future<DC?> updateReturningWith<T extends Table, DC extends DataClass, E extends UpdateCompanion<DC>>(
    TableInfo<T, DC> table, {
    required E entity,
    required bool isSync,
    required SyncTag? syncTag,
  }) async {
    return await transaction(
      () async {
        if (table is Users) {
          if (syncTag != null) throw '更新 User 实体无需进行 sync！';
          await update(table).replace(entity);
          return await (select(table)..where((tbl) => (tbl as dynamic).id.equals((entity as dynamic).id.value))).getSingle();
        }

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
        if ((table is CloudTableBase) && isSync == true) {
          final st = syncTag ?? await SyncTag.create();
          await insertReturningWith(
            DriftDb.instance.syncs,
            entity: SyncsCompanion(
              syncTableName: table.actualTableName.toValue(),
              rowId: (returningEntity as dynamic).id.toValue(),
              syncCurdType: SyncCurdType.u.toValue(),
              tag: st.tag.toValue(),
            ),
            syncTag: st,
          );
        }

        return returningEntity;
      },
    );
  }

  /// TODO: 删除一条数据。
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
