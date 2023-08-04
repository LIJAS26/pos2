//@dart=2.9
import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'rider_record.g.dart';

abstract class RiderRecord implements Built<RiderRecord, RiderRecordBuilder> {
  static Serializer<RiderRecord> get serializer => _$riderRecordSerializer;

  @nullable
  String get name;

  @nullable
  String get address;

  @nullable
  String get vehicleNo;

  @nullable
  String get email;
  @nullable
  bool get online;

  @nullable
  @BuiltValueField(wireName: 'display_name')
  String get displayName;

  @nullable
  @BuiltValueField(wireName: 'photo_url')
  String get photoUrl;

  @nullable
  String get uid;
  @nullable
  double get walletBalance;
  @nullable
  double get earnings;
  @nullable
  double get tips;
  @nullable
  double get paid;
  @nullable
  double get cashInHand;
  @nullable
  Timestamp get walletUpdate;
  @nullable
  Timestamp get earningsUpdate;
  @nullable
  Timestamp get tipsUpdate;
  @nullable
  Timestamp get paidUpdate;
  @nullable
  Timestamp get cashInHandUpdate;


  @nullable
  @BuiltValueField(wireName: 'created_time')
  DateTime get createdTime;

  @nullable
  @BuiltValueField(wireName: 'phone_number')
  String get phoneNumber;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(RiderRecordBuilder builder) => builder
    ..name = ''
    ..address = ''
    ..vehicleNo = ''
    ..email = ''
    ..displayName = ''
    ..photoUrl = ''
    ..uid = ''
    ..online=false
    ..walletBalance=0.0
    ..earnings=0.0
    ..tips=0.0
    ..paid=0.0
    ..cashInHand=0.0
    ..walletUpdate=Timestamp.now()
    ..earningsUpdate=Timestamp.now()
    ..tipsUpdate=Timestamp.now()
    ..paidUpdate=Timestamp.now()
    ..cashInHandUpdate=Timestamp.now()
    ..phoneNumber = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('rider');

  static Stream<RiderRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  RiderRecord._();
  factory RiderRecord([void Function(RiderRecordBuilder) updates]) =
      _$RiderRecord;

  static RiderRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(
          serializer, {...data, kDocumentReferenceField: reference});
}

Map<String, dynamic> createRiderRecordData({
  String name,
  String address,
  String vehicleNo,
  String email,
  String displayName,
  String photoUrl,
  String uid,
  DateTime createdTime,
  String phoneNumber,
  bool online,
  double walletBalance,
  double earnings,
  double tips,
  double paid,
  double cashInHand,
  Timestamp walletUpdate,
  Timestamp earningsUpdate,
  Timestamp tipsUpdate,
  Timestamp paidUpdate,
  Timestamp cashInHandUpdate,

}) =>
    serializers.serializeWith(
        RiderRecord.serializer,
        RiderRecord((r) => r
          ..name = name
          ..address = address
          ..vehicleNo = vehicleNo
          ..email = email
          ..displayName = displayName
          ..photoUrl = photoUrl
          ..uid = uid
          ..online =online
          ..createdTime = createdTime
          ..walletBalance=walletBalance
          ..earnings=earnings
          ..tips=tips
          ..paid=paid
          ..cashInHand=cashInHand
          ..walletUpdate=walletUpdate
          ..earningsUpdate=earningsUpdate
          ..tipsUpdate=tipsUpdate
          ..paidUpdate=paidUpdate
          ..cashInHandUpdate=cashInHandUpdate
          ..phoneNumber = phoneNumber));
