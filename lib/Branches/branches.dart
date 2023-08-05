//@dart=2.9
import 'dart:async';

import 'package:awafi_pos/auth/auth_util.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import '../main.dart';

String currentBranchId;
String currentBranchName;
String currentBranchPhNo;
String currentBranchArabic;
String currentBranchAddress;
String vatNumber;
int offerValue;
List offerCategory=[];
// bool offer;

class BranchPageWidget extends StatefulWidget {
  BranchPageWidget({Key key}) : super(key: key);

  @override
  _BranchPageWidgetState createState() => _BranchPageWidgetState();
}

class _BranchPageWidgetState extends State<BranchPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  BuildContext mainContext;
  var data;
  var datas;
  StreamSubscription branch;
  getBranch(){
    branch=FirebaseFirestore.instance.collection('branches')
        .where('admins',arrayContains: currentUserEmail)
        .snapshots().listen((value) async {
      data=value.docs.length;
      datas=value.docs;

      if(data==1){

        currentBranchId = datas[0]['branchId'];
        // FirebaseMessaging.instance.subscribeToTopic(currentBranchId.toString());
        currentBranchName = datas[0]['name'];
        currentBranchPhNo = datas[0]['number'];
        currentBranchAddress = datas[0]['currentBranchAddress'];
        currentBranchArabic = datas[0]['currentBranchArabic'];
        offerValue=datas[0]['offerPercentage']??0;
        offerCategory=datas[0]['offercategories'];
        offer = datas[0]['offer']??false;
        DelCharge=datas[0]["deliveryCharge"]??0;
        vatNumber=datas[0]["vatNumber"];



       if(mounted){
         setState(() {
         });
       }

        print(currentBranchId);

        await Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (mainContext) =>
                HomeBody(),
          ),
        );
      }
      if(mounted){
        setState(()  {
          data=value.docs.length;
          datas=value.docs;
          print(data);
        });
      }
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getBranch();

  }

  @override
  void dispose() {
    branch?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    mainContext=context;
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.primaryColor,
        automaticallyImplyLeading: false,
        title: Text(
          'Pick Your Branch',
          style: FlutterFlowTheme.bodyText1.override(
            fontFamily: 'Poppins',
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: Color(0xFFF5F5F5),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(15, 15, 15, 15),
          child: datas==null?
          Center(child:CircularProgressIndicator() )
              :data==0?Center(child: Text('No Branches Found'),):
          GridView.builder(
            padding: EdgeInsets.zero,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1,
            ),
            scrollDirection: Axis.vertical,
            itemCount: data,
            itemBuilder: (BuildContext context, int index) {

              return InkWell(
                onTap: () async {

                  currentBranchId=datas[index]['branchId'];
                  FirebaseMessaging.instance.subscribeToTopic(currentBranchId);
                  currentBranchName = datas[index]['name'];
                  currentBranchPhNo = datas[0]['number'];
                  currentBranchAddress = datas[0]['currentBranchAddress'];
                  currentBranchArabic = datas[0]['currentBranchArabic'];
                  offerValue=datas[0]['offerPercentage']??0;
                  offerCategory=datas[0]['offercategories'];
                  offer = datas[0]['offer']??false;
                  DelCharge=datas[0]["deliveryCharge"]??0;
                  vatNumber=datas[0]["vatNumber"];



                  setState(() {
                    currentBranchId=datas[index]['branchId'];
                    currentBranchName = datas[index]['name'];
                    currentBranchPhNo = datas[0]['number'];
                    currentBranchAddress = datas[0]['currentBranchAddress'];
                    currentBranchArabic = datas[0]['currentBranchArabic'];
                    offerValue=datas[0]['offerPercentage']??0;
                    offerCategory=datas[0]['offercategories'];
                    offer = datas[0]['offer']??false;
                    DelCharge=datas[0]["deliveryCharge"];
                    vatNumber=datas[0]["vatNumber"];


                  });

                  print(currentBranchId);

                  await   Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          HomeBody(),
                    ),
                        (r) => false,
                  );
                },
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: const BoxDecoration(
                    color: Color(0xFFA1AB99),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(0),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            datas[index]['name'],
                            style: FlutterFlowTheme.bodyText1.override(
                                fontFamily: 'Poppins',
                                fontSize: 18,
                                color: Colors.black

                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          ),
          // StreamBuilder<QuerySnapshot>(
          //   stream: FirebaseFirestore.instance.collection('branches').where('admins',arrayContains: currentUserEmail).snapshots(),
          //   builder: (context, snapshot) {
          //     // Customize what your widget looks like when it's loading.
          //     if (!snapshot.hasData) {
          //       return Center(
          //         child: SizedBox(
          //           width: 50,
          //           height: 50,
          //           child: CircularProgressIndicator(
          //             color: FlutterFlowTheme.primaryColor,
          //           ),
          //         ),
          //       );
          //     }
          //     var data=snapshot.data.docs;
          //
          //     if(data.length==1){
          //
          //       currentBranchId=data[0]['branchId'];
          //       print(currentBranchId);
          //
          //      Navigator.pushReplacement(
          //         context,
          //         MaterialPageRoute(
          //           builder: (mainContext) =>
          //               NavBarPage(initialPage: 'HomePage'),
          //         ),
          //       );
          //
          //     }
          //
          //     return data.length==0?Center(child: Text('No Branches Available'),):
          //     GridView.builder(
          //       padding: EdgeInsets.zero,
          //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //         crossAxisCount: 2,
          //         crossAxisSpacing: 10,
          //         mainAxisSpacing: 10,
          //         childAspectRatio: 1,
          //       ),
          //       scrollDirection: Axis.vertical,
          //       itemCount: data.length,
          //       itemBuilder: (BuildContext context, int index) {
          //
          //         return InkWell(
          //           onTap: () async {
          //             currentBranchId=data[index]['branchId'];
          //
          //             await   Navigator.pushAndRemoveUntil(
          //               context,
          //               MaterialPageRoute(
          //                 builder: (context) =>
          //                     NavBarPage(initialPage: 'HomePage'),
          //               ),
          //                   (r) => false,
          //             );
          //           },
          //           child: Container(
          //             width: 150,
          //             height: 150,
          //             decoration: BoxDecoration(
          //               color: Color(0xFFA1AB99),
          //               borderRadius: BorderRadius.only(
          //                 bottomLeft: Radius.circular(0),
          //                 bottomRight: Radius.circular(10),
          //                 topLeft: Radius.circular(10),
          //                 topRight: Radius.circular(0),
          //               ),
          //             ),
          //             child: Column(
          //               mainAxisSize: MainAxisSize.max,
          //               mainAxisAlignment: MainAxisAlignment.center,
          //               children: [
          //                 Row(
          //                   mainAxisSize: MainAxisSize.max,
          //                   mainAxisAlignment: MainAxisAlignment.center,
          //                   children: [
          //                     Text(
          //                      data[index]['name'],
          //                       style: FlutterFlowTheme.bodyText1.override(
          //                         fontFamily: 'Poppins',
          //                         fontSize: 18,
          //                         color: Colors.black
          //
          //                       ),
          //                     )
          //                   ],
          //                 )
          //               ],
          //             ),
          //           ),
          //         );
          //       },
          //     );
          //   },
          // ),
        ),
      ),
    );
  }
}
