// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=2.9

part of 'admin_users_record.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<AdminUsersRecord> _$adminUsersRecordSerializer =
    new _$AdminUsersRecordSerializer();

class _$AdminUsersRecordSerializer
    implements StructuredSerializer<AdminUsersRecord> {
  @override
  final Iterable<Type> types = const [AdminUsersRecord, _$AdminUsersRecord];
  @override
  final String wireName = 'AdminUsersRecord';

  @override
  Iterable<Object> serialize(Serializers serializers, AdminUsersRecord object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    Object value;
    value = object.email;
    if (value != null) {
      result
        ..add('email')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
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
    value = object.createdTime;
    if (value != null) {
      result
        ..add('created_time')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(Timestamp)));
    }
    value = object.verified;
    if (value != null) {
      result
        ..add('verified')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.mobileNumber;
    if (value != null) {
      result
        ..add('mobileNumber')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.userId;
    if (value != null) {
      result
        ..add('userId')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                DocumentReference, const [const FullType(Object)])));
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
  AdminUsersRecord deserialize(
      Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new AdminUsersRecordBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object value = iterator.current;
      switch (key) {
        case 'email':
          result.email = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
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
        case 'created_time':
          result.createdTime = serializers.deserialize(value,
              specifiedType: const FullType(Timestamp)) as Timestamp;
          break;
        case 'verified':
          result.verified = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'mobileNumber':
          result.mobileNumber = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'userId':
          result.userId = serializers.deserialize(value,
                  specifiedType: const FullType(
                      DocumentReference, const [const FullType(Object)]))
              as DocumentReference<Object>;
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

class _$AdminUsersRecord extends AdminUsersRecord {
  @override
  final String email;
  @override
  final String displayName;
  @override
  final String photoUrl;
  @override
  final String uid;
  @override
  final Timestamp createdTime;
  @override
  final bool verified;
  @override
  final String mobileNumber;
  @override
  final DocumentReference<Object> userId;
  @override
  final DocumentReference<Object> reference;

  factory _$AdminUsersRecord(
          [void Function(AdminUsersRecordBuilder) updates]) =>
      (new AdminUsersRecordBuilder()..update(updates)).build();

  _$AdminUsersRecord._(
      {this.email,
      this.displayName,
      this.photoUrl,
      this.uid,
      this.createdTime,
      this.verified,
      this.mobileNumber,
      this.userId,
      this.reference})
      : super._();

  @override
  AdminUsersRecord rebuild(void Function(AdminUsersRecordBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AdminUsersRecordBuilder toBuilder() =>
      new AdminUsersRecordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AdminUsersRecord &&
        email == other.email &&
        displayName == other.displayName &&
        photoUrl == other.photoUrl &&
        uid == other.uid &&
        createdTime == other.createdTime &&
        verified == other.verified &&
        mobileNumber == other.mobileNumber &&
        userId == other.userId &&
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
                                $jc($jc(0, email.hashCode),
                                    displayName.hashCode),
                                photoUrl.hashCode),
                            uid.hashCode),
                        createdTime.hashCode),
                    verified.hashCode),
                mobileNumber.hashCode),
            userId.hashCode),
        reference.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('AdminUsersRecord')
          ..add('email', email)
          ..add('displayName', displayName)
          ..add('photoUrl', photoUrl)
          ..add('uid', uid)
          ..add('createdTime', createdTime)
          ..add('verified', verified)
          ..add('mobileNumber', mobileNumber)
          ..add('userId', userId)
          ..add('reference', reference))
        .toString();
  }
}

class AdminUsersRecordBuilder
    implements Builder<AdminUsersRecord, AdminUsersRecordBuilder> {
  _$AdminUsersRecord _$v;

  String _email;
  String get email => _$this._email;
  set email(String email) => _$this._email = email;

  String _displayName;
  String get displayName => _$this._displayName;
  set displayName(String displayName) => _$this._displayName = displayName;

  String _photoUrl;
  String get photoUrl => _$this._photoUrl;
  set photoUrl(String photoUrl) => _$this._photoUrl = photoUrl;

  String _uid;
  String get uid => _$this._uid;
  set uid(String uid) => _$this._uid = uid;

  Timestamp _createdTime;
  Timestamp get createdTime => _$this._createdTime;
  set createdTime(Timestamp createdTime) => _$this._createdTime = createdTime;

  bool _verified;
  bool get verified => _$this._verified;
  set verified(bool verified) => _$this._verified = verified;

  String _mobileNumber;
  String get mobileNumber => _$this._mobileNumber;
  set mobileNumber(String mobileNumber) => _$this._mobileNumber = mobileNumber;

  DocumentReference<Object> _userId;
  DocumentReference<Object> get userId => _$this._userId;
  set userId(DocumentReference<Object> userId) => _$this._userId = userId;

  DocumentReference<Object> _reference;
  DocumentReference<Object> get reference => _$this._reference;
  set reference(DocumentReference<Object> reference) =>
      _$this._reference = reference;

  AdminUsersRecordBuilder() {
    AdminUsersRecord._initializeBuilder(this);
  }

  AdminUsersRecordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _email = $v.email;
      _displayName = $v.displayName;
      _photoUrl = $v.photoUrl;
      _uid = $v.uid;
      _createdTime = $v.createdTime;
      _verified = $v.verified;
      _mobileNumber = $v.mobileNumber;
      _userId = $v.userId;
      _reference = $v.reference;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AdminUsersRecord other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$AdminUsersRecord;
  }

  @override
  void update(void Function(AdminUsersRecordBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$AdminUsersRecord build() {
    final _$result = _$v ??
        new _$AdminUsersRecord._(
            email: email,
            displayName: displayName,
            photoUrl: photoUrl,
            uid: uid,
            createdTime: createdTime,
            verified: verified,
            mobileNumber: mobileNumber,
            userId: userId,
            reference: reference);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
