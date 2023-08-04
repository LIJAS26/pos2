// @dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:awafi_pos/modals/user.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:awafi_pos/services/userService.dart';

import '../main.dart';

class ProfileService{
  UserService _userService = new UserService();
  FirebaseFirestore _firestore;
  initiateFirebase() async {
    await Firebase.initializeApp();
    _firestore = FirebaseFirestore.instance;


  }
  ProfileService() {
    initiateFirebase();
  }

  // Future<Map> getUserProfile() async{
  //   Map profileDetails = new Map();
  //   String uid = await _userService.getUserId();
  //   QuerySnapshot<Map<String , dynamic>> profileData = await _firestore.collection('users').where('userId',isEqualTo: uid).get();
  //
  //   profileDetails['fullName'] = profileData.docs[0].data()['fullName'];
  //   profileDetails['mobileNumber'] = profileData.docs[0].data()['mobileNumber'];
  //   return profileDetails;
  // }


  Future<QuerySnapshot> getUserSettings() async{
    String uid = await _userService.getUserId();
    QuerySnapshot profileData = await _firestore.collection('profileSetting').where('userId',isEqualTo: uid).get();
    return profileData;
  }

  Future<void> updateAccountDetails(String fullName, String mobileNumber) async{
    try {
      String uid = await _userService.getUserId();

             print(mobileNumber);
    await _firestore.collection('users').doc(uid).update({

        'fullName': fullName,
        'mobileNumber': mobileNumber,

      });

      DocumentSnapshot userData = await _firestore.collection('users')
          .doc(uid)
          .get();
      currentUserModel = User.fromDocument(userData);
    }
    catch(error){
      print(error);
    }
  }

  Future <void> updateUserSettings(Map settings) async{
    String uid = await _userService.getUserId();
    QuerySnapshot userSettings = await getUserSettings();
    String documentId = userSettings.docs[0].id;
    await _firestore.collection('profileSetting').doc(documentId).set({
      'newArrivals': settings['newArrivals'],
      'orderUpdates': settings['orderUpdates'],
      'promotions': settings['promotions'],
      'saleAlerts': settings['saleAlerts'],
      'touchId': settings['touchId'],
      'userId': uid
    });

  }
}