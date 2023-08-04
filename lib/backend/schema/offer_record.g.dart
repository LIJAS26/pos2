// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=2.9

part of 'offer_record.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<OfferRecord> _$offerRecordSerializer = new _$OfferRecordSerializer();

class _$OfferRecordSerializer implements StructuredSerializer<OfferRecord> {
  @override
  final Iterable<Type> types = const [OfferRecord, _$OfferRecord];
  @override
  final String wireName = 'OfferRecord';

  @override
  Iterable<Object> serialize(Serializers serializers, OfferRecord object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    Object value;
    value = object.expiryDate;
    if (value != null) {
      result
        ..add('expiryDate')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(Timestamp)));
    }
    value = object.userId;
    if (value != null) {
      result
        ..add('userId')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(BuiltList, const [const FullType(String)])));
    }
    value = object.search;
    if (value != null) {
      result
        ..add('search')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(BuiltList, const [const FullType(String)])));
    }
    value = object.shopId;
    if (value != null) {
      result
        ..add('shopId')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.productId;
    if (value != null) {
      result
        ..add('productId')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.categoryId;
    if (value != null) {
      result
        ..add('categoryId')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.title;
    if (value != null) {
      result
        ..add('title')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.code;
    if (value != null) {
      result
        ..add('code')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.used;
    if (value != null) {
      result
        ..add('used')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(BuiltList, const [const FullType(String)])));
    }
    value = object.description;
    if (value != null) {
      result
        ..add('description')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.global;
    if (value != null) {
      result
        ..add('global')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.unlimited;
    if (value != null) {
      result
        ..add('unlimited')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.amount;
    if (value != null) {
      result
        ..add('amount')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.value;
    if (value != null) {
      result
        ..add('value')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
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
  OfferRecord deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new OfferRecordBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object value = iterator.current;
      switch (key) {
        case 'expiryDate':
          result.expiryDate = serializers.deserialize(value,
              specifiedType: const FullType(Timestamp)) as Timestamp;
          break;
        case 'userId':
          result.userId.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(String)]))
              as BuiltList<Object>);
          break;
        case 'search':
          result.search.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(String)]))
              as BuiltList<Object>);
          break;
        case 'shopId':
          result.shopId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'productId':
          result.productId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'categoryId':
          result.categoryId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'title':
          result.title = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'code':
          result.code = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'used':
          result.used.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(String)]))
              as BuiltList<Object>);
          break;
        case 'description':
          result.description = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'global':
          result.global = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'unlimited':
          result.unlimited = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'amount':
          result.amount = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'value':
          result.value = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
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

class _$OfferRecord extends OfferRecord {
  @override
  final Timestamp expiryDate;
  @override
  final BuiltList<String> userId;
  @override
  final BuiltList<String> search;
  @override
  final String shopId;
  @override
  final String productId;
  @override
  final String categoryId;
  @override
  final String title;
  @override
  final String code;
  @override
  final BuiltList<String> used;
  @override
  final String description;
  @override
  final bool global;
  @override
  final bool unlimited;
  @override
  final bool amount;
  @override
  final double value;
  @override
  final DocumentReference<Object> reference;

  factory _$OfferRecord([void Function(OfferRecordBuilder) updates]) =>
      (new OfferRecordBuilder()..update(updates)).build();

  _$OfferRecord._(
      {this.expiryDate,
      this.userId,
      this.search,
      this.shopId,
      this.productId,
      this.categoryId,
      this.title,
      this.code,
      this.used,
      this.description,
      this.global,
      this.unlimited,
      this.amount,
      this.value,
      this.reference})
      : super._();

  @override
  OfferRecord rebuild(void Function(OfferRecordBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  OfferRecordBuilder toBuilder() => new OfferRecordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is OfferRecord &&
        expiryDate == other.expiryDate &&
        userId == other.userId &&
        search == other.search &&
        shopId == other.shopId &&
        productId == other.productId &&
        categoryId == other.categoryId &&
        title == other.title &&
        code == other.code &&
        used == other.used &&
        description == other.description &&
        global == other.global &&
        unlimited == other.unlimited &&
        amount == other.amount &&
        value == other.value &&
        reference == other.reference;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc(
                                $jc(
                                    $jc(
                                        $jc(
                                            $jc(
                                                $jc(
                                                    $jc(
                                                        $jc(
                                                            $jc(
                                                                0,
                                                                expiryDate
                                                                    .hashCode),
                                                            userId.hashCode),
                                                        search.hashCode),
                                                    shopId.hashCode),
                                                productId.hashCode),
                                            categoryId.hashCode),
                                        title.hashCode),
                                    code.hashCode),
                                used.hashCode),
                            description.hashCode),
                        global.hashCode),
                    unlimited.hashCode),
                amount.hashCode),
            value.hashCode),
        reference.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('OfferRecord')
          ..add('expiryDate', expiryDate)
          ..add('userId', userId)
          ..add('search', search)
          ..add('shopId', shopId)
          ..add('productId', productId)
          ..add('categoryId', categoryId)
          ..add('title', title)
          ..add('code', code)
          ..add('used', used)
          ..add('description', description)
          ..add('global', global)
          ..add('unlimited', unlimited)
          ..add('amount', amount)
          ..add('value', value)
          ..add('reference', reference))
        .toString();
  }
}

class OfferRecordBuilder implements Builder<OfferRecord, OfferRecordBuilder> {
  _$OfferRecord _$v;

  Timestamp _expiryDate;
  Timestamp get expiryDate => _$this._expiryDate;
  set expiryDate(Timestamp expiryDate) => _$this._expiryDate = expiryDate;

  ListBuilder<String> _userId;
  ListBuilder<String> get userId =>
      _$this._userId ??= new ListBuilder<String>();
  set userId(ListBuilder<String> userId) => _$this._userId = userId;

  ListBuilder<String> _search;
  ListBuilder<String> get search =>
      _$this._search ??= new ListBuilder<String>();
  set search(ListBuilder<String> search) => _$this._search = search;

  String _shopId;
  String get shopId => _$this._shopId;
  set shopId(String shopId) => _$this._shopId = shopId;

  String _productId;
  String get productId => _$this._productId;
  set productId(String productId) => _$this._productId = productId;

  String _categoryId;
  String get categoryId => _$this._categoryId;
  set categoryId(String categoryId) => _$this._categoryId = categoryId;

  String _title;
  String get title => _$this._title;
  set title(String title) => _$this._title = title;

  String _code;
  String get code => _$this._code;
  set code(String code) => _$this._code = code;

  ListBuilder<String> _used;
  ListBuilder<String> get used => _$this._used ??= new ListBuilder<String>();
  set used(ListBuilder<String> used) => _$this._used = used;

  String _description;
  String get description => _$this._description;
  set description(String description) => _$this._description = description;

  bool _global;
  bool get global => _$this._global;
  set global(bool global) => _$this._global = global;

  bool _unlimited;
  bool get unlimited => _$this._unlimited;
  set unlimited(bool unlimited) => _$this._unlimited = unlimited;

  bool _amount;
  bool get amount => _$this._amount;
  set amount(bool amount) => _$this._amount = amount;

  double _value;
  double get value => _$this._value;
  set value(double value) => _$this._value = value;

  DocumentReference<Object> _reference;
  DocumentReference<Object> get reference => _$this._reference;
  set reference(DocumentReference<Object> reference) =>
      _$this._reference = reference;

  OfferRecordBuilder() {
    OfferRecord._initializeBuilder(this);
  }

  OfferRecordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _expiryDate = $v.expiryDate;
      _userId = $v.userId?.toBuilder();
      _search = $v.search?.toBuilder();
      _shopId = $v.shopId;
      _productId = $v.productId;
      _categoryId = $v.categoryId;
      _title = $v.title;
      _code = $v.code;
      _used = $v.used?.toBuilder();
      _description = $v.description;
      _global = $v.global;
      _unlimited = $v.unlimited;
      _amount = $v.amount;
      _value = $v.value;
      _reference = $v.reference;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(OfferRecord other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$OfferRecord;
  }

  @override
  void update(void Function(OfferRecordBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$OfferRecord build() {
    _$OfferRecord _$result;
    try {
      _$result = _$v ??
          new _$OfferRecord._(
              expiryDate: expiryDate,
              userId: _userId?.build(),
              search: _search?.build(),
              shopId: shopId,
              productId: productId,
              categoryId: categoryId,
              title: title,
              code: code,
              used: _used?.build(),
              description: description,
              global: global,
              unlimited: unlimited,
              amount: amount,
              value: value,
              reference: reference);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'userId';
        _userId?.build();
        _$failedField = 'search';
        _search?.build();

        _$failedField = 'used';
        _used?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'OfferRecord', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
