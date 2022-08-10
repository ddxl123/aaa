// GENERATED CODE - DO NOT MODIFY BY HAND

part of drift_db;

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: type=lint
class User extends DataClass implements Insertable<User> {
  /// 当子表类为 [Users] 时，
  ///   - 云端创建、云端获取。
  ///   - 无需自增，无需作为主键。
  ///
  /// 当子表类为非 [Users] 时，
  ///   - 生成方案：user_id + uuid.v4
  ///
  /// 云端的 id 无论是创建还是存储，都用字符串类型，若为雪花id，则也要转成字符串类型，以方便开发减少业务逻辑。
  String id;

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
      {required this.id,
      required this.createdAt,
      required this.updatedAt,
      required this.username,
      this.password,
      required this.email,
      required this.age});
  factory User.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return User(
      id: const StringType()
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
    map['id'] = Variable<String>(id);
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
      id: serializer.fromJson<String>(json['id']),
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
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'username': serializer.toJson<String>(username),
      'password': serializer.toJson<String?>(password),
      'email': serializer.toJson<String>(email),
      'age': serializer.toJson<int>(age),
    };
  }

  User copyWith(
          {String? id,
          DateTime? createdAt,
          DateTime? updatedAt,
          String? username,
          String? password,
          String? email,
          int? age}) =>
      User(
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
  int get hashCode =>
      Object.hash(id, createdAt, updatedAt, username, password, email, age);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.username == this.username &&
          other.password == this.password &&
          other.email == this.email &&
          other.age == this.age);
}

class UsersCompanion extends UpdateCompanion<User> {
  Value<String> id;
  Value<DateTime> createdAt;
  Value<DateTime> updatedAt;
  Value<String> username;
  Value<String?> password;
  Value<String> email;
  Value<int> age;
  UsersCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.username = const Value.absent(),
    this.password = const Value.absent(),
    this.email = const Value.absent(),
    this.age = const Value.absent(),
  });
  UsersCompanion.insert({
    required String id,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.username = const Value.absent(),
    this.password = const Value.absent(),
    this.email = const Value.absent(),
    this.age = const Value.absent(),
  }) : id = Value(id);
  static Insertable<User> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? username,
    Expression<String?>? password,
    Expression<String>? email,
    Expression<int>? age,
  }) {
    return RawValuesInsertable({
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
      {Value<String>? id,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<String>? username,
      Value<String?>? password,
      Value<String>? email,
      Value<int>? age}) {
    return UsersCompanion(
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
    if (id.present) {
      map['id'] = Variable<String>(id.value);
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
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String?> id = GeneratedColumn<String?>(
      'id', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
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
      [id, createdAt, updatedAt, username, password, email, age];
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
    } else if (isInserting) {
      context.missing(_idMeta);
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
  /// 当子表类为 [Users] 时，
  ///   - 云端创建、云端获取。
  ///   - 无需自增，无需作为主键。
  ///
  /// 当子表类为非 [Users] 时，
  ///   - 生成方案：user_id + uuid.v4
  ///
  /// 云端的 id 无论是创建还是存储，都用字符串类型，若为雪花id，则也要转成字符串类型，以方便开发减少业务逻辑。
  String id;

  /// 必须是本地时间，因为用户是在本地被创建、修改。
  /// *** 需要预防客户端时间篡改
  DateTime createdAt;

  /// 必须是本地时间，因为用户是在本地被创建、修改。
  /// *** 需要预防客户端时间篡改
  DateTime updatedAt;

  /// 父碎片（该碎片是由哪个碎片修改而来）
  ///
  /// 若为 null，则自身为根节点。
  String? fatherFragmentId;
  String title;

  /// 优先级/高频程度。
  ///
  /// 数字越大，优先级越高，不能为负数。
  int priority;
  Fragment(
      {required this.id,
      required this.createdAt,
      required this.updatedAt,
      this.fatherFragmentId,
      required this.title,
      required this.priority});
  factory Fragment.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Fragment(
      id: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      createdAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at'])!,
      updatedAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}updated_at'])!,
      fatherFragmentId: const StringType().mapFromDatabaseResponse(
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
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || fatherFragmentId != null) {
      map['father_fragment_id'] = Variable<String?>(fatherFragmentId);
    }
    map['title'] = Variable<String>(title);
    map['priority'] = Variable<int>(priority);
    return map;
  }

  FragmentsCompanion toCompanion(bool nullToAbsent) {
    return FragmentsCompanion(
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
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      fatherFragmentId: serializer.fromJson<String?>(json['fatherFragmentId']),
      title: serializer.fromJson<String>(json['title']),
      priority: serializer.fromJson<int>(json['priority']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'fatherFragmentId': serializer.toJson<String?>(fatherFragmentId),
      'title': serializer.toJson<String>(title),
      'priority': serializer.toJson<int>(priority),
    };
  }

  Fragment copyWith(
          {String? id,
          DateTime? createdAt,
          DateTime? updatedAt,
          String? fatherFragmentId,
          String? title,
          int? priority}) =>
      Fragment(
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
  int get hashCode =>
      Object.hash(id, createdAt, updatedAt, fatherFragmentId, title, priority);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Fragment &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.fatherFragmentId == this.fatherFragmentId &&
          other.title == this.title &&
          other.priority == this.priority);
}

class FragmentsCompanion extends UpdateCompanion<Fragment> {
  Value<String> id;
  Value<DateTime> createdAt;
  Value<DateTime> updatedAt;
  Value<String?> fatherFragmentId;
  Value<String> title;
  Value<int> priority;
  FragmentsCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.fatherFragmentId = const Value.absent(),
    this.title = const Value.absent(),
    this.priority = const Value.absent(),
  });
  FragmentsCompanion.insert({
    required String id,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.fatherFragmentId = const Value.absent(),
    this.title = const Value.absent(),
    this.priority = const Value.absent(),
  }) : id = Value(id);
  static Insertable<Fragment> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String?>? fatherFragmentId,
    Expression<String>? title,
    Expression<int>? priority,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (fatherFragmentId != null) 'father_fragment_id': fatherFragmentId,
      if (title != null) 'title': title,
      if (priority != null) 'priority': priority,
    });
  }

  FragmentsCompanion copyWith(
      {Value<String>? id,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<String?>? fatherFragmentId,
      Value<String>? title,
      Value<int>? priority}) {
    return FragmentsCompanion(
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
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (fatherFragmentId.present) {
      map['father_fragment_id'] = Variable<String?>(fatherFragmentId.value);
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
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String?> id = GeneratedColumn<String?>(
      'id', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
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
  late final GeneratedColumn<String?> fatherFragmentId =
      GeneratedColumn<String?>('father_fragment_id', aliasedName, true,
          type: const StringType(), requiredDuringInsert: false);
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
      [id, createdAt, updatedAt, fatherFragmentId, title, priority];
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
    } else if (isInserting) {
      context.missing(_idMeta);
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
  /// 当子表类为 [Users] 时，
  ///   - 云端创建、云端获取。
  ///   - 无需自增，无需作为主键。
  ///
  /// 当子表类为非 [Users] 时，
  ///   - 生成方案：user_id + uuid.v4
  ///
  /// 云端的 id 无论是创建还是存储，都用字符串类型，若为雪花id，则也要转成字符串类型，以方便开发减少业务逻辑。
  String id;

  /// 必须是本地时间，因为用户是在本地被创建、修改。
  /// *** 需要预防客户端时间篡改
  DateTime createdAt;

  /// 必须是本地时间，因为用户是在本地被创建、修改。
  /// *** 需要预防客户端时间篡改
  DateTime updatedAt;
  String? fatherFragmentGroupId;
  String title;
  FragmentGroup(
      {required this.id,
      required this.createdAt,
      required this.updatedAt,
      this.fatherFragmentGroupId,
      required this.title});
  factory FragmentGroup.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return FragmentGroup(
      id: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      createdAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at'])!,
      updatedAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}updated_at'])!,
      fatherFragmentGroupId: const StringType().mapFromDatabaseResponse(
          data['${effectivePrefix}father_fragment_group_id']),
      title: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}title'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || fatherFragmentGroupId != null) {
      map['father_fragment_group_id'] =
          Variable<String?>(fatherFragmentGroupId);
    }
    map['title'] = Variable<String>(title);
    return map;
  }

  FragmentGroupsCompanion toCompanion(bool nullToAbsent) {
    return FragmentGroupsCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      fatherFragmentGroupId: fatherFragmentGroupId == null && nullToAbsent
          ? const Value.absent()
          : Value(fatherFragmentGroupId),
      title: Value(title),
    );
  }

  factory FragmentGroup.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FragmentGroup(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      fatherFragmentGroupId:
          serializer.fromJson<String?>(json['fatherFragmentGroupId']),
      title: serializer.fromJson<String>(json['title']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'fatherFragmentGroupId':
          serializer.toJson<String?>(fatherFragmentGroupId),
      'title': serializer.toJson<String>(title),
    };
  }

  FragmentGroup copyWith(
          {String? id,
          DateTime? createdAt,
          DateTime? updatedAt,
          String? fatherFragmentGroupId,
          String? title}) =>
      FragmentGroup(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        fatherFragmentGroupId:
            fatherFragmentGroupId ?? this.fatherFragmentGroupId,
        title: title ?? this.title,
      );
  @override
  String toString() {
    return (StringBuffer('FragmentGroup(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('fatherFragmentGroupId: $fatherFragmentGroupId, ')
          ..write('title: $title')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, createdAt, updatedAt, fatherFragmentGroupId, title);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FragmentGroup &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.fatherFragmentGroupId == this.fatherFragmentGroupId &&
          other.title == this.title);
}

class FragmentGroupsCompanion extends UpdateCompanion<FragmentGroup> {
  Value<String> id;
  Value<DateTime> createdAt;
  Value<DateTime> updatedAt;
  Value<String?> fatherFragmentGroupId;
  Value<String> title;
  FragmentGroupsCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.fatherFragmentGroupId = const Value.absent(),
    this.title = const Value.absent(),
  });
  FragmentGroupsCompanion.insert({
    required String id,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.fatherFragmentGroupId = const Value.absent(),
    this.title = const Value.absent(),
  }) : id = Value(id);
  static Insertable<FragmentGroup> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String?>? fatherFragmentGroupId,
    Expression<String>? title,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (fatherFragmentGroupId != null)
        'father_fragment_group_id': fatherFragmentGroupId,
      if (title != null) 'title': title,
    });
  }

  FragmentGroupsCompanion copyWith(
      {Value<String>? id,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<String?>? fatherFragmentGroupId,
      Value<String>? title}) {
    return FragmentGroupsCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      fatherFragmentGroupId:
          fatherFragmentGroupId ?? this.fatherFragmentGroupId,
      title: title ?? this.title,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (fatherFragmentGroupId.present) {
      map['father_fragment_group_id'] =
          Variable<String?>(fatherFragmentGroupId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FragmentGroupsCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('fatherFragmentGroupId: $fatherFragmentGroupId, ')
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
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String?> id = GeneratedColumn<String?>(
      'id', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
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
  late final GeneratedColumn<String?> fatherFragmentGroupId =
      GeneratedColumn<String?>('father_fragment_group_id', aliasedName, true,
          type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String?> title = GeneratedColumn<String?>(
      'title', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: false,
      defaultValue: const Constant('还没有名称'));
  @override
  List<GeneratedColumn> get $columns =>
      [id, createdAt, updatedAt, fatherFragmentGroupId, title];
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
    } else if (isInserting) {
      context.missing(_idMeta);
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
  /// 当子表类为 [Users] 时，
  ///   - 云端创建、云端获取。
  ///   - 无需自增，无需作为主键。
  ///
  /// 当子表类为非 [Users] 时，
  ///   - 生成方案：user_id + uuid.v4
  ///
  /// 云端的 id 无论是创建还是存储，都用字符串类型，若为雪花id，则也要转成字符串类型，以方便开发减少业务逻辑。
  String id;

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
      {required this.id,
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
      id: const StringType()
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
    map['id'] = Variable<String>(id);
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
      id: serializer.fromJson<String>(json['id']),
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
      'id': serializer.toJson<String>(id),
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
          {String? id,
          DateTime? createdAt,
          DateTime? updatedAt,
          String? title,
          MemoryGroupType? type,
          MemoryGroupStatusForNormal? normalStatus,
          MemoryGroupStatusForNormalPart? normalPartStatus,
          MemoryGroupStatusForFullFloating? fullFloatingStatus}) =>
      MemoryGroup(
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
  int get hashCode => Object.hash(id, createdAt, updatedAt, title, type,
      normalStatus, normalPartStatus, fullFloatingStatus);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MemoryGroup &&
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
  Value<String> id;
  Value<DateTime> createdAt;
  Value<DateTime> updatedAt;
  Value<String> title;
  Value<MemoryGroupType> type;
  Value<MemoryGroupStatusForNormal> normalStatus;
  Value<MemoryGroupStatusForNormalPart> normalPartStatus;
  Value<MemoryGroupStatusForFullFloating> fullFloatingStatus;
  MemoryGroupsCompanion({
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
    required String id,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.title = const Value.absent(),
    this.type = const Value.absent(),
    this.normalStatus = const Value.absent(),
    this.normalPartStatus = const Value.absent(),
    this.fullFloatingStatus = const Value.absent(),
  }) : id = Value(id);
  static Insertable<MemoryGroup> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? title,
    Expression<MemoryGroupType>? type,
    Expression<MemoryGroupStatusForNormal>? normalStatus,
    Expression<MemoryGroupStatusForNormalPart>? normalPartStatus,
    Expression<MemoryGroupStatusForFullFloating>? fullFloatingStatus,
  }) {
    return RawValuesInsertable({
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
      {Value<String>? id,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<String>? title,
      Value<MemoryGroupType>? type,
      Value<MemoryGroupStatusForNormal>? normalStatus,
      Value<MemoryGroupStatusForNormalPart>? normalPartStatus,
      Value<MemoryGroupStatusForFullFloating>? fullFloatingStatus}) {
    return MemoryGroupsCompanion(
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
    if (id.present) {
      map['id'] = Variable<String>(id.value);
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
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String?> id = GeneratedColumn<String?>(
      'id', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
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
              defaultValue: Constant(MemoryGroupType.inApp.index))
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
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
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
  /// 当子表类为 [Users] 时，
  ///   - 云端创建、云端获取。
  ///   - 无需自增，无需作为主键。
  ///
  /// 当子表类为非 [Users] 时，
  ///   - 生成方案：user_id + uuid.v4
  ///
  /// 云端的 id 无论是创建还是存储，都用字符串类型，若为雪花id，则也要转成字符串类型，以方便开发减少业务逻辑。
  String id;

  /// 必须是本地时间，因为用户是在本地被创建、修改。
  /// *** 需要预防客户端时间篡改
  DateTime createdAt;

  /// 必须是本地时间，因为用户是在本地被创建、修改。
  /// *** 需要预防客户端时间篡改
  DateTime updatedAt;
  String title;

  /// 熟悉度算法。用来计算碎片的熟悉度曲线的数学函数，
  ///
  /// 可用变量：
  ///   t（变量） - 流逝的时间，初始值为 0。
  ///   d（阶段变量） - 启动任务的时间点与当次展示且关闭后的时间间隔。
  ///   i（阶段变量） - 每次展示前的 [阶段熟练度]。
  ///   c1（自定义变量1） - 来自 [nextTimeAlgorithm] 的自定义变量。
  /// 其他：
  ///   f(t) - 流逝熟悉度，单位百分比。
  ///   type - 表示算法类型，比如普通函数曲线类型、分段函数类型、固定值类型（fix:5,30,60,300(单位分钟)）等。
  /// 例如： type:f(t)=1-(0.56(t-d)^0.06)*(1-i)
  ///
  /// 阶段变量：
  /// 每次展示结束后，都会将 [非固定常量] 设置为新值，之后将会根据新的数学公式进行 [流逝熟悉度] 计算。注意，数学公式结构并不会发生改变，只是刷新了 [非固定常量] 的值。
  String? familiarityAlgorithm;

  /// 评估下一次展示的时间点的算法。
  ///
  /// 可用变量：
  ///   i - 阶段熟练度
  ///   b - 按钮数据 - 例如：很熟悉(b=b1=1/i 计算得60min后)  挺熟悉(b=b2=(1/i)*0.5 计算得30min后)  挺陌生(b=b3=(1/i)*0.01 计算得15min后) 很陌生(b=b4=0 计算得1min后)
  ///       - 按钮可以自定义数量 0-5 个，同时也可以设置区间选择，例如对 1.5-0.2 区间进行滑动选择。
  ///   c1 - 自定义变量 - c1、c2、c3...
  /// 其他：
  ///   y - [当前展示结束后]到[下一次展示]的时间间隔，单位min
  ///   type - 表示算法类型
  ///   multi -
  ///     - 第1天的算法：
  ///     - 第2天的算法：
  ///     - 第n天的算法：
  ///     - 第n天以上的算法：
  /// 例如：type:y=30*24*60*(i*b)+1
  ///   - 最终熟悉度=1：  30d+1min  后展示下一次。
  ///   - 最终熟悉度=0.5：  15d+0.5min  后展示下一次。
  ///   - 最终熟练度=0.01： 7h+12min  后展示下一次。
  ///   - 最终熟练度=0：  1min  后展示下一次。
  ///
  /// 展示碎片时，[按钮数据]会进行计算出y值，并展现给用户看，例如，展示内容：很熟悉(+5min)  挺熟悉(+60min)  挺陌生(+1d) 很陌生(+14d)。
  ///
  /// 变量中可以嵌入其他变量，例如，b的值可以是 1/i。
  ///
  /// 熟练度叠加的注意事项：
  ///   - [最终熟练度]的范围应该在 0%~100% 区间，即 0~1。
  ///   - 假设您设定的算法为：[最终熟练度]=[阶段熟练度]*[按钮指定熟练度]，那么[按钮指定熟练度]的最大值应该等于[阶段熟练度的倒数]，这样能保证 [最终熟练度] 的最大值为1。
  ///   - 当然，若您的算法需要的话，也可以让 [最终熟练度] 的值大于1，当程序计算时，也会按照大于1的值进行计算，不过最终向用户展现的最高熟练度仍然为1。
  String? nextTimeAlgorithm;
  MemoryModel(
      {required this.id,
      required this.createdAt,
      required this.updatedAt,
      required this.title,
      this.familiarityAlgorithm,
      this.nextTimeAlgorithm});
  factory MemoryModel.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return MemoryModel(
      id: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      createdAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at'])!,
      updatedAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}updated_at'])!,
      title: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}title'])!,
      familiarityAlgorithm: const StringType().mapFromDatabaseResponse(
          data['${effectivePrefix}familiarity_algorithm']),
      nextTimeAlgorithm: const StringType().mapFromDatabaseResponse(
          data['${effectivePrefix}next_time_algorithm']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || familiarityAlgorithm != null) {
      map['familiarity_algorithm'] = Variable<String?>(familiarityAlgorithm);
    }
    if (!nullToAbsent || nextTimeAlgorithm != null) {
      map['next_time_algorithm'] = Variable<String?>(nextTimeAlgorithm);
    }
    return map;
  }

  MemoryModelsCompanion toCompanion(bool nullToAbsent) {
    return MemoryModelsCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      title: Value(title),
      familiarityAlgorithm: familiarityAlgorithm == null && nullToAbsent
          ? const Value.absent()
          : Value(familiarityAlgorithm),
      nextTimeAlgorithm: nextTimeAlgorithm == null && nullToAbsent
          ? const Value.absent()
          : Value(nextTimeAlgorithm),
    );
  }

  factory MemoryModel.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MemoryModel(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      title: serializer.fromJson<String>(json['title']),
      familiarityAlgorithm:
          serializer.fromJson<String?>(json['familiarityAlgorithm']),
      nextTimeAlgorithm:
          serializer.fromJson<String?>(json['nextTimeAlgorithm']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'title': serializer.toJson<String>(title),
      'familiarityAlgorithm': serializer.toJson<String?>(familiarityAlgorithm),
      'nextTimeAlgorithm': serializer.toJson<String?>(nextTimeAlgorithm),
    };
  }

  MemoryModel copyWith(
          {String? id,
          DateTime? createdAt,
          DateTime? updatedAt,
          String? title,
          String? familiarityAlgorithm,
          String? nextTimeAlgorithm}) =>
      MemoryModel(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        title: title ?? this.title,
        familiarityAlgorithm: familiarityAlgorithm ?? this.familiarityAlgorithm,
        nextTimeAlgorithm: nextTimeAlgorithm ?? this.nextTimeAlgorithm,
      );
  @override
  String toString() {
    return (StringBuffer('MemoryModel(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('title: $title, ')
          ..write('familiarityAlgorithm: $familiarityAlgorithm, ')
          ..write('nextTimeAlgorithm: $nextTimeAlgorithm')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, createdAt, updatedAt, title, familiarityAlgorithm, nextTimeAlgorithm);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MemoryModel &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.title == this.title &&
          other.familiarityAlgorithm == this.familiarityAlgorithm &&
          other.nextTimeAlgorithm == this.nextTimeAlgorithm);
}

class MemoryModelsCompanion extends UpdateCompanion<MemoryModel> {
  Value<String> id;
  Value<DateTime> createdAt;
  Value<DateTime> updatedAt;
  Value<String> title;
  Value<String?> familiarityAlgorithm;
  Value<String?> nextTimeAlgorithm;
  MemoryModelsCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.title = const Value.absent(),
    this.familiarityAlgorithm = const Value.absent(),
    this.nextTimeAlgorithm = const Value.absent(),
  });
  MemoryModelsCompanion.insert({
    required String id,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.title = const Value.absent(),
    this.familiarityAlgorithm = const Value.absent(),
    this.nextTimeAlgorithm = const Value.absent(),
  }) : id = Value(id);
  static Insertable<MemoryModel> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? title,
    Expression<String?>? familiarityAlgorithm,
    Expression<String?>? nextTimeAlgorithm,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (title != null) 'title': title,
      if (familiarityAlgorithm != null)
        'familiarity_algorithm': familiarityAlgorithm,
      if (nextTimeAlgorithm != null) 'next_time_algorithm': nextTimeAlgorithm,
    });
  }

  MemoryModelsCompanion copyWith(
      {Value<String>? id,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<String>? title,
      Value<String?>? familiarityAlgorithm,
      Value<String?>? nextTimeAlgorithm}) {
    return MemoryModelsCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      title: title ?? this.title,
      familiarityAlgorithm: familiarityAlgorithm ?? this.familiarityAlgorithm,
      nextTimeAlgorithm: nextTimeAlgorithm ?? this.nextTimeAlgorithm,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
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
    if (familiarityAlgorithm.present) {
      map['familiarity_algorithm'] =
          Variable<String?>(familiarityAlgorithm.value);
    }
    if (nextTimeAlgorithm.present) {
      map['next_time_algorithm'] = Variable<String?>(nextTimeAlgorithm.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MemoryModelsCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('title: $title, ')
          ..write('familiarityAlgorithm: $familiarityAlgorithm, ')
          ..write('nextTimeAlgorithm: $nextTimeAlgorithm')
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
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String?> id = GeneratedColumn<String?>(
      'id', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
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
  final VerificationMeta _familiarityAlgorithmMeta =
      const VerificationMeta('familiarityAlgorithm');
  @override
  late final GeneratedColumn<String?> familiarityAlgorithm =
      GeneratedColumn<String?>('familiarity_algorithm', aliasedName, true,
          type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _nextTimeAlgorithmMeta =
      const VerificationMeta('nextTimeAlgorithm');
  @override
  late final GeneratedColumn<String?> nextTimeAlgorithm =
      GeneratedColumn<String?>('next_time_algorithm', aliasedName, true,
          type: const StringType(), requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        createdAt,
        updatedAt,
        title,
        familiarityAlgorithm,
        nextTimeAlgorithm
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
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
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
    if (data.containsKey('familiarity_algorithm')) {
      context.handle(
          _familiarityAlgorithmMeta,
          familiarityAlgorithm.isAcceptableOrUnknown(
              data['familiarity_algorithm']!, _familiarityAlgorithmMeta));
    }
    if (data.containsKey('next_time_algorithm')) {
      context.handle(
          _nextTimeAlgorithmMeta,
          nextTimeAlgorithm.isAcceptableOrUnknown(
              data['next_time_algorithm']!, _nextTimeAlgorithmMeta));
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
  /// 当子表类为 [Users] 时，
  ///   - 云端创建、云端获取。
  ///   - 无需自增，无需作为主键。
  ///
  /// 当子表类为非 [Users] 时，
  ///   - 生成方案：user_id + uuid.v4
  ///
  /// 云端的 id 无论是创建还是存储，都用字符串类型，若为雪花id，则也要转成字符串类型，以方便开发减少业务逻辑。
  String id;

  /// 必须是本地时间，因为用户是在本地被创建、修改。
  /// *** 需要预防客户端时间篡改
  DateTime createdAt;

  /// 必须是本地时间，因为用户是在本地被创建、修改。
  /// *** 需要预防客户端时间篡改
  DateTime updatedAt;
  String? fragmentId;

  /// 允许对应的 [MemoryModel] 不存在。
  String? memoryModelId;

  /// 允许对应的 [MemoryGroup] 不存在。
  String? memoryGroupId;

  /// 阶段按钮数值 —— 点击的按钮的数值。
  double? stageButtonValue;

  /// 阶段熟练度 —— 点击按钮前时的熟练度。
  ///
  /// 范围：0~1。
  ///
  /// 在用户触发按钮 **后** ，会根据 [MemoryModels.familiarityAlgorithm] 来计算 **触发按钮前** 的熟练度（触发按钮后的瞬间熟练度必然是1）
  double stageFamiliarity;

  /// 下一次展示的时间点。
  ///
  /// 在用户触发按钮后，会根据 [MemoryModels.nextTimeAlgorithm] 来计算下一次展示的时间。
  DateTime? nextShowTime;

  /// 碎片展示时长。
  double showDuration;
  FragmentPermanentMemoryInfo(
      {required this.id,
      required this.createdAt,
      required this.updatedAt,
      this.fragmentId,
      this.memoryModelId,
      this.memoryGroupId,
      this.stageButtonValue,
      required this.stageFamiliarity,
      this.nextShowTime,
      required this.showDuration});
  factory FragmentPermanentMemoryInfo.fromData(Map<String, dynamic> data,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return FragmentPermanentMemoryInfo(
      id: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      createdAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at'])!,
      updatedAt: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}updated_at'])!,
      fragmentId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}fragment_id']),
      memoryModelId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}memory_model_id']),
      memoryGroupId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}memory_group_id']),
      stageButtonValue: const RealType().mapFromDatabaseResponse(
          data['${effectivePrefix}stage_button_value']),
      stageFamiliarity: const RealType().mapFromDatabaseResponse(
          data['${effectivePrefix}stage_familiarity'])!,
      nextShowTime: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}next_show_time']),
      showDuration: const RealType()
          .mapFromDatabaseResponse(data['${effectivePrefix}show_duration'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || fragmentId != null) {
      map['fragment_id'] = Variable<String?>(fragmentId);
    }
    if (!nullToAbsent || memoryModelId != null) {
      map['memory_model_id'] = Variable<String?>(memoryModelId);
    }
    if (!nullToAbsent || memoryGroupId != null) {
      map['memory_group_id'] = Variable<String?>(memoryGroupId);
    }
    if (!nullToAbsent || stageButtonValue != null) {
      map['stage_button_value'] = Variable<double?>(stageButtonValue);
    }
    map['stage_familiarity'] = Variable<double>(stageFamiliarity);
    if (!nullToAbsent || nextShowTime != null) {
      map['next_show_time'] = Variable<DateTime?>(nextShowTime);
    }
    map['show_duration'] = Variable<double>(showDuration);
    return map;
  }

  FragmentPermanentMemoryInfosCompanion toCompanion(bool nullToAbsent) {
    return FragmentPermanentMemoryInfosCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      fragmentId: fragmentId == null && nullToAbsent
          ? const Value.absent()
          : Value(fragmentId),
      memoryModelId: memoryModelId == null && nullToAbsent
          ? const Value.absent()
          : Value(memoryModelId),
      memoryGroupId: memoryGroupId == null && nullToAbsent
          ? const Value.absent()
          : Value(memoryGroupId),
      stageButtonValue: stageButtonValue == null && nullToAbsent
          ? const Value.absent()
          : Value(stageButtonValue),
      stageFamiliarity: Value(stageFamiliarity),
      nextShowTime: nextShowTime == null && nullToAbsent
          ? const Value.absent()
          : Value(nextShowTime),
      showDuration: Value(showDuration),
    );
  }

  factory FragmentPermanentMemoryInfo.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FragmentPermanentMemoryInfo(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      fragmentId: serializer.fromJson<String?>(json['fragmentId']),
      memoryModelId: serializer.fromJson<String?>(json['memoryModelId']),
      memoryGroupId: serializer.fromJson<String?>(json['memoryGroupId']),
      stageButtonValue: serializer.fromJson<double?>(json['stageButtonValue']),
      stageFamiliarity: serializer.fromJson<double>(json['stageFamiliarity']),
      nextShowTime: serializer.fromJson<DateTime?>(json['nextShowTime']),
      showDuration: serializer.fromJson<double>(json['showDuration']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'fragmentId': serializer.toJson<String?>(fragmentId),
      'memoryModelId': serializer.toJson<String?>(memoryModelId),
      'memoryGroupId': serializer.toJson<String?>(memoryGroupId),
      'stageButtonValue': serializer.toJson<double?>(stageButtonValue),
      'stageFamiliarity': serializer.toJson<double>(stageFamiliarity),
      'nextShowTime': serializer.toJson<DateTime?>(nextShowTime),
      'showDuration': serializer.toJson<double>(showDuration),
    };
  }

  FragmentPermanentMemoryInfo copyWith(
          {String? id,
          DateTime? createdAt,
          DateTime? updatedAt,
          String? fragmentId,
          String? memoryModelId,
          String? memoryGroupId,
          double? stageButtonValue,
          double? stageFamiliarity,
          DateTime? nextShowTime,
          double? showDuration}) =>
      FragmentPermanentMemoryInfo(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        fragmentId: fragmentId ?? this.fragmentId,
        memoryModelId: memoryModelId ?? this.memoryModelId,
        memoryGroupId: memoryGroupId ?? this.memoryGroupId,
        stageButtonValue: stageButtonValue ?? this.stageButtonValue,
        stageFamiliarity: stageFamiliarity ?? this.stageFamiliarity,
        nextShowTime: nextShowTime ?? this.nextShowTime,
        showDuration: showDuration ?? this.showDuration,
      );
  @override
  String toString() {
    return (StringBuffer('FragmentPermanentMemoryInfo(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('fragmentId: $fragmentId, ')
          ..write('memoryModelId: $memoryModelId, ')
          ..write('memoryGroupId: $memoryGroupId, ')
          ..write('stageButtonValue: $stageButtonValue, ')
          ..write('stageFamiliarity: $stageFamiliarity, ')
          ..write('nextShowTime: $nextShowTime, ')
          ..write('showDuration: $showDuration')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      createdAt,
      updatedAt,
      fragmentId,
      memoryModelId,
      memoryGroupId,
      stageButtonValue,
      stageFamiliarity,
      nextShowTime,
      showDuration);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FragmentPermanentMemoryInfo &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.fragmentId == this.fragmentId &&
          other.memoryModelId == this.memoryModelId &&
          other.memoryGroupId == this.memoryGroupId &&
          other.stageButtonValue == this.stageButtonValue &&
          other.stageFamiliarity == this.stageFamiliarity &&
          other.nextShowTime == this.nextShowTime &&
          other.showDuration == this.showDuration);
}

class FragmentPermanentMemoryInfosCompanion
    extends UpdateCompanion<FragmentPermanentMemoryInfo> {
  Value<String> id;
  Value<DateTime> createdAt;
  Value<DateTime> updatedAt;
  Value<String?> fragmentId;
  Value<String?> memoryModelId;
  Value<String?> memoryGroupId;
  Value<double?> stageButtonValue;
  Value<double> stageFamiliarity;
  Value<DateTime?> nextShowTime;
  Value<double> showDuration;
  FragmentPermanentMemoryInfosCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.fragmentId = const Value.absent(),
    this.memoryModelId = const Value.absent(),
    this.memoryGroupId = const Value.absent(),
    this.stageButtonValue = const Value.absent(),
    this.stageFamiliarity = const Value.absent(),
    this.nextShowTime = const Value.absent(),
    this.showDuration = const Value.absent(),
  });
  FragmentPermanentMemoryInfosCompanion.insert({
    required String id,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.fragmentId = const Value.absent(),
    this.memoryModelId = const Value.absent(),
    this.memoryGroupId = const Value.absent(),
    this.stageButtonValue = const Value.absent(),
    this.stageFamiliarity = const Value.absent(),
    this.nextShowTime = const Value.absent(),
    this.showDuration = const Value.absent(),
  }) : id = Value(id);
  static Insertable<FragmentPermanentMemoryInfo> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String?>? fragmentId,
    Expression<String?>? memoryModelId,
    Expression<String?>? memoryGroupId,
    Expression<double?>? stageButtonValue,
    Expression<double>? stageFamiliarity,
    Expression<DateTime?>? nextShowTime,
    Expression<double>? showDuration,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (fragmentId != null) 'fragment_id': fragmentId,
      if (memoryModelId != null) 'memory_model_id': memoryModelId,
      if (memoryGroupId != null) 'memory_group_id': memoryGroupId,
      if (stageButtonValue != null) 'stage_button_value': stageButtonValue,
      if (stageFamiliarity != null) 'stage_familiarity': stageFamiliarity,
      if (nextShowTime != null) 'next_show_time': nextShowTime,
      if (showDuration != null) 'show_duration': showDuration,
    });
  }

  FragmentPermanentMemoryInfosCompanion copyWith(
      {Value<String>? id,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<String?>? fragmentId,
      Value<String?>? memoryModelId,
      Value<String?>? memoryGroupId,
      Value<double?>? stageButtonValue,
      Value<double>? stageFamiliarity,
      Value<DateTime?>? nextShowTime,
      Value<double>? showDuration}) {
    return FragmentPermanentMemoryInfosCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      fragmentId: fragmentId ?? this.fragmentId,
      memoryModelId: memoryModelId ?? this.memoryModelId,
      memoryGroupId: memoryGroupId ?? this.memoryGroupId,
      stageButtonValue: stageButtonValue ?? this.stageButtonValue,
      stageFamiliarity: stageFamiliarity ?? this.stageFamiliarity,
      nextShowTime: nextShowTime ?? this.nextShowTime,
      showDuration: showDuration ?? this.showDuration,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (fragmentId.present) {
      map['fragment_id'] = Variable<String?>(fragmentId.value);
    }
    if (memoryModelId.present) {
      map['memory_model_id'] = Variable<String?>(memoryModelId.value);
    }
    if (memoryGroupId.present) {
      map['memory_group_id'] = Variable<String?>(memoryGroupId.value);
    }
    if (stageButtonValue.present) {
      map['stage_button_value'] = Variable<double?>(stageButtonValue.value);
    }
    if (stageFamiliarity.present) {
      map['stage_familiarity'] = Variable<double>(stageFamiliarity.value);
    }
    if (nextShowTime.present) {
      map['next_show_time'] = Variable<DateTime?>(nextShowTime.value);
    }
    if (showDuration.present) {
      map['show_duration'] = Variable<double>(showDuration.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FragmentPermanentMemoryInfosCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('fragmentId: $fragmentId, ')
          ..write('memoryModelId: $memoryModelId, ')
          ..write('memoryGroupId: $memoryGroupId, ')
          ..write('stageButtonValue: $stageButtonValue, ')
          ..write('stageFamiliarity: $stageFamiliarity, ')
          ..write('nextShowTime: $nextShowTime, ')
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
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String?> id = GeneratedColumn<String?>(
      'id', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
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
  late final GeneratedColumn<String?> fragmentId = GeneratedColumn<String?>(
      'fragment_id', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _memoryModelIdMeta =
      const VerificationMeta('memoryModelId');
  @override
  late final GeneratedColumn<String?> memoryModelId = GeneratedColumn<String?>(
      'memory_model_id', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _memoryGroupIdMeta =
      const VerificationMeta('memoryGroupId');
  @override
  late final GeneratedColumn<String?> memoryGroupId = GeneratedColumn<String?>(
      'memory_group_id', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _stageButtonValueMeta =
      const VerificationMeta('stageButtonValue');
  @override
  late final GeneratedColumn<double?> stageButtonValue =
      GeneratedColumn<double?>('stage_button_value', aliasedName, true,
          type: const RealType(), requiredDuringInsert: false);
  final VerificationMeta _stageFamiliarityMeta =
      const VerificationMeta('stageFamiliarity');
  @override
  late final GeneratedColumn<double?> stageFamiliarity =
      GeneratedColumn<double?>('stage_familiarity', aliasedName, false,
          check: () =>
              stageFamiliarity.isBetween(const Constant(0), const Constant(1)),
          type: const RealType(),
          requiredDuringInsert: false,
          defaultValue: const Constant(0));
  final VerificationMeta _nextShowTimeMeta =
      const VerificationMeta('nextShowTime');
  @override
  late final GeneratedColumn<DateTime?> nextShowTime =
      GeneratedColumn<DateTime?>('next_show_time', aliasedName, true,
          type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _showDurationMeta =
      const VerificationMeta('showDuration');
  @override
  late final GeneratedColumn<double?> showDuration = GeneratedColumn<double?>(
      'show_duration', aliasedName, false,
      type: const RealType(),
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        createdAt,
        updatedAt,
        fragmentId,
        memoryModelId,
        memoryGroupId,
        stageButtonValue,
        stageFamiliarity,
        nextShowTime,
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
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
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
    if (data.containsKey('memory_model_id')) {
      context.handle(
          _memoryModelIdMeta,
          memoryModelId.isAcceptableOrUnknown(
              data['memory_model_id']!, _memoryModelIdMeta));
    }
    if (data.containsKey('memory_group_id')) {
      context.handle(
          _memoryGroupIdMeta,
          memoryGroupId.isAcceptableOrUnknown(
              data['memory_group_id']!, _memoryGroupIdMeta));
    }
    if (data.containsKey('stage_button_value')) {
      context.handle(
          _stageButtonValueMeta,
          stageButtonValue.isAcceptableOrUnknown(
              data['stage_button_value']!, _stageButtonValueMeta));
    }
    if (data.containsKey('stage_familiarity')) {
      context.handle(
          _stageFamiliarityMeta,
          stageFamiliarity.isAcceptableOrUnknown(
              data['stage_familiarity']!, _stageFamiliarityMeta));
    }
    if (data.containsKey('next_show_time')) {
      context.handle(
          _nextShowTimeMeta,
          nextShowTime.isAcceptableOrUnknown(
              data['next_show_time']!, _nextShowTimeMeta));
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

class RFragment2FragmentGroup extends DataClass
    implements Insertable<RFragment2FragmentGroup> {
  String? fatherId;
  String sonId;

  /// 当子表类为 [Users] 时，
  ///   - 云端创建、云端获取。
  ///   - 无需自增，无需作为主键。
  ///
  /// 当子表类为非 [Users] 时，
  ///   - 生成方案：user_id + uuid.v4
  ///
  /// 云端的 id 无论是创建还是存储，都用字符串类型，若为雪花id，则也要转成字符串类型，以方便开发减少业务逻辑。
  String id;

  /// 必须是本地时间，因为用户是在本地被创建、修改。
  /// *** 需要预防客户端时间篡改
  DateTime createdAt;

  /// 必须是本地时间，因为用户是在本地被创建、修改。
  /// *** 需要预防客户端时间篡改
  DateTime updatedAt;
  RFragment2FragmentGroup(
      {this.fatherId,
      required this.sonId,
      required this.id,
      required this.createdAt,
      required this.updatedAt});
  factory RFragment2FragmentGroup.fromData(Map<String, dynamic> data,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return RFragment2FragmentGroup(
      fatherId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}father_id']),
      sonId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}son_id'])!,
      id: const StringType()
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
    if (!nullToAbsent || fatherId != null) {
      map['father_id'] = Variable<String?>(fatherId);
    }
    map['son_id'] = Variable<String>(sonId);
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  RFragment2FragmentGroupsCompanion toCompanion(bool nullToAbsent) {
    return RFragment2FragmentGroupsCompanion(
      fatherId: fatherId == null && nullToAbsent
          ? const Value.absent()
          : Value(fatherId),
      sonId: Value(sonId),
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory RFragment2FragmentGroup.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RFragment2FragmentGroup(
      fatherId: serializer.fromJson<String?>(json['fatherId']),
      sonId: serializer.fromJson<String>(json['sonId']),
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'fatherId': serializer.toJson<String?>(fatherId),
      'sonId': serializer.toJson<String>(sonId),
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  RFragment2FragmentGroup copyWith(
          {String? fatherId,
          String? sonId,
          String? id,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      RFragment2FragmentGroup(
        fatherId: fatherId ?? this.fatherId,
        sonId: sonId ?? this.sonId,
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  @override
  String toString() {
    return (StringBuffer('RFragment2FragmentGroup(')
          ..write('fatherId: $fatherId, ')
          ..write('sonId: $sonId, ')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(fatherId, sonId, id, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RFragment2FragmentGroup &&
          other.fatherId == this.fatherId &&
          other.sonId == this.sonId &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class RFragment2FragmentGroupsCompanion
    extends UpdateCompanion<RFragment2FragmentGroup> {
  Value<String?> fatherId;
  Value<String> sonId;
  Value<String> id;
  Value<DateTime> createdAt;
  Value<DateTime> updatedAt;
  RFragment2FragmentGroupsCompanion({
    this.fatherId = const Value.absent(),
    this.sonId = const Value.absent(),
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  RFragment2FragmentGroupsCompanion.insert({
    this.fatherId = const Value.absent(),
    required String sonId,
    required String id,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  })  : sonId = Value(sonId),
        id = Value(id);
  static Insertable<RFragment2FragmentGroup> custom({
    Expression<String?>? fatherId,
    Expression<String>? sonId,
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (fatherId != null) 'father_id': fatherId,
      if (sonId != null) 'son_id': sonId,
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  RFragment2FragmentGroupsCompanion copyWith(
      {Value<String?>? fatherId,
      Value<String>? sonId,
      Value<String>? id,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return RFragment2FragmentGroupsCompanion(
      fatherId: fatherId ?? this.fatherId,
      sonId: sonId ?? this.sonId,
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (fatherId.present) {
      map['father_id'] = Variable<String?>(fatherId.value);
    }
    if (sonId.present) {
      map['son_id'] = Variable<String>(sonId.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
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
          ..write('fatherId: $fatherId, ')
          ..write('sonId: $sonId, ')
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
  final VerificationMeta _fatherIdMeta = const VerificationMeta('fatherId');
  @override
  late final GeneratedColumn<String?> fatherId = GeneratedColumn<String?>(
      'father_id', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _sonIdMeta = const VerificationMeta('sonId');
  @override
  late final GeneratedColumn<String?> sonId = GeneratedColumn<String?>(
      'son_id', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String?> id = GeneratedColumn<String?>(
      'id', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
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
  List<GeneratedColumn> get $columns =>
      [fatherId, sonId, id, createdAt, updatedAt];
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
    if (data.containsKey('father_id')) {
      context.handle(_fatherIdMeta,
          fatherId.isAcceptableOrUnknown(data['father_id']!, _fatherIdMeta));
    }
    if (data.containsKey('son_id')) {
      context.handle(
          _sonIdMeta, sonId.isAcceptableOrUnknown(data['son_id']!, _sonIdMeta));
    } else if (isInserting) {
      context.missing(_sonIdMeta);
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
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
  String? fatherId;
  String sonId;

  /// 当子表类为 [Users] 时，
  ///   - 云端创建、云端获取。
  ///   - 无需自增，无需作为主键。
  ///
  /// 当子表类为非 [Users] 时，
  ///   - 生成方案：user_id + uuid.v4
  ///
  /// 云端的 id 无论是创建还是存储，都用字符串类型，若为雪花id，则也要转成字符串类型，以方便开发减少业务逻辑。
  String id;

  /// 必须是本地时间，因为用户是在本地被创建、修改。
  /// *** 需要预防客户端时间篡改
  DateTime createdAt;

  /// 必须是本地时间，因为用户是在本地被创建、修改。
  /// *** 需要预防客户端时间篡改
  DateTime updatedAt;
  RFragment2MemoryGroup(
      {this.fatherId,
      required this.sonId,
      required this.id,
      required this.createdAt,
      required this.updatedAt});
  factory RFragment2MemoryGroup.fromData(Map<String, dynamic> data,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return RFragment2MemoryGroup(
      fatherId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}father_id']),
      sonId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}son_id'])!,
      id: const StringType()
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
    if (!nullToAbsent || fatherId != null) {
      map['father_id'] = Variable<String?>(fatherId);
    }
    map['son_id'] = Variable<String>(sonId);
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  RFragment2MemoryGroupsCompanion toCompanion(bool nullToAbsent) {
    return RFragment2MemoryGroupsCompanion(
      fatherId: fatherId == null && nullToAbsent
          ? const Value.absent()
          : Value(fatherId),
      sonId: Value(sonId),
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory RFragment2MemoryGroup.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RFragment2MemoryGroup(
      fatherId: serializer.fromJson<String?>(json['fatherId']),
      sonId: serializer.fromJson<String>(json['sonId']),
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'fatherId': serializer.toJson<String?>(fatherId),
      'sonId': serializer.toJson<String>(sonId),
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  RFragment2MemoryGroup copyWith(
          {String? fatherId,
          String? sonId,
          String? id,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      RFragment2MemoryGroup(
        fatherId: fatherId ?? this.fatherId,
        sonId: sonId ?? this.sonId,
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  @override
  String toString() {
    return (StringBuffer('RFragment2MemoryGroup(')
          ..write('fatherId: $fatherId, ')
          ..write('sonId: $sonId, ')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(fatherId, sonId, id, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RFragment2MemoryGroup &&
          other.fatherId == this.fatherId &&
          other.sonId == this.sonId &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class RFragment2MemoryGroupsCompanion
    extends UpdateCompanion<RFragment2MemoryGroup> {
  Value<String?> fatherId;
  Value<String> sonId;
  Value<String> id;
  Value<DateTime> createdAt;
  Value<DateTime> updatedAt;
  RFragment2MemoryGroupsCompanion({
    this.fatherId = const Value.absent(),
    this.sonId = const Value.absent(),
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  RFragment2MemoryGroupsCompanion.insert({
    this.fatherId = const Value.absent(),
    required String sonId,
    required String id,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  })  : sonId = Value(sonId),
        id = Value(id);
  static Insertable<RFragment2MemoryGroup> custom({
    Expression<String?>? fatherId,
    Expression<String>? sonId,
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (fatherId != null) 'father_id': fatherId,
      if (sonId != null) 'son_id': sonId,
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  RFragment2MemoryGroupsCompanion copyWith(
      {Value<String?>? fatherId,
      Value<String>? sonId,
      Value<String>? id,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return RFragment2MemoryGroupsCompanion(
      fatherId: fatherId ?? this.fatherId,
      sonId: sonId ?? this.sonId,
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (fatherId.present) {
      map['father_id'] = Variable<String?>(fatherId.value);
    }
    if (sonId.present) {
      map['son_id'] = Variable<String>(sonId.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
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
          ..write('fatherId: $fatherId, ')
          ..write('sonId: $sonId, ')
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
  final VerificationMeta _fatherIdMeta = const VerificationMeta('fatherId');
  @override
  late final GeneratedColumn<String?> fatherId = GeneratedColumn<String?>(
      'father_id', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _sonIdMeta = const VerificationMeta('sonId');
  @override
  late final GeneratedColumn<String?> sonId = GeneratedColumn<String?>(
      'son_id', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String?> id = GeneratedColumn<String?>(
      'id', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
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
  List<GeneratedColumn> get $columns =>
      [fatherId, sonId, id, createdAt, updatedAt];
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
    if (data.containsKey('father_id')) {
      context.handle(_fatherIdMeta,
          fatherId.isAcceptableOrUnknown(data['father_id']!, _fatherIdMeta));
    }
    if (data.containsKey('son_id')) {
      context.handle(
          _sonIdMeta, sonId.isAcceptableOrUnknown(data['son_id']!, _sonIdMeta));
    } else if (isInserting) {
      context.missing(_sonIdMeta);
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
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
  String? fatherId;
  String sonId;

  /// 当子表类为 [Users] 时，
  ///   - 云端创建、云端获取。
  ///   - 无需自增，无需作为主键。
  ///
  /// 当子表类为非 [Users] 时，
  ///   - 生成方案：user_id + uuid.v4
  ///
  /// 云端的 id 无论是创建还是存储，都用字符串类型，若为雪花id，则也要转成字符串类型，以方便开发减少业务逻辑。
  String id;

  /// 必须是本地时间，因为用户是在本地被创建、修改。
  /// *** 需要预防客户端时间篡改
  DateTime createdAt;

  /// 必须是本地时间，因为用户是在本地被创建、修改。
  /// *** 需要预防客户端时间篡改
  DateTime updatedAt;
  RMemoryModel2MemoryGroup(
      {this.fatherId,
      required this.sonId,
      required this.id,
      required this.createdAt,
      required this.updatedAt});
  factory RMemoryModel2MemoryGroup.fromData(Map<String, dynamic> data,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return RMemoryModel2MemoryGroup(
      fatherId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}father_id']),
      sonId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}son_id'])!,
      id: const StringType()
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
    if (!nullToAbsent || fatherId != null) {
      map['father_id'] = Variable<String?>(fatherId);
    }
    map['son_id'] = Variable<String>(sonId);
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  RMemoryModel2MemoryGroupsCompanion toCompanion(bool nullToAbsent) {
    return RMemoryModel2MemoryGroupsCompanion(
      fatherId: fatherId == null && nullToAbsent
          ? const Value.absent()
          : Value(fatherId),
      sonId: Value(sonId),
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory RMemoryModel2MemoryGroup.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RMemoryModel2MemoryGroup(
      fatherId: serializer.fromJson<String?>(json['fatherId']),
      sonId: serializer.fromJson<String>(json['sonId']),
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'fatherId': serializer.toJson<String?>(fatherId),
      'sonId': serializer.toJson<String>(sonId),
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  RMemoryModel2MemoryGroup copyWith(
          {String? fatherId,
          String? sonId,
          String? id,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      RMemoryModel2MemoryGroup(
        fatherId: fatherId ?? this.fatherId,
        sonId: sonId ?? this.sonId,
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  @override
  String toString() {
    return (StringBuffer('RMemoryModel2MemoryGroup(')
          ..write('fatherId: $fatherId, ')
          ..write('sonId: $sonId, ')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(fatherId, sonId, id, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RMemoryModel2MemoryGroup &&
          other.fatherId == this.fatherId &&
          other.sonId == this.sonId &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class RMemoryModel2MemoryGroupsCompanion
    extends UpdateCompanion<RMemoryModel2MemoryGroup> {
  Value<String?> fatherId;
  Value<String> sonId;
  Value<String> id;
  Value<DateTime> createdAt;
  Value<DateTime> updatedAt;
  RMemoryModel2MemoryGroupsCompanion({
    this.fatherId = const Value.absent(),
    this.sonId = const Value.absent(),
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  RMemoryModel2MemoryGroupsCompanion.insert({
    this.fatherId = const Value.absent(),
    required String sonId,
    required String id,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  })  : sonId = Value(sonId),
        id = Value(id);
  static Insertable<RMemoryModel2MemoryGroup> custom({
    Expression<String?>? fatherId,
    Expression<String>? sonId,
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (fatherId != null) 'father_id': fatherId,
      if (sonId != null) 'son_id': sonId,
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  RMemoryModel2MemoryGroupsCompanion copyWith(
      {Value<String?>? fatherId,
      Value<String>? sonId,
      Value<String>? id,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return RMemoryModel2MemoryGroupsCompanion(
      fatherId: fatherId ?? this.fatherId,
      sonId: sonId ?? this.sonId,
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (fatherId.present) {
      map['father_id'] = Variable<String?>(fatherId.value);
    }
    if (sonId.present) {
      map['son_id'] = Variable<String>(sonId.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
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
          ..write('fatherId: $fatherId, ')
          ..write('sonId: $sonId, ')
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
  final VerificationMeta _fatherIdMeta = const VerificationMeta('fatherId');
  @override
  late final GeneratedColumn<String?> fatherId = GeneratedColumn<String?>(
      'father_id', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _sonIdMeta = const VerificationMeta('sonId');
  @override
  late final GeneratedColumn<String?> sonId = GeneratedColumn<String?>(
      'son_id', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String?> id = GeneratedColumn<String?>(
      'id', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
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
  List<GeneratedColumn> get $columns =>
      [fatherId, sonId, id, createdAt, updatedAt];
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
    if (data.containsKey('father_id')) {
      context.handle(_fatherIdMeta,
          fatherId.isAcceptableOrUnknown(data['father_id']!, _fatherIdMeta));
    }
    if (data.containsKey('son_id')) {
      context.handle(
          _sonIdMeta, sonId.isAcceptableOrUnknown(data['son_id']!, _sonIdMeta));
    } else if (isInserting) {
      context.missing(_sonIdMeta);
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
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

class RAssistedMemoryFragment2FragmentData extends DataClass
    implements Insertable<RAssistedMemoryFragment2FragmentData> {
  String? fatherId;
  String sonId;

  /// 当子表类为 [Users] 时，
  ///   - 云端创建、云端获取。
  ///   - 无需自增，无需作为主键。
  ///
  /// 当子表类为非 [Users] 时，
  ///   - 生成方案：user_id + uuid.v4
  ///
  /// 云端的 id 无论是创建还是存储，都用字符串类型，若为雪花id，则也要转成字符串类型，以方便开发减少业务逻辑。
  String id;

  /// 必须是本地时间，因为用户是在本地被创建、修改。
  /// *** 需要预防客户端时间篡改
  DateTime createdAt;

  /// 必须是本地时间，因为用户是在本地被创建、修改。
  /// *** 需要预防客户端时间篡改
  DateTime updatedAt;
  RAssistedMemoryFragment2FragmentData(
      {this.fatherId,
      required this.sonId,
      required this.id,
      required this.createdAt,
      required this.updatedAt});
  factory RAssistedMemoryFragment2FragmentData.fromData(
      Map<String, dynamic> data,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return RAssistedMemoryFragment2FragmentData(
      fatherId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}father_id']),
      sonId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}son_id'])!,
      id: const StringType()
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
    if (!nullToAbsent || fatherId != null) {
      map['father_id'] = Variable<String?>(fatherId);
    }
    map['son_id'] = Variable<String>(sonId);
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  RAssistedMemoryFragment2FragmentCompanion toCompanion(bool nullToAbsent) {
    return RAssistedMemoryFragment2FragmentCompanion(
      fatherId: fatherId == null && nullToAbsent
          ? const Value.absent()
          : Value(fatherId),
      sonId: Value(sonId),
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory RAssistedMemoryFragment2FragmentData.fromJson(
      Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RAssistedMemoryFragment2FragmentData(
      fatherId: serializer.fromJson<String?>(json['fatherId']),
      sonId: serializer.fromJson<String>(json['sonId']),
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'fatherId': serializer.toJson<String?>(fatherId),
      'sonId': serializer.toJson<String>(sonId),
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  RAssistedMemoryFragment2FragmentData copyWith(
          {String? fatherId,
          String? sonId,
          String? id,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      RAssistedMemoryFragment2FragmentData(
        fatherId: fatherId ?? this.fatherId,
        sonId: sonId ?? this.sonId,
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  @override
  String toString() {
    return (StringBuffer('RAssistedMemoryFragment2FragmentData(')
          ..write('fatherId: $fatherId, ')
          ..write('sonId: $sonId, ')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(fatherId, sonId, id, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RAssistedMemoryFragment2FragmentData &&
          other.fatherId == this.fatherId &&
          other.sonId == this.sonId &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class RAssistedMemoryFragment2FragmentCompanion
    extends UpdateCompanion<RAssistedMemoryFragment2FragmentData> {
  Value<String?> fatherId;
  Value<String> sonId;
  Value<String> id;
  Value<DateTime> createdAt;
  Value<DateTime> updatedAt;
  RAssistedMemoryFragment2FragmentCompanion({
    this.fatherId = const Value.absent(),
    this.sonId = const Value.absent(),
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  RAssistedMemoryFragment2FragmentCompanion.insert({
    this.fatherId = const Value.absent(),
    required String sonId,
    required String id,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  })  : sonId = Value(sonId),
        id = Value(id);
  static Insertable<RAssistedMemoryFragment2FragmentData> custom({
    Expression<String?>? fatherId,
    Expression<String>? sonId,
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (fatherId != null) 'father_id': fatherId,
      if (sonId != null) 'son_id': sonId,
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  RAssistedMemoryFragment2FragmentCompanion copyWith(
      {Value<String?>? fatherId,
      Value<String>? sonId,
      Value<String>? id,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return RAssistedMemoryFragment2FragmentCompanion(
      fatherId: fatherId ?? this.fatherId,
      sonId: sonId ?? this.sonId,
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (fatherId.present) {
      map['father_id'] = Variable<String?>(fatherId.value);
    }
    if (sonId.present) {
      map['son_id'] = Variable<String>(sonId.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
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
    return (StringBuffer('RAssistedMemoryFragment2FragmentCompanion(')
          ..write('fatherId: $fatherId, ')
          ..write('sonId: $sonId, ')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $RAssistedMemoryFragment2FragmentTable
    extends RAssistedMemoryFragment2Fragment
    with
        TableInfo<$RAssistedMemoryFragment2FragmentTable,
            RAssistedMemoryFragment2FragmentData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RAssistedMemoryFragment2FragmentTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _fatherIdMeta = const VerificationMeta('fatherId');
  @override
  late final GeneratedColumn<String?> fatherId = GeneratedColumn<String?>(
      'father_id', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _sonIdMeta = const VerificationMeta('sonId');
  @override
  late final GeneratedColumn<String?> sonId = GeneratedColumn<String?>(
      'son_id', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String?> id = GeneratedColumn<String?>(
      'id', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
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
  List<GeneratedColumn> get $columns =>
      [fatherId, sonId, id, createdAt, updatedAt];
  @override
  String get aliasedName => _alias ?? 'r_assisted_memory_fragment2_fragment';
  @override
  String get actualTableName => 'r_assisted_memory_fragment2_fragment';
  @override
  VerificationContext validateIntegrity(
      Insertable<RAssistedMemoryFragment2FragmentData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('father_id')) {
      context.handle(_fatherIdMeta,
          fatherId.isAcceptableOrUnknown(data['father_id']!, _fatherIdMeta));
    }
    if (data.containsKey('son_id')) {
      context.handle(
          _sonIdMeta, sonId.isAcceptableOrUnknown(data['son_id']!, _sonIdMeta));
    } else if (isInserting) {
      context.missing(_sonIdMeta);
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
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
  RAssistedMemoryFragment2FragmentData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    return RAssistedMemoryFragment2FragmentData.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $RAssistedMemoryFragment2FragmentTable createAlias(String alias) {
    return $RAssistedMemoryFragment2FragmentTable(attachedDatabase, alias);
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
  String rowId;
  SyncCurdType? syncCurdType;

  /// 当为 [SyncCurdType.u] 时，[syncUpdateColumns] 不能为空。
  ///
  /// 值为字段名，如：'username,password'(字段名不能带有空格或英文逗号)
  ///
  /// TODO: 可以去掉让整行都更新。
  String? syncUpdateColumns;

  /// 同组标识符，可以看 [SyncTag]。
  ///
  /// 当多行 sync 是由同一事务或同一组合的操作时, 需要对这些行设置相同的 tag。
  ///
  /// 当进行上传时, 会将具有相同 tag 的行, 组成一组进行上传，再由云端对该组进行事务操作。
  ///
  /// 仅对 [CloudTableBase] 的子类表生效。
  /// 每组 tag 具有唯一性.
  int tag;
  Sync(
      {required this.id,
      required this.createdAt,
      required this.updatedAt,
      required this.syncTableName,
      required this.rowId,
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
      rowId: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}row_id'])!,
      syncCurdType: $SyncsTable.$converter0.mapToDart(const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}sync_curd_type'])),
      syncUpdateColumns: const StringType().mapFromDatabaseResponse(
          data['${effectivePrefix}sync_update_columns']),
      tag: const IntType()
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
    map['row_id'] = Variable<String>(rowId);
    if (!nullToAbsent || syncCurdType != null) {
      final converter = $SyncsTable.$converter0;
      map['sync_curd_type'] = Variable<int?>(converter.mapToSql(syncCurdType));
    }
    if (!nullToAbsent || syncUpdateColumns != null) {
      map['sync_update_columns'] = Variable<String?>(syncUpdateColumns);
    }
    map['tag'] = Variable<int>(tag);
    return map;
  }

  SyncsCompanion toCompanion(bool nullToAbsent) {
    return SyncsCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      syncTableName: Value(syncTableName),
      rowId: Value(rowId),
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
      rowId: serializer.fromJson<String>(json['rowId']),
      syncCurdType: serializer.fromJson<SyncCurdType?>(json['syncCurdType']),
      syncUpdateColumns:
          serializer.fromJson<String?>(json['syncUpdateColumns']),
      tag: serializer.fromJson<int>(json['tag']),
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
      'rowId': serializer.toJson<String>(rowId),
      'syncCurdType': serializer.toJson<SyncCurdType?>(syncCurdType),
      'syncUpdateColumns': serializer.toJson<String?>(syncUpdateColumns),
      'tag': serializer.toJson<int>(tag),
    };
  }

  Sync copyWith(
          {int? id,
          DateTime? createdAt,
          DateTime? updatedAt,
          String? syncTableName,
          String? rowId,
          SyncCurdType? syncCurdType,
          String? syncUpdateColumns,
          int? tag}) =>
      Sync(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        syncTableName: syncTableName ?? this.syncTableName,
        rowId: rowId ?? this.rowId,
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
          ..write('syncCurdType: $syncCurdType, ')
          ..write('syncUpdateColumns: $syncUpdateColumns, ')
          ..write('tag: $tag')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, createdAt, updatedAt, syncTableName,
      rowId, syncCurdType, syncUpdateColumns, tag);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Sync &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.syncTableName == this.syncTableName &&
          other.rowId == this.rowId &&
          other.syncCurdType == this.syncCurdType &&
          other.syncUpdateColumns == this.syncUpdateColumns &&
          other.tag == this.tag);
}

class SyncsCompanion extends UpdateCompanion<Sync> {
  Value<int> id;
  Value<DateTime> createdAt;
  Value<DateTime> updatedAt;
  Value<String> syncTableName;
  Value<String> rowId;
  Value<SyncCurdType?> syncCurdType;
  Value<String?> syncUpdateColumns;
  Value<int> tag;
  SyncsCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncTableName = const Value.absent(),
    this.rowId = const Value.absent(),
    this.syncCurdType = const Value.absent(),
    this.syncUpdateColumns = const Value.absent(),
    this.tag = const Value.absent(),
  });
  SyncsCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required String syncTableName,
    required String rowId,
    this.syncCurdType = const Value.absent(),
    this.syncUpdateColumns = const Value.absent(),
    required int tag,
  })  : syncTableName = Value(syncTableName),
        rowId = Value(rowId),
        tag = Value(tag);
  static Insertable<Sync> custom({
    Expression<int>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? syncTableName,
    Expression<String>? rowId,
    Expression<SyncCurdType?>? syncCurdType,
    Expression<String?>? syncUpdateColumns,
    Expression<int>? tag,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (syncTableName != null) 'sync_table_name': syncTableName,
      if (rowId != null) 'row_id': rowId,
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
      Value<String>? rowId,
      Value<SyncCurdType?>? syncCurdType,
      Value<String?>? syncUpdateColumns,
      Value<int>? tag}) {
    return SyncsCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      syncTableName: syncTableName ?? this.syncTableName,
      rowId: rowId ?? this.rowId,
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
      map['row_id'] = Variable<String>(rowId.value);
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
      map['tag'] = Variable<int>(tag.value);
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
  late final GeneratedColumn<String?> rowId = GeneratedColumn<String?>(
      'row_id', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
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
  late final GeneratedColumn<int?> tag = GeneratedColumn<int?>(
      'tag', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        createdAt,
        updatedAt,
        syncTableName,
        rowId,
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
  late final $RFragment2FragmentGroupsTable rFragment2FragmentGroups =
      $RFragment2FragmentGroupsTable(this);
  late final $RFragment2MemoryGroupsTable rFragment2MemoryGroups =
      $RFragment2MemoryGroupsTable(this);
  late final $RMemoryModel2MemoryGroupsTable rMemoryModel2MemoryGroups =
      $RMemoryModel2MemoryGroupsTable(this);
  late final $RAssistedMemoryFragment2FragmentTable
      rAssistedMemoryFragment2Fragment =
      $RAssistedMemoryFragment2FragmentTable(this);
  late final $AppInfosTable appInfos = $AppInfosTable(this);
  late final $SyncsTable syncs = $SyncsTable(this);
  late final SingleDAO singleDAO = SingleDAO(this as DriftDb);
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
        rFragment2FragmentGroups,
        rFragment2MemoryGroups,
        rMemoryModel2MemoryGroups,
        rAssistedMemoryFragment2Fragment,
        appInfos,
        syncs
      ];
}

// **************************************************************************
// DaoGenerator
// **************************************************************************

mixin _$SingleDAOMixin on DatabaseAccessor<DriftDb> {
  $UsersTable get users => attachedDatabase.users;
  $FragmentsTable get fragments => attachedDatabase.fragments;
  $FragmentGroupsTable get fragmentGroups => attachedDatabase.fragmentGroups;
  $MemoryGroupsTable get memoryGroups => attachedDatabase.memoryGroups;
  $MemoryModelsTable get memoryModels => attachedDatabase.memoryModels;
  $FragmentPermanentMemoryInfosTable get fragmentPermanentMemoryInfos =>
      attachedDatabase.fragmentPermanentMemoryInfos;
  $RFragment2FragmentGroupsTable get rFragment2FragmentGroups =>
      attachedDatabase.rFragment2FragmentGroups;
  $RFragment2MemoryGroupsTable get rFragment2MemoryGroups =>
      attachedDatabase.rFragment2MemoryGroups;
  $RMemoryModel2MemoryGroupsTable get rMemoryModel2MemoryGroups =>
      attachedDatabase.rMemoryModel2MemoryGroups;
  $RAssistedMemoryFragment2FragmentTable get rAssistedMemoryFragment2Fragment =>
      attachedDatabase.rAssistedMemoryFragment2Fragment;
}
