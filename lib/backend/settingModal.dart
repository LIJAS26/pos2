//@dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';

class DesignSettings {
  double limit;
 double kmCharge;
 double fixedCharge;
 double fixedChargeLimit;





  DesignSettings(
      {this.limit,this.kmCharge,this.fixedCharge,this.fixedChargeLimit});

  factory DesignSettings.fromDocument(DocumentSnapshot document) {

    return DesignSettings(
      limit: document['limit'],
      kmCharge: document['kmCharge'],
      fixedCharge: document['fixedCharge'],
      fixedChargeLimit: document['fixedChargeLimit'],

    );
  }
}
