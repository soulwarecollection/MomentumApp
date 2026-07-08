// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $PlansTable extends Plans with TableInfo<$PlansTable, PlanRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlansTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _currentDayIndexMeta = const VerificationMeta(
    'currentDayIndex',
  );
  @override
  late final GeneratedColumn<int> currentDayIndex = GeneratedColumn<int>(
    'current_day_index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _remoteIdMeta = const VerificationMeta(
    'remoteId',
  );
  @override
  late final GeneratedColumn<String> remoteId = GeneratedColumn<String>(
    'remote_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    isActive,
    currentDayIndex,
    sortOrder,
    createdAt,
    updatedAt,
    deletedAt,
    remoteId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'plans';
  @override
  VerificationContext validateIntegrity(
    Insertable<PlanRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('current_day_index')) {
      context.handle(
        _currentDayIndexMeta,
        currentDayIndex.isAcceptableOrUnknown(
          data['current_day_index']!,
          _currentDayIndexMeta,
        ),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('remote_id')) {
      context.handle(
        _remoteIdMeta,
        remoteId.isAcceptableOrUnknown(data['remote_id']!, _remoteIdMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PlanRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PlanRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      currentDayIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}current_day_index'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      remoteId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}remote_id'],
      ),
    );
  }

  @override
  $PlansTable createAlias(String alias) {
    return $PlansTable(attachedDatabase, alias);
  }
}

class PlanRow extends DataClass implements Insertable<PlanRow> {
  final int id;
  final String name;
  final bool isActive;
  final int currentDayIndex;
  final int sortOrder;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String? remoteId;
  const PlanRow({
    required this.id,
    required this.name,
    required this.isActive,
    required this.currentDayIndex,
    required this.sortOrder,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.remoteId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['is_active'] = Variable<bool>(isActive);
    map['current_day_index'] = Variable<int>(currentDayIndex);
    map['sort_order'] = Variable<int>(sortOrder);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    if (!nullToAbsent || remoteId != null) {
      map['remote_id'] = Variable<String>(remoteId);
    }
    return map;
  }

  PlansCompanion toCompanion(bool nullToAbsent) {
    return PlansCompanion(
      id: Value(id),
      name: Value(name),
      isActive: Value(isActive),
      currentDayIndex: Value(currentDayIndex),
      sortOrder: Value(sortOrder),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      remoteId: remoteId == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteId),
    );
  }

  factory PlanRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PlanRow(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      currentDayIndex: serializer.fromJson<int>(json['currentDayIndex']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      remoteId: serializer.fromJson<String?>(json['remoteId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'isActive': serializer.toJson<bool>(isActive),
      'currentDayIndex': serializer.toJson<int>(currentDayIndex),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'remoteId': serializer.toJson<String?>(remoteId),
    };
  }

  PlanRow copyWith({
    int? id,
    String? name,
    bool? isActive,
    int? currentDayIndex,
    int? sortOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    Value<String?> remoteId = const Value.absent(),
  }) => PlanRow(
    id: id ?? this.id,
    name: name ?? this.name,
    isActive: isActive ?? this.isActive,
    currentDayIndex: currentDayIndex ?? this.currentDayIndex,
    sortOrder: sortOrder ?? this.sortOrder,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    remoteId: remoteId.present ? remoteId.value : this.remoteId,
  );
  PlanRow copyWithCompanion(PlansCompanion data) {
    return PlanRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      currentDayIndex: data.currentDayIndex.present
          ? data.currentDayIndex.value
          : this.currentDayIndex,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      remoteId: data.remoteId.present ? data.remoteId.value : this.remoteId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PlanRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('isActive: $isActive, ')
          ..write('currentDayIndex: $currentDayIndex, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('remoteId: $remoteId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    isActive,
    currentDayIndex,
    sortOrder,
    createdAt,
    updatedAt,
    deletedAt,
    remoteId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PlanRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.isActive == this.isActive &&
          other.currentDayIndex == this.currentDayIndex &&
          other.sortOrder == this.sortOrder &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.remoteId == this.remoteId);
}

class PlansCompanion extends UpdateCompanion<PlanRow> {
  final Value<int> id;
  final Value<String> name;
  final Value<bool> isActive;
  final Value<int> currentDayIndex;
  final Value<int> sortOrder;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String?> remoteId;
  const PlansCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.isActive = const Value.absent(),
    this.currentDayIndex = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.remoteId = const Value.absent(),
  });
  PlansCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.isActive = const Value.absent(),
    this.currentDayIndex = const Value.absent(),
    this.sortOrder = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.deletedAt = const Value.absent(),
    this.remoteId = const Value.absent(),
  }) : name = Value(name),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<PlanRow> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<bool>? isActive,
    Expression<int>? currentDayIndex,
    Expression<int>? sortOrder,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? remoteId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (isActive != null) 'is_active': isActive,
      if (currentDayIndex != null) 'current_day_index': currentDayIndex,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (remoteId != null) 'remote_id': remoteId,
    });
  }

  PlansCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<bool>? isActive,
    Value<int>? currentDayIndex,
    Value<int>? sortOrder,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String?>? remoteId,
  }) {
    return PlansCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      isActive: isActive ?? this.isActive,
      currentDayIndex: currentDayIndex ?? this.currentDayIndex,
      sortOrder: sortOrder ?? this.sortOrder,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      remoteId: remoteId ?? this.remoteId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (currentDayIndex.present) {
      map['current_day_index'] = Variable<int>(currentDayIndex.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (remoteId.present) {
      map['remote_id'] = Variable<String>(remoteId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlansCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('isActive: $isActive, ')
          ..write('currentDayIndex: $currentDayIndex, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('remoteId: $remoteId')
          ..write(')'))
        .toString();
  }
}

class $PlanDaysTable extends PlanDays
    with TableInfo<$PlanDaysTable, PlanDayRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlanDaysTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _planIdMeta = const VerificationMeta('planId');
  @override
  late final GeneratedColumn<int> planId = GeneratedColumn<int>(
    'plan_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES plans (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _orderIndexMeta = const VerificationMeta(
    'orderIndex',
  );
  @override
  late final GeneratedColumn<int> orderIndex = GeneratedColumn<int>(
    'order_index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _focusMeta = const VerificationMeta('focus');
  @override
  late final GeneratedColumn<String> focus = GeneratedColumn<String>(
    'focus',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isRestMeta = const VerificationMeta('isRest');
  @override
  late final GeneratedColumn<bool> isRest = GeneratedColumn<bool>(
    'is_rest',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_rest" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _remoteIdMeta = const VerificationMeta(
    'remoteId',
  );
  @override
  late final GeneratedColumn<String> remoteId = GeneratedColumn<String>(
    'remote_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    planId,
    orderIndex,
    focus,
    isRest,
    updatedAt,
    remoteId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'plan_days';
  @override
  VerificationContext validateIntegrity(
    Insertable<PlanDayRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('plan_id')) {
      context.handle(
        _planIdMeta,
        planId.isAcceptableOrUnknown(data['plan_id']!, _planIdMeta),
      );
    } else if (isInserting) {
      context.missing(_planIdMeta);
    }
    if (data.containsKey('order_index')) {
      context.handle(
        _orderIndexMeta,
        orderIndex.isAcceptableOrUnknown(data['order_index']!, _orderIndexMeta),
      );
    } else if (isInserting) {
      context.missing(_orderIndexMeta);
    }
    if (data.containsKey('focus')) {
      context.handle(
        _focusMeta,
        focus.isAcceptableOrUnknown(data['focus']!, _focusMeta),
      );
    }
    if (data.containsKey('is_rest')) {
      context.handle(
        _isRestMeta,
        isRest.isAcceptableOrUnknown(data['is_rest']!, _isRestMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('remote_id')) {
      context.handle(
        _remoteIdMeta,
        remoteId.isAcceptableOrUnknown(data['remote_id']!, _remoteIdMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PlanDayRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PlanDayRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      planId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}plan_id'],
      )!,
      orderIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}order_index'],
      )!,
      focus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}focus'],
      ),
      isRest: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_rest'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      ),
      remoteId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}remote_id'],
      ),
    );
  }

  @override
  $PlanDaysTable createAlias(String alias) {
    return $PlanDaysTable(attachedDatabase, alias);
  }
}

class PlanDayRow extends DataClass implements Insertable<PlanDayRow> {
  final int id;
  final int planId;
  final int orderIndex;
  final String? focus;
  final bool isRest;
  final DateTime? updatedAt;
  final String? remoteId;
  const PlanDayRow({
    required this.id,
    required this.planId,
    required this.orderIndex,
    this.focus,
    required this.isRest,
    this.updatedAt,
    this.remoteId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['plan_id'] = Variable<int>(planId);
    map['order_index'] = Variable<int>(orderIndex);
    if (!nullToAbsent || focus != null) {
      map['focus'] = Variable<String>(focus);
    }
    map['is_rest'] = Variable<bool>(isRest);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    if (!nullToAbsent || remoteId != null) {
      map['remote_id'] = Variable<String>(remoteId);
    }
    return map;
  }

  PlanDaysCompanion toCompanion(bool nullToAbsent) {
    return PlanDaysCompanion(
      id: Value(id),
      planId: Value(planId),
      orderIndex: Value(orderIndex),
      focus: focus == null && nullToAbsent
          ? const Value.absent()
          : Value(focus),
      isRest: Value(isRest),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
      remoteId: remoteId == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteId),
    );
  }

  factory PlanDayRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PlanDayRow(
      id: serializer.fromJson<int>(json['id']),
      planId: serializer.fromJson<int>(json['planId']),
      orderIndex: serializer.fromJson<int>(json['orderIndex']),
      focus: serializer.fromJson<String?>(json['focus']),
      isRest: serializer.fromJson<bool>(json['isRest']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
      remoteId: serializer.fromJson<String?>(json['remoteId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'planId': serializer.toJson<int>(planId),
      'orderIndex': serializer.toJson<int>(orderIndex),
      'focus': serializer.toJson<String?>(focus),
      'isRest': serializer.toJson<bool>(isRest),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
      'remoteId': serializer.toJson<String?>(remoteId),
    };
  }

  PlanDayRow copyWith({
    int? id,
    int? planId,
    int? orderIndex,
    Value<String?> focus = const Value.absent(),
    bool? isRest,
    Value<DateTime?> updatedAt = const Value.absent(),
    Value<String?> remoteId = const Value.absent(),
  }) => PlanDayRow(
    id: id ?? this.id,
    planId: planId ?? this.planId,
    orderIndex: orderIndex ?? this.orderIndex,
    focus: focus.present ? focus.value : this.focus,
    isRest: isRest ?? this.isRest,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
    remoteId: remoteId.present ? remoteId.value : this.remoteId,
  );
  PlanDayRow copyWithCompanion(PlanDaysCompanion data) {
    return PlanDayRow(
      id: data.id.present ? data.id.value : this.id,
      planId: data.planId.present ? data.planId.value : this.planId,
      orderIndex: data.orderIndex.present
          ? data.orderIndex.value
          : this.orderIndex,
      focus: data.focus.present ? data.focus.value : this.focus,
      isRest: data.isRest.present ? data.isRest.value : this.isRest,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      remoteId: data.remoteId.present ? data.remoteId.value : this.remoteId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PlanDayRow(')
          ..write('id: $id, ')
          ..write('planId: $planId, ')
          ..write('orderIndex: $orderIndex, ')
          ..write('focus: $focus, ')
          ..write('isRest: $isRest, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('remoteId: $remoteId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, planId, orderIndex, focus, isRest, updatedAt, remoteId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PlanDayRow &&
          other.id == this.id &&
          other.planId == this.planId &&
          other.orderIndex == this.orderIndex &&
          other.focus == this.focus &&
          other.isRest == this.isRest &&
          other.updatedAt == this.updatedAt &&
          other.remoteId == this.remoteId);
}

class PlanDaysCompanion extends UpdateCompanion<PlanDayRow> {
  final Value<int> id;
  final Value<int> planId;
  final Value<int> orderIndex;
  final Value<String?> focus;
  final Value<bool> isRest;
  final Value<DateTime?> updatedAt;
  final Value<String?> remoteId;
  const PlanDaysCompanion({
    this.id = const Value.absent(),
    this.planId = const Value.absent(),
    this.orderIndex = const Value.absent(),
    this.focus = const Value.absent(),
    this.isRest = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.remoteId = const Value.absent(),
  });
  PlanDaysCompanion.insert({
    this.id = const Value.absent(),
    required int planId,
    required int orderIndex,
    this.focus = const Value.absent(),
    this.isRest = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.remoteId = const Value.absent(),
  }) : planId = Value(planId),
       orderIndex = Value(orderIndex);
  static Insertable<PlanDayRow> custom({
    Expression<int>? id,
    Expression<int>? planId,
    Expression<int>? orderIndex,
    Expression<String>? focus,
    Expression<bool>? isRest,
    Expression<DateTime>? updatedAt,
    Expression<String>? remoteId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (planId != null) 'plan_id': planId,
      if (orderIndex != null) 'order_index': orderIndex,
      if (focus != null) 'focus': focus,
      if (isRest != null) 'is_rest': isRest,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (remoteId != null) 'remote_id': remoteId,
    });
  }

  PlanDaysCompanion copyWith({
    Value<int>? id,
    Value<int>? planId,
    Value<int>? orderIndex,
    Value<String?>? focus,
    Value<bool>? isRest,
    Value<DateTime?>? updatedAt,
    Value<String?>? remoteId,
  }) {
    return PlanDaysCompanion(
      id: id ?? this.id,
      planId: planId ?? this.planId,
      orderIndex: orderIndex ?? this.orderIndex,
      focus: focus ?? this.focus,
      isRest: isRest ?? this.isRest,
      updatedAt: updatedAt ?? this.updatedAt,
      remoteId: remoteId ?? this.remoteId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (planId.present) {
      map['plan_id'] = Variable<int>(planId.value);
    }
    if (orderIndex.present) {
      map['order_index'] = Variable<int>(orderIndex.value);
    }
    if (focus.present) {
      map['focus'] = Variable<String>(focus.value);
    }
    if (isRest.present) {
      map['is_rest'] = Variable<bool>(isRest.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (remoteId.present) {
      map['remote_id'] = Variable<String>(remoteId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlanDaysCompanion(')
          ..write('id: $id, ')
          ..write('planId: $planId, ')
          ..write('orderIndex: $orderIndex, ')
          ..write('focus: $focus, ')
          ..write('isRest: $isRest, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('remoteId: $remoteId')
          ..write(')'))
        .toString();
  }
}

class $PlanExercisesTable extends PlanExercises
    with TableInfo<$PlanExercisesTable, PlanExerciseRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlanExercisesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _planDayIdMeta = const VerificationMeta(
    'planDayId',
  );
  @override
  late final GeneratedColumn<int> planDayId = GeneratedColumn<int>(
    'plan_day_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES plan_days (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _orderIndexMeta = const VerificationMeta(
    'orderIndex',
  );
  @override
  late final GeneratedColumn<int> orderIndex = GeneratedColumn<int>(
    'order_index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _equipmentMeta = const VerificationMeta(
    'equipment',
  );
  @override
  late final GeneratedColumn<String> equipment = GeneratedColumn<String>(
    'equipment',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _targetSetsMeta = const VerificationMeta(
    'targetSets',
  );
  @override
  late final GeneratedColumn<int> targetSets = GeneratedColumn<int>(
    'target_sets',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _schemeMeta = const VerificationMeta('scheme');
  @override
  late final GeneratedColumn<String> scheme = GeneratedColumn<String>(
    'scheme',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _targetMeta = const VerificationMeta('target');
  @override
  late final GeneratedColumn<String> target = GeneratedColumn<String>(
    'target',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _remoteIdMeta = const VerificationMeta(
    'remoteId',
  );
  @override
  late final GeneratedColumn<String> remoteId = GeneratedColumn<String>(
    'remote_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    planDayId,
    orderIndex,
    name,
    equipment,
    targetSets,
    scheme,
    target,
    updatedAt,
    remoteId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'plan_exercises';
  @override
  VerificationContext validateIntegrity(
    Insertable<PlanExerciseRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('plan_day_id')) {
      context.handle(
        _planDayIdMeta,
        planDayId.isAcceptableOrUnknown(data['plan_day_id']!, _planDayIdMeta),
      );
    } else if (isInserting) {
      context.missing(_planDayIdMeta);
    }
    if (data.containsKey('order_index')) {
      context.handle(
        _orderIndexMeta,
        orderIndex.isAcceptableOrUnknown(data['order_index']!, _orderIndexMeta),
      );
    } else if (isInserting) {
      context.missing(_orderIndexMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('equipment')) {
      context.handle(
        _equipmentMeta,
        equipment.isAcceptableOrUnknown(data['equipment']!, _equipmentMeta),
      );
    }
    if (data.containsKey('target_sets')) {
      context.handle(
        _targetSetsMeta,
        targetSets.isAcceptableOrUnknown(data['target_sets']!, _targetSetsMeta),
      );
    }
    if (data.containsKey('scheme')) {
      context.handle(
        _schemeMeta,
        scheme.isAcceptableOrUnknown(data['scheme']!, _schemeMeta),
      );
    }
    if (data.containsKey('target')) {
      context.handle(
        _targetMeta,
        target.isAcceptableOrUnknown(data['target']!, _targetMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('remote_id')) {
      context.handle(
        _remoteIdMeta,
        remoteId.isAcceptableOrUnknown(data['remote_id']!, _remoteIdMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PlanExerciseRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PlanExerciseRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      planDayId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}plan_day_id'],
      )!,
      orderIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}order_index'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      equipment: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}equipment'],
      ),
      targetSets: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}target_sets'],
      ),
      scheme: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}scheme'],
      ),
      target: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}target'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      ),
      remoteId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}remote_id'],
      ),
    );
  }

  @override
  $PlanExercisesTable createAlias(String alias) {
    return $PlanExercisesTable(attachedDatabase, alias);
  }
}

class PlanExerciseRow extends DataClass implements Insertable<PlanExerciseRow> {
  final int id;
  final int planDayId;
  final int orderIndex;
  final String name;
  final String? equipment;

  /// e.g. 3 (number of target sets per session).
  final int? targetSets;

  /// Prescription shorthand, e.g. "3×8", "5-5-5+", "AMRAP".
  final String? scheme;

  /// Load target, e.g. "75 kg", "80 % 1RM", "bodyweight".
  final String? target;
  final DateTime? updatedAt;
  final String? remoteId;
  const PlanExerciseRow({
    required this.id,
    required this.planDayId,
    required this.orderIndex,
    required this.name,
    this.equipment,
    this.targetSets,
    this.scheme,
    this.target,
    this.updatedAt,
    this.remoteId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['plan_day_id'] = Variable<int>(planDayId);
    map['order_index'] = Variable<int>(orderIndex);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || equipment != null) {
      map['equipment'] = Variable<String>(equipment);
    }
    if (!nullToAbsent || targetSets != null) {
      map['target_sets'] = Variable<int>(targetSets);
    }
    if (!nullToAbsent || scheme != null) {
      map['scheme'] = Variable<String>(scheme);
    }
    if (!nullToAbsent || target != null) {
      map['target'] = Variable<String>(target);
    }
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    if (!nullToAbsent || remoteId != null) {
      map['remote_id'] = Variable<String>(remoteId);
    }
    return map;
  }

  PlanExercisesCompanion toCompanion(bool nullToAbsent) {
    return PlanExercisesCompanion(
      id: Value(id),
      planDayId: Value(planDayId),
      orderIndex: Value(orderIndex),
      name: Value(name),
      equipment: equipment == null && nullToAbsent
          ? const Value.absent()
          : Value(equipment),
      targetSets: targetSets == null && nullToAbsent
          ? const Value.absent()
          : Value(targetSets),
      scheme: scheme == null && nullToAbsent
          ? const Value.absent()
          : Value(scheme),
      target: target == null && nullToAbsent
          ? const Value.absent()
          : Value(target),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
      remoteId: remoteId == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteId),
    );
  }

  factory PlanExerciseRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PlanExerciseRow(
      id: serializer.fromJson<int>(json['id']),
      planDayId: serializer.fromJson<int>(json['planDayId']),
      orderIndex: serializer.fromJson<int>(json['orderIndex']),
      name: serializer.fromJson<String>(json['name']),
      equipment: serializer.fromJson<String?>(json['equipment']),
      targetSets: serializer.fromJson<int?>(json['targetSets']),
      scheme: serializer.fromJson<String?>(json['scheme']),
      target: serializer.fromJson<String?>(json['target']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
      remoteId: serializer.fromJson<String?>(json['remoteId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'planDayId': serializer.toJson<int>(planDayId),
      'orderIndex': serializer.toJson<int>(orderIndex),
      'name': serializer.toJson<String>(name),
      'equipment': serializer.toJson<String?>(equipment),
      'targetSets': serializer.toJson<int?>(targetSets),
      'scheme': serializer.toJson<String?>(scheme),
      'target': serializer.toJson<String?>(target),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
      'remoteId': serializer.toJson<String?>(remoteId),
    };
  }

  PlanExerciseRow copyWith({
    int? id,
    int? planDayId,
    int? orderIndex,
    String? name,
    Value<String?> equipment = const Value.absent(),
    Value<int?> targetSets = const Value.absent(),
    Value<String?> scheme = const Value.absent(),
    Value<String?> target = const Value.absent(),
    Value<DateTime?> updatedAt = const Value.absent(),
    Value<String?> remoteId = const Value.absent(),
  }) => PlanExerciseRow(
    id: id ?? this.id,
    planDayId: planDayId ?? this.planDayId,
    orderIndex: orderIndex ?? this.orderIndex,
    name: name ?? this.name,
    equipment: equipment.present ? equipment.value : this.equipment,
    targetSets: targetSets.present ? targetSets.value : this.targetSets,
    scheme: scheme.present ? scheme.value : this.scheme,
    target: target.present ? target.value : this.target,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
    remoteId: remoteId.present ? remoteId.value : this.remoteId,
  );
  PlanExerciseRow copyWithCompanion(PlanExercisesCompanion data) {
    return PlanExerciseRow(
      id: data.id.present ? data.id.value : this.id,
      planDayId: data.planDayId.present ? data.planDayId.value : this.planDayId,
      orderIndex: data.orderIndex.present
          ? data.orderIndex.value
          : this.orderIndex,
      name: data.name.present ? data.name.value : this.name,
      equipment: data.equipment.present ? data.equipment.value : this.equipment,
      targetSets: data.targetSets.present
          ? data.targetSets.value
          : this.targetSets,
      scheme: data.scheme.present ? data.scheme.value : this.scheme,
      target: data.target.present ? data.target.value : this.target,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      remoteId: data.remoteId.present ? data.remoteId.value : this.remoteId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PlanExerciseRow(')
          ..write('id: $id, ')
          ..write('planDayId: $planDayId, ')
          ..write('orderIndex: $orderIndex, ')
          ..write('name: $name, ')
          ..write('equipment: $equipment, ')
          ..write('targetSets: $targetSets, ')
          ..write('scheme: $scheme, ')
          ..write('target: $target, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('remoteId: $remoteId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    planDayId,
    orderIndex,
    name,
    equipment,
    targetSets,
    scheme,
    target,
    updatedAt,
    remoteId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PlanExerciseRow &&
          other.id == this.id &&
          other.planDayId == this.planDayId &&
          other.orderIndex == this.orderIndex &&
          other.name == this.name &&
          other.equipment == this.equipment &&
          other.targetSets == this.targetSets &&
          other.scheme == this.scheme &&
          other.target == this.target &&
          other.updatedAt == this.updatedAt &&
          other.remoteId == this.remoteId);
}

class PlanExercisesCompanion extends UpdateCompanion<PlanExerciseRow> {
  final Value<int> id;
  final Value<int> planDayId;
  final Value<int> orderIndex;
  final Value<String> name;
  final Value<String?> equipment;
  final Value<int?> targetSets;
  final Value<String?> scheme;
  final Value<String?> target;
  final Value<DateTime?> updatedAt;
  final Value<String?> remoteId;
  const PlanExercisesCompanion({
    this.id = const Value.absent(),
    this.planDayId = const Value.absent(),
    this.orderIndex = const Value.absent(),
    this.name = const Value.absent(),
    this.equipment = const Value.absent(),
    this.targetSets = const Value.absent(),
    this.scheme = const Value.absent(),
    this.target = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.remoteId = const Value.absent(),
  });
  PlanExercisesCompanion.insert({
    this.id = const Value.absent(),
    required int planDayId,
    required int orderIndex,
    required String name,
    this.equipment = const Value.absent(),
    this.targetSets = const Value.absent(),
    this.scheme = const Value.absent(),
    this.target = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.remoteId = const Value.absent(),
  }) : planDayId = Value(planDayId),
       orderIndex = Value(orderIndex),
       name = Value(name);
  static Insertable<PlanExerciseRow> custom({
    Expression<int>? id,
    Expression<int>? planDayId,
    Expression<int>? orderIndex,
    Expression<String>? name,
    Expression<String>? equipment,
    Expression<int>? targetSets,
    Expression<String>? scheme,
    Expression<String>? target,
    Expression<DateTime>? updatedAt,
    Expression<String>? remoteId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (planDayId != null) 'plan_day_id': planDayId,
      if (orderIndex != null) 'order_index': orderIndex,
      if (name != null) 'name': name,
      if (equipment != null) 'equipment': equipment,
      if (targetSets != null) 'target_sets': targetSets,
      if (scheme != null) 'scheme': scheme,
      if (target != null) 'target': target,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (remoteId != null) 'remote_id': remoteId,
    });
  }

  PlanExercisesCompanion copyWith({
    Value<int>? id,
    Value<int>? planDayId,
    Value<int>? orderIndex,
    Value<String>? name,
    Value<String?>? equipment,
    Value<int?>? targetSets,
    Value<String?>? scheme,
    Value<String?>? target,
    Value<DateTime?>? updatedAt,
    Value<String?>? remoteId,
  }) {
    return PlanExercisesCompanion(
      id: id ?? this.id,
      planDayId: planDayId ?? this.planDayId,
      orderIndex: orderIndex ?? this.orderIndex,
      name: name ?? this.name,
      equipment: equipment ?? this.equipment,
      targetSets: targetSets ?? this.targetSets,
      scheme: scheme ?? this.scheme,
      target: target ?? this.target,
      updatedAt: updatedAt ?? this.updatedAt,
      remoteId: remoteId ?? this.remoteId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (planDayId.present) {
      map['plan_day_id'] = Variable<int>(planDayId.value);
    }
    if (orderIndex.present) {
      map['order_index'] = Variable<int>(orderIndex.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (equipment.present) {
      map['equipment'] = Variable<String>(equipment.value);
    }
    if (targetSets.present) {
      map['target_sets'] = Variable<int>(targetSets.value);
    }
    if (scheme.present) {
      map['scheme'] = Variable<String>(scheme.value);
    }
    if (target.present) {
      map['target'] = Variable<String>(target.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (remoteId.present) {
      map['remote_id'] = Variable<String>(remoteId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlanExercisesCompanion(')
          ..write('id: $id, ')
          ..write('planDayId: $planDayId, ')
          ..write('orderIndex: $orderIndex, ')
          ..write('name: $name, ')
          ..write('equipment: $equipment, ')
          ..write('targetSets: $targetSets, ')
          ..write('scheme: $scheme, ')
          ..write('target: $target, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('remoteId: $remoteId')
          ..write(')'))
        .toString();
  }
}

class $SessionsTable extends Sessions
    with TableInfo<$SessionsTable, SessionRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SessionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _planIdMeta = const VerificationMeta('planId');
  @override
  late final GeneratedColumn<int> planId = GeneratedColumn<int>(
    'plan_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES plans (id)',
    ),
  );
  static const VerificationMeta _dayIndexMeta = const VerificationMeta(
    'dayIndex',
  );
  @override
  late final GeneratedColumn<int> dayIndex = GeneratedColumn<int>(
    'day_index',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _focusMeta = const VerificationMeta('focus');
  @override
  late final GeneratedColumn<String> focus = GeneratedColumn<String>(
    'focus',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _startedAtMeta = const VerificationMeta(
    'startedAt',
  );
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
    'started_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endedAtMeta = const VerificationMeta(
    'endedAt',
  );
  @override
  late final GeneratedColumn<DateTime> endedAt = GeneratedColumn<DateTime>(
    'ended_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _durationSecondsMeta = const VerificationMeta(
    'durationSeconds',
  );
  @override
  late final GeneratedColumn<int> durationSeconds = GeneratedColumn<int>(
    'duration_seconds',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _remoteIdMeta = const VerificationMeta(
    'remoteId',
  );
  @override
  late final GeneratedColumn<String> remoteId = GeneratedColumn<String>(
    'remote_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    planId,
    dayIndex,
    focus,
    startedAt,
    endedAt,
    durationSeconds,
    note,
    updatedAt,
    deletedAt,
    remoteId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sessions';
  @override
  VerificationContext validateIntegrity(
    Insertable<SessionRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('plan_id')) {
      context.handle(
        _planIdMeta,
        planId.isAcceptableOrUnknown(data['plan_id']!, _planIdMeta),
      );
    }
    if (data.containsKey('day_index')) {
      context.handle(
        _dayIndexMeta,
        dayIndex.isAcceptableOrUnknown(data['day_index']!, _dayIndexMeta),
      );
    }
    if (data.containsKey('focus')) {
      context.handle(
        _focusMeta,
        focus.isAcceptableOrUnknown(data['focus']!, _focusMeta),
      );
    }
    if (data.containsKey('started_at')) {
      context.handle(
        _startedAtMeta,
        startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_startedAtMeta);
    }
    if (data.containsKey('ended_at')) {
      context.handle(
        _endedAtMeta,
        endedAt.isAcceptableOrUnknown(data['ended_at']!, _endedAtMeta),
      );
    }
    if (data.containsKey('duration_seconds')) {
      context.handle(
        _durationSecondsMeta,
        durationSeconds.isAcceptableOrUnknown(
          data['duration_seconds']!,
          _durationSecondsMeta,
        ),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('remote_id')) {
      context.handle(
        _remoteIdMeta,
        remoteId.isAcceptableOrUnknown(data['remote_id']!, _remoteIdMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SessionRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SessionRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      planId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}plan_id'],
      ),
      dayIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}day_index'],
      ),
      focus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}focus'],
      ),
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}started_at'],
      )!,
      endedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}ended_at'],
      ),
      durationSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration_seconds'],
      ),
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      remoteId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}remote_id'],
      ),
    );
  }

  @override
  $SessionsTable createAlias(String alias) {
    return $SessionsTable(attachedDatabase, alias);
  }
}

class SessionRow extends DataClass implements Insertable<SessionRow> {
  final int id;

  /// Null for freestyle (ad-hoc) sessions.
  final int? planId;

  /// Day slot within the plan; null for freestyle.
  final int? dayIndex;
  final String? focus;
  final DateTime startedAt;
  final DateTime? endedAt;
  final int? durationSeconds;
  final String? note;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final String? remoteId;
  const SessionRow({
    required this.id,
    this.planId,
    this.dayIndex,
    this.focus,
    required this.startedAt,
    this.endedAt,
    this.durationSeconds,
    this.note,
    required this.updatedAt,
    this.deletedAt,
    this.remoteId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || planId != null) {
      map['plan_id'] = Variable<int>(planId);
    }
    if (!nullToAbsent || dayIndex != null) {
      map['day_index'] = Variable<int>(dayIndex);
    }
    if (!nullToAbsent || focus != null) {
      map['focus'] = Variable<String>(focus);
    }
    map['started_at'] = Variable<DateTime>(startedAt);
    if (!nullToAbsent || endedAt != null) {
      map['ended_at'] = Variable<DateTime>(endedAt);
    }
    if (!nullToAbsent || durationSeconds != null) {
      map['duration_seconds'] = Variable<int>(durationSeconds);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    if (!nullToAbsent || remoteId != null) {
      map['remote_id'] = Variable<String>(remoteId);
    }
    return map;
  }

  SessionsCompanion toCompanion(bool nullToAbsent) {
    return SessionsCompanion(
      id: Value(id),
      planId: planId == null && nullToAbsent
          ? const Value.absent()
          : Value(planId),
      dayIndex: dayIndex == null && nullToAbsent
          ? const Value.absent()
          : Value(dayIndex),
      focus: focus == null && nullToAbsent
          ? const Value.absent()
          : Value(focus),
      startedAt: Value(startedAt),
      endedAt: endedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(endedAt),
      durationSeconds: durationSeconds == null && nullToAbsent
          ? const Value.absent()
          : Value(durationSeconds),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      remoteId: remoteId == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteId),
    );
  }

  factory SessionRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SessionRow(
      id: serializer.fromJson<int>(json['id']),
      planId: serializer.fromJson<int?>(json['planId']),
      dayIndex: serializer.fromJson<int?>(json['dayIndex']),
      focus: serializer.fromJson<String?>(json['focus']),
      startedAt: serializer.fromJson<DateTime>(json['startedAt']),
      endedAt: serializer.fromJson<DateTime?>(json['endedAt']),
      durationSeconds: serializer.fromJson<int?>(json['durationSeconds']),
      note: serializer.fromJson<String?>(json['note']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      remoteId: serializer.fromJson<String?>(json['remoteId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'planId': serializer.toJson<int?>(planId),
      'dayIndex': serializer.toJson<int?>(dayIndex),
      'focus': serializer.toJson<String?>(focus),
      'startedAt': serializer.toJson<DateTime>(startedAt),
      'endedAt': serializer.toJson<DateTime?>(endedAt),
      'durationSeconds': serializer.toJson<int?>(durationSeconds),
      'note': serializer.toJson<String?>(note),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'remoteId': serializer.toJson<String?>(remoteId),
    };
  }

  SessionRow copyWith({
    int? id,
    Value<int?> planId = const Value.absent(),
    Value<int?> dayIndex = const Value.absent(),
    Value<String?> focus = const Value.absent(),
    DateTime? startedAt,
    Value<DateTime?> endedAt = const Value.absent(),
    Value<int?> durationSeconds = const Value.absent(),
    Value<String?> note = const Value.absent(),
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    Value<String?> remoteId = const Value.absent(),
  }) => SessionRow(
    id: id ?? this.id,
    planId: planId.present ? planId.value : this.planId,
    dayIndex: dayIndex.present ? dayIndex.value : this.dayIndex,
    focus: focus.present ? focus.value : this.focus,
    startedAt: startedAt ?? this.startedAt,
    endedAt: endedAt.present ? endedAt.value : this.endedAt,
    durationSeconds: durationSeconds.present
        ? durationSeconds.value
        : this.durationSeconds,
    note: note.present ? note.value : this.note,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    remoteId: remoteId.present ? remoteId.value : this.remoteId,
  );
  SessionRow copyWithCompanion(SessionsCompanion data) {
    return SessionRow(
      id: data.id.present ? data.id.value : this.id,
      planId: data.planId.present ? data.planId.value : this.planId,
      dayIndex: data.dayIndex.present ? data.dayIndex.value : this.dayIndex,
      focus: data.focus.present ? data.focus.value : this.focus,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      endedAt: data.endedAt.present ? data.endedAt.value : this.endedAt,
      durationSeconds: data.durationSeconds.present
          ? data.durationSeconds.value
          : this.durationSeconds,
      note: data.note.present ? data.note.value : this.note,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      remoteId: data.remoteId.present ? data.remoteId.value : this.remoteId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SessionRow(')
          ..write('id: $id, ')
          ..write('planId: $planId, ')
          ..write('dayIndex: $dayIndex, ')
          ..write('focus: $focus, ')
          ..write('startedAt: $startedAt, ')
          ..write('endedAt: $endedAt, ')
          ..write('durationSeconds: $durationSeconds, ')
          ..write('note: $note, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('remoteId: $remoteId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    planId,
    dayIndex,
    focus,
    startedAt,
    endedAt,
    durationSeconds,
    note,
    updatedAt,
    deletedAt,
    remoteId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SessionRow &&
          other.id == this.id &&
          other.planId == this.planId &&
          other.dayIndex == this.dayIndex &&
          other.focus == this.focus &&
          other.startedAt == this.startedAt &&
          other.endedAt == this.endedAt &&
          other.durationSeconds == this.durationSeconds &&
          other.note == this.note &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.remoteId == this.remoteId);
}

class SessionsCompanion extends UpdateCompanion<SessionRow> {
  final Value<int> id;
  final Value<int?> planId;
  final Value<int?> dayIndex;
  final Value<String?> focus;
  final Value<DateTime> startedAt;
  final Value<DateTime?> endedAt;
  final Value<int?> durationSeconds;
  final Value<String?> note;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String?> remoteId;
  const SessionsCompanion({
    this.id = const Value.absent(),
    this.planId = const Value.absent(),
    this.dayIndex = const Value.absent(),
    this.focus = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.endedAt = const Value.absent(),
    this.durationSeconds = const Value.absent(),
    this.note = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.remoteId = const Value.absent(),
  });
  SessionsCompanion.insert({
    this.id = const Value.absent(),
    this.planId = const Value.absent(),
    this.dayIndex = const Value.absent(),
    this.focus = const Value.absent(),
    required DateTime startedAt,
    this.endedAt = const Value.absent(),
    this.durationSeconds = const Value.absent(),
    this.note = const Value.absent(),
    required DateTime updatedAt,
    this.deletedAt = const Value.absent(),
    this.remoteId = const Value.absent(),
  }) : startedAt = Value(startedAt),
       updatedAt = Value(updatedAt);
  static Insertable<SessionRow> custom({
    Expression<int>? id,
    Expression<int>? planId,
    Expression<int>? dayIndex,
    Expression<String>? focus,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? endedAt,
    Expression<int>? durationSeconds,
    Expression<String>? note,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? remoteId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (planId != null) 'plan_id': planId,
      if (dayIndex != null) 'day_index': dayIndex,
      if (focus != null) 'focus': focus,
      if (startedAt != null) 'started_at': startedAt,
      if (endedAt != null) 'ended_at': endedAt,
      if (durationSeconds != null) 'duration_seconds': durationSeconds,
      if (note != null) 'note': note,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (remoteId != null) 'remote_id': remoteId,
    });
  }

  SessionsCompanion copyWith({
    Value<int>? id,
    Value<int?>? planId,
    Value<int?>? dayIndex,
    Value<String?>? focus,
    Value<DateTime>? startedAt,
    Value<DateTime?>? endedAt,
    Value<int?>? durationSeconds,
    Value<String?>? note,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String?>? remoteId,
  }) {
    return SessionsCompanion(
      id: id ?? this.id,
      planId: planId ?? this.planId,
      dayIndex: dayIndex ?? this.dayIndex,
      focus: focus ?? this.focus,
      startedAt: startedAt ?? this.startedAt,
      endedAt: endedAt ?? this.endedAt,
      durationSeconds: durationSeconds ?? this.durationSeconds,
      note: note ?? this.note,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      remoteId: remoteId ?? this.remoteId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (planId.present) {
      map['plan_id'] = Variable<int>(planId.value);
    }
    if (dayIndex.present) {
      map['day_index'] = Variable<int>(dayIndex.value);
    }
    if (focus.present) {
      map['focus'] = Variable<String>(focus.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (endedAt.present) {
      map['ended_at'] = Variable<DateTime>(endedAt.value);
    }
    if (durationSeconds.present) {
      map['duration_seconds'] = Variable<int>(durationSeconds.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (remoteId.present) {
      map['remote_id'] = Variable<String>(remoteId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SessionsCompanion(')
          ..write('id: $id, ')
          ..write('planId: $planId, ')
          ..write('dayIndex: $dayIndex, ')
          ..write('focus: $focus, ')
          ..write('startedAt: $startedAt, ')
          ..write('endedAt: $endedAt, ')
          ..write('durationSeconds: $durationSeconds, ')
          ..write('note: $note, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('remoteId: $remoteId')
          ..write(')'))
        .toString();
  }
}

class $SessionExercisesTable extends SessionExercises
    with TableInfo<$SessionExercisesTable, SessionExerciseRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SessionExercisesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _sessionIdMeta = const VerificationMeta(
    'sessionId',
  );
  @override
  late final GeneratedColumn<int> sessionId = GeneratedColumn<int>(
    'session_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES sessions (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _orderIndexMeta = const VerificationMeta(
    'orderIndex',
  );
  @override
  late final GeneratedColumn<int> orderIndex = GeneratedColumn<int>(
    'order_index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<EquipmentType?, String>
  equipment = GeneratedColumn<String>(
    'equipment',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  ).withConverter<EquipmentType?>($SessionExercisesTable.$converterequipmentn);
  static const VerificationMeta _exerciseNoteMeta = const VerificationMeta(
    'exerciseNote',
  );
  @override
  late final GeneratedColumn<String> exerciseNote = GeneratedColumn<String>(
    'exercise_note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<Modality, String> modality =
      GeneratedColumn<String>(
        'modality',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<Modality>($SessionExercisesTable.$convertermodality);
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _remoteIdMeta = const VerificationMeta(
    'remoteId',
  );
  @override
  late final GeneratedColumn<String> remoteId = GeneratedColumn<String>(
    'remote_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    sessionId,
    orderIndex,
    name,
    equipment,
    exerciseNote,
    modality,
    updatedAt,
    remoteId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'session_exercises';
  @override
  VerificationContext validateIntegrity(
    Insertable<SessionExerciseRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('session_id')) {
      context.handle(
        _sessionIdMeta,
        sessionId.isAcceptableOrUnknown(data['session_id']!, _sessionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sessionIdMeta);
    }
    if (data.containsKey('order_index')) {
      context.handle(
        _orderIndexMeta,
        orderIndex.isAcceptableOrUnknown(data['order_index']!, _orderIndexMeta),
      );
    } else if (isInserting) {
      context.missing(_orderIndexMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('exercise_note')) {
      context.handle(
        _exerciseNoteMeta,
        exerciseNote.isAcceptableOrUnknown(
          data['exercise_note']!,
          _exerciseNoteMeta,
        ),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('remote_id')) {
      context.handle(
        _remoteIdMeta,
        remoteId.isAcceptableOrUnknown(data['remote_id']!, _remoteIdMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SessionExerciseRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SessionExerciseRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      sessionId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}session_id'],
      )!,
      orderIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}order_index'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      equipment: $SessionExercisesTable.$converterequipmentn.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}equipment'],
        ),
      ),
      exerciseNote: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}exercise_note'],
      ),
      modality: $SessionExercisesTable.$convertermodality.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}modality'],
        )!,
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      ),
      remoteId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}remote_id'],
      ),
    );
  }

  @override
  $SessionExercisesTable createAlias(String alias) {
    return $SessionExercisesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<EquipmentType, String, String> $converterequipment =
      const EnumNameConverter<EquipmentType>(EquipmentType.values);
  static JsonTypeConverter2<EquipmentType?, String?, String?>
  $converterequipmentn = JsonTypeConverter2.asNullable($converterequipment);
  static JsonTypeConverter2<Modality, String, String> $convertermodality =
      const EnumNameConverter<Modality>(Modality.values);
}

class SessionExerciseRow extends DataClass
    implements Insertable<SessionExerciseRow> {
  final int id;
  final int sessionId;
  final int orderIndex;
  final String name;
  final EquipmentType? equipment;
  final String? exerciseNote;
  final Modality modality;
  final DateTime? updatedAt;
  final String? remoteId;
  const SessionExerciseRow({
    required this.id,
    required this.sessionId,
    required this.orderIndex,
    required this.name,
    this.equipment,
    this.exerciseNote,
    required this.modality,
    this.updatedAt,
    this.remoteId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['session_id'] = Variable<int>(sessionId);
    map['order_index'] = Variable<int>(orderIndex);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || equipment != null) {
      map['equipment'] = Variable<String>(
        $SessionExercisesTable.$converterequipmentn.toSql(equipment),
      );
    }
    if (!nullToAbsent || exerciseNote != null) {
      map['exercise_note'] = Variable<String>(exerciseNote);
    }
    {
      map['modality'] = Variable<String>(
        $SessionExercisesTable.$convertermodality.toSql(modality),
      );
    }
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    if (!nullToAbsent || remoteId != null) {
      map['remote_id'] = Variable<String>(remoteId);
    }
    return map;
  }

  SessionExercisesCompanion toCompanion(bool nullToAbsent) {
    return SessionExercisesCompanion(
      id: Value(id),
      sessionId: Value(sessionId),
      orderIndex: Value(orderIndex),
      name: Value(name),
      equipment: equipment == null && nullToAbsent
          ? const Value.absent()
          : Value(equipment),
      exerciseNote: exerciseNote == null && nullToAbsent
          ? const Value.absent()
          : Value(exerciseNote),
      modality: Value(modality),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
      remoteId: remoteId == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteId),
    );
  }

  factory SessionExerciseRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SessionExerciseRow(
      id: serializer.fromJson<int>(json['id']),
      sessionId: serializer.fromJson<int>(json['sessionId']),
      orderIndex: serializer.fromJson<int>(json['orderIndex']),
      name: serializer.fromJson<String>(json['name']),
      equipment: $SessionExercisesTable.$converterequipmentn.fromJson(
        serializer.fromJson<String?>(json['equipment']),
      ),
      exerciseNote: serializer.fromJson<String?>(json['exerciseNote']),
      modality: $SessionExercisesTable.$convertermodality.fromJson(
        serializer.fromJson<String>(json['modality']),
      ),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
      remoteId: serializer.fromJson<String?>(json['remoteId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'sessionId': serializer.toJson<int>(sessionId),
      'orderIndex': serializer.toJson<int>(orderIndex),
      'name': serializer.toJson<String>(name),
      'equipment': serializer.toJson<String?>(
        $SessionExercisesTable.$converterequipmentn.toJson(equipment),
      ),
      'exerciseNote': serializer.toJson<String?>(exerciseNote),
      'modality': serializer.toJson<String>(
        $SessionExercisesTable.$convertermodality.toJson(modality),
      ),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
      'remoteId': serializer.toJson<String?>(remoteId),
    };
  }

  SessionExerciseRow copyWith({
    int? id,
    int? sessionId,
    int? orderIndex,
    String? name,
    Value<EquipmentType?> equipment = const Value.absent(),
    Value<String?> exerciseNote = const Value.absent(),
    Modality? modality,
    Value<DateTime?> updatedAt = const Value.absent(),
    Value<String?> remoteId = const Value.absent(),
  }) => SessionExerciseRow(
    id: id ?? this.id,
    sessionId: sessionId ?? this.sessionId,
    orderIndex: orderIndex ?? this.orderIndex,
    name: name ?? this.name,
    equipment: equipment.present ? equipment.value : this.equipment,
    exerciseNote: exerciseNote.present ? exerciseNote.value : this.exerciseNote,
    modality: modality ?? this.modality,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
    remoteId: remoteId.present ? remoteId.value : this.remoteId,
  );
  SessionExerciseRow copyWithCompanion(SessionExercisesCompanion data) {
    return SessionExerciseRow(
      id: data.id.present ? data.id.value : this.id,
      sessionId: data.sessionId.present ? data.sessionId.value : this.sessionId,
      orderIndex: data.orderIndex.present
          ? data.orderIndex.value
          : this.orderIndex,
      name: data.name.present ? data.name.value : this.name,
      equipment: data.equipment.present ? data.equipment.value : this.equipment,
      exerciseNote: data.exerciseNote.present
          ? data.exerciseNote.value
          : this.exerciseNote,
      modality: data.modality.present ? data.modality.value : this.modality,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      remoteId: data.remoteId.present ? data.remoteId.value : this.remoteId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SessionExerciseRow(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('orderIndex: $orderIndex, ')
          ..write('name: $name, ')
          ..write('equipment: $equipment, ')
          ..write('exerciseNote: $exerciseNote, ')
          ..write('modality: $modality, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('remoteId: $remoteId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    sessionId,
    orderIndex,
    name,
    equipment,
    exerciseNote,
    modality,
    updatedAt,
    remoteId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SessionExerciseRow &&
          other.id == this.id &&
          other.sessionId == this.sessionId &&
          other.orderIndex == this.orderIndex &&
          other.name == this.name &&
          other.equipment == this.equipment &&
          other.exerciseNote == this.exerciseNote &&
          other.modality == this.modality &&
          other.updatedAt == this.updatedAt &&
          other.remoteId == this.remoteId);
}

class SessionExercisesCompanion extends UpdateCompanion<SessionExerciseRow> {
  final Value<int> id;
  final Value<int> sessionId;
  final Value<int> orderIndex;
  final Value<String> name;
  final Value<EquipmentType?> equipment;
  final Value<String?> exerciseNote;
  final Value<Modality> modality;
  final Value<DateTime?> updatedAt;
  final Value<String?> remoteId;
  const SessionExercisesCompanion({
    this.id = const Value.absent(),
    this.sessionId = const Value.absent(),
    this.orderIndex = const Value.absent(),
    this.name = const Value.absent(),
    this.equipment = const Value.absent(),
    this.exerciseNote = const Value.absent(),
    this.modality = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.remoteId = const Value.absent(),
  });
  SessionExercisesCompanion.insert({
    this.id = const Value.absent(),
    required int sessionId,
    required int orderIndex,
    required String name,
    this.equipment = const Value.absent(),
    this.exerciseNote = const Value.absent(),
    required Modality modality,
    this.updatedAt = const Value.absent(),
    this.remoteId = const Value.absent(),
  }) : sessionId = Value(sessionId),
       orderIndex = Value(orderIndex),
       name = Value(name),
       modality = Value(modality);
  static Insertable<SessionExerciseRow> custom({
    Expression<int>? id,
    Expression<int>? sessionId,
    Expression<int>? orderIndex,
    Expression<String>? name,
    Expression<String>? equipment,
    Expression<String>? exerciseNote,
    Expression<String>? modality,
    Expression<DateTime>? updatedAt,
    Expression<String>? remoteId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sessionId != null) 'session_id': sessionId,
      if (orderIndex != null) 'order_index': orderIndex,
      if (name != null) 'name': name,
      if (equipment != null) 'equipment': equipment,
      if (exerciseNote != null) 'exercise_note': exerciseNote,
      if (modality != null) 'modality': modality,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (remoteId != null) 'remote_id': remoteId,
    });
  }

  SessionExercisesCompanion copyWith({
    Value<int>? id,
    Value<int>? sessionId,
    Value<int>? orderIndex,
    Value<String>? name,
    Value<EquipmentType?>? equipment,
    Value<String?>? exerciseNote,
    Value<Modality>? modality,
    Value<DateTime?>? updatedAt,
    Value<String?>? remoteId,
  }) {
    return SessionExercisesCompanion(
      id: id ?? this.id,
      sessionId: sessionId ?? this.sessionId,
      orderIndex: orderIndex ?? this.orderIndex,
      name: name ?? this.name,
      equipment: equipment ?? this.equipment,
      exerciseNote: exerciseNote ?? this.exerciseNote,
      modality: modality ?? this.modality,
      updatedAt: updatedAt ?? this.updatedAt,
      remoteId: remoteId ?? this.remoteId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (sessionId.present) {
      map['session_id'] = Variable<int>(sessionId.value);
    }
    if (orderIndex.present) {
      map['order_index'] = Variable<int>(orderIndex.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (equipment.present) {
      map['equipment'] = Variable<String>(
        $SessionExercisesTable.$converterequipmentn.toSql(equipment.value),
      );
    }
    if (exerciseNote.present) {
      map['exercise_note'] = Variable<String>(exerciseNote.value);
    }
    if (modality.present) {
      map['modality'] = Variable<String>(
        $SessionExercisesTable.$convertermodality.toSql(modality.value),
      );
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (remoteId.present) {
      map['remote_id'] = Variable<String>(remoteId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SessionExercisesCompanion(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('orderIndex: $orderIndex, ')
          ..write('name: $name, ')
          ..write('equipment: $equipment, ')
          ..write('exerciseNote: $exerciseNote, ')
          ..write('modality: $modality, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('remoteId: $remoteId')
          ..write(')'))
        .toString();
  }
}

class $LoggedSetsTable extends LoggedSets
    with TableInfo<$LoggedSetsTable, LoggedSetRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LoggedSetsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _sessionExerciseIdMeta = const VerificationMeta(
    'sessionExerciseId',
  );
  @override
  late final GeneratedColumn<int> sessionExerciseId = GeneratedColumn<int>(
    'session_exercise_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES session_exercises (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _orderIndexMeta = const VerificationMeta(
    'orderIndex',
  );
  @override
  late final GeneratedColumn<int> orderIndex = GeneratedColumn<int>(
    'order_index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<Modality, String> modality =
      GeneratedColumn<String>(
        'modality',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<Modality>($LoggedSetsTable.$convertermodality);
  @override
  late final GeneratedColumnWithTypeConverter<Map<String, double>, String>
  metrics = GeneratedColumn<String>(
    'metrics',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<Map<String, double>>($LoggedSetsTable.$convertermetrics);
  static const VerificationMeta _isDoneMeta = const VerificationMeta('isDone');
  @override
  late final GeneratedColumn<bool> isDone = GeneratedColumn<bool>(
    'is_done',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_done" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _remoteIdMeta = const VerificationMeta(
    'remoteId',
  );
  @override
  late final GeneratedColumn<String> remoteId = GeneratedColumn<String>(
    'remote_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    sessionExerciseId,
    orderIndex,
    modality,
    metrics,
    isDone,
    createdAt,
    updatedAt,
    remoteId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'logged_sets';
  @override
  VerificationContext validateIntegrity(
    Insertable<LoggedSetRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('session_exercise_id')) {
      context.handle(
        _sessionExerciseIdMeta,
        sessionExerciseId.isAcceptableOrUnknown(
          data['session_exercise_id']!,
          _sessionExerciseIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_sessionExerciseIdMeta);
    }
    if (data.containsKey('order_index')) {
      context.handle(
        _orderIndexMeta,
        orderIndex.isAcceptableOrUnknown(data['order_index']!, _orderIndexMeta),
      );
    } else if (isInserting) {
      context.missing(_orderIndexMeta);
    }
    if (data.containsKey('is_done')) {
      context.handle(
        _isDoneMeta,
        isDone.isAcceptableOrUnknown(data['is_done']!, _isDoneMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('remote_id')) {
      context.handle(
        _remoteIdMeta,
        remoteId.isAcceptableOrUnknown(data['remote_id']!, _remoteIdMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LoggedSetRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LoggedSetRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      sessionExerciseId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}session_exercise_id'],
      )!,
      orderIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}order_index'],
      )!,
      modality: $LoggedSetsTable.$convertermodality.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}modality'],
        )!,
      ),
      metrics: $LoggedSetsTable.$convertermetrics.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}metrics'],
        )!,
      ),
      isDone: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_done'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      ),
      remoteId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}remote_id'],
      ),
    );
  }

  @override
  $LoggedSetsTable createAlias(String alias) {
    return $LoggedSetsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<Modality, String, String> $convertermodality =
      const EnumNameConverter<Modality>(Modality.values);
  static TypeConverter<Map<String, double>, String> $convertermetrics =
      const MetricsConverter();
}

class LoggedSetRow extends DataClass implements Insertable<LoggedSetRow> {
  final int id;
  final int sessionExerciseId;
  final int orderIndex;

  /// Denormalized from the parent exercise for fast per-set queries.
  final Modality modality;

  /// Flexible metric map — see [Modality] for keys per modality.
  final Map<String, double> metrics;
  final bool isDone;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String? remoteId;
  const LoggedSetRow({
    required this.id,
    required this.sessionExerciseId,
    required this.orderIndex,
    required this.modality,
    required this.metrics,
    required this.isDone,
    required this.createdAt,
    this.updatedAt,
    this.remoteId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['session_exercise_id'] = Variable<int>(sessionExerciseId);
    map['order_index'] = Variable<int>(orderIndex);
    {
      map['modality'] = Variable<String>(
        $LoggedSetsTable.$convertermodality.toSql(modality),
      );
    }
    {
      map['metrics'] = Variable<String>(
        $LoggedSetsTable.$convertermetrics.toSql(metrics),
      );
    }
    map['is_done'] = Variable<bool>(isDone);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    if (!nullToAbsent || remoteId != null) {
      map['remote_id'] = Variable<String>(remoteId);
    }
    return map;
  }

  LoggedSetsCompanion toCompanion(bool nullToAbsent) {
    return LoggedSetsCompanion(
      id: Value(id),
      sessionExerciseId: Value(sessionExerciseId),
      orderIndex: Value(orderIndex),
      modality: Value(modality),
      metrics: Value(metrics),
      isDone: Value(isDone),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
      remoteId: remoteId == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteId),
    );
  }

  factory LoggedSetRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LoggedSetRow(
      id: serializer.fromJson<int>(json['id']),
      sessionExerciseId: serializer.fromJson<int>(json['sessionExerciseId']),
      orderIndex: serializer.fromJson<int>(json['orderIndex']),
      modality: $LoggedSetsTable.$convertermodality.fromJson(
        serializer.fromJson<String>(json['modality']),
      ),
      metrics: serializer.fromJson<Map<String, double>>(json['metrics']),
      isDone: serializer.fromJson<bool>(json['isDone']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
      remoteId: serializer.fromJson<String?>(json['remoteId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'sessionExerciseId': serializer.toJson<int>(sessionExerciseId),
      'orderIndex': serializer.toJson<int>(orderIndex),
      'modality': serializer.toJson<String>(
        $LoggedSetsTable.$convertermodality.toJson(modality),
      ),
      'metrics': serializer.toJson<Map<String, double>>(metrics),
      'isDone': serializer.toJson<bool>(isDone),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
      'remoteId': serializer.toJson<String?>(remoteId),
    };
  }

  LoggedSetRow copyWith({
    int? id,
    int? sessionExerciseId,
    int? orderIndex,
    Modality? modality,
    Map<String, double>? metrics,
    bool? isDone,
    DateTime? createdAt,
    Value<DateTime?> updatedAt = const Value.absent(),
    Value<String?> remoteId = const Value.absent(),
  }) => LoggedSetRow(
    id: id ?? this.id,
    sessionExerciseId: sessionExerciseId ?? this.sessionExerciseId,
    orderIndex: orderIndex ?? this.orderIndex,
    modality: modality ?? this.modality,
    metrics: metrics ?? this.metrics,
    isDone: isDone ?? this.isDone,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
    remoteId: remoteId.present ? remoteId.value : this.remoteId,
  );
  LoggedSetRow copyWithCompanion(LoggedSetsCompanion data) {
    return LoggedSetRow(
      id: data.id.present ? data.id.value : this.id,
      sessionExerciseId: data.sessionExerciseId.present
          ? data.sessionExerciseId.value
          : this.sessionExerciseId,
      orderIndex: data.orderIndex.present
          ? data.orderIndex.value
          : this.orderIndex,
      modality: data.modality.present ? data.modality.value : this.modality,
      metrics: data.metrics.present ? data.metrics.value : this.metrics,
      isDone: data.isDone.present ? data.isDone.value : this.isDone,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      remoteId: data.remoteId.present ? data.remoteId.value : this.remoteId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LoggedSetRow(')
          ..write('id: $id, ')
          ..write('sessionExerciseId: $sessionExerciseId, ')
          ..write('orderIndex: $orderIndex, ')
          ..write('modality: $modality, ')
          ..write('metrics: $metrics, ')
          ..write('isDone: $isDone, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('remoteId: $remoteId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    sessionExerciseId,
    orderIndex,
    modality,
    metrics,
    isDone,
    createdAt,
    updatedAt,
    remoteId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LoggedSetRow &&
          other.id == this.id &&
          other.sessionExerciseId == this.sessionExerciseId &&
          other.orderIndex == this.orderIndex &&
          other.modality == this.modality &&
          other.metrics == this.metrics &&
          other.isDone == this.isDone &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.remoteId == this.remoteId);
}

class LoggedSetsCompanion extends UpdateCompanion<LoggedSetRow> {
  final Value<int> id;
  final Value<int> sessionExerciseId;
  final Value<int> orderIndex;
  final Value<Modality> modality;
  final Value<Map<String, double>> metrics;
  final Value<bool> isDone;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<String?> remoteId;
  const LoggedSetsCompanion({
    this.id = const Value.absent(),
    this.sessionExerciseId = const Value.absent(),
    this.orderIndex = const Value.absent(),
    this.modality = const Value.absent(),
    this.metrics = const Value.absent(),
    this.isDone = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.remoteId = const Value.absent(),
  });
  LoggedSetsCompanion.insert({
    this.id = const Value.absent(),
    required int sessionExerciseId,
    required int orderIndex,
    required Modality modality,
    required Map<String, double> metrics,
    this.isDone = const Value.absent(),
    required DateTime createdAt,
    this.updatedAt = const Value.absent(),
    this.remoteId = const Value.absent(),
  }) : sessionExerciseId = Value(sessionExerciseId),
       orderIndex = Value(orderIndex),
       modality = Value(modality),
       metrics = Value(metrics),
       createdAt = Value(createdAt);
  static Insertable<LoggedSetRow> custom({
    Expression<int>? id,
    Expression<int>? sessionExerciseId,
    Expression<int>? orderIndex,
    Expression<String>? modality,
    Expression<String>? metrics,
    Expression<bool>? isDone,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? remoteId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sessionExerciseId != null) 'session_exercise_id': sessionExerciseId,
      if (orderIndex != null) 'order_index': orderIndex,
      if (modality != null) 'modality': modality,
      if (metrics != null) 'metrics': metrics,
      if (isDone != null) 'is_done': isDone,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (remoteId != null) 'remote_id': remoteId,
    });
  }

  LoggedSetsCompanion copyWith({
    Value<int>? id,
    Value<int>? sessionExerciseId,
    Value<int>? orderIndex,
    Value<Modality>? modality,
    Value<Map<String, double>>? metrics,
    Value<bool>? isDone,
    Value<DateTime>? createdAt,
    Value<DateTime?>? updatedAt,
    Value<String?>? remoteId,
  }) {
    return LoggedSetsCompanion(
      id: id ?? this.id,
      sessionExerciseId: sessionExerciseId ?? this.sessionExerciseId,
      orderIndex: orderIndex ?? this.orderIndex,
      modality: modality ?? this.modality,
      metrics: metrics ?? this.metrics,
      isDone: isDone ?? this.isDone,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      remoteId: remoteId ?? this.remoteId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (sessionExerciseId.present) {
      map['session_exercise_id'] = Variable<int>(sessionExerciseId.value);
    }
    if (orderIndex.present) {
      map['order_index'] = Variable<int>(orderIndex.value);
    }
    if (modality.present) {
      map['modality'] = Variable<String>(
        $LoggedSetsTable.$convertermodality.toSql(modality.value),
      );
    }
    if (metrics.present) {
      map['metrics'] = Variable<String>(
        $LoggedSetsTable.$convertermetrics.toSql(metrics.value),
      );
    }
    if (isDone.present) {
      map['is_done'] = Variable<bool>(isDone.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (remoteId.present) {
      map['remote_id'] = Variable<String>(remoteId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LoggedSetsCompanion(')
          ..write('id: $id, ')
          ..write('sessionExerciseId: $sessionExerciseId, ')
          ..write('orderIndex: $orderIndex, ')
          ..write('modality: $modality, ')
          ..write('metrics: $metrics, ')
          ..write('isDone: $isDone, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('remoteId: $remoteId')
          ..write(')'))
        .toString();
  }
}

class $ExercisesTable extends Exercises
    with TableInfo<$ExercisesTable, ExerciseRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExercisesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  @override
  late final GeneratedColumnWithTypeConverter<Modality, String> modality =
      GeneratedColumn<String>(
        'modality',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<Modality>($ExercisesTable.$convertermodality);
  static const VerificationMeta _muscleGroupMeta = const VerificationMeta(
    'muscleGroup',
  );
  @override
  late final GeneratedColumn<String> muscleGroup = GeneratedColumn<String>(
    'muscle_group',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _equipmentMeta = const VerificationMeta(
    'equipment',
  );
  @override
  late final GeneratedColumn<String> equipment = GeneratedColumn<String>(
    'equipment',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isCustomMeta = const VerificationMeta(
    'isCustom',
  );
  @override
  late final GeneratedColumn<bool> isCustom = GeneratedColumn<bool>(
    'is_custom',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_custom" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    modality,
    muscleGroup,
    equipment,
    isCustom,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'exercises';
  @override
  VerificationContext validateIntegrity(
    Insertable<ExerciseRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('muscle_group')) {
      context.handle(
        _muscleGroupMeta,
        muscleGroup.isAcceptableOrUnknown(
          data['muscle_group']!,
          _muscleGroupMeta,
        ),
      );
    }
    if (data.containsKey('equipment')) {
      context.handle(
        _equipmentMeta,
        equipment.isAcceptableOrUnknown(data['equipment']!, _equipmentMeta),
      );
    }
    if (data.containsKey('is_custom')) {
      context.handle(
        _isCustomMeta,
        isCustom.isAcceptableOrUnknown(data['is_custom']!, _isCustomMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExerciseRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExerciseRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      modality: $ExercisesTable.$convertermodality.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}modality'],
        )!,
      ),
      muscleGroup: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}muscle_group'],
      ),
      equipment: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}equipment'],
      ),
      isCustom: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_custom'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $ExercisesTable createAlias(String alias) {
    return $ExercisesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<Modality, String, String> $convertermodality =
      const EnumNameConverter<Modality>(Modality.values);
}

class ExerciseRow extends DataClass implements Insertable<ExerciseRow> {
  final int id;
  final String name;
  final Modality modality;
  final String? muscleGroup;
  final String? equipment;
  final bool isCustom;
  final DateTime createdAt;
  const ExerciseRow({
    required this.id,
    required this.name,
    required this.modality,
    this.muscleGroup,
    this.equipment,
    required this.isCustom,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    {
      map['modality'] = Variable<String>(
        $ExercisesTable.$convertermodality.toSql(modality),
      );
    }
    if (!nullToAbsent || muscleGroup != null) {
      map['muscle_group'] = Variable<String>(muscleGroup);
    }
    if (!nullToAbsent || equipment != null) {
      map['equipment'] = Variable<String>(equipment);
    }
    map['is_custom'] = Variable<bool>(isCustom);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ExercisesCompanion toCompanion(bool nullToAbsent) {
    return ExercisesCompanion(
      id: Value(id),
      name: Value(name),
      modality: Value(modality),
      muscleGroup: muscleGroup == null && nullToAbsent
          ? const Value.absent()
          : Value(muscleGroup),
      equipment: equipment == null && nullToAbsent
          ? const Value.absent()
          : Value(equipment),
      isCustom: Value(isCustom),
      createdAt: Value(createdAt),
    );
  }

  factory ExerciseRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExerciseRow(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      modality: $ExercisesTable.$convertermodality.fromJson(
        serializer.fromJson<String>(json['modality']),
      ),
      muscleGroup: serializer.fromJson<String?>(json['muscleGroup']),
      equipment: serializer.fromJson<String?>(json['equipment']),
      isCustom: serializer.fromJson<bool>(json['isCustom']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'modality': serializer.toJson<String>(
        $ExercisesTable.$convertermodality.toJson(modality),
      ),
      'muscleGroup': serializer.toJson<String?>(muscleGroup),
      'equipment': serializer.toJson<String?>(equipment),
      'isCustom': serializer.toJson<bool>(isCustom),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  ExerciseRow copyWith({
    int? id,
    String? name,
    Modality? modality,
    Value<String?> muscleGroup = const Value.absent(),
    Value<String?> equipment = const Value.absent(),
    bool? isCustom,
    DateTime? createdAt,
  }) => ExerciseRow(
    id: id ?? this.id,
    name: name ?? this.name,
    modality: modality ?? this.modality,
    muscleGroup: muscleGroup.present ? muscleGroup.value : this.muscleGroup,
    equipment: equipment.present ? equipment.value : this.equipment,
    isCustom: isCustom ?? this.isCustom,
    createdAt: createdAt ?? this.createdAt,
  );
  ExerciseRow copyWithCompanion(ExercisesCompanion data) {
    return ExerciseRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      modality: data.modality.present ? data.modality.value : this.modality,
      muscleGroup: data.muscleGroup.present
          ? data.muscleGroup.value
          : this.muscleGroup,
      equipment: data.equipment.present ? data.equipment.value : this.equipment,
      isCustom: data.isCustom.present ? data.isCustom.value : this.isCustom,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExerciseRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('modality: $modality, ')
          ..write('muscleGroup: $muscleGroup, ')
          ..write('equipment: $equipment, ')
          ..write('isCustom: $isCustom, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    modality,
    muscleGroup,
    equipment,
    isCustom,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExerciseRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.modality == this.modality &&
          other.muscleGroup == this.muscleGroup &&
          other.equipment == this.equipment &&
          other.isCustom == this.isCustom &&
          other.createdAt == this.createdAt);
}

class ExercisesCompanion extends UpdateCompanion<ExerciseRow> {
  final Value<int> id;
  final Value<String> name;
  final Value<Modality> modality;
  final Value<String?> muscleGroup;
  final Value<String?> equipment;
  final Value<bool> isCustom;
  final Value<DateTime> createdAt;
  const ExercisesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.modality = const Value.absent(),
    this.muscleGroup = const Value.absent(),
    this.equipment = const Value.absent(),
    this.isCustom = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  ExercisesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required Modality modality,
    this.muscleGroup = const Value.absent(),
    this.equipment = const Value.absent(),
    this.isCustom = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : name = Value(name),
       modality = Value(modality);
  static Insertable<ExerciseRow> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? modality,
    Expression<String>? muscleGroup,
    Expression<String>? equipment,
    Expression<bool>? isCustom,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (modality != null) 'modality': modality,
      if (muscleGroup != null) 'muscle_group': muscleGroup,
      if (equipment != null) 'equipment': equipment,
      if (isCustom != null) 'is_custom': isCustom,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  ExercisesCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<Modality>? modality,
    Value<String?>? muscleGroup,
    Value<String?>? equipment,
    Value<bool>? isCustom,
    Value<DateTime>? createdAt,
  }) {
    return ExercisesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      modality: modality ?? this.modality,
      muscleGroup: muscleGroup ?? this.muscleGroup,
      equipment: equipment ?? this.equipment,
      isCustom: isCustom ?? this.isCustom,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (modality.present) {
      map['modality'] = Variable<String>(
        $ExercisesTable.$convertermodality.toSql(modality.value),
      );
    }
    if (muscleGroup.present) {
      map['muscle_group'] = Variable<String>(muscleGroup.value);
    }
    if (equipment.present) {
      map['equipment'] = Variable<String>(equipment.value);
    }
    if (isCustom.present) {
      map['is_custom'] = Variable<bool>(isCustom.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExercisesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('modality: $modality, ')
          ..write('muscleGroup: $muscleGroup, ')
          ..write('equipment: $equipment, ')
          ..write('isCustom: $isCustom, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $WeightEntriesTable extends WeightEntries
    with TableInfo<$WeightEntriesTable, WeightEntryRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WeightEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _weightKgMeta = const VerificationMeta(
    'weightKg',
  );
  @override
  late final GeneratedColumn<double> weightKg = GeneratedColumn<double>(
    'weight_kg',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _recordedAtMeta = const VerificationMeta(
    'recordedAt',
  );
  @override
  late final GeneratedColumn<DateTime> recordedAt = GeneratedColumn<DateTime>(
    'recorded_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, weightKg, note, recordedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'weight_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<WeightEntryRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('weight_kg')) {
      context.handle(
        _weightKgMeta,
        weightKg.isAcceptableOrUnknown(data['weight_kg']!, _weightKgMeta),
      );
    } else if (isInserting) {
      context.missing(_weightKgMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('recorded_at')) {
      context.handle(
        _recordedAtMeta,
        recordedAt.isAcceptableOrUnknown(data['recorded_at']!, _recordedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_recordedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WeightEntryRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WeightEntryRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      weightKg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}weight_kg'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      recordedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}recorded_at'],
      )!,
    );
  }

  @override
  $WeightEntriesTable createAlias(String alias) {
    return $WeightEntriesTable(attachedDatabase, alias);
  }
}

class WeightEntryRow extends DataClass implements Insertable<WeightEntryRow> {
  final int id;
  final double weightKg;
  final String? note;
  final DateTime recordedAt;
  const WeightEntryRow({
    required this.id,
    required this.weightKg,
    this.note,
    required this.recordedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['weight_kg'] = Variable<double>(weightKg);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['recorded_at'] = Variable<DateTime>(recordedAt);
    return map;
  }

  WeightEntriesCompanion toCompanion(bool nullToAbsent) {
    return WeightEntriesCompanion(
      id: Value(id),
      weightKg: Value(weightKg),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      recordedAt: Value(recordedAt),
    );
  }

  factory WeightEntryRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WeightEntryRow(
      id: serializer.fromJson<int>(json['id']),
      weightKg: serializer.fromJson<double>(json['weightKg']),
      note: serializer.fromJson<String?>(json['note']),
      recordedAt: serializer.fromJson<DateTime>(json['recordedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'weightKg': serializer.toJson<double>(weightKg),
      'note': serializer.toJson<String?>(note),
      'recordedAt': serializer.toJson<DateTime>(recordedAt),
    };
  }

  WeightEntryRow copyWith({
    int? id,
    double? weightKg,
    Value<String?> note = const Value.absent(),
    DateTime? recordedAt,
  }) => WeightEntryRow(
    id: id ?? this.id,
    weightKg: weightKg ?? this.weightKg,
    note: note.present ? note.value : this.note,
    recordedAt: recordedAt ?? this.recordedAt,
  );
  WeightEntryRow copyWithCompanion(WeightEntriesCompanion data) {
    return WeightEntryRow(
      id: data.id.present ? data.id.value : this.id,
      weightKg: data.weightKg.present ? data.weightKg.value : this.weightKg,
      note: data.note.present ? data.note.value : this.note,
      recordedAt: data.recordedAt.present
          ? data.recordedAt.value
          : this.recordedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WeightEntryRow(')
          ..write('id: $id, ')
          ..write('weightKg: $weightKg, ')
          ..write('note: $note, ')
          ..write('recordedAt: $recordedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, weightKg, note, recordedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WeightEntryRow &&
          other.id == this.id &&
          other.weightKg == this.weightKg &&
          other.note == this.note &&
          other.recordedAt == this.recordedAt);
}

class WeightEntriesCompanion extends UpdateCompanion<WeightEntryRow> {
  final Value<int> id;
  final Value<double> weightKg;
  final Value<String?> note;
  final Value<DateTime> recordedAt;
  const WeightEntriesCompanion({
    this.id = const Value.absent(),
    this.weightKg = const Value.absent(),
    this.note = const Value.absent(),
    this.recordedAt = const Value.absent(),
  });
  WeightEntriesCompanion.insert({
    this.id = const Value.absent(),
    required double weightKg,
    this.note = const Value.absent(),
    required DateTime recordedAt,
  }) : weightKg = Value(weightKg),
       recordedAt = Value(recordedAt);
  static Insertable<WeightEntryRow> custom({
    Expression<int>? id,
    Expression<double>? weightKg,
    Expression<String>? note,
    Expression<DateTime>? recordedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (weightKg != null) 'weight_kg': weightKg,
      if (note != null) 'note': note,
      if (recordedAt != null) 'recorded_at': recordedAt,
    });
  }

  WeightEntriesCompanion copyWith({
    Value<int>? id,
    Value<double>? weightKg,
    Value<String?>? note,
    Value<DateTime>? recordedAt,
  }) {
    return WeightEntriesCompanion(
      id: id ?? this.id,
      weightKg: weightKg ?? this.weightKg,
      note: note ?? this.note,
      recordedAt: recordedAt ?? this.recordedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (weightKg.present) {
      map['weight_kg'] = Variable<double>(weightKg.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (recordedAt.present) {
      map['recorded_at'] = Variable<DateTime>(recordedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WeightEntriesCompanion(')
          ..write('id: $id, ')
          ..write('weightKg: $weightKg, ')
          ..write('note: $note, ')
          ..write('recordedAt: $recordedAt')
          ..write(')'))
        .toString();
  }
}

class $GoalsTable extends Goals with TableInfo<$GoalsTable, GoalRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GoalsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<GoalType, String> type =
      GeneratedColumn<String>(
        'type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<GoalType>($GoalsTable.$convertertype);
  static const VerificationMeta _targetValueMeta = const VerificationMeta(
    'targetValue',
  );
  @override
  late final GeneratedColumn<double> targetValue = GeneratedColumn<double>(
    'target_value',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deadlineMeta = const VerificationMeta(
    'deadline',
  );
  @override
  late final GeneratedColumn<DateTime> deadline = GeneratedColumn<DateTime>(
    'deadline',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startValueMeta = const VerificationMeta(
    'startValue',
  );
  @override
  late final GeneratedColumn<double> startValue = GeneratedColumn<double>(
    'start_value',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _exerciseNameMeta = const VerificationMeta(
    'exerciseName',
  );
  @override
  late final GeneratedColumn<String> exerciseName = GeneratedColumn<String>(
    'exercise_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    type,
    targetValue,
    deadline,
    createdAt,
    startValue,
    exerciseName,
    isActive,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'goals';
  @override
  VerificationContext validateIntegrity(
    Insertable<GoalRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('target_value')) {
      context.handle(
        _targetValueMeta,
        targetValue.isAcceptableOrUnknown(
          data['target_value']!,
          _targetValueMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_targetValueMeta);
    }
    if (data.containsKey('deadline')) {
      context.handle(
        _deadlineMeta,
        deadline.isAcceptableOrUnknown(data['deadline']!, _deadlineMeta),
      );
    } else if (isInserting) {
      context.missing(_deadlineMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('start_value')) {
      context.handle(
        _startValueMeta,
        startValue.isAcceptableOrUnknown(data['start_value']!, _startValueMeta),
      );
    }
    if (data.containsKey('exercise_name')) {
      context.handle(
        _exerciseNameMeta,
        exerciseName.isAcceptableOrUnknown(
          data['exercise_name']!,
          _exerciseNameMeta,
        ),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GoalRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GoalRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      type: $GoalsTable.$convertertype.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}type'],
        )!,
      ),
      targetValue: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}target_value'],
      )!,
      deadline: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deadline'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      startValue: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}start_value'],
      ),
      exerciseName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}exercise_name'],
      ),
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
    );
  }

  @override
  $GoalsTable createAlias(String alias) {
    return $GoalsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<GoalType, String, String> $convertertype =
      const EnumNameConverter<GoalType>(GoalType.values);
}

class GoalRow extends DataClass implements Insertable<GoalRow> {
  final int id;
  final GoalType type;
  final double targetValue;
  final DateTime deadline;
  final DateTime createdAt;
  final double? startValue;
  final String? exerciseName;
  final bool isActive;
  const GoalRow({
    required this.id,
    required this.type,
    required this.targetValue,
    required this.deadline,
    required this.createdAt,
    this.startValue,
    this.exerciseName,
    required this.isActive,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      map['type'] = Variable<String>($GoalsTable.$convertertype.toSql(type));
    }
    map['target_value'] = Variable<double>(targetValue);
    map['deadline'] = Variable<DateTime>(deadline);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || startValue != null) {
      map['start_value'] = Variable<double>(startValue);
    }
    if (!nullToAbsent || exerciseName != null) {
      map['exercise_name'] = Variable<String>(exerciseName);
    }
    map['is_active'] = Variable<bool>(isActive);
    return map;
  }

  GoalsCompanion toCompanion(bool nullToAbsent) {
    return GoalsCompanion(
      id: Value(id),
      type: Value(type),
      targetValue: Value(targetValue),
      deadline: Value(deadline),
      createdAt: Value(createdAt),
      startValue: startValue == null && nullToAbsent
          ? const Value.absent()
          : Value(startValue),
      exerciseName: exerciseName == null && nullToAbsent
          ? const Value.absent()
          : Value(exerciseName),
      isActive: Value(isActive),
    );
  }

  factory GoalRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GoalRow(
      id: serializer.fromJson<int>(json['id']),
      type: $GoalsTable.$convertertype.fromJson(
        serializer.fromJson<String>(json['type']),
      ),
      targetValue: serializer.fromJson<double>(json['targetValue']),
      deadline: serializer.fromJson<DateTime>(json['deadline']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      startValue: serializer.fromJson<double?>(json['startValue']),
      exerciseName: serializer.fromJson<String?>(json['exerciseName']),
      isActive: serializer.fromJson<bool>(json['isActive']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'type': serializer.toJson<String>(
        $GoalsTable.$convertertype.toJson(type),
      ),
      'targetValue': serializer.toJson<double>(targetValue),
      'deadline': serializer.toJson<DateTime>(deadline),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'startValue': serializer.toJson<double?>(startValue),
      'exerciseName': serializer.toJson<String?>(exerciseName),
      'isActive': serializer.toJson<bool>(isActive),
    };
  }

  GoalRow copyWith({
    int? id,
    GoalType? type,
    double? targetValue,
    DateTime? deadline,
    DateTime? createdAt,
    Value<double?> startValue = const Value.absent(),
    Value<String?> exerciseName = const Value.absent(),
    bool? isActive,
  }) => GoalRow(
    id: id ?? this.id,
    type: type ?? this.type,
    targetValue: targetValue ?? this.targetValue,
    deadline: deadline ?? this.deadline,
    createdAt: createdAt ?? this.createdAt,
    startValue: startValue.present ? startValue.value : this.startValue,
    exerciseName: exerciseName.present ? exerciseName.value : this.exerciseName,
    isActive: isActive ?? this.isActive,
  );
  GoalRow copyWithCompanion(GoalsCompanion data) {
    return GoalRow(
      id: data.id.present ? data.id.value : this.id,
      type: data.type.present ? data.type.value : this.type,
      targetValue: data.targetValue.present
          ? data.targetValue.value
          : this.targetValue,
      deadline: data.deadline.present ? data.deadline.value : this.deadline,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      startValue: data.startValue.present
          ? data.startValue.value
          : this.startValue,
      exerciseName: data.exerciseName.present
          ? data.exerciseName.value
          : this.exerciseName,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GoalRow(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('targetValue: $targetValue, ')
          ..write('deadline: $deadline, ')
          ..write('createdAt: $createdAt, ')
          ..write('startValue: $startValue, ')
          ..write('exerciseName: $exerciseName, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    type,
    targetValue,
    deadline,
    createdAt,
    startValue,
    exerciseName,
    isActive,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GoalRow &&
          other.id == this.id &&
          other.type == this.type &&
          other.targetValue == this.targetValue &&
          other.deadline == this.deadline &&
          other.createdAt == this.createdAt &&
          other.startValue == this.startValue &&
          other.exerciseName == this.exerciseName &&
          other.isActive == this.isActive);
}

class GoalsCompanion extends UpdateCompanion<GoalRow> {
  final Value<int> id;
  final Value<GoalType> type;
  final Value<double> targetValue;
  final Value<DateTime> deadline;
  final Value<DateTime> createdAt;
  final Value<double?> startValue;
  final Value<String?> exerciseName;
  final Value<bool> isActive;
  const GoalsCompanion({
    this.id = const Value.absent(),
    this.type = const Value.absent(),
    this.targetValue = const Value.absent(),
    this.deadline = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.startValue = const Value.absent(),
    this.exerciseName = const Value.absent(),
    this.isActive = const Value.absent(),
  });
  GoalsCompanion.insert({
    this.id = const Value.absent(),
    required GoalType type,
    required double targetValue,
    required DateTime deadline,
    required DateTime createdAt,
    this.startValue = const Value.absent(),
    this.exerciseName = const Value.absent(),
    this.isActive = const Value.absent(),
  }) : type = Value(type),
       targetValue = Value(targetValue),
       deadline = Value(deadline),
       createdAt = Value(createdAt);
  static Insertable<GoalRow> custom({
    Expression<int>? id,
    Expression<String>? type,
    Expression<double>? targetValue,
    Expression<DateTime>? deadline,
    Expression<DateTime>? createdAt,
    Expression<double>? startValue,
    Expression<String>? exerciseName,
    Expression<bool>? isActive,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (type != null) 'type': type,
      if (targetValue != null) 'target_value': targetValue,
      if (deadline != null) 'deadline': deadline,
      if (createdAt != null) 'created_at': createdAt,
      if (startValue != null) 'start_value': startValue,
      if (exerciseName != null) 'exercise_name': exerciseName,
      if (isActive != null) 'is_active': isActive,
    });
  }

  GoalsCompanion copyWith({
    Value<int>? id,
    Value<GoalType>? type,
    Value<double>? targetValue,
    Value<DateTime>? deadline,
    Value<DateTime>? createdAt,
    Value<double?>? startValue,
    Value<String?>? exerciseName,
    Value<bool>? isActive,
  }) {
    return GoalsCompanion(
      id: id ?? this.id,
      type: type ?? this.type,
      targetValue: targetValue ?? this.targetValue,
      deadline: deadline ?? this.deadline,
      createdAt: createdAt ?? this.createdAt,
      startValue: startValue ?? this.startValue,
      exerciseName: exerciseName ?? this.exerciseName,
      isActive: isActive ?? this.isActive,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(
        $GoalsTable.$convertertype.toSql(type.value),
      );
    }
    if (targetValue.present) {
      map['target_value'] = Variable<double>(targetValue.value);
    }
    if (deadline.present) {
      map['deadline'] = Variable<DateTime>(deadline.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (startValue.present) {
      map['start_value'] = Variable<double>(startValue.value);
    }
    if (exerciseName.present) {
      map['exercise_name'] = Variable<String>(exerciseName.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GoalsCompanion(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('targetValue: $targetValue, ')
          ..write('deadline: $deadline, ')
          ..write('createdAt: $createdAt, ')
          ..write('startValue: $startValue, ')
          ..write('exerciseName: $exerciseName, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $PlansTable plans = $PlansTable(this);
  late final $PlanDaysTable planDays = $PlanDaysTable(this);
  late final $PlanExercisesTable planExercises = $PlanExercisesTable(this);
  late final $SessionsTable sessions = $SessionsTable(this);
  late final $SessionExercisesTable sessionExercises = $SessionExercisesTable(
    this,
  );
  late final $LoggedSetsTable loggedSets = $LoggedSetsTable(this);
  late final $ExercisesTable exercises = $ExercisesTable(this);
  late final $WeightEntriesTable weightEntries = $WeightEntriesTable(this);
  late final $GoalsTable goals = $GoalsTable(this);
  late final PlansDao plansDao = PlansDao(this as AppDatabase);
  late final SessionsDao sessionsDao = SessionsDao(this as AppDatabase);
  late final LoggedSetsDao loggedSetsDao = LoggedSetsDao(this as AppDatabase);
  late final ExercisesDao exercisesDao = ExercisesDao(this as AppDatabase);
  late final WeightEntriesDao weightEntriesDao = WeightEntriesDao(
    this as AppDatabase,
  );
  late final GoalsDao goalsDao = GoalsDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    plans,
    planDays,
    planExercises,
    sessions,
    sessionExercises,
    loggedSets,
    exercises,
    weightEntries,
    goals,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'plans',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('plan_days', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'plan_days',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('plan_exercises', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'sessions',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('session_exercises', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'session_exercises',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('logged_sets', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$PlansTableCreateCompanionBuilder =
    PlansCompanion Function({
      Value<int> id,
      required String name,
      Value<bool> isActive,
      Value<int> currentDayIndex,
      Value<int> sortOrder,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<DateTime?> deletedAt,
      Value<String?> remoteId,
    });
typedef $$PlansTableUpdateCompanionBuilder =
    PlansCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<bool> isActive,
      Value<int> currentDayIndex,
      Value<int> sortOrder,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<String?> remoteId,
    });

final class $$PlansTableReferences
    extends BaseReferences<_$AppDatabase, $PlansTable, PlanRow> {
  $$PlansTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$PlanDaysTable, List<PlanDayRow>>
  _planDaysRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.planDays,
    aliasName: 'plans__id__plan_days__plan_id',
  );

  $$PlanDaysTableProcessedTableManager get planDaysRefs {
    final manager = $$PlanDaysTableTableManager(
      $_db,
      $_db.planDays,
    ).filter((f) => f.planId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_planDaysRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$SessionsTable, List<SessionRow>>
  _sessionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.sessions,
    aliasName: 'plans__id__sessions__plan_id',
  );

  $$SessionsTableProcessedTableManager get sessionsRefs {
    final manager = $$SessionsTableTableManager(
      $_db,
      $_db.sessions,
    ).filter((f) => f.planId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_sessionsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PlansTableFilterComposer extends Composer<_$AppDatabase, $PlansTable> {
  $$PlansTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get currentDayIndex => $composableBuilder(
    column: $table.currentDayIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> planDaysRefs(
    Expression<bool> Function($$PlanDaysTableFilterComposer f) f,
  ) {
    final $$PlanDaysTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.planDays,
      getReferencedColumn: (t) => t.planId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlanDaysTableFilterComposer(
            $db: $db,
            $table: $db.planDays,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> sessionsRefs(
    Expression<bool> Function($$SessionsTableFilterComposer f) f,
  ) {
    final $$SessionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.sessions,
      getReferencedColumn: (t) => t.planId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SessionsTableFilterComposer(
            $db: $db,
            $table: $db.sessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PlansTableOrderingComposer
    extends Composer<_$AppDatabase, $PlansTable> {
  $$PlansTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get currentDayIndex => $composableBuilder(
    column: $table.currentDayIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PlansTableAnnotationComposer
    extends Composer<_$AppDatabase, $PlansTable> {
  $$PlansTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<int> get currentDayIndex => $composableBuilder(
    column: $table.currentDayIndex,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get remoteId =>
      $composableBuilder(column: $table.remoteId, builder: (column) => column);

  Expression<T> planDaysRefs<T extends Object>(
    Expression<T> Function($$PlanDaysTableAnnotationComposer a) f,
  ) {
    final $$PlanDaysTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.planDays,
      getReferencedColumn: (t) => t.planId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlanDaysTableAnnotationComposer(
            $db: $db,
            $table: $db.planDays,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> sessionsRefs<T extends Object>(
    Expression<T> Function($$SessionsTableAnnotationComposer a) f,
  ) {
    final $$SessionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.sessions,
      getReferencedColumn: (t) => t.planId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SessionsTableAnnotationComposer(
            $db: $db,
            $table: $db.sessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PlansTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PlansTable,
          PlanRow,
          $$PlansTableFilterComposer,
          $$PlansTableOrderingComposer,
          $$PlansTableAnnotationComposer,
          $$PlansTableCreateCompanionBuilder,
          $$PlansTableUpdateCompanionBuilder,
          (PlanRow, $$PlansTableReferences),
          PlanRow,
          PrefetchHooks Function({bool planDaysRefs, bool sessionsRefs})
        > {
  $$PlansTableTableManager(_$AppDatabase db, $PlansTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PlansTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PlansTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PlansTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<int> currentDayIndex = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String?> remoteId = const Value.absent(),
              }) => PlansCompanion(
                id: id,
                name: name,
                isActive: isActive,
                currentDayIndex: currentDayIndex,
                sortOrder: sortOrder,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                remoteId: remoteId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<bool> isActive = const Value.absent(),
                Value<int> currentDayIndex = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String?> remoteId = const Value.absent(),
              }) => PlansCompanion.insert(
                id: id,
                name: name,
                isActive: isActive,
                currentDayIndex: currentDayIndex,
                sortOrder: sortOrder,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                remoteId: remoteId,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$PlansTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({planDaysRefs = false, sessionsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (planDaysRefs) db.planDays,
                    if (sessionsRefs) db.sessions,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (planDaysRefs)
                        await $_getPrefetchedData<
                          PlanRow,
                          $PlansTable,
                          PlanDayRow
                        >(
                          currentTable: table,
                          referencedTable: $$PlansTableReferences
                              ._planDaysRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PlansTableReferences(
                                db,
                                table,
                                p0,
                              ).planDaysRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.planId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (sessionsRefs)
                        await $_getPrefetchedData<
                          PlanRow,
                          $PlansTable,
                          SessionRow
                        >(
                          currentTable: table,
                          referencedTable: $$PlansTableReferences
                              ._sessionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PlansTableReferences(
                                db,
                                table,
                                p0,
                              ).sessionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.planId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$PlansTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PlansTable,
      PlanRow,
      $$PlansTableFilterComposer,
      $$PlansTableOrderingComposer,
      $$PlansTableAnnotationComposer,
      $$PlansTableCreateCompanionBuilder,
      $$PlansTableUpdateCompanionBuilder,
      (PlanRow, $$PlansTableReferences),
      PlanRow,
      PrefetchHooks Function({bool planDaysRefs, bool sessionsRefs})
    >;
typedef $$PlanDaysTableCreateCompanionBuilder =
    PlanDaysCompanion Function({
      Value<int> id,
      required int planId,
      required int orderIndex,
      Value<String?> focus,
      Value<bool> isRest,
      Value<DateTime?> updatedAt,
      Value<String?> remoteId,
    });
typedef $$PlanDaysTableUpdateCompanionBuilder =
    PlanDaysCompanion Function({
      Value<int> id,
      Value<int> planId,
      Value<int> orderIndex,
      Value<String?> focus,
      Value<bool> isRest,
      Value<DateTime?> updatedAt,
      Value<String?> remoteId,
    });

final class $$PlanDaysTableReferences
    extends BaseReferences<_$AppDatabase, $PlanDaysTable, PlanDayRow> {
  $$PlanDaysTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PlansTable _planIdTable(_$AppDatabase db) =>
      db.plans.createAlias('plan_days__plan_id__plans__id');

  $$PlansTableProcessedTableManager get planId {
    final $_column = $_itemColumn<int>('plan_id')!;

    final manager = $$PlansTableTableManager(
      $_db,
      $_db.plans,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_planIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$PlanExercisesTable, List<PlanExerciseRow>>
  _planExercisesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.planExercises,
    aliasName: 'plan_days__id__plan_exercises__plan_day_id',
  );

  $$PlanExercisesTableProcessedTableManager get planExercisesRefs {
    final manager = $$PlanExercisesTableTableManager(
      $_db,
      $_db.planExercises,
    ).filter((f) => f.planDayId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_planExercisesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PlanDaysTableFilterComposer
    extends Composer<_$AppDatabase, $PlanDaysTable> {
  $$PlanDaysTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get orderIndex => $composableBuilder(
    column: $table.orderIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get focus => $composableBuilder(
    column: $table.focus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isRest => $composableBuilder(
    column: $table.isRest,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnFilters(column),
  );

  $$PlansTableFilterComposer get planId {
    final $$PlansTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.planId,
      referencedTable: $db.plans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlansTableFilterComposer(
            $db: $db,
            $table: $db.plans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> planExercisesRefs(
    Expression<bool> Function($$PlanExercisesTableFilterComposer f) f,
  ) {
    final $$PlanExercisesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.planExercises,
      getReferencedColumn: (t) => t.planDayId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlanExercisesTableFilterComposer(
            $db: $db,
            $table: $db.planExercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PlanDaysTableOrderingComposer
    extends Composer<_$AppDatabase, $PlanDaysTable> {
  $$PlanDaysTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get orderIndex => $composableBuilder(
    column: $table.orderIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get focus => $composableBuilder(
    column: $table.focus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isRest => $composableBuilder(
    column: $table.isRest,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnOrderings(column),
  );

  $$PlansTableOrderingComposer get planId {
    final $$PlansTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.planId,
      referencedTable: $db.plans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlansTableOrderingComposer(
            $db: $db,
            $table: $db.plans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PlanDaysTableAnnotationComposer
    extends Composer<_$AppDatabase, $PlanDaysTable> {
  $$PlanDaysTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get orderIndex => $composableBuilder(
    column: $table.orderIndex,
    builder: (column) => column,
  );

  GeneratedColumn<String> get focus =>
      $composableBuilder(column: $table.focus, builder: (column) => column);

  GeneratedColumn<bool> get isRest =>
      $composableBuilder(column: $table.isRest, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get remoteId =>
      $composableBuilder(column: $table.remoteId, builder: (column) => column);

  $$PlansTableAnnotationComposer get planId {
    final $$PlansTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.planId,
      referencedTable: $db.plans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlansTableAnnotationComposer(
            $db: $db,
            $table: $db.plans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> planExercisesRefs<T extends Object>(
    Expression<T> Function($$PlanExercisesTableAnnotationComposer a) f,
  ) {
    final $$PlanExercisesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.planExercises,
      getReferencedColumn: (t) => t.planDayId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlanExercisesTableAnnotationComposer(
            $db: $db,
            $table: $db.planExercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PlanDaysTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PlanDaysTable,
          PlanDayRow,
          $$PlanDaysTableFilterComposer,
          $$PlanDaysTableOrderingComposer,
          $$PlanDaysTableAnnotationComposer,
          $$PlanDaysTableCreateCompanionBuilder,
          $$PlanDaysTableUpdateCompanionBuilder,
          (PlanDayRow, $$PlanDaysTableReferences),
          PlanDayRow,
          PrefetchHooks Function({bool planId, bool planExercisesRefs})
        > {
  $$PlanDaysTableTableManager(_$AppDatabase db, $PlanDaysTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PlanDaysTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PlanDaysTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PlanDaysTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> planId = const Value.absent(),
                Value<int> orderIndex = const Value.absent(),
                Value<String?> focus = const Value.absent(),
                Value<bool> isRest = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<String?> remoteId = const Value.absent(),
              }) => PlanDaysCompanion(
                id: id,
                planId: planId,
                orderIndex: orderIndex,
                focus: focus,
                isRest: isRest,
                updatedAt: updatedAt,
                remoteId: remoteId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int planId,
                required int orderIndex,
                Value<String?> focus = const Value.absent(),
                Value<bool> isRest = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<String?> remoteId = const Value.absent(),
              }) => PlanDaysCompanion.insert(
                id: id,
                planId: planId,
                orderIndex: orderIndex,
                focus: focus,
                isRest: isRest,
                updatedAt: updatedAt,
                remoteId: remoteId,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PlanDaysTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({planId = false, planExercisesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (planExercisesRefs) db.planExercises,
              ],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (planId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.planId,
                                referencedTable: $$PlanDaysTableReferences
                                    ._planIdTable(db),
                                referencedColumn: $$PlanDaysTableReferences
                                    ._planIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (planExercisesRefs)
                    await $_getPrefetchedData<
                      PlanDayRow,
                      $PlanDaysTable,
                      PlanExerciseRow
                    >(
                      currentTable: table,
                      referencedTable: $$PlanDaysTableReferences
                          ._planExercisesRefsTable(db),
                      managerFromTypedResult: (p0) => $$PlanDaysTableReferences(
                        db,
                        table,
                        p0,
                      ).planExercisesRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.planDayId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$PlanDaysTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PlanDaysTable,
      PlanDayRow,
      $$PlanDaysTableFilterComposer,
      $$PlanDaysTableOrderingComposer,
      $$PlanDaysTableAnnotationComposer,
      $$PlanDaysTableCreateCompanionBuilder,
      $$PlanDaysTableUpdateCompanionBuilder,
      (PlanDayRow, $$PlanDaysTableReferences),
      PlanDayRow,
      PrefetchHooks Function({bool planId, bool planExercisesRefs})
    >;
typedef $$PlanExercisesTableCreateCompanionBuilder =
    PlanExercisesCompanion Function({
      Value<int> id,
      required int planDayId,
      required int orderIndex,
      required String name,
      Value<String?> equipment,
      Value<int?> targetSets,
      Value<String?> scheme,
      Value<String?> target,
      Value<DateTime?> updatedAt,
      Value<String?> remoteId,
    });
typedef $$PlanExercisesTableUpdateCompanionBuilder =
    PlanExercisesCompanion Function({
      Value<int> id,
      Value<int> planDayId,
      Value<int> orderIndex,
      Value<String> name,
      Value<String?> equipment,
      Value<int?> targetSets,
      Value<String?> scheme,
      Value<String?> target,
      Value<DateTime?> updatedAt,
      Value<String?> remoteId,
    });

final class $$PlanExercisesTableReferences
    extends
        BaseReferences<_$AppDatabase, $PlanExercisesTable, PlanExerciseRow> {
  $$PlanExercisesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $PlanDaysTable _planDayIdTable(_$AppDatabase db) =>
      db.planDays.createAlias('plan_exercises__plan_day_id__plan_days__id');

  $$PlanDaysTableProcessedTableManager get planDayId {
    final $_column = $_itemColumn<int>('plan_day_id')!;

    final manager = $$PlanDaysTableTableManager(
      $_db,
      $_db.planDays,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_planDayIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PlanExercisesTableFilterComposer
    extends Composer<_$AppDatabase, $PlanExercisesTable> {
  $$PlanExercisesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get orderIndex => $composableBuilder(
    column: $table.orderIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get equipment => $composableBuilder(
    column: $table.equipment,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get targetSets => $composableBuilder(
    column: $table.targetSets,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get scheme => $composableBuilder(
    column: $table.scheme,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get target => $composableBuilder(
    column: $table.target,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnFilters(column),
  );

  $$PlanDaysTableFilterComposer get planDayId {
    final $$PlanDaysTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.planDayId,
      referencedTable: $db.planDays,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlanDaysTableFilterComposer(
            $db: $db,
            $table: $db.planDays,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PlanExercisesTableOrderingComposer
    extends Composer<_$AppDatabase, $PlanExercisesTable> {
  $$PlanExercisesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get orderIndex => $composableBuilder(
    column: $table.orderIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get equipment => $composableBuilder(
    column: $table.equipment,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get targetSets => $composableBuilder(
    column: $table.targetSets,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get scheme => $composableBuilder(
    column: $table.scheme,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get target => $composableBuilder(
    column: $table.target,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnOrderings(column),
  );

  $$PlanDaysTableOrderingComposer get planDayId {
    final $$PlanDaysTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.planDayId,
      referencedTable: $db.planDays,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlanDaysTableOrderingComposer(
            $db: $db,
            $table: $db.planDays,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PlanExercisesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PlanExercisesTable> {
  $$PlanExercisesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get orderIndex => $composableBuilder(
    column: $table.orderIndex,
    builder: (column) => column,
  );

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get equipment =>
      $composableBuilder(column: $table.equipment, builder: (column) => column);

  GeneratedColumn<int> get targetSets => $composableBuilder(
    column: $table.targetSets,
    builder: (column) => column,
  );

  GeneratedColumn<String> get scheme =>
      $composableBuilder(column: $table.scheme, builder: (column) => column);

  GeneratedColumn<String> get target =>
      $composableBuilder(column: $table.target, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get remoteId =>
      $composableBuilder(column: $table.remoteId, builder: (column) => column);

  $$PlanDaysTableAnnotationComposer get planDayId {
    final $$PlanDaysTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.planDayId,
      referencedTable: $db.planDays,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlanDaysTableAnnotationComposer(
            $db: $db,
            $table: $db.planDays,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PlanExercisesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PlanExercisesTable,
          PlanExerciseRow,
          $$PlanExercisesTableFilterComposer,
          $$PlanExercisesTableOrderingComposer,
          $$PlanExercisesTableAnnotationComposer,
          $$PlanExercisesTableCreateCompanionBuilder,
          $$PlanExercisesTableUpdateCompanionBuilder,
          (PlanExerciseRow, $$PlanExercisesTableReferences),
          PlanExerciseRow,
          PrefetchHooks Function({bool planDayId})
        > {
  $$PlanExercisesTableTableManager(_$AppDatabase db, $PlanExercisesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PlanExercisesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PlanExercisesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PlanExercisesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> planDayId = const Value.absent(),
                Value<int> orderIndex = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> equipment = const Value.absent(),
                Value<int?> targetSets = const Value.absent(),
                Value<String?> scheme = const Value.absent(),
                Value<String?> target = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<String?> remoteId = const Value.absent(),
              }) => PlanExercisesCompanion(
                id: id,
                planDayId: planDayId,
                orderIndex: orderIndex,
                name: name,
                equipment: equipment,
                targetSets: targetSets,
                scheme: scheme,
                target: target,
                updatedAt: updatedAt,
                remoteId: remoteId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int planDayId,
                required int orderIndex,
                required String name,
                Value<String?> equipment = const Value.absent(),
                Value<int?> targetSets = const Value.absent(),
                Value<String?> scheme = const Value.absent(),
                Value<String?> target = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<String?> remoteId = const Value.absent(),
              }) => PlanExercisesCompanion.insert(
                id: id,
                planDayId: planDayId,
                orderIndex: orderIndex,
                name: name,
                equipment: equipment,
                targetSets: targetSets,
                scheme: scheme,
                target: target,
                updatedAt: updatedAt,
                remoteId: remoteId,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PlanExercisesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({planDayId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (planDayId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.planDayId,
                                referencedTable: $$PlanExercisesTableReferences
                                    ._planDayIdTable(db),
                                referencedColumn: $$PlanExercisesTableReferences
                                    ._planDayIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$PlanExercisesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PlanExercisesTable,
      PlanExerciseRow,
      $$PlanExercisesTableFilterComposer,
      $$PlanExercisesTableOrderingComposer,
      $$PlanExercisesTableAnnotationComposer,
      $$PlanExercisesTableCreateCompanionBuilder,
      $$PlanExercisesTableUpdateCompanionBuilder,
      (PlanExerciseRow, $$PlanExercisesTableReferences),
      PlanExerciseRow,
      PrefetchHooks Function({bool planDayId})
    >;
typedef $$SessionsTableCreateCompanionBuilder =
    SessionsCompanion Function({
      Value<int> id,
      Value<int?> planId,
      Value<int?> dayIndex,
      Value<String?> focus,
      required DateTime startedAt,
      Value<DateTime?> endedAt,
      Value<int?> durationSeconds,
      Value<String?> note,
      required DateTime updatedAt,
      Value<DateTime?> deletedAt,
      Value<String?> remoteId,
    });
typedef $$SessionsTableUpdateCompanionBuilder =
    SessionsCompanion Function({
      Value<int> id,
      Value<int?> planId,
      Value<int?> dayIndex,
      Value<String?> focus,
      Value<DateTime> startedAt,
      Value<DateTime?> endedAt,
      Value<int?> durationSeconds,
      Value<String?> note,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<String?> remoteId,
    });

final class $$SessionsTableReferences
    extends BaseReferences<_$AppDatabase, $SessionsTable, SessionRow> {
  $$SessionsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PlansTable _planIdTable(_$AppDatabase db) =>
      db.plans.createAlias('sessions__plan_id__plans__id');

  $$PlansTableProcessedTableManager? get planId {
    final $_column = $_itemColumn<int>('plan_id');
    if ($_column == null) return null;
    final manager = $$PlansTableTableManager(
      $_db,
      $_db.plans,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_planIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$SessionExercisesTable, List<SessionExerciseRow>>
  _sessionExercisesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.sessionExercises,
    aliasName: 'sessions__id__session_exercises__session_id',
  );

  $$SessionExercisesTableProcessedTableManager get sessionExercisesRefs {
    final manager = $$SessionExercisesTableTableManager(
      $_db,
      $_db.sessionExercises,
    ).filter((f) => f.sessionId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _sessionExercisesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$SessionsTableFilterComposer
    extends Composer<_$AppDatabase, $SessionsTable> {
  $$SessionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get dayIndex => $composableBuilder(
    column: $table.dayIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get focus => $composableBuilder(
    column: $table.focus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endedAt => $composableBuilder(
    column: $table.endedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durationSeconds => $composableBuilder(
    column: $table.durationSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnFilters(column),
  );

  $$PlansTableFilterComposer get planId {
    final $$PlansTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.planId,
      referencedTable: $db.plans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlansTableFilterComposer(
            $db: $db,
            $table: $db.plans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> sessionExercisesRefs(
    Expression<bool> Function($$SessionExercisesTableFilterComposer f) f,
  ) {
    final $$SessionExercisesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.sessionExercises,
      getReferencedColumn: (t) => t.sessionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SessionExercisesTableFilterComposer(
            $db: $db,
            $table: $db.sessionExercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SessionsTableOrderingComposer
    extends Composer<_$AppDatabase, $SessionsTable> {
  $$SessionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get dayIndex => $composableBuilder(
    column: $table.dayIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get focus => $composableBuilder(
    column: $table.focus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endedAt => $composableBuilder(
    column: $table.endedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationSeconds => $composableBuilder(
    column: $table.durationSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnOrderings(column),
  );

  $$PlansTableOrderingComposer get planId {
    final $$PlansTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.planId,
      referencedTable: $db.plans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlansTableOrderingComposer(
            $db: $db,
            $table: $db.plans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SessionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SessionsTable> {
  $$SessionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get dayIndex =>
      $composableBuilder(column: $table.dayIndex, builder: (column) => column);

  GeneratedColumn<String> get focus =>
      $composableBuilder(column: $table.focus, builder: (column) => column);

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get endedAt =>
      $composableBuilder(column: $table.endedAt, builder: (column) => column);

  GeneratedColumn<int> get durationSeconds => $composableBuilder(
    column: $table.durationSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get remoteId =>
      $composableBuilder(column: $table.remoteId, builder: (column) => column);

  $$PlansTableAnnotationComposer get planId {
    final $$PlansTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.planId,
      referencedTable: $db.plans,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlansTableAnnotationComposer(
            $db: $db,
            $table: $db.plans,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> sessionExercisesRefs<T extends Object>(
    Expression<T> Function($$SessionExercisesTableAnnotationComposer a) f,
  ) {
    final $$SessionExercisesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.sessionExercises,
      getReferencedColumn: (t) => t.sessionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SessionExercisesTableAnnotationComposer(
            $db: $db,
            $table: $db.sessionExercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SessionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SessionsTable,
          SessionRow,
          $$SessionsTableFilterComposer,
          $$SessionsTableOrderingComposer,
          $$SessionsTableAnnotationComposer,
          $$SessionsTableCreateCompanionBuilder,
          $$SessionsTableUpdateCompanionBuilder,
          (SessionRow, $$SessionsTableReferences),
          SessionRow,
          PrefetchHooks Function({bool planId, bool sessionExercisesRefs})
        > {
  $$SessionsTableTableManager(_$AppDatabase db, $SessionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SessionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SessionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SessionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> planId = const Value.absent(),
                Value<int?> dayIndex = const Value.absent(),
                Value<String?> focus = const Value.absent(),
                Value<DateTime> startedAt = const Value.absent(),
                Value<DateTime?> endedAt = const Value.absent(),
                Value<int?> durationSeconds = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String?> remoteId = const Value.absent(),
              }) => SessionsCompanion(
                id: id,
                planId: planId,
                dayIndex: dayIndex,
                focus: focus,
                startedAt: startedAt,
                endedAt: endedAt,
                durationSeconds: durationSeconds,
                note: note,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                remoteId: remoteId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> planId = const Value.absent(),
                Value<int?> dayIndex = const Value.absent(),
                Value<String?> focus = const Value.absent(),
                required DateTime startedAt,
                Value<DateTime?> endedAt = const Value.absent(),
                Value<int?> durationSeconds = const Value.absent(),
                Value<String?> note = const Value.absent(),
                required DateTime updatedAt,
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String?> remoteId = const Value.absent(),
              }) => SessionsCompanion.insert(
                id: id,
                planId: planId,
                dayIndex: dayIndex,
                focus: focus,
                startedAt: startedAt,
                endedAt: endedAt,
                durationSeconds: durationSeconds,
                note: note,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                remoteId: remoteId,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SessionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({planId = false, sessionExercisesRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (sessionExercisesRefs) db.sessionExercises,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (planId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.planId,
                                    referencedTable: $$SessionsTableReferences
                                        ._planIdTable(db),
                                    referencedColumn: $$SessionsTableReferences
                                        ._planIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (sessionExercisesRefs)
                        await $_getPrefetchedData<
                          SessionRow,
                          $SessionsTable,
                          SessionExerciseRow
                        >(
                          currentTable: table,
                          referencedTable: $$SessionsTableReferences
                              ._sessionExercisesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$SessionsTableReferences(
                                db,
                                table,
                                p0,
                              ).sessionExercisesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.sessionId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$SessionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SessionsTable,
      SessionRow,
      $$SessionsTableFilterComposer,
      $$SessionsTableOrderingComposer,
      $$SessionsTableAnnotationComposer,
      $$SessionsTableCreateCompanionBuilder,
      $$SessionsTableUpdateCompanionBuilder,
      (SessionRow, $$SessionsTableReferences),
      SessionRow,
      PrefetchHooks Function({bool planId, bool sessionExercisesRefs})
    >;
typedef $$SessionExercisesTableCreateCompanionBuilder =
    SessionExercisesCompanion Function({
      Value<int> id,
      required int sessionId,
      required int orderIndex,
      required String name,
      Value<EquipmentType?> equipment,
      Value<String?> exerciseNote,
      required Modality modality,
      Value<DateTime?> updatedAt,
      Value<String?> remoteId,
    });
typedef $$SessionExercisesTableUpdateCompanionBuilder =
    SessionExercisesCompanion Function({
      Value<int> id,
      Value<int> sessionId,
      Value<int> orderIndex,
      Value<String> name,
      Value<EquipmentType?> equipment,
      Value<String?> exerciseNote,
      Value<Modality> modality,
      Value<DateTime?> updatedAt,
      Value<String?> remoteId,
    });

final class $$SessionExercisesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $SessionExercisesTable,
          SessionExerciseRow
        > {
  $$SessionExercisesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $SessionsTable _sessionIdTable(_$AppDatabase db) =>
      db.sessions.createAlias('session_exercises__session_id__sessions__id');

  $$SessionsTableProcessedTableManager get sessionId {
    final $_column = $_itemColumn<int>('session_id')!;

    final manager = $$SessionsTableTableManager(
      $_db,
      $_db.sessions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sessionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$LoggedSetsTable, List<LoggedSetRow>>
  _loggedSetsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.loggedSets,
    aliasName: 'session_exercises__id__logged_sets__session_exercise_id',
  );

  $$LoggedSetsTableProcessedTableManager get loggedSetsRefs {
    final manager = $$LoggedSetsTableTableManager(
      $_db,
      $_db.loggedSets,
    ).filter((f) => f.sessionExerciseId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_loggedSetsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$SessionExercisesTableFilterComposer
    extends Composer<_$AppDatabase, $SessionExercisesTable> {
  $$SessionExercisesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get orderIndex => $composableBuilder(
    column: $table.orderIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<EquipmentType?, EquipmentType, String>
  get equipment => $composableBuilder(
    column: $table.equipment,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get exerciseNote => $composableBuilder(
    column: $table.exerciseNote,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<Modality, Modality, String> get modality =>
      $composableBuilder(
        column: $table.modality,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnFilters(column),
  );

  $$SessionsTableFilterComposer get sessionId {
    final $$SessionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.sessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SessionsTableFilterComposer(
            $db: $db,
            $table: $db.sessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> loggedSetsRefs(
    Expression<bool> Function($$LoggedSetsTableFilterComposer f) f,
  ) {
    final $$LoggedSetsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.loggedSets,
      getReferencedColumn: (t) => t.sessionExerciseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LoggedSetsTableFilterComposer(
            $db: $db,
            $table: $db.loggedSets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SessionExercisesTableOrderingComposer
    extends Composer<_$AppDatabase, $SessionExercisesTable> {
  $$SessionExercisesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get orderIndex => $composableBuilder(
    column: $table.orderIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get equipment => $composableBuilder(
    column: $table.equipment,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get exerciseNote => $composableBuilder(
    column: $table.exerciseNote,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get modality => $composableBuilder(
    column: $table.modality,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnOrderings(column),
  );

  $$SessionsTableOrderingComposer get sessionId {
    final $$SessionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.sessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SessionsTableOrderingComposer(
            $db: $db,
            $table: $db.sessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SessionExercisesTableAnnotationComposer
    extends Composer<_$AppDatabase, $SessionExercisesTable> {
  $$SessionExercisesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get orderIndex => $composableBuilder(
    column: $table.orderIndex,
    builder: (column) => column,
  );

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumnWithTypeConverter<EquipmentType?, String> get equipment =>
      $composableBuilder(column: $table.equipment, builder: (column) => column);

  GeneratedColumn<String> get exerciseNote => $composableBuilder(
    column: $table.exerciseNote,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<Modality, String> get modality =>
      $composableBuilder(column: $table.modality, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get remoteId =>
      $composableBuilder(column: $table.remoteId, builder: (column) => column);

  $$SessionsTableAnnotationComposer get sessionId {
    final $$SessionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.sessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SessionsTableAnnotationComposer(
            $db: $db,
            $table: $db.sessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> loggedSetsRefs<T extends Object>(
    Expression<T> Function($$LoggedSetsTableAnnotationComposer a) f,
  ) {
    final $$LoggedSetsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.loggedSets,
      getReferencedColumn: (t) => t.sessionExerciseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LoggedSetsTableAnnotationComposer(
            $db: $db,
            $table: $db.loggedSets,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SessionExercisesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SessionExercisesTable,
          SessionExerciseRow,
          $$SessionExercisesTableFilterComposer,
          $$SessionExercisesTableOrderingComposer,
          $$SessionExercisesTableAnnotationComposer,
          $$SessionExercisesTableCreateCompanionBuilder,
          $$SessionExercisesTableUpdateCompanionBuilder,
          (SessionExerciseRow, $$SessionExercisesTableReferences),
          SessionExerciseRow,
          PrefetchHooks Function({bool sessionId, bool loggedSetsRefs})
        > {
  $$SessionExercisesTableTableManager(
    _$AppDatabase db,
    $SessionExercisesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SessionExercisesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SessionExercisesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SessionExercisesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> sessionId = const Value.absent(),
                Value<int> orderIndex = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<EquipmentType?> equipment = const Value.absent(),
                Value<String?> exerciseNote = const Value.absent(),
                Value<Modality> modality = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<String?> remoteId = const Value.absent(),
              }) => SessionExercisesCompanion(
                id: id,
                sessionId: sessionId,
                orderIndex: orderIndex,
                name: name,
                equipment: equipment,
                exerciseNote: exerciseNote,
                modality: modality,
                updatedAt: updatedAt,
                remoteId: remoteId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int sessionId,
                required int orderIndex,
                required String name,
                Value<EquipmentType?> equipment = const Value.absent(),
                Value<String?> exerciseNote = const Value.absent(),
                required Modality modality,
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<String?> remoteId = const Value.absent(),
              }) => SessionExercisesCompanion.insert(
                id: id,
                sessionId: sessionId,
                orderIndex: orderIndex,
                name: name,
                equipment: equipment,
                exerciseNote: exerciseNote,
                modality: modality,
                updatedAt: updatedAt,
                remoteId: remoteId,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SessionExercisesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({sessionId = false, loggedSetsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (loggedSetsRefs) db.loggedSets],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (sessionId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.sessionId,
                                referencedTable:
                                    $$SessionExercisesTableReferences
                                        ._sessionIdTable(db),
                                referencedColumn:
                                    $$SessionExercisesTableReferences
                                        ._sessionIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (loggedSetsRefs)
                    await $_getPrefetchedData<
                      SessionExerciseRow,
                      $SessionExercisesTable,
                      LoggedSetRow
                    >(
                      currentTable: table,
                      referencedTable: $$SessionExercisesTableReferences
                          ._loggedSetsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$SessionExercisesTableReferences(
                            db,
                            table,
                            p0,
                          ).loggedSetsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.sessionExerciseId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$SessionExercisesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SessionExercisesTable,
      SessionExerciseRow,
      $$SessionExercisesTableFilterComposer,
      $$SessionExercisesTableOrderingComposer,
      $$SessionExercisesTableAnnotationComposer,
      $$SessionExercisesTableCreateCompanionBuilder,
      $$SessionExercisesTableUpdateCompanionBuilder,
      (SessionExerciseRow, $$SessionExercisesTableReferences),
      SessionExerciseRow,
      PrefetchHooks Function({bool sessionId, bool loggedSetsRefs})
    >;
typedef $$LoggedSetsTableCreateCompanionBuilder =
    LoggedSetsCompanion Function({
      Value<int> id,
      required int sessionExerciseId,
      required int orderIndex,
      required Modality modality,
      required Map<String, double> metrics,
      Value<bool> isDone,
      required DateTime createdAt,
      Value<DateTime?> updatedAt,
      Value<String?> remoteId,
    });
typedef $$LoggedSetsTableUpdateCompanionBuilder =
    LoggedSetsCompanion Function({
      Value<int> id,
      Value<int> sessionExerciseId,
      Value<int> orderIndex,
      Value<Modality> modality,
      Value<Map<String, double>> metrics,
      Value<bool> isDone,
      Value<DateTime> createdAt,
      Value<DateTime?> updatedAt,
      Value<String?> remoteId,
    });

final class $$LoggedSetsTableReferences
    extends BaseReferences<_$AppDatabase, $LoggedSetsTable, LoggedSetRow> {
  $$LoggedSetsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $SessionExercisesTable _sessionExerciseIdTable(_$AppDatabase db) => db
      .sessionExercises
      .createAlias('logged_sets__session_exercise_id__session_exercises__id');

  $$SessionExercisesTableProcessedTableManager get sessionExerciseId {
    final $_column = $_itemColumn<int>('session_exercise_id')!;

    final manager = $$SessionExercisesTableTableManager(
      $_db,
      $_db.sessionExercises,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sessionExerciseIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$LoggedSetsTableFilterComposer
    extends Composer<_$AppDatabase, $LoggedSetsTable> {
  $$LoggedSetsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get orderIndex => $composableBuilder(
    column: $table.orderIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<Modality, Modality, String> get modality =>
      $composableBuilder(
        column: $table.modality,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<
    Map<String, double>,
    Map<String, double>,
    String
  >
  get metrics => $composableBuilder(
    column: $table.metrics,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<bool> get isDone => $composableBuilder(
    column: $table.isDone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnFilters(column),
  );

  $$SessionExercisesTableFilterComposer get sessionExerciseId {
    final $$SessionExercisesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionExerciseId,
      referencedTable: $db.sessionExercises,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SessionExercisesTableFilterComposer(
            $db: $db,
            $table: $db.sessionExercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LoggedSetsTableOrderingComposer
    extends Composer<_$AppDatabase, $LoggedSetsTable> {
  $$LoggedSetsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get orderIndex => $composableBuilder(
    column: $table.orderIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get modality => $composableBuilder(
    column: $table.modality,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get metrics => $composableBuilder(
    column: $table.metrics,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDone => $composableBuilder(
    column: $table.isDone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnOrderings(column),
  );

  $$SessionExercisesTableOrderingComposer get sessionExerciseId {
    final $$SessionExercisesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionExerciseId,
      referencedTable: $db.sessionExercises,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SessionExercisesTableOrderingComposer(
            $db: $db,
            $table: $db.sessionExercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LoggedSetsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LoggedSetsTable> {
  $$LoggedSetsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get orderIndex => $composableBuilder(
    column: $table.orderIndex,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<Modality, String> get modality =>
      $composableBuilder(column: $table.modality, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Map<String, double>, String> get metrics =>
      $composableBuilder(column: $table.metrics, builder: (column) => column);

  GeneratedColumn<bool> get isDone =>
      $composableBuilder(column: $table.isDone, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get remoteId =>
      $composableBuilder(column: $table.remoteId, builder: (column) => column);

  $$SessionExercisesTableAnnotationComposer get sessionExerciseId {
    final $$SessionExercisesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionExerciseId,
      referencedTable: $db.sessionExercises,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SessionExercisesTableAnnotationComposer(
            $db: $db,
            $table: $db.sessionExercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LoggedSetsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LoggedSetsTable,
          LoggedSetRow,
          $$LoggedSetsTableFilterComposer,
          $$LoggedSetsTableOrderingComposer,
          $$LoggedSetsTableAnnotationComposer,
          $$LoggedSetsTableCreateCompanionBuilder,
          $$LoggedSetsTableUpdateCompanionBuilder,
          (LoggedSetRow, $$LoggedSetsTableReferences),
          LoggedSetRow,
          PrefetchHooks Function({bool sessionExerciseId})
        > {
  $$LoggedSetsTableTableManager(_$AppDatabase db, $LoggedSetsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LoggedSetsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LoggedSetsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LoggedSetsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> sessionExerciseId = const Value.absent(),
                Value<int> orderIndex = const Value.absent(),
                Value<Modality> modality = const Value.absent(),
                Value<Map<String, double>> metrics = const Value.absent(),
                Value<bool> isDone = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<String?> remoteId = const Value.absent(),
              }) => LoggedSetsCompanion(
                id: id,
                sessionExerciseId: sessionExerciseId,
                orderIndex: orderIndex,
                modality: modality,
                metrics: metrics,
                isDone: isDone,
                createdAt: createdAt,
                updatedAt: updatedAt,
                remoteId: remoteId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int sessionExerciseId,
                required int orderIndex,
                required Modality modality,
                required Map<String, double> metrics,
                Value<bool> isDone = const Value.absent(),
                required DateTime createdAt,
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<String?> remoteId = const Value.absent(),
              }) => LoggedSetsCompanion.insert(
                id: id,
                sessionExerciseId: sessionExerciseId,
                orderIndex: orderIndex,
                modality: modality,
                metrics: metrics,
                isDone: isDone,
                createdAt: createdAt,
                updatedAt: updatedAt,
                remoteId: remoteId,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$LoggedSetsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({sessionExerciseId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (sessionExerciseId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.sessionExerciseId,
                                referencedTable: $$LoggedSetsTableReferences
                                    ._sessionExerciseIdTable(db),
                                referencedColumn: $$LoggedSetsTableReferences
                                    ._sessionExerciseIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$LoggedSetsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LoggedSetsTable,
      LoggedSetRow,
      $$LoggedSetsTableFilterComposer,
      $$LoggedSetsTableOrderingComposer,
      $$LoggedSetsTableAnnotationComposer,
      $$LoggedSetsTableCreateCompanionBuilder,
      $$LoggedSetsTableUpdateCompanionBuilder,
      (LoggedSetRow, $$LoggedSetsTableReferences),
      LoggedSetRow,
      PrefetchHooks Function({bool sessionExerciseId})
    >;
typedef $$ExercisesTableCreateCompanionBuilder =
    ExercisesCompanion Function({
      Value<int> id,
      required String name,
      required Modality modality,
      Value<String?> muscleGroup,
      Value<String?> equipment,
      Value<bool> isCustom,
      Value<DateTime> createdAt,
    });
typedef $$ExercisesTableUpdateCompanionBuilder =
    ExercisesCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<Modality> modality,
      Value<String?> muscleGroup,
      Value<String?> equipment,
      Value<bool> isCustom,
      Value<DateTime> createdAt,
    });

class $$ExercisesTableFilterComposer
    extends Composer<_$AppDatabase, $ExercisesTable> {
  $$ExercisesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<Modality, Modality, String> get modality =>
      $composableBuilder(
        column: $table.modality,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get muscleGroup => $composableBuilder(
    column: $table.muscleGroup,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get equipment => $composableBuilder(
    column: $table.equipment,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isCustom => $composableBuilder(
    column: $table.isCustom,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ExercisesTableOrderingComposer
    extends Composer<_$AppDatabase, $ExercisesTable> {
  $$ExercisesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get modality => $composableBuilder(
    column: $table.modality,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get muscleGroup => $composableBuilder(
    column: $table.muscleGroup,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get equipment => $composableBuilder(
    column: $table.equipment,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isCustom => $composableBuilder(
    column: $table.isCustom,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ExercisesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExercisesTable> {
  $$ExercisesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Modality, String> get modality =>
      $composableBuilder(column: $table.modality, builder: (column) => column);

  GeneratedColumn<String> get muscleGroup => $composableBuilder(
    column: $table.muscleGroup,
    builder: (column) => column,
  );

  GeneratedColumn<String> get equipment =>
      $composableBuilder(column: $table.equipment, builder: (column) => column);

  GeneratedColumn<bool> get isCustom =>
      $composableBuilder(column: $table.isCustom, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$ExercisesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ExercisesTable,
          ExerciseRow,
          $$ExercisesTableFilterComposer,
          $$ExercisesTableOrderingComposer,
          $$ExercisesTableAnnotationComposer,
          $$ExercisesTableCreateCompanionBuilder,
          $$ExercisesTableUpdateCompanionBuilder,
          (
            ExerciseRow,
            BaseReferences<_$AppDatabase, $ExercisesTable, ExerciseRow>,
          ),
          ExerciseRow,
          PrefetchHooks Function()
        > {
  $$ExercisesTableTableManager(_$AppDatabase db, $ExercisesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExercisesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExercisesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExercisesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<Modality> modality = const Value.absent(),
                Value<String?> muscleGroup = const Value.absent(),
                Value<String?> equipment = const Value.absent(),
                Value<bool> isCustom = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => ExercisesCompanion(
                id: id,
                name: name,
                modality: modality,
                muscleGroup: muscleGroup,
                equipment: equipment,
                isCustom: isCustom,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required Modality modality,
                Value<String?> muscleGroup = const Value.absent(),
                Value<String?> equipment = const Value.absent(),
                Value<bool> isCustom = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => ExercisesCompanion.insert(
                id: id,
                name: name,
                modality: modality,
                muscleGroup: muscleGroup,
                equipment: equipment,
                isCustom: isCustom,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ExercisesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ExercisesTable,
      ExerciseRow,
      $$ExercisesTableFilterComposer,
      $$ExercisesTableOrderingComposer,
      $$ExercisesTableAnnotationComposer,
      $$ExercisesTableCreateCompanionBuilder,
      $$ExercisesTableUpdateCompanionBuilder,
      (
        ExerciseRow,
        BaseReferences<_$AppDatabase, $ExercisesTable, ExerciseRow>,
      ),
      ExerciseRow,
      PrefetchHooks Function()
    >;
typedef $$WeightEntriesTableCreateCompanionBuilder =
    WeightEntriesCompanion Function({
      Value<int> id,
      required double weightKg,
      Value<String?> note,
      required DateTime recordedAt,
    });
typedef $$WeightEntriesTableUpdateCompanionBuilder =
    WeightEntriesCompanion Function({
      Value<int> id,
      Value<double> weightKg,
      Value<String?> note,
      Value<DateTime> recordedAt,
    });

class $$WeightEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $WeightEntriesTable> {
  $$WeightEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get weightKg => $composableBuilder(
    column: $table.weightKg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get recordedAt => $composableBuilder(
    column: $table.recordedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$WeightEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $WeightEntriesTable> {
  $$WeightEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get weightKg => $composableBuilder(
    column: $table.weightKg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get recordedAt => $composableBuilder(
    column: $table.recordedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$WeightEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $WeightEntriesTable> {
  $$WeightEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get weightKg =>
      $composableBuilder(column: $table.weightKg, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<DateTime> get recordedAt => $composableBuilder(
    column: $table.recordedAt,
    builder: (column) => column,
  );
}

class $$WeightEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WeightEntriesTable,
          WeightEntryRow,
          $$WeightEntriesTableFilterComposer,
          $$WeightEntriesTableOrderingComposer,
          $$WeightEntriesTableAnnotationComposer,
          $$WeightEntriesTableCreateCompanionBuilder,
          $$WeightEntriesTableUpdateCompanionBuilder,
          (
            WeightEntryRow,
            BaseReferences<_$AppDatabase, $WeightEntriesTable, WeightEntryRow>,
          ),
          WeightEntryRow,
          PrefetchHooks Function()
        > {
  $$WeightEntriesTableTableManager(_$AppDatabase db, $WeightEntriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WeightEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WeightEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WeightEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<double> weightKg = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<DateTime> recordedAt = const Value.absent(),
              }) => WeightEntriesCompanion(
                id: id,
                weightKg: weightKg,
                note: note,
                recordedAt: recordedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required double weightKg,
                Value<String?> note = const Value.absent(),
                required DateTime recordedAt,
              }) => WeightEntriesCompanion.insert(
                id: id,
                weightKg: weightKg,
                note: note,
                recordedAt: recordedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$WeightEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WeightEntriesTable,
      WeightEntryRow,
      $$WeightEntriesTableFilterComposer,
      $$WeightEntriesTableOrderingComposer,
      $$WeightEntriesTableAnnotationComposer,
      $$WeightEntriesTableCreateCompanionBuilder,
      $$WeightEntriesTableUpdateCompanionBuilder,
      (
        WeightEntryRow,
        BaseReferences<_$AppDatabase, $WeightEntriesTable, WeightEntryRow>,
      ),
      WeightEntryRow,
      PrefetchHooks Function()
    >;
typedef $$GoalsTableCreateCompanionBuilder =
    GoalsCompanion Function({
      Value<int> id,
      required GoalType type,
      required double targetValue,
      required DateTime deadline,
      required DateTime createdAt,
      Value<double?> startValue,
      Value<String?> exerciseName,
      Value<bool> isActive,
    });
typedef $$GoalsTableUpdateCompanionBuilder =
    GoalsCompanion Function({
      Value<int> id,
      Value<GoalType> type,
      Value<double> targetValue,
      Value<DateTime> deadline,
      Value<DateTime> createdAt,
      Value<double?> startValue,
      Value<String?> exerciseName,
      Value<bool> isActive,
    });

class $$GoalsTableFilterComposer extends Composer<_$AppDatabase, $GoalsTable> {
  $$GoalsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<GoalType, GoalType, String> get type =>
      $composableBuilder(
        column: $table.type,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<double> get targetValue => $composableBuilder(
    column: $table.targetValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deadline => $composableBuilder(
    column: $table.deadline,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get startValue => $composableBuilder(
    column: $table.startValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get exerciseName => $composableBuilder(
    column: $table.exerciseName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );
}

class $$GoalsTableOrderingComposer
    extends Composer<_$AppDatabase, $GoalsTable> {
  $$GoalsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get targetValue => $composableBuilder(
    column: $table.targetValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deadline => $composableBuilder(
    column: $table.deadline,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get startValue => $composableBuilder(
    column: $table.startValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get exerciseName => $composableBuilder(
    column: $table.exerciseName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$GoalsTableAnnotationComposer
    extends Composer<_$AppDatabase, $GoalsTable> {
  $$GoalsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<GoalType, String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<double> get targetValue => $composableBuilder(
    column: $table.targetValue,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get deadline =>
      $composableBuilder(column: $table.deadline, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<double> get startValue => $composableBuilder(
    column: $table.startValue,
    builder: (column) => column,
  );

  GeneratedColumn<String> get exerciseName => $composableBuilder(
    column: $table.exerciseName,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);
}

class $$GoalsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GoalsTable,
          GoalRow,
          $$GoalsTableFilterComposer,
          $$GoalsTableOrderingComposer,
          $$GoalsTableAnnotationComposer,
          $$GoalsTableCreateCompanionBuilder,
          $$GoalsTableUpdateCompanionBuilder,
          (GoalRow, BaseReferences<_$AppDatabase, $GoalsTable, GoalRow>),
          GoalRow,
          PrefetchHooks Function()
        > {
  $$GoalsTableTableManager(_$AppDatabase db, $GoalsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GoalsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GoalsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GoalsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<GoalType> type = const Value.absent(),
                Value<double> targetValue = const Value.absent(),
                Value<DateTime> deadline = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<double?> startValue = const Value.absent(),
                Value<String?> exerciseName = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
              }) => GoalsCompanion(
                id: id,
                type: type,
                targetValue: targetValue,
                deadline: deadline,
                createdAt: createdAt,
                startValue: startValue,
                exerciseName: exerciseName,
                isActive: isActive,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required GoalType type,
                required double targetValue,
                required DateTime deadline,
                required DateTime createdAt,
                Value<double?> startValue = const Value.absent(),
                Value<String?> exerciseName = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
              }) => GoalsCompanion.insert(
                id: id,
                type: type,
                targetValue: targetValue,
                deadline: deadline,
                createdAt: createdAt,
                startValue: startValue,
                exerciseName: exerciseName,
                isActive: isActive,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$GoalsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GoalsTable,
      GoalRow,
      $$GoalsTableFilterComposer,
      $$GoalsTableOrderingComposer,
      $$GoalsTableAnnotationComposer,
      $$GoalsTableCreateCompanionBuilder,
      $$GoalsTableUpdateCompanionBuilder,
      (GoalRow, BaseReferences<_$AppDatabase, $GoalsTable, GoalRow>),
      GoalRow,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$PlansTableTableManager get plans =>
      $$PlansTableTableManager(_db, _db.plans);
  $$PlanDaysTableTableManager get planDays =>
      $$PlanDaysTableTableManager(_db, _db.planDays);
  $$PlanExercisesTableTableManager get planExercises =>
      $$PlanExercisesTableTableManager(_db, _db.planExercises);
  $$SessionsTableTableManager get sessions =>
      $$SessionsTableTableManager(_db, _db.sessions);
  $$SessionExercisesTableTableManager get sessionExercises =>
      $$SessionExercisesTableTableManager(_db, _db.sessionExercises);
  $$LoggedSetsTableTableManager get loggedSets =>
      $$LoggedSetsTableTableManager(_db, _db.loggedSets);
  $$ExercisesTableTableManager get exercises =>
      $$ExercisesTableTableManager(_db, _db.exercises);
  $$WeightEntriesTableTableManager get weightEntries =>
      $$WeightEntriesTableTableManager(_db, _db.weightEntries);
  $$GoalsTableTableManager get goals =>
      $$GoalsTableTableManager(_db, _db.goals);
}
