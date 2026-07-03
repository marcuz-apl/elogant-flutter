// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'well_props.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<WellProps> _$wellPropsSerializer = _$WellPropsSerializer();

class _$WellPropsSerializer implements StructuredSerializer<WellProps> {
  @override
  final Iterable<Type> types = const [WellProps, _$WellProps];
  @override
  final String wireName = 'WellProps';

  @override
  Iterable<Object?> serialize(Serializers serializers, WellProps object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.unit;
    if (value != null) {
      result
        ..add('unit')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.key;
    if (value != null) {
      result
        ..add('key')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.value;
    if (value != null) {
      result
        ..add('value')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.nullValue;
    if (value != null) {
      result
        ..add('nullValue')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(WellProps)));
    }
    value = object.description;
    if (value != null) {
      result
        ..add('description')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  WellProps deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = WellPropsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'unit':
          result.unit = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'key':
          result.key = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'value':
          result.value = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'nullValue':
          result.nullValue.replace(serializers.deserialize(value,
              specifiedType: const FullType(WellProps))! as WellProps);
          break;
        case 'description':
          result.description = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$WellProps extends WellProps {
  @override
  final String? unit;
  @override
  final String? key;
  @override
  final String? value;
  @override
  final WellProps? nullValue;
  @override
  final String? description;

  factory _$WellProps([void Function(WellPropsBuilder)? updates]) =>
      (WellPropsBuilder()..update(updates))._build();

  _$WellProps._(
      {this.unit, this.key, this.value, this.nullValue, this.description})
      : super._();
  @override
  WellProps rebuild(void Function(WellPropsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  WellPropsBuilder toBuilder() => WellPropsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WellProps &&
        unit == other.unit &&
        key == other.key &&
        value == other.value &&
        nullValue == other.nullValue &&
        description == other.description;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, unit.hashCode);
    _$hash = $jc(_$hash, key.hashCode);
    _$hash = $jc(_$hash, value.hashCode);
    _$hash = $jc(_$hash, nullValue.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'WellProps')
          ..add('unit', unit)
          ..add('key', key)
          ..add('value', value)
          ..add('nullValue', nullValue)
          ..add('description', description))
        .toString();
  }
}

class WellPropsBuilder implements Builder<WellProps, WellPropsBuilder> {
  _$WellProps? _$v;

  String? _unit;
  String? get unit => _$this._unit;
  set unit(String? unit) => _$this._unit = unit;

  String? _key;
  String? get key => _$this._key;
  set key(String? key) => _$this._key = key;

  String? _value;
  String? get value => _$this._value;
  set value(String? value) => _$this._value = value;

  WellPropsBuilder? _nullValue;
  WellPropsBuilder get nullValue => _$this._nullValue ??= WellPropsBuilder();
  set nullValue(WellPropsBuilder? nullValue) => _$this._nullValue = nullValue;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  WellPropsBuilder();

  WellPropsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _unit = $v.unit;
      _key = $v.key;
      _value = $v.value;
      _nullValue = $v.nullValue?.toBuilder();
      _description = $v.description;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WellProps other) {
    _$v = other as _$WellProps;
  }

  @override
  void update(void Function(WellPropsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  WellProps build() => _build();

  _$WellProps _build() {
    _$WellProps _$result;
    try {
      _$result = _$v ??
          _$WellProps._(
            unit: unit,
            key: key,
            value: value,
            nullValue: _nullValue?.build(),
            description: description,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'nullValue';
        _nullValue?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'WellProps', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
