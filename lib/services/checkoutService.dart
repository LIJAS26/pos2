// @dart=2.9
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:awafi_pos/services/shoppingBagService.dart';
import 'package:awafi_pos/services/userService.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../main.dart';

class CheckoutService {
  // FirebaseFirestore _firestore;
  UserService _userService = new UserService();
  ShoppingBagService _shoppingBagService = new ShoppingBagService();
  CollectionReference _shippingAddressReference ;
  CollectionReference _creditCardReference;
  // CollectionReference _shoppingBagReference;
  CollectionReference _orderReference;
  CollectionReference _productReference;

  initiateFirebase() async {
    await Firebase.initializeApp();
    // _firestore = FirebaseFirestore.instance;
     _shippingAddressReference = FirebaseFirestore.instance.collection('shippingAddress');
     _creditCardReference = FirebaseFirestore.instance.collection('creditCard');
     // _shoppingBagReference = FirebaseFirestore.instance.collection('bags');
     _orderReference = FirebaseFirestore.instance.collection('orders');
     _productReference = FirebaseFirestore.instance.collection('products');
  }

  CheckoutService() {
    initiateFirebase();
  }


  Map mapAddressValues(Map values){
    Map addressValues = new Map();
    addressValues['area'] = values['area'];
    addressValues['city'] = values['city'];
    addressValues['landmark'] = values['landMark'];
    addressValues['state'] = values['state'];
    addressValues['address'] = values['address'];
    addressValues['name'] = values['fullName'];
    addressValues['mobileNumber'] = values['mobileNumber'];
    addressValues['pinCode'] = values['pinCode'];
    return addressValues;
  }

  Future<void>updateAddressData(QuerySnapshot<Map<String , dynamic>> addressData, Map newAddress) async{
    String documentId = addressData.docs[0].id;
    List savedAddress = addressData.docs[0].data()['address'];
    savedAddress.add(newAddress);
    await _shippingAddressReference.doc(documentId).update({'address': savedAddress});
  }

  Future<void> newShippingAddress(Map address) async{
    String uid = await  _userService.getUserId();
    QuerySnapshot data = await _shippingAddressReference.where("userId", isEqualTo: uid).get();
    if(data.docs.length == 0){
      List savedAddress =[];
      savedAddress.add(address);
       await _shippingAddressReference.doc(uid).set({'userId': uid,'address': savedAddress});
       // await _shippingAddressReference.doc(uid).update({'address': [mapAddressValues(address)]});

    }
    else{
      await updateAddressData(data,address);
    }
  }

  Future<List> listShippingAddress() async{
    String uid = currentUserModel.id;
    List addressList = [];

    QuerySnapshot<Map<String , dynamic>> docRef = await FirebaseFirestore.instance.collection('shippingAddress').where('userId',isEqualTo: uid).get();
    if(docRef.docs.length != 0){
      addressList = docRef.docs[0].data()['address'];
    }

    return addressList;

  }

  Future<void> newCreditCardDetails(String cardNumber, String expiryDate, String cardHolderName) async{
    String uid = await _userService.getUserId();
    QuerySnapshot creditCardData = await _creditCardReference.where("cardNumber", isEqualTo: cardNumber).get();

    if(creditCardData.docs.length == 0){
      await _creditCardReference.add({
        'cardNumber': cardNumber,
        'expiryDate': expiryDate,
        'cardHolderName': cardHolderName,
        'userId': uid
      });
    }
  }


  Future<List> listCreditCardDetails() async{
    String uid = await _userService.getUserId();
    List<String> cardNumberList = <String>[];
    QuerySnapshot<Map<String , dynamic>> cardData = await _creditCardReference.where('userId',isEqualTo: uid).get();
    String cardNumber;
    cardData.docs.forEach((docRef){
      cardNumber = docRef.data()['cardNumber'].toString().replaceAll(new RegExp(r"\s+\b|\b\s"),'');
      cardNumberList.add(cardNumber.substring(cardNumber.length - 4));
    });
    return cardNumberList;
  }
  Future<Timestamp> cancelOrder(DocumentReference orderId) async {
         Timestamp now =Timestamp.now();
    await orderId.update({
      'orderStatus' :2,
      'cancelledDate' :now,
    });
    return now;
  }
  // HttpsCallable callable = FirebaseFunctions.instance.httpsCallable(
  //     'hello',
  //     options: HttpsCallableOptions(timeout: Duration(seconds: 5)));

  Future<void> placeNewOrder(Map orderDetails) async{
    String uid = currentUserModel.id;
    var random = new Random();

   int deliveryPin=random.nextInt(899999)+100000;

    String token=await FirebaseMessaging.instance.getToken();
      await FirebaseFirestore.instance.collection('users').doc(uid).update({
        'token' :FieldValue.arrayUnion([token])
      });


    // QuerySnapshot<Map<String , dynamic>> items =orderDetails['bagItems']['list'];
    List items =orderDetails['bagItems']['list'];
    // QuerySnapshot<Map<String , dynamic>> items = await _shoppingBagReference.where('userId',isEqualTo: uid).get();

   if(items.length!=0) {
     List<Map<String,dynamic>> bagItemss=<Map<String,dynamic>>[];
     for(int i=0;i<items.length;i++){
        bagItemss.add(
          {
            'color':items[i]['selectedColor'],
            'id' :items[i]['productId'],
             'name' :items[i]['name'],
             'quantity' :items[i]['quantity'],
             'size' :items[i]['selectedSize'],
          'cut' :items[i]['cut'],
          'unit' :items[i]['unit'],
            'shopId' :items[i]['shopId'],
            'status' :0,
            'shopDiscount' :items[i]['shopDiscount'],
            'price' :double.tryParse(items[i]['price']),
            'image' :items[i]['image'][0],

          }
        );
     }
     await _orderReference.add({
       'userId':  uid,
       'items': bagItemss,
       'shippingAddress': orderDetails['shippingAddress'],
       'shippingMethod': orderDetails['shippingMethod'],
       'price': double.parse("${orderDetails['price']}"),
       'tip': double.parse("${orderDetails['tip']}"),
       'deliveryCharge': double.parse("${orderDetails['deliveryCharge']}"),
       'paymentCard': orderDetails['selectedCard'],
       'placedDate': DateTime.now(),
       'orderStatus' :0,
       'token' :FieldValue.arrayUnion([token]),
       'shops' :orderDetails['shops'],
       'deliveryPin' :deliveryPin.toString(),
       'driverId' :'',
       'driverName' :'',
       'branchId' :currentUserModel.branchId,
     });

   }

    await _shoppingBagService.delete();
  }

  Future<List> listPlacedOrder() async {
    List orderList = [];
    String uid = await _userService.getUserId();
    QuerySnapshot<Map<String , dynamic>> orders = await _orderReference.orderBy('placedDate',descending: true).where('userId', isEqualTo: uid).get();
    for(DocumentSnapshot<Map<String , dynamic>> order in orders.docs) {
      Map orderMap = new Map();
      orderMap['orderDate'] = order.data()['placedDate'];
      orderMap['placedDate'] = order.data()['placedDate'];
      orderMap['cancelledDate'] = order.data()['cancelledDate'];
      orderMap['acceptedDate'] = order.data()['acceptedDate'];
      orderMap['shippedDate'] = order.data()['shippedDate'];
      orderMap['deliveredDate'] = order.data()['deliveredDate'];
      orderMap['orderStatus'] = order.data()['orderStatus'];
      orderMap['deliveryCharge'] = order.data()['deliveryCharge'];
      orderMap['tip'] = order.data()['tip'];
      orderMap['deliveryPin'] = order.data()['deliveryPin'];
      orderMap['orderId'] = order.reference;
      List orderData = [];
      for (int i = 0; i < order.data()['items'].length; i++) {
        Map tempOrderData = new Map();
        tempOrderData['quantity'] = order.data()['items'][i]['quantity'];
        DocumentSnapshot<Map<String , dynamic>> docRef = await _productReference.doc(order.data()['items'][i]['id']).get();
        tempOrderData['productImage'] = docRef.data()['imageId'][0];
        tempOrderData['productName'] = docRef.data()['name'];
        tempOrderData['discountPrice'] = docRef.data()['discountPrice'];
        orderData.add(tempOrderData);
      }
      orderMap['orderDetails'] = orderData;
      orderList.add(orderMap);
    }
    return orderList;
  }

}