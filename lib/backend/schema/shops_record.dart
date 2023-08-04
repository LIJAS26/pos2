//@dart=2.9
import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'shops_record.g.dart';

abstract class ShopsRecord implements Built<ShopsRecord, ShopsRecordBuilder> {
  static Serializer<ShopsRecord> get serializer => _$shopsRecordSerializer;

  @nullable
  String get imageUrl;

  @nullable
  String get name;

  @nullable
  String get shopId;

  @nullable
  String get address;

  @nullable
  String get email;
  @nullable
  int get ones;
  @nullable
  int get twos;
  @nullable
  int get threes;
  @nullable
  int get fours;
  @nullable
  int get fives;

  @nullable
  String get sunFrom;

  @nullable
  String get sunTo;

  @nullable
  String get monFrom;

  @nullable
  String get monTo;

  @nullable
  String get tueFrom;

  @nullable
  String get tueTo;

  @nullable
  String get wedFrom;

  @nullable
  String get wedTo;

  @nullable
  String get thuFrom;

  @nullable
  String get thuTo;

  @nullable
  String get friFrom;

  @nullable
  String get friTo;

  @nullable
  String get satFrom;

  @nullable
  String get satTo;

  @nullable
  @BuiltValueField(wireName: 'FSSAIRegNo')
  String get fSSAIRegNo;

  @nullable
  BuiltList<String> get users;

  @nullable
  String get phoneNumber;
  @nullable
  BuiltList<String> get search;
  @nullable
  BuiltList<String> get admins;
  @nullable
  bool get online;
  @nullable
  double get discount;
  @nullable
  double get paid;
  @nullable
  double get sales;
  @nullable
  Timestamp get paidUpdate;
  @nullable
  Timestamp get salesUpdate;
  @nullable
  String  get branchId;
  @nullable
  double get latitude;
  @nullable
  double get longitude;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(ShopsRecordBuilder builder) => builder
    ..imageUrl = ''
    ..name = ''
    ..shopId = ''
    ..address = ''
    ..email = ''
    ..sunFrom = ''
    ..sunTo = ''
    ..monFrom = ''
    ..monTo = ''
    ..tueFrom = ''
    ..tueTo = ''
    ..wedFrom = ''
    ..wedTo = ''
    ..thuFrom = ''
    ..thuTo = ''
    ..friFrom = ''
    ..friTo = ''
    ..satFrom = ''
    ..satTo = ''
    ..fSSAIRegNo = ''
    ..users = ListBuilder()
    ..search=ListBuilder()
    ..admins=ListBuilder()
    ..phoneNumber = ''
    ..ones=0
    ..twos=0
    ..threes=0
    ..fours=0
    ..fives=0
    ..discount=0.0
    ..paid=0.0
    ..sales=0.0
    ..latitude=0.0
    ..longitude=0.0
    ..paidUpdate=Timestamp.now()
    ..salesUpdate=Timestamp.now()
    ..branchId=''
    ..online=false;

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('shops');

  static Stream<ShopsRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  ShopsRecord._();
  factory ShopsRecord([void Function(ShopsRecordBuilder) updates]) =
      _$ShopsRecord;

  static ShopsRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(
          serializer, {...data, kDocumentReferenceField: reference});
}

Map<String, dynamic> createShopsRecordData({
  String imageUrl,
  String name,
  String shopId,
  String address,
  String email,
  String sunFrom,
  String sunTo,
  String monFrom,
  String monTo,
  String tueFrom,
  String tueTo,
  String wedFrom,
  String wedTo,
  String thuFrom,
  String thuTo,
  String friFrom,
  String friTo,
  String satFrom,
  String satTo,
  String fSSAIRegNo,
  String phoneNumber,
  ListBuilder search,
  ListBuilder admins,
  bool online,
  int ones,
  int twos,
  int threes,
  int fours,
  int fives,
  double discount,
  double paid,
  double sales,
  double latitude,
  double longitude,
  Timestamp paidUpdate,
  Timestamp salesUpdate,
  String branchId,
}) =>
    serializers.serializeWith(
        ShopsRecord.serializer,
        ShopsRecord((s) => s
          ..imageUrl = imageUrl
          ..name = name
          ..shopId = shopId
          ..address = address
          ..email = email
          ..sunFrom = sunFrom
          ..sunTo = sunTo
          ..monFrom = monFrom
          ..monTo = monTo
          ..tueFrom = tueFrom
          ..tueTo = tueTo
          ..wedFrom = wedFrom
          ..wedTo = wedTo
          ..thuFrom = thuFrom
          ..thuTo = thuTo
          ..friFrom = friFrom
          ..friTo = friTo
          ..satFrom = satFrom
          ..satTo = satTo
          ..fSSAIRegNo = fSSAIRegNo
          ..users = null
          ..phoneNumber = phoneNumber
          ..search=search
          ..admins =admins
          ..ones=ones
          ..twos=twos
          ..threes=threes
          ..fours=fours
          ..fives=fives
          ..discount=discount
          ..paid=paid
          ..sales=sales
          ..paidUpdate=paidUpdate
          ..salesUpdate=salesUpdate
          ..online=online
          ..latitude=latitude
          ..longitude=longitude
          ..branchId=branchId));
