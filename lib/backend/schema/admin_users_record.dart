//@dart=2.9
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'schema_util.dart';
import 'serializers.dart';

part 'admin_users_record.g.dart';

abstract class AdminUsersRecord
    implements Built<AdminUsersRecord, AdminUsersRecordBuilder> {
  static Serializer<AdminUsersRecord> get serializer =>
      _$adminUsersRecordSerializer;

  @nullable
  String get email;

  @nullable
  @BuiltValueField(wireName: 'display_name')
  String get displayName;

  @nullable
  @BuiltValueField(wireName: 'photo_url')
  String get photoUrl;

  @nullable
  String get uid;

  @nullable
  @BuiltValueField(wireName: 'created_time')
  Timestamp get createdTime;

  @nullable
  bool get verified;

  @nullable
  String get mobileNumber;

  @nullable
  DocumentReference get userId;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(AdminUsersRecordBuilder builder) => builder
    ..email = ''
    ..displayName = ''
    ..photoUrl = ''
    ..uid = ''
    ..verified = false
    ..mobileNumber = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('admin_users');

  static Stream<AdminUsersRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  AdminUsersRecord._();
  factory AdminUsersRecord([void Function(AdminUsersRecordBuilder) updates]) =
      _$AdminUsersRecord;
}

Map<String, dynamic> createAdminUsersRecordData({
  String email,
  String displayName,
  String photoUrl,
  String uid,
  Timestamp createdTime,
  bool verified,
  String mobileNumber,
  DocumentReference userId,
}) =>
    serializers.serializeWith(
        AdminUsersRecord.serializer,
        AdminUsersRecord((a) => a
          ..email = email
          ..displayName = displayName
          ..photoUrl = photoUrl
          ..uid = uid
          ..createdTime = createdTime
          ..verified = verified
          ..mobileNumber = mobileNumber
          ..userId = userId));

AdminUsersRecord get dummyAdminUsersRecord {
  final builder = AdminUsersRecordBuilder()
    ..email = dummyString
    ..displayName = dummyString
    ..photoUrl = dummyImagePath
    ..uid = dummyString
    ..createdTime = dummyTimestamp
    ..verified = dummyBoolean
    ..mobileNumber = dummyString;
  return builder.build();
}

List<AdminUsersRecord> createDummyAdminUsersRecord({int count}) =>
    List.generate(count, (_) => dummyAdminUsersRecord);
