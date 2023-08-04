// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=2.9

part of 'sub_category_record.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<SubCategoryRecord> _$subCategoryRecordSerializer =
    new _$SubCategoryRecordSerializer();

class _$SubCategoryRecordSerializer
    implements StructuredSerializer<SubCategoryRecord> {
  @override
  final Iterable<Type> types = const [SubCategoryRecord, _$SubCategoryRecord];
  @override
  final String wireName = 'SubCategoryRecord';

  @override
  Iterable<Object> serialize(Serializers serializers, SubCategoryRecord object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    Object value;
    value = object.categoryId;
    if (value != null) {
      result
        ..add('categoryId')
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
    value = object.subCategoryId;
    if (value != null) {
      result
        ..add('subCategoryId')
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
  SubCategoryRecord deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new SubCategoryRecordBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object value = iterator.current;
      switch (key) {
        case 'categoryId':
          result.categoryId = serializers.deserialize(value,
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
        case 'subCategoryId':
          result.subCategoryId = serializers.deserialize(value,
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

class _$SubCategoryRecord extends SubCategoryRecord {
  @override
  final String categoryId;
  @override
  final String imageUrl;
  @override
  final String name;
  @override
  final String subCategoryId;
  @override
  final BuiltList<String> search;
  @override
  final DocumentReference<Object> reference;

  factory _$SubCategoryRecord(
          [void Function(SubCategoryRecordBuilder) updates]) =>
      (new SubCategoryRecordBuilder()..update(updates)).build();

  _$SubCategoryRecord._(
      {this.categoryId,
      this.imageUrl,
      this.name,
      this.subCategoryId,
      this.search,
      this.reference})
      : super._();

  @override
  SubCategoryRecord rebuild(void Function(SubCategoryRecordBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SubCategoryRecordBuilder toBuilder() =>
      new SubCategoryRecordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SubCategoryRecord &&
        categoryId == other.categoryId &&
        imageUrl == other.imageUrl &&
        name == other.name &&
        subCategoryId == other.subCategoryId &&
        search == other.search &&
        reference == other.reference;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc($jc($jc(0, categoryId.hashCode), imageUrl.hashCode),
                    name.hashCode),
                subCategoryId.hashCode),
            search.hashCode),
        reference.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('SubCategoryRecord')
          ..add('categoryId', categoryId)
          ..add('imageUrl', imageUrl)
          ..add('name', name)
          ..add('subCategoryId', subCategoryId)
          ..add('search', search)
          ..add('reference', reference))
        .toString();
  }
}

class SubCategoryRecordBuilder
    implements Builder<SubCategoryRecord, SubCategoryRecordBuilder> {
  _$SubCategoryRecord _$v;

  String _categoryId;
  String get categoryId => _$this._categoryId;
  set categoryId(String categoryId) => _$this._categoryId = categoryId;

  String _imageUrl;
  String get imageUrl => _$this._imageUrl;
  set imageUrl(String imageUrl) => _$this._imageUrl = imageUrl;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  String _subCategoryId;
  String get subCategoryId => _$this._subCategoryId;
  set subCategoryId(String subCategoryId) =>
      _$this._subCategoryId = subCategoryId;

  ListBuilder<String> _search;
  ListBuilder<String> get search =>
      _$this._search ??= new ListBuilder<String>();
  set search(ListBuilder<String> search) => _$this._search = search;

  DocumentReference<Object> _reference;
  DocumentReference<Object> get reference => _$this._reference;
  set reference(DocumentReference<Object> reference) =>
      _$this._reference = reference;

  SubCategoryRecordBuilder() {
    SubCategoryRecord._initializeBuilder(this);
  }

  SubCategoryRecordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _categoryId = $v.categoryId;
      _imageUrl = $v.imageUrl;
      _name = $v.name;
      _subCategoryId = $v.subCategoryId;
      _search = $v.search?.toBuilder();
      _reference = $v.reference;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SubCategoryRecord other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$SubCategoryRecord;
  }

  @override
  void update(void Function(SubCategoryRecordBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$SubCategoryRecord build() {
    _$SubCategoryRecord _$result;
    try {
      _$result = _$v ??
          new _$SubCategoryRecord._(
              categoryId: categoryId,
              imageUrl: imageUrl,
              name: name,
              subCategoryId: subCategoryId,
              search: _search?.build(),
              reference: reference);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'search';
        _search?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'SubCategoryRecord', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
