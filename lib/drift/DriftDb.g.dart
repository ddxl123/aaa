// GENERATED CODE - DO NOT MODIFY BY HAND

part of drift_db;

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: type=lint
class User extends DataClass implements Insertable<User> {
  int? cloudId;
  int id;

  /// 必须是本地时间，因为用户是在本地被创建、修改。
  /// *** 需要预防客户端时间篡改
  DateTime createdAt;

  /// 必须是本地时间，因为用户是在本地被创建、修改。
  /// *** 需要预防客户端时间篡改
  DateTime updatedAt;
  String username;
  String? password;
  String email;
  int age;
  User(
      {this.cloudId,
      required this.id,
      required this.createdAt,
      required this.updatedAt,
      required this.username,
      this.password,
      required this.email,
      required this.age});
  factory User.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return User(
      cloudId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}cloud_id']),
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      createdAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at'])!,
      updatedAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}updated_at'])!,
      username: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}username'])!,
      password: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}password']),
      email: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}email'])!,
      age: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}age'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || cloudId != null) {
      map['cloud_id'] = Variable<int?>(cloudId);
    }
    map['id'] = Variable<int>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['username'] = Variable<String>(username);
    if (!nullToAbsent || password != null) {
      map['password'] = Variable<String?>(password);
    }
    map['email'] = Variable<String>(email);
    map['age'] = Variable<int>(age);
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      cloudId: cloudId == null && nullToAbsent
          ? const Value.absent()
          : Value(cloudId),
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      username: Value(username),
      password: password == null && nullToAbsent
          ? const Value.absent()
          : Value(password),
      email: Value(email),
      age: Value(age),
    );
  }

  factory User.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return User(
      cloudId: serializer.fromJson<int?>(json['cloudId']),
      id: serializer.fromJson<int>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      username: serializer.fromJson<String>(json['username']),
      password: serializer.fromJson<String?>(json['password']),
      email: serializer.fromJson<String>(json['email']),
      age: serializer.fromJson<int>(json['age']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'cloudId': serializer.toJson<int?>(cloudId),
      'id': serializer.toJson<int>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'username': serializer.toJson<String>(username),
      'password': serializer.toJson<String?>(password),
      'email': serializer.toJson<String>(email),
      'age': serializer.toJson<int>(age),
    };
  }

  User copyWith(
          {int? cloudId,
          int? id,
          DateTime? createdAt,
          DateTime? updatedAt,
          String? username,
          String? password,
          String? email,
          int? age}) =>
      User(
        cloudId: cloudId ?? this.cloudId,
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
  int get hashCode => Object.hash(
      cloudId, id, createdAt, updatedAt, username, password, email, age);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          other.cloudId == this.cloudId &&
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
  Value<int> id;
  Value<DateTime> createdAt;
  Value<DateTime> updatedAt;
  Value<String> username;
  Value<String?> password;
  Value<String> email;
  Value<int> age;
  UsersCompanion({
    this.cloudId = const Value.absent(),
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
    Expression<int>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? username,
    Expression<String?>? password,
    Expression<String>? email,
    Expression<int>? age,
  }) {
    return RawValuesInsertable({
      if (cloudId != null) 'cloud_id': cloudId,
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
      Value<int>? id,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<String>? username,
      Value<String?>? password,
      Value<String>? email,
      Value<int>? age}) {
    return UsersCompanion(
      cloudId: cloudId ?? this.cloudId,
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
      map['username'] = Variable<String>(username.value);
    }
    if (password.present) {
      map['password'] = Variable<String?>(password.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (age.present) {
      map['age'] = Variable<int>(age.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('cloudId: $cloudId, ')
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
      'username', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: false,
      defaultValue: const Constant('还没有名字'));
  final VerificationMeta _passwordMeta = const VerificationMeta('password');
  @override
  late final GeneratedColumn<String?> password = GeneratedColumn<String?>(
      'password', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String?> email = GeneratedColumn<String?>(
      'email', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: false,
      defaultValue: const Constant('-'));
  final VerificationMeta _ageMeta = const VerificationMeta('age');
  @override
  late final GeneratedColumn<int?> age = GeneratedColumn<int?>(
      'age', aliasedName, false,
      check: () => age.isBiggerOrEqual(const Constant(0)),
      type: const IntType(),
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns =>
      [cloudId, id, createdAt, updatedAt, username, password, email, age];
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

class Fragment extends DataClass implements Insertable<Fragment> {
  int? cloudId;
  int id;

  /// 必须是本地时间，因为用户是在本地被创建、修改。
  /// *** 需要预防客户端时间篡改
  DateTime createdAt;

  /// 必须是本地时间，因为用户是在本地被创建、修改。
  /// *** 需要预防客户端时间篡改
  DateTime updatedAt;

  /// 父节点。
  ///
  /// 若为 null，则自身为父节点。
  int? fatherFragmentId;
  String title;

  /// 优先级/高频程度。
  ///
  /// 数字越大，优先级越高，不能为负数。
  int priority;
  Fragment(
      {this.cloudId,
      required this.id,
      required this.createdAt,
      required this.updatedAt,
      this.fatherFragmentId,
      required this.title,
      required this.priority});
  factory Fragment.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Fragment(
      cloudId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}cloud_id']),
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      createdAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at'])!,
      updatedAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}updated_at'])!,
      fatherFragmentId: const IntType().mapFromDatabaseResponse(
          data['${effectivePrefix}father_fragment_id']),
      title: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}title'])!,
      priority: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}priority'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || cloudId != null) {
      map['cloud_id'] = Variable<int?>(cloudId);
    }
    map['id'] = Variable<int>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || fatherFragmentId != null) {
      map['father_fragment_id'] = Variable<int?>(fatherFragmentId);
    }
    map['title'] = Variable<String>(title);
    map['priority'] = Variable<int>(priority);
    return map;
  }

  FragmentsCompanion toCompanion(bool nullToAbsent) {
    return FragmentsCompanion(
      cloudId: cloudId == null && nullToAbsent
          ? const Value.absent()
          : Value(cloudId),
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      fatherFragmentId: fatherFragmentId == null && nullToAbsent
          ? const Value.absent()
          : Value(fatherFragmentId),
      title: Value(title),
      priority: Value(priority),
    );
  }

  factory Fragment.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Fragment(
      cloudId: serializer.fromJson<int?>(json['cloudId']),
      id: serializer.fromJson<int>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      fatherFragmentId: serializer.fromJson<int?>(json['fatherFragmentId']),
      title: serializer.fromJson<String>(json['title']),
      priority: serializer.fromJson<int>(json['priority']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'cloudId': serializer.toJson<int?>(cloudId),
      'id': serializer.toJson<int>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'fatherFragmentId': serializer.toJson<int?>(fatherFragmentId),
      'title': serializer.toJson<String>(title),
      'priority': serializer.toJson<int>(priority),
    };
  }

  Fragment copyWith(
          {int? cloudId,
          int? id,
          DateTime? createdAt,
          DateTime? updatedAt,
          int? fatherFragmentId,
          String? title,
          int? priority}) =>
      Fragment(
        cloudId: cloudId ?? this.cloudId,
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        fatherFragmentId: fatherFragmentId ?? this.fatherFragmentId,
        title: title ?? this.title,
        priority: priority ?? this.priority,
      );
  @override
  String toString() {
    return (StringBuffer('Fragment(')
          ..write('cloudId: $cloudId, ')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('fatherFragmentId: $fatherFragmentId, ')
          ..write('title: $title, ')
          ..write('priority: $priority')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      cloudId, id, createdAt, updatedAt, fatherFragmentId, title, priority);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Fragment &&
          other.cloudId == this.cloudId &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.fatherFragmentId == this.fatherFragmentId &&
          other.title == this.title &&
          other.priority == this.priority);
}

class FragmentsCompanion extends UpdateCompanion<Fragment> {
  Value<int?> cloudId;
  Value<int> id;
  Value<DateTime> createdAt;
  Value<DateTime> updatedAt;
  Value<int?> fatherFragmentId;
  Value<String> title;
  Value<int> priority;
  FragmentsCompanion({
    this.cloudId = const Value.absent(),
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.fatherFragmentId = const Value.absent(),
    this.title = const Value.absent(),
    this.priority = const Value.absent(),
  });
  FragmentsCompanion.insert({
    this.cloudId = const Value.absent(),
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.fatherFragmentId = const Value.absent(),
    this.title = const Value.absent(),
    this.priority = const Value.absent(),
  });
  static Insertable<Fragment> custom({
    Expression<int?>? cloudId,
    Expression<int>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int?>? fatherFragmentId,
    Expression<String>? title,
    Expression<int>? priority,
  }) {
    return RawValuesInsertable({
      if (cloudId != null) 'cloud_id': cloudId,
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (fatherFragmentId != null) 'father_fragment_id': fatherFragmentId,
      if (title != null) 'title': title,
      if (priority != null) 'priority': priority,
    });
  }

  FragmentsCompanion copyWith(
      {Value<int?>? cloudId,
      Value<int>? id,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int?>? fatherFragmentId,
      Value<String>? title,
      Value<int>? priority}) {
    return FragmentsCompanion(
      cloudId: cloudId ?? this.cloudId,
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      fatherFragmentId: fatherFragmentId ?? this.fatherFragmentId,
      title: title ?? this.title,
      priority: priority ?? this.priority,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (cloudId.present) {
      map['cloud_id'] = Variable<int?>(cloudId.value);
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
    if (fatherFragmentId.present) {
      map['father_fragment_id'] = Variable<int?>(fatherFragmentId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (priority.present) {
      map['priority'] = Variable<int>(priority.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FragmentsCompanion(')
          ..write('cloudId: $cloudId, ')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('fatherFragmentId: $fatherFragmentId, ')
          ..write('title: $title, ')
          ..write('priority: $priority')
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
  final VerificationMeta _cloudIdMeta = const VerificationMeta('cloudId');
  @override
  late final GeneratedColumn<int?> cloudId = GeneratedColumn<int?>(
      'cloud_id', aliasedName, true,
      type: const IntType(),
      requiredDuringInsert: false,
      $customConstraints: 'UNIQUE');
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
  final VerificationMeta _fatherFragmentIdMeta =
      const VerificationMeta('fatherFragmentId');
  @override
  late final GeneratedColumn<int?> fatherFragmentId = GeneratedColumn<int?>(
      'father_fragment_id', aliasedName, true,
      type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String?> title = GeneratedColumn<String?>(
      'title', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: false,
      defaultValue: const Constant('还没有标题'));
  final VerificationMeta _priorityMeta = const VerificationMeta('priority');
  @override
  late final GeneratedColumn<int?> priority = GeneratedColumn<int?>(
      'priority', aliasedName, false,
      check: () => priority.isBiggerOrEqual(const Constant(0)),
      type: const IntType(),
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns =>
      [cloudId, id, createdAt, updatedAt, fatherFragmentId, title, priority];
  @override
  String get aliasedName => _alias ?? 'fragments';
  @override
  String get actualTableName => 'fragments';
  @override
  VerificationContext validateIntegrity(Insertable<Fragment> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('cloud_id')) {
      context.handle(_cloudIdMeta,
          cloudId.isAcceptableOrUnknown(data['cloud_id']!, _cloudIdMeta));
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
    if (data.containsKey('father_fragment_id')) {
      context.handle(
          _fatherFragmentIdMeta,
          fatherFragmentId.isAcceptableOrUnknown(
              data['father_fragment_id']!, _fatherFragmentIdMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    }
    if (data.containsKey('priority')) {
      context.handle(_priorityMeta,
          priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta));
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
}

class FragmentGroup extends DataClass implements Insertable<FragmentGroup> {
  int? cloudId;
  int id;

  /// 必须是本地时间，因为用户是在本地被创建、修改。
  /// *** 需要预防客户端时间篡改
  DateTime createdAt;

  /// 必须是本地时间，因为用户是在本地被创建、修改。
  /// *** 需要预防客户端时间篡改
  DateTime updatedAt;
  int? fatherFragmentGroupId;
  int? fatherFragmentGroupCloudId;
  String title;
  FragmentGroup(
      {this.cloudId,
      required this.id,
      required this.createdAt,
      required this.updatedAt,
      this.fatherFragmentGroupId,
      this.fatherFragmentGroupCloudId,
      required this.title});
  factory FragmentGroup.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return FragmentGroup(
      cloudId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}cloud_id']),
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      createdAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at'])!,
      updatedAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}updated_at'])!,
      fatherFragmentGroupId: const IntType().mapFromDatabaseResponse(
          data['${effectivePrefix}father_fragment_group_id']),
      fatherFragmentGroupCloudId: const IntType().mapFromDatabaseResponse(
          data['${effectivePrefix}father_fragment_group_cloud_id']),
      title: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}title'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || cloudId != null) {
      map['cloud_id'] = Variable<int?>(cloudId);
    }
    map['id'] = Variable<int>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || fatherFragmentGroupId != null) {
      map['father_fragment_group_id'] = Variable<int?>(fatherFragmentGroupId);
    }
    if (!nullToAbsent || fatherFragmentGroupCloudId != null) {
      map['father_fragment_group_cloud_id'] =
          Variable<int?>(fatherFragmentGroupCloudId);
    }
    map['title'] = Variable<String>(title);
    return map;
  }

  FragmentGroupsCompanion toCompanion(bool nullToAbsent) {
    return FragmentGroupsCompanion(
      cloudId: cloudId == null && nullToAbsent
          ? const Value.absent()
          : Value(cloudId),
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      fatherFragmentGroupId: fatherFragmentGroupId == null && nullToAbsent
          ? const Value.absent()
          : Value(fatherFragmentGroupId),
      fatherFragmentGroupCloudId:
          fatherFragmentGroupCloudId == null && nullToAbsent
              ? const Value.absent()
              : Value(fatherFragmentGroupCloudId),
      title: Value(title),
    );
  }

  factory FragmentGroup.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FragmentGroup(
      cloudId: serializer.fromJson<int?>(json['cloudId']),
      id: serializer.fromJson<int>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      fatherFragmentGroupId:
          serializer.fromJson<int?>(json['fatherFragmentGroupId']),
      fatherFragmentGroupCloudId:
          serializer.fromJson<int?>(json['fatherFragmentGroupCloudId']),
      title: serializer.fromJson<String>(json['title']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'cloudId': serializer.toJson<int?>(cloudId),
      'id': serializer.toJson<int>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'fatherFragmentGroupId': serializer.toJson<int?>(fatherFragmentGroupId),
      'fatherFragmentGroupCloudId':
          serializer.toJson<int?>(fatherFragmentGroupCloudId),
      'title': serializer.toJson<String>(title),
    };
  }

  FragmentGroup copyWith(
          {int? cloudId,
          int? id,
          DateTime? createdAt,
          DateTime? updatedAt,
          int? fatherFragmentGroupId,
          int? fatherFragmentGroupCloudId,
          String? title}) =>
      FragmentGroup(
        cloudId: cloudId ?? this.cloudId,
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        fatherFragmentGroupId:
            fatherFragmentGroupId ?? this.fatherFragmentGroupId,
        fatherFragmentGroupCloudId:
            fatherFragmentGroupCloudId ?? this.fatherFragmentGroupCloudId,
        title: title ?? this.title,
      );
  @override
  String toString() {
    return (StringBuffer('FragmentGroup(')
          ..write('cloudId: $cloudId, ')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('fatherFragmentGroupId: $fatherFragmentGroupId, ')
          ..write('fatherFragmentGroupCloudId: $fatherFragmentGroupCloudId, ')
          ..write('title: $title')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(cloudId, id, createdAt, updatedAt,
      fatherFragmentGroupId, fatherFragmentGroupCloudId, title);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FragmentGroup &&
          other.cloudId == this.cloudId &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.fatherFragmentGroupId == this.fatherFragmentGroupId &&
          other.fatherFragmentGroupCloudId == this.fatherFragmentGroupCloudId &&
          other.title == this.title);
}

class FragmentGroupsCompanion extends UpdateCompanion<FragmentGroup> {
  Value<int?> cloudId;
  Value<int> id;
  Value<DateTime> createdAt;
  Value<DateTime> updatedAt;
  Value<int?> fatherFragmentGroupId;
  Value<int?> fatherFragmentGroupCloudId;
  Value<String> title;
  FragmentGroupsCompanion({
    this.cloudId = const Value.absent(),
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.fatherFragmentGroupId = const Value.absent(),
    this.fatherFragmentGroupCloudId = const Value.absent(),
    this.title = const Value.absent(),
  });
  FragmentGroupsCompanion.insert({
    this.cloudId = const Value.absent(),
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.fatherFragmentGroupId = const Value.absent(),
    this.fatherFragmentGroupCloudId = const Value.absent(),
    this.title = const Value.absent(),
  });
  static Insertable<FragmentGroup> custom({
    Expression<int?>? cloudId,
    Expression<int>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int?>? fatherFragmentGroupId,
    Expression<int?>? fatherFragmentGroupCloudId,
    Expression<String>? title,
  }) {
    return RawValuesInsertable({
      if (cloudId != null) 'cloud_id': cloudId,
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (fatherFragmentGroupId != null)
        'father_fragment_group_id': fatherFragmentGroupId,
      if (fatherFragmentGroupCloudId != null)
        'father_fragment_group_cloud_id': fatherFragmentGroupCloudId,
      if (title != null) 'title': title,
    });
  }

  FragmentGroupsCompanion copyWith(
      {Value<int?>? cloudId,
      Value<int>? id,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int?>? fatherFragmentGroupId,
      Value<int?>? fatherFragmentGroupCloudId,
      Value<String>? title}) {
    return FragmentGroupsCompanion(
      cloudId: cloudId ?? this.cloudId,
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      fatherFragmentGroupId:
          fatherFragmentGroupId ?? this.fatherFragmentGroupId,
      fatherFragmentGroupCloudId:
          fatherFragmentGroupCloudId ?? this.fatherFragmentGroupCloudId,
      title: title ?? this.title,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (cloudId.present) {
      map['cloud_id'] = Variable<int?>(cloudId.value);
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
    if (fatherFragmentGroupId.present) {
      map['father_fragment_group_id'] =
          Variable<int?>(fatherFragmentGroupId.value);
    }
    if (fatherFragmentGroupCloudId.present) {
      map['father_fragment_group_cloud_id'] =
          Variable<int?>(fatherFragmentGroupCloudId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FragmentGroupsCompanion(')
          ..write('cloudId: $cloudId, ')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('fatherFragmentGroupId: $fatherFragmentGroupId, ')
          ..write('fatherFragmentGroupCloudId: $fatherFragmentGroupCloudId, ')
          ..write('title: $title')
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
  final VerificationMeta _cloudIdMeta = const VerificationMeta('cloudId');
  @override
  late final GeneratedColumn<int?> cloudId = GeneratedColumn<int?>(
      'cloud_id', aliasedName, true,
      type: const IntType(),
      requiredDuringInsert: false,
      $customConstraints: 'UNIQUE');
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
  final VerificationMeta _fatherFragmentGroupIdMeta =
      const VerificationMeta('fatherFragmentGroupId');
  @override
  late final GeneratedColumn<int?> fatherFragmentGroupId =
      GeneratedColumn<int?>('father_fragment_group_id', aliasedName, true,
          type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _fatherFragmentGroupCloudIdMeta =
      const VerificationMeta('fatherFragmentGroupCloudId');
  @override
  late final GeneratedColumn<int?> fatherFragmentGroupCloudId =
      GeneratedColumn<int?>('father_fragment_group_cloud_id', aliasedName, true,
          type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String?> title = GeneratedColumn<String?>(
      'title', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: false,
      defaultValue: const Constant('还没有名称'));
  @override
  List<GeneratedColumn> get $columns => [
        cloudId,
        id,
        createdAt,
        updatedAt,
        fatherFragmentGroupId,
        fatherFragmentGroupCloudId,
        title
      ];
  @override
  String get aliasedName => _alias ?? 'fragment_groups';
  @override
  String get actualTableName => 'fragment_groups';
  @override
  VerificationContext validateIntegrity(Insertable<FragmentGroup> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('cloud_id')) {
      context.handle(_cloudIdMeta,
          cloudId.isAcceptableOrUnknown(data['cloud_id']!, _cloudIdMeta));
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
    if (data.containsKey('father_fragment_group_id')) {
      context.handle(
          _fatherFragmentGroupIdMeta,
          fatherFragmentGroupId.isAcceptableOrUnknown(
              data['father_fragment_group_id']!, _fatherFragmentGroupIdMeta));
    }
    if (data.containsKey('father_fragment_group_cloud_id')) {
      context.handle(
          _fatherFragmentGroupCloudIdMeta,
          fatherFragmentGroupCloudId.isAcceptableOrUnknown(
              data['father_fragment_group_cloud_id']!,
              _fatherFragmentGroupCloudIdMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
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
}

class MemoryGroup extends DataClass implements Insertable<MemoryGroup> {
  int? cloudId;
  int id;

  /// 必须是本地时间，因为用户是在本地被创建、修改。
  /// *** 需要预防客户端时间篡改
  DateTime createdAt;

  /// 必须是本地时间，因为用户是在本地被创建、修改。
  /// *** 需要预防客户端时间篡改
  DateTime updatedAt;
  String title;
  MemoryGroupType type;

  /// [MemoryGroupStatusForNormal]
  MemoryGroupStatusForNormal normalStatus;

  /// [MemoryGroupStatusForNormalPart]
  MemoryGroupStatusForNormalPart normalPartStatus;

  /// [MemoryGroupStatusForFullFloating]
  MemoryGroupStatusForFullFloating fullFloatingStatus;
  MemoryGroup(
      {this.cloudId,
      required this.id,
      required this.createdAt,
      required this.updatedAt,
      required this.title,
      required this.type,
      required this.normalStatus,
      required this.normalPartStatus,
      required this.fullFloatingStatus});
  factory MemoryGroup.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return MemoryGroup(
      cloudId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}cloud_id']),
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      createdAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at'])!,
      updatedAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}updated_at'])!,
      title: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}title'])!,
      type: $MemoryGroupsTable.$converter0.mapToDart(const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}type']))!,
      normalStatus: $MemoryGroupsTable.$converter1.mapToDart(const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}normal_status']))!,
      normalPartStatus: $MemoryGroupsTable.$converter2.mapToDart(const IntType()
          .mapFromDatabaseResponse(
              data['${effectivePrefix}normal_part_status']))!,
      fullFloatingStatus: $MemoryGroupsTable.$converter3.mapToDart(
          const IntType().mapFromDatabaseResponse(
              data['${effectivePrefix}full_floating_status']))!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || cloudId != null) {
      map['cloud_id'] = Variable<int?>(cloudId);
    }
    map['id'] = Variable<int>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['title'] = Variable<String>(title);
    {
      final converter = $MemoryGroupsTable.$converter0;
      map['type'] = Variable<int>(converter.mapToSql(type)!);
    }
    {
      final converter = $MemoryGroupsTable.$converter1;
      map['normal_status'] = Variable<int>(converter.mapToSql(normalStatus)!);
    }
    {
      final converter = $MemoryGroupsTable.$converter2;
      map['normal_part_status'] =
          Variable<int>(converter.mapToSql(normalPartStatus)!);
    }
    {
      final converter = $MemoryGroupsTable.$converter3;
      map['full_floating_status'] =
          Variable<int>(converter.mapToSql(fullFloatingStatus)!);
    }
    return map;
  }

  MemoryGroupsCompanion toCompanion(bool nullToAbsent) {
    return MemoryGroupsCompanion(
      cloudId: cloudId == null && nullToAbsent
          ? const Value.absent()
          : Value(cloudId),
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      title: Value(title),
      type: Value(type),
      normalStatus: Value(normalStatus),
      normalPartStatus: Value(normalPartStatus),
      fullFloatingStatus: Value(fullFloatingStatus),
    );
  }

  factory MemoryGroup.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MemoryGroup(
      cloudId: serializer.fromJson<int?>(json['cloudId']),
      id: serializer.fromJson<int>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      title: serializer.fromJson<String>(json['title']),
      type: serializer.fromJson<MemoryGroupType>(json['type']),
      normalStatus:
          serializer.fromJson<MemoryGroupStatusForNormal>(json['normalStatus']),
      normalPartStatus: serializer
          .fromJson<MemoryGroupStatusForNormalPart>(json['normalPartStatus']),
      fullFloatingStatus: serializer.fromJson<MemoryGroupStatusForFullFloating>(
          json['fullFloatingStatus']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'cloudId': serializer.toJson<int?>(cloudId),
      'id': serializer.toJson<int>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'title': serializer.toJson<String>(title),
      'type': serializer.toJson<MemoryGroupType>(type),
      'normalStatus':
          serializer.toJson<MemoryGroupStatusForNormal>(normalStatus),
      'normalPartStatus':
          serializer.toJson<MemoryGroupStatusForNormalPart>(normalPartStatus),
      'fullFloatingStatus': serializer
          .toJson<MemoryGroupStatusForFullFloating>(fullFloatingStatus),
    };
  }

  MemoryGroup copyWith(
          {int? cloudId,
          int? id,
          DateTime? createdAt,
          DateTime? updatedAt,
          String? title,
          MemoryGroupType? type,
          MemoryGroupStatusForNormal? normalStatus,
          MemoryGroupStatusForNormalPart? normalPartStatus,
          MemoryGroupStatusForFullFloating? fullFloatingStatus}) =>
      MemoryGroup(
        cloudId: cloudId ?? this.cloudId,
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        title: title ?? this.title,
        type: type ?? this.type,
        normalStatus: normalStatus ?? this.normalStatus,
        normalPartStatus: normalPartStatus ?? this.normalPartStatus,
        fullFloatingStatus: fullFloatingStatus ?? this.fullFloatingStatus,
      );
  @override
  String toString() {
    return (StringBuffer('MemoryGroup(')
          ..write('cloudId: $cloudId, ')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('title: $title, ')
          ..write('type: $type, ')
          ..write('normalStatus: $normalStatus, ')
          ..write('normalPartStatus: $normalPartStatus, ')
          ..write('fullFloatingStatus: $fullFloatingStatus')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(cloudId, id, createdAt, updatedAt, title,
      type, normalStatus, normalPartStatus, fullFloatingStatus);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MemoryGroup &&
          other.cloudId == this.cloudId &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.title == this.title &&
          other.type == this.type &&
          other.normalStatus == this.normalStatus &&
          other.normalPartStatus == this.normalPartStatus &&
          other.fullFloatingStatus == this.fullFloatingStatus);
}

class MemoryGroupsCompanion extends UpdateCompanion<MemoryGroup> {
  Value<int?> cloudId;
  Value<int> id;
  Value<DateTime> createdAt;
  Value<DateTime> updatedAt;
  Value<String> title;
  Value<MemoryGroupType> type;
  Value<MemoryGroupStatusForNormal> normalStatus;
  Value<MemoryGroupStatusForNormalPart> normalPartStatus;
  Value<MemoryGroupStatusForFullFloating> fullFloatingStatus;
  MemoryGroupsCompanion({
    this.cloudId = const Value.absent(),
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.title = const Value.absent(),
    this.type = const Value.absent(),
    this.normalStatus = const Value.absent(),
    this.normalPartStatus = const Value.absent(),
    this.fullFloatingStatus = const Value.absent(),
  });
  MemoryGroupsCompanion.insert({
    this.cloudId = const Value.absent(),
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.title = const Value.absent(),
    this.type = const Value.absent(),
    this.normalStatus = const Value.absent(),
    this.normalPartStatus = const Value.absent(),
    this.fullFloatingStatus = const Value.absent(),
  });
  static Insertable<MemoryGroup> custom({
    Expression<int?>? cloudId,
    Expression<int>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? title,
    Expression<MemoryGroupType>? type,
    Expression<MemoryGroupStatusForNormal>? normalStatus,
    Expression<MemoryGroupStatusForNormalPart>? normalPartStatus,
    Expression<MemoryGroupStatusForFullFloating>? fullFloatingStatus,
  }) {
    return RawValuesInsertable({
      if (cloudId != null) 'cloud_id': cloudId,
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (title != null) 'title': title,
      if (type != null) 'type': type,
      if (normalStatus != null) 'normal_status': normalStatus,
      if (normalPartStatus != null) 'normal_part_status': normalPartStatus,
      if (fullFloatingStatus != null)
        'full_floating_status': fullFloatingStatus,
    });
  }

  MemoryGroupsCompanion copyWith(
      {Value<int?>? cloudId,
      Value<int>? id,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<String>? title,
      Value<MemoryGroupType>? type,
      Value<MemoryGroupStatusForNormal>? normalStatus,
      Value<MemoryGroupStatusForNormalPart>? normalPartStatus,
      Value<MemoryGroupStatusForFullFloating>? fullFloatingStatus}) {
    return MemoryGroupsCompanion(
      cloudId: cloudId ?? this.cloudId,
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      title: title ?? this.title,
      type: type ?? this.type,
      normalStatus: normalStatus ?? this.normalStatus,
      normalPartStatus: normalPartStatus ?? this.normalPartStatus,
      fullFloatingStatus: fullFloatingStatus ?? this.fullFloatingStatus,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (cloudId.present) {
      map['cloud_id'] = Variable<int?>(cloudId.value);
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
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (type.present) {
      final converter = $MemoryGroupsTable.$converter0;
      map['type'] = Variable<int>(converter.mapToSql(type.value)!);
    }
    if (normalStatus.present) {
      final converter = $MemoryGroupsTable.$converter1;
      map['normal_status'] =
          Variable<int>(converter.mapToSql(normalStatus.value)!);
    }
    if (normalPartStatus.present) {
      final converter = $MemoryGroupsTable.$converter2;
      map['normal_part_status'] =
          Variable<int>(converter.mapToSql(normalPartStatus.value)!);
    }
    if (fullFloatingStatus.present) {
      final converter = $MemoryGroupsTable.$converter3;
      map['full_floating_status'] =
          Variable<int>(converter.mapToSql(fullFloatingStatus.value)!);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MemoryGroupsCompanion(')
          ..write('cloudId: $cloudId, ')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('title: $title, ')
          ..write('type: $type, ')
          ..write('normalStatus: $normalStatus, ')
          ..write('normalPartStatus: $normalPartStatus, ')
          ..write('fullFloatingStatus: $fullFloatingStatus')
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
  final VerificationMeta _cloudIdMeta = const VerificationMeta('cloudId');
  @override
  late final GeneratedColumn<int?> cloudId = GeneratedColumn<int?>(
      'cloud_id', aliasedName, true,
      type: const IntType(),
      requiredDuringInsert: false,
      $customConstraints: 'UNIQUE');
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
  final VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String?> title = GeneratedColumn<String?>(
      'title', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: false,
      defaultValue: const Constant('还没有名称'));
  final VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumnWithTypeConverter<MemoryGroupType, int?> type =
      GeneratedColumn<int?>('type', aliasedName, false,
              type: const IntType(),
              requiredDuringInsert: false,
              defaultValue: Constant(MemoryGroupType.normal.index))
          .withConverter<MemoryGroupType>($MemoryGroupsTable.$converter0);
  final VerificationMeta _normalStatusMeta =
      const VerificationMeta('normalStatus');
  @override
  late final GeneratedColumnWithTypeConverter<MemoryGroupStatusForNormal, int?>
      normalStatus = GeneratedColumn<int?>('normal_status', aliasedName, false,
              type: const IntType(),
              requiredDuringInsert: false,
              defaultValue: Constant(MemoryGroupStatusForNormal.notStart.index))
          .withConverter<MemoryGroupStatusForNormal>(
              $MemoryGroupsTable.$converter1);
  final VerificationMeta _normalPartStatusMeta =
      const VerificationMeta('normalPartStatus');
  @override
  late final GeneratedColumnWithTypeConverter<MemoryGroupStatusForNormalPart,
      int?> normalPartStatus = GeneratedColumn<int?>(
          'normal_part_status', aliasedName, false,
          type: const IntType(),
          requiredDuringInsert: false,
          defaultValue: Constant(MemoryGroupStatusForNormalPart.disabled.index))
      .withConverter<MemoryGroupStatusForNormalPart>(
          $MemoryGroupsTable.$converter2);
  final VerificationMeta _fullFloatingStatusMeta =
      const VerificationMeta('fullFloatingStatus');
  @override
  late final GeneratedColumnWithTypeConverter<MemoryGroupStatusForFullFloating,
      int?> fullFloatingStatus = GeneratedColumn<int?>(
          'full_floating_status', aliasedName, false,
          type: const IntType(),
          requiredDuringInsert: false,
          defaultValue:
              Constant(MemoryGroupStatusForFullFloating.notStarted.index))
      .withConverter<MemoryGroupStatusForFullFloating>(
          $MemoryGroupsTable.$converter3);
  @override
  List<GeneratedColumn> get $columns => [
        cloudId,
        id,
        createdAt,
        updatedAt,
        title,
        type,
        normalStatus,
        normalPartStatus,
        fullFloatingStatus
      ];
  @override
  String get aliasedName => _alias ?? 'memory_groups';
  @override
  String get actualTableName => 'memory_groups';
  @override
  VerificationContext validateIntegrity(Insertable<MemoryGroup> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('cloud_id')) {
      context.handle(_cloudIdMeta,
          cloudId.isAcceptableOrUnknown(data['cloud_id']!, _cloudIdMeta));
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
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    }
    context.handle(_typeMeta, const VerificationResult.success());
    context.handle(_normalStatusMeta, const VerificationResult.success());
    context.handle(_normalPartStatusMeta, const VerificationResult.success());
    context.handle(_fullFloatingStatusMeta, const VerificationResult.success());
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

  static TypeConverter<MemoryGroupType, int> $converter0 =
      const EnumIndexConverter<MemoryGroupType>(MemoryGroupType.values);
  static TypeConverter<MemoryGroupStatusForNormal, int> $converter1 =
      const EnumIndexConverter<MemoryGroupStatusForNormal>(
          MemoryGroupStatusForNormal.values);
  static TypeConverter<MemoryGroupStatusForNormalPart, int> $converter2 =
      const EnumIndexConverter<MemoryGroupStatusForNormalPart>(
          MemoryGroupStatusForNormalPart.values);
  static TypeConverter<MemoryGroupStatusForFullFloating, int> $converter3 =
      const EnumIndexConverter<MemoryGroupStatusForFullFloating>(
          MemoryGroupStatusForFullFloating.values);
}

class MemoryModel extends DataClass implements Insertable<MemoryModel> {
  int? cloudId;
  int id;

  /// 必须是本地时间，因为用户是在本地被创建、修改。
  /// *** 需要预防客户端时间篡改
  DateTime createdAt;

  /// 必须是本地时间，因为用户是在本地被创建、修改。
  /// *** 需要预防客户端时间篡改
  DateTime updatedAt;
  String title;

  /// 记忆曲线的数学函数。
  ///
  /// 例如： 'type:y=1-0.56t^0.06'
  ///   - y - 熟练度，单位百分比。
  ///   - t - 时间，初始值为 0。
  ///   - type - 表示函数类型，比如普通函数曲线类型、分段函数类型等。
  String? mathFunction;

  /// 下一次展示时间点的数学函数。
  ///
  /// 例如：'type:n=tc+y'
  ///   - n - 下一次展示时间点。
  ///   - tc - 当前时间点。
  ///   - y - 熟练度。
  ///   - type - 表示函数类型，比如函数曲线类型、固定值类型（fix:5,30,60,300(单位分钟)）等。
  String? nextShowTimeMathFunction;
  MemoryModel(
      {this.cloudId,
      required this.id,
      required this.createdAt,
      required this.updatedAt,
      required this.title,
      this.mathFunction,
      this.nextShowTimeMathFunction});
  factory MemoryModel.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return MemoryModel(
      cloudId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}cloud_id']),
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      createdAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at'])!,
      updatedAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}updated_at'])!,
      title: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}title'])!,
      mathFunction: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}math_function']),
      nextShowTimeMathFunction: const StringType().mapFromDatabaseResponse(
          data['${effectivePrefix}next_show_time_math_function']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || cloudId != null) {
      map['cloud_id'] = Variable<int?>(cloudId);
    }
    map['id'] = Variable<int>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || mathFunction != null) {
      map['math_function'] = Variable<String?>(mathFunction);
    }
    if (!nullToAbsent || nextShowTimeMathFunction != null) {
      map['next_show_time_math_function'] =
          Variable<String?>(nextShowTimeMathFunction);
    }
    return map;
  }

  MemoryModelsCompanion toCompanion(bool nullToAbsent) {
    return MemoryModelsCompanion(
      cloudId: cloudId == null && nullToAbsent
          ? const Value.absent()
          : Value(cloudId),
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      title: Value(title),
      mathFunction: mathFunction == null && nullToAbsent
          ? const Value.absent()
          : Value(mathFunction),
      nextShowTimeMathFunction: nextShowTimeMathFunction == null && nullToAbsent
          ? const Value.absent()
          : Value(nextShowTimeMathFunction),
    );
  }

  factory MemoryModel.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MemoryModel(
      cloudId: serializer.fromJson<int?>(json['cloudId']),
      id: serializer.fromJson<int>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      title: serializer.fromJson<String>(json['title']),
      mathFunction: serializer.fromJson<String?>(json['mathFunction']),
      nextShowTimeMathFunction:
          serializer.fromJson<String?>(json['nextShowTimeMathFunction']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'cloudId': serializer.toJson<int?>(cloudId),
      'id': serializer.toJson<int>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'title': serializer.toJson<String>(title),
      'mathFunction': serializer.toJson<String?>(mathFunction),
      'nextShowTimeMathFunction':
          serializer.toJson<String?>(nextShowTimeMathFunction),
    };
  }

  MemoryModel copyWith(
          {int? cloudId,
          int? id,
          DateTime? createdAt,
          DateTime? updatedAt,
          String? title,
          String? mathFunction,
          String? nextShowTimeMathFunction}) =>
      MemoryModel(
        cloudId: cloudId ?? this.cloudId,
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        title: title ?? this.title,
        mathFunction: mathFunction ?? this.mathFunction,
        nextShowTimeMathFunction:
            nextShowTimeMathFunction ?? this.nextShowTimeMathFunction,
      );
  @override
  String toString() {
    return (StringBuffer('MemoryModel(')
          ..write('cloudId: $cloudId, ')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('title: $title, ')
          ..write('mathFunction: $mathFunction, ')
          ..write('nextShowTimeMathFunction: $nextShowTimeMathFunction')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(cloudId, id, createdAt, updatedAt, title,
      mathFunction, nextShowTimeMathFunction);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MemoryModel &&
          other.cloudId == this.cloudId &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.title == this.title &&
          other.mathFunction == this.mathFunction &&
          other.nextShowTimeMathFunction == this.nextShowTimeMathFunction);
}

class MemoryModelsCompanion extends UpdateCompanion<MemoryModel> {
  Value<int?> cloudId;
  Value<int> id;
  Value<DateTime> createdAt;
  Value<DateTime> updatedAt;
  Value<String> title;
  Value<String?> mathFunction;
  Value<String?> nextShowTimeMathFunction;
  MemoryModelsCompanion({
    this.cloudId = const Value.absent(),
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.title = const Value.absent(),
    this.mathFunction = const Value.absent(),
    this.nextShowTimeMathFunction = const Value.absent(),
  });
  MemoryModelsCompanion.insert({
    this.cloudId = const Value.absent(),
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.title = const Value.absent(),
    this.mathFunction = const Value.absent(),
    this.nextShowTimeMathFunction = const Value.absent(),
  });
  static Insertable<MemoryModel> custom({
    Expression<int?>? cloudId,
    Expression<int>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? title,
    Expression<String?>? mathFunction,
    Expression<String?>? nextShowTimeMathFunction,
  }) {
    return RawValuesInsertable({
      if (cloudId != null) 'cloud_id': cloudId,
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (title != null) 'title': title,
      if (mathFunction != null) 'math_function': mathFunction,
      if (nextShowTimeMathFunction != null)
        'next_show_time_math_function': nextShowTimeMathFunction,
    });
  }

  MemoryModelsCompanion copyWith(
      {Value<int?>? cloudId,
      Value<int>? id,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<String>? title,
      Value<String?>? mathFunction,
      Value<String?>? nextShowTimeMathFunction}) {
    return MemoryModelsCompanion(
      cloudId: cloudId ?? this.cloudId,
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      title: title ?? this.title,
      mathFunction: mathFunction ?? this.mathFunction,
      nextShowTimeMathFunction:
          nextShowTimeMathFunction ?? this.nextShowTimeMathFunction,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (cloudId.present) {
      map['cloud_id'] = Variable<int?>(cloudId.value);
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
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (mathFunction.present) {
      map['math_function'] = Variable<String?>(mathFunction.value);
    }
    if (nextShowTimeMathFunction.present) {
      map['next_show_time_math_function'] =
          Variable<String?>(nextShowTimeMathFunction.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MemoryModelsCompanion(')
          ..write('cloudId: $cloudId, ')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('title: $title, ')
          ..write('mathFunction: $mathFunction, ')
          ..write('nextShowTimeMathFunction: $nextShowTimeMathFunction')
          ..write(')'))
        .toString();
  }
}

class $MemoryModelsTable extends MemoryModels
    with TableInfo<$MemoryModelsTable, MemoryModel> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MemoryModelsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _cloudIdMeta = const VerificationMeta('cloudId');
  @override
  late final GeneratedColumn<int?> cloudId = GeneratedColumn<int?>(
      'cloud_id', aliasedName, true,
      type: const IntType(),
      requiredDuringInsert: false,
      $customConstraints: 'UNIQUE');
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
  final VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String?> title = GeneratedColumn<String?>(
      'title', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: false,
      defaultValue: const Constant('还没有名称'));
  final VerificationMeta _mathFunctionMeta =
      const VerificationMeta('mathFunction');
  @override
  late final GeneratedColumn<String?> mathFunction = GeneratedColumn<String?>(
      'math_function', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _nextShowTimeMathFunctionMeta =
      const VerificationMeta('nextShowTimeMathFunction');
  @override
  late final GeneratedColumn<String?> nextShowTimeMathFunction =
      GeneratedColumn<String?>(
          'next_show_time_math_function', aliasedName, true,
          type: const StringType(), requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        cloudId,
        id,
        createdAt,
        updatedAt,
        title,
        mathFunction,
        nextShowTimeMathFunction
      ];
  @override
  String get aliasedName => _alias ?? 'memory_models';
  @override
  String get actualTableName => 'memory_models';
  @override
  VerificationContext validateIntegrity(Insertable<MemoryModel> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('cloud_id')) {
      context.handle(_cloudIdMeta,
          cloudId.isAcceptableOrUnknown(data['cloud_id']!, _cloudIdMeta));
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
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    }
    if (data.containsKey('math_function')) {
      context.handle(
          _mathFunctionMeta,
          mathFunction.isAcceptableOrUnknown(
              data['math_function']!, _mathFunctionMeta));
    }
    if (data.containsKey('next_show_time_math_function')) {
      context.handle(
          _nextShowTimeMathFunctionMeta,
          nextShowTimeMathFunction.isAcceptableOrUnknown(
              data['next_show_time_math_function']!,
              _nextShowTimeMathFunctionMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MemoryModel map(Map<String, dynamic> data, {String? tablePrefix}) {
    return MemoryModel.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $MemoryModelsTable createAlias(String alias) {
    return $MemoryModelsTable(attachedDatabase, alias);
  }
}

class FragmentPermanentMemoryInfo extends DataClass
    implements Insertable<FragmentPermanentMemoryInfo> {
  int? cloudId;
  int id;

  /// 必须是本地时间，因为用户是在本地被创建、修改。
  /// *** 需要预防客户端时间篡改
  DateTime createdAt;

  /// 必须是本地时间，因为用户是在本地被创建、修改。
  /// *** 需要预防客户端时间篡改
  DateTime updatedAt;
  int? fragmentId;
  int? fragmentCloudId;

  /// 自然熟悉度 —— 当前时间点的熟悉度
  /// 范围：0~100。
  int naturalFamiliarity;

  /// 明确熟悉度 —— 当前时间点所操作的熟悉度。
  ///
  /// 范围：0~100。
  ///
  /// 在用户选择某点明确熟悉度时，会根据 [MemoryModels] 来计算下一次展示的时间。
  int explicitFamiliarity;

  /// 碎片展示时长。
  int showDuration;
  FragmentPermanentMemoryInfo(
      {this.cloudId,
      required this.id,
      required this.createdAt,
      required this.updatedAt,
      this.fragmentId,
      this.fragmentCloudId,
      required this.naturalFamiliarity,
      required this.explicitFamiliarity,
      required this.showDuration});
  factory FragmentPermanentMemoryInfo.fromData(Map<String, dynamic> data,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return FragmentPermanentMemoryInfo(
      cloudId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}cloud_id']),
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      createdAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at'])!,
      updatedAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}updated_at'])!,
      fragmentId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}fragment_id']),
      fragmentCloudId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}fragment_cloud_id']),
      naturalFamiliarity: const IntType().mapFromDatabaseResponse(
          data['${effectivePrefix}natural_familiarity'])!,
      explicitFamiliarity: const IntType().mapFromDatabaseResponse(
          data['${effectivePrefix}explicit_familiarity'])!,
      showDuration: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}show_duration'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || cloudId != null) {
      map['cloud_id'] = Variable<int?>(cloudId);
    }
    map['id'] = Variable<int>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || fragmentId != null) {
      map['fragment_id'] = Variable<int?>(fragmentId);
    }
    if (!nullToAbsent || fragmentCloudId != null) {
      map['fragment_cloud_id'] = Variable<int?>(fragmentCloudId);
    }
    map['natural_familiarity'] = Variable<int>(naturalFamiliarity);
    map['explicit_familiarity'] = Variable<int>(explicitFamiliarity);
    map['show_duration'] = Variable<int>(showDuration);
    return map;
  }

  FragmentPermanentMemoryInfosCompanion toCompanion(bool nullToAbsent) {
    return FragmentPermanentMemoryInfosCompanion(
      cloudId: cloudId == null && nullToAbsent
          ? const Value.absent()
          : Value(cloudId),
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      fragmentId: fragmentId == null && nullToAbsent
          ? const Value.absent()
          : Value(fragmentId),
      fragmentCloudId: fragmentCloudId == null && nullToAbsent
          ? const Value.absent()
          : Value(fragmentCloudId),
      naturalFamiliarity: Value(naturalFamiliarity),
      explicitFamiliarity: Value(explicitFamiliarity),
      showDuration: Value(showDuration),
    );
  }

  factory FragmentPermanentMemoryInfo.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FragmentPermanentMemoryInfo(
      cloudId: serializer.fromJson<int?>(json['cloudId']),
      id: serializer.fromJson<int>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      fragmentId: serializer.fromJson<int?>(json['fragmentId']),
      fragmentCloudId: serializer.fromJson<int?>(json['fragmentCloudId']),
      naturalFamiliarity: serializer.fromJson<int>(json['naturalFamiliarity']),
      explicitFamiliarity:
          serializer.fromJson<int>(json['explicitFamiliarity']),
      showDuration: serializer.fromJson<int>(json['showDuration']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'cloudId': serializer.toJson<int?>(cloudId),
      'id': serializer.toJson<int>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'fragmentId': serializer.toJson<int?>(fragmentId),
      'fragmentCloudId': serializer.toJson<int?>(fragmentCloudId),
      'naturalFamiliarity': serializer.toJson<int>(naturalFamiliarity),
      'explicitFamiliarity': serializer.toJson<int>(explicitFamiliarity),
      'showDuration': serializer.toJson<int>(showDuration),
    };
  }

  FragmentPermanentMemoryInfo copyWith(
          {int? cloudId,
          int? id,
          DateTime? createdAt,
          DateTime? updatedAt,
          int? fragmentId,
          int? fragmentCloudId,
          int? naturalFamiliarity,
          int? explicitFamiliarity,
          int? showDuration}) =>
      FragmentPermanentMemoryInfo(
        cloudId: cloudId ?? this.cloudId,
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        fragmentId: fragmentId ?? this.fragmentId,
        fragmentCloudId: fragmentCloudId ?? this.fragmentCloudId,
        naturalFamiliarity: naturalFamiliarity ?? this.naturalFamiliarity,
        explicitFamiliarity: explicitFamiliarity ?? this.explicitFamiliarity,
        showDuration: showDuration ?? this.showDuration,
      );
  @override
  String toString() {
    return (StringBuffer('FragmentPermanentMemoryInfo(')
          ..write('cloudId: $cloudId, ')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('fragmentId: $fragmentId, ')
          ..write('fragmentCloudId: $fragmentCloudId, ')
          ..write('naturalFamiliarity: $naturalFamiliarity, ')
          ..write('explicitFamiliarity: $explicitFamiliarity, ')
          ..write('showDuration: $showDuration')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(cloudId, id, createdAt, updatedAt, fragmentId,
      fragmentCloudId, naturalFamiliarity, explicitFamiliarity, showDuration);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FragmentPermanentMemoryInfo &&
          other.cloudId == this.cloudId &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.fragmentId == this.fragmentId &&
          other.fragmentCloudId == this.fragmentCloudId &&
          other.naturalFamiliarity == this.naturalFamiliarity &&
          other.explicitFamiliarity == this.explicitFamiliarity &&
          other.showDuration == this.showDuration);
}

class FragmentPermanentMemoryInfosCompanion
    extends UpdateCompanion<FragmentPermanentMemoryInfo> {
  Value<int?> cloudId;
  Value<int> id;
  Value<DateTime> createdAt;
  Value<DateTime> updatedAt;
  Value<int?> fragmentId;
  Value<int?> fragmentCloudId;
  Value<int> naturalFamiliarity;
  Value<int> explicitFamiliarity;
  Value<int> showDuration;
  FragmentPermanentMemoryInfosCompanion({
    this.cloudId = const Value.absent(),
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.fragmentId = const Value.absent(),
    this.fragmentCloudId = const Value.absent(),
    this.naturalFamiliarity = const Value.absent(),
    this.explicitFamiliarity = const Value.absent(),
    this.showDuration = const Value.absent(),
  });
  FragmentPermanentMemoryInfosCompanion.insert({
    this.cloudId = const Value.absent(),
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.fragmentId = const Value.absent(),
    this.fragmentCloudId = const Value.absent(),
    this.naturalFamiliarity = const Value.absent(),
    this.explicitFamiliarity = const Value.absent(),
    this.showDuration = const Value.absent(),
  });
  static Insertable<FragmentPermanentMemoryInfo> custom({
    Expression<int?>? cloudId,
    Expression<int>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int?>? fragmentId,
    Expression<int?>? fragmentCloudId,
    Expression<int>? naturalFamiliarity,
    Expression<int>? explicitFamiliarity,
    Expression<int>? showDuration,
  }) {
    return RawValuesInsertable({
      if (cloudId != null) 'cloud_id': cloudId,
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (fragmentId != null) 'fragment_id': fragmentId,
      if (fragmentCloudId != null) 'fragment_cloud_id': fragmentCloudId,
      if (naturalFamiliarity != null) 'natural_familiarity': naturalFamiliarity,
      if (explicitFamiliarity != null)
        'explicit_familiarity': explicitFamiliarity,
      if (showDuration != null) 'show_duration': showDuration,
    });
  }

  FragmentPermanentMemoryInfosCompanion copyWith(
      {Value<int?>? cloudId,
      Value<int>? id,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int?>? fragmentId,
      Value<int?>? fragmentCloudId,
      Value<int>? naturalFamiliarity,
      Value<int>? explicitFamiliarity,
      Value<int>? showDuration}) {
    return FragmentPermanentMemoryInfosCompanion(
      cloudId: cloudId ?? this.cloudId,
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      fragmentId: fragmentId ?? this.fragmentId,
      fragmentCloudId: fragmentCloudId ?? this.fragmentCloudId,
      naturalFamiliarity: naturalFamiliarity ?? this.naturalFamiliarity,
      explicitFamiliarity: explicitFamiliarity ?? this.explicitFamiliarity,
      showDuration: showDuration ?? this.showDuration,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (cloudId.present) {
      map['cloud_id'] = Variable<int?>(cloudId.value);
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
    if (fragmentId.present) {
      map['fragment_id'] = Variable<int?>(fragmentId.value);
    }
    if (fragmentCloudId.present) {
      map['fragment_cloud_id'] = Variable<int?>(fragmentCloudId.value);
    }
    if (naturalFamiliarity.present) {
      map['natural_familiarity'] = Variable<int>(naturalFamiliarity.value);
    }
    if (explicitFamiliarity.present) {
      map['explicit_familiarity'] = Variable<int>(explicitFamiliarity.value);
    }
    if (showDuration.present) {
      map['show_duration'] = Variable<int>(showDuration.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FragmentPermanentMemoryInfosCompanion(')
          ..write('cloudId: $cloudId, ')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('fragmentId: $fragmentId, ')
          ..write('fragmentCloudId: $fragmentCloudId, ')
          ..write('naturalFamiliarity: $naturalFamiliarity, ')
          ..write('explicitFamiliarity: $explicitFamiliarity, ')
          ..write('showDuration: $showDuration')
          ..write(')'))
        .toString();
  }
}

class $FragmentPermanentMemoryInfosTable extends FragmentPermanentMemoryInfos
    with
        TableInfo<$FragmentPermanentMemoryInfosTable,
            FragmentPermanentMemoryInfo> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FragmentPermanentMemoryInfosTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _cloudIdMeta = const VerificationMeta('cloudId');
  @override
  late final GeneratedColumn<int?> cloudId = GeneratedColumn<int?>(
      'cloud_id', aliasedName, true,
      type: const IntType(),
      requiredDuringInsert: false,
      $customConstraints: 'UNIQUE');
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
  final VerificationMeta _fragmentIdMeta = const VerificationMeta('fragmentId');
  @override
  late final GeneratedColumn<int?> fragmentId = GeneratedColumn<int?>(
      'fragment_id', aliasedName, true,
      type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _fragmentCloudIdMeta =
      const VerificationMeta('fragmentCloudId');
  @override
  late final GeneratedColumn<int?> fragmentCloudId = GeneratedColumn<int?>(
      'fragment_cloud_id', aliasedName, true,
      type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _naturalFamiliarityMeta =
      const VerificationMeta('naturalFamiliarity');
  @override
  late final GeneratedColumn<int?> naturalFamiliarity = GeneratedColumn<int?>(
      'natural_familiarity', aliasedName, false,
      check: () =>
          naturalFamiliarity.isBetween(const Constant(0), const Constant(100)),
      type: const IntType(),
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  final VerificationMeta _explicitFamiliarityMeta =
      const VerificationMeta('explicitFamiliarity');
  @override
  late final GeneratedColumn<int?> explicitFamiliarity = GeneratedColumn<int?>(
      'explicit_familiarity', aliasedName, false,
      check: () =>
          explicitFamiliarity.isBetween(const Constant(0), const Constant(100)),
      type: const IntType(),
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  final VerificationMeta _showDurationMeta =
      const VerificationMeta('showDuration');
  @override
  late final GeneratedColumn<int?> showDuration = GeneratedColumn<int?>(
      'show_duration', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns => [
        cloudId,
        id,
        createdAt,
        updatedAt,
        fragmentId,
        fragmentCloudId,
        naturalFamiliarity,
        explicitFamiliarity,
        showDuration
      ];
  @override
  String get aliasedName => _alias ?? 'fragment_permanent_memory_infos';
  @override
  String get actualTableName => 'fragment_permanent_memory_infos';
  @override
  VerificationContext validateIntegrity(
      Insertable<FragmentPermanentMemoryInfo> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('cloud_id')) {
      context.handle(_cloudIdMeta,
          cloudId.isAcceptableOrUnknown(data['cloud_id']!, _cloudIdMeta));
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
    if (data.containsKey('fragment_id')) {
      context.handle(
          _fragmentIdMeta,
          fragmentId.isAcceptableOrUnknown(
              data['fragment_id']!, _fragmentIdMeta));
    }
    if (data.containsKey('fragment_cloud_id')) {
      context.handle(
          _fragmentCloudIdMeta,
          fragmentCloudId.isAcceptableOrUnknown(
              data['fragment_cloud_id']!, _fragmentCloudIdMeta));
    }
    if (data.containsKey('natural_familiarity')) {
      context.handle(
          _naturalFamiliarityMeta,
          naturalFamiliarity.isAcceptableOrUnknown(
              data['natural_familiarity']!, _naturalFamiliarityMeta));
    }
    if (data.containsKey('explicit_familiarity')) {
      context.handle(
          _explicitFamiliarityMeta,
          explicitFamiliarity.isAcceptableOrUnknown(
              data['explicit_familiarity']!, _explicitFamiliarityMeta));
    }
    if (data.containsKey('show_duration')) {
      context.handle(
          _showDurationMeta,
          showDuration.isAcceptableOrUnknown(
              data['show_duration']!, _showDurationMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FragmentPermanentMemoryInfo map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    return FragmentPermanentMemoryInfo.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $FragmentPermanentMemoryInfosTable createAlias(String alias) {
    return $FragmentPermanentMemoryInfosTable(attachedDatabase, alias);
  }
}

class FragmentTemporaryMemoryInfo2Data extends DataClass
    implements Insertable<FragmentTemporaryMemoryInfo2Data> {
  int? cloudId;
  int id;

  /// 必须是本地时间，因为用户是在本地被创建、修改。
  /// *** 需要预防客户端时间篡改
  DateTime createdAt;

  /// 必须是本地时间，因为用户是在本地被创建、修改。
  /// *** 需要预防客户端时间篡改
  DateTime updatedAt;
  int? fragmentId;
  int? fragmentCloudId;
  int? memoryGroupId;
  int? memoryGroupCloudId;

  /// 下一次展示的时间点。
  ///
  /// 为 null 表示在当前记忆组时的当前碎片为新碎片。
  ///
  /// 为 1970 年 1 月 1 日 00:00 分（时间戳为0）表示在当前记忆组时的当前碎片已经完成任务。
  DateTime? nextShowTime;
  FragmentTemporaryMemoryInfo2Data(
      {this.cloudId,
      required this.id,
      required this.createdAt,
      required this.updatedAt,
      this.fragmentId,
      this.fragmentCloudId,
      this.memoryGroupId,
      this.memoryGroupCloudId,
      this.nextShowTime});
  factory FragmentTemporaryMemoryInfo2Data.fromData(Map<String, dynamic> data,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return FragmentTemporaryMemoryInfo2Data(
      cloudId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}cloud_id']),
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      createdAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at'])!,
      updatedAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}updated_at'])!,
      fragmentId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}fragment_id']),
      fragmentCloudId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}fragment_cloud_id']),
      memoryGroupId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}memory_group_id']),
      memoryGroupCloudId: const IntType().mapFromDatabaseResponse(
          data['${effectivePrefix}memory_group_cloud_id']),
      nextShowTime: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}next_show_time']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || cloudId != null) {
      map['cloud_id'] = Variable<int?>(cloudId);
    }
    map['id'] = Variable<int>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || fragmentId != null) {
      map['fragment_id'] = Variable<int?>(fragmentId);
    }
    if (!nullToAbsent || fragmentCloudId != null) {
      map['fragment_cloud_id'] = Variable<int?>(fragmentCloudId);
    }
    if (!nullToAbsent || memoryGroupId != null) {
      map['memory_group_id'] = Variable<int?>(memoryGroupId);
    }
    if (!nullToAbsent || memoryGroupCloudId != null) {
      map['memory_group_cloud_id'] = Variable<int?>(memoryGroupCloudId);
    }
    if (!nullToAbsent || nextShowTime != null) {
      map['next_show_time'] = Variable<DateTime?>(nextShowTime);
    }
    return map;
  }

  FragmentTemporaryMemoryInfo2Companion toCompanion(bool nullToAbsent) {
    return FragmentTemporaryMemoryInfo2Companion(
      cloudId: cloudId == null && nullToAbsent
          ? const Value.absent()
          : Value(cloudId),
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      fragmentId: fragmentId == null && nullToAbsent
          ? const Value.absent()
          : Value(fragmentId),
      fragmentCloudId: fragmentCloudId == null && nullToAbsent
          ? const Value.absent()
          : Value(fragmentCloudId),
      memoryGroupId: memoryGroupId == null && nullToAbsent
          ? const Value.absent()
          : Value(memoryGroupId),
      memoryGroupCloudId: memoryGroupCloudId == null && nullToAbsent
          ? const Value.absent()
          : Value(memoryGroupCloudId),
      nextShowTime: nextShowTime == null && nullToAbsent
          ? const Value.absent()
          : Value(nextShowTime),
    );
  }

  factory FragmentTemporaryMemoryInfo2Data.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FragmentTemporaryMemoryInfo2Data(
      cloudId: serializer.fromJson<int?>(json['cloudId']),
      id: serializer.fromJson<int>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      fragmentId: serializer.fromJson<int?>(json['fragmentId']),
      fragmentCloudId: serializer.fromJson<int?>(json['fragmentCloudId']),
      memoryGroupId: serializer.fromJson<int?>(json['memoryGroupId']),
      memoryGroupCloudId: serializer.fromJson<int?>(json['memoryGroupCloudId']),
      nextShowTime: serializer.fromJson<DateTime?>(json['nextShowTime']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'cloudId': serializer.toJson<int?>(cloudId),
      'id': serializer.toJson<int>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'fragmentId': serializer.toJson<int?>(fragmentId),
      'fragmentCloudId': serializer.toJson<int?>(fragmentCloudId),
      'memoryGroupId': serializer.toJson<int?>(memoryGroupId),
      'memoryGroupCloudId': serializer.toJson<int?>(memoryGroupCloudId),
      'nextShowTime': serializer.toJson<DateTime?>(nextShowTime),
    };
  }

  FragmentTemporaryMemoryInfo2Data copyWith(
          {int? cloudId,
          int? id,
          DateTime? createdAt,
          DateTime? updatedAt,
          int? fragmentId,
          int? fragmentCloudId,
          int? memoryGroupId,
          int? memoryGroupCloudId,
          DateTime? nextShowTime}) =>
      FragmentTemporaryMemoryInfo2Data(
        cloudId: cloudId ?? this.cloudId,
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        fragmentId: fragmentId ?? this.fragmentId,
        fragmentCloudId: fragmentCloudId ?? this.fragmentCloudId,
        memoryGroupId: memoryGroupId ?? this.memoryGroupId,
        memoryGroupCloudId: memoryGroupCloudId ?? this.memoryGroupCloudId,
        nextShowTime: nextShowTime ?? this.nextShowTime,
      );
  @override
  String toString() {
    return (StringBuffer('FragmentTemporaryMemoryInfo2Data(')
          ..write('cloudId: $cloudId, ')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('fragmentId: $fragmentId, ')
          ..write('fragmentCloudId: $fragmentCloudId, ')
          ..write('memoryGroupId: $memoryGroupId, ')
          ..write('memoryGroupCloudId: $memoryGroupCloudId, ')
          ..write('nextShowTime: $nextShowTime')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(cloudId, id, createdAt, updatedAt, fragmentId,
      fragmentCloudId, memoryGroupId, memoryGroupCloudId, nextShowTime);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FragmentTemporaryMemoryInfo2Data &&
          other.cloudId == this.cloudId &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.fragmentId == this.fragmentId &&
          other.fragmentCloudId == this.fragmentCloudId &&
          other.memoryGroupId == this.memoryGroupId &&
          other.memoryGroupCloudId == this.memoryGroupCloudId &&
          other.nextShowTime == this.nextShowTime);
}

class FragmentTemporaryMemoryInfo2Companion
    extends UpdateCompanion<FragmentTemporaryMemoryInfo2Data> {
  Value<int?> cloudId;
  Value<int> id;
  Value<DateTime> createdAt;
  Value<DateTime> updatedAt;
  Value<int?> fragmentId;
  Value<int?> fragmentCloudId;
  Value<int?> memoryGroupId;
  Value<int?> memoryGroupCloudId;
  Value<DateTime?> nextShowTime;
  FragmentTemporaryMemoryInfo2Companion({
    this.cloudId = const Value.absent(),
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.fragmentId = const Value.absent(),
    this.fragmentCloudId = const Value.absent(),
    this.memoryGroupId = const Value.absent(),
    this.memoryGroupCloudId = const Value.absent(),
    this.nextShowTime = const Value.absent(),
  });
  FragmentTemporaryMemoryInfo2Companion.insert({
    this.cloudId = const Value.absent(),
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.fragmentId = const Value.absent(),
    this.fragmentCloudId = const Value.absent(),
    this.memoryGroupId = const Value.absent(),
    this.memoryGroupCloudId = const Value.absent(),
    this.nextShowTime = const Value.absent(),
  });
  static Insertable<FragmentTemporaryMemoryInfo2Data> custom({
    Expression<int?>? cloudId,
    Expression<int>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int?>? fragmentId,
    Expression<int?>? fragmentCloudId,
    Expression<int?>? memoryGroupId,
    Expression<int?>? memoryGroupCloudId,
    Expression<DateTime?>? nextShowTime,
  }) {
    return RawValuesInsertable({
      if (cloudId != null) 'cloud_id': cloudId,
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (fragmentId != null) 'fragment_id': fragmentId,
      if (fragmentCloudId != null) 'fragment_cloud_id': fragmentCloudId,
      if (memoryGroupId != null) 'memory_group_id': memoryGroupId,
      if (memoryGroupCloudId != null)
        'memory_group_cloud_id': memoryGroupCloudId,
      if (nextShowTime != null) 'next_show_time': nextShowTime,
    });
  }

  FragmentTemporaryMemoryInfo2Companion copyWith(
      {Value<int?>? cloudId,
      Value<int>? id,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int?>? fragmentId,
      Value<int?>? fragmentCloudId,
      Value<int?>? memoryGroupId,
      Value<int?>? memoryGroupCloudId,
      Value<DateTime?>? nextShowTime}) {
    return FragmentTemporaryMemoryInfo2Companion(
      cloudId: cloudId ?? this.cloudId,
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      fragmentId: fragmentId ?? this.fragmentId,
      fragmentCloudId: fragmentCloudId ?? this.fragmentCloudId,
      memoryGroupId: memoryGroupId ?? this.memoryGroupId,
      memoryGroupCloudId: memoryGroupCloudId ?? this.memoryGroupCloudId,
      nextShowTime: nextShowTime ?? this.nextShowTime,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (cloudId.present) {
      map['cloud_id'] = Variable<int?>(cloudId.value);
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
    if (fragmentId.present) {
      map['fragment_id'] = Variable<int?>(fragmentId.value);
    }
    if (fragmentCloudId.present) {
      map['fragment_cloud_id'] = Variable<int?>(fragmentCloudId.value);
    }
    if (memoryGroupId.present) {
      map['memory_group_id'] = Variable<int?>(memoryGroupId.value);
    }
    if (memoryGroupCloudId.present) {
      map['memory_group_cloud_id'] = Variable<int?>(memoryGroupCloudId.value);
    }
    if (nextShowTime.present) {
      map['next_show_time'] = Variable<DateTime?>(nextShowTime.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FragmentTemporaryMemoryInfo2Companion(')
          ..write('cloudId: $cloudId, ')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('fragmentId: $fragmentId, ')
          ..write('fragmentCloudId: $fragmentCloudId, ')
          ..write('memoryGroupId: $memoryGroupId, ')
          ..write('memoryGroupCloudId: $memoryGroupCloudId, ')
          ..write('nextShowTime: $nextShowTime')
          ..write(')'))
        .toString();
  }
}

class $FragmentTemporaryMemoryInfo2Table extends FragmentTemporaryMemoryInfo2
    with
        TableInfo<$FragmentTemporaryMemoryInfo2Table,
            FragmentTemporaryMemoryInfo2Data> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FragmentTemporaryMemoryInfo2Table(this.attachedDatabase, [this._alias]);
  final VerificationMeta _cloudIdMeta = const VerificationMeta('cloudId');
  @override
  late final GeneratedColumn<int?> cloudId = GeneratedColumn<int?>(
      'cloud_id', aliasedName, true,
      type: const IntType(),
      requiredDuringInsert: false,
      $customConstraints: 'UNIQUE');
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
  final VerificationMeta _fragmentIdMeta = const VerificationMeta('fragmentId');
  @override
  late final GeneratedColumn<int?> fragmentId = GeneratedColumn<int?>(
      'fragment_id', aliasedName, true,
      type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _fragmentCloudIdMeta =
      const VerificationMeta('fragmentCloudId');
  @override
  late final GeneratedColumn<int?> fragmentCloudId = GeneratedColumn<int?>(
      'fragment_cloud_id', aliasedName, true,
      type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _memoryGroupIdMeta =
      const VerificationMeta('memoryGroupId');
  @override
  late final GeneratedColumn<int?> memoryGroupId = GeneratedColumn<int?>(
      'memory_group_id', aliasedName, true,
      type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _memoryGroupCloudIdMeta =
      const VerificationMeta('memoryGroupCloudId');
  @override
  late final GeneratedColumn<int?> memoryGroupCloudId = GeneratedColumn<int?>(
      'memory_group_cloud_id', aliasedName, true,
      type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _nextShowTimeMeta =
      const VerificationMeta('nextShowTime');
  @override
  late final GeneratedColumn<DateTime?> nextShowTime =
      GeneratedColumn<DateTime?>('next_show_time', aliasedName, true,
          type: const IntType(), requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        cloudId,
        id,
        createdAt,
        updatedAt,
        fragmentId,
        fragmentCloudId,
        memoryGroupId,
        memoryGroupCloudId,
        nextShowTime
      ];
  @override
  String get aliasedName => _alias ?? 'fragment_temporary_memory_info2';
  @override
  String get actualTableName => 'fragment_temporary_memory_info2';
  @override
  VerificationContext validateIntegrity(
      Insertable<FragmentTemporaryMemoryInfo2Data> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('cloud_id')) {
      context.handle(_cloudIdMeta,
          cloudId.isAcceptableOrUnknown(data['cloud_id']!, _cloudIdMeta));
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
    if (data.containsKey('fragment_id')) {
      context.handle(
          _fragmentIdMeta,
          fragmentId.isAcceptableOrUnknown(
              data['fragment_id']!, _fragmentIdMeta));
    }
    if (data.containsKey('fragment_cloud_id')) {
      context.handle(
          _fragmentCloudIdMeta,
          fragmentCloudId.isAcceptableOrUnknown(
              data['fragment_cloud_id']!, _fragmentCloudIdMeta));
    }
    if (data.containsKey('memory_group_id')) {
      context.handle(
          _memoryGroupIdMeta,
          memoryGroupId.isAcceptableOrUnknown(
              data['memory_group_id']!, _memoryGroupIdMeta));
    }
    if (data.containsKey('memory_group_cloud_id')) {
      context.handle(
          _memoryGroupCloudIdMeta,
          memoryGroupCloudId.isAcceptableOrUnknown(
              data['memory_group_cloud_id']!, _memoryGroupCloudIdMeta));
    }
    if (data.containsKey('next_show_time')) {
      context.handle(
          _nextShowTimeMeta,
          nextShowTime.isAcceptableOrUnknown(
              data['next_show_time']!, _nextShowTimeMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FragmentTemporaryMemoryInfo2Data map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    return FragmentTemporaryMemoryInfo2Data.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $FragmentTemporaryMemoryInfo2Table createAlias(String alias) {
    return $FragmentTemporaryMemoryInfo2Table(attachedDatabase, alias);
  }
}

class RFragment2FragmentGroup extends DataClass
    implements Insertable<RFragment2FragmentGroup> {
  int? sonId;
  int? sonCloudId;
  int? fatherId;
  int? fatherCloudId;
  int? cloudId;
  int id;

  /// 必须是本地时间，因为用户是在本地被创建、修改。
  /// *** 需要预防客户端时间篡改
  DateTime createdAt;

  /// 必须是本地时间，因为用户是在本地被创建、修改。
  /// *** 需要预防客户端时间篡改
  DateTime updatedAt;
  RFragment2FragmentGroup(
      {this.sonId,
      this.sonCloudId,
      this.fatherId,
      this.fatherCloudId,
      this.cloudId,
      required this.id,
      required this.createdAt,
      required this.updatedAt});
  factory RFragment2FragmentGroup.fromData(Map<String, dynamic> data,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return RFragment2FragmentGroup(
      sonId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}son_id']),
      sonCloudId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}son_cloud_id']),
      fatherId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}father_id']),
      fatherCloudId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}father_cloud_id']),
      cloudId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}cloud_id']),
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      createdAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at'])!,
      updatedAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}updated_at'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || sonId != null) {
      map['son_id'] = Variable<int?>(sonId);
    }
    if (!nullToAbsent || sonCloudId != null) {
      map['son_cloud_id'] = Variable<int?>(sonCloudId);
    }
    if (!nullToAbsent || fatherId != null) {
      map['father_id'] = Variable<int?>(fatherId);
    }
    if (!nullToAbsent || fatherCloudId != null) {
      map['father_cloud_id'] = Variable<int?>(fatherCloudId);
    }
    if (!nullToAbsent || cloudId != null) {
      map['cloud_id'] = Variable<int?>(cloudId);
    }
    map['id'] = Variable<int>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  RFragment2FragmentGroupsCompanion toCompanion(bool nullToAbsent) {
    return RFragment2FragmentGroupsCompanion(
      sonId:
          sonId == null && nullToAbsent ? const Value.absent() : Value(sonId),
      sonCloudId: sonCloudId == null && nullToAbsent
          ? const Value.absent()
          : Value(sonCloudId),
      fatherId: fatherId == null && nullToAbsent
          ? const Value.absent()
          : Value(fatherId),
      fatherCloudId: fatherCloudId == null && nullToAbsent
          ? const Value.absent()
          : Value(fatherCloudId),
      cloudId: cloudId == null && nullToAbsent
          ? const Value.absent()
          : Value(cloudId),
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory RFragment2FragmentGroup.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RFragment2FragmentGroup(
      sonId: serializer.fromJson<int?>(json['sonId']),
      sonCloudId: serializer.fromJson<int?>(json['sonCloudId']),
      fatherId: serializer.fromJson<int?>(json['fatherId']),
      fatherCloudId: serializer.fromJson<int?>(json['fatherCloudId']),
      cloudId: serializer.fromJson<int?>(json['cloudId']),
      id: serializer.fromJson<int>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'sonId': serializer.toJson<int?>(sonId),
      'sonCloudId': serializer.toJson<int?>(sonCloudId),
      'fatherId': serializer.toJson<int?>(fatherId),
      'fatherCloudId': serializer.toJson<int?>(fatherCloudId),
      'cloudId': serializer.toJson<int?>(cloudId),
      'id': serializer.toJson<int>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  RFragment2FragmentGroup copyWith(
          {int? sonId,
          int? sonCloudId,
          int? fatherId,
          int? fatherCloudId,
          int? cloudId,
          int? id,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      RFragment2FragmentGroup(
        sonId: sonId ?? this.sonId,
        sonCloudId: sonCloudId ?? this.sonCloudId,
        fatherId: fatherId ?? this.fatherId,
        fatherCloudId: fatherCloudId ?? this.fatherCloudId,
        cloudId: cloudId ?? this.cloudId,
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  @override
  String toString() {
    return (StringBuffer('RFragment2FragmentGroup(')
          ..write('sonId: $sonId, ')
          ..write('sonCloudId: $sonCloudId, ')
          ..write('fatherId: $fatherId, ')
          ..write('fatherCloudId: $fatherCloudId, ')
          ..write('cloudId: $cloudId, ')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(sonId, sonCloudId, fatherId, fatherCloudId,
      cloudId, id, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RFragment2FragmentGroup &&
          other.sonId == this.sonId &&
          other.sonCloudId == this.sonCloudId &&
          other.fatherId == this.fatherId &&
          other.fatherCloudId == this.fatherCloudId &&
          other.cloudId == this.cloudId &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class RFragment2FragmentGroupsCompanion
    extends UpdateCompanion<RFragment2FragmentGroup> {
  Value<int?> sonId;
  Value<int?> sonCloudId;
  Value<int?> fatherId;
  Value<int?> fatherCloudId;
  Value<int?> cloudId;
  Value<int> id;
  Value<DateTime> createdAt;
  Value<DateTime> updatedAt;
  RFragment2FragmentGroupsCompanion({
    this.sonId = const Value.absent(),
    this.sonCloudId = const Value.absent(),
    this.fatherId = const Value.absent(),
    this.fatherCloudId = const Value.absent(),
    this.cloudId = const Value.absent(),
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  RFragment2FragmentGroupsCompanion.insert({
    this.sonId = const Value.absent(),
    this.sonCloudId = const Value.absent(),
    this.fatherId = const Value.absent(),
    this.fatherCloudId = const Value.absent(),
    this.cloudId = const Value.absent(),
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  static Insertable<RFragment2FragmentGroup> custom({
    Expression<int?>? sonId,
    Expression<int?>? sonCloudId,
    Expression<int?>? fatherId,
    Expression<int?>? fatherCloudId,
    Expression<int?>? cloudId,
    Expression<int>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (sonId != null) 'son_id': sonId,
      if (sonCloudId != null) 'son_cloud_id': sonCloudId,
      if (fatherId != null) 'father_id': fatherId,
      if (fatherCloudId != null) 'father_cloud_id': fatherCloudId,
      if (cloudId != null) 'cloud_id': cloudId,
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  RFragment2FragmentGroupsCompanion copyWith(
      {Value<int?>? sonId,
      Value<int?>? sonCloudId,
      Value<int?>? fatherId,
      Value<int?>? fatherCloudId,
      Value<int?>? cloudId,
      Value<int>? id,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return RFragment2FragmentGroupsCompanion(
      sonId: sonId ?? this.sonId,
      sonCloudId: sonCloudId ?? this.sonCloudId,
      fatherId: fatherId ?? this.fatherId,
      fatherCloudId: fatherCloudId ?? this.fatherCloudId,
      cloudId: cloudId ?? this.cloudId,
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (sonId.present) {
      map['son_id'] = Variable<int?>(sonId.value);
    }
    if (sonCloudId.present) {
      map['son_cloud_id'] = Variable<int?>(sonCloudId.value);
    }
    if (fatherId.present) {
      map['father_id'] = Variable<int?>(fatherId.value);
    }
    if (fatherCloudId.present) {
      map['father_cloud_id'] = Variable<int?>(fatherCloudId.value);
    }
    if (cloudId.present) {
      map['cloud_id'] = Variable<int?>(cloudId.value);
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
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RFragment2FragmentGroupsCompanion(')
          ..write('sonId: $sonId, ')
          ..write('sonCloudId: $sonCloudId, ')
          ..write('fatherId: $fatherId, ')
          ..write('fatherCloudId: $fatherCloudId, ')
          ..write('cloudId: $cloudId, ')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $RFragment2FragmentGroupsTable extends RFragment2FragmentGroups
    with TableInfo<$RFragment2FragmentGroupsTable, RFragment2FragmentGroup> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RFragment2FragmentGroupsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _sonIdMeta = const VerificationMeta('sonId');
  @override
  late final GeneratedColumn<int?> sonId = GeneratedColumn<int?>(
      'son_id', aliasedName, true,
      type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _sonCloudIdMeta = const VerificationMeta('sonCloudId');
  @override
  late final GeneratedColumn<int?> sonCloudId = GeneratedColumn<int?>(
      'son_cloud_id', aliasedName, true,
      type: const IntType(), requiredDuringInsert: false);
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
  final VerificationMeta _cloudIdMeta = const VerificationMeta('cloudId');
  @override
  late final GeneratedColumn<int?> cloudId = GeneratedColumn<int?>(
      'cloud_id', aliasedName, true,
      type: const IntType(),
      requiredDuringInsert: false,
      $customConstraints: 'UNIQUE');
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
  @override
  List<GeneratedColumn> get $columns => [
        sonId,
        sonCloudId,
        fatherId,
        fatherCloudId,
        cloudId,
        id,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? 'r_fragment2_fragment_groups';
  @override
  String get actualTableName => 'r_fragment2_fragment_groups';
  @override
  VerificationContext validateIntegrity(
      Insertable<RFragment2FragmentGroup> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('son_id')) {
      context.handle(
          _sonIdMeta, sonId.isAcceptableOrUnknown(data['son_id']!, _sonIdMeta));
    }
    if (data.containsKey('son_cloud_id')) {
      context.handle(
          _sonCloudIdMeta,
          sonCloudId.isAcceptableOrUnknown(
              data['son_cloud_id']!, _sonCloudIdMeta));
    }
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
    if (data.containsKey('cloud_id')) {
      context.handle(_cloudIdMeta,
          cloudId.isAcceptableOrUnknown(data['cloud_id']!, _cloudIdMeta));
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
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RFragment2FragmentGroup map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    return RFragment2FragmentGroup.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $RFragment2FragmentGroupsTable createAlias(String alias) {
    return $RFragment2FragmentGroupsTable(attachedDatabase, alias);
  }
}

class RFragment2MemoryGroup extends DataClass
    implements Insertable<RFragment2MemoryGroup> {
  int? sonId;
  int? sonCloudId;
  int? fatherId;
  int? fatherCloudId;
  int? cloudId;
  int id;

  /// 必须是本地时间，因为用户是在本地被创建、修改。
  /// *** 需要预防客户端时间篡改
  DateTime createdAt;

  /// 必须是本地时间，因为用户是在本地被创建、修改。
  /// *** 需要预防客户端时间篡改
  DateTime updatedAt;
  RFragment2MemoryGroup(
      {this.sonId,
      this.sonCloudId,
      this.fatherId,
      this.fatherCloudId,
      this.cloudId,
      required this.id,
      required this.createdAt,
      required this.updatedAt});
  factory RFragment2MemoryGroup.fromData(Map<String, dynamic> data,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return RFragment2MemoryGroup(
      sonId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}son_id']),
      sonCloudId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}son_cloud_id']),
      fatherId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}father_id']),
      fatherCloudId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}father_cloud_id']),
      cloudId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}cloud_id']),
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      createdAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at'])!,
      updatedAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}updated_at'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || sonId != null) {
      map['son_id'] = Variable<int?>(sonId);
    }
    if (!nullToAbsent || sonCloudId != null) {
      map['son_cloud_id'] = Variable<int?>(sonCloudId);
    }
    if (!nullToAbsent || fatherId != null) {
      map['father_id'] = Variable<int?>(fatherId);
    }
    if (!nullToAbsent || fatherCloudId != null) {
      map['father_cloud_id'] = Variable<int?>(fatherCloudId);
    }
    if (!nullToAbsent || cloudId != null) {
      map['cloud_id'] = Variable<int?>(cloudId);
    }
    map['id'] = Variable<int>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  RFragment2MemoryGroupsCompanion toCompanion(bool nullToAbsent) {
    return RFragment2MemoryGroupsCompanion(
      sonId:
          sonId == null && nullToAbsent ? const Value.absent() : Value(sonId),
      sonCloudId: sonCloudId == null && nullToAbsent
          ? const Value.absent()
          : Value(sonCloudId),
      fatherId: fatherId == null && nullToAbsent
          ? const Value.absent()
          : Value(fatherId),
      fatherCloudId: fatherCloudId == null && nullToAbsent
          ? const Value.absent()
          : Value(fatherCloudId),
      cloudId: cloudId == null && nullToAbsent
          ? const Value.absent()
          : Value(cloudId),
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory RFragment2MemoryGroup.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RFragment2MemoryGroup(
      sonId: serializer.fromJson<int?>(json['sonId']),
      sonCloudId: serializer.fromJson<int?>(json['sonCloudId']),
      fatherId: serializer.fromJson<int?>(json['fatherId']),
      fatherCloudId: serializer.fromJson<int?>(json['fatherCloudId']),
      cloudId: serializer.fromJson<int?>(json['cloudId']),
      id: serializer.fromJson<int>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'sonId': serializer.toJson<int?>(sonId),
      'sonCloudId': serializer.toJson<int?>(sonCloudId),
      'fatherId': serializer.toJson<int?>(fatherId),
      'fatherCloudId': serializer.toJson<int?>(fatherCloudId),
      'cloudId': serializer.toJson<int?>(cloudId),
      'id': serializer.toJson<int>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  RFragment2MemoryGroup copyWith(
          {int? sonId,
          int? sonCloudId,
          int? fatherId,
          int? fatherCloudId,
          int? cloudId,
          int? id,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      RFragment2MemoryGroup(
        sonId: sonId ?? this.sonId,
        sonCloudId: sonCloudId ?? this.sonCloudId,
        fatherId: fatherId ?? this.fatherId,
        fatherCloudId: fatherCloudId ?? this.fatherCloudId,
        cloudId: cloudId ?? this.cloudId,
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  @override
  String toString() {
    return (StringBuffer('RFragment2MemoryGroup(')
          ..write('sonId: $sonId, ')
          ..write('sonCloudId: $sonCloudId, ')
          ..write('fatherId: $fatherId, ')
          ..write('fatherCloudId: $fatherCloudId, ')
          ..write('cloudId: $cloudId, ')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(sonId, sonCloudId, fatherId, fatherCloudId,
      cloudId, id, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RFragment2MemoryGroup &&
          other.sonId == this.sonId &&
          other.sonCloudId == this.sonCloudId &&
          other.fatherId == this.fatherId &&
          other.fatherCloudId == this.fatherCloudId &&
          other.cloudId == this.cloudId &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class RFragment2MemoryGroupsCompanion
    extends UpdateCompanion<RFragment2MemoryGroup> {
  Value<int?> sonId;
  Value<int?> sonCloudId;
  Value<int?> fatherId;
  Value<int?> fatherCloudId;
  Value<int?> cloudId;
  Value<int> id;
  Value<DateTime> createdAt;
  Value<DateTime> updatedAt;
  RFragment2MemoryGroupsCompanion({
    this.sonId = const Value.absent(),
    this.sonCloudId = const Value.absent(),
    this.fatherId = const Value.absent(),
    this.fatherCloudId = const Value.absent(),
    this.cloudId = const Value.absent(),
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  RFragment2MemoryGroupsCompanion.insert({
    this.sonId = const Value.absent(),
    this.sonCloudId = const Value.absent(),
    this.fatherId = const Value.absent(),
    this.fatherCloudId = const Value.absent(),
    this.cloudId = const Value.absent(),
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  static Insertable<RFragment2MemoryGroup> custom({
    Expression<int?>? sonId,
    Expression<int?>? sonCloudId,
    Expression<int?>? fatherId,
    Expression<int?>? fatherCloudId,
    Expression<int?>? cloudId,
    Expression<int>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (sonId != null) 'son_id': sonId,
      if (sonCloudId != null) 'son_cloud_id': sonCloudId,
      if (fatherId != null) 'father_id': fatherId,
      if (fatherCloudId != null) 'father_cloud_id': fatherCloudId,
      if (cloudId != null) 'cloud_id': cloudId,
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  RFragment2MemoryGroupsCompanion copyWith(
      {Value<int?>? sonId,
      Value<int?>? sonCloudId,
      Value<int?>? fatherId,
      Value<int?>? fatherCloudId,
      Value<int?>? cloudId,
      Value<int>? id,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return RFragment2MemoryGroupsCompanion(
      sonId: sonId ?? this.sonId,
      sonCloudId: sonCloudId ?? this.sonCloudId,
      fatherId: fatherId ?? this.fatherId,
      fatherCloudId: fatherCloudId ?? this.fatherCloudId,
      cloudId: cloudId ?? this.cloudId,
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (sonId.present) {
      map['son_id'] = Variable<int?>(sonId.value);
    }
    if (sonCloudId.present) {
      map['son_cloud_id'] = Variable<int?>(sonCloudId.value);
    }
    if (fatherId.present) {
      map['father_id'] = Variable<int?>(fatherId.value);
    }
    if (fatherCloudId.present) {
      map['father_cloud_id'] = Variable<int?>(fatherCloudId.value);
    }
    if (cloudId.present) {
      map['cloud_id'] = Variable<int?>(cloudId.value);
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
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RFragment2MemoryGroupsCompanion(')
          ..write('sonId: $sonId, ')
          ..write('sonCloudId: $sonCloudId, ')
          ..write('fatherId: $fatherId, ')
          ..write('fatherCloudId: $fatherCloudId, ')
          ..write('cloudId: $cloudId, ')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $RFragment2MemoryGroupsTable extends RFragment2MemoryGroups
    with TableInfo<$RFragment2MemoryGroupsTable, RFragment2MemoryGroup> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RFragment2MemoryGroupsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _sonIdMeta = const VerificationMeta('sonId');
  @override
  late final GeneratedColumn<int?> sonId = GeneratedColumn<int?>(
      'son_id', aliasedName, true,
      type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _sonCloudIdMeta = const VerificationMeta('sonCloudId');
  @override
  late final GeneratedColumn<int?> sonCloudId = GeneratedColumn<int?>(
      'son_cloud_id', aliasedName, true,
      type: const IntType(), requiredDuringInsert: false);
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
  final VerificationMeta _cloudIdMeta = const VerificationMeta('cloudId');
  @override
  late final GeneratedColumn<int?> cloudId = GeneratedColumn<int?>(
      'cloud_id', aliasedName, true,
      type: const IntType(),
      requiredDuringInsert: false,
      $customConstraints: 'UNIQUE');
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
  @override
  List<GeneratedColumn> get $columns => [
        sonId,
        sonCloudId,
        fatherId,
        fatherCloudId,
        cloudId,
        id,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? 'r_fragment2_memory_groups';
  @override
  String get actualTableName => 'r_fragment2_memory_groups';
  @override
  VerificationContext validateIntegrity(
      Insertable<RFragment2MemoryGroup> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('son_id')) {
      context.handle(
          _sonIdMeta, sonId.isAcceptableOrUnknown(data['son_id']!, _sonIdMeta));
    }
    if (data.containsKey('son_cloud_id')) {
      context.handle(
          _sonCloudIdMeta,
          sonCloudId.isAcceptableOrUnknown(
              data['son_cloud_id']!, _sonCloudIdMeta));
    }
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
    if (data.containsKey('cloud_id')) {
      context.handle(_cloudIdMeta,
          cloudId.isAcceptableOrUnknown(data['cloud_id']!, _cloudIdMeta));
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
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RFragment2MemoryGroup map(Map<String, dynamic> data, {String? tablePrefix}) {
    return RFragment2MemoryGroup.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $RFragment2MemoryGroupsTable createAlias(String alias) {
    return $RFragment2MemoryGroupsTable(attachedDatabase, alias);
  }
}

class RMemoryModel2MemoryGroup extends DataClass
    implements Insertable<RMemoryModel2MemoryGroup> {
  int? sonId;
  int? sonCloudId;
  int? fatherId;
  int? fatherCloudId;
  int? cloudId;
  int id;

  /// 必须是本地时间，因为用户是在本地被创建、修改。
  /// *** 需要预防客户端时间篡改
  DateTime createdAt;

  /// 必须是本地时间，因为用户是在本地被创建、修改。
  /// *** 需要预防客户端时间篡改
  DateTime updatedAt;
  RMemoryModel2MemoryGroup(
      {this.sonId,
      this.sonCloudId,
      this.fatherId,
      this.fatherCloudId,
      this.cloudId,
      required this.id,
      required this.createdAt,
      required this.updatedAt});
  factory RMemoryModel2MemoryGroup.fromData(Map<String, dynamic> data,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return RMemoryModel2MemoryGroup(
      sonId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}son_id']),
      sonCloudId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}son_cloud_id']),
      fatherId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}father_id']),
      fatherCloudId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}father_cloud_id']),
      cloudId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}cloud_id']),
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      createdAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at'])!,
      updatedAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}updated_at'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || sonId != null) {
      map['son_id'] = Variable<int?>(sonId);
    }
    if (!nullToAbsent || sonCloudId != null) {
      map['son_cloud_id'] = Variable<int?>(sonCloudId);
    }
    if (!nullToAbsent || fatherId != null) {
      map['father_id'] = Variable<int?>(fatherId);
    }
    if (!nullToAbsent || fatherCloudId != null) {
      map['father_cloud_id'] = Variable<int?>(fatherCloudId);
    }
    if (!nullToAbsent || cloudId != null) {
      map['cloud_id'] = Variable<int?>(cloudId);
    }
    map['id'] = Variable<int>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  RMemoryModel2MemoryGroupsCompanion toCompanion(bool nullToAbsent) {
    return RMemoryModel2MemoryGroupsCompanion(
      sonId:
          sonId == null && nullToAbsent ? const Value.absent() : Value(sonId),
      sonCloudId: sonCloudId == null && nullToAbsent
          ? const Value.absent()
          : Value(sonCloudId),
      fatherId: fatherId == null && nullToAbsent
          ? const Value.absent()
          : Value(fatherId),
      fatherCloudId: fatherCloudId == null && nullToAbsent
          ? const Value.absent()
          : Value(fatherCloudId),
      cloudId: cloudId == null && nullToAbsent
          ? const Value.absent()
          : Value(cloudId),
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory RMemoryModel2MemoryGroup.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RMemoryModel2MemoryGroup(
      sonId: serializer.fromJson<int?>(json['sonId']),
      sonCloudId: serializer.fromJson<int?>(json['sonCloudId']),
      fatherId: serializer.fromJson<int?>(json['fatherId']),
      fatherCloudId: serializer.fromJson<int?>(json['fatherCloudId']),
      cloudId: serializer.fromJson<int?>(json['cloudId']),
      id: serializer.fromJson<int>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'sonId': serializer.toJson<int?>(sonId),
      'sonCloudId': serializer.toJson<int?>(sonCloudId),
      'fatherId': serializer.toJson<int?>(fatherId),
      'fatherCloudId': serializer.toJson<int?>(fatherCloudId),
      'cloudId': serializer.toJson<int?>(cloudId),
      'id': serializer.toJson<int>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  RMemoryModel2MemoryGroup copyWith(
          {int? sonId,
          int? sonCloudId,
          int? fatherId,
          int? fatherCloudId,
          int? cloudId,
          int? id,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      RMemoryModel2MemoryGroup(
        sonId: sonId ?? this.sonId,
        sonCloudId: sonCloudId ?? this.sonCloudId,
        fatherId: fatherId ?? this.fatherId,
        fatherCloudId: fatherCloudId ?? this.fatherCloudId,
        cloudId: cloudId ?? this.cloudId,
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  @override
  String toString() {
    return (StringBuffer('RMemoryModel2MemoryGroup(')
          ..write('sonId: $sonId, ')
          ..write('sonCloudId: $sonCloudId, ')
          ..write('fatherId: $fatherId, ')
          ..write('fatherCloudId: $fatherCloudId, ')
          ..write('cloudId: $cloudId, ')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(sonId, sonCloudId, fatherId, fatherCloudId,
      cloudId, id, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RMemoryModel2MemoryGroup &&
          other.sonId == this.sonId &&
          other.sonCloudId == this.sonCloudId &&
          other.fatherId == this.fatherId &&
          other.fatherCloudId == this.fatherCloudId &&
          other.cloudId == this.cloudId &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class RMemoryModel2MemoryGroupsCompanion
    extends UpdateCompanion<RMemoryModel2MemoryGroup> {
  Value<int?> sonId;
  Value<int?> sonCloudId;
  Value<int?> fatherId;
  Value<int?> fatherCloudId;
  Value<int?> cloudId;
  Value<int> id;
  Value<DateTime> createdAt;
  Value<DateTime> updatedAt;
  RMemoryModel2MemoryGroupsCompanion({
    this.sonId = const Value.absent(),
    this.sonCloudId = const Value.absent(),
    this.fatherId = const Value.absent(),
    this.fatherCloudId = const Value.absent(),
    this.cloudId = const Value.absent(),
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  RMemoryModel2MemoryGroupsCompanion.insert({
    this.sonId = const Value.absent(),
    this.sonCloudId = const Value.absent(),
    this.fatherId = const Value.absent(),
    this.fatherCloudId = const Value.absent(),
    this.cloudId = const Value.absent(),
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  static Insertable<RMemoryModel2MemoryGroup> custom({
    Expression<int?>? sonId,
    Expression<int?>? sonCloudId,
    Expression<int?>? fatherId,
    Expression<int?>? fatherCloudId,
    Expression<int?>? cloudId,
    Expression<int>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (sonId != null) 'son_id': sonId,
      if (sonCloudId != null) 'son_cloud_id': sonCloudId,
      if (fatherId != null) 'father_id': fatherId,
      if (fatherCloudId != null) 'father_cloud_id': fatherCloudId,
      if (cloudId != null) 'cloud_id': cloudId,
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  RMemoryModel2MemoryGroupsCompanion copyWith(
      {Value<int?>? sonId,
      Value<int?>? sonCloudId,
      Value<int?>? fatherId,
      Value<int?>? fatherCloudId,
      Value<int?>? cloudId,
      Value<int>? id,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return RMemoryModel2MemoryGroupsCompanion(
      sonId: sonId ?? this.sonId,
      sonCloudId: sonCloudId ?? this.sonCloudId,
      fatherId: fatherId ?? this.fatherId,
      fatherCloudId: fatherCloudId ?? this.fatherCloudId,
      cloudId: cloudId ?? this.cloudId,
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (sonId.present) {
      map['son_id'] = Variable<int?>(sonId.value);
    }
    if (sonCloudId.present) {
      map['son_cloud_id'] = Variable<int?>(sonCloudId.value);
    }
    if (fatherId.present) {
      map['father_id'] = Variable<int?>(fatherId.value);
    }
    if (fatherCloudId.present) {
      map['father_cloud_id'] = Variable<int?>(fatherCloudId.value);
    }
    if (cloudId.present) {
      map['cloud_id'] = Variable<int?>(cloudId.value);
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
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RMemoryModel2MemoryGroupsCompanion(')
          ..write('sonId: $sonId, ')
          ..write('sonCloudId: $sonCloudId, ')
          ..write('fatherId: $fatherId, ')
          ..write('fatherCloudId: $fatherCloudId, ')
          ..write('cloudId: $cloudId, ')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $RMemoryModel2MemoryGroupsTable extends RMemoryModel2MemoryGroups
    with TableInfo<$RMemoryModel2MemoryGroupsTable, RMemoryModel2MemoryGroup> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RMemoryModel2MemoryGroupsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _sonIdMeta = const VerificationMeta('sonId');
  @override
  late final GeneratedColumn<int?> sonId = GeneratedColumn<int?>(
      'son_id', aliasedName, true,
      type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _sonCloudIdMeta = const VerificationMeta('sonCloudId');
  @override
  late final GeneratedColumn<int?> sonCloudId = GeneratedColumn<int?>(
      'son_cloud_id', aliasedName, true,
      type: const IntType(), requiredDuringInsert: false);
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
  final VerificationMeta _cloudIdMeta = const VerificationMeta('cloudId');
  @override
  late final GeneratedColumn<int?> cloudId = GeneratedColumn<int?>(
      'cloud_id', aliasedName, true,
      type: const IntType(),
      requiredDuringInsert: false,
      $customConstraints: 'UNIQUE');
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
  @override
  List<GeneratedColumn> get $columns => [
        sonId,
        sonCloudId,
        fatherId,
        fatherCloudId,
        cloudId,
        id,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? 'r_memory_model2_memory_groups';
  @override
  String get actualTableName => 'r_memory_model2_memory_groups';
  @override
  VerificationContext validateIntegrity(
      Insertable<RMemoryModel2MemoryGroup> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('son_id')) {
      context.handle(
          _sonIdMeta, sonId.isAcceptableOrUnknown(data['son_id']!, _sonIdMeta));
    }
    if (data.containsKey('son_cloud_id')) {
      context.handle(
          _sonCloudIdMeta,
          sonCloudId.isAcceptableOrUnknown(
              data['son_cloud_id']!, _sonCloudIdMeta));
    }
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
    if (data.containsKey('cloud_id')) {
      context.handle(_cloudIdMeta,
          cloudId.isAcceptableOrUnknown(data['cloud_id']!, _cloudIdMeta));
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
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RMemoryModel2MemoryGroup map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    return RMemoryModel2MemoryGroup.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $RMemoryModel2MemoryGroupsTable createAlias(String alias) {
    return $RMemoryModel2MemoryGroupsTable(attachedDatabase, alias);
  }
}

class AppInfo extends DataClass implements Insertable<AppInfo> {
  int id;

  /// 必须是本地时间，因为用户是在本地被创建、修改。
  /// *** 需要预防客户端时间篡改
  DateTime createdAt;

  /// 必须是本地时间，因为用户是在本地被创建、修改。
  /// *** 需要预防客户端时间篡改
  DateTime updatedAt;
  String token;
  bool hasDownloadedInitData;
  AppInfo(
      {required this.id,
      required this.createdAt,
      required this.updatedAt,
      required this.token,
      required this.hasDownloadedInitData});
  factory AppInfo.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return AppInfo(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
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
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['token'] = Variable<String>(token);
    map['has_downloaded_init_data'] = Variable<bool>(hasDownloadedInitData);
    return map;
  }

  AppInfosCompanion toCompanion(bool nullToAbsent) {
    return AppInfosCompanion(
      id: Value(id),
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
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'token': serializer.toJson<String>(token),
      'hasDownloadedInitData': serializer.toJson<bool>(hasDownloadedInitData),
    };
  }

  AppInfo copyWith(
          {int? id,
          DateTime? createdAt,
          DateTime? updatedAt,
          String? token,
          bool? hasDownloadedInitData}) =>
      AppInfo(
        id: id ?? this.id,
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
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('token: $token, ')
          ..write('hasDownloadedInitData: $hasDownloadedInitData')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, createdAt, updatedAt, token, hasDownloadedInitData);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppInfo &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.token == this.token &&
          other.hasDownloadedInitData == this.hasDownloadedInitData);
}

class AppInfosCompanion extends UpdateCompanion<AppInfo> {
  Value<int> id;
  Value<DateTime> createdAt;
  Value<DateTime> updatedAt;
  Value<String> token;
  Value<bool> hasDownloadedInitData;
  AppInfosCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.token = const Value.absent(),
    this.hasDownloadedInitData = const Value.absent(),
  });
  AppInfosCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.token = const Value.absent(),
    this.hasDownloadedInitData = const Value.absent(),
  });
  static Insertable<AppInfo> custom({
    Expression<int>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? token,
    Expression<bool>? hasDownloadedInitData,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (token != null) 'token': token,
      if (hasDownloadedInitData != null)
        'has_downloaded_init_data': hasDownloadedInitData,
    });
  }

  AppInfosCompanion copyWith(
      {Value<int>? id,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<String>? token,
      Value<bool>? hasDownloadedInitData}) {
    return AppInfosCompanion(
      id: id ?? this.id,
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
      type: const StringType(),
      requiredDuringInsert: false,
      defaultValue: const Constant('unknown'));
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
  List<GeneratedColumn> get $columns =>
      [id, createdAt, updatedAt, token, hasDownloadedInitData];
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
}

class Sync extends DataClass implements Insertable<Sync> {
  int id;

  /// 必须是本地时间，因为用户是在本地被创建、修改。
  /// *** 需要预防客户端时间篡改
  DateTime createdAt;

  /// 必须是本地时间，因为用户是在本地被创建、修改。
  /// *** 需要预防客户端时间篡改
  DateTime updatedAt;
  String syncTableName;
  int rowId;

  /// 若 [syncCurdType] 为 [SyncCurdType.d]，则会根据 [rowCloudId] 来进行同步删除：
  ///   - [rowCloudId] 为空时，则无需同步，直接本地删除。
  ///   - [rowCloudId] 不为空时，则需根据该 id 进行同步删除。
  int? rowCloudId;
  SyncCurdType? syncCurdType;

  /// 当为 [SyncCurdType.u] 时，[syncUpdateColumns] 不能为空。
  ///
  /// 值为字段名，如：'username,password'(字段名不能带有空格或英文逗号)
  String? syncUpdateColumns;

  /// 成组标识符。
  ///
  /// 仅对 [CloudTableBase] 的子类表生效,
  /// 当多行 sync 是由同一事务或类似事务性的操作时, 需要对这些行设置相同的 tag。
  /// 当进行上传时, 会将具有相同 tag 的行, 组成一组进行上传。
  ///
  /// tag 具有唯一性(使用 uuid).
  ///
  /// 同表同 id：
  ///   - 不能设置相同的 tag,否则进行云同步时, 无法识别其晚者的 cloudId (因为晚者可能没有设置过 cloudId),
  ///   - 例如: 若两行同表同 id 的 sync 具有相同的 tag, 则会组成同一组被上传, 第一行为 c, 第二行为 u, 第一行在云端会生成 cloudId, 但是第二行并没有设置过 cloudId, 导致第二行没法被上传成功.
  String tag;
  Sync(
      {required this.id,
      required this.createdAt,
      required this.updatedAt,
      required this.syncTableName,
      required this.rowId,
      this.rowCloudId,
      this.syncCurdType,
      this.syncUpdateColumns,
      required this.tag});
  factory Sync.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Sync(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      createdAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at'])!,
      updatedAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}updated_at'])!,
      syncTableName: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}sync_table_name'])!,
      rowId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}row_id'])!,
      rowCloudId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}row_cloud_id']),
      syncCurdType: $SyncsTable.$converter0.mapToDart(const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}sync_curd_type'])),
      syncUpdateColumns: const StringType().mapFromDatabaseResponse(
          data['${effectivePrefix}sync_update_columns']),
      tag: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}tag'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['sync_table_name'] = Variable<String>(syncTableName);
    map['row_id'] = Variable<int>(rowId);
    if (!nullToAbsent || rowCloudId != null) {
      map['row_cloud_id'] = Variable<int?>(rowCloudId);
    }
    if (!nullToAbsent || syncCurdType != null) {
      final converter = $SyncsTable.$converter0;
      map['sync_curd_type'] = Variable<int?>(converter.mapToSql(syncCurdType));
    }
    if (!nullToAbsent || syncUpdateColumns != null) {
      map['sync_update_columns'] = Variable<String?>(syncUpdateColumns);
    }
    map['tag'] = Variable<String>(tag);
    return map;
  }

  SyncsCompanion toCompanion(bool nullToAbsent) {
    return SyncsCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      syncTableName: Value(syncTableName),
      rowId: Value(rowId),
      rowCloudId: rowCloudId == null && nullToAbsent
          ? const Value.absent()
          : Value(rowCloudId),
      syncCurdType: syncCurdType == null && nullToAbsent
          ? const Value.absent()
          : Value(syncCurdType),
      syncUpdateColumns: syncUpdateColumns == null && nullToAbsent
          ? const Value.absent()
          : Value(syncUpdateColumns),
      tag: Value(tag),
    );
  }

  factory Sync.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Sync(
      id: serializer.fromJson<int>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      syncTableName: serializer.fromJson<String>(json['syncTableName']),
      rowId: serializer.fromJson<int>(json['rowId']),
      rowCloudId: serializer.fromJson<int?>(json['rowCloudId']),
      syncCurdType: serializer.fromJson<SyncCurdType?>(json['syncCurdType']),
      syncUpdateColumns:
          serializer.fromJson<String?>(json['syncUpdateColumns']),
      tag: serializer.fromJson<String>(json['tag']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'syncTableName': serializer.toJson<String>(syncTableName),
      'rowId': serializer.toJson<int>(rowId),
      'rowCloudId': serializer.toJson<int?>(rowCloudId),
      'syncCurdType': serializer.toJson<SyncCurdType?>(syncCurdType),
      'syncUpdateColumns': serializer.toJson<String?>(syncUpdateColumns),
      'tag': serializer.toJson<String>(tag),
    };
  }

  Sync copyWith(
          {int? id,
          DateTime? createdAt,
          DateTime? updatedAt,
          String? syncTableName,
          int? rowId,
          int? rowCloudId,
          SyncCurdType? syncCurdType,
          String? syncUpdateColumns,
          String? tag}) =>
      Sync(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        syncTableName: syncTableName ?? this.syncTableName,
        rowId: rowId ?? this.rowId,
        rowCloudId: rowCloudId ?? this.rowCloudId,
        syncCurdType: syncCurdType ?? this.syncCurdType,
        syncUpdateColumns: syncUpdateColumns ?? this.syncUpdateColumns,
        tag: tag ?? this.tag,
      );
  @override
  String toString() {
    return (StringBuffer('Sync(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncTableName: $syncTableName, ')
          ..write('rowId: $rowId, ')
          ..write('rowCloudId: $rowCloudId, ')
          ..write('syncCurdType: $syncCurdType, ')
          ..write('syncUpdateColumns: $syncUpdateColumns, ')
          ..write('tag: $tag')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, createdAt, updatedAt, syncTableName,
      rowId, rowCloudId, syncCurdType, syncUpdateColumns, tag);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Sync &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.syncTableName == this.syncTableName &&
          other.rowId == this.rowId &&
          other.rowCloudId == this.rowCloudId &&
          other.syncCurdType == this.syncCurdType &&
          other.syncUpdateColumns == this.syncUpdateColumns &&
          other.tag == this.tag);
}

class SyncsCompanion extends UpdateCompanion<Sync> {
  Value<int> id;
  Value<DateTime> createdAt;
  Value<DateTime> updatedAt;
  Value<String> syncTableName;
  Value<int> rowId;
  Value<int?> rowCloudId;
  Value<SyncCurdType?> syncCurdType;
  Value<String?> syncUpdateColumns;
  Value<String> tag;
  SyncsCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncTableName = const Value.absent(),
    this.rowId = const Value.absent(),
    this.rowCloudId = const Value.absent(),
    this.syncCurdType = const Value.absent(),
    this.syncUpdateColumns = const Value.absent(),
    this.tag = const Value.absent(),
  });
  SyncsCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required String syncTableName,
    required int rowId,
    this.rowCloudId = const Value.absent(),
    this.syncCurdType = const Value.absent(),
    this.syncUpdateColumns = const Value.absent(),
    required String tag,
  })  : syncTableName = Value(syncTableName),
        rowId = Value(rowId),
        tag = Value(tag);
  static Insertable<Sync> custom({
    Expression<int>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? syncTableName,
    Expression<int>? rowId,
    Expression<int?>? rowCloudId,
    Expression<SyncCurdType?>? syncCurdType,
    Expression<String?>? syncUpdateColumns,
    Expression<String>? tag,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (syncTableName != null) 'sync_table_name': syncTableName,
      if (rowId != null) 'row_id': rowId,
      if (rowCloudId != null) 'row_cloud_id': rowCloudId,
      if (syncCurdType != null) 'sync_curd_type': syncCurdType,
      if (syncUpdateColumns != null) 'sync_update_columns': syncUpdateColumns,
      if (tag != null) 'tag': tag,
    });
  }

  SyncsCompanion copyWith(
      {Value<int>? id,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<String>? syncTableName,
      Value<int>? rowId,
      Value<int?>? rowCloudId,
      Value<SyncCurdType?>? syncCurdType,
      Value<String?>? syncUpdateColumns,
      Value<String>? tag}) {
    return SyncsCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      syncTableName: syncTableName ?? this.syncTableName,
      rowId: rowId ?? this.rowId,
      rowCloudId: rowCloudId ?? this.rowCloudId,
      syncCurdType: syncCurdType ?? this.syncCurdType,
      syncUpdateColumns: syncUpdateColumns ?? this.syncUpdateColumns,
      tag: tag ?? this.tag,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (syncTableName.present) {
      map['sync_table_name'] = Variable<String>(syncTableName.value);
    }
    if (rowId.present) {
      map['row_id'] = Variable<int>(rowId.value);
    }
    if (rowCloudId.present) {
      map['row_cloud_id'] = Variable<int?>(rowCloudId.value);
    }
    if (syncCurdType.present) {
      final converter = $SyncsTable.$converter0;
      map['sync_curd_type'] =
          Variable<int?>(converter.mapToSql(syncCurdType.value));
    }
    if (syncUpdateColumns.present) {
      map['sync_update_columns'] = Variable<String?>(syncUpdateColumns.value);
    }
    if (tag.present) {
      map['tag'] = Variable<String>(tag.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncsCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncTableName: $syncTableName, ')
          ..write('rowId: $rowId, ')
          ..write('rowCloudId: $rowCloudId, ')
          ..write('syncCurdType: $syncCurdType, ')
          ..write('syncUpdateColumns: $syncUpdateColumns, ')
          ..write('tag: $tag')
          ..write(')'))
        .toString();
  }
}

class $SyncsTable extends Syncs with TableInfo<$SyncsTable, Sync> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncsTable(this.attachedDatabase, [this._alias]);
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
  final VerificationMeta _syncTableNameMeta =
      const VerificationMeta('syncTableName');
  @override
  late final GeneratedColumn<String?> syncTableName = GeneratedColumn<String?>(
      'sync_table_name', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _rowIdMeta = const VerificationMeta('rowId');
  @override
  late final GeneratedColumn<int?> rowId = GeneratedColumn<int?>(
      'row_id', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  final VerificationMeta _rowCloudIdMeta = const VerificationMeta('rowCloudId');
  @override
  late final GeneratedColumn<int?> rowCloudId = GeneratedColumn<int?>(
      'row_cloud_id', aliasedName, true,
      type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _syncCurdTypeMeta =
      const VerificationMeta('syncCurdType');
  @override
  late final GeneratedColumnWithTypeConverter<SyncCurdType?, int?>
      syncCurdType = GeneratedColumn<int?>('sync_curd_type', aliasedName, true,
              type: const IntType(), requiredDuringInsert: false)
          .withConverter<SyncCurdType?>($SyncsTable.$converter0);
  final VerificationMeta _syncUpdateColumnsMeta =
      const VerificationMeta('syncUpdateColumns');
  @override
  late final GeneratedColumn<String?> syncUpdateColumns =
      GeneratedColumn<String?>('sync_update_columns', aliasedName, true,
          type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _tagMeta = const VerificationMeta('tag');
  @override
  late final GeneratedColumn<String?> tag = GeneratedColumn<String?>(
      'tag', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        createdAt,
        updatedAt,
        syncTableName,
        rowId,
        rowCloudId,
        syncCurdType,
        syncUpdateColumns,
        tag
      ];
  @override
  String get aliasedName => _alias ?? 'syncs';
  @override
  String get actualTableName => 'syncs';
  @override
  VerificationContext validateIntegrity(Insertable<Sync> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
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
    if (data.containsKey('sync_table_name')) {
      context.handle(
          _syncTableNameMeta,
          syncTableName.isAcceptableOrUnknown(
              data['sync_table_name']!, _syncTableNameMeta));
    } else if (isInserting) {
      context.missing(_syncTableNameMeta);
    }
    if (data.containsKey('row_id')) {
      context.handle(
          _rowIdMeta, rowId.isAcceptableOrUnknown(data['row_id']!, _rowIdMeta));
    } else if (isInserting) {
      context.missing(_rowIdMeta);
    }
    if (data.containsKey('row_cloud_id')) {
      context.handle(
          _rowCloudIdMeta,
          rowCloudId.isAcceptableOrUnknown(
              data['row_cloud_id']!, _rowCloudIdMeta));
    }
    context.handle(_syncCurdTypeMeta, const VerificationResult.success());
    if (data.containsKey('sync_update_columns')) {
      context.handle(
          _syncUpdateColumnsMeta,
          syncUpdateColumns.isAcceptableOrUnknown(
              data['sync_update_columns']!, _syncUpdateColumnsMeta));
    }
    if (data.containsKey('tag')) {
      context.handle(
          _tagMeta, tag.isAcceptableOrUnknown(data['tag']!, _tagMeta));
    } else if (isInserting) {
      context.missing(_tagMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Sync map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Sync.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $SyncsTable createAlias(String alias) {
    return $SyncsTable(attachedDatabase, alias);
  }

  static TypeConverter<SyncCurdType?, int> $converter0 =
      const EnumIndexConverter<SyncCurdType>(SyncCurdType.values);
}

abstract class _$DriftDb extends GeneratedDatabase {
  _$DriftDb(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $UsersTable users = $UsersTable(this);
  late final $FragmentsTable fragments = $FragmentsTable(this);
  late final $FragmentGroupsTable fragmentGroups = $FragmentGroupsTable(this);
  late final $MemoryGroupsTable memoryGroups = $MemoryGroupsTable(this);
  late final $MemoryModelsTable memoryModels = $MemoryModelsTable(this);
  late final $FragmentPermanentMemoryInfosTable fragmentPermanentMemoryInfos =
      $FragmentPermanentMemoryInfosTable(this);
  late final $FragmentTemporaryMemoryInfo2Table fragmentTemporaryMemoryInfo2 =
      $FragmentTemporaryMemoryInfo2Table(this);
  late final $RFragment2FragmentGroupsTable rFragment2FragmentGroups =
      $RFragment2FragmentGroupsTable(this);
  late final $RFragment2MemoryGroupsTable rFragment2MemoryGroups =
      $RFragment2MemoryGroupsTable(this);
  late final $RMemoryModel2MemoryGroupsTable rMemoryModel2MemoryGroups =
      $RMemoryModel2MemoryGroupsTable(this);
  late final $AppInfosTable appInfos = $AppInfosTable(this);
  late final $SyncsTable syncs = $SyncsTable(this);
  late final SingleDAO singleDAO = SingleDAO(this as DriftDb);
  late final MultiDAO multiDAO = MultiDAO(this as DriftDb);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        users,
        fragments,
        fragmentGroups,
        memoryGroups,
        memoryModels,
        fragmentPermanentMemoryInfos,
        fragmentTemporaryMemoryInfo2,
        rFragment2FragmentGroups,
        rFragment2MemoryGroups,
        rMemoryModel2MemoryGroups,
        appInfos,
        syncs
      ];
}

// **************************************************************************
// DaoGenerator
// **************************************************************************

mixin _$MultiDAOMixin on DatabaseAccessor<DriftDb> {
  $UsersTable get users => attachedDatabase.users;
  $FragmentsTable get fragments => attachedDatabase.fragments;
  $FragmentGroupsTable get fragmentGroups => attachedDatabase.fragmentGroups;
  $MemoryGroupsTable get memoryGroups => attachedDatabase.memoryGroups;
  $MemoryModelsTable get memoryModels => attachedDatabase.memoryModels;
  $FragmentPermanentMemoryInfosTable get fragmentPermanentMemoryInfos =>
      attachedDatabase.fragmentPermanentMemoryInfos;
  $FragmentTemporaryMemoryInfo2Table get fragmentTemporaryMemoryInfo2 =>
      attachedDatabase.fragmentTemporaryMemoryInfo2;
}
mixin _$SingleDAOMixin on DatabaseAccessor<DriftDb> {
  $UsersTable get users => attachedDatabase.users;
  $FragmentsTable get fragments => attachedDatabase.fragments;
  $FragmentGroupsTable get fragmentGroups => attachedDatabase.fragmentGroups;
  $MemoryGroupsTable get memoryGroups => attachedDatabase.memoryGroups;
  $MemoryModelsTable get memoryModels => attachedDatabase.memoryModels;
  $FragmentPermanentMemoryInfosTable get fragmentPermanentMemoryInfos =>
      attachedDatabase.fragmentPermanentMemoryInfos;
  $FragmentTemporaryMemoryInfo2Table get fragmentTemporaryMemoryInfo2 =>
      attachedDatabase.fragmentTemporaryMemoryInfo2;
  $RFragment2FragmentGroupsTable get rFragment2FragmentGroups =>
      attachedDatabase.rFragment2FragmentGroups;
  $RFragment2MemoryGroupsTable get rFragment2MemoryGroups =>
      attachedDatabase.rFragment2MemoryGroups;
  $RMemoryModel2MemoryGroupsTable get rMemoryModel2MemoryGroups =>
      attachedDatabase.rMemoryModel2MemoryGroups;
}
