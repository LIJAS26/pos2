// @dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';

class DesignSettings {
  int category;
  int brand;
  List order;
  bool showVideoBanner;
  String videoBanner;
  bool showBrand;
  int product;
  bool catalogue;
  int leftPaint;
  int rightPaint;
  int phoneAuthentication;
  int newArrivals;
  int subCategory;
  String apiKey;
  int productPaint;


  DesignSettings(
      {this.category,this.order,this.showVideoBanner,this.videoBanner,this.brand,this.showBrand,this.product,this.catalogue,this.leftPaint,this.rightPaint,this.phoneAuthentication,this.newArrivals,this.subCategory,this.apiKey,this.productPaint});

  factory DesignSettings.fromDocument(DocumentSnapshot document) {

    return DesignSettings(
      category: int.parse(document['category'].toString()),
      order: document['order'],
      showVideoBanner: document['showVideoBanner'],
      videoBanner: document['videoBanner'],
      brand: document['brand'],
      showBrand: document['showBrandBanner'],
      product: document['product'],
      catalogue: document['catalogue'],
      leftPaint: document['leftPaint'],
      rightPaint: document['rightPaint'],
      phoneAuthentication :document['phoneAuthentication'],
      newArrivals: document['newArrivals'],
      subCategory: document['subCategory'],
      apiKey: document['apiKey'],
      productPaint: document['productPaint'],
    );
  }
}
