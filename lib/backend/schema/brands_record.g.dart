// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=2.9

part of 'brands_record.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<BrandsRecord> _$brandsRecordSerializer =
    new _$BrandsRecordSerializer();

class _$BrandsRecordSerializer implements StructuredSerializer<BrandsRecord> {
  @override
  final Iterable<Type> types = const [BrandsRecord, _$BrandsRecord];
  @override
  final String wireName = 'BrandsRecord';

  @override
  Iterable<Object> serialize(Serializers serializers, BrandsRecord object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    Object value;
    value = object.brand;
    if (value != null) {
      result
        ..add('brand')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.brandId;
    if (value != null) {
      result
        ..add('brandId')
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
  BrandsRecord deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new BrandsRecordBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object value = iterator.current;
      switch (key) {
        case 'brand':
          result.brand = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'brandId':
          result.brandId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'imageUrl':
          result.imageUrl = serializers.deserialize(value,
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

class _$BrandsRecord extends BrandsRecord {
  @override
  final String brand;
  @override
  final String brandId;
  @override
  final String imageUrl;
  @override
  final BuiltList<String> search;
  @override
  final DocumentReference<Object> reference;

  factory _$BrandsRecord([void Function(BrandsRecordBuilder) updates]) =>
      (new BrandsRecordBuilder()..update(updates)).build();

  _$BrandsRecord._(
      {this.brand, this.brandId, this.imageUrl, this.search, this.reference})
      : super._();

  @override
  BrandsRecord rebuild(void Function(BrandsRecordBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BrandsRecordBuilder toBuilder() => new BrandsRecordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BrandsRecord &&
        brand == other.brand &&
        brandId == other.brandId &&
        imageUrl == other.imageUrl &&
        search == other.search &&
        reference == other.reference;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc($jc($jc(0, brand.hashCode), brandId.hashCode),
                imageUrl.hashCode),
            search.hashCode),
        reference.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('BrandsRecord')
          ..add('brand', brand)
          ..add('brandId', brandId)
          ..add('imageUrl', imageUrl)
          ..add('search', search)
          ..add('reference', reference))
        .toString();
  }
}

class BrandsRecordBuilder
    implements Builder<BrandsRecord, BrandsRecordBuilder> {
  _$BrandsRecord _$v;

  String _brand;
  String get brand => _$this._brand;
  set brand(String brand) => _$this._brand = brand;

  String _brandId;
  String get brandId => _$this._brandId;
  set brandId(String brandId) => _$this._brandId = brandId;

  String _imageUrl;
  String get imageUrl => _$this._imageUrl;
  set imageUrl(String imageUrl) => _$this._imageUrl = imageUrl;

  ListBuilder<String> _search;
  ListBuilder<String> get search =>
      _$this._search ??= new ListBuilder<String>();
  set search(ListBuilder<String> search) => _$this._search = search;

  DocumentReference<Object> _reference;
  DocumentReference<Object> get reference => _$this._reference;
  set reference(DocumentReference<Object> reference) =>
      _$this._reference = reference;

  BrandsRecordBuilder() {
    BrandsRecord._initializeBuilder(this);
  }

  BrandsRecordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _brand = $v.brand;
      _brandId = $v.brandId;
      _imageUrl = $v.imageUrl;
      _search = $v.search?.toBuilder();
      _reference = $v.reference;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BrandsRecord other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$BrandsRecord;
  }

  @override
  void update(void Function(BrandsRecordBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$BrandsRecord build() {
    _$BrandsRecord _$result;
    try {
      _$result = _$v ??
          new _$BrandsRecord._(
              brand: brand,
              brandId: brandId,
              imageUrl: imageUrl,
              search: _search?.build(),
              reference: reference);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'search';
        _search?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'BrandsRecord', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
