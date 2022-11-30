// GENERATED CODE - DO NOT MODIFY BY HAND

part of drift_db;

// **************************************************************************
// DriftDatabaseGenerator
// **************************************************************************

// ignore_for_file: type=lint
class User extends DataClass implements Insertable<User> {
  int age;
  String? email;
  String? password;
  String username;
  DateTime createdAt;
  int id;
  DateTime updatedAt;
  User(
      {required this.age,
      this.email,
      this.password,
      required this.username,
      required this.createdAt,
      required this.id,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['age'] = Variable<int>(age);
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || password != null) {
      map['password'] = Variable<String>(password);
    }
    map['username'] = Variable<String>(username);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['id'] = Variable<int>(id);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      age: Value(age),
      email:
          email == null && nullToAbsent ? const Value.absent() : Value(email),
      password: password == null && nullToAbsent
          ? const Value.absent()
          : Value(password),
      username: Value(username),
      createdAt: Value(createdAt),
      id: Value(id),
      updatedAt: Value(updatedAt),
    );
  }

  factory User.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return User(
      age: serializer.fromJson<int>(json['age']),
      email: serializer.fromJson<String?>(json['email']),
      password: serializer.fromJson<String?>(json['password']),
      username: serializer.fromJson<String>(json['username']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      id: serializer.fromJson<int>(json['id']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'age': serializer.toJson<int>(age),
      'email': serializer.toJson<String?>(email),
      'password': serializer.toJson<String?>(password),
      'username': serializer.toJson<String>(username),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'id': serializer.toJson<int>(id),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  User copyWith(
          {int? age,
          Value<String?> email = const Value.absent(),
          Value<String?> password = const Value.absent(),
          String? username,
          DateTime? createdAt,
          int? id,
          DateTime? updatedAt}) =>
      User(
        age: age ?? this.age,
        email: email.present ? email.value : this.email,
        password: password.present ? password.value : this.password,
        username: username ?? this.username,
        createdAt: createdAt ?? this.createdAt,
        id: id ?? this.id,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('age: $age, ')
          ..write('email: $email, ')
          ..write('password: $password, ')
          ..write('username: $username, ')
          ..write('createdAt: $createdAt, ')
          ..write('id: $id, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(age, email, password, username, createdAt, id, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          other.age == this.age &&
          other.email == this.email &&
          other.password == this.password &&
          other.username == this.username &&
          other.createdAt == this.createdAt &&
          other.id == this.id &&
          other.updatedAt == this.updatedAt);
}

class UsersCompanion extends UpdateCompanion<User> {
  Value<int> age;
  Value<String?> email;
  Value<String?> password;
  Value<String> username;
  Value<DateTime> createdAt;
  Value<int> id;
  Value<DateTime> updatedAt;
  UsersCompanion({
    this.age = const Value.absent(),
    this.email = const Value.absent(),
    this.password = const Value.absent(),
    this.username = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.id = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  UsersCompanion.insert({
    required int age,
    this.email = const Value.absent(),
    this.password = const Value.absent(),
    required String username,
    required DateTime createdAt,
    this.id = const Value.absent(),
    required DateTime updatedAt,
  })  : age = Value(age),
        username = Value(username),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<User> custom({
    Expression<int>? age,
    Expression<String>? email,
    Expression<String>? password,
    Expression<String>? username,
    Expression<DateTime>? createdAt,
    Expression<int>? id,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (age != null) 'age': age,
      if (email != null) 'email': email,
      if (password != null) 'password': password,
      if (username != null) 'username': username,
      if (createdAt != null) 'created_at': createdAt,
      if (id != null) 'id': id,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  UsersCompanion copyWith(
      {Value<int>? age,
      Value<String?>? email,
      Value<String?>? password,
      Value<String>? username,
      Value<DateTime>? createdAt,
      Value<int>? id,
      Value<DateTime>? updatedAt}) {
    return UsersCompanion(
      age: age ?? this.age,
      email: email ?? this.email,
      password: password ?? this.password,
      username: username ?? this.username,
      createdAt: createdAt ?? this.createdAt,
      id: id ?? this.id,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (age.present) {
      map['age'] = Variable<int>(age.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (password.present) {
      map['password'] = Variable<String>(password.value);
    }
    if (username.present) {
      map['username'] = Variable<String>(username.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('age: $age, ')
          ..write('email: $email, ')
          ..write('password: $password, ')
          ..write('username: $username, ')
          ..write('createdAt: $createdAt, ')
          ..write('id: $id, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _ageMeta = const VerificationMeta('age');
  @override
  late final GeneratedColumn<int> age = GeneratedColumn<int>(
      'age', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  final VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
      'email', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  final VerificationMeta _passwordMeta = const VerificationMeta('password');
  @override
  late final GeneratedColumn<String> password = GeneratedColumn<String>(
      'password', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  final VerificationMeta _usernameMeta = const VerificationMeta('username');
  @override
  late final GeneratedColumn<String> username = GeneratedColumn<String>(
      'username', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  final VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [age, email, password, username, createdAt, id, updatedAt];
  @override
  String get aliasedName => _alias ?? 'users';
  @override
  String get actualTableName => 'users';
  @override
  VerificationContext validateIntegrity(Insertable<User> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('age')) {
      context.handle(
          _ageMeta, age.isAcceptableOrUnknown(data['age']!, _ageMeta));
    } else if (isInserting) {
      context.missing(_ageMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    }
    if (data.containsKey('password')) {
      context.handle(_passwordMeta,
          password.isAcceptableOrUnknown(data['password']!, _passwordMeta));
    }
    if (data.containsKey('username')) {
      context.handle(_usernameMeta,
          username.isAcceptableOrUnknown(data['username']!, _usernameMeta));
    } else if (isInserting) {
      context.missing(_usernameMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  User map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return User(
      age: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}age'])!,
      email: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}email']),
      password: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}password']),
      username: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}username'])!,
      createdAt: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      id: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      updatedAt: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }
}

class FragmentMemoryInfo extends DataClass
    implements Insertable<FragmentMemoryInfo> {
  DateTime clickTime;
  double clickValue;
  int creatorUserId;
  DateTime currentActualShowTime;
  String fragmentId;
  bool isLatestRecord;
  String memoryGroupId;
  DateTime nextPlanShowTime;
  double showFamiliarity;
  DateTime createdAt;
  String id;
  DateTime updatedAt;
  FragmentMemoryInfo(
      {required this.clickTime,
      required this.clickValue,
      required this.creatorUserId,
      required this.currentActualShowTime,
      required this.fragmentId,
      required this.isLatestRecord,
      required this.memoryGroupId,
      required this.nextPlanShowTime,
      required this.showFamiliarity,
      required this.createdAt,
      required this.id,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['click_time'] = Variable<DateTime>(clickTime);
    map['click_value'] = Variable<double>(clickValue);
    map['creator_user_id'] = Variable<int>(creatorUserId);
    map['current_actual_show_time'] = Variable<DateTime>(currentActualShowTime);
    map['fragment_id'] = Variable<String>(fragmentId);
    map['is_latest_record'] = Variable<bool>(isLatestRecord);
    map['memory_group_id'] = Variable<String>(memoryGroupId);
    map['next_plan_show_time'] = Variable<DateTime>(nextPlanShowTime);
    map['show_familiarity'] = Variable<double>(showFamiliarity);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['id'] = Variable<String>(id);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  FragmentMemoryInfosCompanion toCompanion(bool nullToAbsent) {
    return FragmentMemoryInfosCompanion(
      clickTime: Value(clickTime),
      clickValue: Value(clickValue),
      creatorUserId: Value(creatorUserId),
      currentActualShowTime: Value(currentActualShowTime),
      fragmentId: Value(fragmentId),
      isLatestRecord: Value(isLatestRecord),
      memoryGroupId: Value(memoryGroupId),
      nextPlanShowTime: Value(nextPlanShowTime),
      showFamiliarity: Value(showFamiliarity),
      createdAt: Value(createdAt),
      id: Value(id),
      updatedAt: Value(updatedAt),
    );
  }

  factory FragmentMemoryInfo.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FragmentMemoryInfo(
      clickTime: serializer.fromJson<DateTime>(json['clickTime']),
      clickValue: serializer.fromJson<double>(json['clickValue']),
      creatorUserId: serializer.fromJson<int>(json['creatorUserId']),
      currentActualShowTime:
          serializer.fromJson<DateTime>(json['currentActualShowTime']),
      fragmentId: serializer.fromJson<String>(json['fragmentId']),
      isLatestRecord: serializer.fromJson<bool>(json['isLatestRecord']),
      memoryGroupId: serializer.fromJson<String>(json['memoryGroupId']),
      nextPlanShowTime: serializer.fromJson<DateTime>(json['nextPlanShowTime']),
      showFamiliarity: serializer.fromJson<double>(json['showFamiliarity']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      id: serializer.fromJson<String>(json['id']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'clickTime': serializer.toJson<DateTime>(clickTime),
      'clickValue': serializer.toJson<double>(clickValue),
      'creatorUserId': serializer.toJson<int>(creatorUserId),
      'currentActualShowTime':
          serializer.toJson<DateTime>(currentActualShowTime),
      'fragmentId': serializer.toJson<String>(fragmentId),
      'isLatestRecord': serializer.toJson<bool>(isLatestRecord),
      'memoryGroupId': serializer.toJson<String>(memoryGroupId),
      'nextPlanShowTime': serializer.toJson<DateTime>(nextPlanShowTime),
      'showFamiliarity': serializer.toJson<double>(showFamiliarity),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'id': serializer.toJson<String>(id),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  FragmentMemoryInfo copyWith(
          {DateTime? clickTime,
          double? clickValue,
          int? creatorUserId,
          DateTime? currentActualShowTime,
          String? fragmentId,
          bool? isLatestRecord,
          String? memoryGroupId,
          DateTime? nextPlanShowTime,
          double? showFamiliarity,
          DateTime? createdAt,
          String? id,
          DateTime? updatedAt}) =>
      FragmentMemoryInfo(
        clickTime: clickTime ?? this.clickTime,
        clickValue: clickValue ?? this.clickValue,
        creatorUserId: creatorUserId ?? this.creatorUserId,
        currentActualShowTime:
            currentActualShowTime ?? this.currentActualShowTime,
        fragmentId: fragmentId ?? this.fragmentId,
        isLatestRecord: isLatestRecord ?? this.isLatestRecord,
        memoryGroupId: memoryGroupId ?? this.memoryGroupId,
        nextPlanShowTime: nextPlanShowTime ?? this.nextPlanShowTime,
        showFamiliarity: showFamiliarity ?? this.showFamiliarity,
        createdAt: createdAt ?? this.createdAt,
        id: id ?? this.id,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  @override
  String toString() {
    return (StringBuffer('FragmentMemoryInfo(')
          ..write('clickTime: $clickTime, ')
          ..write('clickValue: $clickValue, ')
          ..write('creatorUserId: $creatorUserId, ')
          ..write('currentActualShowTime: $currentActualShowTime, ')
          ..write('fragmentId: $fragmentId, ')
          ..write('isLatestRecord: $isLatestRecord, ')
          ..write('memoryGroupId: $memoryGroupId, ')
          ..write('nextPlanShowTime: $nextPlanShowTime, ')
          ..write('showFamiliarity: $showFamiliarity, ')
          ..write('createdAt: $createdAt, ')
          ..write('id: $id, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      clickTime,
      clickValue,
      creatorUserId,
      currentActualShowTime,
      fragmentId,
      isLatestRecord,
      memoryGroupId,
      nextPlanShowTime,
      showFamiliarity,
      createdAt,
      id,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FragmentMemoryInfo &&
          other.clickTime == this.clickTime &&
          other.clickValue == this.clickValue &&
          other.creatorUserId == this.creatorUserId &&
          other.currentActualShowTime == this.currentActualShowTime &&
          other.fragmentId == this.fragmentId &&
          other.isLatestRecord == this.isLatestRecord &&
          other.memoryGroupId == this.memoryGroupId &&
          other.nextPlanShowTime == this.nextPlanShowTime &&
          other.showFamiliarity == this.showFamiliarity &&
          other.createdAt == this.createdAt &&
          other.id == this.id &&
          other.updatedAt == this.updatedAt);
}

class FragmentMemoryInfosCompanion extends UpdateCompanion<FragmentMemoryInfo> {
  Value<DateTime> clickTime;
  Value<double> clickValue;
  Value<int> creatorUserId;
  Value<DateTime> currentActualShowTime;
  Value<String> fragmentId;
  Value<bool> isLatestRecord;
  Value<String> memoryGroupId;
  Value<DateTime> nextPlanShowTime;
  Value<double> showFamiliarity;
  Value<DateTime> createdAt;
  Value<String> id;
  Value<DateTime> updatedAt;
  FragmentMemoryInfosCompanion({
    this.clickTime = const Value.absent(),
    this.clickValue = const Value.absent(),
    this.creatorUserId = const Value.absent(),
    this.currentActualShowTime = const Value.absent(),
    this.fragmentId = const Value.absent(),
    this.isLatestRecord = const Value.absent(),
    this.memoryGroupId = const Value.absent(),
    this.nextPlanShowTime = const Value.absent(),
    this.showFamiliarity = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.id = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  FragmentMemoryInfosCompanion.insert({
    required DateTime clickTime,
    required double clickValue,
    required int creatorUserId,
    required DateTime currentActualShowTime,
    required String fragmentId,
    required bool isLatestRecord,
    required String memoryGroupId,
    required DateTime nextPlanShowTime,
    required double showFamiliarity,
    required DateTime createdAt,
    required String id,
    required DateTime updatedAt,
  })  : clickTime = Value(clickTime),
        clickValue = Value(clickValue),
        creatorUserId = Value(creatorUserId),
        currentActualShowTime = Value(currentActualShowTime),
        fragmentId = Value(fragmentId),
        isLatestRecord = Value(isLatestRecord),
        memoryGroupId = Value(memoryGroupId),
        nextPlanShowTime = Value(nextPlanShowTime),
        showFamiliarity = Value(showFamiliarity),
        createdAt = Value(createdAt),
        id = Value(id),
        updatedAt = Value(updatedAt);
  static Insertable<FragmentMemoryInfo> custom({
    Expression<DateTime>? clickTime,
    Expression<double>? clickValue,
    Expression<int>? creatorUserId,
    Expression<DateTime>? currentActualShowTime,
    Expression<String>? fragmentId,
    Expression<bool>? isLatestRecord,
    Expression<String>? memoryGroupId,
    Expression<DateTime>? nextPlanShowTime,
    Expression<double>? showFamiliarity,
    Expression<DateTime>? createdAt,
    Expression<String>? id,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (clickTime != null) 'click_time': clickTime,
      if (clickValue != null) 'click_value': clickValue,
      if (creatorUserId != null) 'creator_user_id': creatorUserId,
      if (currentActualShowTime != null)
        'current_actual_show_time': currentActualShowTime,
      if (fragmentId != null) 'fragment_id': fragmentId,
      if (isLatestRecord != null) 'is_latest_record': isLatestRecord,
      if (memoryGroupId != null) 'memory_group_id': memoryGroupId,
      if (nextPlanShowTime != null) 'next_plan_show_time': nextPlanShowTime,
      if (showFamiliarity != null) 'show_familiarity': showFamiliarity,
      if (createdAt != null) 'created_at': createdAt,
      if (id != null) 'id': id,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  FragmentMemoryInfosCompanion copyWith(
      {Value<DateTime>? clickTime,
      Value<double>? clickValue,
      Value<int>? creatorUserId,
      Value<DateTime>? currentActualShowTime,
      Value<String>? fragmentId,
      Value<bool>? isLatestRecord,
      Value<String>? memoryGroupId,
      Value<DateTime>? nextPlanShowTime,
      Value<double>? showFamiliarity,
      Value<DateTime>? createdAt,
      Value<String>? id,
      Value<DateTime>? updatedAt}) {
    return FragmentMemoryInfosCompanion(
      clickTime: clickTime ?? this.clickTime,
      clickValue: clickValue ?? this.clickValue,
      creatorUserId: creatorUserId ?? this.creatorUserId,
      currentActualShowTime:
          currentActualShowTime ?? this.currentActualShowTime,
      fragmentId: fragmentId ?? this.fragmentId,
      isLatestRecord: isLatestRecord ?? this.isLatestRecord,
      memoryGroupId: memoryGroupId ?? this.memoryGroupId,
      nextPlanShowTime: nextPlanShowTime ?? this.nextPlanShowTime,
      showFamiliarity: showFamiliarity ?? this.showFamiliarity,
      createdAt: createdAt ?? this.createdAt,
      id: id ?? this.id,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (clickTime.present) {
      map['click_time'] = Variable<DateTime>(clickTime.value);
    }
    if (clickValue.present) {
      map['click_value'] = Variable<double>(clickValue.value);
    }
    if (creatorUserId.present) {
      map['creator_user_id'] = Variable<int>(creatorUserId.value);
    }
    if (currentActualShowTime.present) {
      map['current_actual_show_time'] =
          Variable<DateTime>(currentActualShowTime.value);
    }
    if (fragmentId.present) {
      map['fragment_id'] = Variable<String>(fragmentId.value);
    }
    if (isLatestRecord.present) {
      map['is_latest_record'] = Variable<bool>(isLatestRecord.value);
    }
    if (memoryGroupId.present) {
      map['memory_group_id'] = Variable<String>(memoryGroupId.value);
    }
    if (nextPlanShowTime.present) {
      map['next_plan_show_time'] = Variable<DateTime>(nextPlanShowTime.value);
    }
    if (showFamiliarity.present) {
      map['show_familiarity'] = Variable<double>(showFamiliarity.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FragmentMemoryInfosCompanion(')
          ..write('clickTime: $clickTime, ')
          ..write('clickValue: $clickValue, ')
          ..write('creatorUserId: $creatorUserId, ')
          ..write('currentActualShowTime: $currentActualShowTime, ')
          ..write('fragmentId: $fragmentId, ')
          ..write('isLatestRecord: $isLatestRecord, ')
          ..write('memoryGroupId: $memoryGroupId, ')
          ..write('nextPlanShowTime: $nextPlanShowTime, ')
          ..write('showFamiliarity: $showFamiliarity, ')
          ..write('createdAt: $createdAt, ')
          ..write('id: $id, ')
          ..write('updatedAt: $updatedAt')
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
  final VerificationMeta _creatorUserIdMeta =
      const VerificationMeta('creatorUserId');
  @override
  late final GeneratedColumn<int> creatorUserId = GeneratedColumn<int>(
      'creator_user_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  final VerificationMeta _currentActualShowTimeMeta =
      const VerificationMeta('currentActualShowTime');
  @override
  late final GeneratedColumn<DateTime> currentActualShowTime =
      GeneratedColumn<DateTime>('current_actual_show_time', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  final VerificationMeta _fragmentIdMeta = const VerificationMeta('fragmentId');
  @override
  late final GeneratedColumn<String> fragmentId = GeneratedColumn<String>(
      'fragment_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _isLatestRecordMeta =
      const VerificationMeta('isLatestRecord');
  @override
  late final GeneratedColumn<bool> isLatestRecord = GeneratedColumn<bool>(
      'is_latest_record', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: 'CHECK (is_latest_record IN (0, 1))');
  final VerificationMeta _memoryGroupIdMeta =
      const VerificationMeta('memoryGroupId');
  @override
  late final GeneratedColumn<String> memoryGroupId = GeneratedColumn<String>(
      'memory_group_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _nextPlanShowTimeMeta =
      const VerificationMeta('nextPlanShowTime');
  @override
  late final GeneratedColumn<DateTime> nextPlanShowTime =
      GeneratedColumn<DateTime>('next_plan_show_time', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  final VerificationMeta _showFamiliarityMeta =
      const VerificationMeta('showFamiliarity');
  @override
  late final GeneratedColumn<double> showFamiliarity = GeneratedColumn<double>(
      'show_familiarity', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        clickTime,
        clickValue,
        creatorUserId,
        currentActualShowTime,
        fragmentId,
        isLatestRecord,
        memoryGroupId,
        nextPlanShowTime,
        showFamiliarity,
        createdAt,
        id,
        updatedAt
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
    if (data.containsKey('creator_user_id')) {
      context.handle(
          _creatorUserIdMeta,
          creatorUserId.isAcceptableOrUnknown(
              data['creator_user_id']!, _creatorUserIdMeta));
    } else if (isInserting) {
      context.missing(_creatorUserIdMeta);
    }
    if (data.containsKey('current_actual_show_time')) {
      context.handle(
          _currentActualShowTimeMeta,
          currentActualShowTime.isAcceptableOrUnknown(
              data['current_actual_show_time']!, _currentActualShowTimeMeta));
    } else if (isInserting) {
      context.missing(_currentActualShowTimeMeta);
    }
    if (data.containsKey('fragment_id')) {
      context.handle(
          _fragmentIdMeta,
          fragmentId.isAcceptableOrUnknown(
              data['fragment_id']!, _fragmentIdMeta));
    } else if (isInserting) {
      context.missing(_fragmentIdMeta);
    }
    if (data.containsKey('is_latest_record')) {
      context.handle(
          _isLatestRecordMeta,
          isLatestRecord.isAcceptableOrUnknown(
              data['is_latest_record']!, _isLatestRecordMeta));
    } else if (isInserting) {
      context.missing(_isLatestRecordMeta);
    }
    if (data.containsKey('memory_group_id')) {
      context.handle(
          _memoryGroupIdMeta,
          memoryGroupId.isAcceptableOrUnknown(
              data['memory_group_id']!, _memoryGroupIdMeta));
    } else if (isInserting) {
      context.missing(_memoryGroupIdMeta);
    }
    if (data.containsKey('next_plan_show_time')) {
      context.handle(
          _nextPlanShowTimeMeta,
          nextPlanShowTime.isAcceptableOrUnknown(
              data['next_plan_show_time']!, _nextPlanShowTimeMeta));
    } else if (isInserting) {
      context.missing(_nextPlanShowTimeMeta);
    }
    if (data.containsKey('show_familiarity')) {
      context.handle(
          _showFamiliarityMeta,
          showFamiliarity.isAcceptableOrUnknown(
              data['show_familiarity']!, _showFamiliarityMeta));
    } else if (isInserting) {
      context.missing(_showFamiliarityMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FragmentMemoryInfo map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FragmentMemoryInfo(
      clickTime: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}click_time'])!,
      clickValue: attachedDatabase.options.types
          .read(DriftSqlType.double, data['${effectivePrefix}click_value'])!,
      creatorUserId: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}creator_user_id'])!,
      currentActualShowTime: attachedDatabase.options.types.read(
          DriftSqlType.dateTime,
          data['${effectivePrefix}current_actual_show_time'])!,
      fragmentId: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}fragment_id'])!,
      isLatestRecord: attachedDatabase.options.types
          .read(DriftSqlType.bool, data['${effectivePrefix}is_latest_record'])!,
      memoryGroupId: attachedDatabase.options.types.read(
          DriftSqlType.string, data['${effectivePrefix}memory_group_id'])!,
      nextPlanShowTime: attachedDatabase.options.types.read(
          DriftSqlType.dateTime,
          data['${effectivePrefix}next_plan_show_time'])!,
      showFamiliarity: attachedDatabase.options.types.read(
          DriftSqlType.double, data['${effectivePrefix}show_familiarity'])!,
      createdAt: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      id: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      updatedAt: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $FragmentMemoryInfosTable createAlias(String alias) {
    return $FragmentMemoryInfosTable(attachedDatabase, alias);
  }
}

class AppInfo extends DataClass implements Insertable<AppInfo> {
  bool hasDownloadedInitData;
  String token;
  DateTime createdAt;
  String id;
  DateTime updatedAt;
  AppInfo(
      {required this.hasDownloadedInitData,
      required this.token,
      required this.createdAt,
      required this.id,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['has_downloaded_init_data'] = Variable<bool>(hasDownloadedInitData);
    map['token'] = Variable<String>(token);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['id'] = Variable<String>(id);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  AppInfosCompanion toCompanion(bool nullToAbsent) {
    return AppInfosCompanion(
      hasDownloadedInitData: Value(hasDownloadedInitData),
      token: Value(token),
      createdAt: Value(createdAt),
      id: Value(id),
      updatedAt: Value(updatedAt),
    );
  }

  factory AppInfo.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppInfo(
      hasDownloadedInitData:
          serializer.fromJson<bool>(json['hasDownloadedInitData']),
      token: serializer.fromJson<String>(json['token']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      id: serializer.fromJson<String>(json['id']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'hasDownloadedInitData': serializer.toJson<bool>(hasDownloadedInitData),
      'token': serializer.toJson<String>(token),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'id': serializer.toJson<String>(id),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  AppInfo copyWith(
          {bool? hasDownloadedInitData,
          String? token,
          DateTime? createdAt,
          String? id,
          DateTime? updatedAt}) =>
      AppInfo(
        hasDownloadedInitData:
            hasDownloadedInitData ?? this.hasDownloadedInitData,
        token: token ?? this.token,
        createdAt: createdAt ?? this.createdAt,
        id: id ?? this.id,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  @override
  String toString() {
    return (StringBuffer('AppInfo(')
          ..write('hasDownloadedInitData: $hasDownloadedInitData, ')
          ..write('token: $token, ')
          ..write('createdAt: $createdAt, ')
          ..write('id: $id, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(hasDownloadedInitData, token, createdAt, id, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppInfo &&
          other.hasDownloadedInitData == this.hasDownloadedInitData &&
          other.token == this.token &&
          other.createdAt == this.createdAt &&
          other.id == this.id &&
          other.updatedAt == this.updatedAt);
}

class AppInfosCompanion extends UpdateCompanion<AppInfo> {
  Value<bool> hasDownloadedInitData;
  Value<String> token;
  Value<DateTime> createdAt;
  Value<String> id;
  Value<DateTime> updatedAt;
  AppInfosCompanion({
    this.hasDownloadedInitData = const Value.absent(),
    this.token = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.id = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  AppInfosCompanion.insert({
    required bool hasDownloadedInitData,
    required String token,
    required DateTime createdAt,
    required String id,
    required DateTime updatedAt,
  })  : hasDownloadedInitData = Value(hasDownloadedInitData),
        token = Value(token),
        createdAt = Value(createdAt),
        id = Value(id),
        updatedAt = Value(updatedAt);
  static Insertable<AppInfo> custom({
    Expression<bool>? hasDownloadedInitData,
    Expression<String>? token,
    Expression<DateTime>? createdAt,
    Expression<String>? id,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (hasDownloadedInitData != null)
        'has_downloaded_init_data': hasDownloadedInitData,
      if (token != null) 'token': token,
      if (createdAt != null) 'created_at': createdAt,
      if (id != null) 'id': id,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  AppInfosCompanion copyWith(
      {Value<bool>? hasDownloadedInitData,
      Value<String>? token,
      Value<DateTime>? createdAt,
      Value<String>? id,
      Value<DateTime>? updatedAt}) {
    return AppInfosCompanion(
      hasDownloadedInitData:
          hasDownloadedInitData ?? this.hasDownloadedInitData,
      token: token ?? this.token,
      createdAt: createdAt ?? this.createdAt,
      id: id ?? this.id,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (hasDownloadedInitData.present) {
      map['has_downloaded_init_data'] =
          Variable<bool>(hasDownloadedInitData.value);
    }
    if (token.present) {
      map['token'] = Variable<String>(token.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppInfosCompanion(')
          ..write('hasDownloadedInitData: $hasDownloadedInitData, ')
          ..write('token: $token, ')
          ..write('createdAt: $createdAt, ')
          ..write('id: $id, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $AppInfosTable extends AppInfos with TableInfo<$AppInfosTable, AppInfo> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppInfosTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _hasDownloadedInitDataMeta =
      const VerificationMeta('hasDownloadedInitData');
  @override
  late final GeneratedColumn<bool> hasDownloadedInitData =
      GeneratedColumn<bool>('has_downloaded_init_data', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: true,
          defaultConstraints: 'CHECK (has_downloaded_init_data IN (0, 1))');
  final VerificationMeta _tokenMeta = const VerificationMeta('token');
  @override
  late final GeneratedColumn<String> token = GeneratedColumn<String>(
      'token', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [hasDownloadedInitData, token, createdAt, id, updatedAt];
  @override
  String get aliasedName => _alias ?? 'app_infos';
  @override
  String get actualTableName => 'app_infos';
  @override
  VerificationContext validateIntegrity(Insertable<AppInfo> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('has_downloaded_init_data')) {
      context.handle(
          _hasDownloadedInitDataMeta,
          hasDownloadedInitData.isAcceptableOrUnknown(
              data['has_downloaded_init_data']!, _hasDownloadedInitDataMeta));
    } else if (isInserting) {
      context.missing(_hasDownloadedInitDataMeta);
    }
    if (data.containsKey('token')) {
      context.handle(
          _tokenMeta, token.isAcceptableOrUnknown(data['token']!, _tokenMeta));
    } else if (isInserting) {
      context.missing(_tokenMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AppInfo map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppInfo(
      hasDownloadedInitData: attachedDatabase.options.types.read(
          DriftSqlType.bool,
          data['${effectivePrefix}has_downloaded_init_data'])!,
      token: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}token'])!,
      createdAt: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      id: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      updatedAt: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $AppInfosTable createAlias(String alias) {
    return $AppInfosTable(attachedDatabase, alias);
  }
}

class Sync extends DataClass implements Insertable<Sync> {
  String rowId;
  SyncCurdType syncCurdType;
  String syncTableName;
  int tag;
  DateTime createdAt;
  String id;
  DateTime updatedAt;
  Sync(
      {required this.rowId,
      required this.syncCurdType,
      required this.syncTableName,
      required this.tag,
      required this.createdAt,
      required this.id,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['row_id'] = Variable<String>(rowId);
    {
      final converter = $SyncsTable.$converter0;
      map['sync_curd_type'] = Variable<int>(converter.toSql(syncCurdType));
    }
    map['sync_table_name'] = Variable<String>(syncTableName);
    map['tag'] = Variable<int>(tag);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['id'] = Variable<String>(id);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  SyncsCompanion toCompanion(bool nullToAbsent) {
    return SyncsCompanion(
      rowId: Value(rowId),
      syncCurdType: Value(syncCurdType),
      syncTableName: Value(syncTableName),
      tag: Value(tag),
      createdAt: Value(createdAt),
      id: Value(id),
      updatedAt: Value(updatedAt),
    );
  }

  factory Sync.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Sync(
      rowId: serializer.fromJson<String>(json['rowId']),
      syncCurdType: serializer.fromJson<SyncCurdType>(json['syncCurdType']),
      syncTableName: serializer.fromJson<String>(json['syncTableName']),
      tag: serializer.fromJson<int>(json['tag']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      id: serializer.fromJson<String>(json['id']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'rowId': serializer.toJson<String>(rowId),
      'syncCurdType': serializer.toJson<SyncCurdType>(syncCurdType),
      'syncTableName': serializer.toJson<String>(syncTableName),
      'tag': serializer.toJson<int>(tag),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'id': serializer.toJson<String>(id),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Sync copyWith(
          {String? rowId,
          SyncCurdType? syncCurdType,
          String? syncTableName,
          int? tag,
          DateTime? createdAt,
          String? id,
          DateTime? updatedAt}) =>
      Sync(
        rowId: rowId ?? this.rowId,
        syncCurdType: syncCurdType ?? this.syncCurdType,
        syncTableName: syncTableName ?? this.syncTableName,
        tag: tag ?? this.tag,
        createdAt: createdAt ?? this.createdAt,
        id: id ?? this.id,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  @override
  String toString() {
    return (StringBuffer('Sync(')
          ..write('rowId: $rowId, ')
          ..write('syncCurdType: $syncCurdType, ')
          ..write('syncTableName: $syncTableName, ')
          ..write('tag: $tag, ')
          ..write('createdAt: $createdAt, ')
          ..write('id: $id, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      rowId, syncCurdType, syncTableName, tag, createdAt, id, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Sync &&
          other.rowId == this.rowId &&
          other.syncCurdType == this.syncCurdType &&
          other.syncTableName == this.syncTableName &&
          other.tag == this.tag &&
          other.createdAt == this.createdAt &&
          other.id == this.id &&
          other.updatedAt == this.updatedAt);
}

class SyncsCompanion extends UpdateCompanion<Sync> {
  Value<String> rowId;
  Value<SyncCurdType> syncCurdType;
  Value<String> syncTableName;
  Value<int> tag;
  Value<DateTime> createdAt;
  Value<String> id;
  Value<DateTime> updatedAt;
  SyncsCompanion({
    this.rowId = const Value.absent(),
    this.syncCurdType = const Value.absent(),
    this.syncTableName = const Value.absent(),
    this.tag = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.id = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  SyncsCompanion.insert({
    required String rowId,
    required SyncCurdType syncCurdType,
    required String syncTableName,
    required int tag,
    required DateTime createdAt,
    required String id,
    required DateTime updatedAt,
  })  : rowId = Value(rowId),
        syncCurdType = Value(syncCurdType),
        syncTableName = Value(syncTableName),
        tag = Value(tag),
        createdAt = Value(createdAt),
        id = Value(id),
        updatedAt = Value(updatedAt);
  static Insertable<Sync> custom({
    Expression<String>? rowId,
    Expression<int>? syncCurdType,
    Expression<String>? syncTableName,
    Expression<int>? tag,
    Expression<DateTime>? createdAt,
    Expression<String>? id,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (rowId != null) 'row_id': rowId,
      if (syncCurdType != null) 'sync_curd_type': syncCurdType,
      if (syncTableName != null) 'sync_table_name': syncTableName,
      if (tag != null) 'tag': tag,
      if (createdAt != null) 'created_at': createdAt,
      if (id != null) 'id': id,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  SyncsCompanion copyWith(
      {Value<String>? rowId,
      Value<SyncCurdType>? syncCurdType,
      Value<String>? syncTableName,
      Value<int>? tag,
      Value<DateTime>? createdAt,
      Value<String>? id,
      Value<DateTime>? updatedAt}) {
    return SyncsCompanion(
      rowId: rowId ?? this.rowId,
      syncCurdType: syncCurdType ?? this.syncCurdType,
      syncTableName: syncTableName ?? this.syncTableName,
      tag: tag ?? this.tag,
      createdAt: createdAt ?? this.createdAt,
      id: id ?? this.id,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (rowId.present) {
      map['row_id'] = Variable<String>(rowId.value);
    }
    if (syncCurdType.present) {
      final converter = $SyncsTable.$converter0;
      map['sync_curd_type'] =
          Variable<int>(converter.toSql(syncCurdType.value));
    }
    if (syncTableName.present) {
      map['sync_table_name'] = Variable<String>(syncTableName.value);
    }
    if (tag.present) {
      map['tag'] = Variable<int>(tag.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncsCompanion(')
          ..write('rowId: $rowId, ')
          ..write('syncCurdType: $syncCurdType, ')
          ..write('syncTableName: $syncTableName, ')
          ..write('tag: $tag, ')
          ..write('createdAt: $createdAt, ')
          ..write('id: $id, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $SyncsTable extends Syncs with TableInfo<$SyncsTable, Sync> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _rowIdMeta = const VerificationMeta('rowId');
  @override
  late final GeneratedColumn<String> rowId = GeneratedColumn<String>(
      'row_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _syncCurdTypeMeta =
      const VerificationMeta('syncCurdType');
  @override
  late final GeneratedColumnWithTypeConverter<SyncCurdType, int> syncCurdType =
      GeneratedColumn<int>('sync_curd_type', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<SyncCurdType>($SyncsTable.$converter0);
  final VerificationMeta _syncTableNameMeta =
      const VerificationMeta('syncTableName');
  @override
  late final GeneratedColumn<String> syncTableName = GeneratedColumn<String>(
      'sync_table_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _tagMeta = const VerificationMeta('tag');
  @override
  late final GeneratedColumn<int> tag = GeneratedColumn<int>(
      'tag', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [rowId, syncCurdType, syncTableName, tag, createdAt, id, updatedAt];
  @override
  String get aliasedName => _alias ?? 'syncs';
  @override
  String get actualTableName => 'syncs';
  @override
  VerificationContext validateIntegrity(Insertable<Sync> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('row_id')) {
      context.handle(
          _rowIdMeta, rowId.isAcceptableOrUnknown(data['row_id']!, _rowIdMeta));
    } else if (isInserting) {
      context.missing(_rowIdMeta);
    }
    context.handle(_syncCurdTypeMeta, const VerificationResult.success());
    if (data.containsKey('sync_table_name')) {
      context.handle(
          _syncTableNameMeta,
          syncTableName.isAcceptableOrUnknown(
              data['sync_table_name']!, _syncTableNameMeta));
    } else if (isInserting) {
      context.missing(_syncTableNameMeta);
    }
    if (data.containsKey('tag')) {
      context.handle(
          _tagMeta, tag.isAcceptableOrUnknown(data['tag']!, _tagMeta));
    } else if (isInserting) {
      context.missing(_tagMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Sync map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Sync(
      rowId: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}row_id'])!,
      syncCurdType: $SyncsTable.$converter0.fromSql(attachedDatabase
          .options.types
          .read(DriftSqlType.int, data['${effectivePrefix}sync_curd_type'])!),
      syncTableName: attachedDatabase.options.types.read(
          DriftSqlType.string, data['${effectivePrefix}sync_table_name'])!,
      tag: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}tag'])!,
      createdAt: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      id: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      updatedAt: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $SyncsTable createAlias(String alias) {
    return $SyncsTable(attachedDatabase, alias);
  }

  static TypeConverter<SyncCurdType, int> $converter0 =
      const EnumIndexConverter<SyncCurdType>(SyncCurdType.values);
}

class MemoryGroup extends DataClass implements Insertable<MemoryGroup> {
  int creatorUserId;
  String? memoryModelId;
  NewDisplayOrder newDisplayOrder;
  NewReviewDisplayOrder newReviewDisplayOrder;
  DateTime reviewInterval;
  DateTime? startTime;
  String title;
  int willNewLearnCount;
  DateTime createdAt;
  String id;
  DateTime updatedAt;
  MemoryGroup(
      {required this.creatorUserId,
      this.memoryModelId,
      required this.newDisplayOrder,
      required this.newReviewDisplayOrder,
      required this.reviewInterval,
      this.startTime,
      required this.title,
      required this.willNewLearnCount,
      required this.createdAt,
      required this.id,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['creator_user_id'] = Variable<int>(creatorUserId);
    if (!nullToAbsent || memoryModelId != null) {
      map['memory_model_id'] = Variable<String>(memoryModelId);
    }
    {
      final converter = $MemoryGroupsTable.$converter0;
      map['new_display_order'] =
          Variable<int>(converter.toSql(newDisplayOrder));
    }
    {
      final converter = $MemoryGroupsTable.$converter1;
      map['new_review_display_order'] =
          Variable<int>(converter.toSql(newReviewDisplayOrder));
    }
    map['review_interval'] = Variable<DateTime>(reviewInterval);
    if (!nullToAbsent || startTime != null) {
      map['start_time'] = Variable<DateTime>(startTime);
    }
    map['title'] = Variable<String>(title);
    map['will_new_learn_count'] = Variable<int>(willNewLearnCount);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['id'] = Variable<String>(id);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  MemoryGroupsCompanion toCompanion(bool nullToAbsent) {
    return MemoryGroupsCompanion(
      creatorUserId: Value(creatorUserId),
      memoryModelId: memoryModelId == null && nullToAbsent
          ? const Value.absent()
          : Value(memoryModelId),
      newDisplayOrder: Value(newDisplayOrder),
      newReviewDisplayOrder: Value(newReviewDisplayOrder),
      reviewInterval: Value(reviewInterval),
      startTime: startTime == null && nullToAbsent
          ? const Value.absent()
          : Value(startTime),
      title: Value(title),
      willNewLearnCount: Value(willNewLearnCount),
      createdAt: Value(createdAt),
      id: Value(id),
      updatedAt: Value(updatedAt),
    );
  }

  factory MemoryGroup.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MemoryGroup(
      creatorUserId: serializer.fromJson<int>(json['creatorUserId']),
      memoryModelId: serializer.fromJson<String?>(json['memoryModelId']),
      newDisplayOrder:
          serializer.fromJson<NewDisplayOrder>(json['newDisplayOrder']),
      newReviewDisplayOrder: serializer
          .fromJson<NewReviewDisplayOrder>(json['newReviewDisplayOrder']),
      reviewInterval: serializer.fromJson<DateTime>(json['reviewInterval']),
      startTime: serializer.fromJson<DateTime?>(json['startTime']),
      title: serializer.fromJson<String>(json['title']),
      willNewLearnCount: serializer.fromJson<int>(json['willNewLearnCount']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      id: serializer.fromJson<String>(json['id']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'creatorUserId': serializer.toJson<int>(creatorUserId),
      'memoryModelId': serializer.toJson<String?>(memoryModelId),
      'newDisplayOrder': serializer.toJson<NewDisplayOrder>(newDisplayOrder),
      'newReviewDisplayOrder':
          serializer.toJson<NewReviewDisplayOrder>(newReviewDisplayOrder),
      'reviewInterval': serializer.toJson<DateTime>(reviewInterval),
      'startTime': serializer.toJson<DateTime?>(startTime),
      'title': serializer.toJson<String>(title),
      'willNewLearnCount': serializer.toJson<int>(willNewLearnCount),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'id': serializer.toJson<String>(id),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  MemoryGroup copyWith(
          {int? creatorUserId,
          Value<String?> memoryModelId = const Value.absent(),
          NewDisplayOrder? newDisplayOrder,
          NewReviewDisplayOrder? newReviewDisplayOrder,
          DateTime? reviewInterval,
          Value<DateTime?> startTime = const Value.absent(),
          String? title,
          int? willNewLearnCount,
          DateTime? createdAt,
          String? id,
          DateTime? updatedAt}) =>
      MemoryGroup(
        creatorUserId: creatorUserId ?? this.creatorUserId,
        memoryModelId:
            memoryModelId.present ? memoryModelId.value : this.memoryModelId,
        newDisplayOrder: newDisplayOrder ?? this.newDisplayOrder,
        newReviewDisplayOrder:
            newReviewDisplayOrder ?? this.newReviewDisplayOrder,
        reviewInterval: reviewInterval ?? this.reviewInterval,
        startTime: startTime.present ? startTime.value : this.startTime,
        title: title ?? this.title,
        willNewLearnCount: willNewLearnCount ?? this.willNewLearnCount,
        createdAt: createdAt ?? this.createdAt,
        id: id ?? this.id,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  @override
  String toString() {
    return (StringBuffer('MemoryGroup(')
          ..write('creatorUserId: $creatorUserId, ')
          ..write('memoryModelId: $memoryModelId, ')
          ..write('newDisplayOrder: $newDisplayOrder, ')
          ..write('newReviewDisplayOrder: $newReviewDisplayOrder, ')
          ..write('reviewInterval: $reviewInterval, ')
          ..write('startTime: $startTime, ')
          ..write('title: $title, ')
          ..write('willNewLearnCount: $willNewLearnCount, ')
          ..write('createdAt: $createdAt, ')
          ..write('id: $id, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      creatorUserId,
      memoryModelId,
      newDisplayOrder,
      newReviewDisplayOrder,
      reviewInterval,
      startTime,
      title,
      willNewLearnCount,
      createdAt,
      id,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MemoryGroup &&
          other.creatorUserId == this.creatorUserId &&
          other.memoryModelId == this.memoryModelId &&
          other.newDisplayOrder == this.newDisplayOrder &&
          other.newReviewDisplayOrder == this.newReviewDisplayOrder &&
          other.reviewInterval == this.reviewInterval &&
          other.startTime == this.startTime &&
          other.title == this.title &&
          other.willNewLearnCount == this.willNewLearnCount &&
          other.createdAt == this.createdAt &&
          other.id == this.id &&
          other.updatedAt == this.updatedAt);
}

class MemoryGroupsCompanion extends UpdateCompanion<MemoryGroup> {
  Value<int> creatorUserId;
  Value<String?> memoryModelId;
  Value<NewDisplayOrder> newDisplayOrder;
  Value<NewReviewDisplayOrder> newReviewDisplayOrder;
  Value<DateTime> reviewInterval;
  Value<DateTime?> startTime;
  Value<String> title;
  Value<int> willNewLearnCount;
  Value<DateTime> createdAt;
  Value<String> id;
  Value<DateTime> updatedAt;
  MemoryGroupsCompanion({
    this.creatorUserId = const Value.absent(),
    this.memoryModelId = const Value.absent(),
    this.newDisplayOrder = const Value.absent(),
    this.newReviewDisplayOrder = const Value.absent(),
    this.reviewInterval = const Value.absent(),
    this.startTime = const Value.absent(),
    this.title = const Value.absent(),
    this.willNewLearnCount = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.id = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  MemoryGroupsCompanion.insert({
    required int creatorUserId,
    this.memoryModelId = const Value.absent(),
    required NewDisplayOrder newDisplayOrder,
    required NewReviewDisplayOrder newReviewDisplayOrder,
    required DateTime reviewInterval,
    this.startTime = const Value.absent(),
    required String title,
    required int willNewLearnCount,
    required DateTime createdAt,
    required String id,
    required DateTime updatedAt,
  })  : creatorUserId = Value(creatorUserId),
        newDisplayOrder = Value(newDisplayOrder),
        newReviewDisplayOrder = Value(newReviewDisplayOrder),
        reviewInterval = Value(reviewInterval),
        title = Value(title),
        willNewLearnCount = Value(willNewLearnCount),
        createdAt = Value(createdAt),
        id = Value(id),
        updatedAt = Value(updatedAt);
  static Insertable<MemoryGroup> custom({
    Expression<int>? creatorUserId,
    Expression<String>? memoryModelId,
    Expression<int>? newDisplayOrder,
    Expression<int>? newReviewDisplayOrder,
    Expression<DateTime>? reviewInterval,
    Expression<DateTime>? startTime,
    Expression<String>? title,
    Expression<int>? willNewLearnCount,
    Expression<DateTime>? createdAt,
    Expression<String>? id,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (creatorUserId != null) 'creator_user_id': creatorUserId,
      if (memoryModelId != null) 'memory_model_id': memoryModelId,
      if (newDisplayOrder != null) 'new_display_order': newDisplayOrder,
      if (newReviewDisplayOrder != null)
        'new_review_display_order': newReviewDisplayOrder,
      if (reviewInterval != null) 'review_interval': reviewInterval,
      if (startTime != null) 'start_time': startTime,
      if (title != null) 'title': title,
      if (willNewLearnCount != null) 'will_new_learn_count': willNewLearnCount,
      if (createdAt != null) 'created_at': createdAt,
      if (id != null) 'id': id,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  MemoryGroupsCompanion copyWith(
      {Value<int>? creatorUserId,
      Value<String?>? memoryModelId,
      Value<NewDisplayOrder>? newDisplayOrder,
      Value<NewReviewDisplayOrder>? newReviewDisplayOrder,
      Value<DateTime>? reviewInterval,
      Value<DateTime?>? startTime,
      Value<String>? title,
      Value<int>? willNewLearnCount,
      Value<DateTime>? createdAt,
      Value<String>? id,
      Value<DateTime>? updatedAt}) {
    return MemoryGroupsCompanion(
      creatorUserId: creatorUserId ?? this.creatorUserId,
      memoryModelId: memoryModelId ?? this.memoryModelId,
      newDisplayOrder: newDisplayOrder ?? this.newDisplayOrder,
      newReviewDisplayOrder:
          newReviewDisplayOrder ?? this.newReviewDisplayOrder,
      reviewInterval: reviewInterval ?? this.reviewInterval,
      startTime: startTime ?? this.startTime,
      title: title ?? this.title,
      willNewLearnCount: willNewLearnCount ?? this.willNewLearnCount,
      createdAt: createdAt ?? this.createdAt,
      id: id ?? this.id,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (creatorUserId.present) {
      map['creator_user_id'] = Variable<int>(creatorUserId.value);
    }
    if (memoryModelId.present) {
      map['memory_model_id'] = Variable<String>(memoryModelId.value);
    }
    if (newDisplayOrder.present) {
      final converter = $MemoryGroupsTable.$converter0;
      map['new_display_order'] =
          Variable<int>(converter.toSql(newDisplayOrder.value));
    }
    if (newReviewDisplayOrder.present) {
      final converter = $MemoryGroupsTable.$converter1;
      map['new_review_display_order'] =
          Variable<int>(converter.toSql(newReviewDisplayOrder.value));
    }
    if (reviewInterval.present) {
      map['review_interval'] = Variable<DateTime>(reviewInterval.value);
    }
    if (startTime.present) {
      map['start_time'] = Variable<DateTime>(startTime.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (willNewLearnCount.present) {
      map['will_new_learn_count'] = Variable<int>(willNewLearnCount.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MemoryGroupsCompanion(')
          ..write('creatorUserId: $creatorUserId, ')
          ..write('memoryModelId: $memoryModelId, ')
          ..write('newDisplayOrder: $newDisplayOrder, ')
          ..write('newReviewDisplayOrder: $newReviewDisplayOrder, ')
          ..write('reviewInterval: $reviewInterval, ')
          ..write('startTime: $startTime, ')
          ..write('title: $title, ')
          ..write('willNewLearnCount: $willNewLearnCount, ')
          ..write('createdAt: $createdAt, ')
          ..write('id: $id, ')
          ..write('updatedAt: $updatedAt')
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
  final VerificationMeta _creatorUserIdMeta =
      const VerificationMeta('creatorUserId');
  @override
  late final GeneratedColumn<int> creatorUserId = GeneratedColumn<int>(
      'creator_user_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  final VerificationMeta _memoryModelIdMeta =
      const VerificationMeta('memoryModelId');
  @override
  late final GeneratedColumn<String> memoryModelId = GeneratedColumn<String>(
      'memory_model_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  final VerificationMeta _newDisplayOrderMeta =
      const VerificationMeta('newDisplayOrder');
  @override
  late final GeneratedColumnWithTypeConverter<NewDisplayOrder, int>
      newDisplayOrder = GeneratedColumn<int>(
              'new_display_order', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<NewDisplayOrder>($MemoryGroupsTable.$converter0);
  final VerificationMeta _newReviewDisplayOrderMeta =
      const VerificationMeta('newReviewDisplayOrder');
  @override
  late final GeneratedColumnWithTypeConverter<NewReviewDisplayOrder, int>
      newReviewDisplayOrder = GeneratedColumn<int>(
              'new_review_display_order', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<NewReviewDisplayOrder>($MemoryGroupsTable.$converter1);
  final VerificationMeta _reviewIntervalMeta =
      const VerificationMeta('reviewInterval');
  @override
  late final GeneratedColumn<DateTime> reviewInterval =
      GeneratedColumn<DateTime>('review_interval', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  final VerificationMeta _startTimeMeta = const VerificationMeta('startTime');
  @override
  late final GeneratedColumn<DateTime> startTime = GeneratedColumn<DateTime>(
      'start_time', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  final VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _willNewLearnCountMeta =
      const VerificationMeta('willNewLearnCount');
  @override
  late final GeneratedColumn<int> willNewLearnCount = GeneratedColumn<int>(
      'will_new_learn_count', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        creatorUserId,
        memoryModelId,
        newDisplayOrder,
        newReviewDisplayOrder,
        reviewInterval,
        startTime,
        title,
        willNewLearnCount,
        createdAt,
        id,
        updatedAt
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
    if (data.containsKey('creator_user_id')) {
      context.handle(
          _creatorUserIdMeta,
          creatorUserId.isAcceptableOrUnknown(
              data['creator_user_id']!, _creatorUserIdMeta));
    } else if (isInserting) {
      context.missing(_creatorUserIdMeta);
    }
    if (data.containsKey('memory_model_id')) {
      context.handle(
          _memoryModelIdMeta,
          memoryModelId.isAcceptableOrUnknown(
              data['memory_model_id']!, _memoryModelIdMeta));
    }
    context.handle(_newDisplayOrderMeta, const VerificationResult.success());
    context.handle(
        _newReviewDisplayOrderMeta, const VerificationResult.success());
    if (data.containsKey('review_interval')) {
      context.handle(
          _reviewIntervalMeta,
          reviewInterval.isAcceptableOrUnknown(
              data['review_interval']!, _reviewIntervalMeta));
    } else if (isInserting) {
      context.missing(_reviewIntervalMeta);
    }
    if (data.containsKey('start_time')) {
      context.handle(_startTimeMeta,
          startTime.isAcceptableOrUnknown(data['start_time']!, _startTimeMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('will_new_learn_count')) {
      context.handle(
          _willNewLearnCountMeta,
          willNewLearnCount.isAcceptableOrUnknown(
              data['will_new_learn_count']!, _willNewLearnCountMeta));
    } else if (isInserting) {
      context.missing(_willNewLearnCountMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MemoryGroup map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MemoryGroup(
      creatorUserId: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}creator_user_id'])!,
      memoryModelId: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}memory_model_id']),
      newDisplayOrder: $MemoryGroupsTable.$converter0.fromSql(
          attachedDatabase.options.types.read(
              DriftSqlType.int, data['${effectivePrefix}new_display_order'])!),
      newReviewDisplayOrder: $MemoryGroupsTable.$converter1.fromSql(
          attachedDatabase.options.types.read(DriftSqlType.int,
              data['${effectivePrefix}new_review_display_order'])!),
      reviewInterval: attachedDatabase.options.types.read(
          DriftSqlType.dateTime, data['${effectivePrefix}review_interval'])!,
      startTime: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}start_time']),
      title: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      willNewLearnCount: attachedDatabase.options.types.read(
          DriftSqlType.int, data['${effectivePrefix}will_new_learn_count'])!,
      createdAt: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      id: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      updatedAt: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $MemoryGroupsTable createAlias(String alias) {
    return $MemoryGroupsTable(attachedDatabase, alias);
  }

  static TypeConverter<NewDisplayOrder, int> $converter0 =
      const EnumIndexConverter<NewDisplayOrder>(NewDisplayOrder.values);
  static TypeConverter<NewReviewDisplayOrder, int> $converter1 =
      const EnumIndexConverter<NewReviewDisplayOrder>(
          NewReviewDisplayOrder.values);
}

class RDocument2DocumentGroup extends DataClass
    implements Insertable<RDocument2DocumentGroup> {
  int creatorUserId;
  String? documentGroupId;
  String documentId;
  DateTime createdAt;
  String id;
  DateTime updatedAt;
  RDocument2DocumentGroup(
      {required this.creatorUserId,
      this.documentGroupId,
      required this.documentId,
      required this.createdAt,
      required this.id,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['creator_user_id'] = Variable<int>(creatorUserId);
    if (!nullToAbsent || documentGroupId != null) {
      map['document_group_id'] = Variable<String>(documentGroupId);
    }
    map['document_id'] = Variable<String>(documentId);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['id'] = Variable<String>(id);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  RDocument2DocumentGroupsCompanion toCompanion(bool nullToAbsent) {
    return RDocument2DocumentGroupsCompanion(
      creatorUserId: Value(creatorUserId),
      documentGroupId: documentGroupId == null && nullToAbsent
          ? const Value.absent()
          : Value(documentGroupId),
      documentId: Value(documentId),
      createdAt: Value(createdAt),
      id: Value(id),
      updatedAt: Value(updatedAt),
    );
  }

  factory RDocument2DocumentGroup.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RDocument2DocumentGroup(
      creatorUserId: serializer.fromJson<int>(json['creatorUserId']),
      documentGroupId: serializer.fromJson<String?>(json['documentGroupId']),
      documentId: serializer.fromJson<String>(json['documentId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      id: serializer.fromJson<String>(json['id']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'creatorUserId': serializer.toJson<int>(creatorUserId),
      'documentGroupId': serializer.toJson<String?>(documentGroupId),
      'documentId': serializer.toJson<String>(documentId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'id': serializer.toJson<String>(id),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  RDocument2DocumentGroup copyWith(
          {int? creatorUserId,
          Value<String?> documentGroupId = const Value.absent(),
          String? documentId,
          DateTime? createdAt,
          String? id,
          DateTime? updatedAt}) =>
      RDocument2DocumentGroup(
        creatorUserId: creatorUserId ?? this.creatorUserId,
        documentGroupId: documentGroupId.present
            ? documentGroupId.value
            : this.documentGroupId,
        documentId: documentId ?? this.documentId,
        createdAt: createdAt ?? this.createdAt,
        id: id ?? this.id,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  @override
  String toString() {
    return (StringBuffer('RDocument2DocumentGroup(')
          ..write('creatorUserId: $creatorUserId, ')
          ..write('documentGroupId: $documentGroupId, ')
          ..write('documentId: $documentId, ')
          ..write('createdAt: $createdAt, ')
          ..write('id: $id, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      creatorUserId, documentGroupId, documentId, createdAt, id, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RDocument2DocumentGroup &&
          other.creatorUserId == this.creatorUserId &&
          other.documentGroupId == this.documentGroupId &&
          other.documentId == this.documentId &&
          other.createdAt == this.createdAt &&
          other.id == this.id &&
          other.updatedAt == this.updatedAt);
}

class RDocument2DocumentGroupsCompanion
    extends UpdateCompanion<RDocument2DocumentGroup> {
  Value<int> creatorUserId;
  Value<String?> documentGroupId;
  Value<String> documentId;
  Value<DateTime> createdAt;
  Value<String> id;
  Value<DateTime> updatedAt;
  RDocument2DocumentGroupsCompanion({
    this.creatorUserId = const Value.absent(),
    this.documentGroupId = const Value.absent(),
    this.documentId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.id = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  RDocument2DocumentGroupsCompanion.insert({
    required int creatorUserId,
    this.documentGroupId = const Value.absent(),
    required String documentId,
    required DateTime createdAt,
    required String id,
    required DateTime updatedAt,
  })  : creatorUserId = Value(creatorUserId),
        documentId = Value(documentId),
        createdAt = Value(createdAt),
        id = Value(id),
        updatedAt = Value(updatedAt);
  static Insertable<RDocument2DocumentGroup> custom({
    Expression<int>? creatorUserId,
    Expression<String>? documentGroupId,
    Expression<String>? documentId,
    Expression<DateTime>? createdAt,
    Expression<String>? id,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (creatorUserId != null) 'creator_user_id': creatorUserId,
      if (documentGroupId != null) 'document_group_id': documentGroupId,
      if (documentId != null) 'document_id': documentId,
      if (createdAt != null) 'created_at': createdAt,
      if (id != null) 'id': id,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  RDocument2DocumentGroupsCompanion copyWith(
      {Value<int>? creatorUserId,
      Value<String?>? documentGroupId,
      Value<String>? documentId,
      Value<DateTime>? createdAt,
      Value<String>? id,
      Value<DateTime>? updatedAt}) {
    return RDocument2DocumentGroupsCompanion(
      creatorUserId: creatorUserId ?? this.creatorUserId,
      documentGroupId: documentGroupId ?? this.documentGroupId,
      documentId: documentId ?? this.documentId,
      createdAt: createdAt ?? this.createdAt,
      id: id ?? this.id,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (creatorUserId.present) {
      map['creator_user_id'] = Variable<int>(creatorUserId.value);
    }
    if (documentGroupId.present) {
      map['document_group_id'] = Variable<String>(documentGroupId.value);
    }
    if (documentId.present) {
      map['document_id'] = Variable<String>(documentId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RDocument2DocumentGroupsCompanion(')
          ..write('creatorUserId: $creatorUserId, ')
          ..write('documentGroupId: $documentGroupId, ')
          ..write('documentId: $documentId, ')
          ..write('createdAt: $createdAt, ')
          ..write('id: $id, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $RDocument2DocumentGroupsTable extends RDocument2DocumentGroups
    with TableInfo<$RDocument2DocumentGroupsTable, RDocument2DocumentGroup> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RDocument2DocumentGroupsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _creatorUserIdMeta =
      const VerificationMeta('creatorUserId');
  @override
  late final GeneratedColumn<int> creatorUserId = GeneratedColumn<int>(
      'creator_user_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  final VerificationMeta _documentGroupIdMeta =
      const VerificationMeta('documentGroupId');
  @override
  late final GeneratedColumn<String> documentGroupId = GeneratedColumn<String>(
      'document_group_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  final VerificationMeta _documentIdMeta = const VerificationMeta('documentId');
  @override
  late final GeneratedColumn<String> documentId = GeneratedColumn<String>(
      'document_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [creatorUserId, documentGroupId, documentId, createdAt, id, updatedAt];
  @override
  String get aliasedName => _alias ?? 'r_document2_document_groups';
  @override
  String get actualTableName => 'r_document2_document_groups';
  @override
  VerificationContext validateIntegrity(
      Insertable<RDocument2DocumentGroup> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('creator_user_id')) {
      context.handle(
          _creatorUserIdMeta,
          creatorUserId.isAcceptableOrUnknown(
              data['creator_user_id']!, _creatorUserIdMeta));
    } else if (isInserting) {
      context.missing(_creatorUserIdMeta);
    }
    if (data.containsKey('document_group_id')) {
      context.handle(
          _documentGroupIdMeta,
          documentGroupId.isAcceptableOrUnknown(
              data['document_group_id']!, _documentGroupIdMeta));
    }
    if (data.containsKey('document_id')) {
      context.handle(
          _documentIdMeta,
          documentId.isAcceptableOrUnknown(
              data['document_id']!, _documentIdMeta));
    } else if (isInserting) {
      context.missing(_documentIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RDocument2DocumentGroup map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RDocument2DocumentGroup(
      creatorUserId: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}creator_user_id'])!,
      documentGroupId: attachedDatabase.options.types.read(
          DriftSqlType.string, data['${effectivePrefix}document_group_id']),
      documentId: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}document_id'])!,
      createdAt: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      id: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      updatedAt: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $RDocument2DocumentGroupsTable createAlias(String alias) {
    return $RDocument2DocumentGroupsTable(attachedDatabase, alias);
  }
}

class RFragment2FragmentGroup extends DataClass
    implements Insertable<RFragment2FragmentGroup> {
  int creatorUserId;
  String? fragmentGroupId;
  String fragmentId;
  DateTime createdAt;
  String id;
  DateTime updatedAt;
  RFragment2FragmentGroup(
      {required this.creatorUserId,
      this.fragmentGroupId,
      required this.fragmentId,
      required this.createdAt,
      required this.id,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['creator_user_id'] = Variable<int>(creatorUserId);
    if (!nullToAbsent || fragmentGroupId != null) {
      map['fragment_group_id'] = Variable<String>(fragmentGroupId);
    }
    map['fragment_id'] = Variable<String>(fragmentId);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['id'] = Variable<String>(id);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  RFragment2FragmentGroupsCompanion toCompanion(bool nullToAbsent) {
    return RFragment2FragmentGroupsCompanion(
      creatorUserId: Value(creatorUserId),
      fragmentGroupId: fragmentGroupId == null && nullToAbsent
          ? const Value.absent()
          : Value(fragmentGroupId),
      fragmentId: Value(fragmentId),
      createdAt: Value(createdAt),
      id: Value(id),
      updatedAt: Value(updatedAt),
    );
  }

  factory RFragment2FragmentGroup.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RFragment2FragmentGroup(
      creatorUserId: serializer.fromJson<int>(json['creatorUserId']),
      fragmentGroupId: serializer.fromJson<String?>(json['fragmentGroupId']),
      fragmentId: serializer.fromJson<String>(json['fragmentId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      id: serializer.fromJson<String>(json['id']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'creatorUserId': serializer.toJson<int>(creatorUserId),
      'fragmentGroupId': serializer.toJson<String?>(fragmentGroupId),
      'fragmentId': serializer.toJson<String>(fragmentId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'id': serializer.toJson<String>(id),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  RFragment2FragmentGroup copyWith(
          {int? creatorUserId,
          Value<String?> fragmentGroupId = const Value.absent(),
          String? fragmentId,
          DateTime? createdAt,
          String? id,
          DateTime? updatedAt}) =>
      RFragment2FragmentGroup(
        creatorUserId: creatorUserId ?? this.creatorUserId,
        fragmentGroupId: fragmentGroupId.present
            ? fragmentGroupId.value
            : this.fragmentGroupId,
        fragmentId: fragmentId ?? this.fragmentId,
        createdAt: createdAt ?? this.createdAt,
        id: id ?? this.id,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  @override
  String toString() {
    return (StringBuffer('RFragment2FragmentGroup(')
          ..write('creatorUserId: $creatorUserId, ')
          ..write('fragmentGroupId: $fragmentGroupId, ')
          ..write('fragmentId: $fragmentId, ')
          ..write('createdAt: $createdAt, ')
          ..write('id: $id, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      creatorUserId, fragmentGroupId, fragmentId, createdAt, id, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RFragment2FragmentGroup &&
          other.creatorUserId == this.creatorUserId &&
          other.fragmentGroupId == this.fragmentGroupId &&
          other.fragmentId == this.fragmentId &&
          other.createdAt == this.createdAt &&
          other.id == this.id &&
          other.updatedAt == this.updatedAt);
}

class RFragment2FragmentGroupsCompanion
    extends UpdateCompanion<RFragment2FragmentGroup> {
  Value<int> creatorUserId;
  Value<String?> fragmentGroupId;
  Value<String> fragmentId;
  Value<DateTime> createdAt;
  Value<String> id;
  Value<DateTime> updatedAt;
  RFragment2FragmentGroupsCompanion({
    this.creatorUserId = const Value.absent(),
    this.fragmentGroupId = const Value.absent(),
    this.fragmentId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.id = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  RFragment2FragmentGroupsCompanion.insert({
    required int creatorUserId,
    this.fragmentGroupId = const Value.absent(),
    required String fragmentId,
    required DateTime createdAt,
    required String id,
    required DateTime updatedAt,
  })  : creatorUserId = Value(creatorUserId),
        fragmentId = Value(fragmentId),
        createdAt = Value(createdAt),
        id = Value(id),
        updatedAt = Value(updatedAt);
  static Insertable<RFragment2FragmentGroup> custom({
    Expression<int>? creatorUserId,
    Expression<String>? fragmentGroupId,
    Expression<String>? fragmentId,
    Expression<DateTime>? createdAt,
    Expression<String>? id,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (creatorUserId != null) 'creator_user_id': creatorUserId,
      if (fragmentGroupId != null) 'fragment_group_id': fragmentGroupId,
      if (fragmentId != null) 'fragment_id': fragmentId,
      if (createdAt != null) 'created_at': createdAt,
      if (id != null) 'id': id,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  RFragment2FragmentGroupsCompanion copyWith(
      {Value<int>? creatorUserId,
      Value<String?>? fragmentGroupId,
      Value<String>? fragmentId,
      Value<DateTime>? createdAt,
      Value<String>? id,
      Value<DateTime>? updatedAt}) {
    return RFragment2FragmentGroupsCompanion(
      creatorUserId: creatorUserId ?? this.creatorUserId,
      fragmentGroupId: fragmentGroupId ?? this.fragmentGroupId,
      fragmentId: fragmentId ?? this.fragmentId,
      createdAt: createdAt ?? this.createdAt,
      id: id ?? this.id,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (creatorUserId.present) {
      map['creator_user_id'] = Variable<int>(creatorUserId.value);
    }
    if (fragmentGroupId.present) {
      map['fragment_group_id'] = Variable<String>(fragmentGroupId.value);
    }
    if (fragmentId.present) {
      map['fragment_id'] = Variable<String>(fragmentId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RFragment2FragmentGroupsCompanion(')
          ..write('creatorUserId: $creatorUserId, ')
          ..write('fragmentGroupId: $fragmentGroupId, ')
          ..write('fragmentId: $fragmentId, ')
          ..write('createdAt: $createdAt, ')
          ..write('id: $id, ')
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
  final VerificationMeta _creatorUserIdMeta =
      const VerificationMeta('creatorUserId');
  @override
  late final GeneratedColumn<int> creatorUserId = GeneratedColumn<int>(
      'creator_user_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  final VerificationMeta _fragmentGroupIdMeta =
      const VerificationMeta('fragmentGroupId');
  @override
  late final GeneratedColumn<String> fragmentGroupId = GeneratedColumn<String>(
      'fragment_group_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  final VerificationMeta _fragmentIdMeta = const VerificationMeta('fragmentId');
  @override
  late final GeneratedColumn<String> fragmentId = GeneratedColumn<String>(
      'fragment_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [creatorUserId, fragmentGroupId, fragmentId, createdAt, id, updatedAt];
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
    if (data.containsKey('creator_user_id')) {
      context.handle(
          _creatorUserIdMeta,
          creatorUserId.isAcceptableOrUnknown(
              data['creator_user_id']!, _creatorUserIdMeta));
    } else if (isInserting) {
      context.missing(_creatorUserIdMeta);
    }
    if (data.containsKey('fragment_group_id')) {
      context.handle(
          _fragmentGroupIdMeta,
          fragmentGroupId.isAcceptableOrUnknown(
              data['fragment_group_id']!, _fragmentGroupIdMeta));
    }
    if (data.containsKey('fragment_id')) {
      context.handle(
          _fragmentIdMeta,
          fragmentId.isAcceptableOrUnknown(
              data['fragment_id']!, _fragmentIdMeta));
    } else if (isInserting) {
      context.missing(_fragmentIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
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
      creatorUserId: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}creator_user_id'])!,
      fragmentGroupId: attachedDatabase.options.types.read(
          DriftSqlType.string, data['${effectivePrefix}fragment_group_id']),
      fragmentId: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}fragment_id'])!,
      createdAt: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      id: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      updatedAt: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $RFragment2FragmentGroupsTable createAlias(String alias) {
    return $RFragment2FragmentGroupsTable(attachedDatabase, alias);
  }
}

class RMemoryModel2MemoryModelGroup extends DataClass
    implements Insertable<RMemoryModel2MemoryModelGroup> {
  int creatorUserId;
  String? memoryModelGroupId;
  String memoryModelId;
  DateTime createdAt;
  String id;
  DateTime updatedAt;
  RMemoryModel2MemoryModelGroup(
      {required this.creatorUserId,
      this.memoryModelGroupId,
      required this.memoryModelId,
      required this.createdAt,
      required this.id,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['creator_user_id'] = Variable<int>(creatorUserId);
    if (!nullToAbsent || memoryModelGroupId != null) {
      map['memory_model_group_id'] = Variable<String>(memoryModelGroupId);
    }
    map['memory_model_id'] = Variable<String>(memoryModelId);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['id'] = Variable<String>(id);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  RMemoryModel2MemoryModelGroupsCompanion toCompanion(bool nullToAbsent) {
    return RMemoryModel2MemoryModelGroupsCompanion(
      creatorUserId: Value(creatorUserId),
      memoryModelGroupId: memoryModelGroupId == null && nullToAbsent
          ? const Value.absent()
          : Value(memoryModelGroupId),
      memoryModelId: Value(memoryModelId),
      createdAt: Value(createdAt),
      id: Value(id),
      updatedAt: Value(updatedAt),
    );
  }

  factory RMemoryModel2MemoryModelGroup.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RMemoryModel2MemoryModelGroup(
      creatorUserId: serializer.fromJson<int>(json['creatorUserId']),
      memoryModelGroupId:
          serializer.fromJson<String?>(json['memoryModelGroupId']),
      memoryModelId: serializer.fromJson<String>(json['memoryModelId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      id: serializer.fromJson<String>(json['id']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'creatorUserId': serializer.toJson<int>(creatorUserId),
      'memoryModelGroupId': serializer.toJson<String?>(memoryModelGroupId),
      'memoryModelId': serializer.toJson<String>(memoryModelId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'id': serializer.toJson<String>(id),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  RMemoryModel2MemoryModelGroup copyWith(
          {int? creatorUserId,
          Value<String?> memoryModelGroupId = const Value.absent(),
          String? memoryModelId,
          DateTime? createdAt,
          String? id,
          DateTime? updatedAt}) =>
      RMemoryModel2MemoryModelGroup(
        creatorUserId: creatorUserId ?? this.creatorUserId,
        memoryModelGroupId: memoryModelGroupId.present
            ? memoryModelGroupId.value
            : this.memoryModelGroupId,
        memoryModelId: memoryModelId ?? this.memoryModelId,
        createdAt: createdAt ?? this.createdAt,
        id: id ?? this.id,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  @override
  String toString() {
    return (StringBuffer('RMemoryModel2MemoryModelGroup(')
          ..write('creatorUserId: $creatorUserId, ')
          ..write('memoryModelGroupId: $memoryModelGroupId, ')
          ..write('memoryModelId: $memoryModelId, ')
          ..write('createdAt: $createdAt, ')
          ..write('id: $id, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(creatorUserId, memoryModelGroupId,
      memoryModelId, createdAt, id, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RMemoryModel2MemoryModelGroup &&
          other.creatorUserId == this.creatorUserId &&
          other.memoryModelGroupId == this.memoryModelGroupId &&
          other.memoryModelId == this.memoryModelId &&
          other.createdAt == this.createdAt &&
          other.id == this.id &&
          other.updatedAt == this.updatedAt);
}

class RMemoryModel2MemoryModelGroupsCompanion
    extends UpdateCompanion<RMemoryModel2MemoryModelGroup> {
  Value<int> creatorUserId;
  Value<String?> memoryModelGroupId;
  Value<String> memoryModelId;
  Value<DateTime> createdAt;
  Value<String> id;
  Value<DateTime> updatedAt;
  RMemoryModel2MemoryModelGroupsCompanion({
    this.creatorUserId = const Value.absent(),
    this.memoryModelGroupId = const Value.absent(),
    this.memoryModelId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.id = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  RMemoryModel2MemoryModelGroupsCompanion.insert({
    required int creatorUserId,
    this.memoryModelGroupId = const Value.absent(),
    required String memoryModelId,
    required DateTime createdAt,
    required String id,
    required DateTime updatedAt,
  })  : creatorUserId = Value(creatorUserId),
        memoryModelId = Value(memoryModelId),
        createdAt = Value(createdAt),
        id = Value(id),
        updatedAt = Value(updatedAt);
  static Insertable<RMemoryModel2MemoryModelGroup> custom({
    Expression<int>? creatorUserId,
    Expression<String>? memoryModelGroupId,
    Expression<String>? memoryModelId,
    Expression<DateTime>? createdAt,
    Expression<String>? id,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (creatorUserId != null) 'creator_user_id': creatorUserId,
      if (memoryModelGroupId != null)
        'memory_model_group_id': memoryModelGroupId,
      if (memoryModelId != null) 'memory_model_id': memoryModelId,
      if (createdAt != null) 'created_at': createdAt,
      if (id != null) 'id': id,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  RMemoryModel2MemoryModelGroupsCompanion copyWith(
      {Value<int>? creatorUserId,
      Value<String?>? memoryModelGroupId,
      Value<String>? memoryModelId,
      Value<DateTime>? createdAt,
      Value<String>? id,
      Value<DateTime>? updatedAt}) {
    return RMemoryModel2MemoryModelGroupsCompanion(
      creatorUserId: creatorUserId ?? this.creatorUserId,
      memoryModelGroupId: memoryModelGroupId ?? this.memoryModelGroupId,
      memoryModelId: memoryModelId ?? this.memoryModelId,
      createdAt: createdAt ?? this.createdAt,
      id: id ?? this.id,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (creatorUserId.present) {
      map['creator_user_id'] = Variable<int>(creatorUserId.value);
    }
    if (memoryModelGroupId.present) {
      map['memory_model_group_id'] = Variable<String>(memoryModelGroupId.value);
    }
    if (memoryModelId.present) {
      map['memory_model_id'] = Variable<String>(memoryModelId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RMemoryModel2MemoryModelGroupsCompanion(')
          ..write('creatorUserId: $creatorUserId, ')
          ..write('memoryModelGroupId: $memoryModelGroupId, ')
          ..write('memoryModelId: $memoryModelId, ')
          ..write('createdAt: $createdAt, ')
          ..write('id: $id, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $RMemoryModel2MemoryModelGroupsTable
    extends RMemoryModel2MemoryModelGroups
    with
        TableInfo<$RMemoryModel2MemoryModelGroupsTable,
            RMemoryModel2MemoryModelGroup> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RMemoryModel2MemoryModelGroupsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _creatorUserIdMeta =
      const VerificationMeta('creatorUserId');
  @override
  late final GeneratedColumn<int> creatorUserId = GeneratedColumn<int>(
      'creator_user_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  final VerificationMeta _memoryModelGroupIdMeta =
      const VerificationMeta('memoryModelGroupId');
  @override
  late final GeneratedColumn<String> memoryModelGroupId =
      GeneratedColumn<String>('memory_model_group_id', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  final VerificationMeta _memoryModelIdMeta =
      const VerificationMeta('memoryModelId');
  @override
  late final GeneratedColumn<String> memoryModelId = GeneratedColumn<String>(
      'memory_model_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        creatorUserId,
        memoryModelGroupId,
        memoryModelId,
        createdAt,
        id,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? 'r_memory_model2_memory_model_groups';
  @override
  String get actualTableName => 'r_memory_model2_memory_model_groups';
  @override
  VerificationContext validateIntegrity(
      Insertable<RMemoryModel2MemoryModelGroup> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('creator_user_id')) {
      context.handle(
          _creatorUserIdMeta,
          creatorUserId.isAcceptableOrUnknown(
              data['creator_user_id']!, _creatorUserIdMeta));
    } else if (isInserting) {
      context.missing(_creatorUserIdMeta);
    }
    if (data.containsKey('memory_model_group_id')) {
      context.handle(
          _memoryModelGroupIdMeta,
          memoryModelGroupId.isAcceptableOrUnknown(
              data['memory_model_group_id']!, _memoryModelGroupIdMeta));
    }
    if (data.containsKey('memory_model_id')) {
      context.handle(
          _memoryModelIdMeta,
          memoryModelId.isAcceptableOrUnknown(
              data['memory_model_id']!, _memoryModelIdMeta));
    } else if (isInserting) {
      context.missing(_memoryModelIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RMemoryModel2MemoryModelGroup map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RMemoryModel2MemoryModelGroup(
      creatorUserId: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}creator_user_id'])!,
      memoryModelGroupId: attachedDatabase.options.types.read(
          DriftSqlType.string, data['${effectivePrefix}memory_model_group_id']),
      memoryModelId: attachedDatabase.options.types.read(
          DriftSqlType.string, data['${effectivePrefix}memory_model_id'])!,
      createdAt: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      id: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      updatedAt: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $RMemoryModel2MemoryModelGroupsTable createAlias(String alias) {
    return $RMemoryModel2MemoryModelGroupsTable(attachedDatabase, alias);
  }
}

class RNote2NoteGroup extends DataClass implements Insertable<RNote2NoteGroup> {
  int creatorUserId;
  String? noteGroupId;
  String noteId;
  DateTime createdAt;
  String id;
  DateTime updatedAt;
  RNote2NoteGroup(
      {required this.creatorUserId,
      this.noteGroupId,
      required this.noteId,
      required this.createdAt,
      required this.id,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['creator_user_id'] = Variable<int>(creatorUserId);
    if (!nullToAbsent || noteGroupId != null) {
      map['note_group_id'] = Variable<String>(noteGroupId);
    }
    map['note_id'] = Variable<String>(noteId);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['id'] = Variable<String>(id);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  RNote2NoteGroupsCompanion toCompanion(bool nullToAbsent) {
    return RNote2NoteGroupsCompanion(
      creatorUserId: Value(creatorUserId),
      noteGroupId: noteGroupId == null && nullToAbsent
          ? const Value.absent()
          : Value(noteGroupId),
      noteId: Value(noteId),
      createdAt: Value(createdAt),
      id: Value(id),
      updatedAt: Value(updatedAt),
    );
  }

  factory RNote2NoteGroup.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RNote2NoteGroup(
      creatorUserId: serializer.fromJson<int>(json['creatorUserId']),
      noteGroupId: serializer.fromJson<String?>(json['noteGroupId']),
      noteId: serializer.fromJson<String>(json['noteId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      id: serializer.fromJson<String>(json['id']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'creatorUserId': serializer.toJson<int>(creatorUserId),
      'noteGroupId': serializer.toJson<String?>(noteGroupId),
      'noteId': serializer.toJson<String>(noteId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'id': serializer.toJson<String>(id),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  RNote2NoteGroup copyWith(
          {int? creatorUserId,
          Value<String?> noteGroupId = const Value.absent(),
          String? noteId,
          DateTime? createdAt,
          String? id,
          DateTime? updatedAt}) =>
      RNote2NoteGroup(
        creatorUserId: creatorUserId ?? this.creatorUserId,
        noteGroupId: noteGroupId.present ? noteGroupId.value : this.noteGroupId,
        noteId: noteId ?? this.noteId,
        createdAt: createdAt ?? this.createdAt,
        id: id ?? this.id,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  @override
  String toString() {
    return (StringBuffer('RNote2NoteGroup(')
          ..write('creatorUserId: $creatorUserId, ')
          ..write('noteGroupId: $noteGroupId, ')
          ..write('noteId: $noteId, ')
          ..write('createdAt: $createdAt, ')
          ..write('id: $id, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(creatorUserId, noteGroupId, noteId, createdAt, id, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RNote2NoteGroup &&
          other.creatorUserId == this.creatorUserId &&
          other.noteGroupId == this.noteGroupId &&
          other.noteId == this.noteId &&
          other.createdAt == this.createdAt &&
          other.id == this.id &&
          other.updatedAt == this.updatedAt);
}

class RNote2NoteGroupsCompanion extends UpdateCompanion<RNote2NoteGroup> {
  Value<int> creatorUserId;
  Value<String?> noteGroupId;
  Value<String> noteId;
  Value<DateTime> createdAt;
  Value<String> id;
  Value<DateTime> updatedAt;
  RNote2NoteGroupsCompanion({
    this.creatorUserId = const Value.absent(),
    this.noteGroupId = const Value.absent(),
    this.noteId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.id = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  RNote2NoteGroupsCompanion.insert({
    required int creatorUserId,
    this.noteGroupId = const Value.absent(),
    required String noteId,
    required DateTime createdAt,
    required String id,
    required DateTime updatedAt,
  })  : creatorUserId = Value(creatorUserId),
        noteId = Value(noteId),
        createdAt = Value(createdAt),
        id = Value(id),
        updatedAt = Value(updatedAt);
  static Insertable<RNote2NoteGroup> custom({
    Expression<int>? creatorUserId,
    Expression<String>? noteGroupId,
    Expression<String>? noteId,
    Expression<DateTime>? createdAt,
    Expression<String>? id,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (creatorUserId != null) 'creator_user_id': creatorUserId,
      if (noteGroupId != null) 'note_group_id': noteGroupId,
      if (noteId != null) 'note_id': noteId,
      if (createdAt != null) 'created_at': createdAt,
      if (id != null) 'id': id,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  RNote2NoteGroupsCompanion copyWith(
      {Value<int>? creatorUserId,
      Value<String?>? noteGroupId,
      Value<String>? noteId,
      Value<DateTime>? createdAt,
      Value<String>? id,
      Value<DateTime>? updatedAt}) {
    return RNote2NoteGroupsCompanion(
      creatorUserId: creatorUserId ?? this.creatorUserId,
      noteGroupId: noteGroupId ?? this.noteGroupId,
      noteId: noteId ?? this.noteId,
      createdAt: createdAt ?? this.createdAt,
      id: id ?? this.id,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (creatorUserId.present) {
      map['creator_user_id'] = Variable<int>(creatorUserId.value);
    }
    if (noteGroupId.present) {
      map['note_group_id'] = Variable<String>(noteGroupId.value);
    }
    if (noteId.present) {
      map['note_id'] = Variable<String>(noteId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RNote2NoteGroupsCompanion(')
          ..write('creatorUserId: $creatorUserId, ')
          ..write('noteGroupId: $noteGroupId, ')
          ..write('noteId: $noteId, ')
          ..write('createdAt: $createdAt, ')
          ..write('id: $id, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $RNote2NoteGroupsTable extends RNote2NoteGroups
    with TableInfo<$RNote2NoteGroupsTable, RNote2NoteGroup> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RNote2NoteGroupsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _creatorUserIdMeta =
      const VerificationMeta('creatorUserId');
  @override
  late final GeneratedColumn<int> creatorUserId = GeneratedColumn<int>(
      'creator_user_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  final VerificationMeta _noteGroupIdMeta =
      const VerificationMeta('noteGroupId');
  @override
  late final GeneratedColumn<String> noteGroupId = GeneratedColumn<String>(
      'note_group_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  final VerificationMeta _noteIdMeta = const VerificationMeta('noteId');
  @override
  late final GeneratedColumn<String> noteId = GeneratedColumn<String>(
      'note_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [creatorUserId, noteGroupId, noteId, createdAt, id, updatedAt];
  @override
  String get aliasedName => _alias ?? 'r_note2_note_groups';
  @override
  String get actualTableName => 'r_note2_note_groups';
  @override
  VerificationContext validateIntegrity(Insertable<RNote2NoteGroup> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('creator_user_id')) {
      context.handle(
          _creatorUserIdMeta,
          creatorUserId.isAcceptableOrUnknown(
              data['creator_user_id']!, _creatorUserIdMeta));
    } else if (isInserting) {
      context.missing(_creatorUserIdMeta);
    }
    if (data.containsKey('note_group_id')) {
      context.handle(
          _noteGroupIdMeta,
          noteGroupId.isAcceptableOrUnknown(
              data['note_group_id']!, _noteGroupIdMeta));
    }
    if (data.containsKey('note_id')) {
      context.handle(_noteIdMeta,
          noteId.isAcceptableOrUnknown(data['note_id']!, _noteIdMeta));
    } else if (isInserting) {
      context.missing(_noteIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RNote2NoteGroup map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RNote2NoteGroup(
      creatorUserId: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}creator_user_id'])!,
      noteGroupId: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}note_group_id']),
      noteId: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}note_id'])!,
      createdAt: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      id: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      updatedAt: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $RNote2NoteGroupsTable createAlias(String alias) {
    return $RNote2NoteGroupsTable(attachedDatabase, alias);
  }
}

class Document extends DataClass implements Insertable<Document> {
  String content;
  int creatorUserId;
  DateTime createdAt;
  String id;
  DateTime updatedAt;
  Document(
      {required this.content,
      required this.creatorUserId,
      required this.createdAt,
      required this.id,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['content'] = Variable<String>(content);
    map['creator_user_id'] = Variable<int>(creatorUserId);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['id'] = Variable<String>(id);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  DocumentsCompanion toCompanion(bool nullToAbsent) {
    return DocumentsCompanion(
      content: Value(content),
      creatorUserId: Value(creatorUserId),
      createdAt: Value(createdAt),
      id: Value(id),
      updatedAt: Value(updatedAt),
    );
  }

  factory Document.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Document(
      content: serializer.fromJson<String>(json['content']),
      creatorUserId: serializer.fromJson<int>(json['creatorUserId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      id: serializer.fromJson<String>(json['id']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'content': serializer.toJson<String>(content),
      'creatorUserId': serializer.toJson<int>(creatorUserId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'id': serializer.toJson<String>(id),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Document copyWith(
          {String? content,
          int? creatorUserId,
          DateTime? createdAt,
          String? id,
          DateTime? updatedAt}) =>
      Document(
        content: content ?? this.content,
        creatorUserId: creatorUserId ?? this.creatorUserId,
        createdAt: createdAt ?? this.createdAt,
        id: id ?? this.id,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  @override
  String toString() {
    return (StringBuffer('Document(')
          ..write('content: $content, ')
          ..write('creatorUserId: $creatorUserId, ')
          ..write('createdAt: $createdAt, ')
          ..write('id: $id, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(content, creatorUserId, createdAt, id, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Document &&
          other.content == this.content &&
          other.creatorUserId == this.creatorUserId &&
          other.createdAt == this.createdAt &&
          other.id == this.id &&
          other.updatedAt == this.updatedAt);
}

class DocumentsCompanion extends UpdateCompanion<Document> {
  Value<String> content;
  Value<int> creatorUserId;
  Value<DateTime> createdAt;
  Value<String> id;
  Value<DateTime> updatedAt;
  DocumentsCompanion({
    this.content = const Value.absent(),
    this.creatorUserId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.id = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  DocumentsCompanion.insert({
    required String content,
    required int creatorUserId,
    required DateTime createdAt,
    required String id,
    required DateTime updatedAt,
  })  : content = Value(content),
        creatorUserId = Value(creatorUserId),
        createdAt = Value(createdAt),
        id = Value(id),
        updatedAt = Value(updatedAt);
  static Insertable<Document> custom({
    Expression<String>? content,
    Expression<int>? creatorUserId,
    Expression<DateTime>? createdAt,
    Expression<String>? id,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (content != null) 'content': content,
      if (creatorUserId != null) 'creator_user_id': creatorUserId,
      if (createdAt != null) 'created_at': createdAt,
      if (id != null) 'id': id,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  DocumentsCompanion copyWith(
      {Value<String>? content,
      Value<int>? creatorUserId,
      Value<DateTime>? createdAt,
      Value<String>? id,
      Value<DateTime>? updatedAt}) {
    return DocumentsCompanion(
      content: content ?? this.content,
      creatorUserId: creatorUserId ?? this.creatorUserId,
      createdAt: createdAt ?? this.createdAt,
      id: id ?? this.id,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (creatorUserId.present) {
      map['creator_user_id'] = Variable<int>(creatorUserId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DocumentsCompanion(')
          ..write('content: $content, ')
          ..write('creatorUserId: $creatorUserId, ')
          ..write('createdAt: $createdAt, ')
          ..write('id: $id, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $DocumentsTable extends Documents
    with TableInfo<$DocumentsTable, Document> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DocumentsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _contentMeta = const VerificationMeta('content');
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
      'content', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _creatorUserIdMeta =
      const VerificationMeta('creatorUserId');
  @override
  late final GeneratedColumn<int> creatorUserId = GeneratedColumn<int>(
      'creator_user_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [content, creatorUserId, createdAt, id, updatedAt];
  @override
  String get aliasedName => _alias ?? 'documents';
  @override
  String get actualTableName => 'documents';
  @override
  VerificationContext validateIntegrity(Insertable<Document> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('creator_user_id')) {
      context.handle(
          _creatorUserIdMeta,
          creatorUserId.isAcceptableOrUnknown(
              data['creator_user_id']!, _creatorUserIdMeta));
    } else if (isInserting) {
      context.missing(_creatorUserIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Document map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Document(
      content: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}content'])!,
      creatorUserId: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}creator_user_id'])!,
      createdAt: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      id: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      updatedAt: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $DocumentsTable createAlias(String alias) {
    return $DocumentsTable(attachedDatabase, alias);
  }
}

class Fragment extends DataClass implements Insertable<Fragment> {
  String content;
  int creatorUserId;
  String? fatherFragmentId;
  bool isSelected;
  String? noteId;
  DateTime createdAt;
  String id;
  DateTime updatedAt;
  Fragment(
      {required this.content,
      required this.creatorUserId,
      this.fatherFragmentId,
      required this.isSelected,
      this.noteId,
      required this.createdAt,
      required this.id,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['content'] = Variable<String>(content);
    map['creator_user_id'] = Variable<int>(creatorUserId);
    if (!nullToAbsent || fatherFragmentId != null) {
      map['father_fragment_id'] = Variable<String>(fatherFragmentId);
    }
    map['is_selected'] = Variable<bool>(isSelected);
    if (!nullToAbsent || noteId != null) {
      map['note_id'] = Variable<String>(noteId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['id'] = Variable<String>(id);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  FragmentsCompanion toCompanion(bool nullToAbsent) {
    return FragmentsCompanion(
      content: Value(content),
      creatorUserId: Value(creatorUserId),
      fatherFragmentId: fatherFragmentId == null && nullToAbsent
          ? const Value.absent()
          : Value(fatherFragmentId),
      isSelected: Value(isSelected),
      noteId:
          noteId == null && nullToAbsent ? const Value.absent() : Value(noteId),
      createdAt: Value(createdAt),
      id: Value(id),
      updatedAt: Value(updatedAt),
    );
  }

  factory Fragment.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Fragment(
      content: serializer.fromJson<String>(json['content']),
      creatorUserId: serializer.fromJson<int>(json['creatorUserId']),
      fatherFragmentId: serializer.fromJson<String?>(json['fatherFragmentId']),
      isSelected: serializer.fromJson<bool>(json['isSelected']),
      noteId: serializer.fromJson<String?>(json['noteId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      id: serializer.fromJson<String>(json['id']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'content': serializer.toJson<String>(content),
      'creatorUserId': serializer.toJson<int>(creatorUserId),
      'fatherFragmentId': serializer.toJson<String?>(fatherFragmentId),
      'isSelected': serializer.toJson<bool>(isSelected),
      'noteId': serializer.toJson<String?>(noteId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'id': serializer.toJson<String>(id),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Fragment copyWith(
          {String? content,
          int? creatorUserId,
          Value<String?> fatherFragmentId = const Value.absent(),
          bool? isSelected,
          Value<String?> noteId = const Value.absent(),
          DateTime? createdAt,
          String? id,
          DateTime? updatedAt}) =>
      Fragment(
        content: content ?? this.content,
        creatorUserId: creatorUserId ?? this.creatorUserId,
        fatherFragmentId: fatherFragmentId.present
            ? fatherFragmentId.value
            : this.fatherFragmentId,
        isSelected: isSelected ?? this.isSelected,
        noteId: noteId.present ? noteId.value : this.noteId,
        createdAt: createdAt ?? this.createdAt,
        id: id ?? this.id,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  @override
  String toString() {
    return (StringBuffer('Fragment(')
          ..write('content: $content, ')
          ..write('creatorUserId: $creatorUserId, ')
          ..write('fatherFragmentId: $fatherFragmentId, ')
          ..write('isSelected: $isSelected, ')
          ..write('noteId: $noteId, ')
          ..write('createdAt: $createdAt, ')
          ..write('id: $id, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(content, creatorUserId, fatherFragmentId,
      isSelected, noteId, createdAt, id, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Fragment &&
          other.content == this.content &&
          other.creatorUserId == this.creatorUserId &&
          other.fatherFragmentId == this.fatherFragmentId &&
          other.isSelected == this.isSelected &&
          other.noteId == this.noteId &&
          other.createdAt == this.createdAt &&
          other.id == this.id &&
          other.updatedAt == this.updatedAt);
}

class FragmentsCompanion extends UpdateCompanion<Fragment> {
  Value<String> content;
  Value<int> creatorUserId;
  Value<String?> fatherFragmentId;
  Value<bool> isSelected;
  Value<String?> noteId;
  Value<DateTime> createdAt;
  Value<String> id;
  Value<DateTime> updatedAt;
  FragmentsCompanion({
    this.content = const Value.absent(),
    this.creatorUserId = const Value.absent(),
    this.fatherFragmentId = const Value.absent(),
    this.isSelected = const Value.absent(),
    this.noteId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.id = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  FragmentsCompanion.insert({
    required String content,
    required int creatorUserId,
    this.fatherFragmentId = const Value.absent(),
    required bool isSelected,
    this.noteId = const Value.absent(),
    required DateTime createdAt,
    required String id,
    required DateTime updatedAt,
  })  : content = Value(content),
        creatorUserId = Value(creatorUserId),
        isSelected = Value(isSelected),
        createdAt = Value(createdAt),
        id = Value(id),
        updatedAt = Value(updatedAt);
  static Insertable<Fragment> custom({
    Expression<String>? content,
    Expression<int>? creatorUserId,
    Expression<String>? fatherFragmentId,
    Expression<bool>? isSelected,
    Expression<String>? noteId,
    Expression<DateTime>? createdAt,
    Expression<String>? id,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (content != null) 'content': content,
      if (creatorUserId != null) 'creator_user_id': creatorUserId,
      if (fatherFragmentId != null) 'father_fragment_id': fatherFragmentId,
      if (isSelected != null) 'is_selected': isSelected,
      if (noteId != null) 'note_id': noteId,
      if (createdAt != null) 'created_at': createdAt,
      if (id != null) 'id': id,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  FragmentsCompanion copyWith(
      {Value<String>? content,
      Value<int>? creatorUserId,
      Value<String?>? fatherFragmentId,
      Value<bool>? isSelected,
      Value<String?>? noteId,
      Value<DateTime>? createdAt,
      Value<String>? id,
      Value<DateTime>? updatedAt}) {
    return FragmentsCompanion(
      content: content ?? this.content,
      creatorUserId: creatorUserId ?? this.creatorUserId,
      fatherFragmentId: fatherFragmentId ?? this.fatherFragmentId,
      isSelected: isSelected ?? this.isSelected,
      noteId: noteId ?? this.noteId,
      createdAt: createdAt ?? this.createdAt,
      id: id ?? this.id,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (creatorUserId.present) {
      map['creator_user_id'] = Variable<int>(creatorUserId.value);
    }
    if (fatherFragmentId.present) {
      map['father_fragment_id'] = Variable<String>(fatherFragmentId.value);
    }
    if (isSelected.present) {
      map['is_selected'] = Variable<bool>(isSelected.value);
    }
    if (noteId.present) {
      map['note_id'] = Variable<String>(noteId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FragmentsCompanion(')
          ..write('content: $content, ')
          ..write('creatorUserId: $creatorUserId, ')
          ..write('fatherFragmentId: $fatherFragmentId, ')
          ..write('isSelected: $isSelected, ')
          ..write('noteId: $noteId, ')
          ..write('createdAt: $createdAt, ')
          ..write('id: $id, ')
          ..write('updatedAt: $updatedAt')
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
  final VerificationMeta _contentMeta = const VerificationMeta('content');
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
      'content', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _creatorUserIdMeta =
      const VerificationMeta('creatorUserId');
  @override
  late final GeneratedColumn<int> creatorUserId = GeneratedColumn<int>(
      'creator_user_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  final VerificationMeta _fatherFragmentIdMeta =
      const VerificationMeta('fatherFragmentId');
  @override
  late final GeneratedColumn<String> fatherFragmentId = GeneratedColumn<String>(
      'father_fragment_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  final VerificationMeta _isSelectedMeta = const VerificationMeta('isSelected');
  @override
  late final GeneratedColumn<bool> isSelected = GeneratedColumn<bool>(
      'is_selected', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: 'CHECK (is_selected IN (0, 1))');
  final VerificationMeta _noteIdMeta = const VerificationMeta('noteId');
  @override
  late final GeneratedColumn<String> noteId = GeneratedColumn<String>(
      'note_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        content,
        creatorUserId,
        fatherFragmentId,
        isSelected,
        noteId,
        createdAt,
        id,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? 'fragments';
  @override
  String get actualTableName => 'fragments';
  @override
  VerificationContext validateIntegrity(Insertable<Fragment> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('creator_user_id')) {
      context.handle(
          _creatorUserIdMeta,
          creatorUserId.isAcceptableOrUnknown(
              data['creator_user_id']!, _creatorUserIdMeta));
    } else if (isInserting) {
      context.missing(_creatorUserIdMeta);
    }
    if (data.containsKey('father_fragment_id')) {
      context.handle(
          _fatherFragmentIdMeta,
          fatherFragmentId.isAcceptableOrUnknown(
              data['father_fragment_id']!, _fatherFragmentIdMeta));
    }
    if (data.containsKey('is_selected')) {
      context.handle(
          _isSelectedMeta,
          isSelected.isAcceptableOrUnknown(
              data['is_selected']!, _isSelectedMeta));
    } else if (isInserting) {
      context.missing(_isSelectedMeta);
    }
    if (data.containsKey('note_id')) {
      context.handle(_noteIdMeta,
          noteId.isAcceptableOrUnknown(data['note_id']!, _noteIdMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Fragment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Fragment(
      content: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}content'])!,
      creatorUserId: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}creator_user_id'])!,
      fatherFragmentId: attachedDatabase.options.types.read(
          DriftSqlType.string, data['${effectivePrefix}father_fragment_id']),
      isSelected: attachedDatabase.options.types
          .read(DriftSqlType.bool, data['${effectivePrefix}is_selected'])!,
      noteId: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}note_id']),
      createdAt: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      id: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      updatedAt: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $FragmentsTable createAlias(String alias) {
    return $FragmentsTable(attachedDatabase, alias);
  }
}

class MemoryModel extends DataClass implements Insertable<MemoryModel> {
  String buttonAlgorithm;
  int creatorUserId;
  String familiarityAlgorithm;
  String? fatherMemoryModelId;
  String nextTimeAlgorithm;
  String stimulateAlgorithm;
  String title;
  DateTime createdAt;
  String id;
  DateTime updatedAt;
  MemoryModel(
      {required this.buttonAlgorithm,
      required this.creatorUserId,
      required this.familiarityAlgorithm,
      this.fatherMemoryModelId,
      required this.nextTimeAlgorithm,
      required this.stimulateAlgorithm,
      required this.title,
      required this.createdAt,
      required this.id,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['button_algorithm'] = Variable<String>(buttonAlgorithm);
    map['creator_user_id'] = Variable<int>(creatorUserId);
    map['familiarity_algorithm'] = Variable<String>(familiarityAlgorithm);
    if (!nullToAbsent || fatherMemoryModelId != null) {
      map['father_memory_model_id'] = Variable<String>(fatherMemoryModelId);
    }
    map['next_time_algorithm'] = Variable<String>(nextTimeAlgorithm);
    map['stimulate_algorithm'] = Variable<String>(stimulateAlgorithm);
    map['title'] = Variable<String>(title);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['id'] = Variable<String>(id);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  MemoryModelsCompanion toCompanion(bool nullToAbsent) {
    return MemoryModelsCompanion(
      buttonAlgorithm: Value(buttonAlgorithm),
      creatorUserId: Value(creatorUserId),
      familiarityAlgorithm: Value(familiarityAlgorithm),
      fatherMemoryModelId: fatherMemoryModelId == null && nullToAbsent
          ? const Value.absent()
          : Value(fatherMemoryModelId),
      nextTimeAlgorithm: Value(nextTimeAlgorithm),
      stimulateAlgorithm: Value(stimulateAlgorithm),
      title: Value(title),
      createdAt: Value(createdAt),
      id: Value(id),
      updatedAt: Value(updatedAt),
    );
  }

  factory MemoryModel.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MemoryModel(
      buttonAlgorithm: serializer.fromJson<String>(json['buttonAlgorithm']),
      creatorUserId: serializer.fromJson<int>(json['creatorUserId']),
      familiarityAlgorithm:
          serializer.fromJson<String>(json['familiarityAlgorithm']),
      fatherMemoryModelId:
          serializer.fromJson<String?>(json['fatherMemoryModelId']),
      nextTimeAlgorithm: serializer.fromJson<String>(json['nextTimeAlgorithm']),
      stimulateAlgorithm:
          serializer.fromJson<String>(json['stimulateAlgorithm']),
      title: serializer.fromJson<String>(json['title']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      id: serializer.fromJson<String>(json['id']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'buttonAlgorithm': serializer.toJson<String>(buttonAlgorithm),
      'creatorUserId': serializer.toJson<int>(creatorUserId),
      'familiarityAlgorithm': serializer.toJson<String>(familiarityAlgorithm),
      'fatherMemoryModelId': serializer.toJson<String?>(fatherMemoryModelId),
      'nextTimeAlgorithm': serializer.toJson<String>(nextTimeAlgorithm),
      'stimulateAlgorithm': serializer.toJson<String>(stimulateAlgorithm),
      'title': serializer.toJson<String>(title),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'id': serializer.toJson<String>(id),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  MemoryModel copyWith(
          {String? buttonAlgorithm,
          int? creatorUserId,
          String? familiarityAlgorithm,
          Value<String?> fatherMemoryModelId = const Value.absent(),
          String? nextTimeAlgorithm,
          String? stimulateAlgorithm,
          String? title,
          DateTime? createdAt,
          String? id,
          DateTime? updatedAt}) =>
      MemoryModel(
        buttonAlgorithm: buttonAlgorithm ?? this.buttonAlgorithm,
        creatorUserId: creatorUserId ?? this.creatorUserId,
        familiarityAlgorithm: familiarityAlgorithm ?? this.familiarityAlgorithm,
        fatherMemoryModelId: fatherMemoryModelId.present
            ? fatherMemoryModelId.value
            : this.fatherMemoryModelId,
        nextTimeAlgorithm: nextTimeAlgorithm ?? this.nextTimeAlgorithm,
        stimulateAlgorithm: stimulateAlgorithm ?? this.stimulateAlgorithm,
        title: title ?? this.title,
        createdAt: createdAt ?? this.createdAt,
        id: id ?? this.id,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  @override
  String toString() {
    return (StringBuffer('MemoryModel(')
          ..write('buttonAlgorithm: $buttonAlgorithm, ')
          ..write('creatorUserId: $creatorUserId, ')
          ..write('familiarityAlgorithm: $familiarityAlgorithm, ')
          ..write('fatherMemoryModelId: $fatherMemoryModelId, ')
          ..write('nextTimeAlgorithm: $nextTimeAlgorithm, ')
          ..write('stimulateAlgorithm: $stimulateAlgorithm, ')
          ..write('title: $title, ')
          ..write('createdAt: $createdAt, ')
          ..write('id: $id, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      buttonAlgorithm,
      creatorUserId,
      familiarityAlgorithm,
      fatherMemoryModelId,
      nextTimeAlgorithm,
      stimulateAlgorithm,
      title,
      createdAt,
      id,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MemoryModel &&
          other.buttonAlgorithm == this.buttonAlgorithm &&
          other.creatorUserId == this.creatorUserId &&
          other.familiarityAlgorithm == this.familiarityAlgorithm &&
          other.fatherMemoryModelId == this.fatherMemoryModelId &&
          other.nextTimeAlgorithm == this.nextTimeAlgorithm &&
          other.stimulateAlgorithm == this.stimulateAlgorithm &&
          other.title == this.title &&
          other.createdAt == this.createdAt &&
          other.id == this.id &&
          other.updatedAt == this.updatedAt);
}

class MemoryModelsCompanion extends UpdateCompanion<MemoryModel> {
  Value<String> buttonAlgorithm;
  Value<int> creatorUserId;
  Value<String> familiarityAlgorithm;
  Value<String?> fatherMemoryModelId;
  Value<String> nextTimeAlgorithm;
  Value<String> stimulateAlgorithm;
  Value<String> title;
  Value<DateTime> createdAt;
  Value<String> id;
  Value<DateTime> updatedAt;
  MemoryModelsCompanion({
    this.buttonAlgorithm = const Value.absent(),
    this.creatorUserId = const Value.absent(),
    this.familiarityAlgorithm = const Value.absent(),
    this.fatherMemoryModelId = const Value.absent(),
    this.nextTimeAlgorithm = const Value.absent(),
    this.stimulateAlgorithm = const Value.absent(),
    this.title = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.id = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  MemoryModelsCompanion.insert({
    required String buttonAlgorithm,
    required int creatorUserId,
    required String familiarityAlgorithm,
    this.fatherMemoryModelId = const Value.absent(),
    required String nextTimeAlgorithm,
    required String stimulateAlgorithm,
    required String title,
    required DateTime createdAt,
    required String id,
    required DateTime updatedAt,
  })  : buttonAlgorithm = Value(buttonAlgorithm),
        creatorUserId = Value(creatorUserId),
        familiarityAlgorithm = Value(familiarityAlgorithm),
        nextTimeAlgorithm = Value(nextTimeAlgorithm),
        stimulateAlgorithm = Value(stimulateAlgorithm),
        title = Value(title),
        createdAt = Value(createdAt),
        id = Value(id),
        updatedAt = Value(updatedAt);
  static Insertable<MemoryModel> custom({
    Expression<String>? buttonAlgorithm,
    Expression<int>? creatorUserId,
    Expression<String>? familiarityAlgorithm,
    Expression<String>? fatherMemoryModelId,
    Expression<String>? nextTimeAlgorithm,
    Expression<String>? stimulateAlgorithm,
    Expression<String>? title,
    Expression<DateTime>? createdAt,
    Expression<String>? id,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (buttonAlgorithm != null) 'button_algorithm': buttonAlgorithm,
      if (creatorUserId != null) 'creator_user_id': creatorUserId,
      if (familiarityAlgorithm != null)
        'familiarity_algorithm': familiarityAlgorithm,
      if (fatherMemoryModelId != null)
        'father_memory_model_id': fatherMemoryModelId,
      if (nextTimeAlgorithm != null) 'next_time_algorithm': nextTimeAlgorithm,
      if (stimulateAlgorithm != null) 'stimulate_algorithm': stimulateAlgorithm,
      if (title != null) 'title': title,
      if (createdAt != null) 'created_at': createdAt,
      if (id != null) 'id': id,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  MemoryModelsCompanion copyWith(
      {Value<String>? buttonAlgorithm,
      Value<int>? creatorUserId,
      Value<String>? familiarityAlgorithm,
      Value<String?>? fatherMemoryModelId,
      Value<String>? nextTimeAlgorithm,
      Value<String>? stimulateAlgorithm,
      Value<String>? title,
      Value<DateTime>? createdAt,
      Value<String>? id,
      Value<DateTime>? updatedAt}) {
    return MemoryModelsCompanion(
      buttonAlgorithm: buttonAlgorithm ?? this.buttonAlgorithm,
      creatorUserId: creatorUserId ?? this.creatorUserId,
      familiarityAlgorithm: familiarityAlgorithm ?? this.familiarityAlgorithm,
      fatherMemoryModelId: fatherMemoryModelId ?? this.fatherMemoryModelId,
      nextTimeAlgorithm: nextTimeAlgorithm ?? this.nextTimeAlgorithm,
      stimulateAlgorithm: stimulateAlgorithm ?? this.stimulateAlgorithm,
      title: title ?? this.title,
      createdAt: createdAt ?? this.createdAt,
      id: id ?? this.id,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (buttonAlgorithm.present) {
      map['button_algorithm'] = Variable<String>(buttonAlgorithm.value);
    }
    if (creatorUserId.present) {
      map['creator_user_id'] = Variable<int>(creatorUserId.value);
    }
    if (familiarityAlgorithm.present) {
      map['familiarity_algorithm'] =
          Variable<String>(familiarityAlgorithm.value);
    }
    if (fatherMemoryModelId.present) {
      map['father_memory_model_id'] =
          Variable<String>(fatherMemoryModelId.value);
    }
    if (nextTimeAlgorithm.present) {
      map['next_time_algorithm'] = Variable<String>(nextTimeAlgorithm.value);
    }
    if (stimulateAlgorithm.present) {
      map['stimulate_algorithm'] = Variable<String>(stimulateAlgorithm.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MemoryModelsCompanion(')
          ..write('buttonAlgorithm: $buttonAlgorithm, ')
          ..write('creatorUserId: $creatorUserId, ')
          ..write('familiarityAlgorithm: $familiarityAlgorithm, ')
          ..write('fatherMemoryModelId: $fatherMemoryModelId, ')
          ..write('nextTimeAlgorithm: $nextTimeAlgorithm, ')
          ..write('stimulateAlgorithm: $stimulateAlgorithm, ')
          ..write('title: $title, ')
          ..write('createdAt: $createdAt, ')
          ..write('id: $id, ')
          ..write('updatedAt: $updatedAt')
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
  final VerificationMeta _buttonAlgorithmMeta =
      const VerificationMeta('buttonAlgorithm');
  @override
  late final GeneratedColumn<String> buttonAlgorithm = GeneratedColumn<String>(
      'button_algorithm', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _creatorUserIdMeta =
      const VerificationMeta('creatorUserId');
  @override
  late final GeneratedColumn<int> creatorUserId = GeneratedColumn<int>(
      'creator_user_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  final VerificationMeta _familiarityAlgorithmMeta =
      const VerificationMeta('familiarityAlgorithm');
  @override
  late final GeneratedColumn<String> familiarityAlgorithm =
      GeneratedColumn<String>('familiarity_algorithm', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _fatherMemoryModelIdMeta =
      const VerificationMeta('fatherMemoryModelId');
  @override
  late final GeneratedColumn<String> fatherMemoryModelId =
      GeneratedColumn<String>('father_memory_model_id', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  final VerificationMeta _nextTimeAlgorithmMeta =
      const VerificationMeta('nextTimeAlgorithm');
  @override
  late final GeneratedColumn<String> nextTimeAlgorithm =
      GeneratedColumn<String>('next_time_algorithm', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _stimulateAlgorithmMeta =
      const VerificationMeta('stimulateAlgorithm');
  @override
  late final GeneratedColumn<String> stimulateAlgorithm =
      GeneratedColumn<String>('stimulate_algorithm', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        buttonAlgorithm,
        creatorUserId,
        familiarityAlgorithm,
        fatherMemoryModelId,
        nextTimeAlgorithm,
        stimulateAlgorithm,
        title,
        createdAt,
        id,
        updatedAt
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
    if (data.containsKey('button_algorithm')) {
      context.handle(
          _buttonAlgorithmMeta,
          buttonAlgorithm.isAcceptableOrUnknown(
              data['button_algorithm']!, _buttonAlgorithmMeta));
    } else if (isInserting) {
      context.missing(_buttonAlgorithmMeta);
    }
    if (data.containsKey('creator_user_id')) {
      context.handle(
          _creatorUserIdMeta,
          creatorUserId.isAcceptableOrUnknown(
              data['creator_user_id']!, _creatorUserIdMeta));
    } else if (isInserting) {
      context.missing(_creatorUserIdMeta);
    }
    if (data.containsKey('familiarity_algorithm')) {
      context.handle(
          _familiarityAlgorithmMeta,
          familiarityAlgorithm.isAcceptableOrUnknown(
              data['familiarity_algorithm']!, _familiarityAlgorithmMeta));
    } else if (isInserting) {
      context.missing(_familiarityAlgorithmMeta);
    }
    if (data.containsKey('father_memory_model_id')) {
      context.handle(
          _fatherMemoryModelIdMeta,
          fatherMemoryModelId.isAcceptableOrUnknown(
              data['father_memory_model_id']!, _fatherMemoryModelIdMeta));
    }
    if (data.containsKey('next_time_algorithm')) {
      context.handle(
          _nextTimeAlgorithmMeta,
          nextTimeAlgorithm.isAcceptableOrUnknown(
              data['next_time_algorithm']!, _nextTimeAlgorithmMeta));
    } else if (isInserting) {
      context.missing(_nextTimeAlgorithmMeta);
    }
    if (data.containsKey('stimulate_algorithm')) {
      context.handle(
          _stimulateAlgorithmMeta,
          stimulateAlgorithm.isAcceptableOrUnknown(
              data['stimulate_algorithm']!, _stimulateAlgorithmMeta));
    } else if (isInserting) {
      context.missing(_stimulateAlgorithmMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MemoryModel map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MemoryModel(
      buttonAlgorithm: attachedDatabase.options.types.read(
          DriftSqlType.string, data['${effectivePrefix}button_algorithm'])!,
      creatorUserId: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}creator_user_id'])!,
      familiarityAlgorithm: attachedDatabase.options.types.read(
          DriftSqlType.string,
          data['${effectivePrefix}familiarity_algorithm'])!,
      fatherMemoryModelId: attachedDatabase.options.types.read(
          DriftSqlType.string,
          data['${effectivePrefix}father_memory_model_id']),
      nextTimeAlgorithm: attachedDatabase.options.types.read(
          DriftSqlType.string, data['${effectivePrefix}next_time_algorithm'])!,
      stimulateAlgorithm: attachedDatabase.options.types.read(
          DriftSqlType.string, data['${effectivePrefix}stimulate_algorithm'])!,
      title: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      createdAt: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      id: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      updatedAt: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $MemoryModelsTable createAlias(String alias) {
    return $MemoryModelsTable(attachedDatabase, alias);
  }
}

class Note extends DataClass implements Insertable<Note> {
  String content;
  int creatorUserId;
  String? documentId;
  String? fatherNoteId;
  DateTime createdAt;
  String id;
  DateTime updatedAt;
  Note(
      {required this.content,
      required this.creatorUserId,
      this.documentId,
      this.fatherNoteId,
      required this.createdAt,
      required this.id,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['content'] = Variable<String>(content);
    map['creator_user_id'] = Variable<int>(creatorUserId);
    if (!nullToAbsent || documentId != null) {
      map['document_id'] = Variable<String>(documentId);
    }
    if (!nullToAbsent || fatherNoteId != null) {
      map['father_note_id'] = Variable<String>(fatherNoteId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['id'] = Variable<String>(id);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  NotesCompanion toCompanion(bool nullToAbsent) {
    return NotesCompanion(
      content: Value(content),
      creatorUserId: Value(creatorUserId),
      documentId: documentId == null && nullToAbsent
          ? const Value.absent()
          : Value(documentId),
      fatherNoteId: fatherNoteId == null && nullToAbsent
          ? const Value.absent()
          : Value(fatherNoteId),
      createdAt: Value(createdAt),
      id: Value(id),
      updatedAt: Value(updatedAt),
    );
  }

  factory Note.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Note(
      content: serializer.fromJson<String>(json['content']),
      creatorUserId: serializer.fromJson<int>(json['creatorUserId']),
      documentId: serializer.fromJson<String?>(json['documentId']),
      fatherNoteId: serializer.fromJson<String?>(json['fatherNoteId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      id: serializer.fromJson<String>(json['id']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'content': serializer.toJson<String>(content),
      'creatorUserId': serializer.toJson<int>(creatorUserId),
      'documentId': serializer.toJson<String?>(documentId),
      'fatherNoteId': serializer.toJson<String?>(fatherNoteId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'id': serializer.toJson<String>(id),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Note copyWith(
          {String? content,
          int? creatorUserId,
          Value<String?> documentId = const Value.absent(),
          Value<String?> fatherNoteId = const Value.absent(),
          DateTime? createdAt,
          String? id,
          DateTime? updatedAt}) =>
      Note(
        content: content ?? this.content,
        creatorUserId: creatorUserId ?? this.creatorUserId,
        documentId: documentId.present ? documentId.value : this.documentId,
        fatherNoteId:
            fatherNoteId.present ? fatherNoteId.value : this.fatherNoteId,
        createdAt: createdAt ?? this.createdAt,
        id: id ?? this.id,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  @override
  String toString() {
    return (StringBuffer('Note(')
          ..write('content: $content, ')
          ..write('creatorUserId: $creatorUserId, ')
          ..write('documentId: $documentId, ')
          ..write('fatherNoteId: $fatherNoteId, ')
          ..write('createdAt: $createdAt, ')
          ..write('id: $id, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(content, creatorUserId, documentId,
      fatherNoteId, createdAt, id, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Note &&
          other.content == this.content &&
          other.creatorUserId == this.creatorUserId &&
          other.documentId == this.documentId &&
          other.fatherNoteId == this.fatherNoteId &&
          other.createdAt == this.createdAt &&
          other.id == this.id &&
          other.updatedAt == this.updatedAt);
}

class NotesCompanion extends UpdateCompanion<Note> {
  Value<String> content;
  Value<int> creatorUserId;
  Value<String?> documentId;
  Value<String?> fatherNoteId;
  Value<DateTime> createdAt;
  Value<String> id;
  Value<DateTime> updatedAt;
  NotesCompanion({
    this.content = const Value.absent(),
    this.creatorUserId = const Value.absent(),
    this.documentId = const Value.absent(),
    this.fatherNoteId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.id = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  NotesCompanion.insert({
    required String content,
    required int creatorUserId,
    this.documentId = const Value.absent(),
    this.fatherNoteId = const Value.absent(),
    required DateTime createdAt,
    required String id,
    required DateTime updatedAt,
  })  : content = Value(content),
        creatorUserId = Value(creatorUserId),
        createdAt = Value(createdAt),
        id = Value(id),
        updatedAt = Value(updatedAt);
  static Insertable<Note> custom({
    Expression<String>? content,
    Expression<int>? creatorUserId,
    Expression<String>? documentId,
    Expression<String>? fatherNoteId,
    Expression<DateTime>? createdAt,
    Expression<String>? id,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (content != null) 'content': content,
      if (creatorUserId != null) 'creator_user_id': creatorUserId,
      if (documentId != null) 'document_id': documentId,
      if (fatherNoteId != null) 'father_note_id': fatherNoteId,
      if (createdAt != null) 'created_at': createdAt,
      if (id != null) 'id': id,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  NotesCompanion copyWith(
      {Value<String>? content,
      Value<int>? creatorUserId,
      Value<String?>? documentId,
      Value<String?>? fatherNoteId,
      Value<DateTime>? createdAt,
      Value<String>? id,
      Value<DateTime>? updatedAt}) {
    return NotesCompanion(
      content: content ?? this.content,
      creatorUserId: creatorUserId ?? this.creatorUserId,
      documentId: documentId ?? this.documentId,
      fatherNoteId: fatherNoteId ?? this.fatherNoteId,
      createdAt: createdAt ?? this.createdAt,
      id: id ?? this.id,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (creatorUserId.present) {
      map['creator_user_id'] = Variable<int>(creatorUserId.value);
    }
    if (documentId.present) {
      map['document_id'] = Variable<String>(documentId.value);
    }
    if (fatherNoteId.present) {
      map['father_note_id'] = Variable<String>(fatherNoteId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NotesCompanion(')
          ..write('content: $content, ')
          ..write('creatorUserId: $creatorUserId, ')
          ..write('documentId: $documentId, ')
          ..write('fatherNoteId: $fatherNoteId, ')
          ..write('createdAt: $createdAt, ')
          ..write('id: $id, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $NotesTable extends Notes with TableInfo<$NotesTable, Note> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NotesTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _contentMeta = const VerificationMeta('content');
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
      'content', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _creatorUserIdMeta =
      const VerificationMeta('creatorUserId');
  @override
  late final GeneratedColumn<int> creatorUserId = GeneratedColumn<int>(
      'creator_user_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  final VerificationMeta _documentIdMeta = const VerificationMeta('documentId');
  @override
  late final GeneratedColumn<String> documentId = GeneratedColumn<String>(
      'document_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  final VerificationMeta _fatherNoteIdMeta =
      const VerificationMeta('fatherNoteId');
  @override
  late final GeneratedColumn<String> fatherNoteId = GeneratedColumn<String>(
      'father_note_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        content,
        creatorUserId,
        documentId,
        fatherNoteId,
        createdAt,
        id,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? 'notes';
  @override
  String get actualTableName => 'notes';
  @override
  VerificationContext validateIntegrity(Insertable<Note> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('creator_user_id')) {
      context.handle(
          _creatorUserIdMeta,
          creatorUserId.isAcceptableOrUnknown(
              data['creator_user_id']!, _creatorUserIdMeta));
    } else if (isInserting) {
      context.missing(_creatorUserIdMeta);
    }
    if (data.containsKey('document_id')) {
      context.handle(
          _documentIdMeta,
          documentId.isAcceptableOrUnknown(
              data['document_id']!, _documentIdMeta));
    }
    if (data.containsKey('father_note_id')) {
      context.handle(
          _fatherNoteIdMeta,
          fatherNoteId.isAcceptableOrUnknown(
              data['father_note_id']!, _fatherNoteIdMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Note map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Note(
      content: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}content'])!,
      creatorUserId: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}creator_user_id'])!,
      documentId: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}document_id']),
      fatherNoteId: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}father_note_id']),
      createdAt: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      id: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      updatedAt: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $NotesTable createAlias(String alias) {
    return $NotesTable(attachedDatabase, alias);
  }
}

class DocumentGroup extends DataClass implements Insertable<DocumentGroup> {
  int creatorUserId;
  String? fatherDocumentGroupsId;
  String title;
  DateTime createdAt;
  String id;
  DateTime updatedAt;
  DocumentGroup(
      {required this.creatorUserId,
      this.fatherDocumentGroupsId,
      required this.title,
      required this.createdAt,
      required this.id,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['creator_user_id'] = Variable<int>(creatorUserId);
    if (!nullToAbsent || fatherDocumentGroupsId != null) {
      map['father_document_groups_id'] =
          Variable<String>(fatherDocumentGroupsId);
    }
    map['title'] = Variable<String>(title);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['id'] = Variable<String>(id);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  DocumentGroupsCompanion toCompanion(bool nullToAbsent) {
    return DocumentGroupsCompanion(
      creatorUserId: Value(creatorUserId),
      fatherDocumentGroupsId: fatherDocumentGroupsId == null && nullToAbsent
          ? const Value.absent()
          : Value(fatherDocumentGroupsId),
      title: Value(title),
      createdAt: Value(createdAt),
      id: Value(id),
      updatedAt: Value(updatedAt),
    );
  }

  factory DocumentGroup.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DocumentGroup(
      creatorUserId: serializer.fromJson<int>(json['creatorUserId']),
      fatherDocumentGroupsId:
          serializer.fromJson<String?>(json['fatherDocumentGroupsId']),
      title: serializer.fromJson<String>(json['title']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      id: serializer.fromJson<String>(json['id']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'creatorUserId': serializer.toJson<int>(creatorUserId),
      'fatherDocumentGroupsId':
          serializer.toJson<String?>(fatherDocumentGroupsId),
      'title': serializer.toJson<String>(title),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'id': serializer.toJson<String>(id),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  DocumentGroup copyWith(
          {int? creatorUserId,
          Value<String?> fatherDocumentGroupsId = const Value.absent(),
          String? title,
          DateTime? createdAt,
          String? id,
          DateTime? updatedAt}) =>
      DocumentGroup(
        creatorUserId: creatorUserId ?? this.creatorUserId,
        fatherDocumentGroupsId: fatherDocumentGroupsId.present
            ? fatherDocumentGroupsId.value
            : this.fatherDocumentGroupsId,
        title: title ?? this.title,
        createdAt: createdAt ?? this.createdAt,
        id: id ?? this.id,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  @override
  String toString() {
    return (StringBuffer('DocumentGroup(')
          ..write('creatorUserId: $creatorUserId, ')
          ..write('fatherDocumentGroupsId: $fatherDocumentGroupsId, ')
          ..write('title: $title, ')
          ..write('createdAt: $createdAt, ')
          ..write('id: $id, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      creatorUserId, fatherDocumentGroupsId, title, createdAt, id, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DocumentGroup &&
          other.creatorUserId == this.creatorUserId &&
          other.fatherDocumentGroupsId == this.fatherDocumentGroupsId &&
          other.title == this.title &&
          other.createdAt == this.createdAt &&
          other.id == this.id &&
          other.updatedAt == this.updatedAt);
}

class DocumentGroupsCompanion extends UpdateCompanion<DocumentGroup> {
  Value<int> creatorUserId;
  Value<String?> fatherDocumentGroupsId;
  Value<String> title;
  Value<DateTime> createdAt;
  Value<String> id;
  Value<DateTime> updatedAt;
  DocumentGroupsCompanion({
    this.creatorUserId = const Value.absent(),
    this.fatherDocumentGroupsId = const Value.absent(),
    this.title = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.id = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  DocumentGroupsCompanion.insert({
    required int creatorUserId,
    this.fatherDocumentGroupsId = const Value.absent(),
    required String title,
    required DateTime createdAt,
    required String id,
    required DateTime updatedAt,
  })  : creatorUserId = Value(creatorUserId),
        title = Value(title),
        createdAt = Value(createdAt),
        id = Value(id),
        updatedAt = Value(updatedAt);
  static Insertable<DocumentGroup> custom({
    Expression<int>? creatorUserId,
    Expression<String>? fatherDocumentGroupsId,
    Expression<String>? title,
    Expression<DateTime>? createdAt,
    Expression<String>? id,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (creatorUserId != null) 'creator_user_id': creatorUserId,
      if (fatherDocumentGroupsId != null)
        'father_document_groups_id': fatherDocumentGroupsId,
      if (title != null) 'title': title,
      if (createdAt != null) 'created_at': createdAt,
      if (id != null) 'id': id,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  DocumentGroupsCompanion copyWith(
      {Value<int>? creatorUserId,
      Value<String?>? fatherDocumentGroupsId,
      Value<String>? title,
      Value<DateTime>? createdAt,
      Value<String>? id,
      Value<DateTime>? updatedAt}) {
    return DocumentGroupsCompanion(
      creatorUserId: creatorUserId ?? this.creatorUserId,
      fatherDocumentGroupsId:
          fatherDocumentGroupsId ?? this.fatherDocumentGroupsId,
      title: title ?? this.title,
      createdAt: createdAt ?? this.createdAt,
      id: id ?? this.id,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (creatorUserId.present) {
      map['creator_user_id'] = Variable<int>(creatorUserId.value);
    }
    if (fatherDocumentGroupsId.present) {
      map['father_document_groups_id'] =
          Variable<String>(fatherDocumentGroupsId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DocumentGroupsCompanion(')
          ..write('creatorUserId: $creatorUserId, ')
          ..write('fatherDocumentGroupsId: $fatherDocumentGroupsId, ')
          ..write('title: $title, ')
          ..write('createdAt: $createdAt, ')
          ..write('id: $id, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $DocumentGroupsTable extends DocumentGroups
    with TableInfo<$DocumentGroupsTable, DocumentGroup> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DocumentGroupsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _creatorUserIdMeta =
      const VerificationMeta('creatorUserId');
  @override
  late final GeneratedColumn<int> creatorUserId = GeneratedColumn<int>(
      'creator_user_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  final VerificationMeta _fatherDocumentGroupsIdMeta =
      const VerificationMeta('fatherDocumentGroupsId');
  @override
  late final GeneratedColumn<String> fatherDocumentGroupsId =
      GeneratedColumn<String>('father_document_groups_id', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  final VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [creatorUserId, fatherDocumentGroupsId, title, createdAt, id, updatedAt];
  @override
  String get aliasedName => _alias ?? 'document_groups';
  @override
  String get actualTableName => 'document_groups';
  @override
  VerificationContext validateIntegrity(Insertable<DocumentGroup> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('creator_user_id')) {
      context.handle(
          _creatorUserIdMeta,
          creatorUserId.isAcceptableOrUnknown(
              data['creator_user_id']!, _creatorUserIdMeta));
    } else if (isInserting) {
      context.missing(_creatorUserIdMeta);
    }
    if (data.containsKey('father_document_groups_id')) {
      context.handle(
          _fatherDocumentGroupsIdMeta,
          fatherDocumentGroupsId.isAcceptableOrUnknown(
              data['father_document_groups_id']!, _fatherDocumentGroupsIdMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DocumentGroup map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DocumentGroup(
      creatorUserId: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}creator_user_id'])!,
      fatherDocumentGroupsId: attachedDatabase.options.types.read(
          DriftSqlType.string,
          data['${effectivePrefix}father_document_groups_id']),
      title: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      createdAt: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      id: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      updatedAt: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $DocumentGroupsTable createAlias(String alias) {
    return $DocumentGroupsTable(attachedDatabase, alias);
  }
}

class FragmentGroup extends DataClass implements Insertable<FragmentGroup> {
  int creatorUserId;
  String? fatherFragmentGroupsId;
  bool isSelected;
  String title;
  DateTime createdAt;
  String id;
  DateTime updatedAt;
  FragmentGroup(
      {required this.creatorUserId,
      this.fatherFragmentGroupsId,
      required this.isSelected,
      required this.title,
      required this.createdAt,
      required this.id,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['creator_user_id'] = Variable<int>(creatorUserId);
    if (!nullToAbsent || fatherFragmentGroupsId != null) {
      map['father_fragment_groups_id'] =
          Variable<String>(fatherFragmentGroupsId);
    }
    map['is_selected'] = Variable<bool>(isSelected);
    map['title'] = Variable<String>(title);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['id'] = Variable<String>(id);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  FragmentGroupsCompanion toCompanion(bool nullToAbsent) {
    return FragmentGroupsCompanion(
      creatorUserId: Value(creatorUserId),
      fatherFragmentGroupsId: fatherFragmentGroupsId == null && nullToAbsent
          ? const Value.absent()
          : Value(fatherFragmentGroupsId),
      isSelected: Value(isSelected),
      title: Value(title),
      createdAt: Value(createdAt),
      id: Value(id),
      updatedAt: Value(updatedAt),
    );
  }

  factory FragmentGroup.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FragmentGroup(
      creatorUserId: serializer.fromJson<int>(json['creatorUserId']),
      fatherFragmentGroupsId:
          serializer.fromJson<String?>(json['fatherFragmentGroupsId']),
      isSelected: serializer.fromJson<bool>(json['isSelected']),
      title: serializer.fromJson<String>(json['title']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      id: serializer.fromJson<String>(json['id']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'creatorUserId': serializer.toJson<int>(creatorUserId),
      'fatherFragmentGroupsId':
          serializer.toJson<String?>(fatherFragmentGroupsId),
      'isSelected': serializer.toJson<bool>(isSelected),
      'title': serializer.toJson<String>(title),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'id': serializer.toJson<String>(id),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  FragmentGroup copyWith(
          {int? creatorUserId,
          Value<String?> fatherFragmentGroupsId = const Value.absent(),
          bool? isSelected,
          String? title,
          DateTime? createdAt,
          String? id,
          DateTime? updatedAt}) =>
      FragmentGroup(
        creatorUserId: creatorUserId ?? this.creatorUserId,
        fatherFragmentGroupsId: fatherFragmentGroupsId.present
            ? fatherFragmentGroupsId.value
            : this.fatherFragmentGroupsId,
        isSelected: isSelected ?? this.isSelected,
        title: title ?? this.title,
        createdAt: createdAt ?? this.createdAt,
        id: id ?? this.id,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  @override
  String toString() {
    return (StringBuffer('FragmentGroup(')
          ..write('creatorUserId: $creatorUserId, ')
          ..write('fatherFragmentGroupsId: $fatherFragmentGroupsId, ')
          ..write('isSelected: $isSelected, ')
          ..write('title: $title, ')
          ..write('createdAt: $createdAt, ')
          ..write('id: $id, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(creatorUserId, fatherFragmentGroupsId,
      isSelected, title, createdAt, id, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FragmentGroup &&
          other.creatorUserId == this.creatorUserId &&
          other.fatherFragmentGroupsId == this.fatherFragmentGroupsId &&
          other.isSelected == this.isSelected &&
          other.title == this.title &&
          other.createdAt == this.createdAt &&
          other.id == this.id &&
          other.updatedAt == this.updatedAt);
}

class FragmentGroupsCompanion extends UpdateCompanion<FragmentGroup> {
  Value<int> creatorUserId;
  Value<String?> fatherFragmentGroupsId;
  Value<bool> isSelected;
  Value<String> title;
  Value<DateTime> createdAt;
  Value<String> id;
  Value<DateTime> updatedAt;
  FragmentGroupsCompanion({
    this.creatorUserId = const Value.absent(),
    this.fatherFragmentGroupsId = const Value.absent(),
    this.isSelected = const Value.absent(),
    this.title = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.id = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  FragmentGroupsCompanion.insert({
    required int creatorUserId,
    this.fatherFragmentGroupsId = const Value.absent(),
    required bool isSelected,
    required String title,
    required DateTime createdAt,
    required String id,
    required DateTime updatedAt,
  })  : creatorUserId = Value(creatorUserId),
        isSelected = Value(isSelected),
        title = Value(title),
        createdAt = Value(createdAt),
        id = Value(id),
        updatedAt = Value(updatedAt);
  static Insertable<FragmentGroup> custom({
    Expression<int>? creatorUserId,
    Expression<String>? fatherFragmentGroupsId,
    Expression<bool>? isSelected,
    Expression<String>? title,
    Expression<DateTime>? createdAt,
    Expression<String>? id,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (creatorUserId != null) 'creator_user_id': creatorUserId,
      if (fatherFragmentGroupsId != null)
        'father_fragment_groups_id': fatherFragmentGroupsId,
      if (isSelected != null) 'is_selected': isSelected,
      if (title != null) 'title': title,
      if (createdAt != null) 'created_at': createdAt,
      if (id != null) 'id': id,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  FragmentGroupsCompanion copyWith(
      {Value<int>? creatorUserId,
      Value<String?>? fatherFragmentGroupsId,
      Value<bool>? isSelected,
      Value<String>? title,
      Value<DateTime>? createdAt,
      Value<String>? id,
      Value<DateTime>? updatedAt}) {
    return FragmentGroupsCompanion(
      creatorUserId: creatorUserId ?? this.creatorUserId,
      fatherFragmentGroupsId:
          fatherFragmentGroupsId ?? this.fatherFragmentGroupsId,
      isSelected: isSelected ?? this.isSelected,
      title: title ?? this.title,
      createdAt: createdAt ?? this.createdAt,
      id: id ?? this.id,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (creatorUserId.present) {
      map['creator_user_id'] = Variable<int>(creatorUserId.value);
    }
    if (fatherFragmentGroupsId.present) {
      map['father_fragment_groups_id'] =
          Variable<String>(fatherFragmentGroupsId.value);
    }
    if (isSelected.present) {
      map['is_selected'] = Variable<bool>(isSelected.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FragmentGroupsCompanion(')
          ..write('creatorUserId: $creatorUserId, ')
          ..write('fatherFragmentGroupsId: $fatherFragmentGroupsId, ')
          ..write('isSelected: $isSelected, ')
          ..write('title: $title, ')
          ..write('createdAt: $createdAt, ')
          ..write('id: $id, ')
          ..write('updatedAt: $updatedAt')
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
  final VerificationMeta _creatorUserIdMeta =
      const VerificationMeta('creatorUserId');
  @override
  late final GeneratedColumn<int> creatorUserId = GeneratedColumn<int>(
      'creator_user_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  final VerificationMeta _fatherFragmentGroupsIdMeta =
      const VerificationMeta('fatherFragmentGroupsId');
  @override
  late final GeneratedColumn<String> fatherFragmentGroupsId =
      GeneratedColumn<String>('father_fragment_groups_id', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  final VerificationMeta _isSelectedMeta = const VerificationMeta('isSelected');
  @override
  late final GeneratedColumn<bool> isSelected = GeneratedColumn<bool>(
      'is_selected', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: 'CHECK (is_selected IN (0, 1))');
  final VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        creatorUserId,
        fatherFragmentGroupsId,
        isSelected,
        title,
        createdAt,
        id,
        updatedAt
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
    if (data.containsKey('creator_user_id')) {
      context.handle(
          _creatorUserIdMeta,
          creatorUserId.isAcceptableOrUnknown(
              data['creator_user_id']!, _creatorUserIdMeta));
    } else if (isInserting) {
      context.missing(_creatorUserIdMeta);
    }
    if (data.containsKey('father_fragment_groups_id')) {
      context.handle(
          _fatherFragmentGroupsIdMeta,
          fatherFragmentGroupsId.isAcceptableOrUnknown(
              data['father_fragment_groups_id']!, _fatherFragmentGroupsIdMeta));
    }
    if (data.containsKey('is_selected')) {
      context.handle(
          _isSelectedMeta,
          isSelected.isAcceptableOrUnknown(
              data['is_selected']!, _isSelectedMeta));
    } else if (isInserting) {
      context.missing(_isSelectedMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FragmentGroup map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FragmentGroup(
      creatorUserId: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}creator_user_id'])!,
      fatherFragmentGroupsId: attachedDatabase.options.types.read(
          DriftSqlType.string,
          data['${effectivePrefix}father_fragment_groups_id']),
      isSelected: attachedDatabase.options.types
          .read(DriftSqlType.bool, data['${effectivePrefix}is_selected'])!,
      title: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      createdAt: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      id: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      updatedAt: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $FragmentGroupsTable createAlias(String alias) {
    return $FragmentGroupsTable(attachedDatabase, alias);
  }
}

class MemoryModelGroup extends DataClass
    implements Insertable<MemoryModelGroup> {
  int creatorUserId;
  String? fatherMemoryModelGroupsId;
  String title;
  DateTime createdAt;
  String id;
  DateTime updatedAt;
  MemoryModelGroup(
      {required this.creatorUserId,
      this.fatherMemoryModelGroupsId,
      required this.title,
      required this.createdAt,
      required this.id,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['creator_user_id'] = Variable<int>(creatorUserId);
    if (!nullToAbsent || fatherMemoryModelGroupsId != null) {
      map['father_memory_model_groups_id'] =
          Variable<String>(fatherMemoryModelGroupsId);
    }
    map['title'] = Variable<String>(title);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['id'] = Variable<String>(id);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  MemoryModelGroupsCompanion toCompanion(bool nullToAbsent) {
    return MemoryModelGroupsCompanion(
      creatorUserId: Value(creatorUserId),
      fatherMemoryModelGroupsId:
          fatherMemoryModelGroupsId == null && nullToAbsent
              ? const Value.absent()
              : Value(fatherMemoryModelGroupsId),
      title: Value(title),
      createdAt: Value(createdAt),
      id: Value(id),
      updatedAt: Value(updatedAt),
    );
  }

  factory MemoryModelGroup.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MemoryModelGroup(
      creatorUserId: serializer.fromJson<int>(json['creatorUserId']),
      fatherMemoryModelGroupsId:
          serializer.fromJson<String?>(json['fatherMemoryModelGroupsId']),
      title: serializer.fromJson<String>(json['title']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      id: serializer.fromJson<String>(json['id']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'creatorUserId': serializer.toJson<int>(creatorUserId),
      'fatherMemoryModelGroupsId':
          serializer.toJson<String?>(fatherMemoryModelGroupsId),
      'title': serializer.toJson<String>(title),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'id': serializer.toJson<String>(id),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  MemoryModelGroup copyWith(
          {int? creatorUserId,
          Value<String?> fatherMemoryModelGroupsId = const Value.absent(),
          String? title,
          DateTime? createdAt,
          String? id,
          DateTime? updatedAt}) =>
      MemoryModelGroup(
        creatorUserId: creatorUserId ?? this.creatorUserId,
        fatherMemoryModelGroupsId: fatherMemoryModelGroupsId.present
            ? fatherMemoryModelGroupsId.value
            : this.fatherMemoryModelGroupsId,
        title: title ?? this.title,
        createdAt: createdAt ?? this.createdAt,
        id: id ?? this.id,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  @override
  String toString() {
    return (StringBuffer('MemoryModelGroup(')
          ..write('creatorUserId: $creatorUserId, ')
          ..write('fatherMemoryModelGroupsId: $fatherMemoryModelGroupsId, ')
          ..write('title: $title, ')
          ..write('createdAt: $createdAt, ')
          ..write('id: $id, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(creatorUserId, fatherMemoryModelGroupsId,
      title, createdAt, id, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MemoryModelGroup &&
          other.creatorUserId == this.creatorUserId &&
          other.fatherMemoryModelGroupsId == this.fatherMemoryModelGroupsId &&
          other.title == this.title &&
          other.createdAt == this.createdAt &&
          other.id == this.id &&
          other.updatedAt == this.updatedAt);
}

class MemoryModelGroupsCompanion extends UpdateCompanion<MemoryModelGroup> {
  Value<int> creatorUserId;
  Value<String?> fatherMemoryModelGroupsId;
  Value<String> title;
  Value<DateTime> createdAt;
  Value<String> id;
  Value<DateTime> updatedAt;
  MemoryModelGroupsCompanion({
    this.creatorUserId = const Value.absent(),
    this.fatherMemoryModelGroupsId = const Value.absent(),
    this.title = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.id = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  MemoryModelGroupsCompanion.insert({
    required int creatorUserId,
    this.fatherMemoryModelGroupsId = const Value.absent(),
    required String title,
    required DateTime createdAt,
    required String id,
    required DateTime updatedAt,
  })  : creatorUserId = Value(creatorUserId),
        title = Value(title),
        createdAt = Value(createdAt),
        id = Value(id),
        updatedAt = Value(updatedAt);
  static Insertable<MemoryModelGroup> custom({
    Expression<int>? creatorUserId,
    Expression<String>? fatherMemoryModelGroupsId,
    Expression<String>? title,
    Expression<DateTime>? createdAt,
    Expression<String>? id,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (creatorUserId != null) 'creator_user_id': creatorUserId,
      if (fatherMemoryModelGroupsId != null)
        'father_memory_model_groups_id': fatherMemoryModelGroupsId,
      if (title != null) 'title': title,
      if (createdAt != null) 'created_at': createdAt,
      if (id != null) 'id': id,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  MemoryModelGroupsCompanion copyWith(
      {Value<int>? creatorUserId,
      Value<String?>? fatherMemoryModelGroupsId,
      Value<String>? title,
      Value<DateTime>? createdAt,
      Value<String>? id,
      Value<DateTime>? updatedAt}) {
    return MemoryModelGroupsCompanion(
      creatorUserId: creatorUserId ?? this.creatorUserId,
      fatherMemoryModelGroupsId:
          fatherMemoryModelGroupsId ?? this.fatherMemoryModelGroupsId,
      title: title ?? this.title,
      createdAt: createdAt ?? this.createdAt,
      id: id ?? this.id,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (creatorUserId.present) {
      map['creator_user_id'] = Variable<int>(creatorUserId.value);
    }
    if (fatherMemoryModelGroupsId.present) {
      map['father_memory_model_groups_id'] =
          Variable<String>(fatherMemoryModelGroupsId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MemoryModelGroupsCompanion(')
          ..write('creatorUserId: $creatorUserId, ')
          ..write('fatherMemoryModelGroupsId: $fatherMemoryModelGroupsId, ')
          ..write('title: $title, ')
          ..write('createdAt: $createdAt, ')
          ..write('id: $id, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $MemoryModelGroupsTable extends MemoryModelGroups
    with TableInfo<$MemoryModelGroupsTable, MemoryModelGroup> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MemoryModelGroupsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _creatorUserIdMeta =
      const VerificationMeta('creatorUserId');
  @override
  late final GeneratedColumn<int> creatorUserId = GeneratedColumn<int>(
      'creator_user_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  final VerificationMeta _fatherMemoryModelGroupsIdMeta =
      const VerificationMeta('fatherMemoryModelGroupsId');
  @override
  late final GeneratedColumn<String> fatherMemoryModelGroupsId =
      GeneratedColumn<String>(
          'father_memory_model_groups_id', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  final VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        creatorUserId,
        fatherMemoryModelGroupsId,
        title,
        createdAt,
        id,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? 'memory_model_groups';
  @override
  String get actualTableName => 'memory_model_groups';
  @override
  VerificationContext validateIntegrity(Insertable<MemoryModelGroup> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('creator_user_id')) {
      context.handle(
          _creatorUserIdMeta,
          creatorUserId.isAcceptableOrUnknown(
              data['creator_user_id']!, _creatorUserIdMeta));
    } else if (isInserting) {
      context.missing(_creatorUserIdMeta);
    }
    if (data.containsKey('father_memory_model_groups_id')) {
      context.handle(
          _fatherMemoryModelGroupsIdMeta,
          fatherMemoryModelGroupsId.isAcceptableOrUnknown(
              data['father_memory_model_groups_id']!,
              _fatherMemoryModelGroupsIdMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MemoryModelGroup map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MemoryModelGroup(
      creatorUserId: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}creator_user_id'])!,
      fatherMemoryModelGroupsId: attachedDatabase.options.types.read(
          DriftSqlType.string,
          data['${effectivePrefix}father_memory_model_groups_id']),
      title: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      createdAt: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      id: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      updatedAt: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $MemoryModelGroupsTable createAlias(String alias) {
    return $MemoryModelGroupsTable(attachedDatabase, alias);
  }
}

class NoteGroup extends DataClass implements Insertable<NoteGroup> {
  int creatorUserId;
  String? fatherNoteGroupsId;
  String title;
  DateTime createdAt;
  String id;
  DateTime updatedAt;
  NoteGroup(
      {required this.creatorUserId,
      this.fatherNoteGroupsId,
      required this.title,
      required this.createdAt,
      required this.id,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['creator_user_id'] = Variable<int>(creatorUserId);
    if (!nullToAbsent || fatherNoteGroupsId != null) {
      map['father_note_groups_id'] = Variable<String>(fatherNoteGroupsId);
    }
    map['title'] = Variable<String>(title);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['id'] = Variable<String>(id);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  NoteGroupsCompanion toCompanion(bool nullToAbsent) {
    return NoteGroupsCompanion(
      creatorUserId: Value(creatorUserId),
      fatherNoteGroupsId: fatherNoteGroupsId == null && nullToAbsent
          ? const Value.absent()
          : Value(fatherNoteGroupsId),
      title: Value(title),
      createdAt: Value(createdAt),
      id: Value(id),
      updatedAt: Value(updatedAt),
    );
  }

  factory NoteGroup.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NoteGroup(
      creatorUserId: serializer.fromJson<int>(json['creatorUserId']),
      fatherNoteGroupsId:
          serializer.fromJson<String?>(json['fatherNoteGroupsId']),
      title: serializer.fromJson<String>(json['title']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      id: serializer.fromJson<String>(json['id']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'creatorUserId': serializer.toJson<int>(creatorUserId),
      'fatherNoteGroupsId': serializer.toJson<String?>(fatherNoteGroupsId),
      'title': serializer.toJson<String>(title),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'id': serializer.toJson<String>(id),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  NoteGroup copyWith(
          {int? creatorUserId,
          Value<String?> fatherNoteGroupsId = const Value.absent(),
          String? title,
          DateTime? createdAt,
          String? id,
          DateTime? updatedAt}) =>
      NoteGroup(
        creatorUserId: creatorUserId ?? this.creatorUserId,
        fatherNoteGroupsId: fatherNoteGroupsId.present
            ? fatherNoteGroupsId.value
            : this.fatherNoteGroupsId,
        title: title ?? this.title,
        createdAt: createdAt ?? this.createdAt,
        id: id ?? this.id,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  @override
  String toString() {
    return (StringBuffer('NoteGroup(')
          ..write('creatorUserId: $creatorUserId, ')
          ..write('fatherNoteGroupsId: $fatherNoteGroupsId, ')
          ..write('title: $title, ')
          ..write('createdAt: $createdAt, ')
          ..write('id: $id, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      creatorUserId, fatherNoteGroupsId, title, createdAt, id, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NoteGroup &&
          other.creatorUserId == this.creatorUserId &&
          other.fatherNoteGroupsId == this.fatherNoteGroupsId &&
          other.title == this.title &&
          other.createdAt == this.createdAt &&
          other.id == this.id &&
          other.updatedAt == this.updatedAt);
}

class NoteGroupsCompanion extends UpdateCompanion<NoteGroup> {
  Value<int> creatorUserId;
  Value<String?> fatherNoteGroupsId;
  Value<String> title;
  Value<DateTime> createdAt;
  Value<String> id;
  Value<DateTime> updatedAt;
  NoteGroupsCompanion({
    this.creatorUserId = const Value.absent(),
    this.fatherNoteGroupsId = const Value.absent(),
    this.title = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.id = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  NoteGroupsCompanion.insert({
    required int creatorUserId,
    this.fatherNoteGroupsId = const Value.absent(),
    required String title,
    required DateTime createdAt,
    required String id,
    required DateTime updatedAt,
  })  : creatorUserId = Value(creatorUserId),
        title = Value(title),
        createdAt = Value(createdAt),
        id = Value(id),
        updatedAt = Value(updatedAt);
  static Insertable<NoteGroup> custom({
    Expression<int>? creatorUserId,
    Expression<String>? fatherNoteGroupsId,
    Expression<String>? title,
    Expression<DateTime>? createdAt,
    Expression<String>? id,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (creatorUserId != null) 'creator_user_id': creatorUserId,
      if (fatherNoteGroupsId != null)
        'father_note_groups_id': fatherNoteGroupsId,
      if (title != null) 'title': title,
      if (createdAt != null) 'created_at': createdAt,
      if (id != null) 'id': id,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  NoteGroupsCompanion copyWith(
      {Value<int>? creatorUserId,
      Value<String?>? fatherNoteGroupsId,
      Value<String>? title,
      Value<DateTime>? createdAt,
      Value<String>? id,
      Value<DateTime>? updatedAt}) {
    return NoteGroupsCompanion(
      creatorUserId: creatorUserId ?? this.creatorUserId,
      fatherNoteGroupsId: fatherNoteGroupsId ?? this.fatherNoteGroupsId,
      title: title ?? this.title,
      createdAt: createdAt ?? this.createdAt,
      id: id ?? this.id,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (creatorUserId.present) {
      map['creator_user_id'] = Variable<int>(creatorUserId.value);
    }
    if (fatherNoteGroupsId.present) {
      map['father_note_groups_id'] = Variable<String>(fatherNoteGroupsId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NoteGroupsCompanion(')
          ..write('creatorUserId: $creatorUserId, ')
          ..write('fatherNoteGroupsId: $fatherNoteGroupsId, ')
          ..write('title: $title, ')
          ..write('createdAt: $createdAt, ')
          ..write('id: $id, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $NoteGroupsTable extends NoteGroups
    with TableInfo<$NoteGroupsTable, NoteGroup> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NoteGroupsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _creatorUserIdMeta =
      const VerificationMeta('creatorUserId');
  @override
  late final GeneratedColumn<int> creatorUserId = GeneratedColumn<int>(
      'creator_user_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  final VerificationMeta _fatherNoteGroupsIdMeta =
      const VerificationMeta('fatherNoteGroupsId');
  @override
  late final GeneratedColumn<String> fatherNoteGroupsId =
      GeneratedColumn<String>('father_note_groups_id', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  final VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [creatorUserId, fatherNoteGroupsId, title, createdAt, id, updatedAt];
  @override
  String get aliasedName => _alias ?? 'note_groups';
  @override
  String get actualTableName => 'note_groups';
  @override
  VerificationContext validateIntegrity(Insertable<NoteGroup> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('creator_user_id')) {
      context.handle(
          _creatorUserIdMeta,
          creatorUserId.isAcceptableOrUnknown(
              data['creator_user_id']!, _creatorUserIdMeta));
    } else if (isInserting) {
      context.missing(_creatorUserIdMeta);
    }
    if (data.containsKey('father_note_groups_id')) {
      context.handle(
          _fatherNoteGroupsIdMeta,
          fatherNoteGroupsId.isAcceptableOrUnknown(
              data['father_note_groups_id']!, _fatherNoteGroupsIdMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NoteGroup map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NoteGroup(
      creatorUserId: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}creator_user_id'])!,
      fatherNoteGroupsId: attachedDatabase.options.types.read(
          DriftSqlType.string, data['${effectivePrefix}father_note_groups_id']),
      title: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      createdAt: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      id: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      updatedAt: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $NoteGroupsTable createAlias(String alias) {
    return $NoteGroupsTable(attachedDatabase, alias);
  }
}

abstract class _$DriftDb extends GeneratedDatabase {
  _$DriftDb(QueryExecutor e) : super(e);
  late final $UsersTable users = $UsersTable(this);
  late final $FragmentMemoryInfosTable fragmentMemoryInfos =
      $FragmentMemoryInfosTable(this);
  late final $AppInfosTable appInfos = $AppInfosTable(this);
  late final $SyncsTable syncs = $SyncsTable(this);
  late final $MemoryGroupsTable memoryGroups = $MemoryGroupsTable(this);
  late final $RDocument2DocumentGroupsTable rDocument2DocumentGroups =
      $RDocument2DocumentGroupsTable(this);
  late final $RFragment2FragmentGroupsTable rFragment2FragmentGroups =
      $RFragment2FragmentGroupsTable(this);
  late final $RMemoryModel2MemoryModelGroupsTable
      rMemoryModel2MemoryModelGroups =
      $RMemoryModel2MemoryModelGroupsTable(this);
  late final $RNote2NoteGroupsTable rNote2NoteGroups =
      $RNote2NoteGroupsTable(this);
  late final $DocumentsTable documents = $DocumentsTable(this);
  late final $FragmentsTable fragments = $FragmentsTable(this);
  late final $MemoryModelsTable memoryModels = $MemoryModelsTable(this);
  late final $NotesTable notes = $NotesTable(this);
  late final $DocumentGroupsTable documentGroups = $DocumentGroupsTable(this);
  late final $FragmentGroupsTable fragmentGroups = $FragmentGroupsTable(this);
  late final $MemoryModelGroupsTable memoryModelGroups =
      $MemoryModelGroupsTable(this);
  late final $NoteGroupsTable noteGroups = $NoteGroupsTable(this);
  late final InsertDAO insertDAO = InsertDAO(this as DriftDb);
  late final UpdateDAO updateDAO = UpdateDAO(this as DriftDb);
  late final DeleteDAO deleteDAO = DeleteDAO(this as DriftDb);
  late final GeneralQueryDAO generalQueryDAO = GeneralQueryDAO(this as DriftDb);
  @override
  Iterable<TableInfo<Table, dynamic>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        users,
        fragmentMemoryInfos,
        appInfos,
        syncs,
        memoryGroups,
        rDocument2DocumentGroups,
        rFragment2FragmentGroups,
        rMemoryModel2MemoryModelGroups,
        rNote2NoteGroups,
        documents,
        fragments,
        memoryModels,
        notes,
        documentGroups,
        fragmentGroups,
        memoryModelGroups,
        noteGroups
      ];
}

// **************************************************************************
// DaoGenerator
// **************************************************************************

mixin _$GeneralQueryDAOMixin on DatabaseAccessor<DriftDb> {
  $UsersTable get users => attachedDatabase.users;
  $FragmentMemoryInfosTable get fragmentMemoryInfos =>
      attachedDatabase.fragmentMemoryInfos;
  $AppInfosTable get appInfos => attachedDatabase.appInfos;
  $SyncsTable get syncs => attachedDatabase.syncs;
  $MemoryGroupsTable get memoryGroups => attachedDatabase.memoryGroups;
  $RDocument2DocumentGroupsTable get rDocument2DocumentGroups =>
      attachedDatabase.rDocument2DocumentGroups;
  $RFragment2FragmentGroupsTable get rFragment2FragmentGroups =>
      attachedDatabase.rFragment2FragmentGroups;
  $RMemoryModel2MemoryModelGroupsTable get rMemoryModel2MemoryModelGroups =>
      attachedDatabase.rMemoryModel2MemoryModelGroups;
  $RNote2NoteGroupsTable get rNote2NoteGroups =>
      attachedDatabase.rNote2NoteGroups;
  $DocumentsTable get documents => attachedDatabase.documents;
  $FragmentsTable get fragments => attachedDatabase.fragments;
  $MemoryModelsTable get memoryModels => attachedDatabase.memoryModels;
  $NotesTable get notes => attachedDatabase.notes;
  $DocumentGroupsTable get documentGroups => attachedDatabase.documentGroups;
  $FragmentGroupsTable get fragmentGroups => attachedDatabase.fragmentGroups;
  $MemoryModelGroupsTable get memoryModelGroups =>
      attachedDatabase.memoryModelGroups;
  $NoteGroupsTable get noteGroups => attachedDatabase.noteGroups;
}
mixin _$InsertDAOMixin on DatabaseAccessor<DriftDb> {
  $UsersTable get users => attachedDatabase.users;
  $FragmentMemoryInfosTable get fragmentMemoryInfos =>
      attachedDatabase.fragmentMemoryInfos;
  $AppInfosTable get appInfos => attachedDatabase.appInfos;
  $SyncsTable get syncs => attachedDatabase.syncs;
  $MemoryGroupsTable get memoryGroups => attachedDatabase.memoryGroups;
  $RDocument2DocumentGroupsTable get rDocument2DocumentGroups =>
      attachedDatabase.rDocument2DocumentGroups;
  $RFragment2FragmentGroupsTable get rFragment2FragmentGroups =>
      attachedDatabase.rFragment2FragmentGroups;
  $RMemoryModel2MemoryModelGroupsTable get rMemoryModel2MemoryModelGroups =>
      attachedDatabase.rMemoryModel2MemoryModelGroups;
  $RNote2NoteGroupsTable get rNote2NoteGroups =>
      attachedDatabase.rNote2NoteGroups;
  $DocumentsTable get documents => attachedDatabase.documents;
  $FragmentsTable get fragments => attachedDatabase.fragments;
  $MemoryModelsTable get memoryModels => attachedDatabase.memoryModels;
  $NotesTable get notes => attachedDatabase.notes;
  $DocumentGroupsTable get documentGroups => attachedDatabase.documentGroups;
  $FragmentGroupsTable get fragmentGroups => attachedDatabase.fragmentGroups;
  $MemoryModelGroupsTable get memoryModelGroups =>
      attachedDatabase.memoryModelGroups;
  $NoteGroupsTable get noteGroups => attachedDatabase.noteGroups;
}
mixin _$UpdateDAOMixin on DatabaseAccessor<DriftDb> {
  $UsersTable get users => attachedDatabase.users;
  $FragmentMemoryInfosTable get fragmentMemoryInfos =>
      attachedDatabase.fragmentMemoryInfos;
  $AppInfosTable get appInfos => attachedDatabase.appInfos;
  $SyncsTable get syncs => attachedDatabase.syncs;
  $MemoryGroupsTable get memoryGroups => attachedDatabase.memoryGroups;
  $RDocument2DocumentGroupsTable get rDocument2DocumentGroups =>
      attachedDatabase.rDocument2DocumentGroups;
  $RFragment2FragmentGroupsTable get rFragment2FragmentGroups =>
      attachedDatabase.rFragment2FragmentGroups;
  $RMemoryModel2MemoryModelGroupsTable get rMemoryModel2MemoryModelGroups =>
      attachedDatabase.rMemoryModel2MemoryModelGroups;
  $RNote2NoteGroupsTable get rNote2NoteGroups =>
      attachedDatabase.rNote2NoteGroups;
  $DocumentsTable get documents => attachedDatabase.documents;
  $FragmentsTable get fragments => attachedDatabase.fragments;
  $MemoryModelsTable get memoryModels => attachedDatabase.memoryModels;
  $NotesTable get notes => attachedDatabase.notes;
  $DocumentGroupsTable get documentGroups => attachedDatabase.documentGroups;
  $FragmentGroupsTable get fragmentGroups => attachedDatabase.fragmentGroups;
  $MemoryModelGroupsTable get memoryModelGroups =>
      attachedDatabase.memoryModelGroups;
  $NoteGroupsTable get noteGroups => attachedDatabase.noteGroups;
}
mixin _$DeleteDAOMixin on DatabaseAccessor<DriftDb> {
  $UsersTable get users => attachedDatabase.users;
  $FragmentMemoryInfosTable get fragmentMemoryInfos =>
      attachedDatabase.fragmentMemoryInfos;
  $AppInfosTable get appInfos => attachedDatabase.appInfos;
  $SyncsTable get syncs => attachedDatabase.syncs;
  $MemoryGroupsTable get memoryGroups => attachedDatabase.memoryGroups;
  $RDocument2DocumentGroupsTable get rDocument2DocumentGroups =>
      attachedDatabase.rDocument2DocumentGroups;
  $RFragment2FragmentGroupsTable get rFragment2FragmentGroups =>
      attachedDatabase.rFragment2FragmentGroups;
  $RMemoryModel2MemoryModelGroupsTable get rMemoryModel2MemoryModelGroups =>
      attachedDatabase.rMemoryModel2MemoryModelGroups;
  $RNote2NoteGroupsTable get rNote2NoteGroups =>
      attachedDatabase.rNote2NoteGroups;
  $DocumentsTable get documents => attachedDatabase.documents;
  $FragmentsTable get fragments => attachedDatabase.fragments;
  $MemoryModelsTable get memoryModels => attachedDatabase.memoryModels;
  $NotesTable get notes => attachedDatabase.notes;
  $DocumentGroupsTable get documentGroups => attachedDatabase.documentGroups;
  $FragmentGroupsTable get fragmentGroups => attachedDatabase.fragmentGroups;
  $MemoryModelGroupsTable get memoryModelGroups =>
      attachedDatabase.memoryModelGroups;
  $NoteGroupsTable get noteGroups => attachedDatabase.noteGroups;
}
