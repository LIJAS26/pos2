// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=2.9

part of 'new_products_record.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<NewProductsRecord> _$newProductsRecordSerializer =
    new _$NewProductsRecordSerializer();

class _$NewProductsRecordSerializer
    implements StructuredSerializer<NewProductsRecord> {
  @override
  final Iterable<Type> types = const [NewProductsRecord, _$NewProductsRecord];
  @override
  final String wireName = 'NewProductsRecord';

  @override
  Iterable<Object> serialize(Serializers serializers, NewProductsRecord object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    Object value;
    value = object.name;
    if (value != null) {
      result
        ..add('name')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.unit;
    if (value != null) {
      result
        ..add('unit')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.shopId;
    if (value != null) {
      result
        ..add('shopId')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.shopName;
    if (value != null) {
      result
        ..add('shopName')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.ones;
    if (value != null) {
      result
        ..add('ones')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.twos;
    if (value != null) {
      result
        ..add('twos')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.threes;
    if (value != null) {
      result
        ..add('threes')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.fours;
    if (value != null) {
      result
        ..add('fours')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.fives;
    if (value != null) {
      result
        ..add('fives')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.description;
    if (value != null) {
      result
        ..add('description')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.price;
    if (value != null) {
      result
        ..add('price')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.discountPrice;
    if (value != null) {
      result
        ..add('discountPrice')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.userId;
    if (value != null) {
      result
        ..add('userId')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.color;
    if (value != null) {
      result
        ..add('color')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(BuiltList, const [const FullType(String)])));
    }
    value = object.size;
    if (value != null) {
      result
        ..add('size')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(BuiltList, const [const FullType(String)])));
    }
    value = object.cuts;
    if (value != null) {
      result
        ..add('cuts')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(BuiltList, const [const FullType(CutRecord)])));
    }
    value = object.imageId;
    if (value != null) {
      result
        ..add('imageId')
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
    value = object.productId;
    if (value != null) {
      result
        ..add('productId')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.brand;
    if (value != null) {
      result
        ..add('brand')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.subCategory;
    if (value != null) {
      result
        ..add('subCategory')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.category;
    if (value != null) {
      result
        ..add('category')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.available;
    if (value != null) {
      result
        ..add('available')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.open;
    if (value != null) {
      result
        ..add('open')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.branchId;
    if (value != null) {
      result
        ..add('branchId')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.start;
    if (value != null) {
      result
        ..add('start')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.step;
    if (value != null) {
      result
        ..add('step')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.stop;
    if (value != null) {
      result
        ..add('stop')
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
  NewProductsRecord deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new NewProductsRecordBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object value = iterator.current;
      switch (key) {
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'unit':
          result.unit = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'shopId':
          result.shopId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'shopName':
          result.shopName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'ones':
          result.ones = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'twos':
          result.twos = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'threes':
          result.threes = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'fours':
          result.fours = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'fives':
          result.fives = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'description':
          result.description = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'price':
          result.price = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'discountPrice':
          result.discountPrice = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'userId':
          result.userId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'color':
          result.color.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(String)]))
              as BuiltList<Object>);
          break;
        case 'size':
          result.size.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(String)]))
              as BuiltList<Object>);
          break;
        case 'cuts':
          result.cuts.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(CutRecord)]))
              as BuiltList<Object>);
          break;
        case 'imageId':
          result.imageId.replace(serializers.deserialize(value,
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
        case 'productId':
          result.productId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'brand':
          result.brand = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'subCategory':
          result.subCategory = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'category':
          result.category = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'available':
          result.available = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'open':
          result.open = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'branchId':
          result.branchId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'start':
          result.start = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'step':
          result.step = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'stop':
          result.stop = serializers.deserialize(value,
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

class _$NewProductsRecord extends NewProductsRecord {
  @override
  final String name;
  @override
  final String unit;
  @override
  final String shopId;
  @override
  final String shopName;
  @override
  final int ones;
  @override
  final int twos;
  @override
  final int threes;
  @override
  final int fours;
  @override
  final int fives;
  @override
  final String description;
  @override
  final double price;
  @override
  final double discountPrice;
  @override
  final String userId;
  @override
  final BuiltList<String> color;
  @override
  final BuiltList<String> size;
  @override
  final BuiltList<CutRecord> cuts;
  @override
  final BuiltList<String> imageId;
  @override
  final BuiltList<String> search;
  @override
  final String productId;
  @override
  final String brand;
  @override
  final String subCategory;
  @override
  final String category;
  @override
  final bool available;
  @override
  final bool open;
  @override
  final String branchId;
  @override
  final double start;
  @override
  final double step;
  @override
  final double stop;
  @override
  final DocumentReference<Object> reference;

  factory _$NewProductsRecord(
          [void Function(NewProductsRecordBuilder) updates]) =>
      (new NewProductsRecordBuilder()..update(updates)).build();

  _$NewProductsRecord._(
      {this.name,
      this.unit,
      this.shopId,
      this.shopName,
      this.ones,
      this.twos,
      this.threes,
      this.fours,
      this.fives,
      this.description,
      this.price,
      this.discountPrice,
      this.userId,
      this.color,
      this.size,
      this.cuts,
      this.imageId,
      this.search,
      this.productId,
      this.brand,
      this.subCategory,
      this.category,
      this.available,
      this.open,
      this.branchId,
      this.start,
      this.step,
      this.stop,
      this.reference})
      : super._();

  @override
  NewProductsRecord rebuild(void Function(NewProductsRecordBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  NewProductsRecordBuilder toBuilder() =>
      new NewProductsRecordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is NewProductsRecord &&
        name == other.name &&
        unit == other.unit &&
        shopId == other.shopId &&
        shopName == other.shopName &&
        ones == other.ones &&
        twos == other.twos &&
        threes == other.threes &&
        fours == other.fours &&
        fives == other.fives &&
        description == other.description &&
        price == other.price &&
        discountPrice == other.discountPrice &&
        userId == other.userId &&
        color == other.color &&
        size == other.size &&
        cuts == other.cuts &&
        imageId == other.imageId &&
        search == other.search &&
        productId == other.productId &&
        brand == other.brand &&
        subCategory == other.subCategory &&
        category == other.category &&
        available == other.available &&
        open == other.open &&
        branchId == other.branchId &&
        start == other.start &&
        step == other.step &&
        stop == other.stop &&
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
                                                                $jc(
                                                                    $jc(
                                                                        $jc(
                                                                            $jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc(0, name.hashCode), unit.hashCode), shopId.hashCode), shopName.hashCode), ones.hashCode), twos.hashCode), threes.hashCode), fours.hashCode), fives.hashCode), description.hashCode),
                                                                                price.hashCode),
                                                                            discountPrice.hashCode),
                                                                        userId.hashCode),
                                                                    color.hashCode),
                                                                size.hashCode),
                                                            cuts.hashCode),
                                                        imageId.hashCode),
                                                    search.hashCode),
                                                productId.hashCode),
                                            brand.hashCode),
                                        subCategory.hashCode),
                                    category.hashCode),
                                available.hashCode),
                            open.hashCode),
                        branchId.hashCode),
                    start.hashCode),
                step.hashCode),
            stop.hashCode),
        reference.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('NewProductsRecord')
          ..add('name', name)
          ..add('unit', unit)
          ..add('shopId', shopId)
          ..add('shopName', shopName)
          ..add('ones', ones)
          ..add('twos', twos)
          ..add('threes', threes)
          ..add('fours', fours)
          ..add('fives', fives)
          ..add('description', description)
          ..add('price', price)
          ..add('discountPrice', discountPrice)
          ..add('userId', userId)
          ..add('color', color)
          ..add('size', size)
          ..add('cuts', cuts)
          ..add('imageId', imageId)
          ..add('search', search)
          ..add('productId', productId)
          ..add('brand', brand)
          ..add('subCategory', subCategory)
          ..add('category', category)
          ..add('available', available)
          ..add('open', open)
          ..add('branchId', branchId)
          ..add('start', start)
          ..add('step', step)
          ..add('stop', stop)
          ..add('reference', reference))
        .toString();
  }
}

class NewProductsRecordBuilder
    implements Builder<NewProductsRecord, NewProductsRecordBuilder> {
  _$NewProductsRecord _$v;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  String _unit;
  String get unit => _$this._unit;
  set unit(String unit) => _$this._unit = unit;

  String _shopId;
  String get shopId => _$this._shopId;
  set shopId(String shopId) => _$this._shopId = shopId;

  String _shopName;
  String get shopName => _$this._shopName;
  set shopName(String shopName) => _$this._shopName = shopName;

  int _ones;
  int get ones => _$this._ones;
  set ones(int ones) => _$this._ones = ones;

  int _twos;
  int get twos => _$this._twos;
  set twos(int twos) => _$this._twos = twos;

  int _threes;
  int get threes => _$this._threes;
  set threes(int threes) => _$this._threes = threes;

  int _fours;
  int get fours => _$this._fours;
  set fours(int fours) => _$this._fours = fours;

  int _fives;
  int get fives => _$this._fives;
  set fives(int fives) => _$this._fives = fives;

  String _description;
  String get description => _$this._description;
  set description(String description) => _$this._description = description;

  double _price;
  double get price => _$this._price;
  set price(double price) => _$this._price = price;

  double _discountPrice;
  double get discountPrice => _$this._discountPrice;
  set discountPrice(double discountPrice) =>
      _$this._discountPrice = discountPrice;

  String _userId;
  String get userId => _$this._userId;
  set userId(String userId) => _$this._userId = userId;

  ListBuilder<String> _color;
  ListBuilder<String> get color => _$this._color ??= new ListBuilder<String>();
  set color(ListBuilder<String> color) => _$this._color = color;

  ListBuilder<String> _size;
  ListBuilder<String> get size => _$this._size ??= new ListBuilder<String>();
  set size(ListBuilder<String> size) => _$this._size = size;

  ListBuilder<CutRecord> _cuts;
  ListBuilder<CutRecord> get cuts =>
      _$this._cuts ??= new ListBuilder<CutRecord>();
  set cuts(ListBuilder<CutRecord> cuts) => _$this._cuts = cuts;

  ListBuilder<String> _imageId;
  ListBuilder<String> get imageId =>
      _$this._imageId ??= new ListBuilder<String>();
  set imageId(ListBuilder<String> imageId) => _$this._imageId = imageId;

  ListBuilder<String> _search;
  ListBuilder<String> get search =>
      _$this._search ??= new ListBuilder<String>();
  set search(ListBuilder<String> search) => _$this._search = search;

  String _productId;
  String get productId => _$this._productId;
  set productId(String productId) => _$this._productId = productId;

  String _brand;
  String get brand => _$this._brand;
  set brand(String brand) => _$this._brand = brand;

  String _subCategory;
  String get subCategory => _$this._subCategory;
  set subCategory(String subCategory) => _$this._subCategory = subCategory;

  String _category;
  String get category => _$this._category;
  set category(String category) => _$this._category = category;

  bool _available;
  bool get available => _$this._available;
  set available(bool available) => _$this._available = available;

  bool _open;
  bool get open => _$this._open;
  set open(bool open) => _$this._open = open;

  String _branchId;
  String get branchId => _$this._branchId;
  set branchId(String branchId) => _$this._branchId = branchId;

  double _start;
  double get start => _$this._start;
  set start(double start) => _$this._start = start;

  double _step;
  double get step => _$this._step;
  set step(double step) => _$this._step = step;

  double _stop;
  double get stop => _$this._stop;
  set stop(double stop) => _$this._stop = stop;

  DocumentReference<Object> _reference;
  DocumentReference<Object> get reference => _$this._reference;
  set reference(DocumentReference<Object> reference) =>
      _$this._reference = reference;

  NewProductsRecordBuilder() {
    NewProductsRecord._initializeBuilder(this);
  }

  NewProductsRecordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _unit = $v.unit;
      _shopId = $v.shopId;
      _shopName = $v.shopName;
      _ones = $v.ones;
      _twos = $v.twos;
      _threes = $v.threes;
      _fours = $v.fours;
      _fives = $v.fives;
      _description = $v.description;
      _price = $v.price;
      _discountPrice = $v.discountPrice;
      _userId = $v.userId;
      _color = $v.color?.toBuilder();
      _size = $v.size?.toBuilder();
      _cuts = $v.cuts?.toBuilder();
      _imageId = $v.imageId?.toBuilder();
      _search = $v.search?.toBuilder();
      _productId = $v.productId;
      _brand = $v.brand;
      _subCategory = $v.subCategory;
      _category = $v.category;
      _available = $v.available;
      _open = $v.open;
      _branchId = $v.branchId;
      _start = $v.start;
      _step = $v.step;
      _stop = $v.stop;
      _reference = $v.reference;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(NewProductsRecord other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$NewProductsRecord;
  }

  @override
  void update(void Function(NewProductsRecordBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$NewProductsRecord build() {
    _$NewProductsRecord _$result;
    try {
      _$result = _$v ??
          new _$NewProductsRecord._(
              name: name,
              unit: unit,
              shopId: shopId,
              shopName: shopName,
              ones: ones,
              twos: twos,
              threes: threes,
              fours: fours,
              fives: fives,
              description: description,
              price: price,
              discountPrice: discountPrice,
              userId: userId,
              color: _color?.build(),
              size: _size?.build(),
              cuts: _cuts?.build(),
              imageId: _imageId?.build(),
              search: _search?.build(),
              productId: productId,
              brand: brand,
              subCategory: subCategory,
              category: category,
              available: available,
              open: open,
              branchId: branchId,
              start: start,
              step: step,
              stop: stop,
              reference: reference);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'color';
        _color?.build();
        _$failedField = 'size';
        _size?.build();
        _$failedField = 'cuts';
        _cuts?.build();
        _$failedField = 'imageId';
        _imageId?.build();
        _$failedField = 'search';
        _search?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'NewProductsRecord', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
