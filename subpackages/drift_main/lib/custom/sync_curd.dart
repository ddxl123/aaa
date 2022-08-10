part of drift_db;

/// 后面不带 'ing' - 暂未执行上传
/// 后面带 'ing' - 正在上传中
///
/// 原因：在客户端上传数据的过程中，客户端可能被断掉，从而客户端未对服务器所上传成功的响应消息进行接受处理。（若是服务器断掉，则客户端会收到失败的响应）
///
/// TODO: 带 'ing' 的处理方式：
///   - 服务端对比 updatedAt。
///   - 若相同，则服务端已同步过。
///   - 若客户端晚于服务端，则需要重新进行同步。
///   - 若客户端早于服务端， 则 1. 可能客户端、服务端时间被篡改；2. 该条数据在其他客户端已经被同步过了 TODO: 可依据此处设计多客户端登陆方案。
enum SyncCurdType {
  /// 增
  c,
  cing,

  /// 改
  u,
  uing,

  /// 删-暂未执行上传
  d,
  ding,
}

extension DriftSyncExt on DatabaseConnectionUser {
  ///

  /// 插入一条数据，并自动插入 createdAt/updatedAt，以及 id。
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
  /// [entity] - 要插入的 [User]/[UsersCompanion] 的实体
  ///
  /// [syncTag] - 见 [SyncTag] 的注释
  ///
  /// [mode] 和 [onConflict] - [InsertStatement.insertReturning] 的参数。
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
        entityDynamic.createdAt = DateTime.now().value();
        entityDynamic.updatedAt = DateTime.now().value();

        // 仅对 CloudTableBase 类型表生成 id，
        // LocalTableBase 类型表全部都是自增主键。
        if (table is CloudTableBase) {
          final mulUsers = await select(DriftDb.instance.users).get();
          if (mulUsers.length != 1) {
            throw 'users 行数不为1';
          }
          entityDynamic.id = (mulUsers.first.id + Helper.uuidV4).value();
        }

        // 插入
        final newInto = into(table);
        final dynamic returningEntityDynamic = await newInto.insertReturning(entityDynamic, mode: mode, onConflict: onConflict);

        // 增加一条 sync 记录 - 仅对 cloud
        if (table is CloudTableBase) {
          await insertReturningWith(
            DriftDb.instance.syncs,
            entity: SyncsCompanion(
              syncTableName: table.actualTableName.value(),
              rowId: (returningEntityDynamic.id as String).value(),
              syncCurdType: SyncCurdType.c.value(),
              syncUpdateColumns: null.value(),
              tag: syncTag.tag.value(),
            ),
            syncTag: syncTag,
          );
        }

        return returningEntityDynamic;
      },
    );
  }

  /// 根据 [entity] 的 id，修改一条数据，并自动修改 updatedAt。
  /// 如果[T] 是 [CloudTableBase] 的话，还会自动插入一条对应的 [Sync]。
  ///
  /// TODO: 测试：返回已被更新的行，返回 null 表示将更新的行不存在，或新旧值相同未发生更新。
  ///
  /// 如果外部没有事务，内部会自动创建事务。
  ///
  /// [entity] - 要替换的 [User]/[UsersCompanion] 的实体
  ///
  /// 注意：该函数不能修改 id。
  Future<DC?> updateReturningWith<T extends Table, DC extends DataClass, E extends Insertable<DC>>(
    TableInfo<T, DC> table, {
    required E entity,
    required SyncTag syncTag,
  }) async {
    return await transaction(
      () async {
        // 设置时间 - 每个更新语句都要设置（local/cloud）
        final dynamic entityDynamic = entity;
        // TODO: 如果之后执行失败的话，下面所修改的时间需要恢复。
        entityDynamic.updatedAt = DateTime.now().value();

        // 修改某行
        final newUpdate = update(table);
        final bool replaceResult = await newUpdate.replace(entityDynamic);
        if (!replaceResult) {
          return null;
        }

        // 获取已被修改的行
        final DC returningEntity = await (select(table)..where((tbl) => (tbl as dynamic).id.equal(entityDynamic.id))).getSingle();

        // 获取被修改的 columns
        // 当 entity 为数据类(非 Companion 类型)时,其中的某个参数值可能为 null,意味着操作者有意的让它值为 null,因而 toColumns(false) 必须为 false,以便遵循操作者的主观意识.
        // 值可能为 ''/'key_1'/'key_1,key_2'...
        final String syncUpdateColumns = (entityDynamic as E).toColumns(false).keys.join(',');

        // 增加一条 sync 记录 - 仅对 cloud
        if (table is CloudTableBase) {
          await insertReturningWith(
            DriftDb.instance.syncs,
            entity: SyncsCompanion(
              syncTableName: table.actualTableName.value(),
              rowId: ((returningEntity as dynamic).id as String).value(),
              syncCurdType: SyncCurdType.u.value(),
              syncUpdateColumns: syncUpdateColumns.value(),
              tag: syncTag.tag.value(),
            ),
            syncTag: syncTag,
          );
        }

        return returningEntity;
      },
    );
  }

  /// 删除一条数据。
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
          await insertReturningWith(
            DriftDb.instance.syncs,
            entity: SyncsCompanion(
              syncTableName: table.actualTableName.value(),
              rowId: (selectEntity.id as String).value(),
              syncCurdType: SyncCurdType.d.value(),
              syncUpdateColumns: null.value(),
              tag: syncTag.tag.value(),
            ),
            syncTag: syncTag,
          );
        }
        return selectEntity;
      },
    );
  }
}
