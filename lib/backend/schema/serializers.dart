//@dart=2.9
import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:awafi_pos/backend/schema/alerts_record.dart';
import 'package:awafi_pos/backend/schema/cut_record.dart';
import 'package:awafi_pos/backend/schema/offer_record.dart';
import 'package:awafi_pos/backend/schema/review_record.dart';
import 'package:awafi_pos/backend/schema/shops_record.dart';


import 'admin_users_record.dart';
import 'orders_record.dart';
import 'users_record.dart';
import 'new_products_record.dart';
import 'brands_record.dart';
import 'categories_record.dart';
import 'sub_category_record.dart';
import 'order_items.dart';


part 'serializers.g.dart';

const kDocumentReferenceField = 'Document__Reference__Field';

@SerializersFor(const [
  AdminUsersRecord,
  OrdersRecord,
  UsersRecord,
  NewProductsRecord,
  BrandsRecord,
  CategoriesRecord,
  SubCategoryRecord,
  CutRecord,
  AlertsRecord,
  ShopsRecord,
  OfferRecord,

])
final Serializers serializers = (_$serializers.toBuilder()
      ..add(DocumentReferenceSerializer())
      ..add(TimestampSerializer())
      ..addPlugin(StandardJsonPlugin()))
    .build();
Serializers standardSerializers = (serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();

T deserialize<T>(dynamic value) =>
    standardSerializers.deserializeWith<T>(standardSerializers.serializerForType(T), value);

BuiltList<T> deserializeListOf<T>(dynamic value) =>
    BuiltList.from(value.map((value) => deserialize<T>(value)).toList(growable: false));


class DocumentReferenceSerializer
    implements PrimitiveSerializer<DocumentReference> {
  final bool structured = false;
  @override
  final Iterable<Type> types = new BuiltList<Type>([DocumentReference]);
  @override
  final String wireName = 'DocumentReference';

  @override
  Object serialize(Serializers serializers, DocumentReference reference,
      {FullType specifiedType: FullType.unspecified}) {
    return reference;
  }

  @override
  DocumentReference deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType: FullType.unspecified}) =>
      serialized as DocumentReference;
}

class TimestampSerializer implements PrimitiveSerializer<Timestamp> {

  final bool structured = false;
  @override
  final Iterable<Type> types = new BuiltList<Type>([Timestamp]);
  @override
  final String wireName = 'Timestamp';

  @override
  Object serialize(Serializers serializers, Timestamp timestamp,
      {FullType specifiedType: FullType.unspecified}) {
    return timestamp;
  }

  @override
  Timestamp deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType: FullType.unspecified}) =>
      serialized as Timestamp;
}

Map<String, dynamic> serializedData(DocumentSnapshot<Map<String, dynamic>> doc){

return {...doc.data(), kDocumentReferenceField: doc.reference};
}
