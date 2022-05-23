part of drift_db;

extension DriftExt on DatabaseAccessor {
  ///

  /// [T] - 表类型，如 [Users]
  ///
  /// [D] - 实体，如 [User]/[UsersCompanion]
  ///
  /// [table] - 要对哪个表进行操作
  ///
  /// [entity] - 要插入的 [User]/[UsersCompanion] 的实体
  ///
  /// [tag] - 见 [Syncs.tag] 的注释
  ///
  /// [autoTransaction] - 是否在该函数内部创建事务块（若外部存在事务块，则为 false），因为 drift 不支持嵌套事务，所以添加了该参数。
  ///
  /// [mode] 和 [onConflict] - [InsertStatement.insertReturning] 的参数。
  Future<D> insertReturningWith<T extends Table, D>({
    required TableInfo<T, D> table,
    required Insertable<D> entity,
    required String tag,
    required bool autoTransaction,
    InsertMode? mode,
    UpsertClause<T, D>? onConflict,
  }) async {
    Future<D> handle() async {
      // 设置时间 - 每个插入语句都要设置（local/cloud）
      final dynamic entityDynamic = entity;
      entityDynamic.createdAt = DateTime.now().toDriftValue<DateTime>();
      entityDynamic.updatedAt = DateTime.now().toDriftValue<DateTime>();

      // 插入
      final newInto = into(table);
      final dynamic returningEntityDynamic = await newInto.insertReturning(entityDynamic, mode: mode, onConflict: onConflict);

      // 增加一条 sync 记录 - 仅对 cloud
      if (T is CloudTableBase) {
        await insertReturningWith(
          table: DriftDb.instance.syncs,
          entity: SyncsCompanion.insert(
            syncTableName: table.actualTableName,
            rowId: returningEntityDynamic.id,
            rowCloudId: returningEntityDynamic.cloudId,
            syncCurdType: SyncCurdType.c.toDriftValue(),
            syncUpdateColumns: null.toDriftValue(),
            tag: tag,
          ),
          tag: tag,
          autoTransaction: false,
        );
      }

      return returningEntityDynamic;
    }

    if (autoTransaction) {
      return await transaction(() async => await handle());
    }
    return await handle();
  }

  /// [T] - 表类型，如 [Users]
  ///
  /// [D] - 实体，如 [User]/[UsersCompanion]
  ///
  /// [table] - 要对哪个表进行操作
  ///
  /// [filter] - 更新 row 时的 where 语句
  ///
  /// [entity] - 要替换的 [User]/[UsersCompanion] 的实体
  ///
  /// [tag] - 见 [Syncs.tag] 的注释
  ///
  /// [autoTransaction] - 是否在该函数内部创建事务块（若外部存在事务块，则为 false），因为 drift 不支持嵌套事务，所以添加了该参数。
  Future<D?> replaceReturningWith<T extends Table, D>({
    required TableInfo<T, D> table,
    required Expression<bool?> Function(T tbl) filter,
    required Insertable<D> entity,
    required String tag,
    required bool autoTransaction,
  }) async {
    Future<D?> handle() async {
      // 设置时间 - 每个更新语句都要设置（local/cloud）
      final dynamic entityDynamic = entity;
      entityDynamic.updatedAt = DateTime.now().toDriftValue<DateTime>();

      // 修改某行
      final newUpdate = update(table)..where(filter);
      final int returningEntityCounts = await newUpdate.write(entityDynamic);
      if (returningEntityCounts == 0) {
        return null;
      } else if (returningEntityCounts == 1) {
      } else {
        throw '单次操作只能修改零行或一行!';
      }

      // 获取已被修改的行
      final List<D> returningEntities = await (select(table)..where(filter)).get();
      if (returningEntities.length != 1) {
        throw '获取到的已被修改的行数不为1!';
      }
      final dynamic returningEntity = returningEntities.first;

      // 获取被修改的 columns
      // 当 entity 为数据类(非 Companion 类型)时,其中的某个参数值可能为 null,意味着操作者有意的让它值为 null,因而 toColumns(false) 必须为 false,以便遵循操作者的主观意识.
      // 值可能为 ''/'key_1'/'key_1,key_2'...
      final String syncUpdateColumns = (entityDynamic as Insertable<D>).toColumns(false).keys.join(',');

      // 增加一条 sync 记录 - 仅对 cloud
      if (T is CloudTableBase) {
        await insertReturningWith(
          table: DriftDb.instance.syncs,
          entity: SyncsCompanion.insert(
            syncTableName: table.actualTableName,
            rowId: returningEntity.id,
            rowCloudId: returningEntity.cloudId,
            syncCurdType: SyncCurdType.u.toDriftValue(),
            syncUpdateColumns: syncUpdateColumns.toDriftValue(),
            tag: tag,
          ),
          tag: tag,
          autoTransaction: false,
        );
      }

      return returningEntity;
    }

    if (autoTransaction) {
      return await transaction(() async => await handle());
    }
    return await handle();
  }

  /// [T] - 表类型，如 [Users]
  ///
  /// [D] - 实体，如 [User]/[UsersCompanion]
  ///
  /// [table] - 要对哪个表进行操作
  ///
  /// [filter] - 更新 row 时的 where 语句
  ///
  /// [entity] - 要替换的 [User]/[UsersCompanion] 的实体
  ///
  /// [tag] - 见 [Syncs.tag] 的注释
  ///
  /// [autoTransaction] - 是否在该函数内部创建事务块（若外部存在事务块，则为 false），因为 drift 不支持嵌套事务，所以添加了该参数。
  Future<D?> deleteWith<T extends Table, D>({
    required TableInfo<T, D> table,
    required Expression<bool?> Function(T tbl) filter,
    required Insertable<D> entity,
    required String tag,
    required bool autoTransaction,
  }) async {
    Future<D?> handle() async {
      // delete(table).delete(entity)
      // 设置时间 - 每个更新语句都要设置（local/cloud）
      final dynamic entityDynamic = entity;
      entityDynamic.updatedAt = DateTime.now().toDriftValue<DateTime>();

      // 修改某行
      final newUpdate = update(table)..where(filter);
      final int returningEntityCounts = await newUpdate.write(entityDynamic);
      if (returningEntityCounts == 0) {
        return null;
      } else if (returningEntityCounts == 1) {
      } else {
        throw '单次操作只能修改零行或一行!';
      }

      // 获取已被修改的行
      final List<D> returningEntities = await (select(table)..where(filter)).get();
      if (returningEntities.length != 1) {
        throw '获取到的已被修改的行数不为1!';
      }
      final dynamic returningEntity = returningEntities.first;

      // 获取被修改的 columns
      // 当 entity 为数据类(非 Companion 类型)时,其中的某个参数值可能为 null,意味着操作者有意的让它值为 null,因而 toColumns(false) 必须为 false,以便遵循操作者的主观意识.
      // 值可能为 ''/'key_1'/'key_1,key_2'...
      final String syncUpdateColumns = (entityDynamic as Insertable<D>).toColumns(false).keys.join(',');

      // 增加一条 sync 记录 - 仅对 cloud
      if (T is CloudTableBase) {
        await insertReturningWith(
          table: DriftDb.instance.syncs,
          entity: SyncsCompanion.insert(
            syncTableName: table.actualTableName,
            rowId: returningEntity.id,
            rowCloudId: returningEntity.cloudId,
            syncCurdType: SyncCurdType.u.toDriftValue(),
            syncUpdateColumns: syncUpdateColumns.toDriftValue(),
            tag: tag,
          ),
          tag: tag,
          autoTransaction: false,
        );
      }

      return returningEntity;
    }

    if (autoTransaction) {
      return await transaction(() async => await handle());
    }
    return await handle();
  }
}
