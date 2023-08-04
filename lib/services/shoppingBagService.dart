// @dart=2.9
import 'package:awafi_pos/backend/backend.dart';
import 'package:awafi_pos/services/userService.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../main.dart';

class ShoppingBagService{
  UserService userService = new UserService();
  // FirebaseFirestore _firestore ;
  CollectionReference _shoppingBagReference ;
  CollectionReference _productReference;
  ShoppingBagService() {
   initiateFirebase();
  }
  initiateFirebase() async {
    await Firebase.initializeApp();

    _shoppingBagReference = FirebaseFirestore.instance.collection('bags');
    _productReference = FirebaseFirestore.instance.collection('products');

  }

  Future<String> update(String productId,String name, String size, String color, int quantity, QuerySnapshot bagItems) async{
    String documentId;
    String msg;
    List productItems = bagItems.docs.map((doc){
      documentId = doc.id;
      return doc['products'];
    }).toList()[0];
    List product = productItems.where((test)=> (test['id'] == productId && test['size']==size && test['color']==color )).toList();

    if(product.length != 0){
      productItems.forEach((items){
        if(items['id'] == productId && items['size']==size && items['color']==color){
          items['size'] = size;
          items['color'] = color;
          items['quantity'] =items['quantity']+ quantity;
          items['name'] = name;
        }
      });
      await _shoppingBagReference.doc(documentId).update({'products':productItems});
      msg =  "Product updated in shopping bag";
    }
    else{
      productItems.add({'id':productId,'name' :name,'size':size,'color':color,'quantity':quantity});
      await _shoppingBagReference.doc(documentId).update({'products':productItems});
      msg = 'Product added to shopping bag';
    }
    return msg;
  }

  Future<String> editCart(String productId,String name, String size, String color, int quantity,int index) async{
    String documentId;
    String uid = currentUserModel.id;
    QuerySnapshot bagItems = await _shoppingBagReference.where("userId", isEqualTo: uid).get();
    String msg;
    List productItems = bagItems.docs.map((doc){
      documentId = doc.id;
      return doc['products'];
    }).toList()[0];



      for(int i=0;i<productItems.length;i++){


        if(i==index){
          productItems[i]['size'] = size;
          productItems[i]['color'] = color;
          productItems[i]['quantity'] =quantity;
          productItems[i]['name'] = name;
        }
      }
      await _shoppingBagReference.doc(documentId).update({'products':productItems});
      msg =  "Product Edited in shopping bag";

    return msg;
  }


  Future<String> add(String productId,String name,String size,String color,String cut,String unit,double quantity,double discountPrice,) async{
    // String uid = currentUserModel.id;
    List bag=currentUserModel.bag;
    String msg;
    bool exist=false;
  for(int i=0;i<bag.length;i++){
    Map<String, dynamic> item =bag[i];
    if(item['id']==productId &&  item['size']==size && item['color']==color && item['cut']==cut && item['unit']==unit)
      {
        exist=true;


      }
  }
    if(!exist) {
      currentUserModel.bag.add({
        'id': productId,
        'name': name,
        'size': size,
        'color': color,
        'cut': cut,
        'unit': unit,
        'quantity': quantity,
        'discountPrice' :discountPrice,
        'shopDiscount' :0.00,
      });
    }
      FirebaseFirestore.instance.collection('users').doc(currentUserModel.id).update({
        'bag' :currentUserModel.bag
      });

      msg =  "Product added to shopping bag";

    return msg;
  }
  Future<String> remove() async{
    // String uid = currentUserModel.id;
    String msg;



    FirebaseFirestore.instance.collection('users').doc(currentUserModel.id).update({
      'bag' :currentUserModel.bag
    });

    msg =  "Product removed from shopping bag";

    return msg;
  }

  Future<String> downloadStorageImage(String image) {
    Reference imageRef = FirebaseStorage.instance.ref().child('/$image.jpg');
    return imageRef.getDownloadURL();
  }
  Future<Map> colorList() async {
    Map colorMap = Map();

    DocumentSnapshot<Map<String, dynamic>> colorRef = await FirebaseFirestore
        .instance.collection('colors').doc('colors').get();
    List colorList = colorRef.data()['colorList'];
    for (int i = 0; i < colorList.length; i++) {
     colorMap[colorList[i]['code']]=colorList[i]['name'];
    }
    return colorMap;
  }


  Future<Map> list() async{
    List bagItemsList =[];
    List bagItemDetails =currentUserModel.bag;
    // String uid = currentUserModel.id;
    int totalBags = currentUserModel.bag.length;
    if(totalBags != 0){
           for(int i=0; i < bagItemDetails.length; i++){
        Map bagItems = new Map();
        DocumentSnapshot<Map<String , dynamic>> productRef = await _productReference.doc(bagItemDetails[i]['id']).get();
        // String image = productRef.data()['imageId'][0];

        // String imageUrl = (await downloadStorageImage(image)).toString();
        // String imageUrl=image;
        bagItems['productId'] = productRef.id;
        bagItems['name']  = productRef.data()['name'];
        bagItems['image'] = productRef.data()['imageId'];
        bagItems['shopId'] = productRef.data()['shopId'];
        bagItems['price']  = productRef.data()['discountPrice'].toString();
        bagItems['color'] = productRef.data()['color'].cast<String>().toList();
        bagItems['size'] = productRef.data()['size'].cast<String>().toList();
        bagItems['selectedSize'] = bagItemDetails[i]['size'];
        bagItems['selectedColor'] = bagItemDetails[i]['color'];
        bagItems['quantity'] = bagItemDetails[i]['quantity'];
        bagItems['cut'] = bagItemDetails[i]['cut'];
        bagItems['unit'] = bagItemDetails[i]['unit'];
        bagItems['shopDiscount'] = bagItemDetails[i]['shopDiscount'];
        bagItems['open'] = productRef.data()['open'];
        bagItems['available'] = productRef.data()['available'];
        bagItemsList.add(bagItems);
      }
    }
     Map bagItemsMap={'list' :bagItemsList};
    return bagItemsMap;
  }




  Future<void> delete() async{
    String uid = currentUserModel.id;
      currentUserModel.bag=[];
    await FirebaseFirestore.instance.collection('users').doc(uid).update(
        {
          'bag' :[]
        }
    );
  }
}