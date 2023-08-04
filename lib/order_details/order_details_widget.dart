// @dart=2.9
import 'dart:convert';
import 'dart:typed_data';

import 'package:awafi_pos/Branches/branches.dart';
import 'package:awafi_pos/flutter_flow/upload_media.dart';
import 'package:awafi_pos/main.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as im;

import '../product_card.dart';


class OrderDetailsWidget extends StatefulWidget {
  OrderDetailsWidget({
    Key key,
    this.order,
    this.orderUser,
  }) : super(key: key);
  final UsersRecord orderUser;
  final OrdersRecord order;

  @override
  _OrderDetailsWidgetState createState() => _OrderDetailsWidgetState();
}

class _OrderDetailsWidgetState extends State<OrderDetailsWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController statusController = TextEditingController();
  bool listView = false;
  Map colorMap = new Map();

  List orderData = [];
  List<DropdownMenuItem> fetchedRiders = [];
  Map<String,dynamic> selectedRider;

  Future<void> getOrderItems() async {
    List ordersItems = [];
    for (int i = 0; i < widget.order.items.length; i++) {
      Map tempOrderData = new Map();
      tempOrderData['quantity'] = widget.order.items[i].quantity;
      tempOrderData['color'] = colorList(widget.order.items[i].color);
      tempOrderData['size'] = widget.order.items[i].size;
      DocumentSnapshot<Map<String, dynamic>> docRef = await FirebaseFirestore
          .instance
          .collection('products')
          .doc(widget.order.items[i].id)
          .get();
      tempOrderData['productImage'] = docRef.data()['imageId'][0];
      tempOrderData['productName'] = docRef.data()['name'];
      tempOrderData['price'] = docRef.data()['price'];
      ordersItems.add(tempOrderData);
    }
    if(mounted) {
      setState(() {
        orderData = ordersItems;
      });
    }
  }
  List<int> bytes = [];
  qr(String vatTotal1, String grantTotal) {
    // seller name
    String sellerName = 'AEEDAH AL KADEEM';
    String vat_registration = '301139464800003';
    String vatTotal = vatTotal1;
    String invoiceTotal = grantTotal;
    BytesBuilder bytesBuilder = BytesBuilder();
    bytesBuilder.addByte(1);
    List<int> sellerNameBytes = utf8.encode(sellerName);
    bytesBuilder.addByte(sellerNameBytes.length);
    bytesBuilder.add(sellerNameBytes);

    //vat registration
    bytesBuilder.addByte(2);
    List<int> vat_registrationBytes = utf8.encode(vat_registration);
    bytesBuilder.addByte(vat_registrationBytes.length);
    bytesBuilder.add(vat_registrationBytes);

    //date
    bytesBuilder.addByte(3);
    List<int> date = utf8.encode(DateTime.now().toString().substring(0, 10));
    bytesBuilder.addByte(date.length);
    bytesBuilder.add(date);
    print(date);

    //invoice total

    bytesBuilder.addByte(4);
    List<int> invoiceTotals = utf8.encode(invoiceTotal);
    bytesBuilder.addByte(invoiceTotals.length);
    bytesBuilder.add(invoiceTotals);

    //vat total

    bytesBuilder.addByte(5);
    List<int> vatTotals = utf8.encode(vatTotal);
    bytesBuilder.addByte(vatTotals.length);
    bytesBuilder.add(vatTotals);

    Uint8List qrCodeAsBytes = bytesBuilder.toBytes();
    const Base64Encoder base64encoder = Base64Encoder();
    return base64encoder.convert(qrCodeAsBytes);
  }


  ScreenshotController screenshotController = ScreenshotController();
  abc(int invNo,double discount,List items,int token) async {
    print('start');
    print(Timestamp.now().seconds);
    final CapabilityProfile profile = await   CapabilityProfile.load();
    print(Timestamp.now().seconds);

    final generator = Generator(PaperSize.mm80, profile);
    bytes = [];



    final Uint8List imgBytes = data.buffer.asUint8List();
    final im.Image image = im.decodeImage(imgBytes);
    bytes += generator.image(image);

    var capturedImage1= await    screenshotController
        .captureFromWidget(Container(
      color: Colors.white,
      width: printWidth*3.8,
      child: ListView(
          shrinkWrap: true,
          children:[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(currentBranchArabic,style:  TextStyle(fontFamily:'GE Dinar One Medium',color: Colors.black,fontSize: printWidth*.20,fontWeight: FontWeight.w600),),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('$currentBranchPhNo: رقمالهتف  ',style:  TextStyle(fontFamily:'GE Dinar One Medium',color: Colors.black,fontSize: printWidth*.17,fontWeight: FontWeight.w600),),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:  [
                Text(' رقمالظريبة : 301139464800003',style: TextStyle(fontFamily:'GE Dinar One Medium',color: Colors.black,fontSize: printWidth*.17,fontWeight: FontWeight.w600),),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:  [
                Text('${DateTime.now().toString().substring(0, 19)}: تاريخ  ',style:  TextStyle(fontFamily:'GE Dinar One Medium',color: Colors.black,fontSize: printWidth*.17,fontWeight: FontWeight.w600),),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:  [
                Text('$invNo: رقم الفاتورة  ',style:  TextStyle(fontFamily:'GE Dinar One Medium',color: Colors.black,fontSize: printWidth*.17,fontWeight: FontWeight.w600),),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:   [
                Text('زبون : زبون مشي',style: TextStyle(fontFamily:'GE Dinar One Medium',color: Colors.black,fontSize: printWidth*.17,fontWeight: FontWeight.w600),),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:   [
                Text('$token: رقم رمزي   ',style:  TextStyle(fontFamily:'GE Dinar One Medium',color: Colors.black,fontSize: printWidth*.17,fontWeight: FontWeight.w600),),
              ],
            ),
            // Container( padding: const EdgeInsets.all(1.0),
            //     decoration: const BoxDecoration(
            //       color: Colors.white,
            //     ),
            //     child: const Center(child: Text('.............................................',
            //       style: TextStyle(color: Colors.black,fontSize: 25),))),

          ]
      ),
    ));

    final im.Image image1 = im.decodeImage(capturedImage1);
    bytes += generator.image(image1);


    final Uint8List imgBytes1 = data1.buffer.asUint8List();
    final im.Image image11 = im.decodeImage(imgBytes1);
    bytes += generator.image(image11);
    String itemString = '';
    String itemStringArabic = '';
    String itemTotal = '';
    String itemGrossTotal = '';
    String itemTax = '';
    String addON = '';

    double deliveryCharge = 0;
    double grantTotal = 0;
    double totalAmount = 0;
    String arabic = '';
    Map<String, dynamic> config = Map();
    List<Widget> itemWidgets=[];
    for (Map<String, dynamic> item in items) {

      double total = double.tryParse(item['price'].toString()) *
          double.tryParse(item['qty'].toString());
      double grossTotal = total * 100 / 115;
      double vat = total * 15 / 115;
      newAddOn = item['addOns'];
      arabic = item['arabicName'];


      grantTotal += total;

      deliveryCharge = item['deliveryCharge'] == null
          ? 0
          : double.tryParse(item['deliveryCharge'].toString());
      addON = newAddOn.isEmpty ? '' : newAddOn.toString();
      double price = double.tryParse(item['price'].toString()) * 100 / 115;
      totalAmount += price * double.tryParse(item['qty'].toString());

      itemWidgets.add(
          Container(
              padding: const EdgeInsets.all(1.0),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: ListView(
                  shrinkWrap: true,
                  children:[
                    Text(arabic,
                      // textDirection: TextDirection.rtl,
                      style:  TextStyle(
                        fontFamily:'GE Dinar One Medium',
                        fontSize: printWidth*.15,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    // Text("${item['pdtname']} $addON",
                    //   textDirection: TextDirection.ltr,
                    //   style: const TextStyle(
                    //     fontSize: 14,
                    //     color: Colors.black,
                    //   ),
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("${double.tryParse(item['qty'].toString())}  ${price.toStringAsFixed(2)}  ${vat.toStringAsFixed(2)}  ${total.toStringAsFixed(2)}",
                          textDirection: TextDirection.ltr,
                          style:  TextStyle(
                            fontSize: printWidth*.15,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    )
                  ]
              )));


      itemTotal += (totalAmount * ((100 + gst) / 100) -
          (double.tryParse(discount.toString()) ?? 0))
          .toStringAsFixed(2);
      itemGrossTotal += grossTotal.toStringAsFixed(2);
      itemTax += (totalAmount * gst / 100).toStringAsFixed(2);
    }

    List<Widget> itemWidgets1=[];
    List<Widget> itemWidgets2=[];
    itemWidgets.add( Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container( padding: const EdgeInsets.all(1.0),
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child:  Center(child: Text('..................................................',
              style: TextStyle(color: Colors.black,fontSize: printWidth*.25),))),
        Container(
          padding: const EdgeInsets.all(1.0),
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child:     Center(
            child: Text("  الاجمامي : ${totalAmount.toStringAsFixed(2)}",
              // textDirection: TextDirection.rtl,
              style:  TextStyle(
                fontFamily:'GE Dinar One Medium',
                fontSize: printWidth*.16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),),
        Container(    padding: const EdgeInsets.all(1.0),
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child:     Center(
            child: Text("  الضريبة : ${(totalAmount * gst / 100).toStringAsFixed(2)}",
              // textDirection: TextDirection.rtl,
              style:  TextStyle(
                fontFamily: 'GE Dinar One Medium',
                fontSize: printWidth*.16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),),
        Container(    padding: const EdgeInsets.all(1.0),
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child:     Center(
            child: Text("  توصيل : $deliveryCharge",
              // textDirection: TextDirection.rtl,
              style:  TextStyle(
                fontFamily: 'GE Dinar One Medium',
                fontSize: printWidth*.16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),),
        Container( padding: const EdgeInsets.all(1.0),
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child:  Center(child: Text('.............................................',
              style: TextStyle(color: Colors.black,fontSize: printWidth*.25),))),
        Container(    padding: const EdgeInsets.all(1.0),
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child:     Center(
            child: Text("  خص : ${(discount==null?"0.00":discount.toStringAsFixed(2))}",
              // textDirection: TextDirection.rtl,
              style:  TextStyle(
                fontFamily: 'GE Dinar One Medium',
                fontSize: printWidth*.16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),),
        Container(    padding: const EdgeInsets.all(1.0),
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child:     Center(
            child: Text("  المجموع الإجمالي : ${grantTotal.toStringAsFixed(2)}",
              // textDirection: TextDirection.rtl,
              style:  TextStyle(
                fontFamily: 'GE Dinar One Medium',
                fontSize: printWidth*.16,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),),
      ],
    ));

    String qrVat = (totalAmount * gst / 100).toStringAsFixed(2);
    String qrTotal = grantTotal.toStringAsFixed(2);
    // bluetooth.printQRcode(qr(qrVat, qrTotal), 200, 200, 1);
    itemWidgets.add(Container(
      color: Colors.white,
      width: qrCode,

      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          QrImage(
            data: qr(qrVat, qrTotal),
            version: 6,
            size: size,
          ),
        ],
      ),
    ));

    itemWidgets.add(Container(
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children:  [
          Text('شكرا لك الزيارة مرة أخرى',style: TextStyle(fontFamily:'GE Dinar One Medium',color: Colors.black,fontSize: printWidth*.16,fontWeight: FontWeight.w600),),
        ],
      ),
    ));

    var capturedImage2 = await screenshotController
        .captureFromWidget(Container(
      width: printWidth*3.6,

      child: ListView.builder(
          shrinkWrap: true,
          itemCount: itemWidgets.length,
          itemBuilder: (context, index) {
            return itemWidgets[index];
          }),
    ));

    final im.Image image2 = im.decodeImage(capturedImage2);
    bytes += generator.image(image2);

    try {

      bytes += generator.feed(2);

      bytes += generator.cut();
      // await flutterUsbPrinter.connect(1155, 22339);
      flutterUsbPrinter.write(Uint8List.fromList(bytes));

    }
    catch (error) {
      print(error.toString(),);
    }
    print("end");
    print(Timestamp.now().seconds);
  }


  @override
  void initState() {
    // TODO: implement initState
    colorLists();

    statusController.text = (widget.order.orderStatus == 0)
        ? 'Pending'
        : (widget.order.orderStatus == 1)
            ? 'Accepted'
            : 'Cancelled';
    super.initState();
    if (fetchedRiders.isEmpty) {
      getRiders().then((value) {
        setState(() {});
      });
    }
  }
  Future getRiders() async {
    QuerySnapshot data1 =
    await FirebaseFirestore.instance.collection("rider").where('online',isEqualTo: true).get();
    for (var doc in data1.docs) {
      fetchedRiders.add(DropdownMenuItem(
        child: Text(doc.get('display_name')),
        value:  doc.data(),
      ));
      if(widget.order.driverId==doc.get('uid')){

        setState(() {
          selectedRider=doc.data();
        });

      }
    }
  }

  void colorLists() async {
    Map colorMaps = Map();

    DocumentSnapshot<Map<String, dynamic>> colorRef = await FirebaseFirestore
        .instance
        .collection('colors')
        .doc('colors')
        .get();
    List colorList = colorRef.data()['colorList'];
    for (int i = 0; i < colorList.length; i++) {
      colorMaps[colorList[i]['code']] = colorList[i]['name'];
    }

    setState(() {
      colorMap = colorMaps;
    });
    getOrderItems();
  }

  String colorList(String colorName) {
    print(colorName);
    if (colorMap[colorName] != null) {
      return colorMap[colorName];
    } else {
      return 'NotFound';
    }
  }

  @override
  Widget build(BuildContext context) {
    final orderDetailsOrdersRecord = widget.order;
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: primaryColor,
        automaticallyImplyLeading: true,
        title: Text(
          statusController.text + ' Order',
          style: FlutterFlowTheme.title2.override(
            fontFamily: 'Poppins',color: Colors.white
          ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 4,
      ),
      body: SafeArea(
        minimum: EdgeInsets.only(left: 5.0, right: 5.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 20, 20),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                    child: FFButtonWidget(
                      onPressed: () async {
                        bool proceed = await alert(
                            context, 'You want to cancel this order?');

                        if (proceed) {
                          final orderStatus = 2;


                          final ordersRecordData = createOrdersRecordData(
                            orderStatus: orderStatus,
                            cancelledDate: Timestamp.now(),
                          );

                          await orderDetailsOrdersRecord.reference
                              .update(ordersRecordData);
                          setState(() {
                            statusController.text = 'cancelled';
                          });
                        }
                      },
                      text: 'Cancel',
                      options: FFButtonOptions(
                        width: 110,
                        height: 40,
                        color: FlutterFlowTheme.primaryColor,
                        textStyle: FlutterFlowTheme.subtitle2.override(
                          fontFamily: 'Poppins',
                          color: Colors.white,
                        ),
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                        borderRadius: 12,
                      ),
                    ),
                  ),
                  FFButtonWidget(
                    onPressed: () async {
                      bool proceed = await alert(
                          context, 'You want to accept this order?');

                      if (proceed) {
                        final orderStatus = 1;

                        final ordersRecordData = createOrdersRecordData(
                          orderStatus: orderStatus,
                          acceptedDate: Timestamp.now(),
                        );

                        await orderDetailsOrdersRecord.reference
                            .update(ordersRecordData);
                        setState(() {
                          statusController.text = 'Accepted';
                        });
                      }
                    },
                    text: 'Accept',
                    options: FFButtonOptions(
                      width: 110,
                      height: 40,
                      color: FlutterFlowTheme.primaryColor,
                      textStyle: FlutterFlowTheme.subtitle2.override(
                        fontFamily: 'Poppins',
                        color: Colors.white,
                      ),
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 1,
                      ),
                      borderRadius: 12,
                    ),
                  ),

                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 20, 20),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                    child: FFButtonWidget(
                      onPressed: () async {
                        bool proceed = await alert(
                            context, 'this order is shipped?');

                        if (proceed) {
                          final orderStatus = 3;

                          final ordersRecordData = createOrdersRecordData(
                            orderStatus: orderStatus,
                            shippedDate: Timestamp.now(),
                          );

                          await orderDetailsOrdersRecord.reference
                              .update(ordersRecordData);
                          setState(() {
                            statusController.text = 'Shipped';
                          });
                        }
                      },
                      text: 'Shipped',
                      options: FFButtonOptions(
                        width: 110,
                        height: 40,
                        color: FlutterFlowTheme.primaryColor,
                        textStyle: FlutterFlowTheme.subtitle2.override(
                          fontFamily: 'Poppins',
                          color: Colors.white,
                        ),
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                        borderRadius: 12,
                      ),
                    ),
                  ),
                  FFButtonWidget(
                    onPressed: () async {
                      bool proceed = await alert(
                          context, 'this order is delivered?');

                      if (proceed) {
                        final orderStatus = 4;


                        final ordersRecordData = createOrdersRecordData(
                          orderStatus: orderStatus,
                          deliveredDate: Timestamp.now(),
                        );

                        await orderDetailsOrdersRecord.reference
                            .update(ordersRecordData);
                        setState(() {
                          statusController.text = 'Delivered';
                        });
                      }
                    },
                    text: 'Delivered',
                    options: FFButtonOptions(
                      width: 110,
                      height: 40,
                      color: FlutterFlowTheme.primaryColor,
                      textStyle: FlutterFlowTheme.subtitle2.override(
                        fontFamily: 'Poppins',
                        color: Colors.white,
                      ),
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 1,
                      ),
                      borderRadius: 12,
                    ),
                  ),

                ],
              ),
            ),
            Column(
              children: [
                Text('List'),
                Switch(
                  value: listView,
                  onChanged: (value) {
                    setState(() {
                      listView = value;
                    });
                  },
                )
              ],
            ),
            Row(
                children:[
                  Container(
                    width: 250,
                    // height: 70,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Color(0xFFE6E6E6),
                      ),
                    ),
                    child:SearchableDropdown.single(
                  items: fetchedRiders,
                  value: selectedRider,
                  hint:selectedRider==null? "Assign Rider":selectedRider['display_name'],
                  searchHint: "Select Rider",
                  onChanged: (value) {
                    setState(() {

                      selectedRider = value;

                    });

                  },
                  isExpanded: true,
                ),),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FFButtonWidget(
                      onPressed: () async {
                        bool proceed = await alert(
                            context, 'You want this rider Assigned?');

                        if (proceed) {
                         String driverId=selectedRider==null?"":selectedRider['uid'];
                         String driverName=selectedRider==null?"":selectedRider['display_name'];


                          final ordersRecordData = createOrdersRecordData(
                           driverId:driverId,
                            driverName: driverName,

                          );

                          await orderDetailsOrdersRecord.reference
                              .update(ordersRecordData);
                          setState(() {
                            statusController.text = 'Driver Assigned';
                          });
                        }
                      },
                      text: 'Assign',
                      options: FFButtonOptions(
                        width: 110,
                        height: 40,
                        color: FlutterFlowTheme.primaryColor,
                        textStyle: FlutterFlowTheme.subtitle2.override(
                          fontFamily: 'Poppins',
                          color: Colors.white,
                        ),
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                        borderRadius: 12,
                      ),
                    ),
                  ),
                ]
              ),

            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Text(
                //   'Customer name : ',
                //   style: FlutterFlowTheme.bodyText1.override(
                //     fontFamily: 'Poppins',
                //   ),
                // ),
                Container(
                  width: MediaQuery.of(context).size.width/2,
                  child: Text(
                    widget.orderUser.fullName,

                    style: FlutterFlowTheme.title3.override(
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
                Text(
                  orderDetailsOrdersRecord.placedDate
                      .toDate()
                      .toLocal()
                      .toString(),

                  style: FlutterFlowTheme.bodyText1.override(
                    fontFamily: 'Poppins',

                  ),

                )
              ],
            ),
            // Row(
            //   mainAxisSize: MainAxisSize.max,
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Text(
            //       'Order Time : ',
            //       style: FlutterFlowTheme.bodyText1.override(
            //         fontFamily: 'Poppins',
            //       ),
            //     ),
            //     Text(
            //       orderDetailsOrdersRecord.placedDate.toDate().toLocal().toString(),
            //       style: FlutterFlowTheme.bodyText1.override(
            //         fontFamily: 'Poppins',
            //       ),
            //     )
            //   ],
            // ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Text(
                //   'Total Amount : ',
                //   style: FlutterFlowTheme.bodyText1.override(
                //     fontFamily: 'Poppins',
                //   ),
                // ),
                Text(
                  '\₹ ${orderDetailsOrdersRecord.price.toString()}',
                  style: FlutterFlowTheme.title3.override(
                    fontFamily: 'Poppins',
                  ),
                ),
                Text(
                  orderDetailsOrdersRecord.shippingMethod,
                  style: FlutterFlowTheme.title3.override(
                    fontFamily: 'Poppins',
                  ),
                )
              ],
            ),
            // Row(
            //   mainAxisSize: MainAxisSize.max,
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Text(
            //       'Payment Type : ',
            //       style: FlutterFlowTheme.bodyText1.override(
            //         fontFamily: 'Poppins',
            //       ),
            //     ),
            //     Text(
            //       orderDetailsOrdersRecord.shippingMethod,
            //       style: FlutterFlowTheme.bodyText1.override(
            //         fontFamily: 'Poppins',
            //       ),
            //     )
            //   ],
            // ),
            Container(
              padding: EdgeInsets.all(20.0),
              color: Colors.grey[300],
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      orderDetailsOrdersRecord.shippingAddress['name'],
                      style: FlutterFlowTheme.bodyText1.override(
                        fontFamily: 'Poppins',
                      ),
                    ),
                    Text(
                      orderDetailsOrdersRecord.shippingAddress['address'],
                      style: FlutterFlowTheme.bodyText1.override(
                        fontFamily: 'Poppins',
                      ),
                    ),
                    // Text(
                    //   orderDetailsOrdersRecord.shippingAddress['landMark'],
                    //   style: FlutterFlowTheme.bodyText1.override(
                    //     fontFamily: 'Poppins',
                    //   ),
                    // ),
                    Text(
                      '${orderDetailsOrdersRecord.shippingAddress['area']}',
                      style: FlutterFlowTheme.bodyText1.override(
                        fontFamily: 'Poppins',
                      ),
                    ),
                    // Text(
                    //   '${orderDetailsOrdersRecord.shippingAddress['city']},${orderDetailsOrdersRecord.shippingAddress['state']}',
                    //   style: FlutterFlowTheme.bodyText1.override(
                    //     fontFamily: 'Poppins',
                    //   ),
                    // ),
                    // Text(
                    //   orderDetailsOrdersRecord.shippingAddress['pinCode'],
                    //   style: FlutterFlowTheme.bodyText1.override(
                    //     fontFamily: 'Poppins',
                    //   ),
                    // ),
                    Text(
                      orderDetailsOrdersRecord.shippingAddress['mobileNumber'],
                      style: FlutterFlowTheme.bodyText1.override(
                        fontFamily: 'Poppins',
                      ),
                    )
                  ]),
            ),
            Expanded(
              child: Builder(
                builder: (context) {
                  final items = orderData;
                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.vertical,
                    itemCount: items.length,
                    // itemExtent:!listView?80:30 ,
                    itemBuilder: (context, itemsIndex) {

                      final itemsItem = items[itemsIndex];
                      return !listView
                          ? ListTile(
                              tileColor: itemsIndex % 2 == 0
                                  ? Colors.blue[200]
                                  : Colors.yellow[200],
                              leading: CircleAvatar(
                                radius: 50.0,
                                backgroundImage: NetworkImage(
                                  itemsItem['productImage'],
                                ),
                              ),
                              title: Text(
                                itemsItem['productName'],
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w600),
                              ),
                              subtitle: Text(
                                "\₹ ${double.parse('${itemsItem['price']}').toStringAsFixed(2)}",
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500),
                              ),
                              trailing: Column(children: [
                                Text(
                                  'x${itemsItem['quantity']}',
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w600),
                                ),
                                itemsItem['color'] == null
                                    ? SizedBox(
                                        height: 10,
                                      )
                                    : Text(
                                        itemsItem['color'],
                                        style: TextStyle(
                                            fontSize: 10.0,
                                            fontWeight: FontWeight.w600),
                                      ),
                                itemsItem['size'] == null
                                    ? SizedBox(
                                        height: 10,
                                      )
                                    : Text(
                                        itemsItem['size'],
                                        style: TextStyle(
                                            fontSize: 10.0,
                                            fontWeight: FontWeight.w600),
                                      ),
                              ]),
                            )
                          : ListTile(
                              tileColor: itemsIndex % 2 == 0
                                  ? Colors.blue[200]
                                  : Colors.yellow[200],
                              // minVerticalPadding: 0,
                              // isThreeLine: false,

                              title: Text(
                                itemsItem['productName'],
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w600),
                              ),
                              trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                        'x${itemsItem['quantity']}-${itemsItem['color'] == null ? "" : itemsItem['color']}-${itemsItem['size'] == null ? "" : itemsItem['size']}'),
                                    // Checkbox(
                                    //     value: itemReady$itemsIndex==null?false:itemReady$itemsIndex,
                                    //     onChanged: (value){
                                    //           print(value);
                                    //       setState(() {
                                    //         itemReady$itemsIndex=value;
                                    //       });
                                    //
                                    // })
                                  ]));
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
