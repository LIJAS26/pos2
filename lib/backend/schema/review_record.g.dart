// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=2.9

part of 'review_record.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<ReviewRecord> _$reviewRecordSerializer =
    new _$ReviewRecordSerializer();

class _$ReviewRecordSerializer implements StructuredSerializer<ReviewRecord> {
  @override
  final Iterable<Type> types = const [ReviewRecord, _$ReviewRecord];
  @override
  final String wireName = 'ReviewRecord';

  @override
  Iterable<Object> serialize(Serializers serializers, ReviewRecord object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    Object value;
    value = object.avatarUrl;
    if (value != null) {
      result
        ..add('avatarUrl')
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
    value = object.username;
    if (value != null) {
      result
        ..add('username')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.rating;
    if (value != null) {
      result
        ..add('rating')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(double)));
    }
    value = object.review;
    if (value != null) {
      result
        ..add('review')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.timestamp;
    if (value != null) {
      result
        ..add('timestamp')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(Timestamp)));
    }
    return result;
  }

  @override
  ReviewRecord deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ReviewRecordBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object value = iterator.current;
      switch (key) {
        case 'avatarUrl':
          result.avatarUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'userId':
          result.userId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'username':
          result.username = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'rating':
          result.rating = serializers.deserialize(value,
              specifiedType: const FullType(double)) as double;
          break;
        case 'review':
          result.review = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'timestamp':
          result.timestamp = serializers.deserialize(value,
              specifiedType: const FullType(Timestamp)) as Timestamp;
          break;
      }
    }

    return result.build();
  }
}

class _$ReviewRecord extends ReviewRecord {
  @override
  final String avatarUrl;
  @override
  final String userId;
  @override
  final String username;
  @override
  final double rating;
  @override
  final String review;
  @override
  final Timestamp timestamp;

  factory _$ReviewRecord([void Function(ReviewRecordBuilder) updates]) =>
      (new ReviewRecordBuilder()..update(updates)).build();

  _$ReviewRecord._(
      {this.avatarUrl,
      this.userId,
      this.username,
      this.rating,
      this.review,
      this.timestamp})
      : super._();

  @override
  ReviewRecord rebuild(void Function(ReviewRecordBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ReviewRecordBuilder toBuilder() => new ReviewRecordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ReviewRecord &&
        avatarUrl == other.avatarUrl &&
        userId == other.userId &&
        username == other.username &&
        rating == other.rating &&
        review == other.review &&
        timestamp == other.timestamp;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc($jc($jc(0, avatarUrl.hashCode), userId.hashCode),
                    username.hashCode),
                rating.hashCode),
            review.hashCode),
        timestamp.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ReviewRecord')
          ..add('avatarUrl', avatarUrl)
          ..add('userId', userId)
          ..add('username', username)
          ..add('rating', rating)
          ..add('review', review)
          ..add('timestamp', timestamp))
        .toString();
  }
}

class ReviewRecordBuilder
    implements Builder<ReviewRecord, ReviewRecordBuilder> {
  _$ReviewRecord _$v;

  String _avatarUrl;
  String get avatarUrl => _$this._avatarUrl;
  set avatarUrl(String avatarUrl) => _$this._avatarUrl = avatarUrl;

  String _userId;
  String get userId => _$this._userId;
  set userId(String userId) => _$this._userId = userId;

  String _username;
  String get username => _$this._username;
  set username(String username) => _$this._username = username;

  double _rating;
  double get rating => _$this._rating;
  set rating(double rating) => _$this._rating = rating;

  String _review;
  String get review => _$this._review;
  set review(String review) => _$this._review = review;

  Timestamp _timestamp;
  Timestamp get timestamp => _$this._timestamp;
  set timestamp(Timestamp timestamp) => _$this._timestamp = timestamp;

  ReviewRecordBuilder();

  ReviewRecordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _avatarUrl = $v.avatarUrl;
      _userId = $v.userId;
      _username = $v.username;
      _rating = $v.rating;
      _review = $v.review;
      _timestamp = $v.timestamp;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ReviewRecord other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ReviewRecord;
  }

  @override
  void update(void Function(ReviewRecordBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ReviewRecord build() {
    final _$result = _$v ??
        new _$ReviewRecord._(
            avatarUrl: avatarUrl,
            userId: userId,
            username: username,
            rating: rating,
            review: review,
            timestamp: timestamp);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
