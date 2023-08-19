//@dart=2.9
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:arabic_numbers/arabic_numbers.dart';
import 'package:awafi_pos/flutter_flow/flutter_flow_theme.dart';
import 'package:awafi_pos/flutter_flow/upload_media.dart';
import 'package:awafi_pos/view_invoice/return_Sales_Print.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import '../Branches/branches.dart';
import '../main.dart';
import 'package:image/image.dart' as im;

import '../product_card.dart';

List<Map<String, dynamic>> returnItems = [];

class ViewInvoice extends StatefulWidget {
  final int invoiceNo;
  const ViewInvoice({
    Key key,
    this.invoiceNo,
  }) : super(key: key);

  @override
  _ViewInvoiceState createState() => _ViewInvoiceState();
}

class _ViewInvoiceState extends State<ViewInvoice> {
  QuerySnapshot invoices;
  DocumentSnapshot invoice;
  int token=0;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    returnItems = [];
    super.initState();
    getInvoiceByNo();
    // setPrinterImages();
  }

  List<int> bytes = [];
  qr(String vatTotal1, String grantTotal,DateTime salesDate) {
    // seller name
    String sellerName = 'Boofiya Faraula';
    String vat_registration = vatNumber;
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
    List<int> date = utf8.encode(salesDate.toString());
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

  ArabicNumbers arabicNumber = ArabicNumbers();
  ScreenshotController screenshotController = ScreenshotController();

  bool working=false;

  efg(int invNo,double discount,int rInvNo,List rItems,List items,int token,deliveryCharge,DateTime saleDate,double pc,double pb,double bal) async {

    final CapabilityProfile profile = await CapabilityProfile.load();


    final generator = Generator(PaperSize.mm80, profile);
    bytes = [];

    // kotBytes=[];
    bytes = [];


    final Uint8List imgBytes = data.buffer.asUint8List();
    final im.Image image = im.decodeImage(imgBytes);
    bytes += generator.image(image);
    bytes += generator.feed(2);

    final im.Image image1 = im.decodeImage(capturedImage1);
    bytes += generator.image(image1);
    capturedImage10= await    screenshotController
        .captureFromWidget(Container(
      color: Colors.white,
      width: printWidth*3,
      child: ListView(

          shrinkWrap: true,
          // physics: NeverScrollableScrollPhysics(),
          children:[



            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Date :', style: TextStyle(color: Colors.black, fontSize: fontSize + 2, fontWeight: FontWeight.w600),),
                Text('${DateTime.now().toString().substring(0, 19)}', style: TextStyle(color: Colors.black, fontSize: fontSize, fontWeight: FontWeight.w600),),

              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:  [
                Text('Invoice No:',style: TextStyle(color: Colors.black,fontSize: fontSize+2,fontWeight: FontWeight.w600),),
                Text('$invNo',style: TextStyle(color: Colors.black,fontSize: fontSize,fontWeight: FontWeight.w600),),
              ],),


          ]
      ),
    )
    );
    final im.Image image10 = im.decodeImage(capturedImage10);
    bytes += generator.image(image10);

    bytes +=generator.text("-------------------------------------------",styles: PosStyles(bold: true,align: PosAlign.center,height: PosTextSize.size2,));

    bytes +=generator.text("TOKEN NUMBER : $token",styles: PosStyles(bold: true,align: PosAlign.center,height: PosTextSize.size2,width: PosTextSize.size2));

    bytes +=generator.text("-------------------------------------------",styles: PosStyles(bold: true,align: PosAlign.center,height: PosTextSize.size2,));

    //HAEAD IMAGE
    // final Uint8List imgBytes1 = data1.buffer.asUint8List();
    // final im.Image image11 = im.decodeImage(imgBytes1);
    // bytes += generator.image(image11);

    final im.Image imagehead = im.decodeImage(capturedhead);
    bytes += generator.image(imagehead,);
    print('capturedhead');
    print(capturedhead);
    // print(imagehead);

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
          child: Center(child: Text('........................................',
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
    double grantTotal = 0;
    double totalAmount = 0;
    String arabic = '';
    String english = '';
    String addOnArabic = '';
    addOnArabic = newAddOnArabic.isEmpty ? '' : newAddOnArabic.toString();


    Map<String, dynamic> config = Map();
    List<Widget> itemWidgets=[];
    List<Widget> itemWidgets1=[];
    for (Map<String, dynamic> item in items) {
      addOnPrice=item['addOnPrice'];
      double total = (double.tryParse(item['price'].toString())+addOnPrice) *
          double.tryParse(item['qty'].toString());
      double grossTotal = total * 100 / 115;
      double vat = (double.tryParse(item['price'].toString())+addOnPrice) * 15 / 115;
      newAddOn = item['addOns'];
      arabic = item['arabicName'];
      english = item['pdtname'];


      grantTotal += total;

      deliveryCharge = item['deliveryCharge'] == null
          ? 0
          : double.tryParse(item['deliveryCharge'].toString());
      addON = newAddOn.isEmpty ? '' : newAddOn.toString();
      double price = (double.tryParse(item['price'].toString())+addOnPrice)* 100 / 115;
      totalAmount += price * double.tryParse(item['qty'].toString());
      itemWidgets1.add(
          Container(
              width: printWidth*3.4,
              padding: const EdgeInsets.all(1.0),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: ListView(
                  shrinkWrap: true,
                  children:[
                    Container(
                      width: printWidth*3.2,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('$arabic $addOnArabic',
                                      // textDirection: TextDirection.rtl,
                                      style:  TextStyle(
                                        fontFamily: 'GE Dinar One Medium',
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text('$english $addON',
                                      // textDirection: TextDirection.rtl,
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
                                    // Text('${arabicNumber.convert(double.tryParse(item['qty'].toString()).toStringAsFixed(2))}',
                                    //   style:  TextStyle(
                                    //       fontFamily: 'GE Dinar One Medium',
                                    //       color: Colors.black,
                                    //       fontSize: fontSize+2,
                                    //       fontWeight: FontWeight.w600),
                                    // ),
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
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Text('${arabicNumber.convert(price.toStringAsFixed(2))} ',
                                    //   style:  TextStyle(
                                    //       fontFamily: 'GE Dinar One Medium',
                                    //       color: Colors.black,
                                    //       fontSize: fontSize+2,
                                    //       fontWeight: FontWeight.w600),
                                    // ),
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
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Text('${arabicNumber.convert(vat.toStringAsFixed(2))}',
                                    //   style:  TextStyle(
                                    //       fontFamily: 'GE Dinar One Medium',
                                    //       color: Colors.black,
                                    //       fontSize: fontSize+2,
                                    //       fontWeight: FontWeight.w600),
                                    // ),
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
                                width: 50,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Text('${arabicNumber.convert(total.toStringAsFixed(2))}',
                                    //   style:  TextStyle(
                                    //       fontFamily: 'GE Dinar One Medium',
                                    //       color: Colors.black,
                                    //       fontSize: fontSize+2,
                                    //       fontWeight: FontWeight.w600),
                                    // ),
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
                          SizedBox(height: 10,)
                        ],
                      ),
                    ),


                  ]
              )
          )
      );



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



      print('mid ********************************'   );

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

      final im.Image image20 = im.decodeImage(capturedIm);
      bytes += generator.image(image20);
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
            child:  Center(child: Text('=====================',
              style: TextStyle(color: Colors.black,fontSize: printWidth*.25),))),
        Container(
          padding: const EdgeInsets.all(1.0),
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child:     Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total - الإجمالي     :  ',style:  TextStyle(color: Colors.black,fontSize: fontSize+4,fontWeight: FontWeight.w600),),
              Text(totalAmount.toStringAsFixed(2),style:  TextStyle(color: Colors.black,fontSize: fontSize+4,fontWeight: FontWeight.w600),),
            ],
          ),),
        Container(padding: const EdgeInsets.all(1.0),
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child:      Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('VAT -  رقم ضريبة  :   ',style:  TextStyle(color: Colors.black,fontSize: fontSize+4,fontWeight: FontWeight.w600),),
              Text('${(totalAmount * gst / 100).toStringAsFixed(2)}',style:  TextStyle(color: Colors.black,fontSize: fontSize+4,fontWeight: FontWeight.w600),),
            ],
          ),),
        Container(    padding: const EdgeInsets.all(1.0),
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child:     Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Delivery Charge - رسوم التوصيل : ',style:  TextStyle(color: Colors.black,fontSize: fontSize+4,fontWeight: FontWeight.w600),),
              Text('${double.tryParse(delivery).toStringAsFixed(2)}',style:  TextStyle(color: Colors.black,fontSize: fontSize+4,fontWeight: FontWeight.w600),),
            ],
          ),),
        Container(
          padding: const EdgeInsets.all(1.0),
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Discount -  خصم  : ', style: TextStyle(color: Colors.black, fontSize: fontSize+4, fontWeight: FontWeight.w600),),
              Text((discount == null ? "0.00" : discount.toStringAsFixed(2)), style: TextStyle(color: Colors.black, fontSize: fontSize+4, fontWeight: FontWeight.w600),),

            ],
          ),),
        Container( padding: const EdgeInsets.all(1.0),
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child:  Center(child: Text('-------------------------------------------',
              style: TextStyle(color: Colors.black,fontSize: printWidth*.25),))),
        Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child:     Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Text('NET - المجموع الإجمالي  : ',style:  TextStyle(color: Colors.black,fontSize: fontSize+7,fontWeight: FontWeight.w700),),
              Text((grantTotal-discount+double.tryParse(delivery)).toStringAsFixed(2) ,style:  TextStyle(color: Colors.black,fontSize: fontSize+7,fontWeight: FontWeight.w700),),
            ],
          ),
        ),
        Container(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child:  Center(child: Text('-------------------------------------------',
              style: TextStyle(color: Colors.black,fontSize: printWidth*.25),))
        ),
        Container(    padding: const EdgeInsets.all(1.0),
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child:     Center(
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:   [
                // Text('نقدأ  :  ${arabicNumber.convert(pc.toStringAsFixed(2))}',style:  TextStyle(color: Colors.black,fontSize: fontSize,fontWeight: FontWeight.w600),),
                Text('Cash  :  ${pc}',style:  TextStyle(color: Colors.black,fontSize: fontSize+2,fontWeight: FontWeight.w600),),
                // Text('مصرف  :  ${arabicNumber.convert(pb.toStringAsFixed(2))}',style:  TextStyle(color: Colors.black,fontSize: fontSize,fontWeight: FontWeight.w600),),
                Text('Bank  :  ${pb}',style:  TextStyle(color: Colors.black,fontSize: fontSize+2,fontWeight: FontWeight.w600),),
                // Text('المتبقي :  ${arabicNumber.convert(bal.toStringAsFixed(2))}',style:  TextStyle(color: Colors.black,fontSize: fontSize,fontWeight: FontWeight.w600),),
                Text('Change :  ${bal}',style:  TextStyle(color: Colors.black,fontSize: fontSize+2,fontWeight: FontWeight.w600),),

              ],
            ),

          ),
        ),
        Container(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child:  Center(child: Text('-------------------------------------------',
              style: TextStyle(color: Colors.black,fontSize: printWidth*.25),))
        ),

      ],
    ));

    deliveryCharge=double.tryParse(delivery);
    String qrVat = (totalAmount * gst / 100).toStringAsFixed(2);
    String qrTotal = (grantTotal-discount+deliveryCharge).toStringAsFixed(2);

    // bluetooth.printQRcode(qr(qrVat, qrTotal), 200, 200, 1);
    itemWidgets.add(Container(
      color: Colors.white,
      width: printWidth*2.4,

      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          QrImage(
            data: qr(qrVat, qrTotal,saleDate),
            version: 6,
            size: size/1.5,
          ),
        ],
      ),
    ));
    // itemWidgets.add(     Container(
    //     padding: const EdgeInsets.all(1.0),
    //     decoration: const BoxDecoration(
    //       color: Colors.white,
    //     ),
    //     child:  Center(child: Text('..................................................',
    //       style: TextStyle(color: Colors.black,fontSize: printWidth*.25),))),);
    itemWidgets.add(     Container(
        padding: const EdgeInsets.all(1.0),
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child:  Center(child: Text('العناصر المرتجعة',
          style: TextStyle(color: Colors.black,fontSize: fontSize),))),);

    itemWidgets.add(     Container(
        padding: const EdgeInsets.all(1.0),
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child:  Center(child: Text('-------------------------------------------',
          style: TextStyle(color: Colors.black,fontSize: printWidth*.25),))),);
    itemWidgets.add(     Container(
        padding: const EdgeInsets.all(1.0),
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child:  Center(child: Text('RETURN ITEMS',
          style: TextStyle(color: Colors.black,fontSize: fontSize+5),))),);
    itemWidgets.add(     Container(
        padding: const EdgeInsets.all(1.0),
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child:  Center(child: Text('-------------------------------------------',
          style: TextStyle(color: Colors.black,fontSize: printWidth*.25),))),);
    for (Map<String, dynamic> item in rItems) {
      addOnPrice = item[addOnPrice];
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
      newAddOn = item['addOns'];
      newAddOnArabic = item['addOnArabic'];
      addOnArabic = newAddOnArabic.isEmpty ? '' : newAddOnArabic.toString();
      addON = newAddOn.isEmpty ? '' : newAddOn.toString();
      double price = double.tryParse(item['price'].toString()) * 100 / 115;
      totalAmount += price * double.tryParse(item['qty'].toString());

      itemWidgets.add(
          Container(

              width: printWidth * 3,
              padding: const EdgeInsets.all(1.0),
              decoration: const BoxDecoration(
                border: Border(),
                color: Colors.white,
              ),

              child: ListView(
                  shrinkWrap: true,
                  children: [
                    Container(
                      width: printWidth * 3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('$arabic $addOnArabic',
                                  // textDirection: TextDirection.rtl,
                                  style: const TextStyle(
                                    fontFamily: 'GE Dinar One Medium',
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                                Text('$english $addON',
                                  // textDirection: TextDirection.rtl,
                                  style: TextStyle(
                                    fontFamily: 'GE Dinar One Medium',
                                    fontSize: fontSize,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),

                              ],
                            ),
                          ),

                          // const SizedBox(width:5),

                          Container(
                            width: 45,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Text('${arabicNumber.convert(double.tryParse(
                                //     item['qty'].toString()).toStringAsFixed(
                                //     2))}',
                                //   style: TextStyle(
                                //       fontFamily: 'GE Dinar One Medium',
                                //       color: Colors.black,
                                //       fontSize: fontSize + 2,
                                //       fontWeight: FontWeight.w600),
                                // ),
                                Text('${double.tryParse(item['qty']
                                    .toString())}',
                                  style: TextStyle(
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
                                // Text('${arabicNumber.convert(price
                                //     .toStringAsFixed(2))} ',
                                //   style: TextStyle(
                                //       fontFamily: 'GE Dinar One Medium',
                                //       color: Colors.black,
                                //       fontSize: fontSize + 2,
                                //       fontWeight: FontWeight.w600),
                                // ),
                                Text('${price.toStringAsFixed(2)} ',
                                  style: TextStyle(
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
                                // Text('${arabicNumber.convert(vat
                                //     .toStringAsFixed(2))}',
                                //   style: TextStyle(
                                //       fontFamily: 'GE Dinar One Medium',
                                //       color: Colors.black,
                                //       fontSize: fontSize + 2,
                                //       fontWeight: FontWeight.w600),
                                // ),
                                Text('${vat.toStringAsFixed(2)}',
                                  style: TextStyle(
                                      fontFamily: 'GE Dinar One Medium',
                                      color: Colors.black,
                                      fontSize: fontSize,
                                      fontWeight: FontWeight.w600),
                                ),

                              ],
                            ),
                          ),
                          Container(
                            width: 50,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Text('${arabicNumber.convert(total
                                //     .toStringAsFixed(2))}',
                                //   style: TextStyle(
                                //       fontFamily: 'GE Dinar One Medium',
                                //       color: Colors.black,
                                //       fontSize: fontSize + 2,
                                //       fontWeight: FontWeight.w600),
                                // ),
                                Text('${total.toStringAsFixed(2)}',
                                  style: TextStyle(
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
                    // Text("${item['pdtname']} $addON",
                    //   textDirection: TextDirection.ltr,
                    //   style: const TextStyle(
                    //     fontSize: 14,
                    //     color: Colors.black,
                    //   ),
                    // ),

                  ]
              )));


      itemTotal += (totalAmount * ((100 + gst) / 100) -
          (double.tryParse(discount.toString()) ?? 0))
          .toStringAsFixed(2);
      itemGrossTotal += grossTotal.toStringAsFixed(2);
      itemTax += (totalAmount * gst / 100).toStringAsFixed(2);
    }

    itemWidgets.add(Container(
        padding: const EdgeInsets.all(1.0),
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Center(
            child: Text('-------------------------------------------',
              style: TextStyle(
                  color: Colors.black, fontSize: printWidth * .25),))),);


    var capturedImage2 = await screenshotController
        .captureFromWidget(Container(
      width: printWidth * 3,



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



    final im.Image image50 = im.decodeImage(footerImage);
    bytes += generator.image(image50);
    bytes += generator.feed(2);
    try {
      // bytes += generator.feed(5);
      bytes += generator.drawer(pin: PosDrawer.pin2);
      bytes += generator.cut();
      // await flutterUsbPrinter.connect(1155, 22339);
      flutterUsbPrinter.write(Uint8List.fromList(bytes));
    }
    catch (error) {
      print(error.toString(),);
    }
    print("end");
    print(Timestamp
        .now()
        .seconds);

  }




  setSearchParam(String caseNumber) {
    List<String> caseSearchList = [];
    String temp = "";

    List<String> nameSplits = caseNumber.split(" ");
    for (int i = 0; i < nameSplits.length; i++) {
      String name = "";

      for (int k = i; k < nameSplits.length; k++) {
        name = name + nameSplits[k] + " ";
      }
      temp = "";

      for (int j = 0; j < name.length; j++) {
        temp = temp + name[j];
        caseSearchList.add(temp.toUpperCase());
      }
    }
    return caseSearchList;
  }
  getInvoiceByNo() async {
    invoices = await FirebaseFirestore.instance
        .collection('sales')
        .doc(currentBranchId)
        .collection('sales')
        .where('invoiceNo', isEqualTo: widget.invoiceNo)
        .get();
    if (invoices.docs.isNotEmpty) {
      invoice = invoices.docs[0];
      token=invoice.get('token');
      selectedTable=invoice.get('table');
      discount=invoice.get('discount').toString();
      delivery=invoice.get('deliveryCharge').toString();
      totalAmount=invoice.get('grandTotal');
      tableName=invoice.get('table');
// print(delivery+'           mmmmmmmmmmmmmmm');
    }
    setState(() {});
  }
  double returnTotal=0;
  calculate(){
    returnTotal=0;
    for (dynamic item
    in returnItems) {
      print(item['qty']);
      returnTotal += (double.tryParse(item['price'].toString()) + double.tryParse(item['addOnPrice'].toString())) * item['qty'];
    }
    List items=returnItems;
    for (int i=0;i<items.length;i++) {
      if(returnItems[i]['qty']==0){
        returnItems.removeAt(i);
      }
    }
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: primaryColor,
        automaticallyImplyLeading: true,
        title: Text(
          'View Invoice',
          style: FlutterFlowTheme.title1
              .override(fontFamily: 'Poppins', color: Colors.white),
        ),
        actions: [],
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 800,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF2b0e10),
                          border: Border.all(color: Color(0xFF2b0e10))),
                      child: Center(
                        child: Text(
                          invoice==null?'':invoice.id,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(width: 20,),
                    ElevatedButton(
                        onPressed: () async {

                          print(delivery+'hhhhhhhhhhhhhhhhhhhhhhhhhhhhh');

                          if(returnItems.isNotEmpty){
                            DocumentSnapshot
                            invoiceNoDoc =
                            await FirebaseFirestore
                                .instance
                                .collection(
                                'invoiceNo')
                                .doc(
                                currentBranchId)
                                .get();
                            FirebaseFirestore.instance
                                .collection(
                                'invoiceNo')
                                .doc(currentBranchId)
                                .update({
                              'return': FieldValue
                                  .increment(1),

                            });
                            int returns =
                            invoiceNoDoc
                                .get('return');

                            returns++;

                            FirebaseFirestore
                                .instance
                                .collection('salesReturn')
                                .doc(currentBranchId)
                                .collection('salesReturn')
                                .doc(returns
                                .toString())
                                .set({
                              'salesReturnDate':
                              DateTime.now(),
                              'invoiceNo': returns,
                              'salesInvoiceNo': invoice.id,
                              'cash': cash,
                              'token': token,
                              'currentBranchId':currentBranchId,
                              'search':setSearchParam(returns.toString()),
                              'currentBranchPhNo':
                              currentBranchPhNo,
                              'currentBranchAddress':
                              currentBranchAddress,
                              'currentBranchArabic':
                              currentBranchArabic,
                              'deliveryCharge': double.tryParse(delivery) ?? 0,
                              'table': selectedTable,
                              'billItems': returnItems,
                              'discount':0,
                              'totalAmount': returnTotal * 100 / (100 + gst),
                              'tax': returnTotal * gst / (100 + gst),
                              'grandTotal': returnTotal,
                              'currentUserId':currentUserId
                            });
                            blue?  await showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (BuildContext context) {
                                  items = invoice.get('billItems');

                                  return return_salesPrint(
                                    salesDate: invoice.get('salesDate').toDate(),
                                    tableName:invoice.get('table'),
                                    items:items,
                                    grandTotal:invoice.get('grandTotal'),
                                    vatTotal:invoice.get('tax'),
                                    total:invoice.get('totalAmount'),
                                    returnItems: returnItems,
                                    token: token,
                                    delivery:   double.tryParse(delivery) ?? 0,
                                    customer: 'Walking Customer',
                                    discountPrice:  double.tryParse(discount.toString()) ?? 0,
                                    invoiceNo: invoice.id.toString(),

                                      cashPaid:double.tryParse(invoice.get('paidCash').toString())??0,
                                      bankPaid:double.tryParse(invoice.get('paidBank').toString())??0,
                                      balance:double.tryParse(invoice.get('balance').toString())??0,
                                  );
                                }):
                           await efg(int.tryParse(invoice.id.toString()), double.tryParse(invoice.get('discount').toString())
                               ,returns,returnItems, invoice.get('billItems'), token,double.tryParse(delivery) ?? 0,
                               invoice.get('salesDate').toDate(),double.tryParse(invoice.get('paidCash').toString())??0,
                             double.tryParse(invoice.get('paidBank').toString())??0,
                             double.tryParse(invoice.get('balance').toString())??0,);


                            // Navigator.pop(context);
                            showUploadMessage(context, 'Return Successfully...');

                          }else{
                            showUploadMessage(context, 'Please Choose Products');
                          }
                        },
                        child: const Text('Return')),
                    const SizedBox(width: 20,),
                    ElevatedButton(onPressed: () {}, child: const Text('Cancel')),
                  ]),
                  Container(
                    height: 40,
                    color: Colors.grey.shade200,
                    child: Row(
                      children: const [
                        Expanded(
                          flex: 1,
                          child: Center(
                              child: Text(
                                "NO:",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                        ),
                        Expanded(
                          flex: 6,
                          child: Center(
                              child: Text(
                                "NAME",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                        ),
                        Expanded(
                          flex: 3,
                          child: Center(
                              child: Text(
                                "PRICE",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                        ),
                        Expanded(
                          flex: 2,
                          child: Center(
                              child: Text(
                                "QTY",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                        ),
                        Expanded(
                          flex: 3,
                          child: Center(
                              child: Text(
                                "Return qty",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                        ),
                        Expanded(
                          flex: 1,
                          child: Center(
                              child: Text(
                                "",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: MediaQuery.of(context).size.height * .4,

                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: invoice==null?0:invoice.get('billItems').length ,
                          itemBuilder: (context, index) {
                            var items = invoice.get('billItems');
                            String item = items[index]['pdtname'];
                            double addOnPrice = items[index]['addOnPrice'];
                            List addOns = items[index]['addOns'];

                            return itemRow(
                              item: items[index],
                              index: index,

                              calculate: calculate,
                            );
                          }),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    color: Colors.blueGrey.shade100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "Total Amount",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.grey.shade700),
                            ),
                            Text(
                              "Discount",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.grey.shade700),
                            ),
                            Text(
                              "Tax ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.grey.shade700),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Grand Total",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.grey.shade700),
                            ),
                            Text(
                              "Return Amount",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.grey.shade700),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "SAR ${invoice==null?0:invoice.get('totalAmount').toStringAsFixed(2)}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.grey.shade700),
                            ),
                            Text(
                              invoice ==
                                  null
                                  ? "0.00"
                                  : "SAR ${double.tryParse(invoice.get('discount').toString()).toStringAsFixed(2)}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.grey.shade700),
                            ),
                            Text(
                              " SAR ${(invoice==null?0:invoice.get('tax')).toStringAsFixed(2)}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.grey.shade700),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "SAR ${(invoice==null?0:invoice.get('grandTotal')).toStringAsFixed(2)}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.grey.shade700),
                            ),
                            Text(
                              "SAR ${returnTotal.toStringAsFixed(2)}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.grey.shade700),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}

class itemRow extends StatefulWidget {
  final Map<String, dynamic> item;
  final int index;
  final Function calculate;
  const itemRow({Key key, this.item, this.index, this.calculate}) : super(key: key);

  @override
  _itemRowState createState() => _itemRowState();
}

class _itemRowState extends State<itemRow> {
  int index;
  String item;
  String price;
  String qty;
  TextEditingController _controller;
  double progress = 0;
  // double addOnPrice = 0;
  bool checked = false;
  @override
  void initState() {
    // print('   widget.item      ===========$widget.item');
    // print(itemRow);

    index = widget.index;
    item = widget.item['pdtname'];
    price = (widget.item['price']+widget.item['addOnPrice']).toString();
    qty = widget.item['qty'].toString();
    _controller = TextEditingController(text: widget.item['qty'].toString());


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Center(
                  child: Text(
                    (index + 1).toString(),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  )),
            ),
            Expanded(
              flex: 6,
              child: Center(
                  child: Text(
                    item,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  )),
            ),
            Expanded(
              flex: 3,
              child: Center(
                  child: Text(
                    price,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  )),
            ),
            Expanded(
              flex: 2,
              child: Center(
                  child: Text(
                    qty,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  )),
            ),
            Expanded(
                flex: 3,
                child: Container(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [

                      Container(
                        // child: Text(
                        //   progrss.toString(),
                        // ),

                        width: 50,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          onFieldSubmitted: (value) {
                            int i=0;
                            for(int k=0;k<items.length;k++){
                              if(items[k]['pdtname']==item&&items[k]['price']==price){
                                i=k;
                                break;
                              }
                            }
                            // items.insert(i, {
                            //   'pdtname': widget.name,
                            //   'arabicName': widget.arabicName,
                            //   'price': widget.price,
                            //   'qty': double.tryParse(value.toString()),
                            //   'addOns': widget.addOns,
                            //   'addOnArabic': widget.addOnsArabic,
                            //   'addOnPrice': widget.addOnPrice
                            // });
                            // FirebaseFirestore.instance
                            //     .collection('tables')
                            //     .doc(selectedTable)
                            //     .update({
                            //   'items': items
                            // });
                            //
                            //
                            setState(() {
                              progress = double.tryParse(value.toString());
                              print(progress);

                            });
                          },
                          controller: _controller,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder()),
                        ),
                      ),

                    ],
                  ),
                )),
            Expanded(
              flex: 1,
              child: Center(
                  child: Checkbox(
                      value: checked,
                      onChanged: (value) {
                        checked = value;
                        Map<String,dynamic> item=widget.item;
                        item['qty']=double.tryParse(_controller.text);


                          setState(() {
                           // checked = value;
                          if (value) {
                            print(returnItems);
                            print(returnItems.indexOf(item));
                            print(" if value");
                            print(value);
                            returnItems.add(item);
                            print(returnItems);
                          } else {
                            print("else");
                            print(returnItems);
                            print(item);
                            print(returnItems.indexOf(item));
                            print("else value");
                            print(value);
                            returnItems.removeAt(returnItems.indexOf(item)+1);
                            print(returnItems);
                            print("${returnItems.length}returnItems length");
                          }
                          widget.calculate();
                          });
                      })
              ),
            )
          ],
        ),
        const Divider(),
      ],
    );
  }
}