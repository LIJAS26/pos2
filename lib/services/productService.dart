// @dart=2.9
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:awafi_pos/modals/category.dart';
import 'package:awafi_pos/modals/product.dart';
import 'package:awafi_pos/services/userService.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';

class ProductService{
  FirebaseFirestore _firestore;
  CollectionReference _productReference;
  CollectionReference _categoryReference;
  CollectionReference _subCategoryReference;
  UserService _userService = new UserService();
  List subCategoryList = [];
  initiateFirebase() async {
    await Firebase.initializeApp();
    _firestore = FirebaseFirestore.instance;
     _productReference = FirebaseFirestore.instance.collection('products');
     _categoryReference = FirebaseFirestore.instance.collection('category');
     _subCategoryReference = FirebaseFirestore.instance.collection('subCategory');

  }

  ProductService() {
    initiateFirebase();
  }
  Future<List> listSubCategories(String categoryId) async {
    QuerySnapshot subCategoryRef = await _subCategoryReference.where('categoryId',isEqualTo: categoryId).get();
    List subCategoryList = [];
    for(int i=0;i< subCategoryRef.docs.length;i++){
      Map subCategory = subCategoryRef.docs[i].data();

      subCategoryList.add({
        'imageId': subCategory['imageUrl'],
        'name': subCategory['name'],
        'id': subCategory['subCategoryId']
      });
    }
    return subCategoryList;
  }

  Future<String> getProductsImage(String imageId) async{
    final ref = FirebaseStorage.instance.ref().child('$imageId.jpg');
    String url = await ref.getDownloadURL();
    return url;
  }

  Future<List<Product>> newItemArrivals() async{
    Random rdn = new Random();
    List<Product> itemList =[];
    _productReference = FirebaseFirestore.instance.collection('products');
    int randomNumber = 1 + rdn.nextInt(20);
    QuerySnapshot itemsRef = await _productReference.orderBy('name').startAt([randomNumber]).limit(5).get();
    for(QueryDocumentSnapshot<Map<String , dynamic>> docRef in itemsRef.docs){
      Map<String,dynamic> items = new Map();
      // String image = await getProductsImage(docRef.data()['imageId'][0]);
      items['image'] = docRef.data()['imageId'][0];
      items['name'] = docRef.data()['name'];
      items['description'] = docRef.data()['description'];
      items['price'] = docRef.data()['price'].toString();
      items['category'] = docRef.data()['category'];
      items['colours'] = docRef.data()['color'];
      items['images'] = docRef.data()['imageId'];
      items['DailyReport'] = docRef.data()['size'];
      items['subCategory'] = docRef.data()['subCategory'];
      items['orderLimit'] = docRef.data()['orderLimit'];
      items['id'] = docRef.data()['productId'];

      itemList.add(Product.fromMapObject(items));
    }
    return itemList;
  }
  
  Future <List> featuredItems() async{
    _productReference = FirebaseFirestore.instance.collection('products');
    List<Product> itemList = [];
    QuerySnapshot<Map<String , dynamic>> itemsRef = await _productReference.limit(16).get();
    for(DocumentSnapshot<Map<String , dynamic>> docRef in itemsRef.docs){
      Map<String,dynamic> items = new Map();
      // String image = await getProductsImage(docRef.data()['imageId'][0]);
      items['image'] = docRef.data()['imageId'][0];
      items['name'] = docRef.data()['name'];
      items['description'] = docRef.data()['description'];
      items['price'] = docRef.data()['price'].toString();
      items['category'] = docRef.data()['category'];
      items['colours'] = docRef.data()['color'];
      items['images'] = docRef.data()['imageId'];
      items['DailyReport'] = docRef.data()['size'];
      items['subCategory'] = docRef.data()['subCategory'];
      items['orderLimit'] = docRef.data()['orderLimit'];
      items['id'] = docRef.data()['productId'];

      itemList.add(Product.fromMapObject(items));

    }
    return itemList;
  }
  
  Future <List> listSubCategoryItems(String subCategoryId) async{
    List<Map<String,String>> itemsList = [];
    QuerySnapshot<Map<String , dynamic>> productRef = await _productReference.where("subCategory",isEqualTo: subCategoryId).get();
    for(DocumentSnapshot<Map<String , dynamic>> docRef in productRef.docs){
      Map<String,String> items  = new Map();
      items['image'] = docRef.data()['imageId'][0];
      items['name'] = docRef.data()['name'];
      items['description'] = docRef.data()['description'];
      items['price'] = docRef.data()['price'].toString();
      items['productId'] = docRef.data()['productId'];
      itemsList.add(items);

    }
    return itemsList;
  }
  Future <List> listCategoryItems(String categoryId) async{
    List<Map<String,String>> itemsList = [];
    QuerySnapshot<Map<String , dynamic>> productRef = await _productReference.where("category",isEqualTo: categoryId).get();
    for(DocumentSnapshot<Map<String , dynamic>> docRef in productRef.docs){
      Map<String,String> items  = new Map();
      items['image'] = docRef.data()['imageId'][0];
      items['name'] = docRef.data()['name'];
      items['price'] = docRef.data()['price'].toString();
      items['description'] = docRef.data()['description'];
      items['productId'] = docRef.data()['productId'];
      itemsList.add(items);

    }
    return itemsList;
  }
  Future <List> listBrandItems(String brandId) async{
    List<Map<String,String>> itemsList = [];
    QuerySnapshot<Map<String , dynamic>> productRef = await _productReference.where("brand",isEqualTo: brandId).get();
    for(DocumentSnapshot<Map<String , dynamic>> docRef in productRef.docs){
      Map<String,String> items  = new Map();
      items['image'] = docRef.data()['imageId'][0];
      items['name'] = docRef.data()['name'];
      items['price'] = docRef.data()['price'].toString();
      items['description'] = docRef.data()['description'];
      items['productId'] = docRef.data()['productId'];
      itemsList.add(items);

    }
    return itemsList;
  }
  
  Future <List<Brands>> listCategories() async{
    _categoryReference = FirebaseFirestore.instance.collection('category');
    QuerySnapshot<Map<String , dynamic>> _categoryRef = await _categoryReference.get();

    List <Brands> categoryList = [];
    for(DocumentSnapshot<Map<String , dynamic>> dataRef in _categoryRef.docs){
      Map<String,String> category = new Map();
      category['name'] = dataRef.data()['name'];
      category['image'] = dataRef.data()['imageUrl'];
      category['id'] = dataRef.data()['categoryId'];
      categoryList.add(Brands.fromMapObject(category));
    }
    return categoryList;
  }
  Future <List<Brands>> listBrands() async{
    _categoryReference = FirebaseFirestore.instance.collection('brands');
    QuerySnapshot<Map<String , dynamic>> _categoryRef = await _categoryReference.get();

    List <Brands> categoryList = [];
    for(DocumentSnapshot<Map<String , dynamic>> dataRef in _categoryRef.docs){
      Map<String,String> category = new Map();
      category['name'] = dataRef.data()['brand'];
      category['image'] = dataRef.data()['imageUrl'];
      category['id'] = dataRef.data()['brandId'];
      categoryList.add(Brands.fromMapObject(category));
    }
    return categoryList;
  }
  Future <List<dynamic>> listBanners() async{

    DocumentSnapshot<Map<String , dynamic>> banners = await FirebaseFirestore.instance.collection('banner').doc('banner').get();

    List <dynamic> categoryList = banners.get('bannerList');
    // for(DocumentSnapshot<Map<String , dynamic>> dataRef in _categoryRef.docs){
    //   Map<String,String> category = new Map();
    //   category['name'] = dataRef.data()['brand'];
    //   category['image'] = dataRef.data()['imageUrl'];
    //   category['id'] = dataRef.data()['brandId'];
    //   categoryList.add(Brands.fromMapObject(category));
    // }
    return categoryList;
  }

  // ignore: missing_return
  Future <String> addItemToWishlist(String productId) async{
    String msg;
    String uid = await _userService.getUserId();
    List<dynamic> wishlist = <dynamic>[];
    QuerySnapshot userRef = await _firestore.collection('users').where('userId',isEqualTo: uid).get();
    Map userData = userRef.docs[0].data();
    String documentId = userRef.docs[0].id;
    if(userData.containsKey('wishlist')){
      wishlist = userData['wishlist'];
      if(wishlist.indexOf(productId) == -1){
        wishlist.add(productId);
      }
      else{
        msg = 'Product existed in Wishlist';
        return msg;
      }
    }
    else{
      wishlist.add(productId);
    }
    await _firestore.collection('users').doc(documentId).update({
      'wishlist': wishlist
    }).then((value){
      msg = 'Product added to wishlist';
      return msg;
    });
  }

  Future<Map> particularItem(String productId) async{
    DocumentSnapshot<Map<String , dynamic>> prodRef = await _productReference.doc(productId).get();
    Map<String, dynamic> itemDetail = new Map();
    itemDetail['image'] = prodRef.data()['imageId'];
    itemDetail['color'] = prodRef.data()['color'];
    itemDetail['size'] = prodRef.data()['size'];
    itemDetail['price'] = prodRef.data()['price'];
    itemDetail['name'] = prodRef.data()['name'];
    itemDetail['productId'] = productId;
    return itemDetail;
  }
}

class NewArrival{
  final String name;
  final String image;

  NewArrival({this.name, this.image});
}