part of drift_db;

/// drift_helper.Value('value') 的快捷方法。
///
/// 使用方法 '123'.toDriftValue()。
extension DriftValueExt on Object? {
  Value<T> toDriftValue<T>() {
    return Value<T>(this as T);
  }
}

extension DriftSyncExt on DatabaseConnectionUser {
  ///

  /// [T] - 表类型 [Table]，如 [Users]
  ///
  /// [DC] - 数据类类型 [DataClass]，如 [User]（不包括 [UsersCompanion]）
  ///
  /// [E] - [Insertable] 类类型，如 [User]/[UsersCompanion]
  ///
  /// [table] - 要对哪个表进行操作
  ///
  /// [entity] - 要插入的 [User]/[UsersCompanion] 的实体
  ///
  /// [syncTag] - 见 [SyncTag] 的注释
  ///
  /// [mode] 和 [onConflict] - [InsertStatement.insertReturning] 的参数。
  Future<DC> syncInsertReturningWith<T extends Table, DC extends DataClass, E extends Insertable<DC>>({
    required TableInfo<T, DC> table,
    required E entity,
    required SyncTag syncTag,
    InsertMode? mode,
    UpsertClause<T, DC>? onConflict,
  }) async {
    return await transaction(
      () async {
        // 设置时间 - 每个插入语句都要设置（local/cloud）
        final dynamic entityDynamic = entity;
        entityDynamic.createdAt = DateTime.now().toDriftValue<DateTime>();
        entityDynamic.updatedAt = DateTime.now().toDriftValue<DateTime>();

        // 插入
        final newInto = into(table);
        final dynamic returningEntityDynamic = await newInto.insertReturning(entityDynamic, mode: mode, onConflict: onConflict);

        // 增加一条 sync 记录 - 仅对 cloud
        if (table is CloudTableBase) {
          await syncTag.check(tableName: table.actualTableName, id: returningEntityDynamic.id);
          await syncInsertReturningWith(
            table: DriftDb.instance.syncs,
            entity: SyncsCompanion(
              syncTableName: table.actualTableName.toDriftValue(),
              rowId: (returningEntityDynamic.id as int).toDriftValue(),
              rowCloudId: (returningEntityDynamic.cloudId as int?).toDriftValue(),
              syncCurdType: SyncCurdType.c.toDriftValue(),
              syncUpdateColumns: null.toDriftValue(),
              tag: syncTag.toString().toDriftValue(),
            ),
            syncTag: syncTag,
          );
        }

        return returningEntityDynamic;
      },
    );
  }

  /// [filter] - 更新 row 时的 where 语句
  ///
  /// [entity] - 要替换的 [User]/[UsersCompanion] 的实体
  Future<DC?> syncUpdateReturningWith<T extends Table, DC extends DataClass, E extends Insertable<DC>>({
    required TableInfo<T, DC> table,
    required Expression<bool?> Function(T tbl) filter,
    required E entity,
    required SyncTag syncTag,
  }) async {
    return await transaction(
      () async {
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
        final List<DC> returningEntities = await (select(table)..where(filter)).get();
        if (returningEntities.length != 1) {
          throw '获取到的已被修改的行数不为1!';
        }
        final dynamic returningEntity = returningEntities.first;

        // 获取被修改的 columns
        // 当 entity 为数据类(非 Companion 类型)时,其中的某个参数值可能为 null,意味着操作者有意的让它值为 null,因而 toColumns(false) 必须为 false,以便遵循操作者的主观意识.
        // 值可能为 ''/'key_1'/'key_1,key_2'...
        final String syncUpdateColumns = (entityDynamic as E).toColumns(false).keys.join(',');

        // 增加一条 sync 记录 - 仅对 cloud
        if (table is CloudTableBase) {
          await syncTag.check(tableName: table.actualTableName, id: returningEntity.id);
          await syncInsertReturningWith(
            table: DriftDb.instance.syncs,
            entity: SyncsCompanion(
              syncTableName: table.actualTableName.toDriftValue(),
              rowId: (returningEntity.id as int).toDriftValue(),
              rowCloudId: (returningEntity.cloudId as int?).toDriftValue(),
              syncCurdType: SyncCurdType.u.toDriftValue(),
              syncUpdateColumns: syncUpdateColumns.toDriftValue(),
              tag: syncTag.toString().toDriftValue(),
            ),
            syncTag: syncTag,
          );
        }

        return returningEntity;
      },
    );
  }

  /// [filter] - 删除 row 时的 where 语句
  ///
  /// [entity] - 要替换的 [User]/[UsersCompanion] 的实体
  Future<DC?> syncDeleteWith<T extends Table, DC extends DataClass, E extends Insertable<DC>>({
    required TableInfo<T, DC> table,
    required Expression<bool?> Function(T tbl) filter,
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
          await syncTag.check(tableName: table.actualTableName, id: selectEntity.id);
          await syncInsertReturningWith(
            table: DriftDb.instance.syncs,
            entity: SyncsCompanion(
              syncTableName: table.actualTableName.toDriftValue(),
              rowId: (selectEntity.id as int).toDriftValue(),
              rowCloudId: (selectEntity.cloudId as int?).toDriftValue(),
              syncCurdType: SyncCurdType.d.toDriftValue(),
              syncUpdateColumns: null.toDriftValue(),
              tag: syncTag.toString().toDriftValue(),
            ),
            syncTag: syncTag,
          );
        }
        return selectEntity;
      },
    );
  }
}
