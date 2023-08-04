//@dart=2.9
import 'package:built_value/serializer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:awafi_pos/backend/schema/categories_record.dart';
import 'package:awafi_pos/backend/schema/cut_record.dart';
import 'package:awafi_pos/backend/schema/offer_record.dart';
import 'package:awafi_pos/backend/schema/rider_record.dart';
import 'package:awafi_pos/backend/schema/shop_users_record.dart';
import 'package:awafi_pos/backend/schema/shops_record.dart';

import '../flutter_flow/flutter_flow_util.dart';

import 'schema/admin_users_record.dart';
import 'schema/orders_record.dart';
import 'schema/users_record.dart';
import 'schema/new_products_record.dart';
import 'schema/brands_record.dart';
import 'schema/sub_category_record.dart';
import 'schema/serializers.dart';

export 'package:cloud_firestore/cloud_firestore.dart';
export 'schema/admin_users_record.dart';
export 'schema/orders_record.dart';
export 'schema/users_record.dart';
export 'schema/new_products_record.dart';
export 'schema/brands_record.dart';
export 'schema/sub_category_record.dart';

Stream<List<AdminUsersRecord>> queryAdminUsersRecord(
        {Query Function(Query) queryBuilder,
        int limit = -1,
        bool singleRecord = false}) =>
    queryCollection(AdminUsersRecord.collection, AdminUsersRecord.serializer,
        queryBuilder: queryBuilder, limit: limit, singleRecord: singleRecord);

Stream<List<OrdersRecord>> queryOrdersRecord(
        {Query Function(Query) queryBuilder,
        int limit = -1,
        bool singleRecord = false}) =>
    queryCollection(OrdersRecord.collection, OrdersRecord.serializer,
        queryBuilder: queryBuilder, limit: limit, singleRecord: singleRecord);

Stream<List<UsersRecord>> queryUsersRecord(
        {Query Function(Query) queryBuilder,
        int limit = -1,
        bool singleRecord = false}) =>
    queryCollection(UsersRecord.collection, UsersRecord.serializer,
        queryBuilder: queryBuilder, limit: limit, singleRecord: singleRecord);

Stream<List<NewProductsRecord>> queryNewProductsRecord(
        {Query Function(Query) queryBuilder,
        int limit = -1,
        bool singleRecord = false}) =>
    queryCollection(NewProductsRecord.collection, NewProductsRecord.serializer,
        queryBuilder: queryBuilder, limit: limit, singleRecord: singleRecord);

Stream<List<BrandsRecord>> queryBrandsRecord(
        {Query Function(Query) queryBuilder,
        int limit = -1,
        bool singleRecord = false}) =>
    queryCollection(BrandsRecord.collection, BrandsRecord.serializer,
        queryBuilder: queryBuilder, limit: limit, singleRecord: singleRecord);

Stream<List<CategoriesRecord>> queryCategoriesRecord(
        {Query Function(Query) queryBuilder,
        int limit = -1,
        bool singleRecord = false}) =>
    queryCollection(CategoriesRecord.collection, CategoriesRecord.serializer,
        queryBuilder: queryBuilder, limit: limit, singleRecord: singleRecord);
Stream<List<CutRecord>> queryCutRecord(
    {Query Function(Query) queryBuilder,
      int limit = -1,
      bool singleRecord = false}) =>
    queryCollection(CutRecord.collection, CutRecord.serializer,
        queryBuilder: queryBuilder, limit: limit, singleRecord: singleRecord);

Stream<List<SubCategoryRecord>> querySubCategoryRecord(
        {Query Function(Query) queryBuilder,
        int limit = -1,
        bool singleRecord = false}) =>
    queryCollection(SubCategoryRecord.collection, SubCategoryRecord.serializer,
        queryBuilder: queryBuilder, limit: limit, singleRecord: singleRecord);
Stream<List<ShopsRecord>> queryShopsRecord(
    {Query Function(Query) queryBuilder,
      int limit = -1,
      bool singleRecord = false}) =>
    queryCollection(ShopsRecord.collection, ShopsRecord.serializer,
        queryBuilder: queryBuilder, limit: limit, singleRecord: singleRecord);
Stream<List<ShopUsersRecord>> queryShopUsersRecord(
    {Query Function(Query) queryBuilder,
      int limit = -1,
      bool singleRecord = false}) =>
    queryCollection(ShopUsersRecord.collection, ShopUsersRecord.serializer,
        queryBuilder: queryBuilder, limit: limit, singleRecord: singleRecord);
Stream<List<OfferRecord>> queryOfferRecord(
    {Query Function(Query) queryBuilder,
      int limit = -1,
      bool singleRecord = false}) =>
    queryCollection(OfferRecord.collection, OfferRecord.serializer,
        queryBuilder: queryBuilder, limit: limit, singleRecord: singleRecord);
Stream<List<RiderRecord>> queryRiderRecord(
    {Query Function(Query) queryBuilder,
      int limit = -1,
      bool singleRecord = false}) =>
    queryCollection(RiderRecord.collection, RiderRecord.serializer,
        queryBuilder: queryBuilder, limit: limit, singleRecord: singleRecord);

Stream<List<T>> queryCollection<T>(
    CollectionReference<Map<String, dynamic>> collection, Serializer<T> serializer,
    {Query Function(Query) queryBuilder,
      int limit = -1,
      bool singleRecord = false}) {
  final builder = queryBuilder ?? (q) => q;
  Query<Map<String, dynamic>> query = builder(collection);
  if (limit > 0 || singleRecord) {
    query = query.limit(singleRecord ? 1 : limit);
  }
  return query.snapshots().map((s) => s.docs
      .map((d) => serializers.deserializeWith(serializer, serializedData(d)))
      .toList());
}
// Creates a Firestore record representing the logged in user if it doesn't yet exist
Future maybeCreateUser(User user) async {
  // GoogleSignInAccount guser = googleSignIn.currentUser;
  final userRecord = AdminUsersRecord.collection.doc(user.uid);
  final userExists = await userRecord.get().then((u) => u.exists);
  if (userExists) {
    return;
  }

  final userData = createAdminUsersRecordData(
    email: user.email,
    displayName: user.displayName,
    photoUrl: user.photoURL,
    uid: user.uid,
    createdTime: getCurrentTimestamp,
    verified: false,
  );

  await userRecord.set(userData);
}
