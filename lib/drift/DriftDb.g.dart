// GENERATED CODE - DO NOT MODIFY BY HAND

part of drift_db;

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class AppInfo extends DataClass implements Insertable<AppInfo> {
  int id;
  int? cloudId;

  /// 同步 curd 类型。为空则表示该行 不需要进行同步。
  ///
  /// 值： null C-0 U-1 R-2 D-3
  ///
  /// 不为 null 的可能性：
  ///   1. 未上传更改。
  ///   2. 客户端上传数据后，客户端被断掉，从而未对服务器上传成功的消息进行接收。（若是服务器断掉，则客户端会收到失败的响应）
  ///
  /// 若客户端请求——服务器响应，这个流程成功则设为 null，失败则保持为 curd。
  /// 若为 2 的情况，应用会再次检索未上传的数据，再次进行上传，但无碍，因为服务端上传时，会对比 updatedAt。
  ///   - 若新旧相同，则服务端已同步过，响应客户端将其置空。
  ///   - 若新的晚于旧的，则需要服务端进行同步后，响应客户端将其置空。
  ///   - 若新的早于旧的，则 1. 可能客户端、服务端时间被篡改；2. 该条数据在其他客户端已经被同步过了 TODO: 可依据此处设计多客户端登陆方案。
  SyncCurd? syncCurd;

  /// 当 [syncCurd] 为 U-1 时，[syncUpdateColumns] 不能为空。
  ///
  /// 值为字段名，如："username,password"。
  String? syncUpdateColumns;

  /// 必须是本地时间，因为用户是在本地被创建、修改。
  DateTime createdAt;

  /// 必须是本地时间，因为用户是在本地被创建、修改。
  DateTime updatedAt;
  String token;
  bool hasDownloadedInitData;
  AppInfo(
      {required this.id,
      this.cloudId,
      this.syncCurd,
      this.syncUpdateColumns,
      required this.createdAt,
      required this.updatedAt,
      required this.token,
      required this.hasDownloadedInitData});
  factory AppInfo.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return AppInfo(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      cloudId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}cloud_id']),
      syncCurd: $AppInfosTable.$converter0.mapToDart(const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}sync_curd'])),
      syncUpdateColumns: const StringType().mapFromDatabaseResponse(
          data['${effectivePrefix}sync_update_columns']),
      createdAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at'])!,
      updatedAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}updated_at'])!,
      token: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}token'])!,
      hasDownloadedInitData: const BoolType().mapFromDatabaseResponse(
          data['${effectivePrefix}has_downloaded_init_data'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || cloudId != null) {
      map['cloud_id'] = Variable<int?>(cloudId);
    }
    if (!nullToAbsent || syncCurd != null) {
      final converter = $AppInfosTable.$converter0;
      map['sync_curd'] = Variable<int?>(converter.mapToSql(syncCurd));
    }
    if (!nullToAbsent || syncUpdateColumns != null) {
      map['sync_update_columns'] = Variable<String?>(syncUpdateColumns);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['token'] = Variable<String>(token);
    map['has_downloaded_init_data'] = Variable<bool>(hasDownloadedInitData);
    return map;
  }

  AppInfosCompanion toCompanion(bool nullToAbsent) {
    return AppInfosCompanion(
      id: Value(id),
      cloudId: cloudId == null && nullToAbsent
          ? const Value.absent()
          : Value(cloudId),
      syncCurd: syncCurd == null && nullToAbsent
          ? const Value.absent()
          : Value(syncCurd),
      syncUpdateColumns: syncUpdateColumns == null && nullToAbsent
          ? const Value.absent()
          : Value(syncUpdateColumns),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      token: Value(token),
      hasDownloadedInitData: Value(hasDownloadedInitData),
    );
  }

  factory AppInfo.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppInfo(
      id: serializer.fromJson<int>(json['id']),
      cloudId: serializer.fromJson<int?>(json['cloudId']),
      syncCurd: serializer.fromJson<SyncCurd?>(json['syncCurd']),
      syncUpdateColumns:
          serializer.fromJson<String?>(json['syncUpdateColumns']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      token: serializer.fromJson<String>(json['token']),
      hasDownloadedInitData:
          serializer.fromJson<bool>(json['hasDownloadedInitData']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'cloudId': serializer.toJson<int?>(cloudId),
      'syncCurd': serializer.toJson<SyncCurd?>(syncCurd),
      'syncUpdateColumns': serializer.toJson<String?>(syncUpdateColumns),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'token': serializer.toJson<String>(token),
      'hasDownloadedInitData': serializer.toJson<bool>(hasDownloadedInitData),
    };
  }

  AppInfo copyWith(
          {int? id,
          int? cloudId,
          SyncCurd? syncCurd,
          String? syncUpdateColumns,
          DateTime? createdAt,
          DateTime? updatedAt,
          String? token,
          bool? hasDownloadedInitData}) =>
      AppInfo(
        id: id ?? this.id,
        cloudId: cloudId ?? this.cloudId,
        syncCurd: syncCurd ?? this.syncCurd,
        syncUpdateColumns: syncUpdateColumns ?? this.syncUpdateColumns,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        token: token ?? this.token,
        hasDownloadedInitData:
            hasDownloadedInitData ?? this.hasDownloadedInitData,
      );
  @override
  String toString() {
    return (StringBuffer('AppInfo(')
          ..write('id: $id, ')
          ..write('cloudId: $cloudId, ')
          ..write('syncCurd: $syncCurd, ')
          ..write('syncUpdateColumns: $syncUpdateColumns, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('token: $token, ')
          ..write('hasDownloadedInitData: $hasDownloadedInitData')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, cloudId, syncCurd, syncUpdateColumns,
      createdAt, updatedAt, token, hasDownloadedInitData);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppInfo &&
          other.id == this.id &&
          other.cloudId == this.cloudId &&
          other.syncCurd == this.syncCurd &&
          other.syncUpdateColumns == this.syncUpdateColumns &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.token == this.token &&
          other.hasDownloadedInitData == this.hasDownloadedInitData);
}

class AppInfosCompanion extends UpdateCompanion<AppInfo> {
  Value<int> id;
  Value<int?> cloudId;
  Value<SyncCurd?> syncCurd;
  Value<String?> syncUpdateColumns;
  Value<DateTime> createdAt;
  Value<DateTime> updatedAt;
  Value<String> token;
  Value<bool> hasDownloadedInitData;
  AppInfosCompanion({
    this.id = const Value.absent(),
    this.cloudId = const Value.absent(),
    this.syncCurd = const Value.absent(),
    this.syncUpdateColumns = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.token = const Value.absent(),
    this.hasDownloadedInitData = const Value.absent(),
  });
  AppInfosCompanion.insert({
    this.id = const Value.absent(),
    this.cloudId = const Value.absent(),
    this.syncCurd = const Value.absent(),
    this.syncUpdateColumns = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required String token,
    this.hasDownloadedInitData = const Value.absent(),
  }) : token = Value(token);
  static Insertable<AppInfo> custom({
    Expression<int>? id,
    Expression<int?>? cloudId,
    Expression<SyncCurd?>? syncCurd,
    Expression<String?>? syncUpdateColumns,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? token,
    Expression<bool>? hasDownloadedInitData,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (cloudId != null) 'cloud_id': cloudId,
      if (syncCurd != null) 'sync_curd': syncCurd,
      if (syncUpdateColumns != null) 'sync_update_columns': syncUpdateColumns,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (token != null) 'token': token,
      if (hasDownloadedInitData != null)
        'has_downloaded_init_data': hasDownloadedInitData,
    });
  }

  AppInfosCompanion copyWith(
      {Value<int>? id,
      Value<int?>? cloudId,
      Value<SyncCurd?>? syncCurd,
      Value<String?>? syncUpdateColumns,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<String>? token,
      Value<bool>? hasDownloadedInitData}) {
    return AppInfosCompanion(
      id: id ?? this.id,
      cloudId: cloudId ?? this.cloudId,
      syncCurd: syncCurd ?? this.syncCurd,
      syncUpdateColumns: syncUpdateColumns ?? this.syncUpdateColumns,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      token: token ?? this.token,
      hasDownloadedInitData:
          hasDownloadedInitData ?? this.hasDownloadedInitData,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (cloudId.present) {
      map['cloud_id'] = Variable<int?>(cloudId.value);
    }
    if (syncCurd.present) {
      final converter = $AppInfosTable.$converter0;
      map['sync_curd'] = Variable<int?>(converter.mapToSql(syncCurd.value));
    }
    if (syncUpdateColumns.present) {
      map['sync_update_columns'] = Variable<String?>(syncUpdateColumns.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (token.present) {
      map['token'] = Variable<String>(token.value);
    }
    if (hasDownloadedInitData.present) {
      map['has_downloaded_init_data'] =
          Variable<bool>(hasDownloadedInitData.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppInfosCompanion(')
          ..write('id: $id, ')
          ..write('cloudId: $cloudId, ')
          ..write('syncCurd: $syncCurd, ')
          ..write('syncUpdateColumns: $syncUpdateColumns, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('token: $token, ')
          ..write('hasDownloadedInitData: $hasDownloadedInitData')
          ..write(')'))
        .toString();
  }
}

class $AppInfosTable extends AppInfos with TableInfo<$AppInfosTable, AppInfo> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppInfosTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _cloudIdMeta = const VerificationMeta('cloudId');
  @override
  late final GeneratedColumn<int?> cloudId = GeneratedColumn<int?>(
      'cloud_id', aliasedName, true,
      type: const IntType(),
      requiredDuringInsert: false,
      $customConstraints: 'UNIQUE');
  final VerificationMeta _syncCurdMeta = const VerificationMeta('syncCurd');
  @override
  late final GeneratedColumnWithTypeConverter<SyncCurd?, int?> syncCurd =
      GeneratedColumn<int?>('sync_curd', aliasedName, true,
              type: const IntType(), requiredDuringInsert: false)
          .withConverter<SyncCurd?>($AppInfosTable.$converter0);
  final VerificationMeta _syncUpdateColumnsMeta =
      const VerificationMeta('syncUpdateColumns');
  @override
  late final GeneratedColumn<String?> syncUpdateColumns =
      GeneratedColumn<String?>('sync_update_columns', aliasedName, true,
          type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime?> createdAt = GeneratedColumn<DateTime?>(
      'created_at', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now());
  final VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime?> updatedAt = GeneratedColumn<DateTime?>(
      'updated_at', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now());
  final VerificationMeta _tokenMeta = const VerificationMeta('token');
  @override
  late final GeneratedColumn<String?> token = GeneratedColumn<String?>(
      'token', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _hasDownloadedInitDataMeta =
      const VerificationMeta('hasDownloadedInitData');
  @override
  late final GeneratedColumn<bool?> hasDownloadedInitData =
      GeneratedColumn<bool?>('has_downloaded_init_data', aliasedName, false,
          type: const BoolType(),
          requiredDuringInsert: false,
          defaultConstraints: 'CHECK (has_downloaded_init_data IN (0, 1))',
          defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        cloudId,
        syncCurd,
        syncUpdateColumns,
        createdAt,
        updatedAt,
        token,
        hasDownloadedInitData
      ];
  @override
  String get aliasedName => _alias ?? 'app_infos';
  @override
  String get actualTableName => 'app_infos';
  @override
  VerificationContext validateIntegrity(Insertable<AppInfo> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('cloud_id')) {
      context.handle(_cloudIdMeta,
          cloudId.isAcceptableOrUnknown(data['cloud_id']!, _cloudIdMeta));
    }
    context.handle(_syncCurdMeta, const VerificationResult.success());
    if (data.containsKey('sync_update_columns')) {
      context.handle(
          _syncUpdateColumnsMeta,
          syncUpdateColumns.isAcceptableOrUnknown(
              data['sync_update_columns']!, _syncUpdateColumnsMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('token')) {
      context.handle(
          _tokenMeta, token.isAcceptableOrUnknown(data['token']!, _tokenMeta));
    } else if (isInserting) {
      context.missing(_tokenMeta);
    }
    if (data.containsKey('has_downloaded_init_data')) {
      context.handle(
          _hasDownloadedInitDataMeta,
          hasDownloadedInitData.isAcceptableOrUnknown(
              data['has_downloaded_init_data']!, _hasDownloadedInitDataMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AppInfo map(Map<String, dynamic> data, {String? tablePrefix}) {
    return AppInfo.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $AppInfosTable createAlias(String alias) {
    return $AppInfosTable(attachedDatabase, alias);
  }

  static TypeConverter<SyncCurd?, int> $converter0 =
      const EnumIndexConverter<SyncCurd>(SyncCurd.values);
}

class FatherChildData extends DataClass implements Insertable<FatherChildData> {
  int id;
  int? cloudId;

  /// 同步 curd 类型。为空则表示该行 不需要进行同步。
  ///
  /// 值： null C-0 U-1 R-2 D-3
  ///
  /// 不为 null 的可能性：
  ///   1. 未上传更改。
  ///   2. 客户端上传数据后，客户端被断掉，从而未对服务器上传成功的消息进行接收。（若是服务器断掉，则客户端会收到失败的响应）
  ///
  /// 若客户端请求——服务器响应，这个流程成功则设为 null，失败则保持为 curd。
  /// 若为 2 的情况，应用会再次检索未上传的数据，再次进行上传，但无碍，因为服务端上传时，会对比 updatedAt。
  ///   - 若新旧相同，则服务端已同步过，响应客户端将其置空。
  ///   - 若新的晚于旧的，则需要服务端进行同步后，响应客户端将其置空。
  ///   - 若新的早于旧的，则 1. 可能客户端、服务端时间被篡改；2. 该条数据在其他客户端已经被同步过了 TODO: 可依据此处设计多客户端登陆方案。
  SyncCurd? syncCurd;

  /// 当 [syncCurd] 为 U-1 时，[syncUpdateColumns] 不能为空。
  ///
  /// 值为字段名，如："username,password"。
  String? syncUpdateColumns;

  /// 必须是本地时间，因为用户是在本地被创建、修改。
  DateTime createdAt;

  /// 必须是本地时间，因为用户是在本地被创建、修改。
  DateTime updatedAt;
  FatherChildType type;
  int? fatherId;
  int? fatherCloudId;
  int? childId;
  int? childCloudId;
  FatherChildData(
      {required this.id,
      this.cloudId,
      this.syncCurd,
      this.syncUpdateColumns,
      required this.createdAt,
      required this.updatedAt,
      required this.type,
      this.fatherId,
      this.fatherCloudId,
      this.childId,
      this.childCloudId});
  factory FatherChildData.fromData(Map<String, dynamic> data,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return FatherChildData(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      cloudId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}cloud_id']),
      syncCurd: $FatherChildTable.$converter0.mapToDart(const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}sync_curd'])),
      syncUpdateColumns: const StringType().mapFromDatabaseResponse(
          data['${effectivePrefix}sync_update_columns']),
      createdAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at'])!,
      updatedAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}updated_at'])!,
      type: $FatherChildTable.$converter1.mapToDart(const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}type']))!,
      fatherId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}father_id']),
      fatherCloudId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}father_cloud_id']),
      childId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}child_id']),
      childCloudId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}child_cloud_id']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || cloudId != null) {
      map['cloud_id'] = Variable<int?>(cloudId);
    }
    if (!nullToAbsent || syncCurd != null) {
      final converter = $FatherChildTable.$converter0;
      map['sync_curd'] = Variable<int?>(converter.mapToSql(syncCurd));
    }
    if (!nullToAbsent || syncUpdateColumns != null) {
      map['sync_update_columns'] = Variable<String?>(syncUpdateColumns);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    {
      final converter = $FatherChildTable.$converter1;
      map['type'] = Variable<int>(converter.mapToSql(type)!);
    }
    if (!nullToAbsent || fatherId != null) {
      map['father_id'] = Variable<int?>(fatherId);
    }
    if (!nullToAbsent || fatherCloudId != null) {
      map['father_cloud_id'] = Variable<int?>(fatherCloudId);
    }
    if (!nullToAbsent || childId != null) {
      map['child_id'] = Variable<int?>(childId);
    }
    if (!nullToAbsent || childCloudId != null) {
      map['child_cloud_id'] = Variable<int?>(childCloudId);
    }
    return map;
  }

  FatherChildCompanion toCompanion(bool nullToAbsent) {
    return FatherChildCompanion(
      id: Value(id),
      cloudId: cloudId == null && nullToAbsent
          ? const Value.absent()
          : Value(cloudId),
      syncCurd: syncCurd == null && nullToAbsent
          ? const Value.absent()
          : Value(syncCurd),
      syncUpdateColumns: syncUpdateColumns == null && nullToAbsent
          ? const Value.absent()
          : Value(syncUpdateColumns),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      type: Value(type),
      fatherId: fatherId == null && nullToAbsent
          ? const Value.absent()
          : Value(fatherId),
      fatherCloudId: fatherCloudId == null && nullToAbsent
          ? const Value.absent()
          : Value(fatherCloudId),
      childId: childId == null && nullToAbsent
          ? const Value.absent()
          : Value(childId),
      childCloudId: childCloudId == null && nullToAbsent
          ? const Value.absent()
          : Value(childCloudId),
    );
  }

  factory FatherChildData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FatherChildData(
      id: serializer.fromJson<int>(json['id']),
      cloudId: serializer.fromJson<int?>(json['cloudId']),
      syncCurd: serializer.fromJson<SyncCurd?>(json['syncCurd']),
      syncUpdateColumns:
          serializer.fromJson<String?>(json['syncUpdateColumns']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      type: serializer.fromJson<FatherChildType>(json['type']),
      fatherId: serializer.fromJson<int?>(json['fatherId']),
      fatherCloudId: serializer.fromJson<int?>(json['fatherCloudId']),
      childId: serializer.fromJson<int?>(json['childId']),
      childCloudId: serializer.fromJson<int?>(json['childCloudId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'cloudId': serializer.toJson<int?>(cloudId),
      'syncCurd': serializer.toJson<SyncCurd?>(syncCurd),
      'syncUpdateColumns': serializer.toJson<String?>(syncUpdateColumns),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'type': serializer.toJson<FatherChildType>(type),
      'fatherId': serializer.toJson<int?>(fatherId),
      'fatherCloudId': serializer.toJson<int?>(fatherCloudId),
      'childId': serializer.toJson<int?>(childId),
      'childCloudId': serializer.toJson<int?>(childCloudId),
    };
  }

  FatherChildData copyWith(
          {int? id,
          int? cloudId,
          SyncCurd? syncCurd,
          String? syncUpdateColumns,
          DateTime? createdAt,
          DateTime? updatedAt,
          FatherChildType? type,
          int? fatherId,
          int? fatherCloudId,
          int? childId,
          int? childCloudId}) =>
      FatherChildData(
        id: id ?? this.id,
        cloudId: cloudId ?? this.cloudId,
        syncCurd: syncCurd ?? this.syncCurd,
        syncUpdateColumns: syncUpdateColumns ?? this.syncUpdateColumns,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        type: type ?? this.type,
        fatherId: fatherId ?? this.fatherId,
        fatherCloudId: fatherCloudId ?? this.fatherCloudId,
        childId: childId ?? this.childId,
        childCloudId: childCloudId ?? this.childCloudId,
      );
  @override
  String toString() {
    return (StringBuffer('FatherChildData(')
          ..write('id: $id, ')
          ..write('cloudId: $cloudId, ')
          ..write('syncCurd: $syncCurd, ')
          ..write('syncUpdateColumns: $syncUpdateColumns, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('type: $type, ')
          ..write('fatherId: $fatherId, ')
          ..write('fatherCloudId: $fatherCloudId, ')
          ..write('childId: $childId, ')
          ..write('childCloudId: $childCloudId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      cloudId,
      syncCurd,
      syncUpdateColumns,
      createdAt,
      updatedAt,
      type,
      fatherId,
      fatherCloudId,
      childId,
      childCloudId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FatherChildData &&
          other.id == this.id &&
          other.cloudId == this.cloudId &&
          other.syncCurd == this.syncCurd &&
          other.syncUpdateColumns == this.syncUpdateColumns &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.type == this.type &&
          other.fatherId == this.fatherId &&
          other.fatherCloudId == this.fatherCloudId &&
          other.childId == this.childId &&
          other.childCloudId == this.childCloudId);
}

class FatherChildCompanion extends UpdateCompanion<FatherChildData> {
  Value<int> id;
  Value<int?> cloudId;
  Value<SyncCurd?> syncCurd;
  Value<String?> syncUpdateColumns;
  Value<DateTime> createdAt;
  Value<DateTime> updatedAt;
  Value<FatherChildType> type;
  Value<int?> fatherId;
  Value<int?> fatherCloudId;
  Value<int?> childId;
  Value<int?> childCloudId;
  FatherChildCompanion({
    this.id = const Value.absent(),
    this.cloudId = const Value.absent(),
    this.syncCurd = const Value.absent(),
    this.syncUpdateColumns = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.type = const Value.absent(),
    this.fatherId = const Value.absent(),
    this.fatherCloudId = const Value.absent(),
    this.childId = const Value.absent(),
    this.childCloudId = const Value.absent(),
  });
  FatherChildCompanion.insert({
    this.id = const Value.absent(),
    this.cloudId = const Value.absent(),
    this.syncCurd = const Value.absent(),
    this.syncUpdateColumns = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required FatherChildType type,
    this.fatherId = const Value.absent(),
    this.fatherCloudId = const Value.absent(),
    this.childId = const Value.absent(),
    this.childCloudId = const Value.absent(),
  }) : type = Value(type);
  static Insertable<FatherChildData> custom({
    Expression<int>? id,
    Expression<int?>? cloudId,
    Expression<SyncCurd?>? syncCurd,
    Expression<String?>? syncUpdateColumns,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<FatherChildType>? type,
    Expression<int?>? fatherId,
    Expression<int?>? fatherCloudId,
    Expression<int?>? childId,
    Expression<int?>? childCloudId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (cloudId != null) 'cloud_id': cloudId,
      if (syncCurd != null) 'sync_curd': syncCurd,
      if (syncUpdateColumns != null) 'sync_update_columns': syncUpdateColumns,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (type != null) 'type': type,
      if (fatherId != null) 'father_id': fatherId,
      if (fatherCloudId != null) 'father_cloud_id': fatherCloudId,
      if (childId != null) 'child_id': childId,
      if (childCloudId != null) 'child_cloud_id': childCloudId,
    });
  }

  FatherChildCompanion copyWith(
      {Value<int>? id,
      Value<int?>? cloudId,
      Value<SyncCurd?>? syncCurd,
      Value<String?>? syncUpdateColumns,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<FatherChildType>? type,
      Value<int?>? fatherId,
      Value<int?>? fatherCloudId,
      Value<int?>? childId,
      Value<int?>? childCloudId}) {
    return FatherChildCompanion(
      id: id ?? this.id,
      cloudId: cloudId ?? this.cloudId,
      syncCurd: syncCurd ?? this.syncCurd,
      syncUpdateColumns: syncUpdateColumns ?? this.syncUpdateColumns,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      type: type ?? this.type,
      fatherId: fatherId ?? this.fatherId,
      fatherCloudId: fatherCloudId ?? this.fatherCloudId,
      childId: childId ?? this.childId,
      childCloudId: childCloudId ?? this.childCloudId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (cloudId.present) {
      map['cloud_id'] = Variable<int?>(cloudId.value);
    }
    if (syncCurd.present) {
      final converter = $FatherChildTable.$converter0;
      map['sync_curd'] = Variable<int?>(converter.mapToSql(syncCurd.value));
    }
    if (syncUpdateColumns.present) {
      map['sync_update_columns'] = Variable<String?>(syncUpdateColumns.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (type.present) {
      final converter = $FatherChildTable.$converter1;
      map['type'] = Variable<int>(converter.mapToSql(type.value)!);
    }
    if (fatherId.present) {
      map['father_id'] = Variable<int?>(fatherId.value);
    }
    if (fatherCloudId.present) {
      map['father_cloud_id'] = Variable<int?>(fatherCloudId.value);
    }
    if (childId.present) {
      map['child_id'] = Variable<int?>(childId.value);
    }
    if (childCloudId.present) {
      map['child_cloud_id'] = Variable<int?>(childCloudId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FatherChildCompanion(')
          ..write('id: $id, ')
          ..write('cloudId: $cloudId, ')
          ..write('syncCurd: $syncCurd, ')
          ..write('syncUpdateColumns: $syncUpdateColumns, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('type: $type, ')
          ..write('fatherId: $fatherId, ')
          ..write('fatherCloudId: $fatherCloudId, ')
          ..write('childId: $childId, ')
          ..write('childCloudId: $childCloudId')
          ..write(')'))
        .toString();
  }
}

class $FatherChildTable extends FatherChild
    with TableInfo<$FatherChildTable, FatherChildData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FatherChildTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _cloudIdMeta = const VerificationMeta('cloudId');
  @override
  late final GeneratedColumn<int?> cloudId = GeneratedColumn<int?>(
      'cloud_id', aliasedName, true,
      type: const IntType(),
      requiredDuringInsert: false,
      $customConstraints: 'UNIQUE');
  final VerificationMeta _syncCurdMeta = const VerificationMeta('syncCurd');
  @override
  late final GeneratedColumnWithTypeConverter<SyncCurd?, int?> syncCurd =
      GeneratedColumn<int?>('sync_curd', aliasedName, true,
              type: const IntType(), requiredDuringInsert: false)
          .withConverter<SyncCurd?>($FatherChildTable.$converter0);
  final VerificationMeta _syncUpdateColumnsMeta =
      const VerificationMeta('syncUpdateColumns');
  @override
  late final GeneratedColumn<String?> syncUpdateColumns =
      GeneratedColumn<String?>('sync_update_columns', aliasedName, true,
          type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime?> createdAt = GeneratedColumn<DateTime?>(
      'created_at', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now());
  final VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime?> updatedAt = GeneratedColumn<DateTime?>(
      'updated_at', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now());
  final VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumnWithTypeConverter<FatherChildType, int?> type =
      GeneratedColumn<int?>('type', aliasedName, false,
              type: const IntType(), requiredDuringInsert: true)
          .withConverter<FatherChildType>($FatherChildTable.$converter1);
  final VerificationMeta _fatherIdMeta = const VerificationMeta('fatherId');
  @override
  late final GeneratedColumn<int?> fatherId = GeneratedColumn<int?>(
      'father_id', aliasedName, true,
      type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _fatherCloudIdMeta =
      const VerificationMeta('fatherCloudId');
  @override
  late final GeneratedColumn<int?> fatherCloudId = GeneratedColumn<int?>(
      'father_cloud_id', aliasedName, true,
      type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _childIdMeta = const VerificationMeta('childId');
  @override
  late final GeneratedColumn<int?> childId = GeneratedColumn<int?>(
      'child_id', aliasedName, true,
      type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _childCloudIdMeta =
      const VerificationMeta('childCloudId');
  @override
  late final GeneratedColumn<int?> childCloudId = GeneratedColumn<int?>(
      'child_cloud_id', aliasedName, true,
      type: const IntType(), requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        cloudId,
        syncCurd,
        syncUpdateColumns,
        createdAt,
        updatedAt,
        type,
        fatherId,
        fatherCloudId,
        childId,
        childCloudId
      ];
  @override
  String get aliasedName => _alias ?? 'father_child';
  @override
  String get actualTableName => 'father_child';
  @override
  VerificationContext validateIntegrity(Insertable<FatherChildData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('cloud_id')) {
      context.handle(_cloudIdMeta,
          cloudId.isAcceptableOrUnknown(data['cloud_id']!, _cloudIdMeta));
    }
    context.handle(_syncCurdMeta, const VerificationResult.success());
    if (data.containsKey('sync_update_columns')) {
      context.handle(
          _syncUpdateColumnsMeta,
          syncUpdateColumns.isAcceptableOrUnknown(
              data['sync_update_columns']!, _syncUpdateColumnsMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    context.handle(_typeMeta, const VerificationResult.success());
    if (data.containsKey('father_id')) {
      context.handle(_fatherIdMeta,
          fatherId.isAcceptableOrUnknown(data['father_id']!, _fatherIdMeta));
    }
    if (data.containsKey('father_cloud_id')) {
      context.handle(
          _fatherCloudIdMeta,
          fatherCloudId.isAcceptableOrUnknown(
              data['father_cloud_id']!, _fatherCloudIdMeta));
    }
    if (data.containsKey('child_id')) {
      context.handle(_childIdMeta,
          childId.isAcceptableOrUnknown(data['child_id']!, _childIdMeta));
    }
    if (data.containsKey('child_cloud_id')) {
      context.handle(
          _childCloudIdMeta,
          childCloudId.isAcceptableOrUnknown(
              data['child_cloud_id']!, _childCloudIdMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FatherChildData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return FatherChildData.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $FatherChildTable createAlias(String alias) {
    return $FatherChildTable(attachedDatabase, alias);
  }

  static TypeConverter<SyncCurd?, int> $converter0 =
      const EnumIndexConverter<SyncCurd>(SyncCurd.values);
  static TypeConverter<FatherChildType, int> $converter1 =
      const EnumIndexConverter<FatherChildType>(FatherChildType.values);
}

class User extends DataClass implements Insertable<User> {
  int id;
  int? cloudId;

  /// 同步 curd 类型。为空则表示该行 不需要进行同步。
  ///
  /// 值： null C-0 U-1 R-2 D-3
  ///
  /// 不为 null 的可能性：
  ///   1. 未上传更改。
  ///   2. 客户端上传数据后，客户端被断掉，从而未对服务器上传成功的消息进行接收。（若是服务器断掉，则客户端会收到失败的响应）
  ///
  /// 若客户端请求——服务器响应，这个流程成功则设为 null，失败则保持为 curd。
  /// 若为 2 的情况，应用会再次检索未上传的数据，再次进行上传，但无碍，因为服务端上传时，会对比 updatedAt。
  ///   - 若新旧相同，则服务端已同步过，响应客户端将其置空。
  ///   - 若新的晚于旧的，则需要服务端进行同步后，响应客户端将其置空。
  ///   - 若新的早于旧的，则 1. 可能客户端、服务端时间被篡改；2. 该条数据在其他客户端已经被同步过了 TODO: 可依据此处设计多客户端登陆方案。
  SyncCurd? syncCurd;

  /// 当 [syncCurd] 为 U-1 时，[syncUpdateColumns] 不能为空。
  ///
  /// 值为字段名，如："username,password"。
  String? syncUpdateColumns;

  /// 必须是本地时间，因为用户是在本地被创建、修改。
  DateTime createdAt;

  /// 必须是本地时间，因为用户是在本地被创建、修改。
  DateTime updatedAt;
  String? username;
  String? password;
  String? email;
  int? age;
  User(
      {required this.id,
      this.cloudId,
      this.syncCurd,
      this.syncUpdateColumns,
      required this.createdAt,
      required this.updatedAt,
      this.username,
      this.password,
      this.email,
      this.age});
  factory User.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return User(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      cloudId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}cloud_id']),
      syncCurd: $UsersTable.$converter0.mapToDart(const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}sync_curd'])),
      syncUpdateColumns: const StringType().mapFromDatabaseResponse(
          data['${effectivePrefix}sync_update_columns']),
      createdAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at'])!,
      updatedAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}updated_at'])!,
      username: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}username']),
      password: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}password']),
      email: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}email']),
      age: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}age']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || cloudId != null) {
      map['cloud_id'] = Variable<int?>(cloudId);
    }
    if (!nullToAbsent || syncCurd != null) {
      final converter = $UsersTable.$converter0;
      map['sync_curd'] = Variable<int?>(converter.mapToSql(syncCurd));
    }
    if (!nullToAbsent || syncUpdateColumns != null) {
      map['sync_update_columns'] = Variable<String?>(syncUpdateColumns);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || username != null) {
      map['username'] = Variable<String?>(username);
    }
    if (!nullToAbsent || password != null) {
      map['password'] = Variable<String?>(password);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String?>(email);
    }
    if (!nullToAbsent || age != null) {
      map['age'] = Variable<int?>(age);
    }
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: Value(id),
      cloudId: cloudId == null && nullToAbsent
          ? const Value.absent()
          : Value(cloudId),
      syncCurd: syncCurd == null && nullToAbsent
          ? const Value.absent()
          : Value(syncCurd),
      syncUpdateColumns: syncUpdateColumns == null && nullToAbsent
          ? const Value.absent()
          : Value(syncUpdateColumns),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      username: username == null && nullToAbsent
          ? const Value.absent()
          : Value(username),
      password: password == null && nullToAbsent
          ? const Value.absent()
          : Value(password),
      email:
          email == null && nullToAbsent ? const Value.absent() : Value(email),
      age: age == null && nullToAbsent ? const Value.absent() : Value(age),
    );
  }

  factory User.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return User(
      id: serializer.fromJson<int>(json['id']),
      cloudId: serializer.fromJson<int?>(json['cloudId']),
      syncCurd: serializer.fromJson<SyncCurd?>(json['syncCurd']),
      syncUpdateColumns:
          serializer.fromJson<String?>(json['syncUpdateColumns']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      username: serializer.fromJson<String?>(json['username']),
      password: serializer.fromJson<String?>(json['password']),
      email: serializer.fromJson<String?>(json['email']),
      age: serializer.fromJson<int?>(json['age']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'cloudId': serializer.toJson<int?>(cloudId),
      'syncCurd': serializer.toJson<SyncCurd?>(syncCurd),
      'syncUpdateColumns': serializer.toJson<String?>(syncUpdateColumns),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'username': serializer.toJson<String?>(username),
      'password': serializer.toJson<String?>(password),
      'email': serializer.toJson<String?>(email),
      'age': serializer.toJson<int?>(age),
    };
  }

  User copyWith(
          {int? id,
          int? cloudId,
          SyncCurd? syncCurd,
          String? syncUpdateColumns,
          DateTime? createdAt,
          DateTime? updatedAt,
          String? username,
          String? password,
          String? email,
          int? age}) =>
      User(
        id: id ?? this.id,
        cloudId: cloudId ?? this.cloudId,
        syncCurd: syncCurd ?? this.syncCurd,
        syncUpdateColumns: syncUpdateColumns ?? this.syncUpdateColumns,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        username: username ?? this.username,
        password: password ?? this.password,
        email: email ?? this.email,
        age: age ?? this.age,
      );
  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('id: $id, ')
          ..write('cloudId: $cloudId, ')
          ..write('syncCurd: $syncCurd, ')
          ..write('syncUpdateColumns: $syncUpdateColumns, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('username: $username, ')
          ..write('password: $password, ')
          ..write('email: $email, ')
          ..write('age: $age')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, cloudId, syncCurd, syncUpdateColumns,
      createdAt, updatedAt, username, password, email, age);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          other.id == this.id &&
          other.cloudId == this.cloudId &&
          other.syncCurd == this.syncCurd &&
          other.syncUpdateColumns == this.syncUpdateColumns &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.username == this.username &&
          other.password == this.password &&
          other.email == this.email &&
          other.age == this.age);
}

class UsersCompanion extends UpdateCompanion<User> {
  Value<int> id;
  Value<int?> cloudId;
  Value<SyncCurd?> syncCurd;
  Value<String?> syncUpdateColumns;
  Value<DateTime> createdAt;
  Value<DateTime> updatedAt;
  Value<String?> username;
  Value<String?> password;
  Value<String?> email;
  Value<int?> age;
  UsersCompanion({
    this.id = const Value.absent(),
    this.cloudId = const Value.absent(),
    this.syncCurd = const Value.absent(),
    this.syncUpdateColumns = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.username = const Value.absent(),
    this.password = const Value.absent(),
    this.email = const Value.absent(),
    this.age = const Value.absent(),
  });
  UsersCompanion.insert({
    this.id = const Value.absent(),
    this.cloudId = const Value.absent(),
    this.syncCurd = const Value.absent(),
    this.syncUpdateColumns = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.username = const Value.absent(),
    this.password = const Value.absent(),
    this.email = const Value.absent(),
    this.age = const Value.absent(),
  });
  static Insertable<User> custom({
    Expression<int>? id,
    Expression<int?>? cloudId,
    Expression<SyncCurd?>? syncCurd,
    Expression<String?>? syncUpdateColumns,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String?>? username,
    Expression<String?>? password,
    Expression<String?>? email,
    Expression<int?>? age,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (cloudId != null) 'cloud_id': cloudId,
      if (syncCurd != null) 'sync_curd': syncCurd,
      if (syncUpdateColumns != null) 'sync_update_columns': syncUpdateColumns,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (username != null) 'username': username,
      if (password != null) 'password': password,
      if (email != null) 'email': email,
      if (age != null) 'age': age,
    });
  }

  UsersCompanion copyWith(
      {Value<int>? id,
      Value<int?>? cloudId,
      Value<SyncCurd?>? syncCurd,
      Value<String?>? syncUpdateColumns,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<String?>? username,
      Value<String?>? password,
      Value<String?>? email,
      Value<int?>? age}) {
    return UsersCompanion(
      id: id ?? this.id,
      cloudId: cloudId ?? this.cloudId,
      syncCurd: syncCurd ?? this.syncCurd,
      syncUpdateColumns: syncUpdateColumns ?? this.syncUpdateColumns,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      username: username ?? this.username,
      password: password ?? this.password,
      email: email ?? this.email,
      age: age ?? this.age,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (cloudId.present) {
      map['cloud_id'] = Variable<int?>(cloudId.value);
    }
    if (syncCurd.present) {
      final converter = $UsersTable.$converter0;
      map['sync_curd'] = Variable<int?>(converter.mapToSql(syncCurd.value));
    }
    if (syncUpdateColumns.present) {
      map['sync_update_columns'] = Variable<String?>(syncUpdateColumns.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (username.present) {
      map['username'] = Variable<String?>(username.value);
    }
    if (password.present) {
      map['password'] = Variable<String?>(password.value);
    }
    if (email.present) {
      map['email'] = Variable<String?>(email.value);
    }
    if (age.present) {
      map['age'] = Variable<int?>(age.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('cloudId: $cloudId, ')
          ..write('syncCurd: $syncCurd, ')
          ..write('syncUpdateColumns: $syncUpdateColumns, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('username: $username, ')
          ..write('password: $password, ')
          ..write('email: $email, ')
          ..write('age: $age')
          ..write(')'))
        .toString();
  }
}

class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _cloudIdMeta = const VerificationMeta('cloudId');
  @override
  late final GeneratedColumn<int?> cloudId = GeneratedColumn<int?>(
      'cloud_id', aliasedName, true,
      type: const IntType(),
      requiredDuringInsert: false,
      $customConstraints: 'UNIQUE');
  final VerificationMeta _syncCurdMeta = const VerificationMeta('syncCurd');
  @override
  late final GeneratedColumnWithTypeConverter<SyncCurd?, int?> syncCurd =
      GeneratedColumn<int?>('sync_curd', aliasedName, true,
              type: const IntType(), requiredDuringInsert: false)
          .withConverter<SyncCurd?>($UsersTable.$converter0);
  final VerificationMeta _syncUpdateColumnsMeta =
      const VerificationMeta('syncUpdateColumns');
  @override
  late final GeneratedColumn<String?> syncUpdateColumns =
      GeneratedColumn<String?>('sync_update_columns', aliasedName, true,
          type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime?> createdAt = GeneratedColumn<DateTime?>(
      'created_at', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now());
  final VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime?> updatedAt = GeneratedColumn<DateTime?>(
      'updated_at', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now());
  final VerificationMeta _usernameMeta = const VerificationMeta('username');
  @override
  late final GeneratedColumn<String?> username = GeneratedColumn<String?>(
      'username', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _passwordMeta = const VerificationMeta('password');
  @override
  late final GeneratedColumn<String?> password = GeneratedColumn<String?>(
      'password', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String?> email = GeneratedColumn<String?>(
      'email', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _ageMeta = const VerificationMeta('age');
  @override
  late final GeneratedColumn<int?> age = GeneratedColumn<int?>(
      'age', aliasedName, true,
      type: const IntType(), requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        cloudId,
        syncCurd,
        syncUpdateColumns,
        createdAt,
        updatedAt,
        username,
        password,
        email,
        age
      ];
  @override
  String get aliasedName => _alias ?? 'users';
  @override
  String get actualTableName => 'users';
  @override
  VerificationContext validateIntegrity(Insertable<User> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('cloud_id')) {
      context.handle(_cloudIdMeta,
          cloudId.isAcceptableOrUnknown(data['cloud_id']!, _cloudIdMeta));
    }
    context.handle(_syncCurdMeta, const VerificationResult.success());
    if (data.containsKey('sync_update_columns')) {
      context.handle(
          _syncUpdateColumnsMeta,
          syncUpdateColumns.isAcceptableOrUnknown(
              data['sync_update_columns']!, _syncUpdateColumnsMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('username')) {
      context.handle(_usernameMeta,
          username.isAcceptableOrUnknown(data['username']!, _usernameMeta));
    }
    if (data.containsKey('password')) {
      context.handle(_passwordMeta,
          password.isAcceptableOrUnknown(data['password']!, _passwordMeta));
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    }
    if (data.containsKey('age')) {
      context.handle(
          _ageMeta, age.isAcceptableOrUnknown(data['age']!, _ageMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  User map(Map<String, dynamic> data, {String? tablePrefix}) {
    return User.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }

  static TypeConverter<SyncCurd?, int> $converter0 =
      const EnumIndexConverter<SyncCurd>(SyncCurd.values);
}

class FragmentGroup extends DataClass implements Insertable<FragmentGroup> {
  int id;
  int? cloudId;

  /// 同步 curd 类型。为空则表示该行 不需要进行同步。
  ///
  /// 值： null C-0 U-1 R-2 D-3
  ///
  /// 不为 null 的可能性：
  ///   1. 未上传更改。
  ///   2. 客户端上传数据后，客户端被断掉，从而未对服务器上传成功的消息进行接收。（若是服务器断掉，则客户端会收到失败的响应）
  ///
  /// 若客户端请求——服务器响应，这个流程成功则设为 null，失败则保持为 curd。
  /// 若为 2 的情况，应用会再次检索未上传的数据，再次进行上传，但无碍，因为服务端上传时，会对比 updatedAt。
  ///   - 若新旧相同，则服务端已同步过，响应客户端将其置空。
  ///   - 若新的晚于旧的，则需要服务端进行同步后，响应客户端将其置空。
  ///   - 若新的早于旧的，则 1. 可能客户端、服务端时间被篡改；2. 该条数据在其他客户端已经被同步过了 TODO: 可依据此处设计多客户端登陆方案。
  SyncCurd? syncCurd;

  /// 当 [syncCurd] 为 U-1 时，[syncUpdateColumns] 不能为空。
  ///
  /// 值为字段名，如："username,password"。
  String? syncUpdateColumns;

  /// 必须是本地时间，因为用户是在本地被创建、修改。
  DateTime createdAt;

  /// 必须是本地时间，因为用户是在本地被创建、修改。
  DateTime updatedAt;
  String? name;
  FragmentGroup(
      {required this.id,
      this.cloudId,
      this.syncCurd,
      this.syncUpdateColumns,
      required this.createdAt,
      required this.updatedAt,
      this.name});
  factory FragmentGroup.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return FragmentGroup(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      cloudId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}cloud_id']),
      syncCurd: $FragmentGroupsTable.$converter0.mapToDart(const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}sync_curd'])),
      syncUpdateColumns: const StringType().mapFromDatabaseResponse(
          data['${effectivePrefix}sync_update_columns']),
      createdAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at'])!,
      updatedAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}updated_at'])!,
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || cloudId != null) {
      map['cloud_id'] = Variable<int?>(cloudId);
    }
    if (!nullToAbsent || syncCurd != null) {
      final converter = $FragmentGroupsTable.$converter0;
      map['sync_curd'] = Variable<int?>(converter.mapToSql(syncCurd));
    }
    if (!nullToAbsent || syncUpdateColumns != null) {
      map['sync_update_columns'] = Variable<String?>(syncUpdateColumns);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String?>(name);
    }
    return map;
  }

  FragmentGroupsCompanion toCompanion(bool nullToAbsent) {
    return FragmentGroupsCompanion(
      id: Value(id),
      cloudId: cloudId == null && nullToAbsent
          ? const Value.absent()
          : Value(cloudId),
      syncCurd: syncCurd == null && nullToAbsent
          ? const Value.absent()
          : Value(syncCurd),
      syncUpdateColumns: syncUpdateColumns == null && nullToAbsent
          ? const Value.absent()
          : Value(syncUpdateColumns),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
    );
  }

  factory FragmentGroup.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FragmentGroup(
      id: serializer.fromJson<int>(json['id']),
      cloudId: serializer.fromJson<int?>(json['cloudId']),
      syncCurd: serializer.fromJson<SyncCurd?>(json['syncCurd']),
      syncUpdateColumns:
          serializer.fromJson<String?>(json['syncUpdateColumns']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      name: serializer.fromJson<String?>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'cloudId': serializer.toJson<int?>(cloudId),
      'syncCurd': serializer.toJson<SyncCurd?>(syncCurd),
      'syncUpdateColumns': serializer.toJson<String?>(syncUpdateColumns),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'name': serializer.toJson<String?>(name),
    };
  }

  FragmentGroup copyWith(
          {int? id,
          int? cloudId,
          SyncCurd? syncCurd,
          String? syncUpdateColumns,
          DateTime? createdAt,
          DateTime? updatedAt,
          String? name}) =>
      FragmentGroup(
        id: id ?? this.id,
        cloudId: cloudId ?? this.cloudId,
        syncCurd: syncCurd ?? this.syncCurd,
        syncUpdateColumns: syncUpdateColumns ?? this.syncUpdateColumns,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('FragmentGroup(')
          ..write('id: $id, ')
          ..write('cloudId: $cloudId, ')
          ..write('syncCurd: $syncCurd, ')
          ..write('syncUpdateColumns: $syncUpdateColumns, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, cloudId, syncCurd, syncUpdateColumns, createdAt, updatedAt, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FragmentGroup &&
          other.id == this.id &&
          other.cloudId == this.cloudId &&
          other.syncCurd == this.syncCurd &&
          other.syncUpdateColumns == this.syncUpdateColumns &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.name == this.name);
}

class FragmentGroupsCompanion extends UpdateCompanion<FragmentGroup> {
  Value<int> id;
  Value<int?> cloudId;
  Value<SyncCurd?> syncCurd;
  Value<String?> syncUpdateColumns;
  Value<DateTime> createdAt;
  Value<DateTime> updatedAt;
  Value<String?> name;
  FragmentGroupsCompanion({
    this.id = const Value.absent(),
    this.cloudId = const Value.absent(),
    this.syncCurd = const Value.absent(),
    this.syncUpdateColumns = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.name = const Value.absent(),
  });
  FragmentGroupsCompanion.insert({
    this.id = const Value.absent(),
    this.cloudId = const Value.absent(),
    this.syncCurd = const Value.absent(),
    this.syncUpdateColumns = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.name = const Value.absent(),
  });
  static Insertable<FragmentGroup> custom({
    Expression<int>? id,
    Expression<int?>? cloudId,
    Expression<SyncCurd?>? syncCurd,
    Expression<String?>? syncUpdateColumns,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String?>? name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (cloudId != null) 'cloud_id': cloudId,
      if (syncCurd != null) 'sync_curd': syncCurd,
      if (syncUpdateColumns != null) 'sync_update_columns': syncUpdateColumns,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (name != null) 'name': name,
    });
  }

  FragmentGroupsCompanion copyWith(
      {Value<int>? id,
      Value<int?>? cloudId,
      Value<SyncCurd?>? syncCurd,
      Value<String?>? syncUpdateColumns,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<String?>? name}) {
    return FragmentGroupsCompanion(
      id: id ?? this.id,
      cloudId: cloudId ?? this.cloudId,
      syncCurd: syncCurd ?? this.syncCurd,
      syncUpdateColumns: syncUpdateColumns ?? this.syncUpdateColumns,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      name: name ?? this.name,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (cloudId.present) {
      map['cloud_id'] = Variable<int?>(cloudId.value);
    }
    if (syncCurd.present) {
      final converter = $FragmentGroupsTable.$converter0;
      map['sync_curd'] = Variable<int?>(converter.mapToSql(syncCurd.value));
    }
    if (syncUpdateColumns.present) {
      map['sync_update_columns'] = Variable<String?>(syncUpdateColumns.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (name.present) {
      map['name'] = Variable<String?>(name.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FragmentGroupsCompanion(')
          ..write('id: $id, ')
          ..write('cloudId: $cloudId, ')
          ..write('syncCurd: $syncCurd, ')
          ..write('syncUpdateColumns: $syncUpdateColumns, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

class $FragmentGroupsTable extends FragmentGroups
    with TableInfo<$FragmentGroupsTable, FragmentGroup> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FragmentGroupsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _cloudIdMeta = const VerificationMeta('cloudId');
  @override
  late final GeneratedColumn<int?> cloudId = GeneratedColumn<int?>(
      'cloud_id', aliasedName, true,
      type: const IntType(),
      requiredDuringInsert: false,
      $customConstraints: 'UNIQUE');
  final VerificationMeta _syncCurdMeta = const VerificationMeta('syncCurd');
  @override
  late final GeneratedColumnWithTypeConverter<SyncCurd?, int?> syncCurd =
      GeneratedColumn<int?>('sync_curd', aliasedName, true,
              type: const IntType(), requiredDuringInsert: false)
          .withConverter<SyncCurd?>($FragmentGroupsTable.$converter0);
  final VerificationMeta _syncUpdateColumnsMeta =
      const VerificationMeta('syncUpdateColumns');
  @override
  late final GeneratedColumn<String?> syncUpdateColumns =
      GeneratedColumn<String?>('sync_update_columns', aliasedName, true,
          type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime?> createdAt = GeneratedColumn<DateTime?>(
      'created_at', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now());
  final VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime?> updatedAt = GeneratedColumn<DateTime?>(
      'updated_at', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now());
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String?> name = GeneratedColumn<String?>(
      'name', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, cloudId, syncCurd, syncUpdateColumns, createdAt, updatedAt, name];
  @override
  String get aliasedName => _alias ?? 'fragment_groups';
  @override
  String get actualTableName => 'fragment_groups';
  @override
  VerificationContext validateIntegrity(Insertable<FragmentGroup> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('cloud_id')) {
      context.handle(_cloudIdMeta,
          cloudId.isAcceptableOrUnknown(data['cloud_id']!, _cloudIdMeta));
    }
    context.handle(_syncCurdMeta, const VerificationResult.success());
    if (data.containsKey('sync_update_columns')) {
      context.handle(
          _syncUpdateColumnsMeta,
          syncUpdateColumns.isAcceptableOrUnknown(
              data['sync_update_columns']!, _syncUpdateColumnsMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FragmentGroup map(Map<String, dynamic> data, {String? tablePrefix}) {
    return FragmentGroup.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $FragmentGroupsTable createAlias(String alias) {
    return $FragmentGroupsTable(attachedDatabase, alias);
  }

  static TypeConverter<SyncCurd?, int> $converter0 =
      const EnumIndexConverter<SyncCurd>(SyncCurd.values);
}

class Fragment extends DataClass implements Insertable<Fragment> {
  int id;
  int? cloudId;

  /// 同步 curd 类型。为空则表示该行 不需要进行同步。
  ///
  /// 值： null C-0 U-1 R-2 D-3
  ///
  /// 不为 null 的可能性：
  ///   1. 未上传更改。
  ///   2. 客户端上传数据后，客户端被断掉，从而未对服务器上传成功的消息进行接收。（若是服务器断掉，则客户端会收到失败的响应）
  ///
  /// 若客户端请求——服务器响应，这个流程成功则设为 null，失败则保持为 curd。
  /// 若为 2 的情况，应用会再次检索未上传的数据，再次进行上传，但无碍，因为服务端上传时，会对比 updatedAt。
  ///   - 若新旧相同，则服务端已同步过，响应客户端将其置空。
  ///   - 若新的晚于旧的，则需要服务端进行同步后，响应客户端将其置空。
  ///   - 若新的早于旧的，则 1. 可能客户端、服务端时间被篡改；2. 该条数据在其他客户端已经被同步过了 TODO: 可依据此处设计多客户端登陆方案。
  SyncCurd? syncCurd;

  /// 当 [syncCurd] 为 U-1 时，[syncUpdateColumns] 不能为空。
  ///
  /// 值为字段名，如："username,password"。
  String? syncUpdateColumns;

  /// 必须是本地时间，因为用户是在本地被创建、修改。
  DateTime createdAt;

  /// 必须是本地时间，因为用户是在本地被创建、修改。
  DateTime updatedAt;
  String? content;
  Fragment(
      {required this.id,
      this.cloudId,
      this.syncCurd,
      this.syncUpdateColumns,
      required this.createdAt,
      required this.updatedAt,
      this.content});
  factory Fragment.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Fragment(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      cloudId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}cloud_id']),
      syncCurd: $FragmentsTable.$converter0.mapToDart(const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}sync_curd'])),
      syncUpdateColumns: const StringType().mapFromDatabaseResponse(
          data['${effectivePrefix}sync_update_columns']),
      createdAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at'])!,
      updatedAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}updated_at'])!,
      content: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}content']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || cloudId != null) {
      map['cloud_id'] = Variable<int?>(cloudId);
    }
    if (!nullToAbsent || syncCurd != null) {
      final converter = $FragmentsTable.$converter0;
      map['sync_curd'] = Variable<int?>(converter.mapToSql(syncCurd));
    }
    if (!nullToAbsent || syncUpdateColumns != null) {
      map['sync_update_columns'] = Variable<String?>(syncUpdateColumns);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || content != null) {
      map['content'] = Variable<String?>(content);
    }
    return map;
  }

  FragmentsCompanion toCompanion(bool nullToAbsent) {
    return FragmentsCompanion(
      id: Value(id),
      cloudId: cloudId == null && nullToAbsent
          ? const Value.absent()
          : Value(cloudId),
      syncCurd: syncCurd == null && nullToAbsent
          ? const Value.absent()
          : Value(syncCurd),
      syncUpdateColumns: syncUpdateColumns == null && nullToAbsent
          ? const Value.absent()
          : Value(syncUpdateColumns),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      content: content == null && nullToAbsent
          ? const Value.absent()
          : Value(content),
    );
  }

  factory Fragment.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Fragment(
      id: serializer.fromJson<int>(json['id']),
      cloudId: serializer.fromJson<int?>(json['cloudId']),
      syncCurd: serializer.fromJson<SyncCurd?>(json['syncCurd']),
      syncUpdateColumns:
          serializer.fromJson<String?>(json['syncUpdateColumns']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      content: serializer.fromJson<String?>(json['content']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'cloudId': serializer.toJson<int?>(cloudId),
      'syncCurd': serializer.toJson<SyncCurd?>(syncCurd),
      'syncUpdateColumns': serializer.toJson<String?>(syncUpdateColumns),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'content': serializer.toJson<String?>(content),
    };
  }

  Fragment copyWith(
          {int? id,
          int? cloudId,
          SyncCurd? syncCurd,
          String? syncUpdateColumns,
          DateTime? createdAt,
          DateTime? updatedAt,
          String? content}) =>
      Fragment(
        id: id ?? this.id,
        cloudId: cloudId ?? this.cloudId,
        syncCurd: syncCurd ?? this.syncCurd,
        syncUpdateColumns: syncUpdateColumns ?? this.syncUpdateColumns,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        content: content ?? this.content,
      );
  @override
  String toString() {
    return (StringBuffer('Fragment(')
          ..write('id: $id, ')
          ..write('cloudId: $cloudId, ')
          ..write('syncCurd: $syncCurd, ')
          ..write('syncUpdateColumns: $syncUpdateColumns, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('content: $content')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, cloudId, syncCurd, syncUpdateColumns, createdAt, updatedAt, content);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Fragment &&
          other.id == this.id &&
          other.cloudId == this.cloudId &&
          other.syncCurd == this.syncCurd &&
          other.syncUpdateColumns == this.syncUpdateColumns &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.content == this.content);
}

class FragmentsCompanion extends UpdateCompanion<Fragment> {
  Value<int> id;
  Value<int?> cloudId;
  Value<SyncCurd?> syncCurd;
  Value<String?> syncUpdateColumns;
  Value<DateTime> createdAt;
  Value<DateTime> updatedAt;
  Value<String?> content;
  FragmentsCompanion({
    this.id = const Value.absent(),
    this.cloudId = const Value.absent(),
    this.syncCurd = const Value.absent(),
    this.syncUpdateColumns = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.content = const Value.absent(),
  });
  FragmentsCompanion.insert({
    this.id = const Value.absent(),
    this.cloudId = const Value.absent(),
    this.syncCurd = const Value.absent(),
    this.syncUpdateColumns = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.content = const Value.absent(),
  });
  static Insertable<Fragment> custom({
    Expression<int>? id,
    Expression<int?>? cloudId,
    Expression<SyncCurd?>? syncCurd,
    Expression<String?>? syncUpdateColumns,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String?>? content,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (cloudId != null) 'cloud_id': cloudId,
      if (syncCurd != null) 'sync_curd': syncCurd,
      if (syncUpdateColumns != null) 'sync_update_columns': syncUpdateColumns,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (content != null) 'content': content,
    });
  }

  FragmentsCompanion copyWith(
      {Value<int>? id,
      Value<int?>? cloudId,
      Value<SyncCurd?>? syncCurd,
      Value<String?>? syncUpdateColumns,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<String?>? content}) {
    return FragmentsCompanion(
      id: id ?? this.id,
      cloudId: cloudId ?? this.cloudId,
      syncCurd: syncCurd ?? this.syncCurd,
      syncUpdateColumns: syncUpdateColumns ?? this.syncUpdateColumns,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      content: content ?? this.content,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (cloudId.present) {
      map['cloud_id'] = Variable<int?>(cloudId.value);
    }
    if (syncCurd.present) {
      final converter = $FragmentsTable.$converter0;
      map['sync_curd'] = Variable<int?>(converter.mapToSql(syncCurd.value));
    }
    if (syncUpdateColumns.present) {
      map['sync_update_columns'] = Variable<String?>(syncUpdateColumns.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (content.present) {
      map['content'] = Variable<String?>(content.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FragmentsCompanion(')
          ..write('id: $id, ')
          ..write('cloudId: $cloudId, ')
          ..write('syncCurd: $syncCurd, ')
          ..write('syncUpdateColumns: $syncUpdateColumns, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('content: $content')
          ..write(')'))
        .toString();
  }
}

class $FragmentsTable extends Fragments
    with TableInfo<$FragmentsTable, Fragment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FragmentsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _cloudIdMeta = const VerificationMeta('cloudId');
  @override
  late final GeneratedColumn<int?> cloudId = GeneratedColumn<int?>(
      'cloud_id', aliasedName, true,
      type: const IntType(),
      requiredDuringInsert: false,
      $customConstraints: 'UNIQUE');
  final VerificationMeta _syncCurdMeta = const VerificationMeta('syncCurd');
  @override
  late final GeneratedColumnWithTypeConverter<SyncCurd?, int?> syncCurd =
      GeneratedColumn<int?>('sync_curd', aliasedName, true,
              type: const IntType(), requiredDuringInsert: false)
          .withConverter<SyncCurd?>($FragmentsTable.$converter0);
  final VerificationMeta _syncUpdateColumnsMeta =
      const VerificationMeta('syncUpdateColumns');
  @override
  late final GeneratedColumn<String?> syncUpdateColumns =
      GeneratedColumn<String?>('sync_update_columns', aliasedName, true,
          type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime?> createdAt = GeneratedColumn<DateTime?>(
      'created_at', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now());
  final VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime?> updatedAt = GeneratedColumn<DateTime?>(
      'updated_at', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now());
  final VerificationMeta _contentMeta = const VerificationMeta('content');
  @override
  late final GeneratedColumn<String?> content = GeneratedColumn<String?>(
      'content', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, cloudId, syncCurd, syncUpdateColumns, createdAt, updatedAt, content];
  @override
  String get aliasedName => _alias ?? 'fragments';
  @override
  String get actualTableName => 'fragments';
  @override
  VerificationContext validateIntegrity(Insertable<Fragment> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('cloud_id')) {
      context.handle(_cloudIdMeta,
          cloudId.isAcceptableOrUnknown(data['cloud_id']!, _cloudIdMeta));
    }
    context.handle(_syncCurdMeta, const VerificationResult.success());
    if (data.containsKey('sync_update_columns')) {
      context.handle(
          _syncUpdateColumnsMeta,
          syncUpdateColumns.isAcceptableOrUnknown(
              data['sync_update_columns']!, _syncUpdateColumnsMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Fragment map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Fragment.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $FragmentsTable createAlias(String alias) {
    return $FragmentsTable(attachedDatabase, alias);
  }

  static TypeConverter<SyncCurd?, int> $converter0 =
      const EnumIndexConverter<SyncCurd>(SyncCurd.values);
}

class MemoryGroup extends DataClass implements Insertable<MemoryGroup> {
  int id;
  int? cloudId;

  /// 同步 curd 类型。为空则表示该行 不需要进行同步。
  ///
  /// 值： null C-0 U-1 R-2 D-3
  ///
  /// 不为 null 的可能性：
  ///   1. 未上传更改。
  ///   2. 客户端上传数据后，客户端被断掉，从而未对服务器上传成功的消息进行接收。（若是服务器断掉，则客户端会收到失败的响应）
  ///
  /// 若客户端请求——服务器响应，这个流程成功则设为 null，失败则保持为 curd。
  /// 若为 2 的情况，应用会再次检索未上传的数据，再次进行上传，但无碍，因为服务端上传时，会对比 updatedAt。
  ///   - 若新旧相同，则服务端已同步过，响应客户端将其置空。
  ///   - 若新的晚于旧的，则需要服务端进行同步后，响应客户端将其置空。
  ///   - 若新的早于旧的，则 1. 可能客户端、服务端时间被篡改；2. 该条数据在其他客户端已经被同步过了 TODO: 可依据此处设计多客户端登陆方案。
  SyncCurd? syncCurd;

  /// 当 [syncCurd] 为 U-1 时，[syncUpdateColumns] 不能为空。
  ///
  /// 值为字段名，如："username,password"。
  String? syncUpdateColumns;

  /// 必须是本地时间，因为用户是在本地被创建、修改。
  DateTime createdAt;

  /// 必须是本地时间，因为用户是在本地被创建、修改。
  DateTime updatedAt;
  String? name;
  MemoryGroup(
      {required this.id,
      this.cloudId,
      this.syncCurd,
      this.syncUpdateColumns,
      required this.createdAt,
      required this.updatedAt,
      this.name});
  factory MemoryGroup.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return MemoryGroup(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      cloudId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}cloud_id']),
      syncCurd: $MemoryGroupsTable.$converter0.mapToDart(const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}sync_curd'])),
      syncUpdateColumns: const StringType().mapFromDatabaseResponse(
          data['${effectivePrefix}sync_update_columns']),
      createdAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at'])!,
      updatedAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}updated_at'])!,
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || cloudId != null) {
      map['cloud_id'] = Variable<int?>(cloudId);
    }
    if (!nullToAbsent || syncCurd != null) {
      final converter = $MemoryGroupsTable.$converter0;
      map['sync_curd'] = Variable<int?>(converter.mapToSql(syncCurd));
    }
    if (!nullToAbsent || syncUpdateColumns != null) {
      map['sync_update_columns'] = Variable<String?>(syncUpdateColumns);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String?>(name);
    }
    return map;
  }

  MemoryGroupsCompanion toCompanion(bool nullToAbsent) {
    return MemoryGroupsCompanion(
      id: Value(id),
      cloudId: cloudId == null && nullToAbsent
          ? const Value.absent()
          : Value(cloudId),
      syncCurd: syncCurd == null && nullToAbsent
          ? const Value.absent()
          : Value(syncCurd),
      syncUpdateColumns: syncUpdateColumns == null && nullToAbsent
          ? const Value.absent()
          : Value(syncUpdateColumns),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
    );
  }

  factory MemoryGroup.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MemoryGroup(
      id: serializer.fromJson<int>(json['id']),
      cloudId: serializer.fromJson<int?>(json['cloudId']),
      syncCurd: serializer.fromJson<SyncCurd?>(json['syncCurd']),
      syncUpdateColumns:
          serializer.fromJson<String?>(json['syncUpdateColumns']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      name: serializer.fromJson<String?>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'cloudId': serializer.toJson<int?>(cloudId),
      'syncCurd': serializer.toJson<SyncCurd?>(syncCurd),
      'syncUpdateColumns': serializer.toJson<String?>(syncUpdateColumns),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'name': serializer.toJson<String?>(name),
    };
  }

  MemoryGroup copyWith(
          {int? id,
          int? cloudId,
          SyncCurd? syncCurd,
          String? syncUpdateColumns,
          DateTime? createdAt,
          DateTime? updatedAt,
          String? name}) =>
      MemoryGroup(
        id: id ?? this.id,
        cloudId: cloudId ?? this.cloudId,
        syncCurd: syncCurd ?? this.syncCurd,
        syncUpdateColumns: syncUpdateColumns ?? this.syncUpdateColumns,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        name: name ?? this.name,
      );
  @override
  String toString() {
    return (StringBuffer('MemoryGroup(')
          ..write('id: $id, ')
          ..write('cloudId: $cloudId, ')
          ..write('syncCurd: $syncCurd, ')
          ..write('syncUpdateColumns: $syncUpdateColumns, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, cloudId, syncCurd, syncUpdateColumns, createdAt, updatedAt, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MemoryGroup &&
          other.id == this.id &&
          other.cloudId == this.cloudId &&
          other.syncCurd == this.syncCurd &&
          other.syncUpdateColumns == this.syncUpdateColumns &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.name == this.name);
}

class MemoryGroupsCompanion extends UpdateCompanion<MemoryGroup> {
  Value<int> id;
  Value<int?> cloudId;
  Value<SyncCurd?> syncCurd;
  Value<String?> syncUpdateColumns;
  Value<DateTime> createdAt;
  Value<DateTime> updatedAt;
  Value<String?> name;
  MemoryGroupsCompanion({
    this.id = const Value.absent(),
    this.cloudId = const Value.absent(),
    this.syncCurd = const Value.absent(),
    this.syncUpdateColumns = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.name = const Value.absent(),
  });
  MemoryGroupsCompanion.insert({
    this.id = const Value.absent(),
    this.cloudId = const Value.absent(),
    this.syncCurd = const Value.absent(),
    this.syncUpdateColumns = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.name = const Value.absent(),
  });
  static Insertable<MemoryGroup> custom({
    Expression<int>? id,
    Expression<int?>? cloudId,
    Expression<SyncCurd?>? syncCurd,
    Expression<String?>? syncUpdateColumns,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String?>? name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (cloudId != null) 'cloud_id': cloudId,
      if (syncCurd != null) 'sync_curd': syncCurd,
      if (syncUpdateColumns != null) 'sync_update_columns': syncUpdateColumns,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (name != null) 'name': name,
    });
  }

  MemoryGroupsCompanion copyWith(
      {Value<int>? id,
      Value<int?>? cloudId,
      Value<SyncCurd?>? syncCurd,
      Value<String?>? syncUpdateColumns,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<String?>? name}) {
    return MemoryGroupsCompanion(
      id: id ?? this.id,
      cloudId: cloudId ?? this.cloudId,
      syncCurd: syncCurd ?? this.syncCurd,
      syncUpdateColumns: syncUpdateColumns ?? this.syncUpdateColumns,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      name: name ?? this.name,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (cloudId.present) {
      map['cloud_id'] = Variable<int?>(cloudId.value);
    }
    if (syncCurd.present) {
      final converter = $MemoryGroupsTable.$converter0;
      map['sync_curd'] = Variable<int?>(converter.mapToSql(syncCurd.value));
    }
    if (syncUpdateColumns.present) {
      map['sync_update_columns'] = Variable<String?>(syncUpdateColumns.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (name.present) {
      map['name'] = Variable<String?>(name.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MemoryGroupsCompanion(')
          ..write('id: $id, ')
          ..write('cloudId: $cloudId, ')
          ..write('syncCurd: $syncCurd, ')
          ..write('syncUpdateColumns: $syncUpdateColumns, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

class $MemoryGroupsTable extends MemoryGroups
    with TableInfo<$MemoryGroupsTable, MemoryGroup> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MemoryGroupsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _cloudIdMeta = const VerificationMeta('cloudId');
  @override
  late final GeneratedColumn<int?> cloudId = GeneratedColumn<int?>(
      'cloud_id', aliasedName, true,
      type: const IntType(),
      requiredDuringInsert: false,
      $customConstraints: 'UNIQUE');
  final VerificationMeta _syncCurdMeta = const VerificationMeta('syncCurd');
  @override
  late final GeneratedColumnWithTypeConverter<SyncCurd?, int?> syncCurd =
      GeneratedColumn<int?>('sync_curd', aliasedName, true,
              type: const IntType(), requiredDuringInsert: false)
          .withConverter<SyncCurd?>($MemoryGroupsTable.$converter0);
  final VerificationMeta _syncUpdateColumnsMeta =
      const VerificationMeta('syncUpdateColumns');
  @override
  late final GeneratedColumn<String?> syncUpdateColumns =
      GeneratedColumn<String?>('sync_update_columns', aliasedName, true,
          type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime?> createdAt = GeneratedColumn<DateTime?>(
      'created_at', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now());
  final VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime?> updatedAt = GeneratedColumn<DateTime?>(
      'updated_at', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now());
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String?> name = GeneratedColumn<String?>(
      'name', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, cloudId, syncCurd, syncUpdateColumns, createdAt, updatedAt, name];
  @override
  String get aliasedName => _alias ?? 'memory_groups';
  @override
  String get actualTableName => 'memory_groups';
  @override
  VerificationContext validateIntegrity(Insertable<MemoryGroup> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('cloud_id')) {
      context.handle(_cloudIdMeta,
          cloudId.isAcceptableOrUnknown(data['cloud_id']!, _cloudIdMeta));
    }
    context.handle(_syncCurdMeta, const VerificationResult.success());
    if (data.containsKey('sync_update_columns')) {
      context.handle(
          _syncUpdateColumnsMeta,
          syncUpdateColumns.isAcceptableOrUnknown(
              data['sync_update_columns']!, _syncUpdateColumnsMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MemoryGroup map(Map<String, dynamic> data, {String? tablePrefix}) {
    return MemoryGroup.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $MemoryGroupsTable createAlias(String alias) {
    return $MemoryGroupsTable(attachedDatabase, alias);
  }

  static TypeConverter<SyncCurd?, int> $converter0 =
      const EnumIndexConverter<SyncCurd>(SyncCurd.values);
}

abstract class _$DriftDb extends GeneratedDatabase {
  _$DriftDb(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $AppInfosTable appInfos = $AppInfosTable(this);
  late final $FatherChildTable fatherChild = $FatherChildTable(this);
  late final $UsersTable users = $UsersTable(this);
  late final $FragmentGroupsTable fragmentGroups = $FragmentGroupsTable(this);
  late final $FragmentsTable fragments = $FragmentsTable(this);
  late final $MemoryGroupsTable memoryGroups = $MemoryGroupsTable(this);
  late final SingleDAO singleDAO = SingleDAO(this as DriftDb);
  late final MultiDAO multiDAO = MultiDAO(this as DriftDb);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [appInfos, fatherChild, users, fragmentGroups, fragments, memoryGroups];
}

// **************************************************************************
// DaoGenerator
// **************************************************************************

mixin _$MultiDAOMixin on DatabaseAccessor<DriftDb> {
  $AppInfosTable get appInfos => attachedDatabase.appInfos;
  $FatherChildTable get fatherChild => attachedDatabase.fatherChild;
  $UsersTable get users => attachedDatabase.users;
  $FragmentGroupsTable get fragmentGroups => attachedDatabase.fragmentGroups;
  $FragmentsTable get fragments => attachedDatabase.fragments;
  $MemoryGroupsTable get memoryGroups => attachedDatabase.memoryGroups;
}
mixin _$SingleDAOMixin on DatabaseAccessor<DriftDb> {
  $AppInfosTable get appInfos => attachedDatabase.appInfos;
  $FatherChildTable get fatherChild => attachedDatabase.fatherChild;
  $UsersTable get users => attachedDatabase.users;
  $FragmentGroupsTable get fragmentGroups => attachedDatabase.fragmentGroups;
  $FragmentsTable get fragments => attachedDatabase.fragments;
  $MemoryGroupsTable get memoryGroups => attachedDatabase.memoryGroups;
}
