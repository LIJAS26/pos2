// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=2.9

part of 'orders_record.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<OrdersRecord> _$ordersRecordSerializer =
    new _$OrdersRecordSerializer();

class _$OrdersRecordSerializer implements StructuredSerializer<OrdersRecord> {
  @override
  final Iterable<Type> types = const [OrdersRecord, _$OrdersRecord];
  @override
  final String wireName = 'OrdersRecord';

  @override
  Iterable<Object> serialize(Serializers serializers, OrdersRecord object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    Object value;
    value = object.paymentCard;
    if (value != null) {
      result
        ..add('paymentCard')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.placedDate;
    if (value != null) {
      result
        ..add('placedDate')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(Timestamp)));
    }
    value = object.cancelledDate;
    if (value != null) {
      result
        ..add('cancelledDate')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(Timestamp)));
    }
    value = object.acceptedDate;
    if (value != null) {
      result
        ..add('acceptedDate')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(Timestamp)));
    }
    value = object.shippedDate;
    if (value != null) {
      result
        ..add('shippedDate')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(Timestamp)));
    }
    value = object.deliveredDate;
    if (value != null) {
      result
        ..add('deliveredDate')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(Timestamp)));
    }
    value = object.price;
    if (value != null) {
      result
        ..add('price')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.shippingMethod;
    if (value != null) {
      result
        ..add('shippingMethod')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.userId;
    if (value != null) {
      result
        ..add('userId')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.items;
    if (value != null) {
      result
        ..add('items')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(BuiltList, const [const FullType(OrderItems)])));
    }
    value = object.shops;
    if (value != null) {
      result
        ..add('shops')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(BuiltList, const [const FullType(String)])));
    }
    value = object.shippingAddress;
    if (value != null) {
      result
        ..add('shippingAddress')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(BuiltMap,
                const [const FullType(String), const FullType(String)])));
    }
    value = object.orderStatus;
    if (value != null) {
      result
        ..add('orderStatus')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.deliveryCharge;
    if (value != null) {
      result
        ..add('deliveryCharge')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.tip;
    if (value != null) {
      result
        ..add('tip')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.promoDiscount;
    if (value != null) {
      result
        ..add('promoDiscount')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.promoCode;
    if (value != null) {
      result
        ..add('promoCode')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.driverName;
    if (value != null) {
      result
        ..add('driverName')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.driverId;
    if (value != null) {
      result
        ..add('driverId')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.deliveryPin;
    if (value != null) {
      result
        ..add('deliveryPin')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.branchId;
    if (value != null) {
      result
        ..add('branchId')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
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
  OrdersRecord deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new OrdersRecordBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object value = iterator.current;
      switch (key) {
        case 'paymentCard':
          result.paymentCard = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'placedDate':
          result.placedDate = serializers.deserialize(value,
              specifiedType: const FullType(Timestamp)) as Timestamp;
          break;
        case 'cancelledDate':
          result.cancelledDate = serializers.deserialize(value,
              specifiedType: const FullType(Timestamp)) as Timestamp;
          break;
        case 'acceptedDate':
          result.acceptedDate = serializers.deserialize(value,
              specifiedType: const FullType(Timestamp)) as Timestamp;
          break;
        case 'shippedDate':
          result.shippedDate = serializers.deserialize(value,
              specifiedType: const FullType(Timestamp)) as Timestamp;
          break;
        case 'deliveredDate':
          result.deliveredDate = serializers.deserialize(value,
              specifiedType: const FullType(Timestamp)) as Timestamp;
          break;
        case 'price':
          result.price = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'shippingMethod':
          result.shippingMethod = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'userId':
          result.userId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'items':
          result.items.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(OrderItems)]))
              as BuiltList<Object>);
          break;
        case 'shops':
          result.shops.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(String)]))
              as BuiltList<Object>);
          break;
        case 'shippingAddress':
          result.shippingAddress.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap,
                  const [const FullType(String), const FullType(String)])));
          break;
        case 'orderStatus':
          result.orderStatus = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'deliveryCharge':
          result.deliveryCharge = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'tip':
          result.tip = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'promoDiscount':
          result.promoDiscount = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'promoCode':
          result.promoCode = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'driverName':
          result.driverName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'driverId':
          result.driverId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'deliveryPin':
          result.deliveryPin = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'branchId':
          result.branchId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
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

class _$OrdersRecord extends OrdersRecord {
  @override
  final String paymentCard;
  @override
  final Timestamp placedDate;
  @override
  final Timestamp cancelledDate;
  @override
  final Timestamp acceptedDate;
  @override
  final Timestamp shippedDate;
  @override
  final Timestamp deliveredDate;
  @override
  final double price;
  @override
  final String shippingMethod;
  @override
  final String userId;
  @override
  final BuiltList<OrderItems> items;
  @override
  final BuiltList<String> shops;
  @override
  final BuiltMap<String, String> shippingAddress;
  @override
  final int orderStatus;
  @override
  final double deliveryCharge;
  @override
  final double tip;
  @override
  final double promoDiscount;
  @override
  final String promoCode;
  @override
  final String driverName;
  @override
  final String driverId;
  @override
  final String deliveryPin;
  @override
  final String branchId;
  @override
  final DocumentReference<Object> reference;

  factory _$OrdersRecord([void Function(OrdersRecordBuilder) updates]) =>
      (new OrdersRecordBuilder()..update(updates)).build();

  _$OrdersRecord._(
      {this.paymentCard,
      this.placedDate,
      this.cancelledDate,
      this.acceptedDate,
      this.shippedDate,
      this.deliveredDate,
      this.price,
      this.shippingMethod,
      this.userId,
      this.items,
      this.shops,
      this.shippingAddress,
      this.orderStatus,
      this.deliveryCharge,
      this.tip,
      this.promoDiscount,
      this.promoCode,
      this.driverName,
      this.driverId,
      this.deliveryPin,
      this.branchId,
      this.reference})
      : super._();

  @override
  OrdersRecord rebuild(void Function(OrdersRecordBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  OrdersRecordBuilder toBuilder() => new OrdersRecordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is OrdersRecord &&
        paymentCard == other.paymentCard &&
        placedDate == other.placedDate &&
        cancelledDate == other.cancelledDate &&
        acceptedDate == other.acceptedDate &&
        shippedDate == other.shippedDate &&
        deliveredDate == other.deliveredDate &&
        price == other.price &&
        shippingMethod == other.shippingMethod &&
        userId == other.userId &&
        items == other.items &&
        shops == other.shops &&
        shippingAddress == other.shippingAddress &&
        orderStatus == other.orderStatus &&
        deliveryCharge == other.deliveryCharge &&
        tip == other.tip &&
        promoDiscount == other.promoDiscount &&
        promoCode == other.promoCode &&
        driverName == other.driverName &&
        driverId == other.driverId &&
        deliveryPin == other.deliveryPin &&
        branchId == other.branchId &&
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
                                                                            $jc($jc($jc($jc(0, paymentCard.hashCode), placedDate.hashCode), cancelledDate.hashCode),
                                                                                acceptedDate.hashCode),
                                                                            shippedDate.hashCode),
                                                                        deliveredDate.hashCode),
                                                                    price.hashCode),
                                                                shippingMethod.hashCode),
                                                            userId.hashCode),
                                                        items.hashCode),
                                                    shops.hashCode),
                                                shippingAddress.hashCode),
                                            orderStatus.hashCode),
                                        deliveryCharge.hashCode),
                                    tip.hashCode),
                                promoDiscount.hashCode),
                            promoCode.hashCode),
                        driverName.hashCode),
                    driverId.hashCode),
                deliveryPin.hashCode),
            branchId.hashCode),
        reference.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('OrdersRecord')
          ..add('paymentCard', paymentCard)
          ..add('placedDate', placedDate)
          ..add('cancelledDate', cancelledDate)
          ..add('acceptedDate', acceptedDate)
          ..add('shippedDate', shippedDate)
          ..add('deliveredDate', deliveredDate)
          ..add('price', price)
          ..add('shippingMethod', shippingMethod)
          ..add('userId', userId)
          ..add('items', items)
          ..add('shops', shops)
          ..add('shippingAddress', shippingAddress)
          ..add('orderStatus', orderStatus)
          ..add('deliveryCharge', deliveryCharge)
          ..add('tip', tip)
          ..add('promoDiscount', promoDiscount)
          ..add('promoCode', promoCode)
          ..add('driverName', driverName)
          ..add('driverId', driverId)
          ..add('deliveryPin', deliveryPin)
          ..add('branchId', branchId)
          ..add('reference', reference))
        .toString();
  }
}

class OrdersRecordBuilder
    implements Builder<OrdersRecord, OrdersRecordBuilder> {
  _$OrdersRecord _$v;

  String _paymentCard;
  String get paymentCard => _$this._paymentCard;
  set paymentCard(String paymentCard) => _$this._paymentCard = paymentCard;

  Timestamp _placedDate;
  Timestamp get placedDate => _$this._placedDate;
  set placedDate(Timestamp placedDate) => _$this._placedDate = placedDate;

  Timestamp _cancelledDate;
  Timestamp get cancelledDate => _$this._cancelledDate;
  set cancelledDate(Timestamp cancelledDate) =>
      _$this._cancelledDate = cancelledDate;

  Timestamp _acceptedDate;
  Timestamp get acceptedDate => _$this._acceptedDate;
  set acceptedDate(Timestamp acceptedDate) =>
      _$this._acceptedDate = acceptedDate;

  Timestamp _shippedDate;
  Timestamp get shippedDate => _$this._shippedDate;
  set shippedDate(Timestamp shippedDate) => _$this._shippedDate = shippedDate;

  Timestamp _deliveredDate;
  Timestamp get deliveredDate => _$this._deliveredDate;
  set deliveredDate(Timestamp deliveredDate) =>
      _$this._deliveredDate = deliveredDate;

  double _price;
  double get price => _$this._price;
  set price(double price) => _$this._price = price;

  String _shippingMethod;
  String get shippingMethod => _$this._shippingMethod;
  set shippingMethod(String shippingMethod) =>
      _$this._shippingMethod = shippingMethod;

  String _userId;
  String get userId => _$this._userId;
  set userId(String userId) => _$this._userId = userId;

  ListBuilder<OrderItems> _items;
  ListBuilder<OrderItems> get items =>
      _$this._items ??= new ListBuilder<OrderItems>();
  set items(ListBuilder<OrderItems> items) => _$this._items = items;

  ListBuilder<String> _shops;
  ListBuilder<String> get shops => _$this._shops ??= new ListBuilder<String>();
  set shops(ListBuilder<String> shops) => _$this._shops = shops;

  MapBuilder<String, String> _shippingAddress;
  MapBuilder<String, String> get shippingAddress =>
      _$this._shippingAddress ??= new MapBuilder<String, String>();
  set shippingAddress(MapBuilder<String, String> shippingAddress) =>
      _$this._shippingAddress = shippingAddress;

  int _orderStatus;
  int get orderStatus => _$this._orderStatus;
  set orderStatus(int orderStatus) => _$this._orderStatus = orderStatus;

  double _deliveryCharge;
  double get deliveryCharge => _$this._deliveryCharge;
  set deliveryCharge(double deliveryCharge) =>
      _$this._deliveryCharge = deliveryCharge;

  double _tip;
  double get tip => _$this._tip;
  set tip(double tip) => _$this._tip = tip;

  double _promoDiscount;
  double get promoDiscount => _$this._promoDiscount;
  set promoDiscount(double promoDiscount) =>
      _$this._promoDiscount = promoDiscount;

  String _promoCode;
  String get promoCode => _$this._promoCode;
  set promoCode(String promoCode) => _$this._promoCode = promoCode;

  String _driverName;
  String get driverName => _$this._driverName;
  set driverName(String driverName) => _$this._driverName = driverName;

  String _driverId;
  String get driverId => _$this._driverId;
  set driverId(String driverId) => _$this._driverId = driverId;

  String _deliveryPin;
  String get deliveryPin => _$this._deliveryPin;
  set deliveryPin(String deliveryPin) => _$this._deliveryPin = deliveryPin;

  String _branchId;
  String get branchId => _$this._branchId;
  set branchId(String branchId) => _$this._branchId = branchId;

  DocumentReference<Object> _reference;
  DocumentReference<Object> get reference => _$this._reference;
  set reference(DocumentReference<Object> reference) =>
      _$this._reference = reference;

  OrdersRecordBuilder() {
    OrdersRecord._initializeBuilder(this);
  }

  OrdersRecordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _paymentCard = $v.paymentCard;
      _placedDate = $v.placedDate;
      _cancelledDate = $v.cancelledDate;
      _acceptedDate = $v.acceptedDate;
      _shippedDate = $v.shippedDate;
      _deliveredDate = $v.deliveredDate;
      _price = $v.price;
      _shippingMethod = $v.shippingMethod;
      _userId = $v.userId;
      _items = $v.items?.toBuilder();
      _shops = $v.shops?.toBuilder();
      _shippingAddress = $v.shippingAddress?.toBuilder();
      _orderStatus = $v.orderStatus;
      _deliveryCharge = $v.deliveryCharge;
      _tip = $v.tip;
      _promoDiscount = $v.promoDiscount;
      _promoCode = $v.promoCode;
      _driverName = $v.driverName;
      _driverId = $v.driverId;
      _deliveryPin = $v.deliveryPin;
      _branchId = $v.branchId;
      _reference = $v.reference;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(OrdersRecord other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$OrdersRecord;
  }

  @override
  void update(void Function(OrdersRecordBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$OrdersRecord build() {
    _$OrdersRecord _$result;
    try {
      _$result = _$v ??
          new _$OrdersRecord._(
              paymentCard: paymentCard,
              placedDate: placedDate,
              cancelledDate: cancelledDate,
              acceptedDate: acceptedDate,
              shippedDate: shippedDate,
              deliveredDate: deliveredDate,
              price: price,
              shippingMethod: shippingMethod,
              userId: userId,
              items: _items?.build(),
              shops: _shops?.build(),
              shippingAddress: _shippingAddress?.build(),
              orderStatus: orderStatus,
              deliveryCharge: deliveryCharge,
              tip: tip,
              promoDiscount: promoDiscount,
              promoCode: promoCode,
              driverName: driverName,
              driverId: driverId,
              deliveryPin: deliveryPin,
              branchId: branchId,
              reference: reference);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'items';
        _items?.build();
        _$failedField = 'shops';
        _shops?.build();
        _$failedField = 'shippingAddress';
        _shippingAddress?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'OrdersRecord', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
