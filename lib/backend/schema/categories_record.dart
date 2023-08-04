//@dart=2.9
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


import 'serializers.dart';

part 'categories_record.g.dart';

abstract class CategoriesRecord
    implements Built<CategoriesRecord, CategoriesRecordBuilder> {
  static Serializer<CategoriesRecord> get serializer =>
      _$categoriesRecordSerializer;

  @nullable
  String get categoryId;

  @nullable
  String get imageUrl;


  @nullable
  String get branchId;


  @nullable
  String get name;


  @nullable
  int get SNo;

  @nullable
  BuiltList<String> get search;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(CategoriesRecordBuilder builder) => builder
    ..categoryId = ''
    ..imageUrl = ''
    ..name = ''
    ..branchId = ''
    ..SNo = 0
    ..search = ListBuilder();

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('category');

  static Stream<CategoriesRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  CategoriesRecord._();
  factory CategoriesRecord([void Function(CategoriesRecordBuilder) updates]) =
      _$CategoriesRecord;
}

Map<String, dynamic> createCategoriesRecordData({
  String categoryId,
  String imageUrl,
  String name,
  String branchId,
  int SNo,
  ListBuilder<String> search,
}) =>
    serializers.serializeWith(
        CategoriesRecord.serializer,
        CategoriesRecord((c) => c
          ..categoryId = categoryId
          ..imageUrl = imageUrl
          ..name = name
          ..branchId = branchId
          ..SNo = SNo
          ..search = search));


