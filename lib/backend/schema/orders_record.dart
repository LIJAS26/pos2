//@dart=2.9
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'order_items.dart';
import 'serializers.dart';

part 'orders_record.g.dart';

abstract class OrdersRecord
    implements Built<OrdersRecord, OrdersRecordBuilder> {
  static Serializer<OrdersRecord> get serializer => _$ordersRecordSerializer;

  @nullable
  String get paymentCard;

  @nullable
  Timestamp get placedDate;
  @nullable
  Timestamp get cancelledDate;
  @nullable
  Timestamp get acceptedDate;
  @nullable
  Timestamp get shippedDate;
  @nullable
  Timestamp get deliveredDate;

  @nullable
  double get price;

  @nullable
  String get shippingMethod;

  @nullable
  String get userId;

  @nullable
  BuiltList<OrderItems> get items;
  @nullable
  BuiltList<String> get shops;
  @nullable
  BuiltMap<String,String> get shippingAddress;

  @nullable
  int get orderStatus;
  @nullable
  double get deliveryCharge;
  @nullable
  double get tip;
  @nullable
  double get promoDiscount;
  @nullable
  String get promoCode;
  @nullable
  String get driverName;
  @nullable
  String get driverId;
  @nullable
  String get deliveryPin;
  @nullable
  String  get branchId;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(OrdersRecordBuilder builder) => builder
    ..paymentCard = ''
    ..userId = ''
    ..price = 0.0
    ..shippingMethod = ''
    ..deliveryCharge= 0.0
    ..tip= 0.0
    ..promoDiscount= 0.0
    ..promoCode= ''
    ..driverName= ''
    ..driverId= ''
    ..deliveryPin=''
    ..shops = ListBuilder<String>()
    ..items = ListBuilder<OrderItems>()
    ..shippingAddress = MapBuilder<String,String>()
    ..branchId=''
    ..orderStatus = 0;

  static CollectionReference get collection =>

      FirebaseFirestore.instance.collection('orders');

  static Stream<OrdersRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));
  static Stream<OrdersRecord> getDocumentFromId(String ref) => FirebaseFirestore.instance.collection('orders').doc(ref)
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  OrdersRecord._();
  factory OrdersRecord([void Function(OrdersRecordBuilder) updates]) =
      _$OrdersRecord;
}

Map<String, dynamic> createOrdersRecordData({
  String paymentCard,
  Timestamp placedDate,
  Timestamp cancelledDate,
  Timestamp acceptedDate,
  Timestamp shippedDate,
  Timestamp deliveredDate,
  double price,
  String shippingMethod,
  String userId,
  int orderStatus,
  ListBuilder<OrderItems> items,
  MapBuilder<String,String> shippingAddress,
  ListBuilder<String> shops,
  String promoCode,
  String driverName,
  String driverId,
  double deliveryCharge,
  double tip,
  double promoDiscount,
  String deliveryPin,
  String  branchId,


}) =>
    serializers.serializeWith(
        OrdersRecord.serializer,
        OrdersRecord((o) => o
          ..paymentCard = paymentCard
          ..placedDate = placedDate
          ..cancelledDate=cancelledDate
          ..acceptedDate=acceptedDate
          ..shippedDate=shippedDate
          ..deliveredDate=deliveredDate
          ..price = price
          ..shippingMethod = shippingMethod
          ..userId = userId
          ..items = items
          ..shippingAddress = shippingAddress
          ..orderStatus = orderStatus
          ..shops=shops
          ..deliveryCharge =deliveryCharge
          ..tip=tip
          ..promoCode=promoCode
          ..promoDiscount=promoDiscount
          ..driverName=driverName
          ..driverId=driverId
          ..deliveryPin=deliveryPin
          ..branchId=branchId
        ));


