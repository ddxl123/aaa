// GENERATED CODE - DO NOT MODIFY BY HAND

part of drift_db;

// **************************************************************************
// DriftDatabaseGenerator
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
  String password;
  String email;
  int age;
  User(
      {required this.id,
      required this.createdAt,
      required this.updatedAt,
      required this.username,
      required this.password,
      required this.email,
      required this.age});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['username'] = Variable<String>(username);
    map['password'] = Variable<String>(password);
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
      password: Value(password),
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
      password: serializer.fromJson<String>(json['password']),
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
      'password': serializer.toJson<String>(password),
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
  Value<String> password;
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
    required String username,
    required String password,
    required String email,
    required int age,
  })  : id = Value(id),
        username = Value(username),
        password = Value(password),
        email = Value(email),
        age = Value(age);
  static Insertable<User> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? username,
    Expression<String>? password,
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
      Value<String>? password,
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
      map['password'] = Variable<String>(password.value);
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
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now());
  final VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now());
  final VerificationMeta _usernameMeta = const VerificationMeta('username');
  @override
  late final GeneratedColumn<String> username = GeneratedColumn<String>(
      'username', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _passwordMeta = const VerificationMeta('password');
  @override
  late final GeneratedColumn<String> password = GeneratedColumn<String>(
      'password', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
      'email', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _ageMeta = const VerificationMeta('age');
  @override
  late final GeneratedColumn<int> age = GeneratedColumn<int>(
      'age', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
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
    } else if (isInserting) {
      context.missing(_usernameMeta);
    }
    if (data.containsKey('password')) {
      context.handle(_passwordMeta,
          password.isAcceptableOrUnknown(data['password']!, _passwordMeta));
    } else if (isInserting) {
      context.missing(_passwordMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('age')) {
      context.handle(
          _ageMeta, age.isAcceptableOrUnknown(data['age']!, _ageMeta));
    } else if (isInserting) {
      context.missing(_ageMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  User map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return User(
      id: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      createdAt: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      username: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}username'])!,
      password: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}password'])!,
      email: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}email'])!,
      age: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}age'])!,
    );
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
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || fatherFragmentId != null) {
      map['father_fragment_id'] = Variable<String>(fatherFragmentId);
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
          Value<String?> fatherFragmentId = const Value.absent(),
          String? title,
          int? priority}) =>
      Fragment(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        fatherFragmentId: fatherFragmentId.present
            ? fatherFragmentId.value
            : this.fatherFragmentId,
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
    required String title,
    required int priority,
  })  : id = Value(id),
        title = Value(title),
        priority = Value(priority);
  static Insertable<Fragment> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? fatherFragmentId,
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
      map['father_fragment_id'] = Variable<String>(fatherFragmentId.value);
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
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now());
  final VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now());
  final VerificationMeta _fatherFragmentIdMeta =
      const VerificationMeta('fatherFragmentId');
  @override
  late final GeneratedColumn<String> fatherFragmentId = GeneratedColumn<String>(
      'father_fragment_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  final VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _priorityMeta = const VerificationMeta('priority');
  @override
  late final GeneratedColumn<int> priority = GeneratedColumn<int>(
      'priority', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
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
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('priority')) {
      context.handle(_priorityMeta,
          priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta));
    } else if (isInserting) {
      context.missing(_priorityMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Fragment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Fragment(
      id: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      createdAt: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      fatherFragmentId: attachedDatabase.options.types.read(
          DriftSqlType.string, data['${effectivePrefix}father_fragment_id']),
      title: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      priority: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}priority'])!,
    );
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
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || fatherFragmentGroupId != null) {
      map['father_fragment_group_id'] = Variable<String>(fatherFragmentGroupId);
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
          Value<String?> fatherFragmentGroupId = const Value.absent(),
          String? title}) =>
      FragmentGroup(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        fatherFragmentGroupId: fatherFragmentGroupId.present
            ? fatherFragmentGroupId.value
            : this.fatherFragmentGroupId,
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
    required String title,
  })  : id = Value(id),
        title = Value(title);
  static Insertable<FragmentGroup> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? fatherFragmentGroupId,
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
          Variable<String>(fatherFragmentGroupId.value);
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
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now());
  final VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now());
  final VerificationMeta _fatherFragmentGroupIdMeta =
      const VerificationMeta('fatherFragmentGroupId');
  @override
  late final GeneratedColumn<String> fatherFragmentGroupId =
      GeneratedColumn<String>('father_fragment_group_id', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  final VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
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
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FragmentGroup map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FragmentGroup(
      id: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      createdAt: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      fatherFragmentGroupId: attachedDatabase.options.types.read(
          DriftSqlType.string,
          data['${effectivePrefix}father_fragment_group_id']),
      title: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
    );
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
  String? memoryModelId;
  String title;
  MemoryGroupType type;
  MemoryGroupStatus status;

  /// 新学数量
  int newLearnCount;

  /// 取用 [reviewInterval] 时间点内的复习碎片。
  DateTime reviewInterval;

  /// 过滤碎片
  String filterOut;

  /// 新旧碎片展示先后顺序。
  NewReviewDisplayOrder newReviewDisplayOrder;

  /// 新碎片展示先后顺序。
  NewDisplayOrder newDisplayOrder;
  MemoryGroup(
      {required this.id,
      required this.createdAt,
      required this.updatedAt,
      this.memoryModelId,
      required this.title,
      required this.type,
      required this.status,
      required this.newLearnCount,
      required this.reviewInterval,
      required this.filterOut,
      required this.newReviewDisplayOrder,
      required this.newDisplayOrder});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || memoryModelId != null) {
      map['memory_model_id'] = Variable<String>(memoryModelId);
    }
    map['title'] = Variable<String>(title);
    {
      final converter = $MemoryGroupsTable.$converter0;
      map['type'] = Variable<int>(converter.toSql(type));
    }
    {
      final converter = $MemoryGroupsTable.$converter1;
      map['status'] = Variable<int>(converter.toSql(status));
    }
    map['new_learn_count'] = Variable<int>(newLearnCount);
    map['review_interval'] = Variable<DateTime>(reviewInterval);
    map['filter_out'] = Variable<String>(filterOut);
    {
      final converter = $MemoryGroupsTable.$converter2;
      map['new_review_display_order'] =
          Variable<int>(converter.toSql(newReviewDisplayOrder));
    }
    {
      final converter = $MemoryGroupsTable.$converter3;
      map['new_display_order'] =
          Variable<int>(converter.toSql(newDisplayOrder));
    }
    return map;
  }

  MemoryGroupsCompanion toCompanion(bool nullToAbsent) {
    return MemoryGroupsCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      memoryModelId: memoryModelId == null && nullToAbsent
          ? const Value.absent()
          : Value(memoryModelId),
      title: Value(title),
      type: Value(type),
      status: Value(status),
      newLearnCount: Value(newLearnCount),
      reviewInterval: Value(reviewInterval),
      filterOut: Value(filterOut),
      newReviewDisplayOrder: Value(newReviewDisplayOrder),
      newDisplayOrder: Value(newDisplayOrder),
    );
  }

  factory MemoryGroup.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MemoryGroup(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      memoryModelId: serializer.fromJson<String?>(json['memoryModelId']),
      title: serializer.fromJson<String>(json['title']),
      type: serializer.fromJson<MemoryGroupType>(json['type']),
      status: serializer.fromJson<MemoryGroupStatus>(json['status']),
      newLearnCount: serializer.fromJson<int>(json['newLearnCount']),
      reviewInterval: serializer.fromJson<DateTime>(json['reviewInterval']),
      filterOut: serializer.fromJson<String>(json['filterOut']),
      newReviewDisplayOrder: serializer
          .fromJson<NewReviewDisplayOrder>(json['newReviewDisplayOrder']),
      newDisplayOrder:
          serializer.fromJson<NewDisplayOrder>(json['newDisplayOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'memoryModelId': serializer.toJson<String?>(memoryModelId),
      'title': serializer.toJson<String>(title),
      'type': serializer.toJson<MemoryGroupType>(type),
      'status': serializer.toJson<MemoryGroupStatus>(status),
      'newLearnCount': serializer.toJson<int>(newLearnCount),
      'reviewInterval': serializer.toJson<DateTime>(reviewInterval),
      'filterOut': serializer.toJson<String>(filterOut),
      'newReviewDisplayOrder':
          serializer.toJson<NewReviewDisplayOrder>(newReviewDisplayOrder),
      'newDisplayOrder': serializer.toJson<NewDisplayOrder>(newDisplayOrder),
    };
  }

  MemoryGroup copyWith(
          {String? id,
          DateTime? createdAt,
          DateTime? updatedAt,
          Value<String?> memoryModelId = const Value.absent(),
          String? title,
          MemoryGroupType? type,
          MemoryGroupStatus? status,
          int? newLearnCount,
          DateTime? reviewInterval,
          String? filterOut,
          NewReviewDisplayOrder? newReviewDisplayOrder,
          NewDisplayOrder? newDisplayOrder}) =>
      MemoryGroup(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        memoryModelId:
            memoryModelId.present ? memoryModelId.value : this.memoryModelId,
        title: title ?? this.title,
        type: type ?? this.type,
        status: status ?? this.status,
        newLearnCount: newLearnCount ?? this.newLearnCount,
        reviewInterval: reviewInterval ?? this.reviewInterval,
        filterOut: filterOut ?? this.filterOut,
        newReviewDisplayOrder:
            newReviewDisplayOrder ?? this.newReviewDisplayOrder,
        newDisplayOrder: newDisplayOrder ?? this.newDisplayOrder,
      );
  @override
  String toString() {
    return (StringBuffer('MemoryGroup(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('memoryModelId: $memoryModelId, ')
          ..write('title: $title, ')
          ..write('type: $type, ')
          ..write('status: $status, ')
          ..write('newLearnCount: $newLearnCount, ')
          ..write('reviewInterval: $reviewInterval, ')
          ..write('filterOut: $filterOut, ')
          ..write('newReviewDisplayOrder: $newReviewDisplayOrder, ')
          ..write('newDisplayOrder: $newDisplayOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      createdAt,
      updatedAt,
      memoryModelId,
      title,
      type,
      status,
      newLearnCount,
      reviewInterval,
      filterOut,
      newReviewDisplayOrder,
      newDisplayOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MemoryGroup &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.memoryModelId == this.memoryModelId &&
          other.title == this.title &&
          other.type == this.type &&
          other.status == this.status &&
          other.newLearnCount == this.newLearnCount &&
          other.reviewInterval == this.reviewInterval &&
          other.filterOut == this.filterOut &&
          other.newReviewDisplayOrder == this.newReviewDisplayOrder &&
          other.newDisplayOrder == this.newDisplayOrder);
}

class MemoryGroupsCompanion extends UpdateCompanion<MemoryGroup> {
  Value<String> id;
  Value<DateTime> createdAt;
  Value<DateTime> updatedAt;
  Value<String?> memoryModelId;
  Value<String> title;
  Value<MemoryGroupType> type;
  Value<MemoryGroupStatus> status;
  Value<int> newLearnCount;
  Value<DateTime> reviewInterval;
  Value<String> filterOut;
  Value<NewReviewDisplayOrder> newReviewDisplayOrder;
  Value<NewDisplayOrder> newDisplayOrder;
  MemoryGroupsCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.memoryModelId = const Value.absent(),
    this.title = const Value.absent(),
    this.type = const Value.absent(),
    this.status = const Value.absent(),
    this.newLearnCount = const Value.absent(),
    this.reviewInterval = const Value.absent(),
    this.filterOut = const Value.absent(),
    this.newReviewDisplayOrder = const Value.absent(),
    this.newDisplayOrder = const Value.absent(),
  });
  MemoryGroupsCompanion.insert({
    required String id,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.memoryModelId = const Value.absent(),
    required String title,
    required MemoryGroupType type,
    required MemoryGroupStatus status,
    required int newLearnCount,
    required DateTime reviewInterval,
    required String filterOut,
    required NewReviewDisplayOrder newReviewDisplayOrder,
    required NewDisplayOrder newDisplayOrder,
  })  : id = Value(id),
        title = Value(title),
        type = Value(type),
        status = Value(status),
        newLearnCount = Value(newLearnCount),
        reviewInterval = Value(reviewInterval),
        filterOut = Value(filterOut),
        newReviewDisplayOrder = Value(newReviewDisplayOrder),
        newDisplayOrder = Value(newDisplayOrder);
  static Insertable<MemoryGroup> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? memoryModelId,
    Expression<String>? title,
    Expression<int>? type,
    Expression<int>? status,
    Expression<int>? newLearnCount,
    Expression<DateTime>? reviewInterval,
    Expression<String>? filterOut,
    Expression<int>? newReviewDisplayOrder,
    Expression<int>? newDisplayOrder,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (memoryModelId != null) 'memory_model_id': memoryModelId,
      if (title != null) 'title': title,
      if (type != null) 'type': type,
      if (status != null) 'status': status,
      if (newLearnCount != null) 'new_learn_count': newLearnCount,
      if (reviewInterval != null) 'review_interval': reviewInterval,
      if (filterOut != null) 'filter_out': filterOut,
      if (newReviewDisplayOrder != null)
        'new_review_display_order': newReviewDisplayOrder,
      if (newDisplayOrder != null) 'new_display_order': newDisplayOrder,
    });
  }

  MemoryGroupsCompanion copyWith(
      {Value<String>? id,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<String?>? memoryModelId,
      Value<String>? title,
      Value<MemoryGroupType>? type,
      Value<MemoryGroupStatus>? status,
      Value<int>? newLearnCount,
      Value<DateTime>? reviewInterval,
      Value<String>? filterOut,
      Value<NewReviewDisplayOrder>? newReviewDisplayOrder,
      Value<NewDisplayOrder>? newDisplayOrder}) {
    return MemoryGroupsCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      memoryModelId: memoryModelId ?? this.memoryModelId,
      title: title ?? this.title,
      type: type ?? this.type,
      status: status ?? this.status,
      newLearnCount: newLearnCount ?? this.newLearnCount,
      reviewInterval: reviewInterval ?? this.reviewInterval,
      filterOut: filterOut ?? this.filterOut,
      newReviewDisplayOrder:
          newReviewDisplayOrder ?? this.newReviewDisplayOrder,
      newDisplayOrder: newDisplayOrder ?? this.newDisplayOrder,
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
    if (memoryModelId.present) {
      map['memory_model_id'] = Variable<String>(memoryModelId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (type.present) {
      final converter = $MemoryGroupsTable.$converter0;
      map['type'] = Variable<int>(converter.toSql(type.value));
    }
    if (status.present) {
      final converter = $MemoryGroupsTable.$converter1;
      map['status'] = Variable<int>(converter.toSql(status.value));
    }
    if (newLearnCount.present) {
      map['new_learn_count'] = Variable<int>(newLearnCount.value);
    }
    if (reviewInterval.present) {
      map['review_interval'] = Variable<DateTime>(reviewInterval.value);
    }
    if (filterOut.present) {
      map['filter_out'] = Variable<String>(filterOut.value);
    }
    if (newReviewDisplayOrder.present) {
      final converter = $MemoryGroupsTable.$converter2;
      map['new_review_display_order'] =
          Variable<int>(converter.toSql(newReviewDisplayOrder.value));
    }
    if (newDisplayOrder.present) {
      final converter = $MemoryGroupsTable.$converter3;
      map['new_display_order'] =
          Variable<int>(converter.toSql(newDisplayOrder.value));
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MemoryGroupsCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('memoryModelId: $memoryModelId, ')
          ..write('title: $title, ')
          ..write('type: $type, ')
          ..write('status: $status, ')
          ..write('newLearnCount: $newLearnCount, ')
          ..write('reviewInterval: $reviewInterval, ')
          ..write('filterOut: $filterOut, ')
          ..write('newReviewDisplayOrder: $newReviewDisplayOrder, ')
          ..write('newDisplayOrder: $newDisplayOrder')
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
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now());
  final VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now());
  final VerificationMeta _memoryModelIdMeta =
      const VerificationMeta('memoryModelId');
  @override
  late final GeneratedColumn<String> memoryModelId = GeneratedColumn<String>(
      'memory_model_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  final VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumnWithTypeConverter<MemoryGroupType, int> type =
      GeneratedColumn<int>('type', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<MemoryGroupType>($MemoryGroupsTable.$converter0);
  final VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumnWithTypeConverter<MemoryGroupStatus, int> status =
      GeneratedColumn<int>('status', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<MemoryGroupStatus>($MemoryGroupsTable.$converter1);
  final VerificationMeta _newLearnCountMeta =
      const VerificationMeta('newLearnCount');
  @override
  late final GeneratedColumn<int> willNewLearnCount = GeneratedColumn<int>(
      'new_learn_count', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  final VerificationMeta _reviewIntervalMeta =
      const VerificationMeta('reviewInterval');
  @override
  late final GeneratedColumn<DateTime> reviewInterval =
      GeneratedColumn<DateTime>('review_interval', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  final VerificationMeta _filterOutMeta = const VerificationMeta('filterOut');
  @override
  late final GeneratedColumn<String> filterOut = GeneratedColumn<String>(
      'filter_out', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _newReviewDisplayOrderMeta =
      const VerificationMeta('newReviewDisplayOrder');
  @override
  late final GeneratedColumnWithTypeConverter<NewReviewDisplayOrder, int>
      newReviewDisplayOrder = GeneratedColumn<int>(
              'new_review_display_order', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<NewReviewDisplayOrder>($MemoryGroupsTable.$converter2);
  final VerificationMeta _newDisplayOrderMeta =
      const VerificationMeta('newDisplayOrder');
  @override
  late final GeneratedColumnWithTypeConverter<NewDisplayOrder, int>
      newDisplayOrder = GeneratedColumn<int>(
              'new_display_order', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<NewDisplayOrder>($MemoryGroupsTable.$converter3);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        createdAt,
        updatedAt,
        memoryModelId,
        title,
        type,
        status,
        willNewLearnCount,
        reviewInterval,
        filterOut,
        newReviewDisplayOrder,
        newDisplayOrder
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
    if (data.containsKey('memory_model_id')) {
      context.handle(
          _memoryModelIdMeta,
          memoryModelId.isAcceptableOrUnknown(
              data['memory_model_id']!, _memoryModelIdMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    context.handle(_typeMeta, const VerificationResult.success());
    context.handle(_statusMeta, const VerificationResult.success());
    if (data.containsKey('new_learn_count')) {
      context.handle(
          _newLearnCountMeta,
          willNewLearnCount.isAcceptableOrUnknown(
              data['new_learn_count']!, _newLearnCountMeta));
    } else if (isInserting) {
      context.missing(_newLearnCountMeta);
    }
    if (data.containsKey('review_interval')) {
      context.handle(
          _reviewIntervalMeta,
          reviewInterval.isAcceptableOrUnknown(
              data['review_interval']!, _reviewIntervalMeta));
    } else if (isInserting) {
      context.missing(_reviewIntervalMeta);
    }
    if (data.containsKey('filter_out')) {
      context.handle(_filterOutMeta,
          filterOut.isAcceptableOrUnknown(data['filter_out']!, _filterOutMeta));
    } else if (isInserting) {
      context.missing(_filterOutMeta);
    }
    context.handle(
        _newReviewDisplayOrderMeta, const VerificationResult.success());
    context.handle(_newDisplayOrderMeta, const VerificationResult.success());
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MemoryGroup map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MemoryGroup(
      id: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      createdAt: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      memoryModelId: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}memory_model_id']),
      title: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      type: $MemoryGroupsTable.$converter0.fromSql(attachedDatabase
          .options.types
          .read(DriftSqlType.int, data['${effectivePrefix}type'])!),
      status: $MemoryGroupsTable.$converter1.fromSql(attachedDatabase
          .options.types
          .read(DriftSqlType.int, data['${effectivePrefix}status'])!),
      newLearnCount: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}new_learn_count'])!,
      reviewInterval: attachedDatabase.options.types.read(
          DriftSqlType.dateTime, data['${effectivePrefix}review_interval'])!,
      filterOut: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}filter_out'])!,
      newReviewDisplayOrder: $MemoryGroupsTable.$converter2.fromSql(
          attachedDatabase.options.types.read(DriftSqlType.int,
              data['${effectivePrefix}new_review_display_order'])!),
      newDisplayOrder: $MemoryGroupsTable.$converter3.fromSql(
          attachedDatabase.options.types.read(
              DriftSqlType.int, data['${effectivePrefix}new_display_order'])!),
    );
  }

  @override
  $MemoryGroupsTable createAlias(String alias) {
    return $MemoryGroupsTable(attachedDatabase, alias);
  }

  static TypeConverter<MemoryGroupType, int> $converter0 =
      const EnumIndexConverter<MemoryGroupType>(MemoryGroupType.values);
  static TypeConverter<MemoryGroupStatus, int> $converter1 =
      const EnumIndexConverter<MemoryGroupStatus>(MemoryGroupStatus.values);
  static TypeConverter<NewReviewDisplayOrder, int> $converter2 =
      const EnumIndexConverter<NewReviewDisplayOrder>(
          NewReviewDisplayOrder.values);
  static TypeConverter<NewDisplayOrder, int> $converter3 =
      const EnumIndexConverter<NewDisplayOrder>(NewDisplayOrder.values);
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

  /// <在点击按钮时>，评估碎片熟悉度变化的算法。
  ///
  /// 每次展示并点击按钮后，将输入以下变量，计算出新的熟悉度函数曲线。
  /// 注意：是 [每次展示并点击按钮 后 ，将输入以下变量]，而非 [每次点击按钮前，或每次展示前，或每次展示后且点击按钮前...]。
  ///
  /// y=f(x) 是一个任意函数。
  ///   1. 一般来讲，若熟悉度的范围为0%~100%，则需要将其表示为 0~1 或 0.0~1.0。例如，熟悉度 50%，则需要写成 0.5，否则%符号无法解析。
  ///   2. 即使熟悉度可能存在范围，但它仍然可以超出范围，例如 -0.5, 1.5...，甚至999.999...
  ///   3. 若想使熟悉度维持在范围之内，则需要将算法进行优化。
  ///       - 例如，在 y=sin(x) 的函数图像中，只要在 0≤x≤pi 范围内，其本身就会被限制在 0≤y≤1。
  ///       - 而当 y<0 时，即使 f(y) 在第二三象限内，但由于 y>=0，因此算法执行时，y 本身就不会小于 0。
  ///   4. "熟悉度"函数曲线的含义不一定非得是对碎片的熟悉程度曲线——f(t)随时间的增大而减小。也可以改变它的含义，例如"熟悉度"函数曲线也可以代表着遗忘程度曲线——f(t)随时间的增大而增大。
  ///   5. 总结：你想让函数曲线是什么样子就可以是什么样子，你想让函数值为多少就可以是多少，你想让 f(t) 的含义是什么就可以是什么。
  ///      甚至，用户可以利用编程知识来编写算法，提供了 if-else/for语句, ??语法糖等。
  String familiarityAlgorithm;

  /// <在点击按钮时>，评估下一次展示的时间点的算法。
  ///
  /// 每次展示并点击按钮后，将输入以下变量，计算出下一次展示的时间点.
  /// 注意：是 [每次展示并点击按钮 后 ，将输入以下变量]，而非 [每次点击按钮前，或每次展示前，或每次展示后且点击按钮前...]。
  String nextTimeAlgorithm;

  /// <在刚展示时>，按钮算法
  String buttonData;

  /// 激发算法
  ///
  /// 在碎片展示时，若满足xxx条件，将展示对应的[激发碎片]，刺激学习者的记忆，以至加深记忆。
  ///
  /// 例如，若在本次展示前，已经满足连续5次点击了'忘记'按钮，则本次将展示对应的[激发碎片]。
  ///
  /// 若不存在对应的[激发碎片]，有两种选择或可能性：
  ///   1. 将默认使用格外的文字代替，来提醒学习者。（仅仅只能是提醒作用）
  ///   2. 对市场上的碎片进行检索，寻找合适的碎片来充当[激发碎片]，
  ///      若处于离线状态，将默认使用 1 代替。
  String stimulateAlgorithm;

  /// 适用群体
  ///
  /// 例如：大一生、高中生
  String applicableGroups;

  /// 适用领域
  ///
  /// 例如：英语、英语-四级英语、语文-高中必备文言文
  String applicableFields;
  MemoryModel(
      {required this.id,
      required this.createdAt,
      required this.updatedAt,
      required this.title,
      required this.familiarityAlgorithm,
      required this.nextTimeAlgorithm,
      required this.buttonData,
      required this.stimulateAlgorithm,
      required this.applicableGroups,
      required this.applicableFields});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['title'] = Variable<String>(title);
    map['familiarity_algorithm'] = Variable<String>(familiarityAlgorithm);
    map['next_time_algorithm'] = Variable<String>(nextTimeAlgorithm);
    map['button_data'] = Variable<String>(buttonData);
    map['stimulate_algorithm'] = Variable<String>(stimulateAlgorithm);
    map['applicable_groups'] = Variable<String>(applicableGroups);
    map['applicable_fields'] = Variable<String>(applicableFields);
    return map;
  }

  MemoryModelsCompanion toCompanion(bool nullToAbsent) {
    return MemoryModelsCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      title: Value(title),
      familiarityAlgorithm: Value(familiarityAlgorithm),
      nextTimeAlgorithm: Value(nextTimeAlgorithm),
      buttonData: Value(buttonData),
      stimulateAlgorithm: Value(stimulateAlgorithm),
      applicableGroups: Value(applicableGroups),
      applicableFields: Value(applicableFields),
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
          serializer.fromJson<String>(json['familiarityAlgorithm']),
      nextTimeAlgorithm: serializer.fromJson<String>(json['nextTimeAlgorithm']),
      buttonData: serializer.fromJson<String>(json['buttonData']),
      stimulateAlgorithm:
          serializer.fromJson<String>(json['stimulateAlgorithm']),
      applicableGroups: serializer.fromJson<String>(json['applicableGroups']),
      applicableFields: serializer.fromJson<String>(json['applicableFields']),
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
      'familiarityAlgorithm': serializer.toJson<String>(familiarityAlgorithm),
      'nextTimeAlgorithm': serializer.toJson<String>(nextTimeAlgorithm),
      'buttonData': serializer.toJson<String>(buttonData),
      'stimulateAlgorithm': serializer.toJson<String>(stimulateAlgorithm),
      'applicableGroups': serializer.toJson<String>(applicableGroups),
      'applicableFields': serializer.toJson<String>(applicableFields),
    };
  }

  MemoryModel copyWith(
          {String? id,
          DateTime? createdAt,
          DateTime? updatedAt,
          String? title,
          String? familiarityAlgorithm,
          String? nextTimeAlgorithm,
          String? buttonData,
          String? stimulateAlgorithm,
          String? applicableGroups,
          String? applicableFields}) =>
      MemoryModel(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        title: title ?? this.title,
        familiarityAlgorithm: familiarityAlgorithm ?? this.familiarityAlgorithm,
        nextTimeAlgorithm: nextTimeAlgorithm ?? this.nextTimeAlgorithm,
        buttonData: buttonData ?? this.buttonData,
        stimulateAlgorithm: stimulateAlgorithm ?? this.stimulateAlgorithm,
        applicableGroups: applicableGroups ?? this.applicableGroups,
        applicableFields: applicableFields ?? this.applicableFields,
      );
  @override
  String toString() {
    return (StringBuffer('MemoryModel(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('title: $title, ')
          ..write('familiarityAlgorithm: $familiarityAlgorithm, ')
          ..write('nextTimeAlgorithm: $nextTimeAlgorithm, ')
          ..write('buttonData: $buttonData, ')
          ..write('stimulateAlgorithm: $stimulateAlgorithm, ')
          ..write('applicableGroups: $applicableGroups, ')
          ..write('applicableFields: $applicableFields')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      createdAt,
      updatedAt,
      title,
      familiarityAlgorithm,
      nextTimeAlgorithm,
      buttonData,
      stimulateAlgorithm,
      applicableGroups,
      applicableFields);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MemoryModel &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.title == this.title &&
          other.familiarityAlgorithm == this.familiarityAlgorithm &&
          other.nextTimeAlgorithm == this.nextTimeAlgorithm &&
          other.buttonData == this.buttonData &&
          other.stimulateAlgorithm == this.stimulateAlgorithm &&
          other.applicableGroups == this.applicableGroups &&
          other.applicableFields == this.applicableFields);
}

class MemoryModelsCompanion extends UpdateCompanion<MemoryModel> {
  Value<String> id;
  Value<DateTime> createdAt;
  Value<DateTime> updatedAt;
  Value<String> title;
  Value<String> familiarityAlgorithm;
  Value<String> nextTimeAlgorithm;
  Value<String> buttonData;
  Value<String> stimulateAlgorithm;
  Value<String> applicableGroups;
  Value<String> applicableFields;
  MemoryModelsCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.title = const Value.absent(),
    this.familiarityAlgorithm = const Value.absent(),
    this.nextTimeAlgorithm = const Value.absent(),
    this.buttonData = const Value.absent(),
    this.stimulateAlgorithm = const Value.absent(),
    this.applicableGroups = const Value.absent(),
    this.applicableFields = const Value.absent(),
  });
  MemoryModelsCompanion.insert({
    required String id,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required String title,
    required String familiarityAlgorithm,
    required String nextTimeAlgorithm,
    required String buttonData,
    required String stimulateAlgorithm,
    required String applicableGroups,
    required String applicableFields,
  })  : id = Value(id),
        title = Value(title),
        familiarityAlgorithm = Value(familiarityAlgorithm),
        nextTimeAlgorithm = Value(nextTimeAlgorithm),
        buttonData = Value(buttonData),
        stimulateAlgorithm = Value(stimulateAlgorithm),
        applicableGroups = Value(applicableGroups),
        applicableFields = Value(applicableFields);
  static Insertable<MemoryModel> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? title,
    Expression<String>? familiarityAlgorithm,
    Expression<String>? nextTimeAlgorithm,
    Expression<String>? buttonData,
    Expression<String>? stimulateAlgorithm,
    Expression<String>? applicableGroups,
    Expression<String>? applicableFields,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (title != null) 'title': title,
      if (familiarityAlgorithm != null)
        'familiarity_algorithm': familiarityAlgorithm,
      if (nextTimeAlgorithm != null) 'next_time_algorithm': nextTimeAlgorithm,
      if (buttonData != null) 'button_data': buttonData,
      if (stimulateAlgorithm != null) 'stimulate_algorithm': stimulateAlgorithm,
      if (applicableGroups != null) 'applicable_groups': applicableGroups,
      if (applicableFields != null) 'applicable_fields': applicableFields,
    });
  }

  MemoryModelsCompanion copyWith(
      {Value<String>? id,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<String>? title,
      Value<String>? familiarityAlgorithm,
      Value<String>? nextTimeAlgorithm,
      Value<String>? buttonData,
      Value<String>? stimulateAlgorithm,
      Value<String>? applicableGroups,
      Value<String>? applicableFields}) {
    return MemoryModelsCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      title: title ?? this.title,
      familiarityAlgorithm: familiarityAlgorithm ?? this.familiarityAlgorithm,
      nextTimeAlgorithm: nextTimeAlgorithm ?? this.nextTimeAlgorithm,
      buttonData: buttonData ?? this.buttonData,
      stimulateAlgorithm: stimulateAlgorithm ?? this.stimulateAlgorithm,
      applicableGroups: applicableGroups ?? this.applicableGroups,
      applicableFields: applicableFields ?? this.applicableFields,
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
          Variable<String>(familiarityAlgorithm.value);
    }
    if (nextTimeAlgorithm.present) {
      map['next_time_algorithm'] = Variable<String>(nextTimeAlgorithm.value);
    }
    if (buttonData.present) {
      map['button_data'] = Variable<String>(buttonData.value);
    }
    if (stimulateAlgorithm.present) {
      map['stimulate_algorithm'] = Variable<String>(stimulateAlgorithm.value);
    }
    if (applicableGroups.present) {
      map['applicable_groups'] = Variable<String>(applicableGroups.value);
    }
    if (applicableFields.present) {
      map['applicable_fields'] = Variable<String>(applicableFields.value);
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
          ..write('nextTimeAlgorithm: $nextTimeAlgorithm, ')
          ..write('buttonData: $buttonData, ')
          ..write('stimulateAlgorithm: $stimulateAlgorithm, ')
          ..write('applicableGroups: $applicableGroups, ')
          ..write('applicableFields: $applicableFields')
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
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now());
  final VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now());
  final VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _familiarityAlgorithmMeta =
      const VerificationMeta('familiarityAlgorithm');
  @override
  late final GeneratedColumn<String> familiarityAlgorithm =
      GeneratedColumn<String>('familiarity_algorithm', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _nextTimeAlgorithmMeta =
      const VerificationMeta('nextTimeAlgorithm');
  @override
  late final GeneratedColumn<String> nextTimeAlgorithm =
      GeneratedColumn<String>('next_time_algorithm', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _buttonDataMeta = const VerificationMeta('buttonData');
  @override
  late final GeneratedColumn<String> buttonData = GeneratedColumn<String>(
      'button_data', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _stimulateAlgorithmMeta =
      const VerificationMeta('stimulateAlgorithm');
  @override
  late final GeneratedColumn<String> stimulateAlgorithm =
      GeneratedColumn<String>('stimulate_algorithm', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _applicableGroupsMeta =
      const VerificationMeta('applicableGroups');
  @override
  late final GeneratedColumn<String> applicableGroups = GeneratedColumn<String>(
      'applicable_groups', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _applicableFieldsMeta =
      const VerificationMeta('applicableFields');
  @override
  late final GeneratedColumn<String> applicableFields = GeneratedColumn<String>(
      'applicable_fields', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        createdAt,
        updatedAt,
        title,
        familiarityAlgorithm,
        nextTimeAlgorithm,
        buttonData,
        stimulateAlgorithm,
        applicableGroups,
        applicableFields
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
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('familiarity_algorithm')) {
      context.handle(
          _familiarityAlgorithmMeta,
          familiarityAlgorithm.isAcceptableOrUnknown(
              data['familiarity_algorithm']!, _familiarityAlgorithmMeta));
    } else if (isInserting) {
      context.missing(_familiarityAlgorithmMeta);
    }
    if (data.containsKey('next_time_algorithm')) {
      context.handle(
          _nextTimeAlgorithmMeta,
          nextTimeAlgorithm.isAcceptableOrUnknown(
              data['next_time_algorithm']!, _nextTimeAlgorithmMeta));
    } else if (isInserting) {
      context.missing(_nextTimeAlgorithmMeta);
    }
    if (data.containsKey('button_data')) {
      context.handle(
          _buttonDataMeta,
          buttonData.isAcceptableOrUnknown(
              data['button_data']!, _buttonDataMeta));
    } else if (isInserting) {
      context.missing(_buttonDataMeta);
    }
    if (data.containsKey('stimulate_algorithm')) {
      context.handle(
          _stimulateAlgorithmMeta,
          stimulateAlgorithm.isAcceptableOrUnknown(
              data['stimulate_algorithm']!, _stimulateAlgorithmMeta));
    } else if (isInserting) {
      context.missing(_stimulateAlgorithmMeta);
    }
    if (data.containsKey('applicable_groups')) {
      context.handle(
          _applicableGroupsMeta,
          applicableGroups.isAcceptableOrUnknown(
              data['applicable_groups']!, _applicableGroupsMeta));
    } else if (isInserting) {
      context.missing(_applicableGroupsMeta);
    }
    if (data.containsKey('applicable_fields')) {
      context.handle(
          _applicableFieldsMeta,
          applicableFields.isAcceptableOrUnknown(
              data['applicable_fields']!, _applicableFieldsMeta));
    } else if (isInserting) {
      context.missing(_applicableFieldsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MemoryModel map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MemoryModel(
      id: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      createdAt: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      title: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      familiarityAlgorithm: attachedDatabase.options.types.read(
          DriftSqlType.string,
          data['${effectivePrefix}familiarity_algorithm'])!,
      nextTimeAlgorithm: attachedDatabase.options.types.read(
          DriftSqlType.string, data['${effectivePrefix}next_time_algorithm'])!,
      buttonData: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}button_data'])!,
      stimulateAlgorithm: attachedDatabase.options.types.read(
          DriftSqlType.string, data['${effectivePrefix}stimulate_algorithm'])!,
      applicableGroups: attachedDatabase.options.types.read(
          DriftSqlType.string, data['${effectivePrefix}applicable_groups'])!,
      applicableFields: attachedDatabase.options.types.read(
          DriftSqlType.string, data['${effectivePrefix}applicable_fields'])!,
    );
  }

  @override
  $MemoryModelsTable createAlias(String alias) {
    return $MemoryModelsTable(attachedDatabase, alias);
  }
}

class FragmentMemoryInfo extends DataClass
    implements Insertable<FragmentMemoryInfo> {
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
  String fragmentId;
  String memoryGroupId;

  /// 在当前记忆组内的，当前记录是否为当前碎片的最新记录。
  /// 在新纪录被创建的同时，需要把旧记录设为 false。
  bool isLatestRecord;

  /// =====
  /// 原本计划展示的时间点。
  DateTime planedShowTime;

  /// 实际展示的时间点。
  DateTime actualShowTime;

  /// 刚展示时的熟练度。
  double clickFamiliarity;

  /// 点击按钮的时间。
  DateTime clickTime;

  /// 点击按钮的按钮数值。
  double clickValue;
  FragmentMemoryInfo(
      {required this.id,
      required this.createdAt,
      required this.updatedAt,
      required this.fragmentId,
      required this.memoryGroupId,
      required this.isLatestRecord,
      required this.planedShowTime,
      required this.actualShowTime,
      required this.clickFamiliarity,
      required this.clickTime,
      required this.clickValue});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['fragment_id'] = Variable<String>(fragmentId);
    map['memory_group_id'] = Variable<String>(memoryGroupId);
    map['is_latest_record'] = Variable<bool>(isLatestRecord);
    map['planed_show_time'] = Variable<DateTime>(planedShowTime);
    map['actual_show_time'] = Variable<DateTime>(actualShowTime);
    map['click_familiarity'] = Variable<double>(clickFamiliarity);
    map['click_time'] = Variable<DateTime>(clickTime);
    map['click_value'] = Variable<double>(clickValue);
    return map;
  }

  FragmentMemoryInfosCompanion toCompanion(bool nullToAbsent) {
    return FragmentMemoryInfosCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      fragmentId: Value(fragmentId),
      memoryGroupId: Value(memoryGroupId),
      isLatestRecord: Value(isLatestRecord),
      planedShowTime: Value(planedShowTime),
      actualShowTime: Value(actualShowTime),
      clickFamiliarity: Value(clickFamiliarity),
      clickTime: Value(clickTime),
      clickValue: Value(clickValue),
    );
  }

  factory FragmentMemoryInfo.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FragmentMemoryInfo(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      fragmentId: serializer.fromJson<String>(json['fragmentId']),
      memoryGroupId: serializer.fromJson<String>(json['memoryGroupId']),
      isLatestRecord: serializer.fromJson<bool>(json['isLatestRecord']),
      planedShowTime: serializer.fromJson<DateTime>(json['planedShowTime']),
      actualShowTime: serializer.fromJson<DateTime>(json['actualShowTime']),
      clickFamiliarity: serializer.fromJson<double>(json['clickFamiliarity']),
      clickTime: serializer.fromJson<DateTime>(json['clickTime']),
      clickValue: serializer.fromJson<double>(json['clickValue']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'fragmentId': serializer.toJson<String>(fragmentId),
      'memoryGroupId': serializer.toJson<String>(memoryGroupId),
      'isLatestRecord': serializer.toJson<bool>(isLatestRecord),
      'planedShowTime': serializer.toJson<DateTime>(planedShowTime),
      'actualShowTime': serializer.toJson<DateTime>(actualShowTime),
      'clickFamiliarity': serializer.toJson<double>(clickFamiliarity),
      'clickTime': serializer.toJson<DateTime>(clickTime),
      'clickValue': serializer.toJson<double>(clickValue),
    };
  }

  FragmentMemoryInfo copyWith(
          {String? id,
          DateTime? createdAt,
          DateTime? updatedAt,
          String? fragmentId,
          String? memoryGroupId,
          bool? isLatestRecord,
          DateTime? planedShowTime,
          DateTime? actualShowTime,
          double? clickFamiliarity,
          DateTime? clickTime,
          double? clickValue}) =>
      FragmentMemoryInfo(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        fragmentId: fragmentId ?? this.fragmentId,
        memoryGroupId: memoryGroupId ?? this.memoryGroupId,
        isLatestRecord: isLatestRecord ?? this.isLatestRecord,
        planedShowTime: planedShowTime ?? this.planedShowTime,
        actualShowTime: actualShowTime ?? this.actualShowTime,
        clickFamiliarity: clickFamiliarity ?? this.clickFamiliarity,
        clickTime: clickTime ?? this.clickTime,
        clickValue: clickValue ?? this.clickValue,
      );
  @override
  String toString() {
    return (StringBuffer('FragmentMemoryInfo(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('fragmentId: $fragmentId, ')
          ..write('memoryGroupId: $memoryGroupId, ')
          ..write('isLatestRecord: $isLatestRecord, ')
          ..write('planedShowTime: $planedShowTime, ')
          ..write('actualShowTime: $actualShowTime, ')
          ..write('clickFamiliarity: $clickFamiliarity, ')
          ..write('clickTime: $clickTime, ')
          ..write('clickValue: $clickValue')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      createdAt,
      updatedAt,
      fragmentId,
      memoryGroupId,
      isLatestRecord,
      planedShowTime,
      actualShowTime,
      clickFamiliarity,
      clickTime,
      clickValue);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FragmentMemoryInfo &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.fragmentId == this.fragmentId &&
          other.memoryGroupId == this.memoryGroupId &&
          other.isLatestRecord == this.isLatestRecord &&
          other.planedShowTime == this.planedShowTime &&
          other.actualShowTime == this.actualShowTime &&
          other.clickFamiliarity == this.clickFamiliarity &&
          other.clickTime == this.clickTime &&
          other.clickValue == this.clickValue);
}

class FragmentMemoryInfosCompanion extends UpdateCompanion<FragmentMemoryInfo> {
  Value<String> id;
  Value<DateTime> createdAt;
  Value<DateTime> updatedAt;
  Value<String> fragmentId;
  Value<String> memoryGroupId;
  Value<bool> isLatestRecord;
  Value<DateTime> planedShowTime;
  Value<DateTime> actualShowTime;
  Value<double> clickFamiliarity;
  Value<DateTime> clickTime;
  Value<double> clickValue;
  FragmentMemoryInfosCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.fragmentId = const Value.absent(),
    this.memoryGroupId = const Value.absent(),
    this.isLatestRecord = const Value.absent(),
    this.planedShowTime = const Value.absent(),
    this.actualShowTime = const Value.absent(),
    this.clickFamiliarity = const Value.absent(),
    this.clickTime = const Value.absent(),
    this.clickValue = const Value.absent(),
  });
  FragmentMemoryInfosCompanion.insert({
    required String id,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required String fragmentId,
    required String memoryGroupId,
    required bool isLatestRecord,
    required DateTime planedShowTime,
    required DateTime actualShowTime,
    required double clickFamiliarity,
    required DateTime clickTime,
    required double clickValue,
  })  : id = Value(id),
        fragmentId = Value(fragmentId),
        memoryGroupId = Value(memoryGroupId),
        isLatestRecord = Value(isLatestRecord),
        planedShowTime = Value(planedShowTime),
        actualShowTime = Value(actualShowTime),
        clickFamiliarity = Value(clickFamiliarity),
        clickTime = Value(clickTime),
        clickValue = Value(clickValue);
  static Insertable<FragmentMemoryInfo> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? fragmentId,
    Expression<String>? memoryGroupId,
    Expression<bool>? isLatestRecord,
    Expression<DateTime>? planedShowTime,
    Expression<DateTime>? actualShowTime,
    Expression<double>? clickFamiliarity,
    Expression<DateTime>? clickTime,
    Expression<double>? clickValue,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (fragmentId != null) 'fragment_id': fragmentId,
      if (memoryGroupId != null) 'memory_group_id': memoryGroupId,
      if (isLatestRecord != null) 'is_latest_record': isLatestRecord,
      if (planedShowTime != null) 'planed_show_time': planedShowTime,
      if (actualShowTime != null) 'actual_show_time': actualShowTime,
      if (clickFamiliarity != null) 'click_familiarity': clickFamiliarity,
      if (clickTime != null) 'click_time': clickTime,
      if (clickValue != null) 'click_value': clickValue,
    });
  }

  FragmentMemoryInfosCompanion copyWith(
      {Value<String>? id,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<String>? fragmentId,
      Value<String>? memoryGroupId,
      Value<bool>? isLatestRecord,
      Value<DateTime>? planedShowTime,
      Value<DateTime>? actualShowTime,
      Value<double>? clickFamiliarity,
      Value<DateTime>? clickTime,
      Value<double>? clickValue}) {
    return FragmentMemoryInfosCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      fragmentId: fragmentId ?? this.fragmentId,
      memoryGroupId: memoryGroupId ?? this.memoryGroupId,
      isLatestRecord: isLatestRecord ?? this.isLatestRecord,
      planedShowTime: planedShowTime ?? this.planedShowTime,
      actualShowTime: actualShowTime ?? this.actualShowTime,
      clickFamiliarity: clickFamiliarity ?? this.clickFamiliarity,
      clickTime: clickTime ?? this.clickTime,
      clickValue: clickValue ?? this.clickValue,
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
      map['fragment_id'] = Variable<String>(fragmentId.value);
    }
    if (memoryGroupId.present) {
      map['memory_group_id'] = Variable<String>(memoryGroupId.value);
    }
    if (isLatestRecord.present) {
      map['is_latest_record'] = Variable<bool>(isLatestRecord.value);
    }
    if (planedShowTime.present) {
      map['planed_show_time'] = Variable<DateTime>(planedShowTime.value);
    }
    if (actualShowTime.present) {
      map['actual_show_time'] = Variable<DateTime>(actualShowTime.value);
    }
    if (clickFamiliarity.present) {
      map['click_familiarity'] = Variable<double>(clickFamiliarity.value);
    }
    if (clickTime.present) {
      map['click_time'] = Variable<DateTime>(clickTime.value);
    }
    if (clickValue.present) {
      map['click_value'] = Variable<double>(clickValue.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FragmentMemoryInfosCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('fragmentId: $fragmentId, ')
          ..write('memoryGroupId: $memoryGroupId, ')
          ..write('isLatestRecord: $isLatestRecord, ')
          ..write('planedShowTime: $planedShowTime, ')
          ..write('actualShowTime: $actualShowTime, ')
          ..write('clickFamiliarity: $clickFamiliarity, ')
          ..write('clickTime: $clickTime, ')
          ..write('clickValue: $clickValue')
          ..write(')'))
        .toString();
  }
}

class $FragmentMemoryInfosTable extends FragmentMemoryInfos
    with TableInfo<$FragmentMemoryInfosTable, FragmentMemoryInfo> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FragmentMemoryInfosTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now());
  final VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now());
  final VerificationMeta _fragmentIdMeta = const VerificationMeta('fragmentId');
  @override
  late final GeneratedColumn<String> fragmentId = GeneratedColumn<String>(
      'fragment_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _memoryGroupIdMeta =
      const VerificationMeta('memoryGroupId');
  @override
  late final GeneratedColumn<String> memoryGroupId = GeneratedColumn<String>(
      'memory_group_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _isLatestRecordMeta =
      const VerificationMeta('isLatestRecord');
  @override
  late final GeneratedColumn<bool> isLatestRecord = GeneratedColumn<bool>(
      'is_latest_record', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: 'CHECK (is_latest_record IN (0, 1))');
  final VerificationMeta _planedShowTimeMeta =
      const VerificationMeta('planedShowTime');
  @override
  late final GeneratedColumn<DateTime> planedShowTime =
      GeneratedColumn<DateTime>('planed_show_time', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  final VerificationMeta _actualShowTimeMeta =
      const VerificationMeta('actualShowTime');
  @override
  late final GeneratedColumn<DateTime> actualShowTime =
      GeneratedColumn<DateTime>('actual_show_time', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  final VerificationMeta _clickFamiliarityMeta =
      const VerificationMeta('clickFamiliarity');
  @override
  late final GeneratedColumn<double> clickFamiliarity = GeneratedColumn<double>(
      'click_familiarity', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  final VerificationMeta _clickTimeMeta = const VerificationMeta('clickTime');
  @override
  late final GeneratedColumn<DateTime> clickTime = GeneratedColumn<DateTime>(
      'click_time', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  final VerificationMeta _clickValueMeta = const VerificationMeta('clickValue');
  @override
  late final GeneratedColumn<double> clickValue = GeneratedColumn<double>(
      'click_value', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        createdAt,
        updatedAt,
        fragmentId,
        memoryGroupId,
        isLatestRecord,
        planedShowTime,
        actualShowTime,
        clickFamiliarity,
        clickTime,
        clickValue
      ];
  @override
  String get aliasedName => _alias ?? 'fragment_memory_infos';
  @override
  String get actualTableName => 'fragment_memory_infos';
  @override
  VerificationContext validateIntegrity(Insertable<FragmentMemoryInfo> instance,
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
    } else if (isInserting) {
      context.missing(_fragmentIdMeta);
    }
    if (data.containsKey('memory_group_id')) {
      context.handle(
          _memoryGroupIdMeta,
          memoryGroupId.isAcceptableOrUnknown(
              data['memory_group_id']!, _memoryGroupIdMeta));
    } else if (isInserting) {
      context.missing(_memoryGroupIdMeta);
    }
    if (data.containsKey('is_latest_record')) {
      context.handle(
          _isLatestRecordMeta,
          isLatestRecord.isAcceptableOrUnknown(
              data['is_latest_record']!, _isLatestRecordMeta));
    } else if (isInserting) {
      context.missing(_isLatestRecordMeta);
    }
    if (data.containsKey('planed_show_time')) {
      context.handle(
          _planedShowTimeMeta,
          planedShowTime.isAcceptableOrUnknown(
              data['planed_show_time']!, _planedShowTimeMeta));
    } else if (isInserting) {
      context.missing(_planedShowTimeMeta);
    }
    if (data.containsKey('actual_show_time')) {
      context.handle(
          _actualShowTimeMeta,
          actualShowTime.isAcceptableOrUnknown(
              data['actual_show_time']!, _actualShowTimeMeta));
    } else if (isInserting) {
      context.missing(_actualShowTimeMeta);
    }
    if (data.containsKey('click_familiarity')) {
      context.handle(
          _clickFamiliarityMeta,
          clickFamiliarity.isAcceptableOrUnknown(
              data['click_familiarity']!, _clickFamiliarityMeta));
    } else if (isInserting) {
      context.missing(_clickFamiliarityMeta);
    }
    if (data.containsKey('click_time')) {
      context.handle(_clickTimeMeta,
          clickTime.isAcceptableOrUnknown(data['click_time']!, _clickTimeMeta));
    } else if (isInserting) {
      context.missing(_clickTimeMeta);
    }
    if (data.containsKey('click_value')) {
      context.handle(
          _clickValueMeta,
          clickValue.isAcceptableOrUnknown(
              data['click_value']!, _clickValueMeta));
    } else if (isInserting) {
      context.missing(_clickValueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FragmentMemoryInfo map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FragmentMemoryInfo(
      id: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      createdAt: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      fragmentId: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}fragment_id'])!,
      memoryGroupId: attachedDatabase.options.types.read(
          DriftSqlType.string, data['${effectivePrefix}memory_group_id'])!,
      isLatestRecord: attachedDatabase.options.types
          .read(DriftSqlType.bool, data['${effectivePrefix}is_latest_record'])!,
      planedShowTime: attachedDatabase.options.types.read(
          DriftSqlType.dateTime, data['${effectivePrefix}planed_show_time'])!,
      actualShowTime: attachedDatabase.options.types.read(
          DriftSqlType.dateTime, data['${effectivePrefix}actual_show_time'])!,
      clickFamiliarity: attachedDatabase.options.types.read(
          DriftSqlType.double, data['${effectivePrefix}click_familiarity'])!,
      clickTime: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}click_time'])!,
      clickValue: attachedDatabase.options.types
          .read(DriftSqlType.double, data['${effectivePrefix}click_value'])!,
    );
  }

  @override
  $FragmentMemoryInfosTable createAlias(String alias) {
    return $FragmentMemoryInfosTable(attachedDatabase, alias);
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
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || fatherId != null) {
      map['father_id'] = Variable<String>(fatherId);
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
          {Value<String?> fatherId = const Value.absent(),
          String? sonId,
          String? id,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      RFragment2FragmentGroup(
        fatherId: fatherId.present ? fatherId.value : this.fatherId,
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
    Expression<String>? fatherId,
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
      map['father_id'] = Variable<String>(fatherId.value);
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
  late final GeneratedColumn<String> fatherId = GeneratedColumn<String>(
      'father_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  final VerificationMeta _sonIdMeta = const VerificationMeta('sonId');
  @override
  late final GeneratedColumn<String> sonId = GeneratedColumn<String>(
      'son_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now());
  final VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
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
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RFragment2FragmentGroup(
      fatherId: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}father_id']),
      sonId: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}son_id'])!,
      id: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      createdAt: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
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
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || fatherId != null) {
      map['father_id'] = Variable<String>(fatherId);
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
          {Value<String?> fatherId = const Value.absent(),
          String? sonId,
          String? id,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      RFragment2MemoryGroup(
        fatherId: fatherId.present ? fatherId.value : this.fatherId,
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
    Expression<String>? fatherId,
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
      map['father_id'] = Variable<String>(fatherId.value);
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
  late final GeneratedColumn<String> fatherId = GeneratedColumn<String>(
      'father_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  final VerificationMeta _sonIdMeta = const VerificationMeta('sonId');
  @override
  late final GeneratedColumn<String> sonId = GeneratedColumn<String>(
      'son_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now());
  final VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
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
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RFragment2MemoryGroup(
      fatherId: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}father_id']),
      sonId: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}son_id'])!,
      id: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      createdAt: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $RFragment2MemoryGroupsTable createAlias(String alias) {
    return $RFragment2MemoryGroupsTable(attachedDatabase, alias);
  }
}

class RAssistedMemory2Fragment extends DataClass
    implements Insertable<RAssistedMemory2Fragment> {
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
  RAssistedMemory2Fragment(
      {this.fatherId,
      required this.sonId,
      required this.id,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || fatherId != null) {
      map['father_id'] = Variable<String>(fatherId);
    }
    map['son_id'] = Variable<String>(sonId);
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  RAssistedMemory2FragmentsCompanion toCompanion(bool nullToAbsent) {
    return RAssistedMemory2FragmentsCompanion(
      fatherId: fatherId == null && nullToAbsent
          ? const Value.absent()
          : Value(fatherId),
      sonId: Value(sonId),
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory RAssistedMemory2Fragment.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RAssistedMemory2Fragment(
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

  RAssistedMemory2Fragment copyWith(
          {Value<String?> fatherId = const Value.absent(),
          String? sonId,
          String? id,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      RAssistedMemory2Fragment(
        fatherId: fatherId.present ? fatherId.value : this.fatherId,
        sonId: sonId ?? this.sonId,
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  @override
  String toString() {
    return (StringBuffer('RAssistedMemory2Fragment(')
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
      (other is RAssistedMemory2Fragment &&
          other.fatherId == this.fatherId &&
          other.sonId == this.sonId &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class RAssistedMemory2FragmentsCompanion
    extends UpdateCompanion<RAssistedMemory2Fragment> {
  Value<String?> fatherId;
  Value<String> sonId;
  Value<String> id;
  Value<DateTime> createdAt;
  Value<DateTime> updatedAt;
  RAssistedMemory2FragmentsCompanion({
    this.fatherId = const Value.absent(),
    this.sonId = const Value.absent(),
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  RAssistedMemory2FragmentsCompanion.insert({
    this.fatherId = const Value.absent(),
    required String sonId,
    required String id,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  })  : sonId = Value(sonId),
        id = Value(id);
  static Insertable<RAssistedMemory2Fragment> custom({
    Expression<String>? fatherId,
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

  RAssistedMemory2FragmentsCompanion copyWith(
      {Value<String?>? fatherId,
      Value<String>? sonId,
      Value<String>? id,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return RAssistedMemory2FragmentsCompanion(
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
      map['father_id'] = Variable<String>(fatherId.value);
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
    return (StringBuffer('RAssistedMemory2FragmentsCompanion(')
          ..write('fatherId: $fatherId, ')
          ..write('sonId: $sonId, ')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $RAssistedMemory2FragmentsTable extends RAssistedMemory2Fragments
    with TableInfo<$RAssistedMemory2FragmentsTable, RAssistedMemory2Fragment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RAssistedMemory2FragmentsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _fatherIdMeta = const VerificationMeta('fatherId');
  @override
  late final GeneratedColumn<String> fatherId = GeneratedColumn<String>(
      'father_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  final VerificationMeta _sonIdMeta = const VerificationMeta('sonId');
  @override
  late final GeneratedColumn<String> sonId = GeneratedColumn<String>(
      'son_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now());
  final VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now());
  @override
  List<GeneratedColumn> get $columns =>
      [fatherId, sonId, id, createdAt, updatedAt];
  @override
  String get aliasedName => _alias ?? 'r_assisted_memory2_fragments';
  @override
  String get actualTableName => 'r_assisted_memory2_fragments';
  @override
  VerificationContext validateIntegrity(
      Insertable<RAssistedMemory2Fragment> instance,
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
  RAssistedMemory2Fragment map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RAssistedMemory2Fragment(
      fatherId: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}father_id']),
      sonId: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}son_id'])!,
      id: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      createdAt: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $RAssistedMemory2FragmentsTable createAlias(String alias) {
    return $RAssistedMemory2FragmentsTable(attachedDatabase, alias);
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
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now());
  final VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now());
  final VerificationMeta _tokenMeta = const VerificationMeta('token');
  @override
  late final GeneratedColumn<String> token = GeneratedColumn<String>(
      'token', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('unknown'));
  final VerificationMeta _hasDownloadedInitDataMeta =
      const VerificationMeta('hasDownloadedInitData');
  @override
  late final GeneratedColumn<bool> hasDownloadedInitData =
      GeneratedColumn<bool>('has_downloaded_init_data', aliasedName, false,
          type: DriftSqlType.bool,
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
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppInfo(
      id: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      createdAt: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      token: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}token'])!,
      hasDownloadedInitData: attachedDatabase.options.types.read(
          DriftSqlType.bool,
          data['${effectivePrefix}has_downloaded_init_data'])!,
    );
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
      required this.tag});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['sync_table_name'] = Variable<String>(syncTableName);
    map['row_id'] = Variable<String>(rowId);
    if (!nullToAbsent || syncCurdType != null) {
      final converter = $SyncsTable.$converter0n;
      map['sync_curd_type'] = Variable<int>(converter.toSql(syncCurdType));
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
      'tag': serializer.toJson<int>(tag),
    };
  }

  Sync copyWith(
          {int? id,
          DateTime? createdAt,
          DateTime? updatedAt,
          String? syncTableName,
          String? rowId,
          Value<SyncCurdType?> syncCurdType = const Value.absent(),
          int? tag}) =>
      Sync(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        syncTableName: syncTableName ?? this.syncTableName,
        rowId: rowId ?? this.rowId,
        syncCurdType:
            syncCurdType.present ? syncCurdType.value : this.syncCurdType,
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
          ..write('tag: $tag')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, createdAt, updatedAt, syncTableName, rowId, syncCurdType, tag);
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
          other.tag == this.tag);
}

class SyncsCompanion extends UpdateCompanion<Sync> {
  Value<int> id;
  Value<DateTime> createdAt;
  Value<DateTime> updatedAt;
  Value<String> syncTableName;
  Value<String> rowId;
  Value<SyncCurdType?> syncCurdType;
  Value<int> tag;
  SyncsCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncTableName = const Value.absent(),
    this.rowId = const Value.absent(),
    this.syncCurdType = const Value.absent(),
    this.tag = const Value.absent(),
  });
  SyncsCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required String syncTableName,
    required String rowId,
    this.syncCurdType = const Value.absent(),
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
    Expression<int>? syncCurdType,
    Expression<int>? tag,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (syncTableName != null) 'sync_table_name': syncTableName,
      if (rowId != null) 'row_id': rowId,
      if (syncCurdType != null) 'sync_curd_type': syncCurdType,
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
      Value<int>? tag}) {
    return SyncsCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      syncTableName: syncTableName ?? this.syncTableName,
      rowId: rowId ?? this.rowId,
      syncCurdType: syncCurdType ?? this.syncCurdType,
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
      final converter = $SyncsTable.$converter0n;
      map['sync_curd_type'] =
          Variable<int>(converter.toSql(syncCurdType.value));
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
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now());
  final VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      clientDefault: () => DateTime.now());
  final VerificationMeta _syncTableNameMeta =
      const VerificationMeta('syncTableName');
  @override
  late final GeneratedColumn<String> syncTableName = GeneratedColumn<String>(
      'sync_table_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _rowIdMeta = const VerificationMeta('rowId');
  @override
  late final GeneratedColumn<String> rowId = GeneratedColumn<String>(
      'row_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _syncCurdTypeMeta =
      const VerificationMeta('syncCurdType');
  @override
  late final GeneratedColumnWithTypeConverter<SyncCurdType?, int> syncCurdType =
      GeneratedColumn<int>('sync_curd_type', aliasedName, true,
              type: DriftSqlType.int, requiredDuringInsert: false)
          .withConverter<SyncCurdType?>($SyncsTable.$converter0n);
  final VerificationMeta _tagMeta = const VerificationMeta('tag');
  @override
  late final GeneratedColumn<int> tag = GeneratedColumn<int>(
      'tag', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, createdAt, updatedAt, syncTableName, rowId, syncCurdType, tag];
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
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Sync(
      id: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      createdAt: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      syncTableName: attachedDatabase.options.types.read(
          DriftSqlType.string, data['${effectivePrefix}sync_table_name'])!,
      rowId: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}row_id'])!,
      syncCurdType: $SyncsTable.$converter0n.fromSql(attachedDatabase
          .options.types
          .read(DriftSqlType.int, data['${effectivePrefix}sync_curd_type'])),
      tag: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}tag'])!,
    );
  }

  @override
  $SyncsTable createAlias(String alias) {
    return $SyncsTable(attachedDatabase, alias);
  }

  static TypeConverter<SyncCurdType, int> $converter0 =
      const EnumIndexConverter<SyncCurdType>(SyncCurdType.values);
  static TypeConverter<SyncCurdType?, int?> $converter0n =
      NullAwareTypeConverter.wrap($converter0);
}

abstract class _$DriftDb extends GeneratedDatabase {
  _$DriftDb(QueryExecutor e) : super(e);
  late final $UsersTable users = $UsersTable(this);
  late final $FragmentsTable fragments = $FragmentsTable(this);
  late final $FragmentGroupsTable fragmentGroups = $FragmentGroupsTable(this);
  late final $MemoryGroupsTable memoryGroups = $MemoryGroupsTable(this);
  late final $MemoryModelsTable memoryModels = $MemoryModelsTable(this);
  late final $FragmentMemoryInfosTable fragmentMemoryInfos =
      $FragmentMemoryInfosTable(this);
  late final $RFragment2FragmentGroupsTable rFragment2FragmentGroups =
      $RFragment2FragmentGroupsTable(this);
  late final $RFragment2MemoryGroupsTable rFragment2MemoryGroups =
      $RFragment2MemoryGroupsTable(this);
  late final $RAssistedMemory2FragmentsTable rAssistedMemory2Fragments =
      $RAssistedMemory2FragmentsTable(this);
  late final $AppInfosTable appInfos = $AppInfosTable(this);
  late final $SyncsTable syncs = $SyncsTable(this);
  late final InsertDAO insertDAO = InsertDAO(this as DriftDb);
  late final UpdateDAO updateDAO = UpdateDAO(this as DriftDb);
  late final QueryDAO queryDAO = QueryDAO(this as DriftDb);
  late final DeleteDAO deleteDAO = DeleteDAO(this as DriftDb);
  @override
  Iterable<TableInfo<Table, dynamic>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        users,
        fragments,
        fragmentGroups,
        memoryGroups,
        memoryModels,
        fragmentMemoryInfos,
        rFragment2FragmentGroups,
        rFragment2MemoryGroups,
        rAssistedMemory2Fragments,
        appInfos,
        syncs
      ];
}

// **************************************************************************
// DaoGenerator
// **************************************************************************

mixin _$QueryDAOMixin on DatabaseAccessor<DriftDb> {
  $UsersTable get users => attachedDatabase.users;
  $FragmentsTable get fragments => attachedDatabase.fragments;
  $FragmentGroupsTable get fragmentGroups => attachedDatabase.fragmentGroups;
  $MemoryGroupsTable get memoryGroups => attachedDatabase.memoryGroups;
  $MemoryModelsTable get memoryModels => attachedDatabase.memoryModels;
  $FragmentMemoryInfosTable get fragmentMemoryInfos =>
      attachedDatabase.fragmentMemoryInfos;
  $RFragment2FragmentGroupsTable get rFragment2FragmentGroups =>
      attachedDatabase.rFragment2FragmentGroups;
  $RFragment2MemoryGroupsTable get rFragment2MemoryGroups =>
      attachedDatabase.rFragment2MemoryGroups;
  $RAssistedMemory2FragmentsTable get rAssistedMemory2Fragments =>
      attachedDatabase.rAssistedMemory2Fragments;
}
mixin _$InsertDAOMixin on DatabaseAccessor<DriftDb> {
  $UsersTable get users => attachedDatabase.users;
  $FragmentsTable get fragments => attachedDatabase.fragments;
  $FragmentGroupsTable get fragmentGroups => attachedDatabase.fragmentGroups;
  $MemoryGroupsTable get memoryGroups => attachedDatabase.memoryGroups;
  $MemoryModelsTable get memoryModels => attachedDatabase.memoryModels;
  $FragmentMemoryInfosTable get fragmentMemoryInfos =>
      attachedDatabase.fragmentMemoryInfos;
  $RFragment2FragmentGroupsTable get rFragment2FragmentGroups =>
      attachedDatabase.rFragment2FragmentGroups;
  $RFragment2MemoryGroupsTable get rFragment2MemoryGroups =>
      attachedDatabase.rFragment2MemoryGroups;
  $RAssistedMemory2FragmentsTable get rAssistedMemory2Fragments =>
      attachedDatabase.rAssistedMemory2Fragments;
}
mixin _$UpdateDAOMixin on DatabaseAccessor<DriftDb> {
  $UsersTable get users => attachedDatabase.users;
  $FragmentsTable get fragments => attachedDatabase.fragments;
  $FragmentGroupsTable get fragmentGroups => attachedDatabase.fragmentGroups;
  $MemoryGroupsTable get memoryGroups => attachedDatabase.memoryGroups;
  $MemoryModelsTable get memoryModels => attachedDatabase.memoryModels;
  $FragmentMemoryInfosTable get fragmentMemoryInfos =>
      attachedDatabase.fragmentMemoryInfos;
  $RFragment2FragmentGroupsTable get rFragment2FragmentGroups =>
      attachedDatabase.rFragment2FragmentGroups;
  $RFragment2MemoryGroupsTable get rFragment2MemoryGroups =>
      attachedDatabase.rFragment2MemoryGroups;
  $RAssistedMemory2FragmentsTable get rAssistedMemory2Fragments =>
      attachedDatabase.rAssistedMemory2Fragments;
}
mixin _$DeleteDAOMixin on DatabaseAccessor<DriftDb> {
  $UsersTable get users => attachedDatabase.users;
  $FragmentsTable get fragments => attachedDatabase.fragments;
  $FragmentGroupsTable get fragmentGroups => attachedDatabase.fragmentGroups;
  $MemoryGroupsTable get memoryGroups => attachedDatabase.memoryGroups;
  $MemoryModelsTable get memoryModels => attachedDatabase.memoryModels;
  $FragmentMemoryInfosTable get fragmentMemoryInfos =>
      attachedDatabase.fragmentMemoryInfos;
  $RFragment2FragmentGroupsTable get rFragment2FragmentGroups =>
      attachedDatabase.rFragment2FragmentGroups;
  $RFragment2MemoryGroupsTable get rFragment2MemoryGroups =>
      attachedDatabase.rFragment2MemoryGroups;
  $RAssistedMemory2FragmentsTable get rAssistedMemory2Fragments =>
      attachedDatabase.rAssistedMemory2Fragments;
}
