// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=2.9

part of 'rider_record.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<RiderRecord> _$riderRecordSerializer = new _$RiderRecordSerializer();

class _$RiderRecordSerializer implements StructuredSerializer<RiderRecord> {
  @override
  final Iterable<Type> types = const [RiderRecord, _$RiderRecord];
  @override
  final String wireName = 'RiderRecord';

  @override
  Iterable<Object> serialize(Serializers serializers, RiderRecord object,
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
    value = object.address;
    if (value != null) {
      result
        ..add('address')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.vehicleNo;
    if (value != null) {
      result
        ..add('vehicleNo')
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
    value = object.online;
    if (value != null) {
      result
        ..add('online')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.displayName;
    if (value != null) {
      result
        ..add('display_name')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.photoUrl;
    if (value != null) {
      result
        ..add('photo_url')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.uid;
    if (value != null) {
      result
        ..add('uid')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.walletBalance;
    if (value != null) {
      result
        ..add('walletBalance')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.earnings;
    if (value != null) {
      result
        ..add('earnings')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.tips;
    if (value != null) {
      result
        ..add('tips')
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
    value = object.cashInHand;
    if (value != null) {
      result
        ..add('cashInHand')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.walletUpdate;
    if (value != null) {
      result
        ..add('walletUpdate')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(Timestamp)));
    }
    value = object.earningsUpdate;
    if (value != null) {
      result
        ..add('earningsUpdate')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(Timestamp)));
    }
    value = object.tipsUpdate;
    if (value != null) {
      result
        ..add('tipsUpdate')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(Timestamp)));
    }
    value = object.paidUpdate;
    if (value != null) {
      result
        ..add('paidUpdate')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(Timestamp)));
    }
    value = object.cashInHandUpdate;
    if (value != null) {
      result
        ..add('cashInHandUpdate')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(Timestamp)));
    }
    value = object.createdTime;
    if (value != null) {
      result
        ..add('created_time')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(DateTime)));
    }
    value = object.phoneNumber;
    if (value != null) {
      result
        ..add('phone_number')
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
  RiderRecord deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new RiderRecordBuilder();

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
        case 'address':
          result.address = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'vehicleNo':
          result.vehicleNo = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'email':
          result.email = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'online':
          result.online = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'display_name':
          result.displayName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'photo_url':
          result.photoUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'uid':
          result.uid = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'walletBalance':
          result.walletBalance = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'earnings':
          result.earnings = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'tips':
          result.tips = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'paid':
          result.paid = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'cashInHand':
          result.cashInHand = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'walletUpdate':
          result.walletUpdate = serializers.deserialize(value,
              specifiedType: const FullType(Timestamp)) as Timestamp;
          break;
        case 'earningsUpdate':
          result.earningsUpdate = serializers.deserialize(value,
              specifiedType: const FullType(Timestamp)) as Timestamp;
          break;
        case 'tipsUpdate':
          result.tipsUpdate = serializers.deserialize(value,
              specifiedType: const FullType(Timestamp)) as Timestamp;
          break;
        case 'paidUpdate':
          result.paidUpdate = serializers.deserialize(value,
              specifiedType: const FullType(Timestamp)) as Timestamp;
          break;
        case 'cashInHandUpdate':
          result.cashInHandUpdate = serializers.deserialize(value,
              specifiedType: const FullType(Timestamp)) as Timestamp;
          break;
        case 'created_time':
          result.createdTime = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime;
          break;
        case 'phone_number':
          result.phoneNumber = serializers.deserialize(value,
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

class _$RiderRecord extends RiderRecord {
  @override
  final String name;
  @override
  final String address;
  @override
  final String vehicleNo;
  @override
  final String email;
  @override
  final bool online;
  @override
  final String displayName;
  @override
  final String photoUrl;
  @override
  final String uid;
  @override
  final double walletBalance;
  @override
  final double earnings;
  @override
  final double tips;
  @override
  final double paid;
  @override
  final double cashInHand;
  @override
  final Timestamp walletUpdate;
  @override
  final Timestamp earningsUpdate;
  @override
  final Timestamp tipsUpdate;
  @override
  final Timestamp paidUpdate;
  @override
  final Timestamp cashInHandUpdate;
  @override
  final DateTime createdTime;
  @override
  final String phoneNumber;
  @override
  final DocumentReference<Object> reference;

  factory _$RiderRecord([void Function(RiderRecordBuilder) updates]) =>
      (new RiderRecordBuilder()..update(updates)).build();

  _$RiderRecord._(
      {this.name,
      this.address,
      this.vehicleNo,
      this.email,
      this.online,
      this.displayName,
      this.photoUrl,
      this.uid,
      this.walletBalance,
      this.earnings,
      this.tips,
      this.paid,
      this.cashInHand,
      this.walletUpdate,
      this.earningsUpdate,
      this.tipsUpdate,
      this.paidUpdate,
      this.cashInHandUpdate,
      this.createdTime,
      this.phoneNumber,
      this.reference})
      : super._();

  @override
  RiderRecord rebuild(void Function(RiderRecordBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RiderRecordBuilder toBuilder() => new RiderRecordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RiderRecord &&
        name == other.name &&
        address == other.address &&
        vehicleNo == other.vehicleNo &&
        email == other.email &&
        online == other.online &&
        displayName == other.displayName &&
        photoUrl == other.photoUrl &&
        uid == other.uid &&
        walletBalance == other.walletBalance &&
        earnings == other.earnings &&
        tips == other.tips &&
        paid == other.paid &&
        cashInHand == other.cashInHand &&
        walletUpdate == other.walletUpdate &&
        earningsUpdate == other.earningsUpdate &&
        tipsUpdate == other.tipsUpdate &&
        paidUpdate == other.paidUpdate &&
        cashInHandUpdate == other.cashInHandUpdate &&
        createdTime == other.createdTime &&
        phoneNumber == other.phoneNumber &&
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
                                                                            $jc($jc($jc(0, name.hashCode), address.hashCode),
                                                                                vehicleNo.hashCode),
                                                                            email.hashCode),
                                                                        online.hashCode),
                                                                    displayName.hashCode),
                                                                photoUrl.hashCode),
                                                            uid.hashCode),
                                                        walletBalance.hashCode),
                                                    earnings.hashCode),
                                                tips.hashCode),
                                            paid.hashCode),
                                        cashInHand.hashCode),
                                    walletUpdate.hashCode),
                                earningsUpdate.hashCode),
                            tipsUpdate.hashCode),
                        paidUpdate.hashCode),
                    cashInHandUpdate.hashCode),
                createdTime.hashCode),
            phoneNumber.hashCode),
        reference.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('RiderRecord')
          ..add('name', name)
          ..add('address', address)
          ..add('vehicleNo', vehicleNo)
          ..add('email', email)
          ..add('online', online)
          ..add('displayName', displayName)
          ..add('photoUrl', photoUrl)
          ..add('uid', uid)
          ..add('walletBalance', walletBalance)
          ..add('earnings', earnings)
          ..add('tips', tips)
          ..add('paid', paid)
          ..add('cashInHand', cashInHand)
          ..add('walletUpdate', walletUpdate)
          ..add('earningsUpdate', earningsUpdate)
          ..add('tipsUpdate', tipsUpdate)
          ..add('paidUpdate', paidUpdate)
          ..add('cashInHandUpdate', cashInHandUpdate)
          ..add('createdTime', createdTime)
          ..add('phoneNumber', phoneNumber)
          ..add('reference', reference))
        .toString();
  }
}

class RiderRecordBuilder implements Builder<RiderRecord, RiderRecordBuilder> {
  _$RiderRecord _$v;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  String _address;
  String get address => _$this._address;
  set address(String address) => _$this._address = address;

  String _vehicleNo;
  String get vehicleNo => _$this._vehicleNo;
  set vehicleNo(String vehicleNo) => _$this._vehicleNo = vehicleNo;

  String _email;
  String get email => _$this._email;
  set email(String email) => _$this._email = email;

  bool _online;
  bool get online => _$this._online;
  set online(bool online) => _$this._online = online;

  String _displayName;
  String get displayName => _$this._displayName;
  set displayName(String displayName) => _$this._displayName = displayName;

  String _photoUrl;
  String get photoUrl => _$this._photoUrl;
  set photoUrl(String photoUrl) => _$this._photoUrl = photoUrl;

  String _uid;
  String get uid => _$this._uid;
  set uid(String uid) => _$this._uid = uid;

  double _walletBalance;
  double get walletBalance => _$this._walletBalance;
  set walletBalance(double walletBalance) =>
      _$this._walletBalance = walletBalance;

  double _earnings;
  double get earnings => _$this._earnings;
  set earnings(double earnings) => _$this._earnings = earnings;

  double _tips;
  double get tips => _$this._tips;
  set tips(double tips) => _$this._tips = tips;

  double _paid;
  double get paid => _$this._paid;
  set paid(double paid) => _$this._paid = paid;

  double _cashInHand;
  double get cashInHand => _$this._cashInHand;
  set cashInHand(double cashInHand) => _$this._cashInHand = cashInHand;

  Timestamp _walletUpdate;
  Timestamp get walletUpdate => _$this._walletUpdate;
  set walletUpdate(Timestamp walletUpdate) =>
      _$this._walletUpdate = walletUpdate;

  Timestamp _earningsUpdate;
  Timestamp get earningsUpdate => _$this._earningsUpdate;
  set earningsUpdate(Timestamp earningsUpdate) =>
      _$this._earningsUpdate = earningsUpdate;

  Timestamp _tipsUpdate;
  Timestamp get tipsUpdate => _$this._tipsUpdate;
  set tipsUpdate(Timestamp tipsUpdate) => _$this._tipsUpdate = tipsUpdate;

  Timestamp _paidUpdate;
  Timestamp get paidUpdate => _$this._paidUpdate;
  set paidUpdate(Timestamp paidUpdate) => _$this._paidUpdate = paidUpdate;

  Timestamp _cashInHandUpdate;
  Timestamp get cashInHandUpdate => _$this._cashInHandUpdate;
  set cashInHandUpdate(Timestamp cashInHandUpdate) =>
      _$this._cashInHandUpdate = cashInHandUpdate;

  DateTime _createdTime;
  DateTime get createdTime => _$this._createdTime;
  set createdTime(DateTime createdTime) => _$this._createdTime = createdTime;

  String _phoneNumber;
  String get phoneNumber => _$this._phoneNumber;
  set phoneNumber(String phoneNumber) => _$this._phoneNumber = phoneNumber;

  DocumentReference<Object> _reference;
  DocumentReference<Object> get reference => _$this._reference;
  set reference(DocumentReference<Object> reference) =>
      _$this._reference = reference;

  RiderRecordBuilder() {
    RiderRecord._initializeBuilder(this);
  }

  RiderRecordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _address = $v.address;
      _vehicleNo = $v.vehicleNo;
      _email = $v.email;
      _online = $v.online;
      _displayName = $v.displayName;
      _photoUrl = $v.photoUrl;
      _uid = $v.uid;
      _walletBalance = $v.walletBalance;
      _earnings = $v.earnings;
      _tips = $v.tips;
      _paid = $v.paid;
      _cashInHand = $v.cashInHand;
      _walletUpdate = $v.walletUpdate;
      _earningsUpdate = $v.earningsUpdate;
      _tipsUpdate = $v.tipsUpdate;
      _paidUpdate = $v.paidUpdate;
      _cashInHandUpdate = $v.cashInHandUpdate;
      _createdTime = $v.createdTime;
      _phoneNumber = $v.phoneNumber;
      _reference = $v.reference;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RiderRecord other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$RiderRecord;
  }

  @override
  void update(void Function(RiderRecordBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$RiderRecord build() {
    final _$result = _$v ??
        new _$RiderRecord._(
            name: name,
            address: address,
            vehicleNo: vehicleNo,
            email: email,
            online: online,
            displayName: displayName,
            photoUrl: photoUrl,
            uid: uid,
            walletBalance: walletBalance,
            earnings: earnings,
            tips: tips,
            paid: paid,
            cashInHand: cashInHand,
            walletUpdate: walletUpdate,
            earningsUpdate: earningsUpdate,
            tipsUpdate: tipsUpdate,
            paidUpdate: paidUpdate,
            cashInHandUpdate: cashInHandUpdate,
            createdTime: createdTime,
            phoneNumber: phoneNumber,
            reference: reference);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
