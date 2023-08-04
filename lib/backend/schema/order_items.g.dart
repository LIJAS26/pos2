// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=2.9

part of 'order_items.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<OrderItems> _$orderItemsSerializer = new _$OrderItemsSerializer();

class _$OrderItemsSerializer implements StructuredSerializer<OrderItems> {
  @override
  final Iterable<Type> types = const [OrderItems, _$OrderItems];
  @override
  final String wireName = 'OrderItems';

  @override
  Iterable<Object> serialize(Serializers serializers, OrderItems object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'color',
      serializers.serialize(object.color,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'quantity',
      serializers.serialize(object.quantity,
          specifiedType: const FullType(double)),
      'size',
      serializers.serialize(object.size, specifiedType: const FullType(String)),
    ];
    Object value;
    value = object.shopId;
    if (value != null) {
      result
        ..add('shopId')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.status;
    if (value != null) {
      result
        ..add('status')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.shopDiscount;
    if (value != null) {
      result
        ..add('shopDiscount')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    return result;
  }

  @override
  OrderItems deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new OrderItemsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object value = iterator.current;
      switch (key) {
        case 'color':
          result.color = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'quantity':
          result.quantity = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'size':
          result.size = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'shopId':
          result.shopId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'status':
          result.status = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'shopDiscount':
          result.shopDiscount = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
      }
    }

    return result.build();
  }
}

class _$OrderItems extends OrderItems {
  @override
  final String color;
  @override
  final String id;
  @override
  final String name;
  @override
  final double quantity;
  @override
  final String size;
  @override
  final String shopId;
  @override
  final int status;
  @override
  final double shopDiscount;

  factory _$OrderItems([void Function(OrderItemsBuilder) updates]) =>
      (new OrderItemsBuilder()..update(updates)).build();

  _$OrderItems._(
      {this.color,
      this.id,
      this.name,
      this.quantity,
      this.size,
      this.shopId,
      this.status,
      this.shopDiscount})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(color, 'OrderItems', 'color');
    BuiltValueNullFieldError.checkNotNull(id, 'OrderItems', 'id');
    BuiltValueNullFieldError.checkNotNull(name, 'OrderItems', 'name');
    BuiltValueNullFieldError.checkNotNull(quantity, 'OrderItems', 'quantity');
    BuiltValueNullFieldError.checkNotNull(size, 'OrderItems', 'size');
  }

  @override
  OrderItems rebuild(void Function(OrderItemsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  OrderItemsBuilder toBuilder() => new OrderItemsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is OrderItems &&
        color == other.color &&
        id == other.id &&
        name == other.name &&
        quantity == other.quantity &&
        size == other.size &&
        shopId == other.shopId &&
        status == other.status &&
        shopDiscount == other.shopDiscount;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc($jc($jc(0, color.hashCode), id.hashCode),
                            name.hashCode),
                        quantity.hashCode),
                    size.hashCode),
                shopId.hashCode),
            status.hashCode),
        shopDiscount.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('OrderItems')
          ..add('color', color)
          ..add('id', id)
          ..add('name', name)
          ..add('quantity', quantity)
          ..add('size', size)
          ..add('shopId', shopId)
          ..add('status', status)
          ..add('shopDiscount', shopDiscount))
        .toString();
  }
}

class OrderItemsBuilder implements Builder<OrderItems, OrderItemsBuilder> {
  _$OrderItems _$v;

  String _color;
  String get color => _$this._color;
  set color(String color) => _$this._color = color;

  String _id;
  String get id => _$this._id;
  set id(String id) => _$this._id = id;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  double _quantity;
  double get quantity => _$this._quantity;
  set quantity(double quantity) => _$this._quantity = quantity;

  String _size;
  String get size => _$this._size;
  set size(String size) => _$this._size = size;

  String _shopId;
  String get shopId => _$this._shopId;
  set shopId(String shopId) => _$this._shopId = shopId;

  int _status;
  int get status => _$this._status;
  set status(int status) => _$this._status = status;

  double _shopDiscount;
  double get shopDiscount => _$this._shopDiscount;
  set shopDiscount(double shopDiscount) => _$this._shopDiscount = shopDiscount;

  OrderItemsBuilder();

  OrderItemsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _color = $v.color;
      _id = $v.id;
      _name = $v.name;
      _quantity = $v.quantity;
      _size = $v.size;
      _shopId = $v.shopId;
      _status = $v.status;
      _shopDiscount = $v.shopDiscount;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(OrderItems other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$OrderItems;
  }

  @override
  void update(void Function(OrderItemsBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$OrderItems build() {
    final _$result = _$v ??
        new _$OrderItems._(
            color: BuiltValueNullFieldError.checkNotNull(
                color, 'OrderItems', 'color'),
            id: BuiltValueNullFieldError.checkNotNull(id, 'OrderItems', 'id'),
            name: BuiltValueNullFieldError.checkNotNull(
                name, 'OrderItems', 'name'),
            quantity: BuiltValueNullFieldError.checkNotNull(
                quantity, 'OrderItems', 'quantity'),
            size: BuiltValueNullFieldError.checkNotNull(
                size, 'OrderItems', 'size'),
            shopId: shopId,
            status: status,
            shopDiscount: shopDiscount);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
