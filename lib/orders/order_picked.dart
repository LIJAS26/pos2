//@dart=2.9
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:awafi_pos/flutter_flow/upload_media.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../main.dart';


class PickedOrdersWidget extends StatefulWidget {
  final String orderId;
  const PickedOrdersWidget({Key key, this.orderId}) : super(key: key);

  @override
  _PickedOrdersWidgetState createState() => _PickedOrdersWidgetState();
}

class _PickedOrdersWidgetState extends State<PickedOrdersWidget> {
  bool _loadingButton = false;

  bool cash=false;
  bool lunch=false;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  List billItem=[];
  String pin='';
  TextEditingController deliveryPin;
  @override
  void initState() {
    super.initState();
    deliveryPin=TextEditingController();
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('orders')
            .where('orderId',isEqualTo: widget.orderId)
            .snapshots(),
        builder: (context, snapshot) {
          if(!snapshot.hasData){
            return const Center(child: CircularProgressIndicator());
          }
          var data=snapshot.data.docs;
          var bag=data[0]['salesItems'];
          List addOn=[];


          for(Map<String,dynamic> snap in bag){
            addOn=snap['addOn'];
          }
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              backgroundColor: FlutterFlowTheme.primaryColor,
              automaticallyImplyLeading: true,
              title: Text(
                'Order Details',
                style: FlutterFlowTheme.bodyText1.override(
                  fontFamily: 'Poppins',
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              actions: const [],
              centerTitle: true,
              elevation: 0,
            ),
            backgroundColor: const Color(0xFFF5F5F5),
            body: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Material(
                          color: Colors.white,
                          elevation: 5,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(0),
                              bottomRight: Radius.circular(0),
                              topLeft: Radius.circular(0),
                              topRight: Radius.circular(30),
                            ),
                          ),
                          child: Container(
                            width: MediaQuery.of(context).size.width*0.9,


                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(0),
                                bottomRight: Radius.circular(0),
                                topLeft: Radius.circular(0),
                                topRight: Radius.circular(30),
                              ),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding:
                                  const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Order Id : ${data[0]['orderId']}',
                                        style: FlutterFlowTheme.bodyText1.override(
                                          fontFamily: 'Poppins',
                                          color: Colors.black,
                                          fontSize: 14,
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsetsDirectional.fromSTEB(10, 5, 0, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Customer Name :${data[0]['name']}',
                                        style: FlutterFlowTheme.bodyText1.override(
                                          fontFamily: 'Poppins',
                                          color: Colors.black,
                                          fontSize: 14,
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsetsDirectional.fromSTEB(10, 5, 0, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'Address : ${data[0]['address']}',
                                          style: FlutterFlowTheme.bodyText1.override(
                                            fontFamily: 'Poppins',
                                            color: Colors.black,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsetsDirectional.fromSTEB(10, 5, 0, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Phone Number : ${data[0]['phone']}',
                                        style: FlutterFlowTheme.bodyText1.override(
                                          fontFamily: 'Poppins',
                                          color: Colors.black,
                                          fontSize: 14,
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsetsDirectional.fromSTEB(10, 5, 10, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'Delivery Location : ${data[0]['address']}',
                                          style: FlutterFlowTheme.bodyText1.override(
                                            fontFamily: 'Poppins',
                                            color: Colors.black,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsetsDirectional.fromSTEB(10, 5, 0, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Branch : ${data[0]['branchName']}',
                                        style: FlutterFlowTheme.bodyText1.override(
                                          fontFamily: 'Poppins',
                                          color: Colors.black,
                                          fontSize: 14,
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsetsDirectional.fromSTEB(10, 5, 0, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Table : ',
                                        style: FlutterFlowTheme.bodyText1.override(
                                          fontFamily: 'Poppins',
                                          color: Colors.black,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        '${data[0]['table']}',
                                        style: FlutterFlowTheme.bodyText1.override(
                                            fontFamily: 'Poppins',
                                            color:data[0]['table']=='Home Delivery'? Colors.blue
                                                : data[0]['table']=='Take Away'?Colors.green
                                                : Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),

                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                      child: bag==null?const Center(child: CircularProgressIndicator(),):

                      ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: bag.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (BuildContext context,int index){

                          double addOnPrice=0;

                          List addOnName=[];
                          for(Map<String,dynamic> items in addOn){
                            addOnName.add(items['addOn']);
                            addOnPrice+=double.tryParse(items['price']);

                          }
                          Map<String,dynamic> variants={};
                          if(bag.isNotEmpty){
                            variants=bag[index]['variant'];
                          }

                          billItem.add({
                            'addOnPrice':double.tryParse(addOnPrice.toStringAsFixed(2)),
                            'addOns':addOnName,
                            'addOnArabic':[],
                            'variant':variants,
                            'arabicName':bag[index]['arabicName'],
                            'pdtname':bag[index]['productName'],
                            'price':bag[index]['price']/bag[index]['qty'],
                            'qty':int.tryParse(bag[index]['qty'].toString()),
                          });

                          return  Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Material(
                              color: Colors.transparent,
                              elevation: 5,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(0),
                                  bottomRight: Radius.circular(10),
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(0),
                                ),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      CachedNetworkImage(
                                        imageUrl:
                                        bag[index]['photoUrl'],
                                        width: 90,
                                        height: 90,
                                        fit: BoxFit.contain,
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(

                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    bag[index]['productName'],
                                                    style:
                                                    FlutterFlowTheme.bodyText1.override(
                                                      fontFamily: 'Poppins',
                                                      color: Colors.black,
                                                      fontSize: 13,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ),
                                                  Text(variants.isEmpty?'': ' - ${variants['english']}',style: const TextStyle(fontWeight: FontWeight.w600),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                addOnName.isEmpty?'':
                                                addOnName.toString().substring(1,addOnName.toString().length-1),


                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    'Qty : ${bag[index]['qty'].toString()}',
                                                    style:
                                                    FlutterFlowTheme.bodyText1.override(
                                                      fontFamily: 'Poppins',
                                                      color: Colors.black,
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ),
                                                  Text(
                                                    'SAR ${bag[index]['price'].toString()}',
                                                    style:
                                                    FlutterFlowTheme.bodyText1.override(
                                                      fontFamily: 'Poppins',
                                                      color: Colors.black,
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },

                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  data[0]['table']=='Home Delivery'?
                  Container(
                    height: 40,width: 150,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.black
                        ),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Center(
                      child: TextField(
                        controller: deliveryPin,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        style: TextStyle(

                          fontSize: 18,
                          fontWeight:
                          FontWeight.normal,
                          color: Colors.black,

                        ),
                        decoration:

                        InputDecoration(
                          contentPadding: EdgeInsets.all(5),
                          fillColor: Colors.white,
                          hintText: 'ENTER DELIVERY PIN',
                          hintStyle:  TextStyle(
                              fontSize: 12,
                              fontWeight:
                              FontWeight.normal,
                              color: Colors.black
                                  .withOpacity(
                                  0.250)
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                              BorderRadius
                                  .circular(
                                  9),
                              borderSide: BorderSide(
                                  color: Color
                                      .fromRGBO(
                                      42,
                                      172,
                                      146,
                                      0.0))),
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                              BorderRadius
                                  .circular(
                                  9),
                              borderSide: BorderSide(
                                  color: Color
                                      .fromRGBO(
                                      42,
                                      172,
                                      146,
                                      0.0))),
                          filled: true,
                          // border: OutlineInputBorder(
                          //     borderRadius: BorderRadius.circular(20),
                          //     borderSide: BorderSide(color: Colors.yellow)),
                        ),
                      ),
                    ),
                  )
                      :Container(),
                  SizedBox(height: 10,),
                  Align(
                    alignment: const AlignmentDirectional(0, 1),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(10, 20, 20, 40),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Total Price : SAR ${data[0]['total']}',
                            style: FlutterFlowTheme.bodyText1.override(
                              fontFamily: 'Poppins',
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(0, 0.45),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // Container(
                          //   width: MediaQuery.of(context).size.width*0.1,
                          //   height: 50,
                          //   child: Row(
                          //     children: [
                          //       Text('Cash',style: TextStyle(
                          //           fontWeight: FontWeight.bold,
                          //           color: Colors.black,
                          //           fontSize: 17
                          //       ),
                          //       ),
                          //       Checkbox(
                          //         value: cash,
                          //         onChanged: (value) {
                          //           setState(() {
                          //             cash = !cash;
                          //             if(cash==true){
                          //               lunch=false;
                          //             }
                          //           });
                          //         },
                          //       ),
                          //
                          //     ],
                          //   ),
                          // ),
                          // Container(
                          //   width: MediaQuery.of(context).size.width*0.1,
                          //   height: 50,
                          //   child: Row(
                          //     children: [
                          //       Text('Bank',style: TextStyle(
                          //           fontWeight: FontWeight.bold,
                          //           color: Colors.black,
                          //           fontSize: 17
                          //       ),
                          //       ),
                          //       Checkbox(
                          //         value: lunch,
                          //         onChanged: (value) {
                          //           setState(() {
                          //             lunch = !lunch;
                          //             if(lunch==true){
                          //               cash=false;
                          //             }
                          //
                          //           });
                          //         },
                          //       ),
                          //
                          //     ],
                          //   ),
                          // ),
                          FFButtonWidget(
                            onPressed: () async {
                              print('gggggggggg');
                              setState(() => _loadingButton = true);

                              if(data[0]['table']=='Home Delivery'){
                                log('TRUEEE');
                                try {
                                  pin=data[0]['deliveryPin'];
                                  if(deliveryPin.text!=''&&deliveryPin.text==pin.toString()){
                                    DocumentSnapshot order=data[0];
                                    order.reference.update({
                                      // 'cash':cash==true?true:false,
                                      'currentUserId':currentUserId,
                                      'status':2,
                                      'DeliveredTime':DateTime.now(),
                                    });
                                    Navigator.pop(context);
                                    showUploadMessage(context, ' Order Delivered');
                                  }else{
                                    deliveryPin.text==''?
                                    showUploadMessage(context, 'Please Enter Delivery Pin'):
                                    showUploadMessage(context, 'Wrong Delivery Pin');
                                  }
                                } finally {
                                  setState(() => _loadingButton = false);
                                }

                              }else if(data[0]['table']!='Home Delivery'){
                                log('ELSE SSSSS');

                                DocumentSnapshot order=data[0];
                                order.reference.update({
                                  // 'cash':cash==true?true:false,
                                  'currentUserId':currentUserId,
                                  'status':2,
                                  'DeliveredTime':DateTime.now(),
                                });
                                Navigator.pop(context);
                                showUploadMessage(context, ' Order Delivered');
                              }

                            },
                            text: 'Mark As Delivered',
                            options: FFButtonOptions(
                              width:160,
                              height: 45,
                              color: const Color(0xFF04C130),
                              textStyle: FlutterFlowTheme.subtitle2.override(
                                fontFamily: 'Poppins',
                                color: Colors.white,
                                fontSize: 13,
                              ),
                              borderSide: const BorderSide(
                                color: Colors.transparent,
                                width: 1,
                              ),
                              borderRadius: 12,
                            ),
                            loading: _loadingButton,
                          ),
                          SizedBox(width: MediaQuery.of(context).size.width*0.1,)
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        }
    );
  }
}
