//@dart=2.9
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:awafi_pos/Branches/branches.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:awafi_pos/flutter_flow/upload_media.dart';
import 'package:awafi_pos/salesPrint/new_sales_print.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as im;

import '../main.dart';
import '../product_card.dart';

class AcceptedOrdersWidget extends StatefulWidget {
  final String orderId;
  const AcceptedOrdersWidget({Key key, this.orderId}) : super(key: key);

  @override
  _AcceptedOrdersWidgetState createState() => _AcceptedOrdersWidgetState();
}

class _AcceptedOrdersWidgetState extends State<AcceptedOrdersWidget> {
  bool _loadingButton = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List billItem=[];
  List<int> bytes = [];
  qr(String vatTotal1, String grantTotal) {
    // seller name
    String sellerName = 'Boofiya Faraula';
    String vat_registration = '310963595400003';
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

  List<int> kotBytes = [];
  abc(int invNo,double discount,List items,int token,String tableName) async {
    print('start ************************************************************************************************'   );
    print(Timestamp.now().seconds);
    final CapabilityProfile profile = await CapabilityProfile.load();
    print(Timestamp.now().seconds);

    final generator = Generator(PaperSize.mm80, profile);
    bytes = [];

    kotBytes=[];


    final Uint8List imgBytes = data.buffer.asUint8List();
    final im.Image image = im.decodeImage(imgBytes);
    bytes += generator.image(image);

    var capturedImage1= await    screenshotController
        .captureFromWidget(Container(
      color: Colors.white,
      width: printWidth*3,
      child: ListView(
          shrinkWrap: true,
          children:[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(currentBranchArabic,style:  TextStyle(fontFamily:'GE Dinar One Medium',color: Colors.black,fontSize: fontSize+2,fontWeight: FontWeight.w600),),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('$currentBranchPhNo: Ph( رقم الهاتف )  ',style:  TextStyle(fontFamily:'GE Dinar One Medium',color: Colors.black,fontSize: fontSize,fontWeight: FontWeight.w600)),
                // Text('$currentBranchPhNo: Ph( رقمالهتف )  ',style:  TextStyle(fontFamily:'GE Dinar One Medium',color: Colors.black,fontSize: fontSize,fontWeight: FontWeight.w600)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:  [
                Text(' 310963595400003 :'+ 'Vat( رقم ضريبة )',style: TextStyle(fontFamily:'GE Dinar One Medium',color: Colors.black,fontSize: fontSize,fontWeight: FontWeight.w600),),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:  [
                Text('${DateTime.now().toString().substring(0, 19)}: Date( تاريخ )  ',style:  TextStyle(fontFamily:'GE Dinar One Medium',color: Colors.black,fontSize: fontSize,fontWeight: FontWeight.w600),),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:  [
                Text('$invNo: Invoice No( رقم الفاتورة )  '
                  ,style:  TextStyle(fontFamily:'GE Dinar One Medium',color: Colors.black,fontSize: fontSize,fontWeight: FontWeight.w600),),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:   [
                Text('Walking Customer( زبون سفري )',style: TextStyle(fontFamily:'GE Dinar One Medium',color: Colors.black,fontSize: fontSize,fontWeight: FontWeight.w600),),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:   [
                Text('$token: Token( رقم الطلب ) ',style:  TextStyle(fontFamily:'GE Dinar One Medium',color: Colors.black,fontSize: fontSize,fontWeight: FontWeight.w600),),
              ],
            ),
            tableName==null?Text('',style: TextStyle(
              fontSize: 1
            ),):
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:   [
                Text('TABLE : $tableName',
                  style:  TextStyle(color: Colors.black,fontSize: fontSize+13,fontWeight: FontWeight.w600),), ],
            ),
            Container( padding: const EdgeInsets.all(1.0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child:  Center(child: Text('...........................................',
                  style: TextStyle(color: Colors.black,fontSize: printWidth*.25),))),
          ]
      ),
    ));
    print('***************');
    print(printWidth);
    print('***************');

    //HEAD IMAGE
    // final im.Image image1 = im.decodeImage(capturedImage1);
    // bytes += generator.image(image1);
    // final Uint8List imgBytes1 = data1.buffer.asUint8List();
    // final im.Image image11 = im.decodeImage(imgBytes1);
    // bytes += generator.image(image11);

    var capturedhead= await    screenshotController
        .captureFromWidget(Container(
      color: Colors.white,
      width: printWidth*3,
      height: 50,
      padding: const EdgeInsets.only(top: 4),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:   [
          //pdt
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Product',
                  style:  TextStyle(
                      color: Colors.black,
                      fontFamily: 'GE Dinar One Medium',
                      fontSize: fontSize,
                      fontWeight: FontWeight.w600),
                ),
                Text('منتج',
                  style:  TextStyle(
                    fontFamily: 'GE Dinar One Medium',
                    fontSize: fontSize,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 45,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Qty',
                  style:  TextStyle(
                      fontFamily: 'GE Dinar One Medium',
                      color: Colors.black,
                      fontSize: fontSize,
                      fontWeight: FontWeight.w600),
                ),
                Text('كمية',
                  style:  TextStyle(
                      fontFamily: 'GE Dinar One Medium',
                      color: Colors.black,
                      fontSize: fontSize,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          Container(
            width: 45,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Rate',
                  style:  TextStyle(
                      fontFamily: 'GE Dinar One Medium',
                      color: Colors.black,
                      fontSize: fontSize,
                      fontWeight: FontWeight.w600),
                ),
                Text('سعر',
                  style:  TextStyle(
                      fontFamily: 'GE Dinar One Medium',
                      color: Colors.black,
                      fontSize: fontSize,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          Container(
            width: 45,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('vat',
                  style:  TextStyle(
                      fontFamily: 'GE Dinar One Medium',
                      color: Colors.black,
                      fontSize: fontSize,
                      fontWeight: FontWeight.w600),
                ),
                Text('ضريبة',
                  style:  TextStyle(
                      fontFamily: 'GE Dinar One Medium',
                      color: Colors.black,
                      fontSize: fontSize,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          Container(
            width: 45,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Total',
                  style:  TextStyle(
                      fontFamily: 'GE Dinar One Medium',
                      color: Colors.black,
                      fontSize: fontSize,
                      fontWeight: FontWeight.w600),
                ),
                Text('المجموع',
                  style:  TextStyle(
                      fontFamily: 'GE Dinar One Medium',
                      color: Colors.black,
                      fontSize: fontSize,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ],
      ),
    ));


    var capturedImage12= await    screenshotController
        .captureFromWidget(Container(
      color: Colors.white,
      width: printWidth*3,
      height: 15,
      child:Container(
          padding: const EdgeInsets.all(1.0),
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Center(child: Text('.........................................',
            style: TextStyle(color: Colors.black,fontSize: printWidth*.25),))
      ),
    )
    );

    final im.Image image13 = im.decodeImage(capturedImage12);
    bytes += generator.image(image13);

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
    String english = '';
    Map<String, dynamic> config = Map();
    List<Widget> itemWidgets=[];
    List<Widget> itemWidgets1=[];
    for (Map<String, dynamic> item in items) {

      double total = double.tryParse(item['price'].toString()) *
          double.tryParse(item['qty'].toString());
      double grossTotal = total * 100 / 115;
      double vat = total * 15 / 115;
      newAddOn = item['addOns'];
      arabic = item['arabicName'];
      english = item['pdtname'];


      grantTotal += total;

      deliveryCharge = item['deliveryCharge'] == null
          ? 0
          : double.tryParse(item['deliveryCharge'].toString());
      addON = newAddOn.isEmpty ? '' : newAddOn.toString();
      double price = double.tryParse(item['price'].toString()) * 100 / 115;
      totalAmount += price * double.tryParse(item['qty'].toString());

      itemWidgets1.add(
          Container(
              padding: const EdgeInsets.all(1.0),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              // child: ListView(
              //     shrinkWrap: true,
              //     children:[
              //       Row(
              //         children: [
              //           Column(
              //             children: [
              //               Text(english,
              //                 // textDirection: TextDirection.rtl,
              //                 style:  TextStyle(
              //                   fontFamily: 'Amiri',
              //                   fontSize: fontSize,
              //                   fontWeight: FontWeight.w600,
              //                   color: Colors.black,
              //                 ),
              //               ),Text(arabic,
              //                 // textDirection: TextDirection.rtl,
              //                 style:  TextStyle(
              //                   fontFamily: 'Amiri',
              //                   fontSize: 17,
              //                   fontWeight: FontWeight.w600,
              //                   color: Colors.black,
              //                 ),
              //               ),
              //             ],
              //           ),
              //           Text("${double.tryParse(item['qty'].toString())}  ${price.toStringAsFixed(2)}  ${vat.toStringAsFixed(2)}  ${total.toStringAsFixed(2)}",
              //             textDirection: TextDirection.ltr,
              //             style:  TextStyle(
              //               fontSize: fontSize,
              //               fontWeight: FontWeight.w600,
              //               color: Colors.black,
              //             ),
              //           )
              //         ],
              //       ),
              //       // Text("${item['pdtname']} $addON",
              //       //   textDirection: TextDirection.ltr,
              //       //   style: const TextStyle(
              //       //     fontSize: 14,
              //       //     color: Colors.black,
              //       //   ),
              //       // ),
              //
              //     ]
              // )));
              child: ListView(
                  shrinkWrap: true,
                  children:[
                    Container(
                      width: printWidth*3.2,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0,right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,

                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(english,
                                    // textDirection: TextDirection.rtl,
                                    style:  TextStyle(
                                      fontFamily: 'GE Dinar One Medium',
                                      fontSize: fontSize,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(arabic,
                                    // textDirection: TextDirection.rtl,
                                    style:  TextStyle(
                                      fontFamily: 'GE Dinar One Medium',
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width:20),
                            // Text("${double.tryParse(item['qty'].toString())}     ${price.toStringAsFixed(2)}     ${vat.toStringAsFixed(2)}      ${total.toStringAsFixed(2)}",
                            //   textDirection: TextDirection.ltr,
                            //   textAlign:TextAlign.end,
                            //   style:  TextStyle(
                            //     fontSize: fontSize,
                            //
                            //     fontWeight: FontWeight.w600,
                            //     color: Colors.black,
                            //   ),
                            // ),
                            // Text("${double.tryParse(item['qty'].toString())}     ${price.toStringAsFixed(2)}     ${vat.toStringAsFixed(2)}     ${total.toStringAsFixed(2)}",
                            //
                            Container(
                              width: 45,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text('${double.tryParse(item['qty'].toString())}',
                                    style:  TextStyle(
                                        fontFamily: 'GE Dinar One Medium',
                                        color: Colors.black,
                                        fontSize: fontSize,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 45,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text('${price.toStringAsFixed(2)} ',
                                    style:  TextStyle(
                                        fontFamily: 'GE Dinar One Medium',
                                        color: Colors.black,
                                        fontSize: fontSize,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 45,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text('${vat.toStringAsFixed(2)}',
                                    style:  TextStyle(
                                        fontFamily: 'GE Dinar One Medium',
                                        color: Colors.black,
                                        fontSize: fontSize,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 45,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text('${total.toStringAsFixed(2)}',
                                    style:  TextStyle(
                                        fontFamily: 'GE Dinar One Medium',
                                        color: Colors.black,
                                        fontSize: fontSize,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),


                          ],
                        ),
                      ),
                    ),
                    // Text("${item['pdtname']} $addON",
                    //   textDirection: TextDirection.ltr,
                    //   style: const TextStyle(
                    //     fontSize: 14,
                    //     color: Colors.black,
                    //   ),
                    // ),

                  ]
              )));
      print('mid ************************************************************************************************'   );
     if(itemWidgets1.length==itemCount){
        var capturedIm = await screenshotController
            .captureFromWidget(Container(
          width: printWidth*3,

          child: ListView.builder(
              shrinkWrap: true,
              itemCount: itemWidgets1.length,
              itemBuilder: (context, index) {
                return itemWidgets1[index];
              }),
        ));

        final im.Image image2 = im.decodeImage(capturedIm);
        bytes += generator.image(image2);
        itemWidgets1=[];
      }

      itemTotal += (totalAmount * ((100 + gst) / 100) -
          (double.tryParse(discount.toString()) ?? 0))
          .toStringAsFixed(2);
      itemGrossTotal += grossTotal.toStringAsFixed(2);
      itemTax += (totalAmount * gst / 100).toStringAsFixed(2);
    }
    if(itemWidgets1.length>0){
      var capturedIm = await screenshotController
          .captureFromWidget(Container(
        width: printWidth*3,

        child: ListView.builder(
            shrinkWrap: true,
            itemCount: itemWidgets1.length,
            itemBuilder: (context, index) {
              return itemWidgets1[index];
            }),
      ));

      final im.Image image2 = im.decodeImage(capturedIm);
      bytes += generator.image(image2);
      itemWidgets1=[];
    }
    List<Widget> itemWidgets2=[];
    itemWidgets.add( Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container( padding: const EdgeInsets.all(1.0),
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child:  Center(child: Text('...........................................',
              style: TextStyle(color: Colors.black,fontSize: printWidth*.25),))),
        Container(
          padding: const EdgeInsets.all(1.0),
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child:     Center(
            child: Text("  Total Amount( رقم الطلب ) : ${totalAmount.toStringAsFixed(2)}",
              style:  TextStyle(
                fontFamily:'GE Dinar One Medium',
                fontSize: fontSize,
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
            child: Text("Vat( رقم ضريبة ) : ${(totalAmount * gst / 100).toStringAsFixed(2)}",
              // textDirection: TextDirection.rtl,
              style:  TextStyle(
                fontFamily: 'GE Dinar One Medium',
                fontSize: fontSize,
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
            child: Text("Delivery Charge( رسوم التوصيل ) : $deliveryCharge",
              // textDirection: TextDirection.rtl,
              style:  TextStyle(
                fontFamily: 'GE Dinar One Medium',
                fontSize: fontSize,
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
            child: Text(" Discount( خصم ) : ${(discount==null?"0.00":discount.toStringAsFixed(2))}",
              // textDirection: TextDirection.rtl,
              style:  TextStyle(
                fontFamily: 'GE Dinar One Medium',
                fontSize: fontSize,
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
            child: Text("Grand Total( المجموع الإجمالي ) : ${grantTotal.toStringAsFixed(2)}",
              // textDirection: TextDirection.rtl,
              style:  TextStyle(
                fontFamily: 'GE Dinar One Medium',
                fontSize: 20,
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
      width: printWidth*2.4,

      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          QrImage(
            data: qr(qrVat, qrTotal),
            version: 6,
            size: size/1.5,
          ),
        ],
      ),
    ));

    itemWidgets.add(Container(
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children:  [
          Column(
            children: [
              Text('شكرًا لزيارتك ونتشوق لرؤيتك مرة أخرى',style: TextStyle(fontFamily:'GE Dinar One Medium',color: Colors.black,fontSize: 20,fontWeight: FontWeight.w600),),
              Text('THANK YOU VISIT AGAIN',style: TextStyle(fontFamily:'GE Dinar One Medium',color: Colors.black,fontSize: 20,fontWeight: FontWeight.w600),),
            ],
          ),
        ],
      ),
    ));

    var capturedImage2 = await screenshotController
        .captureFromWidget(Container(
      width: printWidth*3,

      child: ListView.builder(
          shrinkWrap: true,
          itemCount: itemWidgets.length,
          itemBuilder: (context, index) {
            return itemWidgets[index];
          }),
    ));

    final im.Image image2 = im.decodeImage(capturedImage2);
    bytes += generator.image(image2);
    bytes += generator.feed(2);
    print('end ************************************************************************************************'   );

    bytes += generator.cut();
    print('kot ************************************************************************************************'   );
    print(totalAmount);

    try {


      // await flutterUsbPrinter.connect(1155, 22339);
      // flutterUsbPrinter.write(Uint8List.fromList(bytes));//print num may be doubleprint
      flutterUsbPrinter.write(Uint8List.fromList(bytes));

      // kotBytes+=generator.text('Token No : '+token.toString(),styles: const PosStyles(align: PosAlign.center,));
      // kotBytes+=generator.text('Date : '+DateTime.now().toString().substring(0,16),styles: const PosStyles(align: PosAlign.center,));
      // kotBytes+=generator.text('Invoice No : '+invNo.toString(),styles: const PosStyles(align: PosAlign.center,));
      // // kotBytes+=generator.text('.............................................',styles: const PosStyles(align: PosAlign.center,));
      // // kotBytes+=generator.emptyLines(2);
      //
      // for (Map<String, dynamic> item in items) {
      //
      //   double total = double.tryParse(item['price'].toString()) *
      //       double.tryParse(item['qty'].toString());
      //
      //   double vat = total * 15 / 115;
      //   newAddOn = item['addOns'];
      //
      //   token = item['token'];
      //   String arabic1 = StringUtils.reverse(arabic);
      //
      //   addON = newAddOn.isEmpty ? '' : newAddOn.toString();
      //   double price =
      //       double.tryParse(item['price'].toString()) * 100 / 115;
      //
      //
      //   kotBytes+=generator.text("${int.tryParse(item['qty']
      //       .toString())} x ${item['pdtname']} $addON");
      //
      // }
      //
      // if(lastCut==true){
      //   kotBytes += generator.feed(2);
      //
      //   kotBytes += generator.cut();
      //   flutterUsbPrinter.write(Uint8List.fromList(kotBytes));//double print
      // }
      //


    }
    catch (error) {
      print(error.toString(),);
    }
    print("end");
    print(Timestamp.now().seconds);
  }

  // abc(int invNo,double discount,List items,int token) async {
  //   print('start');
  //   print(Timestamp.now().seconds);
  //   final CapabilityProfile profile = await   CapabilityProfile.load();
  //   print(Timestamp.now().seconds);
  //
  //   final generator = Generator(PaperSize.mm80, profile);
  //   bytes = [];
  //
  //
  //
  //   final Uint8List imgBytes = data.buffer.asUint8List();
  //   final im.Image image = im.decodeImage(imgBytes);
  //   bytes += generator.image(image);
  //
  //   var capturedImage1= await    screenshotController
  //       .captureFromWidget(Container(
  //     color: Colors.white,
  //     width: printWidth*3.8,
  //     child: ListView(
  //         shrinkWrap: true,
  //         children:[
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               Text(currentBranchArabic,style:  TextStyle(fontFamily:'GE Dinar One Medium',color: Colors.black,fontSize: printWidth*.20,fontWeight: FontWeight.w600),),
  //             ],
  //           ),
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               Text('$currentBranchPhNo: رقمالهتف  ',style:  TextStyle(fontFamily:'GE Dinar One Medium',color: Colors.black,fontSize: printWidth*.17,fontWeight: FontWeight.w600),),
  //             ],
  //           ),
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children:  [
  //               Text(' رقمالظريبة : 301139464800003',style: TextStyle(fontFamily:'GE Dinar One Medium',color: Colors.black,fontSize: printWidth*.17,fontWeight: FontWeight.w600),),
  //             ],
  //           ),
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children:  [
  //               Text('${DateTime.now().toString().substring(0, 19)}: تاريخ  ',style:  TextStyle(fontFamily:'GE Dinar One Medium',color: Colors.black,fontSize: printWidth*.17,fontWeight: FontWeight.w600),),
  //             ],
  //           ),
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children:  [
  //               Text('$invNo: رقم الفاتورة  ',style:  TextStyle(fontFamily:'GE Dinar One Medium',color: Colors.black,fontSize: printWidth*.17,fontWeight: FontWeight.w600),),
  //             ],
  //           ),
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children:   [
  //               Text('زبون : زبون مشي',style: TextStyle(fontFamily:'GE Dinar One Medium',color: Colors.black,fontSize: printWidth*.17,fontWeight: FontWeight.w600),),
  //             ],
  //           ),
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children:   [
  //               Text('$token: رقم رمزي   ',style:  TextStyle(fontFamily:'GE Dinar One Medium',color: Colors.black,fontSize: printWidth*.17,fontWeight: FontWeight.w600),),
  //             ],
  //           ),
  //           // Container( padding: const EdgeInsets.all(1.0),
  //           //     decoration: const BoxDecoration(
  //           //       color: Colors.white,
  //           //     ),
  //           //     child: const Center(child: Text('.............................................',
  //           //       style: TextStyle(color: Colors.black,fontSize: 25),))),
  //
  //         ]
  //     ),
  //   ));
  //
  //   final im.Image image1 = im.decodeImage(capturedImage1);
  //   bytes += generator.image(image1);
  //
  //
  //   final Uint8List imgBytes1 = data1.buffer.asUint8List();
  //   final im.Image image11 = im.decodeImage(imgBytes1);
  //   bytes += generator.image(image11);
  //   String itemString = '';
  //   String itemStringArabic = '';
  //   String itemTotal = '';
  //   String itemGrossTotal = '';
  //   String itemTax = '';
  //   String addON = '';
  //
  //   double deliveryCharge = 0;
  //   double grantTotal = 0;
  //   double totalAmount = 0;
  //   String arabic = '';
  //   Map<String, dynamic> config = Map();
  //   List<Widget> itemWidgets=[];
  //   for (Map<String, dynamic> item in items) {
  //
  //     double total = double.tryParse(item['price'].toString()) *
  //         double.tryParse(item['qty'].toString());
  //     double grossTotal = total * 100 / 115;
  //     double vat = total * 15 / 115;
  //     newAddOn = item['addOns'];
  //     arabic = item['arabicName'];
  //
  //
  //     grantTotal += total;
  //
  //     deliveryCharge = item['deliveryCharge'] == null
  //         ? 0
  //         : double.tryParse(item['deliveryCharge'].toString());
  //     addON = newAddOn.isEmpty ? '' : newAddOn.toString();
  //     double price = double.tryParse(item['price'].toString()) * 100 / 115;
  //     totalAmount += price * double.tryParse(item['qty'].toString());
  //
  //     itemWidgets.add(
  //         Container(
  //             padding: const EdgeInsets.all(1.0),
  //             decoration: const BoxDecoration(
  //               color: Colors.white,
  //             ),
  //             child: ListView(
  //                 shrinkWrap: true,
  //                 children:[
  //                   Text(arabic,
  //                     // textDirection: TextDirection.rtl,
  //                     style:  TextStyle(
  //                       fontFamily:'GE Dinar One Medium',
  //                       fontSize: printWidth*.15,
  //                       fontWeight: FontWeight.w600,
  //                       color: Colors.black,
  //                     ),
  //                   ),
  //                   // Text("${item['pdtname']} $addON",
  //                   //   textDirection: TextDirection.ltr,
  //                   //   style: const TextStyle(
  //                   //     fontSize: 14,
  //                   //     color: Colors.black,
  //                   //   ),
  //                   // ),
  //                   Row(
  //                     mainAxisAlignment: MainAxisAlignment.end,
  //                     children: [
  //                       Text("${double.tryParse(item['qty'].toString())}  ${price.toStringAsFixed(2)}  ${vat.toStringAsFixed(2)}  ${total.toStringAsFixed(2)}",
  //                         textDirection: TextDirection.ltr,
  //                         style:  TextStyle(
  //                           fontSize: printWidth*.15,
  //                           fontWeight: FontWeight.w600,
  //                           color: Colors.black,
  //                         ),
  //                       ),
  //                     ],
  //                   )
  //                 ]
  //             )));
  //
  //
  //     itemTotal += (totalAmount * ((100 + gst) / 100) -
  //         (double.tryParse(discount.toString()) ?? 0))
  //         .toStringAsFixed(2);
  //     itemGrossTotal += grossTotal.toStringAsFixed(2);
  //     itemTax += (totalAmount * gst / 100).toStringAsFixed(2);
  //   }
  //
  //   List<Widget> itemWidgets1=[];
  //   List<Widget> itemWidgets2=[];
  //   itemWidgets.add( Column(
  //     crossAxisAlignment: CrossAxisAlignment.center,
  //     children: [
  //       Container( padding: const EdgeInsets.all(1.0),
  //           decoration: const BoxDecoration(
  //             color: Colors.white,
  //           ),
  //           child:  Center(child: Text('..................................................',
  //             style: TextStyle(color: Colors.black,fontSize: printWidth*.25),))),
  //       Container(
  //         padding: const EdgeInsets.all(1.0),
  //         decoration: const BoxDecoration(
  //           color: Colors.white,
  //         ),
  //         child:     Center(
  //           child: Text("  الاجمامي : ${totalAmount.toStringAsFixed(2)}",
  //             // textDirection: TextDirection.rtl,
  //             style:  TextStyle(
  //               fontFamily:'GE Dinar One Medium',
  //               fontSize: printWidth*.16,
  //               fontWeight: FontWeight.w600,
  //               color: Colors.black,
  //             ),
  //           ),
  //         ),),
  //       Container(    padding: const EdgeInsets.all(1.0),
  //         decoration: const BoxDecoration(
  //           color: Colors.white,
  //         ),
  //         child:     Center(
  //           child: Text("  الضريبة : ${(totalAmount * gst / 100).toStringAsFixed(2)}",
  //             // textDirection: TextDirection.rtl,
  //             style:  TextStyle(
  //               fontFamily: 'GE Dinar One Medium',
  //               fontSize: printWidth*.16,
  //               fontWeight: FontWeight.w600,
  //               color: Colors.black,
  //             ),
  //           ),
  //         ),),
  //       Container(    padding: const EdgeInsets.all(1.0),
  //         decoration: const BoxDecoration(
  //           color: Colors.white,
  //         ),
  //         child:     Center(
  //           child: Text("  توصيل : $deliveryCharge",
  //             // textDirection: TextDirection.rtl,
  //             style:  TextStyle(
  //               fontFamily: 'GE Dinar One Medium',
  //               fontSize: printWidth*.16,
  //               fontWeight: FontWeight.w600,
  //               color: Colors.black,
  //             ),
  //           ),
  //         ),),
  //       Container( padding: const EdgeInsets.all(1.0),
  //           decoration: const BoxDecoration(
  //             color: Colors.white,
  //           ),
  //           child:  Center(child: Text('.............................................',
  //             style: TextStyle(color: Colors.black,fontSize: printWidth*.25),))),
  //       Container(    padding: const EdgeInsets.all(1.0),
  //         decoration: const BoxDecoration(
  //           color: Colors.white,
  //         ),
  //         child:     Center(
  //           child: Text("  خص : ${(discount==null?"0.00":discount.toStringAsFixed(2))}",
  //             // textDirection: TextDirection.rtl,
  //             style:  TextStyle(
  //               fontFamily: 'GE Dinar One Medium',
  //               fontSize: printWidth*.16,
  //               fontWeight: FontWeight.w600,
  //               color: Colors.black,
  //             ),
  //           ),
  //         ),),
  //       Container(    padding: const EdgeInsets.all(1.0),
  //         decoration: const BoxDecoration(
  //           color: Colors.white,
  //         ),
  //         child:     Center(
  //           child: Text("  المجموع الإجمالي : ${grantTotal.toStringAsFixed(2)}",
  //             // textDirection: TextDirection.rtl,
  //             style:  TextStyle(
  //               fontFamily: 'GE Dinar One Medium',
  //               fontSize: printWidth*.16,
  //               fontWeight: FontWeight.w600,
  //               color: Colors.black,
  //             ),
  //           ),
  //         ),),
  //     ],
  //   ));
  //
  //   String qrVat = (totalAmount * gst / 100).toStringAsFixed(2);
  //   String qrTotal = grantTotal.toStringAsFixed(2);
  //   // bluetooth.printQRcode(qr(qrVat, qrTotal), 200, 200, 1);
  //   itemWidgets.add(Container(
  //     color: Colors.white,
  //     width: qrCode,
  //
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         QrImage(
  //           data: qr(qrVat, qrTotal),
  //           version: 6,
  //           size: size,
  //         ),
  //       ],
  //     ),
  //   ));
  //
  //   itemWidgets.add(Container(
  //     color: Colors.white,
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children:  [
  //         Text('شكرا لك الزيارة مرة أخرى',style: TextStyle(fontFamily:'GE Dinar One Medium',color: Colors.black,fontSize: printWidth*.16,fontWeight: FontWeight.w600),),
  //       ],
  //     ),
  //   ));
  //
  //   var capturedImage2 = await screenshotController
  //       .captureFromWidget(Container(
  //     width: printWidth*3.6,
  //
  //     child: ListView.builder(
  //         shrinkWrap: true,
  //         itemCount: itemWidgets.length,
  //         itemBuilder: (context, index) {
  //           return itemWidgets[index];
  //         }),
  //   ));
  //
  //   final im.Image image2 = im.decodeImage(capturedImage2);
  //   bytes += generator.image(image2);
  //
  //   try {
  //
  //     bytes += generator.feed(2);
  //
  //     bytes += generator.cut();
  //     // await flutterUsbPrinter.connect(1155, 22339);
  //     flutterUsbPrinter.write(Uint8List.fromList(bytes));
  //
  //   }
  //   catch (error) {
  //     print(error.toString(),);
  //   }
  //   print("end");
  //   print(Timestamp.now().seconds);
  // }
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
          int invoiceNo=data[0]['invoiceNo'];
          int token=data[0]['token'];
          print(invoiceNo.toString());
          print(token.toString());
          List addOn=[];
          billItem=[];

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
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          FFButtonWidget(
                            onPressed: () async {
                              setState(() => _loadingButton = true);
                              try {
                                // await showDialog(
                                //     barrierDismissible: false,
                                //     context: context,
                                //     builder:
                                //         (BuildContext context) {
                                      items = billItem;
                                      blue?
                                      showDialog(
                                          barrierDismissible: false,
                                          context: context,
                                          builder:
                                              (BuildContext context) {
                                            items = billItem;
                                            return  mytest(
                                              items: billItem,
                                              token:token,
                                              customer: data[0]['name'],
                                              discountPrice:0,
                                              invoiceNo: invoiceNo.toString(),
                                              selectedTable: data[0]['table'],
                                            );

                                          }):

                                      abc(invoiceNo, 0, billItem, token,data[0]['table']);
                                // Navigator.pop(context);
                                showUploadMessage(context, 'Print Successfully..');


                              } finally {
                                setState(() => _loadingButton = false);
                              }
                            },
                            text: 'Print',
                            options: FFButtonOptions(
                              width:140,
                              height: 45,
                              color: Colors.blue,
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
                          FFButtonWidget(
                            onPressed: () async {
                              setState(() => _loadingButton = true);
                              try {
                                DocumentSnapshot order=data[0];
                                order.reference.update({
                                  'status':6,
                                  'pickedUpTime':DateTime.now(),
                                  // 'status':2,
                                  // 'DeliveredTime':DateTime.now(),
                                });
                                Navigator.pop(context);
                                showUploadMessage(context, ' Order Picked');


                              } finally {
                                setState(() => _loadingButton = false);
                              }
                            },
                            text: 'Mark As Picked',
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
