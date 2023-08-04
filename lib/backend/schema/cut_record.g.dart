// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=2.9

part of 'cut_record.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<CutRecord> _$cutRecordSerializer = new _$CutRecordSerializer();

class _$CutRecordSerializer implements StructuredSerializer<CutRecord> {
  @override
  final Iterable<Type> types = const [CutRecord, _$CutRecord];
  @override
  final String wireName = 'CutRecord';

  @override
  Iterable<Object> serialize(Serializers serializers, CutRecord object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    Object value;
    value = object.cutId;
    if (value != null) {
      result
        ..add('cutId')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.imageUrl;
    if (value != null) {
      result
        ..add('imageUrl')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.name;
    if (value != null) {
      result
        ..add('name')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.search;
    if (value != null) {
      result
        ..add('search')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(BuiltList, const [const FullType(String)])));
    }
    value = object.reference;
    if (value != null) {
      result
        ..add('Document__Reference__Field')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                DocumentReference, const [const FullType(Object)])));
    }
    return result;
  }

  @override
  CutRecord deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new CutRecordBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object value = iterator.current;
      switch (key) {
        case 'cutId':
          result.cutId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'imageUrl':
          result.imageUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'search':
          result.search.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(String)]))
              as BuiltList<Object>);
          break;
        case 'Document__Reference__Field':
          result.reference = serializers.deserialize(value,
                  specifiedType: const FullType(
                      DocumentReference, const [const FullType(Object)]))
              as DocumentReference<Object>;
          break;
      }
    }

    return result.build();
  }
}

class _$CutRecord extends CutRecord {
  @override
  final String cutId;
  @override
  final String imageUrl;
  @override
  final String name;
  @override
  final BuiltList<String> search;
  @override
  final DocumentReference<Object> reference;

  factory _$CutRecord([void Function(CutRecordBuilder) updates]) =>
      (new CutRecordBuilder()..update(updates)).build();

  _$CutRecord._(
      {this.cutId, this.imageUrl, this.name, this.search, this.reference})
      : super._();

  @override
  CutRecord rebuild(void Function(CutRecordBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CutRecordBuilder toBuilder() => new CutRecordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CutRecord &&
        cutId == other.cutId &&
        imageUrl == other.imageUrl &&
        name == other.name &&
        search == other.search &&
        reference == other.reference;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc($jc(0, cutId.hashCode), imageUrl.hashCode), name.hashCode),
            search.hashCode),
        reference.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('CutRecord')
          ..add('cutId', cutId)
          ..add('imageUrl', imageUrl)
          ..add('name', name)
          ..add('search', search)
          ..add('reference', reference))
        .toString();
  }
}

class CutRecordBuilder implements Builder<CutRecord, CutRecordBuilder> {
  _$CutRecord _$v;

  String _cutId;
  String get cutId => _$this._cutId;
  set cutId(String cutId) => _$this._cutId = cutId;

  String _imageUrl;
  String get imageUrl => _$this._imageUrl;
  set imageUrl(String imageUrl) => _$this._imageUrl = imageUrl;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  ListBuilder<String> _search;
  ListBuilder<String> get search =>
      _$this._search ??= new ListBuilder<String>();
  set search(ListBuilder<String> search) => _$this._search = search;

  DocumentReference<Object> _reference;
  DocumentReference<Object> get reference => _$this._reference;
  set reference(DocumentReference<Object> reference) =>
      _$this._reference = reference;

  CutRecordBuilder() {
    CutRecord._initializeBuilder(this);
  }

  CutRecordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _cutId = $v.cutId;
      _imageUrl = $v.imageUrl;
      _name = $v.name;
      _search = $v.search?.toBuilder();
      _reference = $v.reference;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CutRecord other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$CutRecord;
  }

  @override
  void update(void Function(CutRecordBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$CutRecord build() {
    _$CutRecord _$result;
    try {
      _$result = _$v ??
          new _$CutRecord._(
              cutId: cutId,
              imageUrl: imageUrl,
              name: name,
              search: _search?.build(),
              reference: reference);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'search';
        _search?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'CutRecord', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
