// @dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String id;
   String photoUrl;
   String phoneNo;
   String displayName;
   List wishlist;
  List bag;
  String branchId;



   User(
      {this.phoneNo,
      this.id,
      this.photoUrl,
      this.email,
      this.displayName,
        this.wishlist,
        this.bag,
        this.branchId,
     });

  factory User.fromDocument(DocumentSnapshot document) {


    return User(
      email: document['email'],
      phoneNo: document['mobileNumber']!=null?document['mobileNumber']:'Add Phone',
      photoUrl: document['photoUrl'],
      id: document['userId'],
      displayName: document['fullName'],
      wishlist: document['wishlist'],
      bag: document['bag'],
      branchId:document['branchId'],

    );
  }
}
