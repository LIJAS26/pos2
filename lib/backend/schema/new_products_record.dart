//@dart=2.9
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


import 'cut_record.dart';
import 'serializers.dart';

part 'new_products_record.g.dart';

abstract class NewProductsRecord
    implements Built<NewProductsRecord, NewProductsRecordBuilder> {
  static Serializer<NewProductsRecord> get serializer =>
      _$newProductsRecordSerializer;

  @nullable
  String get name;

  @nullable
  String get unit;
  @nullable
  String get shopId;
  @nullable
  String get shopName;
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
  String get description;

  @nullable
  double get price;

  @nullable
  double get discountPrice;

  @nullable
  String get userId;

  @nullable
  BuiltList<String> get color;
  @nullable
  BuiltList<String> get size;
  @nullable
  BuiltList<CutRecord> get cuts;

  @nullable
  BuiltList<String> get imageId;
  @nullable
  BuiltList<String> get search;


  @nullable
  String get productId;
  @nullable
  String get brand;
  @nullable
  String get subCategory;
  @nullable
  String get category;
  @nullable
  bool get available;
  @nullable
  bool get open;
  @nullable
  String  get branchId;
  @nullable
  double get start;
  @nullable
  double get step;
  @nullable
  double get stop;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(NewProductsRecordBuilder builder) => builder
    ..name = ''
    ..description = ''
    ..brand = ''
    ..unit =''
    ..subCategory = ''
    ..shopId = ''
    ..shopName = ''
    ..category = ''
    ..productId = ''
    ..price = 0.0
    ..discountPrice = 0.0
    ..ones=0
    ..twos=0
    ..threes=0
    ..fours=0
    ..fives=0
    ..start=0.0
    ..step=0.0
    ..stop=0.0
    ..available=false
    ..open=false
    ..color = ListBuilder<String>()
    ..size = ListBuilder<String>()
    ..imageId = ListBuilder<String>()
    ..cuts = ListBuilder<CutRecord>()
    ..size = ListBuilder<String>()
    ..size = ListBuilder<String>()
    ..branchId='';


  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('products');

  static Stream<NewProductsRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  NewProductsRecord._();
  factory NewProductsRecord([void Function(NewProductsRecordBuilder) updates]) =
  _$NewProductsRecord;
}

Map<String, dynamic> createNewProductsRecordData({
  String name,
  String description,
  String brand,
  String subCategory,
  String category,
  double price,
  double discountPrice,
  String unit,
  String shopId,
  String shopName,
  String userId,
  String productId,
  ListBuilder<String> color,
  ListBuilder<String> size,
  ListBuilder<String> imageId,
  ListBuilder<String> search,
  ListBuilder<CutRecord> cuts,
  int ones,
  int twos,
  int threes,
  int fours,
  int fives,
  bool available,
  bool open,
  String  branchId,
  double start,
  double step,
  double stop,

}) =>
    serializers.serializeWith(
        NewProductsRecord.serializer,
        NewProductsRecord((n) => n
          ..name = name
          ..description = description
          ..brand = brand
          ..subCategory = subCategory
          ..category = category
          ..price = price
          ..discountPrice = discountPrice
          ..unit =unit
          ..userId = userId
          ..color = color
          ..size = size
          ..shopId = shopId
          ..shopName = shopName
          ..search = search
          ..imageId = imageId
          ..cuts=cuts
          ..ones=ones
          ..twos=twos
          ..threes=threes
          ..fours=fours
          ..fives=fives
          ..productId = productId
          ..available =available
          ..open=open
          ..branchId=branchId
          ..start=start
          ..step=step
          ..stop=stop
        ));


