// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=2.9

part of 'shops_record.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<ShopsRecord> _$shopsRecordSerializer = new _$ShopsRecordSerializer();

class _$ShopsRecordSerializer implements StructuredSerializer<ShopsRecord> {
  @override
  final Iterable<Type> types = const [ShopsRecord, _$ShopsRecord];
  @override
  final String wireName = 'ShopsRecord';

  @override
  Iterable<Object> serialize(Serializers serializers, ShopsRecord object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    Object value;
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
    value = object.shopId;
    if (value != null) {
      result
        ..add('shopId')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.address;
    if (value != null) {
      result
        ..add('address')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.email;
    if (value != null) {
      result
        ..add('email')
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
    value = object.sunFrom;
    if (value != null) {
      result
        ..add('sunFrom')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.sunTo;
    if (value != null) {
      result
        ..add('sunTo')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.monFrom;
    if (value != null) {
      result
        ..add('monFrom')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.monTo;
    if (value != null) {
      result
        ..add('monTo')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.tueFrom;
    if (value != null) {
      result
        ..add('tueFrom')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.tueTo;
    if (value != null) {
      result
        ..add('tueTo')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.wedFrom;
    if (value != null) {
      result
        ..add('wedFrom')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.wedTo;
    if (value != null) {
      result
        ..add('wedTo')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.thuFrom;
    if (value != null) {
      result
        ..add('thuFrom')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.thuTo;
    if (value != null) {
      result
        ..add('thuTo')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.friFrom;
    if (value != null) {
      result
        ..add('friFrom')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.friTo;
    if (value != null) {
      result
        ..add('friTo')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.satFrom;
    if (value != null) {
      result
        ..add('satFrom')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.satTo;
    if (value != null) {
      result
        ..add('satTo')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.fSSAIRegNo;
    if (value != null) {
      result
        ..add('FSSAIRegNo')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.users;
    if (value != null) {
      result
        ..add('users')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(BuiltList, const [const FullType(String)])));
    }
    value = object.phoneNumber;
    if (value != null) {
      result
        ..add('phoneNumber')
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
    value = object.admins;
    if (value != null) {
      result
        ..add('admins')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(BuiltList, const [const FullType(String)])));
    }
    value = object.online;
    if (value != null) {
      result
        ..add('online')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.discount;
    if (value != null) {
      result
        ..add('discount')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.paid;
    if (value != null) {
      result
        ..add('paid')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.sales;
    if (value != null) {
      result
        ..add('sales')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.paidUpdate;
    if (value != null) {
      result
        ..add('paidUpdate')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(Timestamp)));
    }
    value = object.salesUpdate;
    if (value != null) {
      result
        ..add('salesUpdate')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(Timestamp)));
    }
    value = object.branchId;
    if (value != null) {
      result
        ..add('branchId')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.latitude;
    if (value != null) {
      result
        ..add('latitude')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.longitude;
    if (value != null) {
      result
        ..add('longitude')
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
  ShopsRecord deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ShopsRecordBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object value = iterator.current;
      switch (key) {
        case 'imageUrl':
          result.imageUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'shopId':
          result.shopId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'address':
          result.address = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'email':
          result.email = serializers.deserialize(value,
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
        case 'sunFrom':
          result.sunFrom = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'sunTo':
          result.sunTo = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'monFrom':
          result.monFrom = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'monTo':
          result.monTo = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'tueFrom':
          result.tueFrom = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'tueTo':
          result.tueTo = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'wedFrom':
          result.wedFrom = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'wedTo':
          result.wedTo = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'thuFrom':
          result.thuFrom = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'thuTo':
          result.thuTo = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'friFrom':
          result.friFrom = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'friTo':
          result.friTo = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'satFrom':
          result.satFrom = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'satTo':
          result.satTo = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'FSSAIRegNo':
          result.fSSAIRegNo = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'users':
          result.users.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(String)]))
              as BuiltList<Object>);
          break;
        case 'phoneNumber':
          result.phoneNumber = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'search':
          result.search.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(String)]))
              as BuiltList<Object>);
          break;
        case 'admins':
          result.admins.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(String)]))
              as BuiltList<Object>);
          break;
        case 'online':
          result.online = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'discount':
          result.discount = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'paid':
          result.paid = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'sales':
          result.sales = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'paidUpdate':
          result.paidUpdate = serializers.deserialize(value,
              specifiedType: const FullType(Timestamp)) as Timestamp;
          break;
        case 'salesUpdate':
          result.salesUpdate = serializers.deserialize(value,
              specifiedType: const FullType(Timestamp)) as Timestamp;
          break;
        case 'branchId':
          result.branchId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'latitude':
          result.latitude = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'longitude':
          result.longitude = serializers.deserialize(value,
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

class _$ShopsRecord extends ShopsRecord {
  @override
  final String imageUrl;
  @override
  final String name;
  @override
  final String shopId;
  @override
  final String address;
  @override
  final String email;
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
  final String sunFrom;
  @override
  final String sunTo;
  @override
  final String monFrom;
  @override
  final String monTo;
  @override
  final String tueFrom;
  @override
  final String tueTo;
  @override
  final String wedFrom;
  @override
  final String wedTo;
  @override
  final String thuFrom;
  @override
  final String thuTo;
  @override
  final String friFrom;
  @override
  final String friTo;
  @override
  final String satFrom;
  @override
  final String satTo;
  @override
  final String fSSAIRegNo;
  @override
  final BuiltList<String> users;
  @override
  final String phoneNumber;
  @override
  final BuiltList<String> search;
  @override
  final BuiltList<String> admins;
  @override
  final bool online;
  @override
  final double discount;
  @override
  final double paid;
  @override
  final double sales;
  @override
  final Timestamp paidUpdate;
  @override
  final Timestamp salesUpdate;
  @override
  final String branchId;
  @override
  final double latitude;
  @override
  final double longitude;
  @override
  final DocumentReference<Object> reference;

  factory _$ShopsRecord([void Function(ShopsRecordBuilder) updates]) =>
      (new ShopsRecordBuilder()..update(updates)).build();

  _$ShopsRecord._(
      {this.imageUrl,
      this.name,
      this.shopId,
      this.address,
      this.email,
      this.ones,
      this.twos,
      this.threes,
      this.fours,
      this.fives,
      this.sunFrom,
      this.sunTo,
      this.monFrom,
      this.monTo,
      this.tueFrom,
      this.tueTo,
      this.wedFrom,
      this.wedTo,
      this.thuFrom,
      this.thuTo,
      this.friFrom,
      this.friTo,
      this.satFrom,
      this.satTo,
      this.fSSAIRegNo,
      this.users,
      this.phoneNumber,
      this.search,
      this.admins,
      this.online,
      this.discount,
      this.paid,
      this.sales,
      this.paidUpdate,
      this.salesUpdate,
      this.branchId,
      this.latitude,
      this.longitude,
      this.reference})
      : super._();

  @override
  ShopsRecord rebuild(void Function(ShopsRecordBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ShopsRecordBuilder toBuilder() => new ShopsRecordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ShopsRecord &&
        imageUrl == other.imageUrl &&
        name == other.name &&
        shopId == other.shopId &&
        address == other.address &&
        email == other.email &&
        ones == other.ones &&
        twos == other.twos &&
        threes == other.threes &&
        fours == other.fours &&
        fives == other.fives &&
        sunFrom == other.sunFrom &&
        sunTo == other.sunTo &&
        monFrom == other.monFrom &&
        monTo == other.monTo &&
        tueFrom == other.tueFrom &&
        tueTo == other.tueTo &&
        wedFrom == other.wedFrom &&
        wedTo == other.wedTo &&
        thuFrom == other.thuFrom &&
        thuTo == other.thuTo &&
        friFrom == other.friFrom &&
        friTo == other.friTo &&
        satFrom == other.satFrom &&
        satTo == other.satTo &&
        fSSAIRegNo == other.fSSAIRegNo &&
        users == other.users &&
        phoneNumber == other.phoneNumber &&
        search == other.search &&
        admins == other.admins &&
        online == other.online &&
        discount == other.discount &&
        paid == other.paid &&
        sales == other.sales &&
        paidUpdate == other.paidUpdate &&
        salesUpdate == other.salesUpdate &&
        branchId == other.branchId &&
        latitude == other.latitude &&
        longitude == other.longitude &&
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
                                                                            $jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc($jc(0, imageUrl.hashCode), name.hashCode), shopId.hashCode), address.hashCode), email.hashCode), ones.hashCode), twos.hashCode), threes.hashCode), fours.hashCode), fives.hashCode), sunFrom.hashCode), sunTo.hashCode), monFrom.hashCode), monTo.hashCode), tueFrom.hashCode), tueTo.hashCode), wedFrom.hashCode), wedTo.hashCode), thuFrom.hashCode), thuTo.hashCode),
                                                                                friFrom.hashCode),
                                                                            friTo.hashCode),
                                                                        satFrom.hashCode),
                                                                    satTo.hashCode),
                                                                fSSAIRegNo.hashCode),
                                                            users.hashCode),
                                                        phoneNumber.hashCode),
                                                    search.hashCode),
                                                admins.hashCode),
                                            online.hashCode),
                                        discount.hashCode),
                                    paid.hashCode),
                                sales.hashCode),
                            paidUpdate.hashCode),
                        salesUpdate.hashCode),
                    branchId.hashCode),
                latitude.hashCode),
            longitude.hashCode),
        reference.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ShopsRecord')
          ..add('imageUrl', imageUrl)
          ..add('name', name)
          ..add('shopId', shopId)
          ..add('address', address)
          ..add('email', email)
          ..add('ones', ones)
          ..add('twos', twos)
          ..add('threes', threes)
          ..add('fours', fours)
          ..add('fives', fives)
          ..add('sunFrom', sunFrom)
          ..add('sunTo', sunTo)
          ..add('monFrom', monFrom)
          ..add('monTo', monTo)
          ..add('tueFrom', tueFrom)
          ..add('tueTo', tueTo)
          ..add('wedFrom', wedFrom)
          ..add('wedTo', wedTo)
          ..add('thuFrom', thuFrom)
          ..add('thuTo', thuTo)
          ..add('friFrom', friFrom)
          ..add('friTo', friTo)
          ..add('satFrom', satFrom)
          ..add('satTo', satTo)
          ..add('fSSAIRegNo', fSSAIRegNo)
          ..add('users', users)
          ..add('phoneNumber', phoneNumber)
          ..add('search', search)
          ..add('admins', admins)
          ..add('online', online)
          ..add('discount', discount)
          ..add('paid', paid)
          ..add('sales', sales)
          ..add('paidUpdate', paidUpdate)
          ..add('salesUpdate', salesUpdate)
          ..add('branchId', branchId)
          ..add('latitude', latitude)
          ..add('longitude', longitude)
          ..add('reference', reference))
        .toString();
  }
}

class ShopsRecordBuilder implements Builder<ShopsRecord, ShopsRecordBuilder> {
  _$ShopsRecord _$v;

  String _imageUrl;
  String get imageUrl => _$this._imageUrl;
  set imageUrl(String imageUrl) => _$this._imageUrl = imageUrl;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  String _shopId;
  String get shopId => _$this._shopId;
  set shopId(String shopId) => _$this._shopId = shopId;

  String _address;
  String get address => _$this._address;
  set address(String address) => _$this._address = address;

  String _email;
  String get email => _$this._email;
  set email(String email) => _$this._email = email;

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

  String _sunFrom;
  String get sunFrom => _$this._sunFrom;
  set sunFrom(String sunFrom) => _$this._sunFrom = sunFrom;

  String _sunTo;
  String get sunTo => _$this._sunTo;
  set sunTo(String sunTo) => _$this._sunTo = sunTo;

  String _monFrom;
  String get monFrom => _$this._monFrom;
  set monFrom(String monFrom) => _$this._monFrom = monFrom;

  String _monTo;
  String get monTo => _$this._monTo;
  set monTo(String monTo) => _$this._monTo = monTo;

  String _tueFrom;
  String get tueFrom => _$this._tueFrom;
  set tueFrom(String tueFrom) => _$this._tueFrom = tueFrom;

  String _tueTo;
  String get tueTo => _$this._tueTo;
  set tueTo(String tueTo) => _$this._tueTo = tueTo;

  String _wedFrom;
  String get wedFrom => _$this._wedFrom;
  set wedFrom(String wedFrom) => _$this._wedFrom = wedFrom;

  String _wedTo;
  String get wedTo => _$this._wedTo;
  set wedTo(String wedTo) => _$this._wedTo = wedTo;

  String _thuFrom;
  String get thuFrom => _$this._thuFrom;
  set thuFrom(String thuFrom) => _$this._thuFrom = thuFrom;

  String _thuTo;
  String get thuTo => _$this._thuTo;
  set thuTo(String thuTo) => _$this._thuTo = thuTo;

  String _friFrom;
  String get friFrom => _$this._friFrom;
  set friFrom(String friFrom) => _$this._friFrom = friFrom;

  String _friTo;
  String get friTo => _$this._friTo;
  set friTo(String friTo) => _$this._friTo = friTo;

  String _satFrom;
  String get satFrom => _$this._satFrom;
  set satFrom(String satFrom) => _$this._satFrom = satFrom;

  String _satTo;
  String get satTo => _$this._satTo;
  set satTo(String satTo) => _$this._satTo = satTo;

  String _fSSAIRegNo;
  String get fSSAIRegNo => _$this._fSSAIRegNo;
  set fSSAIRegNo(String fSSAIRegNo) => _$this._fSSAIRegNo = fSSAIRegNo;

  ListBuilder<String> _users;
  ListBuilder<String> get users => _$this._users ??= new ListBuilder<String>();
  set users(ListBuilder<String> users) => _$this._users = users;

  String _phoneNumber;
  String get phoneNumber => _$this._phoneNumber;
  set phoneNumber(String phoneNumber) => _$this._phoneNumber = phoneNumber;

  ListBuilder<String> _search;
  ListBuilder<String> get search =>
      _$this._search ??= new ListBuilder<String>();
  set search(ListBuilder<String> search) => _$this._search = search;

  ListBuilder<String> _admins;
  ListBuilder<String> get admins =>
      _$this._admins ??= new ListBuilder<String>();
  set admins(ListBuilder<String> admins) => _$this._admins = admins;

  bool _online;
  bool get online => _$this._online;
  set online(bool online) => _$this._online = online;

  double _discount;
  double get discount => _$this._discount;
  set discount(double discount) => _$this._discount = discount;

  double _paid;
  double get paid => _$this._paid;
  set paid(double paid) => _$this._paid = paid;

  double _sales;
  double get sales => _$this._sales;
  set sales(double sales) => _$this._sales = sales;

  Timestamp _paidUpdate;
  Timestamp get paidUpdate => _$this._paidUpdate;
  set paidUpdate(Timestamp paidUpdate) => _$this._paidUpdate = paidUpdate;

  Timestamp _salesUpdate;
  Timestamp get salesUpdate => _$this._salesUpdate;
  set salesUpdate(Timestamp salesUpdate) => _$this._salesUpdate = salesUpdate;

  String _branchId;
  String get branchId => _$this._branchId;
  set branchId(String branchId) => _$this._branchId = branchId;

  double _latitude;
  double get latitude => _$this._latitude;
  set latitude(double latitude) => _$this._latitude = latitude;

  double _longitude;
  double get longitude => _$this._longitude;
  set longitude(double longitude) => _$this._longitude = longitude;

  DocumentReference<Object> _reference;
  DocumentReference<Object> get reference => _$this._reference;
  set reference(DocumentReference<Object> reference) =>
      _$this._reference = reference;

  ShopsRecordBuilder() {
    ShopsRecord._initializeBuilder(this);
  }

  ShopsRecordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _imageUrl = $v.imageUrl;
      _name = $v.name;
      _shopId = $v.shopId;
      _address = $v.address;
      _email = $v.email;
      _ones = $v.ones;
      _twos = $v.twos;
      _threes = $v.threes;
      _fours = $v.fours;
      _fives = $v.fives;
      _sunFrom = $v.sunFrom;
      _sunTo = $v.sunTo;
      _monFrom = $v.monFrom;
      _monTo = $v.monTo;
      _tueFrom = $v.tueFrom;
      _tueTo = $v.tueTo;
      _wedFrom = $v.wedFrom;
      _wedTo = $v.wedTo;
      _thuFrom = $v.thuFrom;
      _thuTo = $v.thuTo;
      _friFrom = $v.friFrom;
      _friTo = $v.friTo;
      _satFrom = $v.satFrom;
      _satTo = $v.satTo;
      _fSSAIRegNo = $v.fSSAIRegNo;
      _users = $v.users?.toBuilder();
      _phoneNumber = $v.phoneNumber;
      _search = $v.search?.toBuilder();
      _admins = $v.admins?.toBuilder();
      _online = $v.online;
      _discount = $v.discount;
      _paid = $v.paid;
      _sales = $v.sales;
      _paidUpdate = $v.paidUpdate;
      _salesUpdate = $v.salesUpdate;
      _branchId = $v.branchId;
      _latitude = $v.latitude;
      _longitude = $v.longitude;
      _reference = $v.reference;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ShopsRecord other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ShopsRecord;
  }

  @override
  void update(void Function(ShopsRecordBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ShopsRecord build() {
    _$ShopsRecord _$result;
    try {
      _$result = _$v ??
          new _$ShopsRecord._(
              imageUrl: imageUrl,
              name: name,
              shopId: shopId,
              address: address,
              email: email,
              ones: ones,
              twos: twos,
              threes: threes,
              fours: fours,
              fives: fives,
              sunFrom: sunFrom,
              sunTo: sunTo,
              monFrom: monFrom,
              monTo: monTo,
              tueFrom: tueFrom,
              tueTo: tueTo,
              wedFrom: wedFrom,
              wedTo: wedTo,
              thuFrom: thuFrom,
              thuTo: thuTo,
              friFrom: friFrom,
              friTo: friTo,
              satFrom: satFrom,
              satTo: satTo,
              fSSAIRegNo: fSSAIRegNo,
              users: _users?.build(),
              phoneNumber: phoneNumber,
              search: _search?.build(),
              admins: _admins?.build(),
              online: online,
              discount: discount,
              paid: paid,
              sales: sales,
              paidUpdate: paidUpdate,
              salesUpdate: salesUpdate,
              branchId: branchId,
              latitude: latitude,
              longitude: longitude,
              reference: reference);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'users';
        _users?.build();

        _$failedField = 'search';
        _search?.build();
        _$failedField = 'admins';
        _admins?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'ShopsRecord', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
