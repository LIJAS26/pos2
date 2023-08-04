// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=2.9

part of 'alerts_record.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<AlertsRecord> _$alertsRecordSerializer =
    new _$AlertsRecordSerializer();

class _$AlertsRecordSerializer implements StructuredSerializer<AlertsRecord> {
  @override
  final Iterable<Type> types = const [AlertsRecord, _$AlertsRecord];
  @override
  final String wireName = 'AlertsRecord';

  @override
  Iterable<Object> serialize(Serializers serializers, AlertsRecord object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    Object value;
    value = object.date;
    if (value != null) {
      result
        ..add('date')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(Timestamp)));
    }
    value = object.userId;
    if (value != null) {
      result
        ..add('userId')
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
    value = object.message;
    if (value != null) {
      result
        ..add('message')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.seen;
    if (value != null) {
      result
        ..add('seen')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.link;
    if (value != null) {
      result
        ..add('link')
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
  AlertsRecord deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new AlertsRecordBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object value = iterator.current;
      switch (key) {
        case 'date':
          result.date = serializers.deserialize(value,
              specifiedType: const FullType(Timestamp)) as Timestamp;
          break;
        case 'userId':
          result.userId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'title':
          result.title = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'message':
          result.message = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'seen':
          result.seen = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'link':
          result.link = serializers.deserialize(value,
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

class _$AlertsRecord extends AlertsRecord {
  @override
  final Timestamp date;
  @override
  final String userId;
  @override
  final String title;
  @override
  final String message;
  @override
  final String seen;
  @override
  final String link;
  @override
  final DocumentReference<Object> reference;

  factory _$AlertsRecord([void Function(AlertsRecordBuilder) updates]) =>
      (new AlertsRecordBuilder()..update(updates)).build();

  _$AlertsRecord._(
      {this.date,
      this.userId,
      this.title,
      this.message,
      this.seen,
      this.link,
      this.reference})
      : super._();

  @override
  AlertsRecord rebuild(void Function(AlertsRecordBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AlertsRecordBuilder toBuilder() => new AlertsRecordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AlertsRecord &&
        date == other.date &&
        userId == other.userId &&
        title == other.title &&
        message == other.message &&
        seen == other.seen &&
        link == other.link &&
        reference == other.reference;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc($jc($jc(0, date.hashCode), userId.hashCode),
                        title.hashCode),
                    message.hashCode),
                seen.hashCode),
            link.hashCode),
        reference.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('AlertsRecord')
          ..add('date', date)
          ..add('userId', userId)
          ..add('title', title)
          ..add('message', message)
          ..add('seen', seen)
          ..add('link', link)
          ..add('reference', reference))
        .toString();
  }
}

class AlertsRecordBuilder
    implements Builder<AlertsRecord, AlertsRecordBuilder> {
  _$AlertsRecord _$v;

  Timestamp _date;
  Timestamp get date => _$this._date;
  set date(Timestamp date) => _$this._date = date;

  String _userId;
  String get userId => _$this._userId;
  set userId(String userId) => _$this._userId = userId;

  String _title;
  String get title => _$this._title;
  set title(String title) => _$this._title = title;

  String _message;
  String get message => _$this._message;
  set message(String message) => _$this._message = message;

  String _seen;
  String get seen => _$this._seen;
  set seen(String seen) => _$this._seen = seen;

  String _link;
  String get link => _$this._link;
  set link(String link) => _$this._link = link;

  DocumentReference<Object> _reference;
  DocumentReference<Object> get reference => _$this._reference;
  set reference(DocumentReference<Object> reference) =>
      _$this._reference = reference;

  AlertsRecordBuilder() {
    AlertsRecord._initializeBuilder(this);
  }

  AlertsRecordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _date = $v.date;
      _userId = $v.userId;
      _title = $v.title;
      _message = $v.message;
      _seen = $v.seen;
      _link = $v.link;
      _reference = $v.reference;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AlertsRecord other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$AlertsRecord;
  }

  @override
  void update(void Function(AlertsRecordBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$AlertsRecord build() {
    final _$result = _$v ??
        new _$AlertsRecord._(
            date: date,
            userId: userId,
            title: title,
            message: message,
            seen: seen,
            link: link,
            reference: reference);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
