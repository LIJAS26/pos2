//@dart=2.9
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


import 'serializers.dart';

part 'sub_category_record.g.dart';

abstract class SubCategoryRecord
    implements Built<SubCategoryRecord, SubCategoryRecordBuilder> {
  static Serializer<SubCategoryRecord> get serializer =>
      _$subCategoryRecordSerializer;

  @nullable
  String get categoryId;

  @nullable
  String get imageUrl;

  @nullable
  String get name;

  @nullable
  String get subCategoryId;

  @nullable
  BuiltList<String> get search;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(SubCategoryRecordBuilder builder) => builder
    ..categoryId = ''
    ..imageUrl = ''
    ..name = ''
    ..subCategoryId = ''
    ..search = ListBuilder();

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('subCategory');

  static Stream<SubCategoryRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  SubCategoryRecord._();
  factory SubCategoryRecord([void Function(SubCategoryRecordBuilder) updates]) =
      _$SubCategoryRecord;
}

Map<String, dynamic> createSubCategoryRecordData({
  String categoryId,
  String imageUrl,
  String name,
  String subCategoryId,
  ListBuilder<String> search,
}) =>
    serializers.serializeWith(
        SubCategoryRecord.serializer,
        SubCategoryRecord((s) => s
          ..categoryId = categoryId
          ..imageUrl = imageUrl
          ..name = name
          ..subCategoryId = subCategoryId
          ..search = search));




