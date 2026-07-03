// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $LasLogDataTable extends LasLogData
    with TableInfo<$LasLogDataTable, LasLogDataData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LasLogDataTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _wellNameMeta = const VerificationMeta(
    'wellName',
  );
  @override
  late final GeneratedColumn<String> wellName = GeneratedColumn<String>(
    'well_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mnemonicMeta = const VerificationMeta(
    'mnemonic',
  );
  @override
  late final GeneratedColumn<String> mnemonic = GeneratedColumn<String>(
    'mnemonic',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitMeta = const VerificationMeta('unit');
  @override
  late final GeneratedColumn<String> unit = GeneratedColumn<String>(
    'unit',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dataJsonMeta = const VerificationMeta(
    'dataJson',
  );
  @override
  late final GeneratedColumn<String> dataJson = GeneratedColumn<String>(
    'data_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    wellName,
    mnemonic,
    unit,
    description,
    dataJson,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'las_log_data';
  @override
  VerificationContext validateIntegrity(
    Insertable<LasLogDataData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('well_name')) {
      context.handle(
        _wellNameMeta,
        wellName.isAcceptableOrUnknown(data['well_name']!, _wellNameMeta),
      );
    } else if (isInserting) {
      context.missing(_wellNameMeta);
    }
    if (data.containsKey('mnemonic')) {
      context.handle(
        _mnemonicMeta,
        mnemonic.isAcceptableOrUnknown(data['mnemonic']!, _mnemonicMeta),
      );
    } else if (isInserting) {
      context.missing(_mnemonicMeta);
    }
    if (data.containsKey('unit')) {
      context.handle(
        _unitMeta,
        unit.isAcceptableOrUnknown(data['unit']!, _unitMeta),
      );
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('data_json')) {
      context.handle(
        _dataJsonMeta,
        dataJson.isAcceptableOrUnknown(data['data_json']!, _dataJsonMeta),
      );
    } else if (isInserting) {
      context.missing(_dataJsonMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LasLogDataData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LasLogDataData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      wellName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}well_name'],
      )!,
      mnemonic: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mnemonic'],
      )!,
      unit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unit'],
      ),
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      dataJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}data_json'],
      )!,
    );
  }

  @override
  $LasLogDataTable createAlias(String alias) {
    return $LasLogDataTable(attachedDatabase, alias);
  }
}

class LasLogDataData extends DataClass implements Insertable<LasLogDataData> {
  final int id;
  final String wellName;
  final String mnemonic;
  final String? unit;
  final String? description;
  final String dataJson;
  const LasLogDataData({
    required this.id,
    required this.wellName,
    required this.mnemonic,
    this.unit,
    this.description,
    required this.dataJson,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['well_name'] = Variable<String>(wellName);
    map['mnemonic'] = Variable<String>(mnemonic);
    if (!nullToAbsent || unit != null) {
      map['unit'] = Variable<String>(unit);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['data_json'] = Variable<String>(dataJson);
    return map;
  }

  LasLogDataCompanion toCompanion(bool nullToAbsent) {
    return LasLogDataCompanion(
      id: Value(id),
      wellName: Value(wellName),
      mnemonic: Value(mnemonic),
      unit: unit == null && nullToAbsent ? const Value.absent() : Value(unit),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      dataJson: Value(dataJson),
    );
  }

  factory LasLogDataData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LasLogDataData(
      id: serializer.fromJson<int>(json['id']),
      wellName: serializer.fromJson<String>(json['wellName']),
      mnemonic: serializer.fromJson<String>(json['mnemonic']),
      unit: serializer.fromJson<String?>(json['unit']),
      description: serializer.fromJson<String?>(json['description']),
      dataJson: serializer.fromJson<String>(json['dataJson']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'wellName': serializer.toJson<String>(wellName),
      'mnemonic': serializer.toJson<String>(mnemonic),
      'unit': serializer.toJson<String?>(unit),
      'description': serializer.toJson<String?>(description),
      'dataJson': serializer.toJson<String>(dataJson),
    };
  }

  LasLogDataData copyWith({
    int? id,
    String? wellName,
    String? mnemonic,
    Value<String?> unit = const Value.absent(),
    Value<String?> description = const Value.absent(),
    String? dataJson,
  }) => LasLogDataData(
    id: id ?? this.id,
    wellName: wellName ?? this.wellName,
    mnemonic: mnemonic ?? this.mnemonic,
    unit: unit.present ? unit.value : this.unit,
    description: description.present ? description.value : this.description,
    dataJson: dataJson ?? this.dataJson,
  );
  LasLogDataData copyWithCompanion(LasLogDataCompanion data) {
    return LasLogDataData(
      id: data.id.present ? data.id.value : this.id,
      wellName: data.wellName.present ? data.wellName.value : this.wellName,
      mnemonic: data.mnemonic.present ? data.mnemonic.value : this.mnemonic,
      unit: data.unit.present ? data.unit.value : this.unit,
      description: data.description.present
          ? data.description.value
          : this.description,
      dataJson: data.dataJson.present ? data.dataJson.value : this.dataJson,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LasLogDataData(')
          ..write('id: $id, ')
          ..write('wellName: $wellName, ')
          ..write('mnemonic: $mnemonic, ')
          ..write('unit: $unit, ')
          ..write('description: $description, ')
          ..write('dataJson: $dataJson')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, wellName, mnemonic, unit, description, dataJson);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LasLogDataData &&
          other.id == this.id &&
          other.wellName == this.wellName &&
          other.mnemonic == this.mnemonic &&
          other.unit == this.unit &&
          other.description == this.description &&
          other.dataJson == this.dataJson);
}

class LasLogDataCompanion extends UpdateCompanion<LasLogDataData> {
  final Value<int> id;
  final Value<String> wellName;
  final Value<String> mnemonic;
  final Value<String?> unit;
  final Value<String?> description;
  final Value<String> dataJson;
  const LasLogDataCompanion({
    this.id = const Value.absent(),
    this.wellName = const Value.absent(),
    this.mnemonic = const Value.absent(),
    this.unit = const Value.absent(),
    this.description = const Value.absent(),
    this.dataJson = const Value.absent(),
  });
  LasLogDataCompanion.insert({
    this.id = const Value.absent(),
    required String wellName,
    required String mnemonic,
    this.unit = const Value.absent(),
    this.description = const Value.absent(),
    required String dataJson,
  }) : wellName = Value(wellName),
       mnemonic = Value(mnemonic),
       dataJson = Value(dataJson);
  static Insertable<LasLogDataData> custom({
    Expression<int>? id,
    Expression<String>? wellName,
    Expression<String>? mnemonic,
    Expression<String>? unit,
    Expression<String>? description,
    Expression<String>? dataJson,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (wellName != null) 'well_name': wellName,
      if (mnemonic != null) 'mnemonic': mnemonic,
      if (unit != null) 'unit': unit,
      if (description != null) 'description': description,
      if (dataJson != null) 'data_json': dataJson,
    });
  }

  LasLogDataCompanion copyWith({
    Value<int>? id,
    Value<String>? wellName,
    Value<String>? mnemonic,
    Value<String?>? unit,
    Value<String?>? description,
    Value<String>? dataJson,
  }) {
    return LasLogDataCompanion(
      id: id ?? this.id,
      wellName: wellName ?? this.wellName,
      mnemonic: mnemonic ?? this.mnemonic,
      unit: unit ?? this.unit,
      description: description ?? this.description,
      dataJson: dataJson ?? this.dataJson,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (wellName.present) {
      map['well_name'] = Variable<String>(wellName.value);
    }
    if (mnemonic.present) {
      map['mnemonic'] = Variable<String>(mnemonic.value);
    }
    if (unit.present) {
      map['unit'] = Variable<String>(unit.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (dataJson.present) {
      map['data_json'] = Variable<String>(dataJson.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LasLogDataCompanion(')
          ..write('id: $id, ')
          ..write('wellName: $wellName, ')
          ..write('mnemonic: $mnemonic, ')
          ..write('unit: $unit, ')
          ..write('description: $description, ')
          ..write('dataJson: $dataJson')
          ..write(')'))
        .toString();
  }
}

class $PetrophysicalParametersTable extends PetrophysicalParameters
    with TableInfo<$PetrophysicalParametersTable, PetrophysicalParameter> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PetrophysicalParametersTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _wellNameMeta = const VerificationMeta(
    'wellName',
  );
  @override
  late final GeneratedColumn<String> wellName = GeneratedColumn<String>(
    'well_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _aMeta = const VerificationMeta('a');
  @override
  late final GeneratedColumn<double> a = GeneratedColumn<double>(
    'a',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(1.0),
  );
  static const VerificationMeta _mMeta = const VerificationMeta('m');
  @override
  late final GeneratedColumn<double> m = GeneratedColumn<double>(
    'm',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(2.0),
  );
  static const VerificationMeta _nMeta = const VerificationMeta('n');
  @override
  late final GeneratedColumn<double> n = GeneratedColumn<double>(
    'n',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(2.0),
  );
  @override
  List<GeneratedColumn> get $columns => [id, wellName, a, m, n];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'petrophysical_parameters';
  @override
  VerificationContext validateIntegrity(
    Insertable<PetrophysicalParameter> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('well_name')) {
      context.handle(
        _wellNameMeta,
        wellName.isAcceptableOrUnknown(data['well_name']!, _wellNameMeta),
      );
    } else if (isInserting) {
      context.missing(_wellNameMeta);
    }
    if (data.containsKey('a')) {
      context.handle(_aMeta, a.isAcceptableOrUnknown(data['a']!, _aMeta));
    }
    if (data.containsKey('m')) {
      context.handle(_mMeta, m.isAcceptableOrUnknown(data['m']!, _mMeta));
    }
    if (data.containsKey('n')) {
      context.handle(_nMeta, n.isAcceptableOrUnknown(data['n']!, _nMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PetrophysicalParameter map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PetrophysicalParameter(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      wellName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}well_name'],
      )!,
      a: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}a'],
      )!,
      m: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}m'],
      )!,
      n: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}n'],
      )!,
    );
  }

  @override
  $PetrophysicalParametersTable createAlias(String alias) {
    return $PetrophysicalParametersTable(attachedDatabase, alias);
  }
}

class PetrophysicalParameter extends DataClass
    implements Insertable<PetrophysicalParameter> {
  final int id;
  final String wellName;
  final double a;
  final double m;
  final double n;
  const PetrophysicalParameter({
    required this.id,
    required this.wellName,
    required this.a,
    required this.m,
    required this.n,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['well_name'] = Variable<String>(wellName);
    map['a'] = Variable<double>(a);
    map['m'] = Variable<double>(m);
    map['n'] = Variable<double>(n);
    return map;
  }

  PetrophysicalParametersCompanion toCompanion(bool nullToAbsent) {
    return PetrophysicalParametersCompanion(
      id: Value(id),
      wellName: Value(wellName),
      a: Value(a),
      m: Value(m),
      n: Value(n),
    );
  }

  factory PetrophysicalParameter.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PetrophysicalParameter(
      id: serializer.fromJson<int>(json['id']),
      wellName: serializer.fromJson<String>(json['wellName']),
      a: serializer.fromJson<double>(json['a']),
      m: serializer.fromJson<double>(json['m']),
      n: serializer.fromJson<double>(json['n']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'wellName': serializer.toJson<String>(wellName),
      'a': serializer.toJson<double>(a),
      'm': serializer.toJson<double>(m),
      'n': serializer.toJson<double>(n),
    };
  }

  PetrophysicalParameter copyWith({
    int? id,
    String? wellName,
    double? a,
    double? m,
    double? n,
  }) => PetrophysicalParameter(
    id: id ?? this.id,
    wellName: wellName ?? this.wellName,
    a: a ?? this.a,
    m: m ?? this.m,
    n: n ?? this.n,
  );
  PetrophysicalParameter copyWithCompanion(
    PetrophysicalParametersCompanion data,
  ) {
    return PetrophysicalParameter(
      id: data.id.present ? data.id.value : this.id,
      wellName: data.wellName.present ? data.wellName.value : this.wellName,
      a: data.a.present ? data.a.value : this.a,
      m: data.m.present ? data.m.value : this.m,
      n: data.n.present ? data.n.value : this.n,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PetrophysicalParameter(')
          ..write('id: $id, ')
          ..write('wellName: $wellName, ')
          ..write('a: $a, ')
          ..write('m: $m, ')
          ..write('n: $n')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, wellName, a, m, n);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PetrophysicalParameter &&
          other.id == this.id &&
          other.wellName == this.wellName &&
          other.a == this.a &&
          other.m == this.m &&
          other.n == this.n);
}

class PetrophysicalParametersCompanion
    extends UpdateCompanion<PetrophysicalParameter> {
  final Value<int> id;
  final Value<String> wellName;
  final Value<double> a;
  final Value<double> m;
  final Value<double> n;
  const PetrophysicalParametersCompanion({
    this.id = const Value.absent(),
    this.wellName = const Value.absent(),
    this.a = const Value.absent(),
    this.m = const Value.absent(),
    this.n = const Value.absent(),
  });
  PetrophysicalParametersCompanion.insert({
    this.id = const Value.absent(),
    required String wellName,
    this.a = const Value.absent(),
    this.m = const Value.absent(),
    this.n = const Value.absent(),
  }) : wellName = Value(wellName);
  static Insertable<PetrophysicalParameter> custom({
    Expression<int>? id,
    Expression<String>? wellName,
    Expression<double>? a,
    Expression<double>? m,
    Expression<double>? n,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (wellName != null) 'well_name': wellName,
      if (a != null) 'a': a,
      if (m != null) 'm': m,
      if (n != null) 'n': n,
    });
  }

  PetrophysicalParametersCompanion copyWith({
    Value<int>? id,
    Value<String>? wellName,
    Value<double>? a,
    Value<double>? m,
    Value<double>? n,
  }) {
    return PetrophysicalParametersCompanion(
      id: id ?? this.id,
      wellName: wellName ?? this.wellName,
      a: a ?? this.a,
      m: m ?? this.m,
      n: n ?? this.n,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (wellName.present) {
      map['well_name'] = Variable<String>(wellName.value);
    }
    if (a.present) {
      map['a'] = Variable<double>(a.value);
    }
    if (m.present) {
      map['m'] = Variable<double>(m.value);
    }
    if (n.present) {
      map['n'] = Variable<double>(n.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PetrophysicalParametersCompanion(')
          ..write('id: $id, ')
          ..write('wellName: $wellName, ')
          ..write('a: $a, ')
          ..write('m: $m, ')
          ..write('n: $n')
          ..write(')'))
        .toString();
  }
}

class $AnalysisResultsTable extends AnalysisResults
    with TableInfo<$AnalysisResultsTable, AnalysisResult> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AnalysisResultsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _wellNameMeta = const VerificationMeta(
    'wellName',
  );
  @override
  late final GeneratedColumn<String> wellName = GeneratedColumn<String>(
    'well_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _resultTypeMeta = const VerificationMeta(
    'resultType',
  );
  @override
  late final GeneratedColumn<String> resultType = GeneratedColumn<String>(
    'result_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dataJsonMeta = const VerificationMeta(
    'dataJson',
  );
  @override
  late final GeneratedColumn<String> dataJson = GeneratedColumn<String>(
    'data_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, wellName, resultType, dataJson];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'analysis_results';
  @override
  VerificationContext validateIntegrity(
    Insertable<AnalysisResult> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('well_name')) {
      context.handle(
        _wellNameMeta,
        wellName.isAcceptableOrUnknown(data['well_name']!, _wellNameMeta),
      );
    } else if (isInserting) {
      context.missing(_wellNameMeta);
    }
    if (data.containsKey('result_type')) {
      context.handle(
        _resultTypeMeta,
        resultType.isAcceptableOrUnknown(data['result_type']!, _resultTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_resultTypeMeta);
    }
    if (data.containsKey('data_json')) {
      context.handle(
        _dataJsonMeta,
        dataJson.isAcceptableOrUnknown(data['data_json']!, _dataJsonMeta),
      );
    } else if (isInserting) {
      context.missing(_dataJsonMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AnalysisResult map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AnalysisResult(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      wellName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}well_name'],
      )!,
      resultType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}result_type'],
      )!,
      dataJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}data_json'],
      )!,
    );
  }

  @override
  $AnalysisResultsTable createAlias(String alias) {
    return $AnalysisResultsTable(attachedDatabase, alias);
  }
}

class AnalysisResult extends DataClass implements Insertable<AnalysisResult> {
  final int id;
  final String wellName;
  final String resultType;
  final String dataJson;
  const AnalysisResult({
    required this.id,
    required this.wellName,
    required this.resultType,
    required this.dataJson,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['well_name'] = Variable<String>(wellName);
    map['result_type'] = Variable<String>(resultType);
    map['data_json'] = Variable<String>(dataJson);
    return map;
  }

  AnalysisResultsCompanion toCompanion(bool nullToAbsent) {
    return AnalysisResultsCompanion(
      id: Value(id),
      wellName: Value(wellName),
      resultType: Value(resultType),
      dataJson: Value(dataJson),
    );
  }

  factory AnalysisResult.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AnalysisResult(
      id: serializer.fromJson<int>(json['id']),
      wellName: serializer.fromJson<String>(json['wellName']),
      resultType: serializer.fromJson<String>(json['resultType']),
      dataJson: serializer.fromJson<String>(json['dataJson']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'wellName': serializer.toJson<String>(wellName),
      'resultType': serializer.toJson<String>(resultType),
      'dataJson': serializer.toJson<String>(dataJson),
    };
  }

  AnalysisResult copyWith({
    int? id,
    String? wellName,
    String? resultType,
    String? dataJson,
  }) => AnalysisResult(
    id: id ?? this.id,
    wellName: wellName ?? this.wellName,
    resultType: resultType ?? this.resultType,
    dataJson: dataJson ?? this.dataJson,
  );
  AnalysisResult copyWithCompanion(AnalysisResultsCompanion data) {
    return AnalysisResult(
      id: data.id.present ? data.id.value : this.id,
      wellName: data.wellName.present ? data.wellName.value : this.wellName,
      resultType: data.resultType.present
          ? data.resultType.value
          : this.resultType,
      dataJson: data.dataJson.present ? data.dataJson.value : this.dataJson,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AnalysisResult(')
          ..write('id: $id, ')
          ..write('wellName: $wellName, ')
          ..write('resultType: $resultType, ')
          ..write('dataJson: $dataJson')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, wellName, resultType, dataJson);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AnalysisResult &&
          other.id == this.id &&
          other.wellName == this.wellName &&
          other.resultType == this.resultType &&
          other.dataJson == this.dataJson);
}

class AnalysisResultsCompanion extends UpdateCompanion<AnalysisResult> {
  final Value<int> id;
  final Value<String> wellName;
  final Value<String> resultType;
  final Value<String> dataJson;
  const AnalysisResultsCompanion({
    this.id = const Value.absent(),
    this.wellName = const Value.absent(),
    this.resultType = const Value.absent(),
    this.dataJson = const Value.absent(),
  });
  AnalysisResultsCompanion.insert({
    this.id = const Value.absent(),
    required String wellName,
    required String resultType,
    required String dataJson,
  }) : wellName = Value(wellName),
       resultType = Value(resultType),
       dataJson = Value(dataJson);
  static Insertable<AnalysisResult> custom({
    Expression<int>? id,
    Expression<String>? wellName,
    Expression<String>? resultType,
    Expression<String>? dataJson,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (wellName != null) 'well_name': wellName,
      if (resultType != null) 'result_type': resultType,
      if (dataJson != null) 'data_json': dataJson,
    });
  }

  AnalysisResultsCompanion copyWith({
    Value<int>? id,
    Value<String>? wellName,
    Value<String>? resultType,
    Value<String>? dataJson,
  }) {
    return AnalysisResultsCompanion(
      id: id ?? this.id,
      wellName: wellName ?? this.wellName,
      resultType: resultType ?? this.resultType,
      dataJson: dataJson ?? this.dataJson,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (wellName.present) {
      map['well_name'] = Variable<String>(wellName.value);
    }
    if (resultType.present) {
      map['result_type'] = Variable<String>(resultType.value);
    }
    if (dataJson.present) {
      map['data_json'] = Variable<String>(dataJson.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AnalysisResultsCompanion(')
          ..write('id: $id, ')
          ..write('wellName: $wellName, ')
          ..write('resultType: $resultType, ')
          ..write('dataJson: $dataJson')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $LasLogDataTable lasLogData = $LasLogDataTable(this);
  late final $PetrophysicalParametersTable petrophysicalParameters =
      $PetrophysicalParametersTable(this);
  late final $AnalysisResultsTable analysisResults = $AnalysisResultsTable(
    this,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    lasLogData,
    petrophysicalParameters,
    analysisResults,
  ];
}

typedef $$LasLogDataTableCreateCompanionBuilder =
    LasLogDataCompanion Function({
      Value<int> id,
      required String wellName,
      required String mnemonic,
      Value<String?> unit,
      Value<String?> description,
      required String dataJson,
    });
typedef $$LasLogDataTableUpdateCompanionBuilder =
    LasLogDataCompanion Function({
      Value<int> id,
      Value<String> wellName,
      Value<String> mnemonic,
      Value<String?> unit,
      Value<String?> description,
      Value<String> dataJson,
    });

class $$LasLogDataTableFilterComposer
    extends Composer<_$AppDatabase, $LasLogDataTable> {
  $$LasLogDataTableFilterComposer({
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

  ColumnFilters<String> get wellName => $composableBuilder(
    column: $table.wellName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mnemonic => $composableBuilder(
    column: $table.mnemonic,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dataJson => $composableBuilder(
    column: $table.dataJson,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LasLogDataTableOrderingComposer
    extends Composer<_$AppDatabase, $LasLogDataTable> {
  $$LasLogDataTableOrderingComposer({
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

  ColumnOrderings<String> get wellName => $composableBuilder(
    column: $table.wellName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mnemonic => $composableBuilder(
    column: $table.mnemonic,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dataJson => $composableBuilder(
    column: $table.dataJson,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LasLogDataTableAnnotationComposer
    extends Composer<_$AppDatabase, $LasLogDataTable> {
  $$LasLogDataTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get wellName =>
      $composableBuilder(column: $table.wellName, builder: (column) => column);

  GeneratedColumn<String> get mnemonic =>
      $composableBuilder(column: $table.mnemonic, builder: (column) => column);

  GeneratedColumn<String> get unit =>
      $composableBuilder(column: $table.unit, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get dataJson =>
      $composableBuilder(column: $table.dataJson, builder: (column) => column);
}

class $$LasLogDataTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LasLogDataTable,
          LasLogDataData,
          $$LasLogDataTableFilterComposer,
          $$LasLogDataTableOrderingComposer,
          $$LasLogDataTableAnnotationComposer,
          $$LasLogDataTableCreateCompanionBuilder,
          $$LasLogDataTableUpdateCompanionBuilder,
          (
            LasLogDataData,
            BaseReferences<_$AppDatabase, $LasLogDataTable, LasLogDataData>,
          ),
          LasLogDataData,
          PrefetchHooks Function()
        > {
  $$LasLogDataTableTableManager(_$AppDatabase db, $LasLogDataTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LasLogDataTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LasLogDataTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LasLogDataTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> wellName = const Value.absent(),
                Value<String> mnemonic = const Value.absent(),
                Value<String?> unit = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String> dataJson = const Value.absent(),
              }) => LasLogDataCompanion(
                id: id,
                wellName: wellName,
                mnemonic: mnemonic,
                unit: unit,
                description: description,
                dataJson: dataJson,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String wellName,
                required String mnemonic,
                Value<String?> unit = const Value.absent(),
                Value<String?> description = const Value.absent(),
                required String dataJson,
              }) => LasLogDataCompanion.insert(
                id: id,
                wellName: wellName,
                mnemonic: mnemonic,
                unit: unit,
                description: description,
                dataJson: dataJson,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LasLogDataTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LasLogDataTable,
      LasLogDataData,
      $$LasLogDataTableFilterComposer,
      $$LasLogDataTableOrderingComposer,
      $$LasLogDataTableAnnotationComposer,
      $$LasLogDataTableCreateCompanionBuilder,
      $$LasLogDataTableUpdateCompanionBuilder,
      (
        LasLogDataData,
        BaseReferences<_$AppDatabase, $LasLogDataTable, LasLogDataData>,
      ),
      LasLogDataData,
      PrefetchHooks Function()
    >;
typedef $$PetrophysicalParametersTableCreateCompanionBuilder =
    PetrophysicalParametersCompanion Function({
      Value<int> id,
      required String wellName,
      Value<double> a,
      Value<double> m,
      Value<double> n,
    });
typedef $$PetrophysicalParametersTableUpdateCompanionBuilder =
    PetrophysicalParametersCompanion Function({
      Value<int> id,
      Value<String> wellName,
      Value<double> a,
      Value<double> m,
      Value<double> n,
    });

class $$PetrophysicalParametersTableFilterComposer
    extends Composer<_$AppDatabase, $PetrophysicalParametersTable> {
  $$PetrophysicalParametersTableFilterComposer({
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

  ColumnFilters<String> get wellName => $composableBuilder(
    column: $table.wellName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get a => $composableBuilder(
    column: $table.a,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get m => $composableBuilder(
    column: $table.m,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get n => $composableBuilder(
    column: $table.n,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PetrophysicalParametersTableOrderingComposer
    extends Composer<_$AppDatabase, $PetrophysicalParametersTable> {
  $$PetrophysicalParametersTableOrderingComposer({
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

  ColumnOrderings<String> get wellName => $composableBuilder(
    column: $table.wellName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get a => $composableBuilder(
    column: $table.a,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get m => $composableBuilder(
    column: $table.m,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get n => $composableBuilder(
    column: $table.n,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PetrophysicalParametersTableAnnotationComposer
    extends Composer<_$AppDatabase, $PetrophysicalParametersTable> {
  $$PetrophysicalParametersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get wellName =>
      $composableBuilder(column: $table.wellName, builder: (column) => column);

  GeneratedColumn<double> get a =>
      $composableBuilder(column: $table.a, builder: (column) => column);

  GeneratedColumn<double> get m =>
      $composableBuilder(column: $table.m, builder: (column) => column);

  GeneratedColumn<double> get n =>
      $composableBuilder(column: $table.n, builder: (column) => column);
}

class $$PetrophysicalParametersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PetrophysicalParametersTable,
          PetrophysicalParameter,
          $$PetrophysicalParametersTableFilterComposer,
          $$PetrophysicalParametersTableOrderingComposer,
          $$PetrophysicalParametersTableAnnotationComposer,
          $$PetrophysicalParametersTableCreateCompanionBuilder,
          $$PetrophysicalParametersTableUpdateCompanionBuilder,
          (
            PetrophysicalParameter,
            BaseReferences<
              _$AppDatabase,
              $PetrophysicalParametersTable,
              PetrophysicalParameter
            >,
          ),
          PetrophysicalParameter,
          PrefetchHooks Function()
        > {
  $$PetrophysicalParametersTableTableManager(
    _$AppDatabase db,
    $PetrophysicalParametersTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PetrophysicalParametersTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$PetrophysicalParametersTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$PetrophysicalParametersTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> wellName = const Value.absent(),
                Value<double> a = const Value.absent(),
                Value<double> m = const Value.absent(),
                Value<double> n = const Value.absent(),
              }) => PetrophysicalParametersCompanion(
                id: id,
                wellName: wellName,
                a: a,
                m: m,
                n: n,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String wellName,
                Value<double> a = const Value.absent(),
                Value<double> m = const Value.absent(),
                Value<double> n = const Value.absent(),
              }) => PetrophysicalParametersCompanion.insert(
                id: id,
                wellName: wellName,
                a: a,
                m: m,
                n: n,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PetrophysicalParametersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PetrophysicalParametersTable,
      PetrophysicalParameter,
      $$PetrophysicalParametersTableFilterComposer,
      $$PetrophysicalParametersTableOrderingComposer,
      $$PetrophysicalParametersTableAnnotationComposer,
      $$PetrophysicalParametersTableCreateCompanionBuilder,
      $$PetrophysicalParametersTableUpdateCompanionBuilder,
      (
        PetrophysicalParameter,
        BaseReferences<
          _$AppDatabase,
          $PetrophysicalParametersTable,
          PetrophysicalParameter
        >,
      ),
      PetrophysicalParameter,
      PrefetchHooks Function()
    >;
typedef $$AnalysisResultsTableCreateCompanionBuilder =
    AnalysisResultsCompanion Function({
      Value<int> id,
      required String wellName,
      required String resultType,
      required String dataJson,
    });
typedef $$AnalysisResultsTableUpdateCompanionBuilder =
    AnalysisResultsCompanion Function({
      Value<int> id,
      Value<String> wellName,
      Value<String> resultType,
      Value<String> dataJson,
    });

class $$AnalysisResultsTableFilterComposer
    extends Composer<_$AppDatabase, $AnalysisResultsTable> {
  $$AnalysisResultsTableFilterComposer({
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

  ColumnFilters<String> get wellName => $composableBuilder(
    column: $table.wellName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get resultType => $composableBuilder(
    column: $table.resultType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dataJson => $composableBuilder(
    column: $table.dataJson,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AnalysisResultsTableOrderingComposer
    extends Composer<_$AppDatabase, $AnalysisResultsTable> {
  $$AnalysisResultsTableOrderingComposer({
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

  ColumnOrderings<String> get wellName => $composableBuilder(
    column: $table.wellName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get resultType => $composableBuilder(
    column: $table.resultType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dataJson => $composableBuilder(
    column: $table.dataJson,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AnalysisResultsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AnalysisResultsTable> {
  $$AnalysisResultsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get wellName =>
      $composableBuilder(column: $table.wellName, builder: (column) => column);

  GeneratedColumn<String> get resultType => $composableBuilder(
    column: $table.resultType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get dataJson =>
      $composableBuilder(column: $table.dataJson, builder: (column) => column);
}

class $$AnalysisResultsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AnalysisResultsTable,
          AnalysisResult,
          $$AnalysisResultsTableFilterComposer,
          $$AnalysisResultsTableOrderingComposer,
          $$AnalysisResultsTableAnnotationComposer,
          $$AnalysisResultsTableCreateCompanionBuilder,
          $$AnalysisResultsTableUpdateCompanionBuilder,
          (
            AnalysisResult,
            BaseReferences<
              _$AppDatabase,
              $AnalysisResultsTable,
              AnalysisResult
            >,
          ),
          AnalysisResult,
          PrefetchHooks Function()
        > {
  $$AnalysisResultsTableTableManager(
    _$AppDatabase db,
    $AnalysisResultsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AnalysisResultsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AnalysisResultsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AnalysisResultsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> wellName = const Value.absent(),
                Value<String> resultType = const Value.absent(),
                Value<String> dataJson = const Value.absent(),
              }) => AnalysisResultsCompanion(
                id: id,
                wellName: wellName,
                resultType: resultType,
                dataJson: dataJson,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String wellName,
                required String resultType,
                required String dataJson,
              }) => AnalysisResultsCompanion.insert(
                id: id,
                wellName: wellName,
                resultType: resultType,
                dataJson: dataJson,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AnalysisResultsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AnalysisResultsTable,
      AnalysisResult,
      $$AnalysisResultsTableFilterComposer,
      $$AnalysisResultsTableOrderingComposer,
      $$AnalysisResultsTableAnnotationComposer,
      $$AnalysisResultsTableCreateCompanionBuilder,
      $$AnalysisResultsTableUpdateCompanionBuilder,
      (
        AnalysisResult,
        BaseReferences<_$AppDatabase, $AnalysisResultsTable, AnalysisResult>,
      ),
      AnalysisResult,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$LasLogDataTableTableManager get lasLogData =>
      $$LasLogDataTableTableManager(_db, _db.lasLogData);
  $$PetrophysicalParametersTableTableManager get petrophysicalParameters =>
      $$PetrophysicalParametersTableTableManager(
        _db,
        _db.petrophysicalParameters,
      );
  $$AnalysisResultsTableTableManager get analysisResults =>
      $$AnalysisResultsTableTableManager(_db, _db.analysisResults);
}
