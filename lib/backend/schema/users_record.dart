//@dart=2.9
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


import 'serializers.dart';

part 'users_record.g.dart';

abstract class UsersRecord implements Built<UsersRecord, UsersRecordBuilder> {
  static Serializer<UsersRecord> get serializer => _$usersRecordSerializer;

  @nullable
  String get email;

  @nullable
  String get fullName;

  @nullable
  String get mobileNumber;

  @nullable
  String get photoUrl;

  @nullable
  String get userId;

  @nullable
  BuiltList<String> get wishlist;
  @nullable
  String  get branchId;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(UsersRecordBuilder builder) => builder
    ..email = ''
    ..fullName = ''
    ..mobileNumber = ''
    ..photoUrl = ''
    ..userId = ''
    ..branchId=''
    ..wishlist = ListBuilder();

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('users');

  static Stream<UsersRecord> getDocument(String ref) =>  FirebaseFirestore.instance.collection('users').doc(ref)
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  UsersRecord._();
  factory UsersRecord([void Function(UsersRecordBuilder) updates]) =
      _$UsersRecord;
}

Map<String, dynamic> createUsersRecordData({
  String email,
  String fullName,
  String mobileNumber,
  String photoUrl,
  String userId,
  String branchId,
}) =>
    serializers.serializeWith(
        UsersRecord.serializer,
        UsersRecord((u) => u
          ..email = email
          ..fullName = fullName
          ..mobileNumber = mobileNumber
          ..photoUrl = photoUrl
          ..userId = userId
          ..branchId=branchId
          ..wishlist = null));


