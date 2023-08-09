part of drift_db;

/// 不建议使用该同步方案。建议使用每个 row 都添加一个字段的方案来识别是否已被同步。
extension DriftSyncExt on DatabaseConnectionUser {
  ///

  /// 插入一条数据，并自动插入 created_at/updated_at，以及 id。
  ///
  /// 初始化插入不能使用该函数。
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
  ///
  /// [isCloudTableWithSync] - 需要同步的行是否需要进行同步。
  ///   - 在下载别人的碎片组等时，子碎片组不会再次上传到云端，而只会下载到本地，但是其表是带 cloud 表，因此增加 [isCloudTableWithSync] 来解决这个问题。
  ///
  /// [isCloudTableAutoId] - 在 [entity] 为 [CloudTableBase] 的前提下，是否根据 [syncTag] 自动生成 [entity] 的 id。
  ///   - 若为 true，则根据 [syncTag] 自动生成 [entity] 的 id。
  ///   - 若为 false，则根据 [entity] 的 id 进行插入。
  ///
  /// [isReplaceWhenIdSame] - 如果遇到 id 相同时，是否进行覆盖。
  ///   - 如果为 false，且遇到 id 相同，则会抛出异常并回滚。
  ///   - 如果为 true，且遇到 id 相同，则会覆盖掉。
  ///
  /// 必须搭配 [withRefs] 使用。
  Future<DC> insertReturningWith<T extends Table, DC extends DataClass, E extends UpdateCompanion<DC>>(
    TableInfo<T, DC> table, {
    required E entity,
    required SyncTag syncTag,
    required bool isCloudTableWithSync,
    required bool isCloudTableAutoId,
    required bool isReplaceWhenIdSame,
  }) async {
    return await transaction(
      () async {
        if (table is Users) {
          throw '对 User 的插入不能使用 insertReturningWith 函数，请使用 insertUser 函数进行插入！';
        }
        // 设置时间 - 每个插入语句都要设置（local/cloud）
        final dynamic entityDynamic = entity;
        // TODO: 如果是初始化下载，则时间必须保存下载的默认，而不能修改它。
        entityDynamic.created_at = DateTime.now().toValue();
        entityDynamic.updated_at = DateTime.now().toValue();

        // CloudTableBase 类型表生成 String 类型 id，需要手动配置。
        //
        // LocalTableBase 类型表全部都是自增主键，不需要手动配置。
        if (table is CloudTableBase) {
          if (isCloudTableAutoId) {
            // TODO: 可以使用全局获取 user。
            final mulUsers = await select(DriftDb.instance.users).get();
            if (mulUsers.length != 1) {
              throw 'users 行数不为1';
            }

            entityDynamic.id = syncTag.createCloudId(userId: mulUsers.first.id).toValue();
          }
        }

        // 插入
        final newInto = into(table);
        final dynamic returningEntityDynamic = await newInto.insertReturning(
          entityDynamic,
          mode: isReplaceWhenIdSame ? InsertMode.replace : InsertMode.insert,
        );

        // CloudTableBase 类型表需要添加一条 sync 记录。
        //
        // LocalTableBase 类型表不需要添加 sync。
        if ((table is CloudTableBase) && isCloudTableWithSync) {
          await insertReturningWith(
            DriftDb.instance.syncs,
            entity: SyncsCompanion(
              sync_table_name: table.actualTableName.toValue(),
              row_id: (returningEntityDynamic.id as String).toValue(),
              sync_curd_type: SyncCurdType.c.toValue(),
              tag: syncTag.tag.toValue(),
            ),
            syncTag: syncTag,
            isCloudTableWithSync: false,
            isCloudTableAutoId: false,
            isReplaceWhenIdSame: false,
          );
        }

        return returningEntityDynamic;
      },
    );
  }

  /// 根据 [entity] 的 id，修改一条数据，并自动修改 updated_at。
  ///
  /// 如果 [T] 是 [CloudTableBase] 且 [isCloudTableWithSync] 为 true 的话，还会自动插入一条对应的 [Sync]。
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
  /// [isCloudTableWithSync]
  ///   - 1. 当新旧实体只有本地字段被修改时，应设为 false，当新旧实体存在同步字段被修改，因设为 true。
  ///   - 2. 在下载别人的碎片组等时，子碎片组不会再次上传到云端，而只会下载到本地，但是其表是带 cloud 表，因此增加 [isCloudTableWithSync] 来解决这个问题。
  ///
  /// 必须搭配 [withRefs] 与 [UserExt.reset] 使用。
  Future<DC?> updateReturningWith<T extends Table, DC extends DataClass, E extends UpdateCompanion<DC>>(
    TableInfo<T, DC> table, {
    required E entity,
    required bool isCloudTableWithSync,
    required SyncTag syncTag,
  }) async {
    return await transaction(
      () async {
        if (table is Users) {
          throw '对 User 的更新不能使用 updateReturningWith 函数，请使用';
        }

        // 设置时间 - 每个更新语句都要设置（local/cloud）
        final dynamic entityDynamic = entity;
        // TODO: 如果之后执行失败的话，下面所修改的时间需要恢复。
        entityDynamic.updated_at = DateTime.now().toValue();

        // 修改某行
        final newUpdate = update(table);
        final bool replaceResult = await newUpdate.replace(entityDynamic);
        if (!replaceResult) {
          return null;
        }
        // 获取已被修改的行
        final DC returningEntity = await (select(table)..where((tbl) => (tbl as dynamic).id.equals(entityDynamic.id.value))).getSingle();

        // 增加一条 sync 记录 - 仅对 cloud
        if ((table is CloudTableBase) && isCloudTableWithSync) {
          await insertReturningWith(
            DriftDb.instance.syncs,
            entity: SyncsCompanion(
              sync_table_name: table.actualTableName.toValue(),
              // 无法识别到 dynamic.toValue() 这个扩展，因此直接使用 Value()。
              row_id: Value((returningEntity as dynamic).id),
              sync_curd_type: SyncCurdType.u.toValue(),
              tag: syncTag.tag.toValue(),
            ),
            syncTag: syncTag,
            isCloudTableWithSync: false,
            isCloudTableAutoId: false,
            isReplaceWhenIdSame: false,
          );
        }

        return returningEntity;
      },
    );
  }

  /// 如果[T] 是 [CloudTableBase] 的话，还会自动插入一条对应的 [Sync]。
  ///
  /// 返回已被删除的行，返回 null 表示将删除的行不存在。
  ///
  /// 如果外部没有事务，内部会自动创建事务。
  ///
  /// [entity] - 要替换的 [User] 的实体，不能是 [UsersCompanion]。
  ///
  /// [isCloudTableWithSync]
  ///   - 在下载别人的碎片组等时，子碎片组不会再次上传到云端，而只会下载到本地，但是其表是带 cloud 表，因此增加 [isCloudTableWithSync] 来解决这个问题。
  ///
  Future<void> deleteWith<T extends Table, DC extends DataClass, E extends Insertable<DC>>(
    TableInfo<T, DC> table, {
    required E entity,
    required SyncTag syncTag,
    required bool isCloudTableWithSync,
  }) async {
    return await transaction(
      () async {
        // 执行删除操作
        final int deleteCount = await (delete(table).delete(entity));
        if (deleteCount != 1) {
          return;
        }

        // 增加一条 sync 记录 - 仅对 cloud
        if ((table is CloudTableBase) && isCloudTableWithSync) {
          await insertReturningWith(
            DriftDb.instance.syncs,
            entity: SyncsCompanion(
              sync_table_name: table.actualTableName.toValue(),
              row_id: ((entity as dynamic).id as String).toValue(),
              sync_curd_type: SyncCurdType.d.toValue(),
              tag: syncTag.tag.toValue(),
            ),
            syncTag: syncTag,
            isCloudTableWithSync: false,
            isCloudTableAutoId: false,
            isReplaceWhenIdSame: false,
          );
        }
      },
    );
  }
}
