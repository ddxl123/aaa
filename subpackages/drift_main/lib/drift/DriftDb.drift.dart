// GENERATED CODE - DO NOT MODIFY BY HAND

part of drift_db;

// **************************************************************************
// DriftDatabaseGenerator
// **************************************************************************

// ignore_for_file: type=lint
class User extends DataClass implements Insertable<User> {
  int? age;
  String? email;
  String? password;
  String? username;
  DateTime createdAt;
  int? id;
  DateTime updatedAt;
  User(
      {this.age,
      this.email,
      this.password,
      this.username,
      required this.createdAt,
      this.id,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || age != null) {
      map['age'] = Variable<int>(age);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || password != null) {
      map['password'] = Variable<String>(password);
    }
    if (!nullToAbsent || username != null) {
      map['username'] = Variable<String>(username);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      age: age == null && nullToAbsent ? const Value.absent() : Value(age),
      email:
          email == null && nullToAbsent ? const Value.absent() : Value(email),
      password: password == null && nullToAbsent
          ? const Value.absent()
          : Value(password),
      username: username == null && nullToAbsent
          ? const Value.absent()
          : Value(username),
      createdAt: Value(createdAt),
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      updatedAt: Value(updatedAt),
    );
  }

  factory User.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return User(
      age: serializer.fromJson<int?>(json['age']),
      email: serializer.fromJson<String?>(json['email']),
      password: serializer.fromJson<String?>(json['password']),
      username: serializer.fromJson<String?>(json['username']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      id: serializer.fromJson<int?>(json['id']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'age': serializer.toJson<int?>(age),
      'email': serializer.toJson<String?>(email),
      'password': serializer.toJson<String?>(password),
      'username': serializer.toJson<String?>(username),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'id': serializer.toJson<int?>(id),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  User copyWith(
          {Value<int?> age = const Value.absent(),
          Value<String?> email = const Value.absent(),
          Value<String?> password = const Value.absent(),
          Value<String?> username = const Value.absent(),
          DateTime? createdAt,
          Value<int?> id = const Value.absent(),
          DateTime? updatedAt}) =>
      User(
        age: age.present ? age.value : this.age,
        email: email.present ? email.value : this.email,
        password: password.present ? password.value : this.password,
        username: username.present ? username.value : this.username,
        createdAt: createdAt ?? this.createdAt,
        id: id.present ? id.value : this.id,
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
  Value<int?> age;
  Value<String?> email;
  Value<String?> password;
  Value<String?> username;
  Value<DateTime> createdAt;
  Value<int?> id;
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
    this.age = const Value.absent(),
    this.email = const Value.absent(),
    this.password = const Value.absent(),
    this.username = const Value.absent(),
    required DateTime createdAt,
    this.id = const Value.absent(),
    required DateTime updatedAt,
  })  : createdAt = Value(createdAt),
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
      {Value<int?>? age,
      Value<String?>? email,
      Value<String?>? password,
      Value<String?>? username,
      Value<DateTime>? createdAt,
      Value<int?>? id,
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
      'age', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
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
      'username', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, true,
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
          .read(DriftSqlType.int, data['${effectivePrefix}age']),
      email: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}email']),
      password: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}password']),
      username: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}username']),
      createdAt: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      id: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id']),
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
  int clickTime;
  double clickValue;
  int creatorUserId;
  int currentActualShowTime;
  int fragmentId;
  bool isLatestRecord;
  int memoryGroupId;
  DateTime nextPlanShowTime;
  double showFamiliarity;
  DateTime createdAt;
  int? id;
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
      this.id,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['click_time'] = Variable<int>(clickTime);
    map['click_value'] = Variable<double>(clickValue);
    map['creator_user_id'] = Variable<int>(creatorUserId);
    map['current_actual_show_time'] = Variable<int>(currentActualShowTime);
    map['fragment_id'] = Variable<int>(fragmentId);
    map['is_latest_record'] = Variable<bool>(isLatestRecord);
    map['memory_group_id'] = Variable<int>(memoryGroupId);
    map['next_plan_show_time'] = Variable<DateTime>(nextPlanShowTime);
    map['show_familiarity'] = Variable<double>(showFamiliarity);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
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
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      updatedAt: Value(updatedAt),
    );
  }

  factory FragmentMemoryInfo.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FragmentMemoryInfo(
      clickTime: serializer.fromJson<int>(json['clickTime']),
      clickValue: serializer.fromJson<double>(json['clickValue']),
      creatorUserId: serializer.fromJson<int>(json['creatorUserId']),
      currentActualShowTime:
          serializer.fromJson<int>(json['currentActualShowTime']),
      fragmentId: serializer.fromJson<int>(json['fragmentId']),
      isLatestRecord: serializer.fromJson<bool>(json['isLatestRecord']),
      memoryGroupId: serializer.fromJson<int>(json['memoryGroupId']),
      nextPlanShowTime: serializer.fromJson<DateTime>(json['nextPlanShowTime']),
      showFamiliarity: serializer.fromJson<double>(json['showFamiliarity']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      id: serializer.fromJson<int?>(json['id']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'clickTime': serializer.toJson<int>(clickTime),
      'clickValue': serializer.toJson<double>(clickValue),
      'creatorUserId': serializer.toJson<int>(creatorUserId),
      'currentActualShowTime': serializer.toJson<int>(currentActualShowTime),
      'fragmentId': serializer.toJson<int>(fragmentId),
      'isLatestRecord': serializer.toJson<bool>(isLatestRecord),
      'memoryGroupId': serializer.toJson<int>(memoryGroupId),
      'nextPlanShowTime': serializer.toJson<DateTime>(nextPlanShowTime),
      'showFamiliarity': serializer.toJson<double>(showFamiliarity),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'id': serializer.toJson<int?>(id),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  FragmentMemoryInfo copyWith(
          {int? clickTime,
          double? clickValue,
          int? creatorUserId,
          int? currentActualShowTime,
          int? fragmentId,
          bool? isLatestRecord,
          int? memoryGroupId,
          DateTime? nextPlanShowTime,
          double? showFamiliarity,
          DateTime? createdAt,
          Value<int?> id = const Value.absent(),
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
        id: id.present ? id.value : this.id,
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
  Value<int> clickTime;
  Value<double> clickValue;
  Value<int> creatorUserId;
  Value<int> currentActualShowTime;
  Value<int> fragmentId;
  Value<bool> isLatestRecord;
  Value<int> memoryGroupId;
  Value<DateTime> nextPlanShowTime;
  Value<double> showFamiliarity;
  Value<DateTime> createdAt;
  Value<int?> id;
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
    required int clickTime,
    required double clickValue,
    required int creatorUserId,
    required int currentActualShowTime,
    required int fragmentId,
    required bool isLatestRecord,
    required int memoryGroupId,
    required DateTime nextPlanShowTime,
    required double showFamiliarity,
    required DateTime createdAt,
    this.id = const Value.absent(),
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
        updatedAt = Value(updatedAt);
  static Insertable<FragmentMemoryInfo> custom({
    Expression<int>? clickTime,
    Expression<double>? clickValue,
    Expression<int>? creatorUserId,
    Expression<int>? currentActualShowTime,
    Expression<int>? fragmentId,
    Expression<bool>? isLatestRecord,
    Expression<int>? memoryGroupId,
    Expression<DateTime>? nextPlanShowTime,
    Expression<double>? showFamiliarity,
    Expression<DateTime>? createdAt,
    Expression<int>? id,
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
      {Value<int>? clickTime,
      Value<double>? clickValue,
      Value<int>? creatorUserId,
      Value<int>? currentActualShowTime,
      Value<int>? fragmentId,
      Value<bool>? isLatestRecord,
      Value<int>? memoryGroupId,
      Value<DateTime>? nextPlanShowTime,
      Value<double>? showFamiliarity,
      Value<DateTime>? createdAt,
      Value<int?>? id,
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
      map['click_time'] = Variable<int>(clickTime.value);
    }
    if (clickValue.present) {
      map['click_value'] = Variable<double>(clickValue.value);
    }
    if (creatorUserId.present) {
      map['creator_user_id'] = Variable<int>(creatorUserId.value);
    }
    if (currentActualShowTime.present) {
      map['current_actual_show_time'] =
          Variable<int>(currentActualShowTime.value);
    }
    if (fragmentId.present) {
      map['fragment_id'] = Variable<int>(fragmentId.value);
    }
    if (isLatestRecord.present) {
      map['is_latest_record'] = Variable<bool>(isLatestRecord.value);
    }
    if (memoryGroupId.present) {
      map['memory_group_id'] = Variable<int>(memoryGroupId.value);
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
      map['id'] = Variable<int>(id.value);
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
  late final GeneratedColumn<int> clickTime = GeneratedColumn<int>(
      'click_time', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
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
  late final GeneratedColumn<int> currentActualShowTime = GeneratedColumn<int>(
      'current_actual_show_time', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  final VerificationMeta _fragmentIdMeta = const VerificationMeta('fragmentId');
  @override
  late final GeneratedColumn<int> fragmentId = GeneratedColumn<int>(
      'fragment_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
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
  late final GeneratedColumn<int> memoryGroupId = GeneratedColumn<int>(
      'memory_group_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
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
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
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
          .read(DriftSqlType.int, data['${effectivePrefix}click_time'])!,
      clickValue: attachedDatabase.options.types
          .read(DriftSqlType.double, data['${effectivePrefix}click_value'])!,
      creatorUserId: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}creator_user_id'])!,
      currentActualShowTime: attachedDatabase.options.types.read(
          DriftSqlType.int,
          data['${effectivePrefix}current_actual_show_time'])!,
      fragmentId: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}fragment_id'])!,
      isLatestRecord: attachedDatabase.options.types
          .read(DriftSqlType.bool, data['${effectivePrefix}is_latest_record'])!,
      memoryGroupId: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}memory_group_id'])!,
      nextPlanShowTime: attachedDatabase.options.types.read(
          DriftSqlType.dateTime,
          data['${effectivePrefix}next_plan_show_time'])!,
      showFamiliarity: attachedDatabase.options.types.read(
          DriftSqlType.double, data['${effectivePrefix}show_familiarity'])!,
      createdAt: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      id: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id']),
      updatedAt: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $FragmentMemoryInfosTable createAlias(String alias) {
    return $FragmentMemoryInfosTable(attachedDatabase, alias);
  }
}

class MemoryGroup extends DataClass implements Insertable<MemoryGroup> {
  int creatorUserId;
  int? memoryModelId;
  NewDisplayOrder? newDisplayOrder;
  NewReviewDisplayOrder? newReviewDisplayOrder;
  DateTime? reviewInterval;
  DateTime? startTime;
  String? title;
  int? willNewLearnCount;
  DateTime createdAt;
  int? id;
  DateTime updatedAt;
  MemoryGroup(
      {required this.creatorUserId,
      this.memoryModelId,
      this.newDisplayOrder,
      this.newReviewDisplayOrder,
      this.reviewInterval,
      this.startTime,
      this.title,
      this.willNewLearnCount,
      required this.createdAt,
      this.id,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['creator_user_id'] = Variable<int>(creatorUserId);
    if (!nullToAbsent || memoryModelId != null) {
      map['memory_model_id'] = Variable<int>(memoryModelId);
    }
    if (!nullToAbsent || newDisplayOrder != null) {
      final converter = $MemoryGroupsTable.$converter0n;
      map['new_display_order'] =
          Variable<int>(converter.toSql(newDisplayOrder));
    }
    if (!nullToAbsent || newReviewDisplayOrder != null) {
      final converter = $MemoryGroupsTable.$converter1n;
      map['new_review_display_order'] =
          Variable<int>(converter.toSql(newReviewDisplayOrder));
    }
    if (!nullToAbsent || reviewInterval != null) {
      map['review_interval'] = Variable<DateTime>(reviewInterval);
    }
    if (!nullToAbsent || startTime != null) {
      map['start_time'] = Variable<DateTime>(startTime);
    }
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    if (!nullToAbsent || willNewLearnCount != null) {
      map['will_new_learn_count'] = Variable<int>(willNewLearnCount);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  MemoryGroupsCompanion toCompanion(bool nullToAbsent) {
    return MemoryGroupsCompanion(
      creatorUserId: Value(creatorUserId),
      memoryModelId: memoryModelId == null && nullToAbsent
          ? const Value.absent()
          : Value(memoryModelId),
      newDisplayOrder: newDisplayOrder == null && nullToAbsent
          ? const Value.absent()
          : Value(newDisplayOrder),
      newReviewDisplayOrder: newReviewDisplayOrder == null && nullToAbsent
          ? const Value.absent()
          : Value(newReviewDisplayOrder),
      reviewInterval: reviewInterval == null && nullToAbsent
          ? const Value.absent()
          : Value(reviewInterval),
      startTime: startTime == null && nullToAbsent
          ? const Value.absent()
          : Value(startTime),
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
      willNewLearnCount: willNewLearnCount == null && nullToAbsent
          ? const Value.absent()
          : Value(willNewLearnCount),
      createdAt: Value(createdAt),
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      updatedAt: Value(updatedAt),
    );
  }

  factory MemoryGroup.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MemoryGroup(
      creatorUserId: serializer.fromJson<int>(json['creatorUserId']),
      memoryModelId: serializer.fromJson<int?>(json['memoryModelId']),
      newDisplayOrder:
          serializer.fromJson<NewDisplayOrder?>(json['newDisplayOrder']),
      newReviewDisplayOrder: serializer
          .fromJson<NewReviewDisplayOrder?>(json['newReviewDisplayOrder']),
      reviewInterval: serializer.fromJson<DateTime?>(json['reviewInterval']),
      startTime: serializer.fromJson<DateTime?>(json['startTime']),
      title: serializer.fromJson<String?>(json['title']),
      willNewLearnCount: serializer.fromJson<int?>(json['willNewLearnCount']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      id: serializer.fromJson<int?>(json['id']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'creatorUserId': serializer.toJson<int>(creatorUserId),
      'memoryModelId': serializer.toJson<int?>(memoryModelId),
      'newDisplayOrder': serializer.toJson<NewDisplayOrder?>(newDisplayOrder),
      'newReviewDisplayOrder':
          serializer.toJson<NewReviewDisplayOrder?>(newReviewDisplayOrder),
      'reviewInterval': serializer.toJson<DateTime?>(reviewInterval),
      'startTime': serializer.toJson<DateTime?>(startTime),
      'title': serializer.toJson<String?>(title),
      'willNewLearnCount': serializer.toJson<int?>(willNewLearnCount),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'id': serializer.toJson<int?>(id),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  MemoryGroup copyWith(
          {int? creatorUserId,
          Value<int?> memoryModelId = const Value.absent(),
          Value<NewDisplayOrder?> newDisplayOrder = const Value.absent(),
          Value<NewReviewDisplayOrder?> newReviewDisplayOrder =
              const Value.absent(),
          Value<DateTime?> reviewInterval = const Value.absent(),
          Value<DateTime?> startTime = const Value.absent(),
          Value<String?> title = const Value.absent(),
          Value<int?> willNewLearnCount = const Value.absent(),
          DateTime? createdAt,
          Value<int?> id = const Value.absent(),
          DateTime? updatedAt}) =>
      MemoryGroup(
        creatorUserId: creatorUserId ?? this.creatorUserId,
        memoryModelId:
            memoryModelId.present ? memoryModelId.value : this.memoryModelId,
        newDisplayOrder: newDisplayOrder.present
            ? newDisplayOrder.value
            : this.newDisplayOrder,
        newReviewDisplayOrder: newReviewDisplayOrder.present
            ? newReviewDisplayOrder.value
            : this.newReviewDisplayOrder,
        reviewInterval:
            reviewInterval.present ? reviewInterval.value : this.reviewInterval,
        startTime: startTime.present ? startTime.value : this.startTime,
        title: title.present ? title.value : this.title,
        willNewLearnCount: willNewLearnCount.present
            ? willNewLearnCount.value
            : this.willNewLearnCount,
        createdAt: createdAt ?? this.createdAt,
        id: id.present ? id.value : this.id,
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
  Value<int?> memoryModelId;
  Value<NewDisplayOrder?> newDisplayOrder;
  Value<NewReviewDisplayOrder?> newReviewDisplayOrder;
  Value<DateTime?> reviewInterval;
  Value<DateTime?> startTime;
  Value<String?> title;
  Value<int?> willNewLearnCount;
  Value<DateTime> createdAt;
  Value<int?> id;
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
    this.newDisplayOrder = const Value.absent(),
    this.newReviewDisplayOrder = const Value.absent(),
    this.reviewInterval = const Value.absent(),
    this.startTime = const Value.absent(),
    this.title = const Value.absent(),
    this.willNewLearnCount = const Value.absent(),
    required DateTime createdAt,
    this.id = const Value.absent(),
    required DateTime updatedAt,
  })  : creatorUserId = Value(creatorUserId),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<MemoryGroup> custom({
    Expression<int>? creatorUserId,
    Expression<int>? memoryModelId,
    Expression<int>? newDisplayOrder,
    Expression<int>? newReviewDisplayOrder,
    Expression<DateTime>? reviewInterval,
    Expression<DateTime>? startTime,
    Expression<String>? title,
    Expression<int>? willNewLearnCount,
    Expression<DateTime>? createdAt,
    Expression<int>? id,
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
      Value<int?>? memoryModelId,
      Value<NewDisplayOrder?>? newDisplayOrder,
      Value<NewReviewDisplayOrder?>? newReviewDisplayOrder,
      Value<DateTime?>? reviewInterval,
      Value<DateTime?>? startTime,
      Value<String?>? title,
      Value<int?>? willNewLearnCount,
      Value<DateTime>? createdAt,
      Value<int?>? id,
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
      map['memory_model_id'] = Variable<int>(memoryModelId.value);
    }
    if (newDisplayOrder.present) {
      final converter = $MemoryGroupsTable.$converter0n;
      map['new_display_order'] =
          Variable<int>(converter.toSql(newDisplayOrder.value));
    }
    if (newReviewDisplayOrder.present) {
      final converter = $MemoryGroupsTable.$converter1n;
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
      map['id'] = Variable<int>(id.value);
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
  late final GeneratedColumn<int> memoryModelId = GeneratedColumn<int>(
      'memory_model_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  final VerificationMeta _newDisplayOrderMeta =
      const VerificationMeta('newDisplayOrder');
  @override
  late final GeneratedColumnWithTypeConverter<NewDisplayOrder?, int>
      newDisplayOrder = GeneratedColumn<int>(
              'new_display_order', aliasedName, true,
              type: DriftSqlType.int, requiredDuringInsert: false)
          .withConverter<NewDisplayOrder?>($MemoryGroupsTable.$converter0n);
  final VerificationMeta _newReviewDisplayOrderMeta =
      const VerificationMeta('newReviewDisplayOrder');
  @override
  late final GeneratedColumnWithTypeConverter<NewReviewDisplayOrder?, int>
      newReviewDisplayOrder = GeneratedColumn<int>(
              'new_review_display_order', aliasedName, true,
              type: DriftSqlType.int, requiredDuringInsert: false)
          .withConverter<NewReviewDisplayOrder?>(
              $MemoryGroupsTable.$converter1n);
  final VerificationMeta _reviewIntervalMeta =
      const VerificationMeta('reviewInterval');
  @override
  late final GeneratedColumn<DateTime> reviewInterval =
      GeneratedColumn<DateTime>('review_interval', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  final VerificationMeta _startTimeMeta = const VerificationMeta('startTime');
  @override
  late final GeneratedColumn<DateTime> startTime = GeneratedColumn<DateTime>(
      'start_time', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  final VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  final VerificationMeta _willNewLearnCountMeta =
      const VerificationMeta('willNewLearnCount');
  @override
  late final GeneratedColumn<int> willNewLearnCount = GeneratedColumn<int>(
      'will_new_learn_count', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
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
    }
    if (data.containsKey('start_time')) {
      context.handle(_startTimeMeta,
          startTime.isAcceptableOrUnknown(data['start_time']!, _startTimeMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    }
    if (data.containsKey('will_new_learn_count')) {
      context.handle(
          _willNewLearnCountMeta,
          willNewLearnCount.isAcceptableOrUnknown(
              data['will_new_learn_count']!, _willNewLearnCountMeta));
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
  MemoryGroup map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MemoryGroup(
      creatorUserId: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}creator_user_id'])!,
      memoryModelId: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}memory_model_id']),
      newDisplayOrder: $MemoryGroupsTable.$converter0n.fromSql(attachedDatabase
          .options.types
          .read(DriftSqlType.int, data['${effectivePrefix}new_display_order'])),
      newReviewDisplayOrder: $MemoryGroupsTable.$converter1n.fromSql(
          attachedDatabase.options.types.read(DriftSqlType.int,
              data['${effectivePrefix}new_review_display_order'])),
      reviewInterval: attachedDatabase.options.types.read(
          DriftSqlType.dateTime, data['${effectivePrefix}review_interval']),
      startTime: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}start_time']),
      title: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}title']),
      willNewLearnCount: attachedDatabase.options.types.read(
          DriftSqlType.int, data['${effectivePrefix}will_new_learn_count']),
      createdAt: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      id: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id']),
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
  static TypeConverter<NewDisplayOrder?, int?> $converter0n =
      NullAwareTypeConverter.wrap($converter0);
  static TypeConverter<NewReviewDisplayOrder?, int?> $converter1n =
      NullAwareTypeConverter.wrap($converter1);
}

class RDocument2DocumentGroup extends DataClass
    implements Insertable<RDocument2DocumentGroup> {
  int creatorUserId;
  int? documentGroupId;
  int documentId;
  DateTime createdAt;
  int? id;
  DateTime updatedAt;
  RDocument2DocumentGroup(
      {required this.creatorUserId,
      this.documentGroupId,
      required this.documentId,
      required this.createdAt,
      this.id,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['creator_user_id'] = Variable<int>(creatorUserId);
    if (!nullToAbsent || documentGroupId != null) {
      map['document_group_id'] = Variable<int>(documentGroupId);
    }
    map['document_id'] = Variable<int>(documentId);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
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
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      updatedAt: Value(updatedAt),
    );
  }

  factory RDocument2DocumentGroup.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RDocument2DocumentGroup(
      creatorUserId: serializer.fromJson<int>(json['creatorUserId']),
      documentGroupId: serializer.fromJson<int?>(json['documentGroupId']),
      documentId: serializer.fromJson<int>(json['documentId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      id: serializer.fromJson<int?>(json['id']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'creatorUserId': serializer.toJson<int>(creatorUserId),
      'documentGroupId': serializer.toJson<int?>(documentGroupId),
      'documentId': serializer.toJson<int>(documentId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'id': serializer.toJson<int?>(id),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  RDocument2DocumentGroup copyWith(
          {int? creatorUserId,
          Value<int?> documentGroupId = const Value.absent(),
          int? documentId,
          DateTime? createdAt,
          Value<int?> id = const Value.absent(),
          DateTime? updatedAt}) =>
      RDocument2DocumentGroup(
        creatorUserId: creatorUserId ?? this.creatorUserId,
        documentGroupId: documentGroupId.present
            ? documentGroupId.value
            : this.documentGroupId,
        documentId: documentId ?? this.documentId,
        createdAt: createdAt ?? this.createdAt,
        id: id.present ? id.value : this.id,
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
  Value<int?> documentGroupId;
  Value<int> documentId;
  Value<DateTime> createdAt;
  Value<int?> id;
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
    required int documentId,
    required DateTime createdAt,
    this.id = const Value.absent(),
    required DateTime updatedAt,
  })  : creatorUserId = Value(creatorUserId),
        documentId = Value(documentId),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<RDocument2DocumentGroup> custom({
    Expression<int>? creatorUserId,
    Expression<int>? documentGroupId,
    Expression<int>? documentId,
    Expression<DateTime>? createdAt,
    Expression<int>? id,
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
      Value<int?>? documentGroupId,
      Value<int>? documentId,
      Value<DateTime>? createdAt,
      Value<int?>? id,
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
      map['document_group_id'] = Variable<int>(documentGroupId.value);
    }
    if (documentId.present) {
      map['document_id'] = Variable<int>(documentId.value);
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
  late final GeneratedColumn<int> documentGroupId = GeneratedColumn<int>(
      'document_group_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  final VerificationMeta _documentIdMeta = const VerificationMeta('documentId');
  @override
  late final GeneratedColumn<int> documentId = GeneratedColumn<int>(
      'document_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
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
      documentGroupId: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}document_group_id']),
      documentId: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}document_id'])!,
      createdAt: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      id: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id']),
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
  int fragmentGroupId;
  int fragmentId;
  DateTime createdAt;
  int? id;
  DateTime updatedAt;
  RFragment2FragmentGroup(
      {required this.creatorUserId,
      required this.fragmentGroupId,
      required this.fragmentId,
      required this.createdAt,
      this.id,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['creator_user_id'] = Variable<int>(creatorUserId);
    map['fragment_group_id'] = Variable<int>(fragmentGroupId);
    map['fragment_id'] = Variable<int>(fragmentId);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  RFragment2FragmentGroupsCompanion toCompanion(bool nullToAbsent) {
    return RFragment2FragmentGroupsCompanion(
      creatorUserId: Value(creatorUserId),
      fragmentGroupId: Value(fragmentGroupId),
      fragmentId: Value(fragmentId),
      createdAt: Value(createdAt),
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      updatedAt: Value(updatedAt),
    );
  }

  factory RFragment2FragmentGroup.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RFragment2FragmentGroup(
      creatorUserId: serializer.fromJson<int>(json['creatorUserId']),
      fragmentGroupId: serializer.fromJson<int>(json['fragmentGroupId']),
      fragmentId: serializer.fromJson<int>(json['fragmentId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      id: serializer.fromJson<int?>(json['id']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'creatorUserId': serializer.toJson<int>(creatorUserId),
      'fragmentGroupId': serializer.toJson<int>(fragmentGroupId),
      'fragmentId': serializer.toJson<int>(fragmentId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'id': serializer.toJson<int?>(id),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  RFragment2FragmentGroup copyWith(
          {int? creatorUserId,
          int? fragmentGroupId,
          int? fragmentId,
          DateTime? createdAt,
          Value<int?> id = const Value.absent(),
          DateTime? updatedAt}) =>
      RFragment2FragmentGroup(
        creatorUserId: creatorUserId ?? this.creatorUserId,
        fragmentGroupId: fragmentGroupId ?? this.fragmentGroupId,
        fragmentId: fragmentId ?? this.fragmentId,
        createdAt: createdAt ?? this.createdAt,
        id: id.present ? id.value : this.id,
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
  Value<int> fragmentGroupId;
  Value<int> fragmentId;
  Value<DateTime> createdAt;
  Value<int?> id;
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
    required int fragmentGroupId,
    required int fragmentId,
    required DateTime createdAt,
    this.id = const Value.absent(),
    required DateTime updatedAt,
  })  : creatorUserId = Value(creatorUserId),
        fragmentGroupId = Value(fragmentGroupId),
        fragmentId = Value(fragmentId),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<RFragment2FragmentGroup> custom({
    Expression<int>? creatorUserId,
    Expression<int>? fragmentGroupId,
    Expression<int>? fragmentId,
    Expression<DateTime>? createdAt,
    Expression<int>? id,
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
      Value<int>? fragmentGroupId,
      Value<int>? fragmentId,
      Value<DateTime>? createdAt,
      Value<int?>? id,
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
      map['fragment_group_id'] = Variable<int>(fragmentGroupId.value);
    }
    if (fragmentId.present) {
      map['fragment_id'] = Variable<int>(fragmentId.value);
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
  late final GeneratedColumn<int> fragmentGroupId = GeneratedColumn<int>(
      'fragment_group_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  final VerificationMeta _fragmentIdMeta = const VerificationMeta('fragmentId');
  @override
  late final GeneratedColumn<int> fragmentId = GeneratedColumn<int>(
      'fragment_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
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
    } else if (isInserting) {
      context.missing(_fragmentGroupIdMeta);
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
      fragmentGroupId: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}fragment_group_id'])!,
      fragmentId: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}fragment_id'])!,
      createdAt: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      id: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id']),
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
  int memoryModelGroupId;
  int memoryModelId;
  DateTime createdAt;
  int? id;
  DateTime updatedAt;
  RMemoryModel2MemoryModelGroup(
      {required this.creatorUserId,
      required this.memoryModelGroupId,
      required this.memoryModelId,
      required this.createdAt,
      this.id,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['creator_user_id'] = Variable<int>(creatorUserId);
    map['memory_model_group_id'] = Variable<int>(memoryModelGroupId);
    map['memory_model_id'] = Variable<int>(memoryModelId);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  RMemoryModel2MemoryModelGroupsCompanion toCompanion(bool nullToAbsent) {
    return RMemoryModel2MemoryModelGroupsCompanion(
      creatorUserId: Value(creatorUserId),
      memoryModelGroupId: Value(memoryModelGroupId),
      memoryModelId: Value(memoryModelId),
      createdAt: Value(createdAt),
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      updatedAt: Value(updatedAt),
    );
  }

  factory RMemoryModel2MemoryModelGroup.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RMemoryModel2MemoryModelGroup(
      creatorUserId: serializer.fromJson<int>(json['creatorUserId']),
      memoryModelGroupId: serializer.fromJson<int>(json['memoryModelGroupId']),
      memoryModelId: serializer.fromJson<int>(json['memoryModelId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      id: serializer.fromJson<int?>(json['id']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'creatorUserId': serializer.toJson<int>(creatorUserId),
      'memoryModelGroupId': serializer.toJson<int>(memoryModelGroupId),
      'memoryModelId': serializer.toJson<int>(memoryModelId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'id': serializer.toJson<int?>(id),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  RMemoryModel2MemoryModelGroup copyWith(
          {int? creatorUserId,
          int? memoryModelGroupId,
          int? memoryModelId,
          DateTime? createdAt,
          Value<int?> id = const Value.absent(),
          DateTime? updatedAt}) =>
      RMemoryModel2MemoryModelGroup(
        creatorUserId: creatorUserId ?? this.creatorUserId,
        memoryModelGroupId: memoryModelGroupId ?? this.memoryModelGroupId,
        memoryModelId: memoryModelId ?? this.memoryModelId,
        createdAt: createdAt ?? this.createdAt,
        id: id.present ? id.value : this.id,
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
  Value<int> memoryModelGroupId;
  Value<int> memoryModelId;
  Value<DateTime> createdAt;
  Value<int?> id;
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
    required int memoryModelGroupId,
    required int memoryModelId,
    required DateTime createdAt,
    this.id = const Value.absent(),
    required DateTime updatedAt,
  })  : creatorUserId = Value(creatorUserId),
        memoryModelGroupId = Value(memoryModelGroupId),
        memoryModelId = Value(memoryModelId),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<RMemoryModel2MemoryModelGroup> custom({
    Expression<int>? creatorUserId,
    Expression<int>? memoryModelGroupId,
    Expression<int>? memoryModelId,
    Expression<DateTime>? createdAt,
    Expression<int>? id,
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
      Value<int>? memoryModelGroupId,
      Value<int>? memoryModelId,
      Value<DateTime>? createdAt,
      Value<int?>? id,
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
      map['memory_model_group_id'] = Variable<int>(memoryModelGroupId.value);
    }
    if (memoryModelId.present) {
      map['memory_model_id'] = Variable<int>(memoryModelId.value);
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
  late final GeneratedColumn<int> memoryModelGroupId = GeneratedColumn<int>(
      'memory_model_group_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  final VerificationMeta _memoryModelIdMeta =
      const VerificationMeta('memoryModelId');
  @override
  late final GeneratedColumn<int> memoryModelId = GeneratedColumn<int>(
      'memory_model_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
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
    } else if (isInserting) {
      context.missing(_memoryModelGroupIdMeta);
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
          DriftSqlType.int, data['${effectivePrefix}memory_model_group_id'])!,
      memoryModelId: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}memory_model_id'])!,
      createdAt: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      id: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id']),
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
  int noteGroupId;
  int noteId;
  DateTime createdAt;
  int? id;
  DateTime updatedAt;
  RNote2NoteGroup(
      {required this.creatorUserId,
      required this.noteGroupId,
      required this.noteId,
      required this.createdAt,
      this.id,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['creator_user_id'] = Variable<int>(creatorUserId);
    map['note_group_id'] = Variable<int>(noteGroupId);
    map['note_id'] = Variable<int>(noteId);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  RNote2NoteGroupsCompanion toCompanion(bool nullToAbsent) {
    return RNote2NoteGroupsCompanion(
      creatorUserId: Value(creatorUserId),
      noteGroupId: Value(noteGroupId),
      noteId: Value(noteId),
      createdAt: Value(createdAt),
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      updatedAt: Value(updatedAt),
    );
  }

  factory RNote2NoteGroup.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RNote2NoteGroup(
      creatorUserId: serializer.fromJson<int>(json['creatorUserId']),
      noteGroupId: serializer.fromJson<int>(json['noteGroupId']),
      noteId: serializer.fromJson<int>(json['noteId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      id: serializer.fromJson<int?>(json['id']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'creatorUserId': serializer.toJson<int>(creatorUserId),
      'noteGroupId': serializer.toJson<int>(noteGroupId),
      'noteId': serializer.toJson<int>(noteId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'id': serializer.toJson<int?>(id),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  RNote2NoteGroup copyWith(
          {int? creatorUserId,
          int? noteGroupId,
          int? noteId,
          DateTime? createdAt,
          Value<int?> id = const Value.absent(),
          DateTime? updatedAt}) =>
      RNote2NoteGroup(
        creatorUserId: creatorUserId ?? this.creatorUserId,
        noteGroupId: noteGroupId ?? this.noteGroupId,
        noteId: noteId ?? this.noteId,
        createdAt: createdAt ?? this.createdAt,
        id: id.present ? id.value : this.id,
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
  Value<int> noteGroupId;
  Value<int> noteId;
  Value<DateTime> createdAt;
  Value<int?> id;
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
    required int noteGroupId,
    required int noteId,
    required DateTime createdAt,
    this.id = const Value.absent(),
    required DateTime updatedAt,
  })  : creatorUserId = Value(creatorUserId),
        noteGroupId = Value(noteGroupId),
        noteId = Value(noteId),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<RNote2NoteGroup> custom({
    Expression<int>? creatorUserId,
    Expression<int>? noteGroupId,
    Expression<int>? noteId,
    Expression<DateTime>? createdAt,
    Expression<int>? id,
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
      Value<int>? noteGroupId,
      Value<int>? noteId,
      Value<DateTime>? createdAt,
      Value<int?>? id,
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
      map['note_group_id'] = Variable<int>(noteGroupId.value);
    }
    if (noteId.present) {
      map['note_id'] = Variable<int>(noteId.value);
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
  late final GeneratedColumn<int> noteGroupId = GeneratedColumn<int>(
      'note_group_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  final VerificationMeta _noteIdMeta = const VerificationMeta('noteId');
  @override
  late final GeneratedColumn<int> noteId = GeneratedColumn<int>(
      'note_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
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
    } else if (isInserting) {
      context.missing(_noteGroupIdMeta);
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
          .read(DriftSqlType.int, data['${effectivePrefix}note_group_id'])!,
      noteId: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}note_id'])!,
      createdAt: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      id: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id']),
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
  String? content;
  int creatorUserId;
  DateTime createdAt;
  int? id;
  DateTime updatedAt;
  Document(
      {this.content,
      required this.creatorUserId,
      required this.createdAt,
      this.id,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || content != null) {
      map['content'] = Variable<String>(content);
    }
    map['creator_user_id'] = Variable<int>(creatorUserId);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  DocumentsCompanion toCompanion(bool nullToAbsent) {
    return DocumentsCompanion(
      content: content == null && nullToAbsent
          ? const Value.absent()
          : Value(content),
      creatorUserId: Value(creatorUserId),
      createdAt: Value(createdAt),
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      updatedAt: Value(updatedAt),
    );
  }

  factory Document.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Document(
      content: serializer.fromJson<String?>(json['content']),
      creatorUserId: serializer.fromJson<int>(json['creatorUserId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      id: serializer.fromJson<int?>(json['id']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'content': serializer.toJson<String?>(content),
      'creatorUserId': serializer.toJson<int>(creatorUserId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'id': serializer.toJson<int?>(id),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Document copyWith(
          {Value<String?> content = const Value.absent(),
          int? creatorUserId,
          DateTime? createdAt,
          Value<int?> id = const Value.absent(),
          DateTime? updatedAt}) =>
      Document(
        content: content.present ? content.value : this.content,
        creatorUserId: creatorUserId ?? this.creatorUserId,
        createdAt: createdAt ?? this.createdAt,
        id: id.present ? id.value : this.id,
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
  Value<String?> content;
  Value<int> creatorUserId;
  Value<DateTime> createdAt;
  Value<int?> id;
  Value<DateTime> updatedAt;
  DocumentsCompanion({
    this.content = const Value.absent(),
    this.creatorUserId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.id = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  DocumentsCompanion.insert({
    this.content = const Value.absent(),
    required int creatorUserId,
    required DateTime createdAt,
    this.id = const Value.absent(),
    required DateTime updatedAt,
  })  : creatorUserId = Value(creatorUserId),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<Document> custom({
    Expression<String>? content,
    Expression<int>? creatorUserId,
    Expression<DateTime>? createdAt,
    Expression<int>? id,
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
      {Value<String?>? content,
      Value<int>? creatorUserId,
      Value<DateTime>? createdAt,
      Value<int?>? id,
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
      map['id'] = Variable<int>(id.value);
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
      'content', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
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
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
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
          .read(DriftSqlType.string, data['${effectivePrefix}content']),
      creatorUserId: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}creator_user_id'])!,
      createdAt: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      id: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id']),
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
  String? content;
  int creatorUserId;
  int? fatherFragmentId;
  int? noteId;
  DateTime createdAt;
  int? id;
  DateTime updatedAt;
  Fragment(
      {this.content,
      required this.creatorUserId,
      this.fatherFragmentId,
      this.noteId,
      required this.createdAt,
      this.id,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || content != null) {
      map['content'] = Variable<String>(content);
    }
    map['creator_user_id'] = Variable<int>(creatorUserId);
    if (!nullToAbsent || fatherFragmentId != null) {
      map['father_fragment_id'] = Variable<int>(fatherFragmentId);
    }
    if (!nullToAbsent || noteId != null) {
      map['note_id'] = Variable<int>(noteId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  FragmentsCompanion toCompanion(bool nullToAbsent) {
    return FragmentsCompanion(
      content: content == null && nullToAbsent
          ? const Value.absent()
          : Value(content),
      creatorUserId: Value(creatorUserId),
      fatherFragmentId: fatherFragmentId == null && nullToAbsent
          ? const Value.absent()
          : Value(fatherFragmentId),
      noteId:
          noteId == null && nullToAbsent ? const Value.absent() : Value(noteId),
      createdAt: Value(createdAt),
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      updatedAt: Value(updatedAt),
    );
  }

  factory Fragment.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Fragment(
      content: serializer.fromJson<String?>(json['content']),
      creatorUserId: serializer.fromJson<int>(json['creatorUserId']),
      fatherFragmentId: serializer.fromJson<int?>(json['fatherFragmentId']),
      noteId: serializer.fromJson<int?>(json['noteId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      id: serializer.fromJson<int?>(json['id']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'content': serializer.toJson<String?>(content),
      'creatorUserId': serializer.toJson<int>(creatorUserId),
      'fatherFragmentId': serializer.toJson<int?>(fatherFragmentId),
      'noteId': serializer.toJson<int?>(noteId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'id': serializer.toJson<int?>(id),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Fragment copyWith(
          {Value<String?> content = const Value.absent(),
          int? creatorUserId,
          Value<int?> fatherFragmentId = const Value.absent(),
          Value<int?> noteId = const Value.absent(),
          DateTime? createdAt,
          Value<int?> id = const Value.absent(),
          DateTime? updatedAt}) =>
      Fragment(
        content: content.present ? content.value : this.content,
        creatorUserId: creatorUserId ?? this.creatorUserId,
        fatherFragmentId: fatherFragmentId.present
            ? fatherFragmentId.value
            : this.fatherFragmentId,
        noteId: noteId.present ? noteId.value : this.noteId,
        createdAt: createdAt ?? this.createdAt,
        id: id.present ? id.value : this.id,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  @override
  String toString() {
    return (StringBuffer('Fragment(')
          ..write('content: $content, ')
          ..write('creatorUserId: $creatorUserId, ')
          ..write('fatherFragmentId: $fatherFragmentId, ')
          ..write('noteId: $noteId, ')
          ..write('createdAt: $createdAt, ')
          ..write('id: $id, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(content, creatorUserId, fatherFragmentId,
      noteId, createdAt, id, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Fragment &&
          other.content == this.content &&
          other.creatorUserId == this.creatorUserId &&
          other.fatherFragmentId == this.fatherFragmentId &&
          other.noteId == this.noteId &&
          other.createdAt == this.createdAt &&
          other.id == this.id &&
          other.updatedAt == this.updatedAt);
}

class FragmentsCompanion extends UpdateCompanion<Fragment> {
  Value<String?> content;
  Value<int> creatorUserId;
  Value<int?> fatherFragmentId;
  Value<int?> noteId;
  Value<DateTime> createdAt;
  Value<int?> id;
  Value<DateTime> updatedAt;
  FragmentsCompanion({
    this.content = const Value.absent(),
    this.creatorUserId = const Value.absent(),
    this.fatherFragmentId = const Value.absent(),
    this.noteId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.id = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  FragmentsCompanion.insert({
    this.content = const Value.absent(),
    required int creatorUserId,
    this.fatherFragmentId = const Value.absent(),
    this.noteId = const Value.absent(),
    required DateTime createdAt,
    this.id = const Value.absent(),
    required DateTime updatedAt,
  })  : creatorUserId = Value(creatorUserId),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<Fragment> custom({
    Expression<String>? content,
    Expression<int>? creatorUserId,
    Expression<int>? fatherFragmentId,
    Expression<int>? noteId,
    Expression<DateTime>? createdAt,
    Expression<int>? id,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (content != null) 'content': content,
      if (creatorUserId != null) 'creator_user_id': creatorUserId,
      if (fatherFragmentId != null) 'father_fragment_id': fatherFragmentId,
      if (noteId != null) 'note_id': noteId,
      if (createdAt != null) 'created_at': createdAt,
      if (id != null) 'id': id,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  FragmentsCompanion copyWith(
      {Value<String?>? content,
      Value<int>? creatorUserId,
      Value<int?>? fatherFragmentId,
      Value<int?>? noteId,
      Value<DateTime>? createdAt,
      Value<int?>? id,
      Value<DateTime>? updatedAt}) {
    return FragmentsCompanion(
      content: content ?? this.content,
      creatorUserId: creatorUserId ?? this.creatorUserId,
      fatherFragmentId: fatherFragmentId ?? this.fatherFragmentId,
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
      map['father_fragment_id'] = Variable<int>(fatherFragmentId.value);
    }
    if (noteId.present) {
      map['note_id'] = Variable<int>(noteId.value);
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
    return (StringBuffer('FragmentsCompanion(')
          ..write('content: $content, ')
          ..write('creatorUserId: $creatorUserId, ')
          ..write('fatherFragmentId: $fatherFragmentId, ')
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
      'content', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  final VerificationMeta _creatorUserIdMeta =
      const VerificationMeta('creatorUserId');
  @override
  late final GeneratedColumn<int> creatorUserId = GeneratedColumn<int>(
      'creator_user_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  final VerificationMeta _fatherFragmentIdMeta =
      const VerificationMeta('fatherFragmentId');
  @override
  late final GeneratedColumn<int> fatherFragmentId = GeneratedColumn<int>(
      'father_fragment_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  final VerificationMeta _noteIdMeta = const VerificationMeta('noteId');
  @override
  late final GeneratedColumn<int> noteId = GeneratedColumn<int>(
      'note_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
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
          .read(DriftSqlType.string, data['${effectivePrefix}content']),
      creatorUserId: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}creator_user_id'])!,
      fatherFragmentId: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}father_fragment_id']),
      noteId: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}note_id']),
      createdAt: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      id: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id']),
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
  String? applicableFields;
  String? applicableGroups;
  String? buttonAlgorithm;
  int creatorUserId;
  String? familiarityAlgorithm;
  int? fatherFragmentId;
  String? nextTimeAlgorithm;
  String? stimulateAlgorithm;
  String? title;
  DateTime createdAt;
  int? id;
  DateTime updatedAt;
  MemoryModel(
      {this.applicableFields,
      this.applicableGroups,
      this.buttonAlgorithm,
      required this.creatorUserId,
      this.familiarityAlgorithm,
      this.fatherFragmentId,
      this.nextTimeAlgorithm,
      this.stimulateAlgorithm,
      this.title,
      required this.createdAt,
      this.id,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || applicableFields != null) {
      map['applicable_fields'] = Variable<String>(applicableFields);
    }
    if (!nullToAbsent || applicableGroups != null) {
      map['applicable_groups'] = Variable<String>(applicableGroups);
    }
    if (!nullToAbsent || buttonAlgorithm != null) {
      map['button_algorithm'] = Variable<String>(buttonAlgorithm);
    }
    map['creator_user_id'] = Variable<int>(creatorUserId);
    if (!nullToAbsent || familiarityAlgorithm != null) {
      map['familiarity_algorithm'] = Variable<String>(familiarityAlgorithm);
    }
    if (!nullToAbsent || fatherFragmentId != null) {
      map['father_fragment_id'] = Variable<int>(fatherFragmentId);
    }
    if (!nullToAbsent || nextTimeAlgorithm != null) {
      map['next_time_algorithm'] = Variable<String>(nextTimeAlgorithm);
    }
    if (!nullToAbsent || stimulateAlgorithm != null) {
      map['stimulate_algorithm'] = Variable<String>(stimulateAlgorithm);
    }
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  MemoryModelsCompanion toCompanion(bool nullToAbsent) {
    return MemoryModelsCompanion(
      applicableFields: applicableFields == null && nullToAbsent
          ? const Value.absent()
          : Value(applicableFields),
      applicableGroups: applicableGroups == null && nullToAbsent
          ? const Value.absent()
          : Value(applicableGroups),
      buttonAlgorithm: buttonAlgorithm == null && nullToAbsent
          ? const Value.absent()
          : Value(buttonAlgorithm),
      creatorUserId: Value(creatorUserId),
      familiarityAlgorithm: familiarityAlgorithm == null && nullToAbsent
          ? const Value.absent()
          : Value(familiarityAlgorithm),
      fatherFragmentId: fatherFragmentId == null && nullToAbsent
          ? const Value.absent()
          : Value(fatherFragmentId),
      nextTimeAlgorithm: nextTimeAlgorithm == null && nullToAbsent
          ? const Value.absent()
          : Value(nextTimeAlgorithm),
      stimulateAlgorithm: stimulateAlgorithm == null && nullToAbsent
          ? const Value.absent()
          : Value(stimulateAlgorithm),
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
      createdAt: Value(createdAt),
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      updatedAt: Value(updatedAt),
    );
  }

  factory MemoryModel.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MemoryModel(
      applicableFields: serializer.fromJson<String?>(json['applicableFields']),
      applicableGroups: serializer.fromJson<String?>(json['applicableGroups']),
      buttonAlgorithm: serializer.fromJson<String?>(json['buttonAlgorithm']),
      creatorUserId: serializer.fromJson<int>(json['creatorUserId']),
      familiarityAlgorithm:
          serializer.fromJson<String?>(json['familiarityAlgorithm']),
      fatherFragmentId: serializer.fromJson<int?>(json['fatherFragmentId']),
      nextTimeAlgorithm:
          serializer.fromJson<String?>(json['nextTimeAlgorithm']),
      stimulateAlgorithm:
          serializer.fromJson<String?>(json['stimulateAlgorithm']),
      title: serializer.fromJson<String?>(json['title']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      id: serializer.fromJson<int?>(json['id']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'applicableFields': serializer.toJson<String?>(applicableFields),
      'applicableGroups': serializer.toJson<String?>(applicableGroups),
      'buttonAlgorithm': serializer.toJson<String?>(buttonAlgorithm),
      'creatorUserId': serializer.toJson<int>(creatorUserId),
      'familiarityAlgorithm': serializer.toJson<String?>(familiarityAlgorithm),
      'fatherFragmentId': serializer.toJson<int?>(fatherFragmentId),
      'nextTimeAlgorithm': serializer.toJson<String?>(nextTimeAlgorithm),
      'stimulateAlgorithm': serializer.toJson<String?>(stimulateAlgorithm),
      'title': serializer.toJson<String?>(title),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'id': serializer.toJson<int?>(id),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  MemoryModel copyWith(
          {Value<String?> applicableFields = const Value.absent(),
          Value<String?> applicableGroups = const Value.absent(),
          Value<String?> buttonAlgorithm = const Value.absent(),
          int? creatorUserId,
          Value<String?> familiarityAlgorithm = const Value.absent(),
          Value<int?> fatherFragmentId = const Value.absent(),
          Value<String?> nextTimeAlgorithm = const Value.absent(),
          Value<String?> stimulateAlgorithm = const Value.absent(),
          Value<String?> title = const Value.absent(),
          DateTime? createdAt,
          Value<int?> id = const Value.absent(),
          DateTime? updatedAt}) =>
      MemoryModel(
        applicableFields: applicableFields.present
            ? applicableFields.value
            : this.applicableFields,
        applicableGroups: applicableGroups.present
            ? applicableGroups.value
            : this.applicableGroups,
        buttonAlgorithm: buttonAlgorithm.present
            ? buttonAlgorithm.value
            : this.buttonAlgorithm,
        creatorUserId: creatorUserId ?? this.creatorUserId,
        familiarityAlgorithm: familiarityAlgorithm.present
            ? familiarityAlgorithm.value
            : this.familiarityAlgorithm,
        fatherFragmentId: fatherFragmentId.present
            ? fatherFragmentId.value
            : this.fatherFragmentId,
        nextTimeAlgorithm: nextTimeAlgorithm.present
            ? nextTimeAlgorithm.value
            : this.nextTimeAlgorithm,
        stimulateAlgorithm: stimulateAlgorithm.present
            ? stimulateAlgorithm.value
            : this.stimulateAlgorithm,
        title: title.present ? title.value : this.title,
        createdAt: createdAt ?? this.createdAt,
        id: id.present ? id.value : this.id,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  @override
  String toString() {
    return (StringBuffer('MemoryModel(')
          ..write('applicableFields: $applicableFields, ')
          ..write('applicableGroups: $applicableGroups, ')
          ..write('buttonAlgorithm: $buttonAlgorithm, ')
          ..write('creatorUserId: $creatorUserId, ')
          ..write('familiarityAlgorithm: $familiarityAlgorithm, ')
          ..write('fatherFragmentId: $fatherFragmentId, ')
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
      applicableFields,
      applicableGroups,
      buttonAlgorithm,
      creatorUserId,
      familiarityAlgorithm,
      fatherFragmentId,
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
          other.applicableFields == this.applicableFields &&
          other.applicableGroups == this.applicableGroups &&
          other.buttonAlgorithm == this.buttonAlgorithm &&
          other.creatorUserId == this.creatorUserId &&
          other.familiarityAlgorithm == this.familiarityAlgorithm &&
          other.fatherFragmentId == this.fatherFragmentId &&
          other.nextTimeAlgorithm == this.nextTimeAlgorithm &&
          other.stimulateAlgorithm == this.stimulateAlgorithm &&
          other.title == this.title &&
          other.createdAt == this.createdAt &&
          other.id == this.id &&
          other.updatedAt == this.updatedAt);
}

class MemoryModelsCompanion extends UpdateCompanion<MemoryModel> {
  Value<String?> applicableFields;
  Value<String?> applicableGroups;
  Value<String?> buttonAlgorithm;
  Value<int> creatorUserId;
  Value<String?> familiarityAlgorithm;
  Value<int?> fatherFragmentId;
  Value<String?> nextTimeAlgorithm;
  Value<String?> stimulateAlgorithm;
  Value<String?> title;
  Value<DateTime> createdAt;
  Value<int?> id;
  Value<DateTime> updatedAt;
  MemoryModelsCompanion({
    this.applicableFields = const Value.absent(),
    this.applicableGroups = const Value.absent(),
    this.buttonAlgorithm = const Value.absent(),
    this.creatorUserId = const Value.absent(),
    this.familiarityAlgorithm = const Value.absent(),
    this.fatherFragmentId = const Value.absent(),
    this.nextTimeAlgorithm = const Value.absent(),
    this.stimulateAlgorithm = const Value.absent(),
    this.title = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.id = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  MemoryModelsCompanion.insert({
    this.applicableFields = const Value.absent(),
    this.applicableGroups = const Value.absent(),
    this.buttonAlgorithm = const Value.absent(),
    required int creatorUserId,
    this.familiarityAlgorithm = const Value.absent(),
    this.fatherFragmentId = const Value.absent(),
    this.nextTimeAlgorithm = const Value.absent(),
    this.stimulateAlgorithm = const Value.absent(),
    this.title = const Value.absent(),
    required DateTime createdAt,
    this.id = const Value.absent(),
    required DateTime updatedAt,
  })  : creatorUserId = Value(creatorUserId),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<MemoryModel> custom({
    Expression<String>? applicableFields,
    Expression<String>? applicableGroups,
    Expression<String>? buttonAlgorithm,
    Expression<int>? creatorUserId,
    Expression<String>? familiarityAlgorithm,
    Expression<int>? fatherFragmentId,
    Expression<String>? nextTimeAlgorithm,
    Expression<String>? stimulateAlgorithm,
    Expression<String>? title,
    Expression<DateTime>? createdAt,
    Expression<int>? id,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (applicableFields != null) 'applicable_fields': applicableFields,
      if (applicableGroups != null) 'applicable_groups': applicableGroups,
      if (buttonAlgorithm != null) 'button_algorithm': buttonAlgorithm,
      if (creatorUserId != null) 'creator_user_id': creatorUserId,
      if (familiarityAlgorithm != null)
        'familiarity_algorithm': familiarityAlgorithm,
      if (fatherFragmentId != null) 'father_fragment_id': fatherFragmentId,
      if (nextTimeAlgorithm != null) 'next_time_algorithm': nextTimeAlgorithm,
      if (stimulateAlgorithm != null) 'stimulate_algorithm': stimulateAlgorithm,
      if (title != null) 'title': title,
      if (createdAt != null) 'created_at': createdAt,
      if (id != null) 'id': id,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  MemoryModelsCompanion copyWith(
      {Value<String?>? applicableFields,
      Value<String?>? applicableGroups,
      Value<String?>? buttonAlgorithm,
      Value<int>? creatorUserId,
      Value<String?>? familiarityAlgorithm,
      Value<int?>? fatherFragmentId,
      Value<String?>? nextTimeAlgorithm,
      Value<String?>? stimulateAlgorithm,
      Value<String?>? title,
      Value<DateTime>? createdAt,
      Value<int?>? id,
      Value<DateTime>? updatedAt}) {
    return MemoryModelsCompanion(
      applicableFields: applicableFields ?? this.applicableFields,
      applicableGroups: applicableGroups ?? this.applicableGroups,
      buttonAlgorithm: buttonAlgorithm ?? this.buttonAlgorithm,
      creatorUserId: creatorUserId ?? this.creatorUserId,
      familiarityAlgorithm: familiarityAlgorithm ?? this.familiarityAlgorithm,
      fatherFragmentId: fatherFragmentId ?? this.fatherFragmentId,
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
    if (applicableFields.present) {
      map['applicable_fields'] = Variable<String>(applicableFields.value);
    }
    if (applicableGroups.present) {
      map['applicable_groups'] = Variable<String>(applicableGroups.value);
    }
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
    if (fatherFragmentId.present) {
      map['father_fragment_id'] = Variable<int>(fatherFragmentId.value);
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
      map['id'] = Variable<int>(id.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MemoryModelsCompanion(')
          ..write('applicableFields: $applicableFields, ')
          ..write('applicableGroups: $applicableGroups, ')
          ..write('buttonAlgorithm: $buttonAlgorithm, ')
          ..write('creatorUserId: $creatorUserId, ')
          ..write('familiarityAlgorithm: $familiarityAlgorithm, ')
          ..write('fatherFragmentId: $fatherFragmentId, ')
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
  final VerificationMeta _applicableFieldsMeta =
      const VerificationMeta('applicableFields');
  @override
  late final GeneratedColumn<String> applicableFields = GeneratedColumn<String>(
      'applicable_fields', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  final VerificationMeta _applicableGroupsMeta =
      const VerificationMeta('applicableGroups');
  @override
  late final GeneratedColumn<String> applicableGroups = GeneratedColumn<String>(
      'applicable_groups', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  final VerificationMeta _buttonAlgorithmMeta =
      const VerificationMeta('buttonAlgorithm');
  @override
  late final GeneratedColumn<String> buttonAlgorithm = GeneratedColumn<String>(
      'button_algorithm', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
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
      GeneratedColumn<String>('familiarity_algorithm', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  final VerificationMeta _fatherFragmentIdMeta =
      const VerificationMeta('fatherFragmentId');
  @override
  late final GeneratedColumn<int> fatherFragmentId = GeneratedColumn<int>(
      'father_fragment_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  final VerificationMeta _nextTimeAlgorithmMeta =
      const VerificationMeta('nextTimeAlgorithm');
  @override
  late final GeneratedColumn<String> nextTimeAlgorithm =
      GeneratedColumn<String>('next_time_algorithm', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  final VerificationMeta _stimulateAlgorithmMeta =
      const VerificationMeta('stimulateAlgorithm');
  @override
  late final GeneratedColumn<String> stimulateAlgorithm =
      GeneratedColumn<String>('stimulate_algorithm', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  final VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  final VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        applicableFields,
        applicableGroups,
        buttonAlgorithm,
        creatorUserId,
        familiarityAlgorithm,
        fatherFragmentId,
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
    if (data.containsKey('applicable_fields')) {
      context.handle(
          _applicableFieldsMeta,
          applicableFields.isAcceptableOrUnknown(
              data['applicable_fields']!, _applicableFieldsMeta));
    }
    if (data.containsKey('applicable_groups')) {
      context.handle(
          _applicableGroupsMeta,
          applicableGroups.isAcceptableOrUnknown(
              data['applicable_groups']!, _applicableGroupsMeta));
    }
    if (data.containsKey('button_algorithm')) {
      context.handle(
          _buttonAlgorithmMeta,
          buttonAlgorithm.isAcceptableOrUnknown(
              data['button_algorithm']!, _buttonAlgorithmMeta));
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
    }
    if (data.containsKey('father_fragment_id')) {
      context.handle(
          _fatherFragmentIdMeta,
          fatherFragmentId.isAcceptableOrUnknown(
              data['father_fragment_id']!, _fatherFragmentIdMeta));
    }
    if (data.containsKey('next_time_algorithm')) {
      context.handle(
          _nextTimeAlgorithmMeta,
          nextTimeAlgorithm.isAcceptableOrUnknown(
              data['next_time_algorithm']!, _nextTimeAlgorithmMeta));
    }
    if (data.containsKey('stimulate_algorithm')) {
      context.handle(
          _stimulateAlgorithmMeta,
          stimulateAlgorithm.isAcceptableOrUnknown(
              data['stimulate_algorithm']!, _stimulateAlgorithmMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
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
  MemoryModel map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MemoryModel(
      applicableFields: attachedDatabase.options.types.read(
          DriftSqlType.string, data['${effectivePrefix}applicable_fields']),
      applicableGroups: attachedDatabase.options.types.read(
          DriftSqlType.string, data['${effectivePrefix}applicable_groups']),
      buttonAlgorithm: attachedDatabase.options.types.read(
          DriftSqlType.string, data['${effectivePrefix}button_algorithm']),
      creatorUserId: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}creator_user_id'])!,
      familiarityAlgorithm: attachedDatabase.options.types.read(
          DriftSqlType.string, data['${effectivePrefix}familiarity_algorithm']),
      fatherFragmentId: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}father_fragment_id']),
      nextTimeAlgorithm: attachedDatabase.options.types.read(
          DriftSqlType.string, data['${effectivePrefix}next_time_algorithm']),
      stimulateAlgorithm: attachedDatabase.options.types.read(
          DriftSqlType.string, data['${effectivePrefix}stimulate_algorithm']),
      title: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}title']),
      createdAt: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      id: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id']),
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
  String? content;
  int creatorUserId;
  int? documentId;
  int? fatherNoteId;
  DateTime createdAt;
  int? id;
  DateTime updatedAt;
  Note(
      {this.content,
      required this.creatorUserId,
      this.documentId,
      this.fatherNoteId,
      required this.createdAt,
      this.id,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || content != null) {
      map['content'] = Variable<String>(content);
    }
    map['creator_user_id'] = Variable<int>(creatorUserId);
    if (!nullToAbsent || documentId != null) {
      map['document_id'] = Variable<int>(documentId);
    }
    if (!nullToAbsent || fatherNoteId != null) {
      map['father_note_id'] = Variable<int>(fatherNoteId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  NotesCompanion toCompanion(bool nullToAbsent) {
    return NotesCompanion(
      content: content == null && nullToAbsent
          ? const Value.absent()
          : Value(content),
      creatorUserId: Value(creatorUserId),
      documentId: documentId == null && nullToAbsent
          ? const Value.absent()
          : Value(documentId),
      fatherNoteId: fatherNoteId == null && nullToAbsent
          ? const Value.absent()
          : Value(fatherNoteId),
      createdAt: Value(createdAt),
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      updatedAt: Value(updatedAt),
    );
  }

  factory Note.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Note(
      content: serializer.fromJson<String?>(json['content']),
      creatorUserId: serializer.fromJson<int>(json['creatorUserId']),
      documentId: serializer.fromJson<int?>(json['documentId']),
      fatherNoteId: serializer.fromJson<int?>(json['fatherNoteId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      id: serializer.fromJson<int?>(json['id']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'content': serializer.toJson<String?>(content),
      'creatorUserId': serializer.toJson<int>(creatorUserId),
      'documentId': serializer.toJson<int?>(documentId),
      'fatherNoteId': serializer.toJson<int?>(fatherNoteId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'id': serializer.toJson<int?>(id),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Note copyWith(
          {Value<String?> content = const Value.absent(),
          int? creatorUserId,
          Value<int?> documentId = const Value.absent(),
          Value<int?> fatherNoteId = const Value.absent(),
          DateTime? createdAt,
          Value<int?> id = const Value.absent(),
          DateTime? updatedAt}) =>
      Note(
        content: content.present ? content.value : this.content,
        creatorUserId: creatorUserId ?? this.creatorUserId,
        documentId: documentId.present ? documentId.value : this.documentId,
        fatherNoteId:
            fatherNoteId.present ? fatherNoteId.value : this.fatherNoteId,
        createdAt: createdAt ?? this.createdAt,
        id: id.present ? id.value : this.id,
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
  Value<String?> content;
  Value<int> creatorUserId;
  Value<int?> documentId;
  Value<int?> fatherNoteId;
  Value<DateTime> createdAt;
  Value<int?> id;
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
    this.content = const Value.absent(),
    required int creatorUserId,
    this.documentId = const Value.absent(),
    this.fatherNoteId = const Value.absent(),
    required DateTime createdAt,
    this.id = const Value.absent(),
    required DateTime updatedAt,
  })  : creatorUserId = Value(creatorUserId),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<Note> custom({
    Expression<String>? content,
    Expression<int>? creatorUserId,
    Expression<int>? documentId,
    Expression<int>? fatherNoteId,
    Expression<DateTime>? createdAt,
    Expression<int>? id,
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
      {Value<String?>? content,
      Value<int>? creatorUserId,
      Value<int?>? documentId,
      Value<int?>? fatherNoteId,
      Value<DateTime>? createdAt,
      Value<int?>? id,
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
      map['document_id'] = Variable<int>(documentId.value);
    }
    if (fatherNoteId.present) {
      map['father_note_id'] = Variable<int>(fatherNoteId.value);
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
      'content', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  final VerificationMeta _creatorUserIdMeta =
      const VerificationMeta('creatorUserId');
  @override
  late final GeneratedColumn<int> creatorUserId = GeneratedColumn<int>(
      'creator_user_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  final VerificationMeta _documentIdMeta = const VerificationMeta('documentId');
  @override
  late final GeneratedColumn<int> documentId = GeneratedColumn<int>(
      'document_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  final VerificationMeta _fatherNoteIdMeta =
      const VerificationMeta('fatherNoteId');
  @override
  late final GeneratedColumn<int> fatherNoteId = GeneratedColumn<int>(
      'father_note_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
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
          .read(DriftSqlType.string, data['${effectivePrefix}content']),
      creatorUserId: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}creator_user_id'])!,
      documentId: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}document_id']),
      fatherNoteId: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}father_note_id']),
      createdAt: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      id: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id']),
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
  int? fatherDocumentGroupsId;
  String? title;
  DateTime createdAt;
  int? id;
  DateTime updatedAt;
  DocumentGroup(
      {required this.creatorUserId,
      this.fatherDocumentGroupsId,
      this.title,
      required this.createdAt,
      this.id,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['creator_user_id'] = Variable<int>(creatorUserId);
    if (!nullToAbsent || fatherDocumentGroupsId != null) {
      map['father_document_groups_id'] = Variable<int>(fatherDocumentGroupsId);
    }
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  DocumentGroupsCompanion toCompanion(bool nullToAbsent) {
    return DocumentGroupsCompanion(
      creatorUserId: Value(creatorUserId),
      fatherDocumentGroupsId: fatherDocumentGroupsId == null && nullToAbsent
          ? const Value.absent()
          : Value(fatherDocumentGroupsId),
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
      createdAt: Value(createdAt),
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      updatedAt: Value(updatedAt),
    );
  }

  factory DocumentGroup.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DocumentGroup(
      creatorUserId: serializer.fromJson<int>(json['creatorUserId']),
      fatherDocumentGroupsId:
          serializer.fromJson<int?>(json['fatherDocumentGroupsId']),
      title: serializer.fromJson<String?>(json['title']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      id: serializer.fromJson<int?>(json['id']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'creatorUserId': serializer.toJson<int>(creatorUserId),
      'fatherDocumentGroupsId': serializer.toJson<int?>(fatherDocumentGroupsId),
      'title': serializer.toJson<String?>(title),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'id': serializer.toJson<int?>(id),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  DocumentGroup copyWith(
          {int? creatorUserId,
          Value<int?> fatherDocumentGroupsId = const Value.absent(),
          Value<String?> title = const Value.absent(),
          DateTime? createdAt,
          Value<int?> id = const Value.absent(),
          DateTime? updatedAt}) =>
      DocumentGroup(
        creatorUserId: creatorUserId ?? this.creatorUserId,
        fatherDocumentGroupsId: fatherDocumentGroupsId.present
            ? fatherDocumentGroupsId.value
            : this.fatherDocumentGroupsId,
        title: title.present ? title.value : this.title,
        createdAt: createdAt ?? this.createdAt,
        id: id.present ? id.value : this.id,
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
  Value<int?> fatherDocumentGroupsId;
  Value<String?> title;
  Value<DateTime> createdAt;
  Value<int?> id;
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
    this.title = const Value.absent(),
    required DateTime createdAt,
    this.id = const Value.absent(),
    required DateTime updatedAt,
  })  : creatorUserId = Value(creatorUserId),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<DocumentGroup> custom({
    Expression<int>? creatorUserId,
    Expression<int>? fatherDocumentGroupsId,
    Expression<String>? title,
    Expression<DateTime>? createdAt,
    Expression<int>? id,
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
      Value<int?>? fatherDocumentGroupsId,
      Value<String?>? title,
      Value<DateTime>? createdAt,
      Value<int?>? id,
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
          Variable<int>(fatherDocumentGroupsId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
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
  late final GeneratedColumn<int> fatherDocumentGroupsId = GeneratedColumn<int>(
      'father_document_groups_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  final VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
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
  DocumentGroup map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DocumentGroup(
      creatorUserId: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}creator_user_id'])!,
      fatherDocumentGroupsId: attachedDatabase.options.types.read(
          DriftSqlType.int,
          data['${effectivePrefix}father_document_groups_id']),
      title: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}title']),
      createdAt: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      id: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id']),
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
  int? fatherFragmentGroupsId;
  String? title;
  DateTime createdAt;
  int? id;
  DateTime updatedAt;
  FragmentGroup(
      {required this.creatorUserId,
      this.fatherFragmentGroupsId,
      this.title,
      required this.createdAt,
      this.id,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['creator_user_id'] = Variable<int>(creatorUserId);
    if (!nullToAbsent || fatherFragmentGroupsId != null) {
      map['father_fragment_groups_id'] = Variable<int>(fatherFragmentGroupsId);
    }
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  FragmentGroupsCompanion toCompanion(bool nullToAbsent) {
    return FragmentGroupsCompanion(
      creatorUserId: Value(creatorUserId),
      fatherFragmentGroupsId: fatherFragmentGroupsId == null && nullToAbsent
          ? const Value.absent()
          : Value(fatherFragmentGroupsId),
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
      createdAt: Value(createdAt),
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      updatedAt: Value(updatedAt),
    );
  }

  factory FragmentGroup.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FragmentGroup(
      creatorUserId: serializer.fromJson<int>(json['creatorUserId']),
      fatherFragmentGroupsId:
          serializer.fromJson<int?>(json['fatherFragmentGroupsId']),
      title: serializer.fromJson<String?>(json['title']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      id: serializer.fromJson<int?>(json['id']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'creatorUserId': serializer.toJson<int>(creatorUserId),
      'fatherFragmentGroupsId': serializer.toJson<int?>(fatherFragmentGroupsId),
      'title': serializer.toJson<String?>(title),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'id': serializer.toJson<int?>(id),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  FragmentGroup copyWith(
          {int? creatorUserId,
          Value<int?> fatherFragmentGroupsId = const Value.absent(),
          Value<String?> title = const Value.absent(),
          DateTime? createdAt,
          Value<int?> id = const Value.absent(),
          DateTime? updatedAt}) =>
      FragmentGroup(
        creatorUserId: creatorUserId ?? this.creatorUserId,
        fatherFragmentGroupsId: fatherFragmentGroupsId.present
            ? fatherFragmentGroupsId.value
            : this.fatherFragmentGroupsId,
        title: title.present ? title.value : this.title,
        createdAt: createdAt ?? this.createdAt,
        id: id.present ? id.value : this.id,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  @override
  String toString() {
    return (StringBuffer('FragmentGroup(')
          ..write('creatorUserId: $creatorUserId, ')
          ..write('fatherFragmentGroupsId: $fatherFragmentGroupsId, ')
          ..write('title: $title, ')
          ..write('createdAt: $createdAt, ')
          ..write('id: $id, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      creatorUserId, fatherFragmentGroupsId, title, createdAt, id, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FragmentGroup &&
          other.creatorUserId == this.creatorUserId &&
          other.fatherFragmentGroupsId == this.fatherFragmentGroupsId &&
          other.title == this.title &&
          other.createdAt == this.createdAt &&
          other.id == this.id &&
          other.updatedAt == this.updatedAt);
}

class FragmentGroupsCompanion extends UpdateCompanion<FragmentGroup> {
  Value<int> creatorUserId;
  Value<int?> fatherFragmentGroupsId;
  Value<String?> title;
  Value<DateTime> createdAt;
  Value<int?> id;
  Value<DateTime> updatedAt;
  FragmentGroupsCompanion({
    this.creatorUserId = const Value.absent(),
    this.fatherFragmentGroupsId = const Value.absent(),
    this.title = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.id = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  FragmentGroupsCompanion.insert({
    required int creatorUserId,
    this.fatherFragmentGroupsId = const Value.absent(),
    this.title = const Value.absent(),
    required DateTime createdAt,
    this.id = const Value.absent(),
    required DateTime updatedAt,
  })  : creatorUserId = Value(creatorUserId),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<FragmentGroup> custom({
    Expression<int>? creatorUserId,
    Expression<int>? fatherFragmentGroupsId,
    Expression<String>? title,
    Expression<DateTime>? createdAt,
    Expression<int>? id,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (creatorUserId != null) 'creator_user_id': creatorUserId,
      if (fatherFragmentGroupsId != null)
        'father_fragment_groups_id': fatherFragmentGroupsId,
      if (title != null) 'title': title,
      if (createdAt != null) 'created_at': createdAt,
      if (id != null) 'id': id,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  FragmentGroupsCompanion copyWith(
      {Value<int>? creatorUserId,
      Value<int?>? fatherFragmentGroupsId,
      Value<String?>? title,
      Value<DateTime>? createdAt,
      Value<int?>? id,
      Value<DateTime>? updatedAt}) {
    return FragmentGroupsCompanion(
      creatorUserId: creatorUserId ?? this.creatorUserId,
      fatherFragmentGroupsId:
          fatherFragmentGroupsId ?? this.fatherFragmentGroupsId,
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
          Variable<int>(fatherFragmentGroupsId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
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
    return (StringBuffer('FragmentGroupsCompanion(')
          ..write('creatorUserId: $creatorUserId, ')
          ..write('fatherFragmentGroupsId: $fatherFragmentGroupsId, ')
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
  late final GeneratedColumn<int> fatherFragmentGroupsId = GeneratedColumn<int>(
      'father_fragment_groups_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  final VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  final VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [creatorUserId, fatherFragmentGroupsId, title, createdAt, id, updatedAt];
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
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
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
  FragmentGroup map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FragmentGroup(
      creatorUserId: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}creator_user_id'])!,
      fatherFragmentGroupsId: attachedDatabase.options.types.read(
          DriftSqlType.int,
          data['${effectivePrefix}father_fragment_groups_id']),
      title: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}title']),
      createdAt: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      id: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id']),
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
  int? fatherMemoryModelGroupsId;
  String? title;
  DateTime createdAt;
  int? id;
  DateTime updatedAt;
  MemoryModelGroup(
      {required this.creatorUserId,
      this.fatherMemoryModelGroupsId,
      this.title,
      required this.createdAt,
      this.id,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['creator_user_id'] = Variable<int>(creatorUserId);
    if (!nullToAbsent || fatherMemoryModelGroupsId != null) {
      map['father_memory_model_groups_id'] =
          Variable<int>(fatherMemoryModelGroupsId);
    }
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
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
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
      createdAt: Value(createdAt),
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      updatedAt: Value(updatedAt),
    );
  }

  factory MemoryModelGroup.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MemoryModelGroup(
      creatorUserId: serializer.fromJson<int>(json['creatorUserId']),
      fatherMemoryModelGroupsId:
          serializer.fromJson<int?>(json['fatherMemoryModelGroupsId']),
      title: serializer.fromJson<String?>(json['title']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      id: serializer.fromJson<int?>(json['id']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'creatorUserId': serializer.toJson<int>(creatorUserId),
      'fatherMemoryModelGroupsId':
          serializer.toJson<int?>(fatherMemoryModelGroupsId),
      'title': serializer.toJson<String?>(title),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'id': serializer.toJson<int?>(id),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  MemoryModelGroup copyWith(
          {int? creatorUserId,
          Value<int?> fatherMemoryModelGroupsId = const Value.absent(),
          Value<String?> title = const Value.absent(),
          DateTime? createdAt,
          Value<int?> id = const Value.absent(),
          DateTime? updatedAt}) =>
      MemoryModelGroup(
        creatorUserId: creatorUserId ?? this.creatorUserId,
        fatherMemoryModelGroupsId: fatherMemoryModelGroupsId.present
            ? fatherMemoryModelGroupsId.value
            : this.fatherMemoryModelGroupsId,
        title: title.present ? title.value : this.title,
        createdAt: createdAt ?? this.createdAt,
        id: id.present ? id.value : this.id,
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
  Value<int?> fatherMemoryModelGroupsId;
  Value<String?> title;
  Value<DateTime> createdAt;
  Value<int?> id;
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
    this.title = const Value.absent(),
    required DateTime createdAt,
    this.id = const Value.absent(),
    required DateTime updatedAt,
  })  : creatorUserId = Value(creatorUserId),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<MemoryModelGroup> custom({
    Expression<int>? creatorUserId,
    Expression<int>? fatherMemoryModelGroupsId,
    Expression<String>? title,
    Expression<DateTime>? createdAt,
    Expression<int>? id,
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
      Value<int?>? fatherMemoryModelGroupsId,
      Value<String?>? title,
      Value<DateTime>? createdAt,
      Value<int?>? id,
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
          Variable<int>(fatherMemoryModelGroupsId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
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
  late final GeneratedColumn<int> fatherMemoryModelGroupsId =
      GeneratedColumn<int>('father_memory_model_groups_id', aliasedName, true,
          type: DriftSqlType.int, requiredDuringInsert: false);
  final VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
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
  MemoryModelGroup map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MemoryModelGroup(
      creatorUserId: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}creator_user_id'])!,
      fatherMemoryModelGroupsId: attachedDatabase.options.types.read(
          DriftSqlType.int,
          data['${effectivePrefix}father_memory_model_groups_id']),
      title: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}title']),
      createdAt: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      id: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id']),
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
  int? fatherNoteGroupsId;
  String? title;
  DateTime createdAt;
  int? id;
  DateTime updatedAt;
  NoteGroup(
      {required this.creatorUserId,
      this.fatherNoteGroupsId,
      this.title,
      required this.createdAt,
      this.id,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['creator_user_id'] = Variable<int>(creatorUserId);
    if (!nullToAbsent || fatherNoteGroupsId != null) {
      map['father_note_groups_id'] = Variable<int>(fatherNoteGroupsId);
    }
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  NoteGroupsCompanion toCompanion(bool nullToAbsent) {
    return NoteGroupsCompanion(
      creatorUserId: Value(creatorUserId),
      fatherNoteGroupsId: fatherNoteGroupsId == null && nullToAbsent
          ? const Value.absent()
          : Value(fatherNoteGroupsId),
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
      createdAt: Value(createdAt),
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      updatedAt: Value(updatedAt),
    );
  }

  factory NoteGroup.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NoteGroup(
      creatorUserId: serializer.fromJson<int>(json['creatorUserId']),
      fatherNoteGroupsId: serializer.fromJson<int?>(json['fatherNoteGroupsId']),
      title: serializer.fromJson<String?>(json['title']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      id: serializer.fromJson<int?>(json['id']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'creatorUserId': serializer.toJson<int>(creatorUserId),
      'fatherNoteGroupsId': serializer.toJson<int?>(fatherNoteGroupsId),
      'title': serializer.toJson<String?>(title),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'id': serializer.toJson<int?>(id),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  NoteGroup copyWith(
          {int? creatorUserId,
          Value<int?> fatherNoteGroupsId = const Value.absent(),
          Value<String?> title = const Value.absent(),
          DateTime? createdAt,
          Value<int?> id = const Value.absent(),
          DateTime? updatedAt}) =>
      NoteGroup(
        creatorUserId: creatorUserId ?? this.creatorUserId,
        fatherNoteGroupsId: fatherNoteGroupsId.present
            ? fatherNoteGroupsId.value
            : this.fatherNoteGroupsId,
        title: title.present ? title.value : this.title,
        createdAt: createdAt ?? this.createdAt,
        id: id.present ? id.value : this.id,
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
  Value<int?> fatherNoteGroupsId;
  Value<String?> title;
  Value<DateTime> createdAt;
  Value<int?> id;
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
    this.title = const Value.absent(),
    required DateTime createdAt,
    this.id = const Value.absent(),
    required DateTime updatedAt,
  })  : creatorUserId = Value(creatorUserId),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<NoteGroup> custom({
    Expression<int>? creatorUserId,
    Expression<int>? fatherNoteGroupsId,
    Expression<String>? title,
    Expression<DateTime>? createdAt,
    Expression<int>? id,
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
      Value<int?>? fatherNoteGroupsId,
      Value<String?>? title,
      Value<DateTime>? createdAt,
      Value<int?>? id,
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
      map['father_note_groups_id'] = Variable<int>(fatherNoteGroupsId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
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
  late final GeneratedColumn<int> fatherNoteGroupsId = GeneratedColumn<int>(
      'father_note_groups_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  final VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
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
  NoteGroup map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NoteGroup(
      creatorUserId: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}creator_user_id'])!,
      fatherNoteGroupsId: attachedDatabase.options.types.read(
          DriftSqlType.int, data['${effectivePrefix}father_note_groups_id']),
      title: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}title']),
      createdAt: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      id: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id']),
      updatedAt: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $NoteGroupsTable createAlias(String alias) {
    return $NoteGroupsTable(attachedDatabase, alias);
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
    required DateTime createdAt,
    required DateTime updatedAt,
    required String token,
    required bool hasDownloadedInitData,
  })  : createdAt = Value(createdAt),
        updatedAt = Value(updatedAt),
        token = Value(token),
        hasDownloadedInitData = Value(hasDownloadedInitData);
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
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  final VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  final VerificationMeta _tokenMeta = const VerificationMeta('token');
  @override
  late final GeneratedColumn<String> token = GeneratedColumn<String>(
      'token', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _hasDownloadedInitDataMeta =
      const VerificationMeta('hasDownloadedInitData');
  @override
  late final GeneratedColumn<bool> hasDownloadedInitData =
      GeneratedColumn<bool>('has_downloaded_init_data', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: true,
          defaultConstraints: 'CHECK (has_downloaded_init_data IN (0, 1))');
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
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
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
    } else if (isInserting) {
      context.missing(_hasDownloadedInitDataMeta);
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
    required DateTime createdAt,
    required DateTime updatedAt,
    required String syncTableName,
    required String rowId,
    this.syncCurdType = const Value.absent(),
    required int tag,
  })  : createdAt = Value(createdAt),
        updatedAt = Value(updatedAt),
        syncTableName = Value(syncTableName),
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
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  final VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
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
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
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
  late final $FragmentMemoryInfosTable fragmentMemoryInfos =
      $FragmentMemoryInfosTable(this);
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
  late final $AppInfosTable appInfos = $AppInfosTable(this);
  late final $SyncsTable syncs = $SyncsTable(this);
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
        noteGroups,
        appInfos,
        syncs
      ];
}

// **************************************************************************
// DaoGenerator
// **************************************************************************

mixin _$GeneralQueryDAOMixin on DatabaseAccessor<DriftDb> {}
mixin _$InsertDAOMixin on DatabaseAccessor<DriftDb> {}
mixin _$UpdateDAOMixin on DatabaseAccessor<DriftDb> {
  $UsersTable get users => attachedDatabase.users;
  $FragmentMemoryInfosTable get fragmentMemoryInfos =>
      attachedDatabase.fragmentMemoryInfos;
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
mixin _$DeleteDAOMixin on DatabaseAccessor<DriftDb> {}
