//@dart=2.9
import 'dart:convert';
import 'dart:typed_data';
import 'package:arabic_numbers/arabic_numbers.dart';
import 'package:awafi_pos/Branches/branches.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esc_pos_printer/esc_pos_printer.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter/services.dart';
import 'package:flutter_usb_printer/flutter_usb_printer.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as im;
import '../main.dart';
import '../product_card.dart';
import 'history_print.dart';

class history_View_Widget extends StatefulWidget {
  const history_View_Widget({Key key}) : super(key: key);

  @override
  _history_View_WidgetState createState() => _history_View_WidgetState();
}

class _history_View_WidgetState extends State<history_View_Widget> {
  TextEditingController search;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  Timestamp datePicked1;
  Timestamp datePicked2;

  @override
  void initState() {
    super.initState();
    // setPrinterImages();
    search = TextEditingController();
    DateTime today = DateTime.now();
    datePicked1 = Timestamp.fromDate(
        DateTime(today.year, today.month, today.day - 1, 0, 0, 0));
    datePicked2 = Timestamp.fromDate(DateTime.now());
    // change();
  }

  ArabicNumbers arabicNumber = ArabicNumbers();
  ScreenshotController screenshotController = ScreenshotController();

  qr(String vatTotal1, String grantTotal, DateTime saleDate) {
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
    List<int> date = utf8.encode(saleDate.toString());
    bytesBuilder.addByte(date.length);
    bytesBuilder.add(date);

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
    final Base64Encoder base64encoder = Base64Encoder();
    return base64encoder.convert(qrCodeAsBytes);
  }
  _connect(int vendorId, int productId) async {
    bool returned;
    try {
      returned = await flutterUsbPrinter.connect(vendorId, productId);
    } on PlatformException {
      //response = 'Failed to get platform version.';
    }
    if (returned) {
      setState(() {
        connected = true;
      });
    }
  }
  _getDevicelist() async {
    List<Map<String, dynamic>> results = [];
    results = await FlutterUsbPrinter.getUSBDeviceList();
    for (dynamic device in results) {
      _connect(int.parse(device['vendorId']), int.parse(device['productId']));
    }
    if (mounted) {
      setState(() {
        devices = results;
      });
    }
  }


  List<int> kotBytes = [];
  List<int> bytes = [];
  abc(int invNo,double discount,List items,int token,String tableNo,double delivery,DateTime salesDate,double pc,double pb,double bal) async {
    print('start');
    final CapabilityProfile profile = await CapabilityProfile.load();

    final generator = Generator(PaperSize.mm80, profile);
    const PaperSize paper1 = PaperSize.mm80;
    var profile1 = await CapabilityProfile.load();
    var printer1 = NetworkPrinter(paper1, profile1);
    List<int> bytes = [];


    final Uint8List imgBytes = data.buffer.asUint8List();
    final im.Image image = im.decodeImage(imgBytes);
    bytes += generator.image(image);

    final im.Image image1 = im.decodeImage(capturedImage1);
    bytes += generator.image(image1);
    // bytes += generator.row([
    //   PosColumn(text:"Date :",styles: PosStyles(bold: true,align: PosAlign.left,height: PosTextSize.size1,width: PosTextSize.size1),width: 4),
    //   PosColumn(text:"${DateTime.now().toString().substring(0, 19)} ",styles: PosStyles(bold: true,align: PosAlign.right,height: PosTextSize.size1,width: PosTextSize.size1),width: 8)
    // ]);
    // bytes += generator.row(
    //     [
    //       PosColumn(text: "Invoice No:",styles: const PosStyles(bold: true,align: PosAlign.left,height: PosTextSize.size1,width: PosTextSize.size1),width: 4),
    //       PosColumn(text: "$invNo ",styles: const PosStyles(bold: true,align: PosAlign.right,height: PosTextSize.size1,width: PosTextSize.size1),width: 4)
    //     ]);
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


    //HEAD IMAGE
    // final Uint8List imgBytes1 = data1.buffer.asUint8List();
    // final im.Image image11 = im.decodeImage(imgBytes1);
    // bytes += generator.image(image11);

    // var capturedhead= await    screenshotController
    //     .captureFromWidget(Container(
    //   color: Colors.white,
    //   width: printWidth*3,
    //   height: 85,
    //
    //   child: Column(
    //     children: [
    //       Row(
    //         // mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //         children:   [
    //           //pdt
    //           Expanded(
    //             child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //
    //                 Text('منتج',
    //                   style:  TextStyle(
    //                     fontFamily: 'GE Dinar One Medium',
    //                     fontSize: fontSize,
    //                     fontWeight: FontWeight.w600,
    //                     color: Colors.black,
    //                   ),
    //                 ),
    //                 Text('ITEM',
    //                   style:  TextStyle(
    //                       color: Colors.black,
    //                       fontFamily: 'GE Dinar One Medium',
    //                       fontSize: fontSize,
    //                       fontWeight: FontWeight.w600),
    //                 ),
    //               ],
    //             ),
    //           ),
    //           Container(
    //             width: 45,
    //             child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //
    //                 Text('كمية',
    //                   style:  TextStyle(
    //                       fontFamily: 'GE Dinar One Medium',
    //                       color: Colors.black,
    //                       fontSize: fontSize,
    //                       fontWeight: FontWeight.w600),
    //                 ),
    //                 Text('QTY',
    //                   style:  TextStyle(
    //                       fontFamily: 'GE Dinar One Medium',
    //                       color: Colors.black,
    //                       fontSize: fontSize,
    //                       fontWeight: FontWeight.w600),
    //                 ),
    //               ],
    //             ),
    //           ),
    //           Container(
    //             width: 45,
    //             child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //
    //                 Text('سعر',
    //                   style:  TextStyle(
    //                       fontFamily: 'GE Dinar One Medium',
    //                       color: Colors.black,
    //                       fontSize: fontSize,
    //                       fontWeight: FontWeight.w600),
    //                 ),
    //                 Text('RATE',
    //                   style:  TextStyle(
    //                       fontFamily: 'GE Dinar One Medium',
    //                       color: Colors.black,
    //                       fontSize: fontSize,
    //                       fontWeight: FontWeight.w600),
    //                 ),
    //               ],
    //             ),
    //           ),
    //           Container(
    //             width: 45,
    //             child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //
    //                 Text('ضريبة',
    //                   style:  TextStyle(
    //                       fontFamily: 'GE Dinar One Medium',
    //                       color: Colors.black,
    //                       fontSize: fontSize,
    //                       fontWeight: FontWeight.w600),
    //                 ),
    //                 Text('VAT',
    //                   style:  TextStyle(
    //                       fontFamily: 'GE Dinar One Medium',
    //                       color: Colors.black,
    //                       fontSize: fontSize,
    //                       fontWeight: FontWeight.w600),
    //                 ),
    //               ],
    //             ),
    //           ),
    //           Container(
    //             width: 50,
    //             child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //
    //                 Text('المجموع',
    //                   style:  TextStyle(
    //                       fontFamily: 'GE Dinar One Medium',
    //                       color: Colors.black,
    //                       fontSize: fontSize,
    //                       fontWeight: FontWeight.w600),
    //                 ),
    //                 Text('TOTAL',
    //                   style:  TextStyle(
    //                       fontFamily: 'GE Dinar One Medium',
    //                       color: Colors.black,
    //                       fontSize: fontSize,
    //                       fontWeight: FontWeight.w600),
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ],
    //       ),
    //       Container(
    //           decoration: const BoxDecoration(
    //             color: Colors.white,
    //           ),
    //           child:  Center(child: Text('-------------------------------------------',
    //             style: TextStyle(color: Colors.black,fontSize: printWidth*.25),))
    //       ),
    //     ],
    //   ),
    // ));
    final im.Image imagehead = im.decodeImage(capturedhead);
    bytes += generator.image(imagehead,);
print("$capturedhead--------------------");




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
    String addOnArabic = '';
    addOnArabic = newAddOnArabic.isEmpty ? '' : newAddOnArabic.toString();
    Map<String, dynamic> config = Map();
    List<Widget> itemWidgets=[];
    List<Widget> itemWidgets1=[];
    for (Map<String, dynamic> item in items) {
      var addOnPrice=item['addOnPrice'];
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
      newAddOn = item['addOns'];
      newAddOnArabic = item['addOnArabic'];
      addOnArabic = newAddOnArabic.isEmpty ? '' : newAddOnArabic.toString();
      addON = newAddOn.isEmpty ? '' : newAddOn.toString();
      double price = (double.tryParse(item['price'].toString())+addOnPrice) * 100 / 115;
      totalAmount += price * double.tryParse(item['qty'].toString());
      itemWidgets1.add(
          Container(

            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: ListView(
                shrinkWrap: true,
                children:[
                  Container(
                    width: printWidth*3,
                    child: Column(
                      children: [
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,

                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Text('$arabic $addOnArabic',
                                    // textDirection: TextDirection.rtl,
                                    style:  const TextStyle(
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
            ),
          )
      );



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
              Text('${delivery.toStringAsFixed(2)} ',style:  TextStyle(color: Colors.black,fontSize: fontSize+4,fontWeight: FontWeight.w600),),
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
              Text((grantTotal-discount+delivery).toStringAsFixed(2) ,style:  TextStyle(color: Colors.black,fontSize: fontSize+7,fontWeight: FontWeight.w700),),
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
              mainAxisAlignment: MainAxisAlignment.start,
              children:   [
                Text('Cash  :  ${pc}',style:  TextStyle(color: Colors.black,fontSize: fontSize+2,fontWeight: FontWeight.w600),),
                Text('Bank  :  ${pb}',style:  TextStyle(color: Colors.black,fontSize: fontSize+2,fontWeight: FontWeight.w600),),
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
        // ${(grantTotal-discount+delivery).toStringAsFixed(2)}
      ],
    ));

    String qrVat = (totalAmount * gst / 100).toStringAsFixed(2);
    String qrTotal = (grantTotal-discount+delivery).toStringAsFixed(2);
    // bluetooth.printQRcode(qr(qrVat, qrTotal), 200, 200, 1);
    itemWidgets.add(Container(
      color: Colors.white,
      width: qrCode,

      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          QrImage(
            data: qr(qrVat, qrTotal,salesDate),
            version: 6,
            size: size/1.5,
          ),
        ],
      ),
    ));

    itemWidgets.add(Container(
      color: Colors.white,
      width: printWidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:  [
          SizedBox(height: 8,),
          Text('${PosUserIdToArabicName[currentUserId]}: المحاسب  ',style: TextStyle(color: Colors.black,fontSize: fontSize+2,fontWeight: FontWeight.bold, ),),
          Text('Cashier : ${PosUserIdToName[currentUserId]}',style: TextStyle(color: Colors.black,fontSize: fontSize,fontWeight: FontWeight.bold),),

          SizedBox(height: 8,),
          Text('شكرًا لزيارتك ونتشوق لرؤيتك مرة أخرى',style: TextStyle(color: Colors.black,fontSize:fontSize+3,fontWeight: FontWeight.w600),),
          Text('THANK YOU VISIT AGAIN',style: TextStyle(color: Colors.black,fontSize:fontSize+3,fontWeight: FontWeight.w600),),
        ],
      ),
    )
    );
    // await  bluetooth.printImageBytes(capturedImage5);


    var capturedImage2 = await screenshotController
        .captureFromWidget(Container(
      width: printWidth*3,
      color: Colors.black,

      child: ListView.builder(
          shrinkWrap: true,
          itemCount: itemWidgets.length,
          itemBuilder: (context, index) {
            return itemWidgets[index];
          }),
    ));
    final im.Image image2 = im.decodeImage(capturedImage2);
    bytes += generator.image(image2);


    // try {

    bytes += generator.feed(2);

    bytes += generator.cut();
    // await flutterUsbPrinter.connect(1155, 22339);
    flutterUsbPrinter.write(Uint8List.fromList(bytes));


    print("end");
  }





    change(){
      FirebaseFirestore.instance.collection('sales').get().then((value){
        for(DocumentSnapshot doc in value.docs){
          doc.reference.update({
            'search':setSearchParam(doc.get('invoiceNo').toString()),
            'currentBranchId':currentBranchId,
          });
        }
      });
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

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.primaryColor,
          automaticallyImplyLeading: true,
          title: Text(
            'History',
            style: FlutterFlowTheme.bodyText1.override(
              fontFamily: 'Lexend Deca',
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          actions: [],
          centerTitle: true,
          elevation: 4,
        ),
        backgroundColor: Color(0xFFF5F5F5),
        body:
             SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(15, 15, 15, 15),
                child: TextFormField(
                  controller: search,
                  keyboardType: TextInputType.number,
                  obscureText: false,
                  onChanged: (text) {
                    setState(() {

                    });
                  },

                  decoration: InputDecoration(
                    isDense: true,
                    labelText: 'Search',
                    labelStyle: FlutterFlowTheme.bodyText1,
                    hintText: 'Search By Invoice No:',
                    hintStyle: FlutterFlowTheme.bodyText1,
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(4.0),
                        topRight: Radius.circular(4.0),
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(4.0),
                        topRight: Radius.circular(4.0),
                      ),
                    ),
                  ),
                  style: FlutterFlowTheme.bodyText1,
                ),
              ),


              search.text == '' ?
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('sales')
                      .doc(currentBranchId)
                      .collection('sales')
                      .orderBy('salesDate', descending: true)
                      .where('currentBranchId', isEqualTo: currentBranchId)
                      .where('salesDate', isGreaterThanOrEqualTo: datePicked1)
                      .where('salesDate', isLessThanOrEqualTo: datePicked2)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData ) {
                      return Center(child: CircularProgressIndicator());
                    }
                    var data = snapshot.data.docs;
                    print(data.length);

                    return data.isEmpty
                        ? Center(child: Text('No Data'))
                        : Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          var billItems = data[index]['billItems'];
                          double grandTotal = data[index]['grandTotal'];
                          int token = data[index]['token'];
                          int invoice = data[index]['invoiceNo'];
                          // String StaffName=PosUserIdToName[data[index]['currentUserId']]==null?'':PosUserIdToName[data[index]['currentUserId']];
                          double deliveryCharge = double.tryParse(
                              data[index]['deliveryCharge'].toString());
                          DateTime saleDate = data[index]['salesDate'].toDate();

                          double discount = double.tryParse(
                              data[index]['discount'].toString());
                          return Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                15, 15, 15, 15),
                            child: Container(
                              width: 100,
                              decoration: BoxDecoration(
                                color: Color(0xFFEEEEEE),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: Colors.black,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    10, 15, 10, 15),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceEvenly,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      children: [
                                        Text(
                                          'Bill No : ${data[index].id}',
                                          style: FlutterFlowTheme.bodyText1
                                              .override(
                                              fontFamily: 'Lexend Deca',
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600
                                          ),
                                        ),
                                        Text(
                                          'Date : ${data[index]['salesDate']
                                              .toDate().toString()
                                              .substring(0, 16)}',
                                          style: FlutterFlowTheme.bodyText1
                                              .override(
                                            fontFamily: 'Lexend Deca',
                                            color: Colors.black,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      children: [
                                        Text(
                                          'Total Items : ${billItems.length}',
                                          style: FlutterFlowTheme.bodyText1
                                              .override(
                                            fontFamily: 'Lexend Deca',
                                            color: Colors.black,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      children: [
                                        Text(
                                          data[index]['currentUserId'] == null
                                              ? ''
                                              : 'StaffName : ${PosUserIdToName[data[index]['currentUserId']]}',
                                          style: FlutterFlowTheme.bodyText1
                                              .override(
                                            fontFamily: 'Lexend Deca',
                                            color: Colors.black,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      children: [
                                        Text(
                                          data[index]['cash'] == true &&
                                              data[index]['bank'] == true
                                              ? 'Mode Of Payment : Cash & Bank'
                                              : data[index]['cash'] == true &&
                                              data[index]['bank'] == false
                                              ? 'Mode Of Payment : Cash'
                                              : 'Mode Of Payment : Bank',
                                          style: FlutterFlowTheme.bodyText1
                                              .override(
                                            fontFamily: 'Lexend Deca',
                                            color: Colors.black,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment
                                          .center,
                                      children: [
                                        Text(
                                          'Amount : ${grandTotal
                                              .toStringAsFixed(2)}',
                                          style: FlutterFlowTheme.bodyText1
                                              .override(
                                            fontFamily: 'Lexend Deca',
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding:
                                      const EdgeInsetsDirectional.fromSTEB(
                                          0, 10, 0, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment
                                            .end,
                                        children: [
                                          FFButtonWidget(
                                            onPressed: () {
                                              blue ?

                                              showDialog(
                                                  barrierDismissible: false,
                                                  context: context,
                                                  builder: (
                                                      BuildContext context) {
                                                    items = billItems;
                                                    return history_print(
                                                      items: items,
                                                      token: token,
                                                      salesDate: data[index]['salesDate']
                                                          .toDate().toString()
                                                          .substring(0, 16),
                                                      delivery: deliveryCharge,
                                                      customer: 'Walking Customer',
                                                      discountPrice: discount,
                                                      invoiceNo: invoice
                                                          .toString(),
                                                      tableName: data[index]['table'],
                                                      cashPaid: double.tryParse(
                                                          data[index]['paidCash']
                                                              .toString()),
                                                      bankPaid: double.tryParse(
                                                          data[index]['paidBank']
                                                              .toString()),
                                                      balance: double.tryParse(
                                                          data[index]['balance']
                                                              .toString()),
                                                    );
                                                  }) : abc(
                                                invoice,
                                                discount,
                                                billItems,
                                                token,
                                                data[index]['table'],
                                                deliveryCharge
                                                ,
                                                data[index]['salesDate']
                                                    .toDate(),
                                                double.tryParse(
                                                    data[index]['paidCash']
                                                        .toString()),
                                                double.tryParse(
                                                    data[index]['paidBank']
                                                        .toString()),
                                                double.tryParse(
                                                    data[index]['balance']
                                                        .toString()),);
                                            },
                                            text: 'Print',
                                            icon: const Icon(
                                              Icons.print,
                                              size: 18,
                                            ),
                                            options: FFButtonOptions(
                                              width: 130,
                                              height: 35,
                                              color: FlutterFlowTheme
                                                  .primaryColor,
                                              textStyle:
                                              FlutterFlowTheme.subtitle2
                                                  .override(
                                                fontFamily: 'Lexend Deca',
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
                                  ],
                                ),
                              ),
                            ),
                          );
                        },

                      ),
                    );
                  }
              ) :
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('sales')
                      .doc(currentBranchId)
                      .collection('sales')
                      .orderBy('salesDate', descending: true)
                  // .where('search',arrayContains: search.text)
                      .where('invoiceNo', isEqualTo: int.tryParse(search.text))
                      .where('currentBranchId', isEqualTo: currentBranchId)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    }
                    var data = snapshot.data.docs;

                    return data.isEmpty
                        ? Center(child: Text('No Data'))
                        : Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          var billItems = data[index]['billItems'];
                          double grandTotal = data[index]['grandTotal'];
                          int token = data[index]['token'];
                          int invoice = data[index]['invoiceNo'];
                          double deliveryCharge = double.tryParse(
                              data[index]['deliveryCharge'].toString());
                          DateTime saleDate = data[index]['salesDate'].toDate();

                          double discount = double.tryParse(
                              data[index]['discount'].toString());

                          return Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                15, 15, 15, 15),
                            child: Container(
                              width: 100,
                              decoration: BoxDecoration(
                                color: Color(0xFFEEEEEE),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: Colors.black,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    10, 15, 10, 15),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceEvenly,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      children: [
                                        Text(
                                          'Bill No : ${data[index].id}',
                                          style: FlutterFlowTheme.bodyText1
                                              .override(
                                              fontFamily: 'Lexend Deca',
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600
                                          ),
                                        ),
                                        Text(
                                          'Date : ${data[index]['salesDate']
                                              .toDate().toString()
                                              .substring(0, 16)}',
                                          style: FlutterFlowTheme.bodyText1
                                              .override(
                                            fontFamily: 'Lexend Deca',
                                            color: Colors.black,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Text(
                                          'Token : ${data[index]['token']}',
                                          style: FlutterFlowTheme.bodyText1
                                              .override(
                                            fontFamily: 'Lexend Deca',
                                            color: Colors.black,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      children: [
                                        Text(
                                          'Total Items : ${billItems.length}',
                                          style: FlutterFlowTheme.bodyText1
                                              .override(
                                            fontFamily: 'Lexend Deca',
                                            color: Colors.black,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      children: [
                                        Text(
                                          data[index]['currentUserId'] == null
                                              ? ''
                                              : 'StaffName : ${PosUserIdToName[data[index]['currentUserId']]}',
                                          style: FlutterFlowTheme.bodyText1
                                              .override(
                                            fontFamily: 'Lexend Deca',
                                            color: Colors.black,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      children: [
                                        Text(
                                          data[index]['cash'] == true ?
                                          'Mode Of Payment : Cash'
                                              : 'Mode Of Payment : Bank',
                                          style: FlutterFlowTheme.bodyText1
                                              .override(
                                            fontFamily: 'Lexend Deca',
                                            color: Colors.black,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment
                                          .center,
                                      children: [
                                        Text(
                                          'Amount : ${grandTotal
                                              .toStringAsFixed(2)}',
                                          style: FlutterFlowTheme.bodyText1
                                              .override(
                                            fontFamily: 'Lexend Deca',
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding:
                                      const EdgeInsetsDirectional.fromSTEB(
                                          0, 10, 0, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment
                                            .end,
                                        children: [
                                          FFButtonWidget(
                                            onPressed: () {
                                              try {
                                                blue ?

                                                showDialog(
                                                    barrierDismissible: false,
                                                    context: context,
                                                    builder: (
                                                        BuildContext context) {
                                                      items = billItems;
                                                      return history_print(
                                                        items: items,
                                                        token: token,
                                                        salesDate: data[index]['salesDate']
                                                            .toDate().toString()
                                                            .substring(0, 16),
                                                        delivery: deliveryCharge,
                                                        customer: 'Walking Customer',
                                                        discountPrice: discount,
                                                        invoiceNo: invoice
                                                            .toString(),
                                                        tableName: data[index]['table'],
                                                        cashPaid: double
                                                            .tryParse(
                                                            data[index]['paidCash']
                                                                .toString()),
                                                        bankPaid: double
                                                            .tryParse(
                                                            data[index]['paidBank']
                                                                .toString()),
                                                        balance: double
                                                            .tryParse(
                                                            data[index]['balance']
                                                                .toString()),

                                                      );
                                                    }) : abc(
                                                  invoice,
                                                  discount,
                                                  billItems,
                                                  token,
                                                  data[index]['table'],
                                                  deliveryCharge,
                                                  data[index]['salesDate']
                                                      .toDate(),
                                                  double.tryParse(
                                                      data[index]['paidCash']
                                                          .toString()),
                                                  double.tryParse(
                                                      data[index]['paidBank']
                                                          .toString()),
                                                  double.tryParse(
                                                      data[index]['balance']
                                                          .toString()),);
                                              } catch (e) {
                                                print(e.toString() +
                                                    'llllllllllllllllllll');
                                                showDialog<void>(
                                                  context: context,
                                                  barrierDismissible: false,
                                                  // user must tap button!
                                                  builder: (
                                                      BuildContext context) {
                                                    return AlertDialog(
                                                      title: Text(e.toString()),

                                                      actions: <Widget>[
                                                        TextButton(
                                                          child: const Text(
                                                              'Approve'),
                                                          onPressed: () {
                                                            Navigator.of(
                                                                context).pop();
                                                          },
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                              }
                                            },
                                            text: 'Print',
                                            icon: const Icon(
                                              Icons.print,
                                              size: 18,
                                            ),
                                            options: FFButtonOptions(
                                              width: 130,
                                              height: 35,
                                              color: FlutterFlowTheme
                                                  .primaryColor,
                                              textStyle:
                                              FlutterFlowTheme.subtitle2
                                                  .override(
                                                fontFamily: 'Lexend Deca',
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
                                  ],
                                ),
                              ),
                            ),
                          );
                        },

                      ),
                    );
                  }
              ),
            ],
          ),
        )
           ,
      );
    }
  }

