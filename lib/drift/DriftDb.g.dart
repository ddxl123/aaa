// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DriftDb.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class User extends DataClass implements Insertable<User> {
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
  int? syncCurd;

  /// 当 [syncCurd] 为 U-1 时，[syncUpdateColumns] 不能为空。
  ///
  /// 值为字段名，如："username,password"。
  String? syncUpdateColumns;
  int id;

  /// 必须是本地时间，因为用户是在本地被创建、修改。
  DateTime createdAt;

  /// 必须是本地时间，因为用户是在本地被创建、修改。
  DateTime updatedAt;
  String? username;
  String? password;
  String? email;
  int? age;
  User(
      {this.cloudId,
      this.syncCurd,
      this.syncUpdateColumns,
      required this.id,
      required this.createdAt,
      required this.updatedAt,
      this.username,
      this.password,
      this.email,
      this.age});
  factory User.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return User(
      cloudId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}cloud_id']),
      syncCurd: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}sync_curd']),
      syncUpdateColumns: const StringType().mapFromDatabaseResponse(
          data['${effectivePrefix}sync_update_columns']),
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
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
    if (!nullToAbsent || cloudId != null) {
      map['cloud_id'] = Variable<int?>(cloudId);
    }
    if (!nullToAbsent || syncCurd != null) {
      map['sync_curd'] = Variable<int?>(syncCurd);
    }
    if (!nullToAbsent || syncUpdateColumns != null) {
      map['sync_update_columns'] = Variable<String?>(syncUpdateColumns);
    }
    map['id'] = Variable<int>(id);
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
      cloudId: cloudId == null && nullToAbsent
          ? const Value.absent()
          : Value(cloudId),
      syncCurd: syncCurd == null && nullToAbsent
          ? const Value.absent()
          : Value(syncCurd),
      syncUpdateColumns: syncUpdateColumns == null && nullToAbsent
          ? const Value.absent()
          : Value(syncUpdateColumns),
      id: Value(id),
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
      cloudId: serializer.fromJson<int?>(json['cloudId']),
      syncCurd: serializer.fromJson<int?>(json['syncCurd']),
      syncUpdateColumns:
          serializer.fromJson<String?>(json['syncUpdateColumns']),
      id: serializer.fromJson<int>(json['id']),
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
      'cloudId': serializer.toJson<int?>(cloudId),
      'syncCurd': serializer.toJson<int?>(syncCurd),
      'syncUpdateColumns': serializer.toJson<String?>(syncUpdateColumns),
      'id': serializer.toJson<int>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'username': serializer.toJson<String?>(username),
      'password': serializer.toJson<String?>(password),
      'email': serializer.toJson<String?>(email),
      'age': serializer.toJson<int?>(age),
    };
  }

  User copyWith(
          {int? cloudId,
          int? syncCurd,
          String? syncUpdateColumns,
          int? id,
          DateTime? createdAt,
          DateTime? updatedAt,
          String? username,
          String? password,
          String? email,
          int? age}) =>
      User(
        cloudId: cloudId ?? this.cloudId,
        syncCurd: syncCurd ?? this.syncCurd,
        syncUpdateColumns: syncUpdateColumns ?? this.syncUpdateColumns,
        id: id ?? this.id,
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
          ..write('cloudId: $cloudId, ')
          ..write('syncCurd: $syncCurd, ')
          ..write('syncUpdateColumns: $syncUpdateColumns, ')
          ..write('id: $id, ')
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
  int get hashCode => Object.hash(cloudId, syncCurd, syncUpdateColumns, id,
      createdAt, updatedAt, username, password, email, age);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          other.cloudId == this.cloudId &&
          other.syncCurd == this.syncCurd &&
          other.syncUpdateColumns == this.syncUpdateColumns &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.username == this.username &&
          other.password == this.password &&
          other.email == this.email &&
          other.age == this.age);
}

class UsersCompanion extends UpdateCompanion<User> {
  Value<int?> cloudId;
  Value<int?> syncCurd;
  Value<String?> syncUpdateColumns;
  Value<int> id;
  Value<DateTime> createdAt;
  Value<DateTime> updatedAt;
  Value<String?> username;
  Value<String?> password;
  Value<String?> email;
  Value<int?> age;
  UsersCompanion({
    this.cloudId = const Value.absent(),
    this.syncCurd = const Value.absent(),
    this.syncUpdateColumns = const Value.absent(),
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.username = const Value.absent(),
    this.password = const Value.absent(),
    this.email = const Value.absent(),
    this.age = const Value.absent(),
  });
  UsersCompanion.insert({
    this.cloudId = const Value.absent(),
    this.syncCurd = const Value.absent(),
    this.syncUpdateColumns = const Value.absent(),
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.username = const Value.absent(),
    this.password = const Value.absent(),
    this.email = const Value.absent(),
    this.age = const Value.absent(),
  });
  static Insertable<User> custom({
    Expression<int?>? cloudId,
    Expression<int?>? syncCurd,
    Expression<String?>? syncUpdateColumns,
    Expression<int>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String?>? username,
    Expression<String?>? password,
    Expression<String?>? email,
    Expression<int?>? age,
  }) {
    return RawValuesInsertable({
      if (cloudId != null) 'cloud_id': cloudId,
      if (syncCurd != null) 'sync_curd': syncCurd,
      if (syncUpdateColumns != null) 'sync_update_columns': syncUpdateColumns,
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (username != null) 'username': username,
      if (password != null) 'password': password,
      if (email != null) 'email': email,
      if (age != null) 'age': age,
    });
  }

  UsersCompanion copyWith(
      {Value<int?>? cloudId,
      Value<int?>? syncCurd,
      Value<String?>? syncUpdateColumns,
      Value<int>? id,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<String?>? username,
      Value<String?>? password,
      Value<String?>? email,
      Value<int?>? age}) {
    return UsersCompanion(
      cloudId: cloudId ?? this.cloudId,
      syncCurd: syncCurd ?? this.syncCurd,
      syncUpdateColumns: syncUpdateColumns ?? this.syncUpdateColumns,
      id: id ?? this.id,
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
    if (cloudId.present) {
      map['cloud_id'] = Variable<int?>(cloudId.value);
    }
    if (syncCurd.present) {
      map['sync_curd'] = Variable<int?>(syncCurd.value);
    }
    if (syncUpdateColumns.present) {
      map['sync_update_columns'] = Variable<String?>(syncUpdateColumns.value);
    }
    if (id.present) {
      map['id'] = Variable<int>(id.value);
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
          ..write('cloudId: $cloudId, ')
          ..write('syncCurd: $syncCurd, ')
          ..write('syncUpdateColumns: $syncUpdateColumns, ')
          ..write('id: $id, ')
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
  final VerificationMeta _cloudIdMeta = const VerificationMeta('cloudId');
  @override
  late final GeneratedColumn<int?> cloudId = GeneratedColumn<int?>(
      'cloud_id', aliasedName, true,
      type: const IntType(),
      requiredDuringInsert: false,
      $customConstraints: 'UNIQUE');
  final VerificationMeta _syncCurdMeta = const VerificationMeta('syncCurd');
  @override
  late final GeneratedColumn<int?> syncCurd = GeneratedColumn<int?>(
      'sync_curd', aliasedName, true,
      type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _syncUpdateColumnsMeta =
      const VerificationMeta('syncUpdateColumns');
  @override
  late final GeneratedColumn<String?> syncUpdateColumns =
      GeneratedColumn<String?>('sync_update_columns', aliasedName, true,
          type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
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
        cloudId,
        syncCurd,
        syncUpdateColumns,
        id,
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
    if (data.containsKey('cloud_id')) {
      context.handle(_cloudIdMeta,
          cloudId.isAcceptableOrUnknown(data['cloud_id']!, _cloudIdMeta));
    }
    if (data.containsKey('sync_curd')) {
      context.handle(_syncCurdMeta,
          syncCurd.isAcceptableOrUnknown(data['sync_curd']!, _syncCurdMeta));
    }
    if (data.containsKey('sync_update_columns')) {
      context.handle(
          _syncUpdateColumnsMeta,
          syncUpdateColumns.isAcceptableOrUnknown(
              data['sync_update_columns']!, _syncUpdateColumnsMeta));
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
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
}

abstract class _$DriftDb extends GeneratedDatabase {
  _$DriftDb(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $UsersTable users = $UsersTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [users];
}
