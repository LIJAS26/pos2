//@dart=2.9
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


import 'serializers.dart';

part 'review_record.g.dart';

abstract class ReviewRecord
    implements Built<ReviewRecord, ReviewRecordBuilder> {


  @nullable
  String get avatarUrl;

  @nullable
  String get userId;

  @nullable
  String get username;

  @nullable
  double get rating;

  @nullable
  String get review;

  @nullable
  Timestamp get timestamp;


  ReviewRecord._();

  factory ReviewRecord([updates(ReviewRecordBuilder b)]) = _$ReviewRecord;

  static Serializer<ReviewRecord> get serializer =>
      _$reviewRecordSerializer;
}

  Map<String, dynamic> createReviewRecordData({
  String avatarUrl,
  String  userId,
  String  username,
   double  rating,
  String  review,
  Timestamp timestamp,
  }) =>
      serializers.serializeWith(
          ReviewRecord.serializer,
          ReviewRecord((n) => n
            ..avatarUrl = avatarUrl
            ..userId = userId
            ..username = username
            ..rating=rating
            ..review = review
            ..timestamp=timestamp));
