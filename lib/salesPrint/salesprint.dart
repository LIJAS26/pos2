//@dart=2.9
import 'dart:async';
import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:bluetooth_print/bluetooth_print.dart';
import 'package:flutter/material.dart';
import 'package:awafi_pos/flutter_flow/flutter_flow_theme.dart';
import 'package:awafi_pos/flutter_flow/flutter_flow_widgets.dart';
import 'package:awafi_pos/flutter_flow/upload_media.dart';
import 'package:awafi_pos/modals/Print/Invoice.dart';
import 'package:awafi_pos/modals/Print/supplier.dart';
import '../main.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';




class SalesHistoryPrint extends StatefulWidget {
  final String shopName;
  final DateTime salesDate;
  final String invoiceNo;
  final String currentBalance;
  final String customeracct;
  final String amount;
  final int value;
  final List salesItems;
  final String from;
final double discountPrice;
  const SalesHistoryPrint({Key key, this.shopName, this.currentBalance, this.customeracct, this.value, this.amount, this.from, this.salesItems, this.salesDate, this.invoiceNo, this.discountPrice}) : super(key: key);
  @override
  _SalesHistoryPrintState createState() => _SalesHistoryPrintState();
}

class _SalesHistoryPrintState extends State<SalesHistoryPrint> {
  BluetoothPrint bluetoothPrint = BluetoothPrint.instance;

  bool _connected = false;
  BluetoothDevice _device;
  String tips = 'No Device connect';
  var Type;
  var addOn;
  @override
  void initState() {
    super.initState();
    print(items);
    WidgetsBinding.instance.addPostFrameCallback((_) => initBluetooth());
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initBluetooth() async {
    bluetoothPrint.startScan(timeout: Duration(seconds: 4));

    bool isConnected=await bluetoothPrint.isConnected;

    bluetoothPrint.state.listen((state) {
      print('cur device status: $state');

      switch (state) {
        case BluetoothPrint.CONNECTED:
          setState(() {
            _connected = true;
            tips = 'Connect Success';
          });
          break;
        case BluetoothPrint.DISCONNECTED:
          setState(() {
            _connected = false;
            tips = 'Disconnect Success';
          });
          break;
        default:
          break;
      }
    });

    if (!mounted) return;

    if(isConnected) {
      setState(() {
        _connected=true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AlertDialog(

        content: Container(
          child: RefreshIndicator(
            onRefresh: () =>
                bluetoothPrint.startScan(timeout: const Duration(seconds: 4)),
            child: SingleChildScrollView(
              child: Stack(
               children: [
                 Column(
                   children: <Widget>[
                     Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: <Widget>[
                         Padding(
                           padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                           child: _connected==true?
                           Text(tips,
                             style: FlutterFlowTheme.bodyText1.override(
                               fontFamily: 'Poppins',
                               color: Colors.green,
                               fontSize: 17,
                               fontWeight: FontWeight.w600,
                             ),

                           ):
                           Text(tips,
                             style: FlutterFlowTheme.bodyText1.override(
                               fontFamily: 'Poppins',
                               color: Colors.red,
                               fontSize: 17,
                               fontWeight: FontWeight.w600,
                             ),

                           ),
                         ),
                       ],
                     ),
                     Divider(),
                     StreamBuilder<List<BluetoothDevice>>(
                       stream: bluetoothPrint.scanResults,
                       initialData: [],
                       builder: (c, snapshot) {
                         return Column(
                           children: snapshot.data.map((d) => ListTile(
                             title: Text(d.name??''),
                             subtitle: Text(d.address),
                             onTap: () async {
                               setState(() {
                                 _device = d;
                               });
                             },
                             trailing: _device!=null && _device.address == d.address?Icon(
                               Icons.check,
                               color: Colors.green,
                             ):null,
                           )).toList(),
                         );
                       }
                     ),
                     Divider(),
                     Container(
                       padding: EdgeInsets.fromLTRB(20, 5, 20, 10),
                       child: Column(
                         children: <Widget>[
                           Row(
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: <Widget>[
                               OutlinedButton(
                                 child: Text('connect'),
                                 onPressed:  _connected?null:() async {
                                   if(_device!=null && _device.address !=null){
                                     await bluetoothPrint.connect(_device);
                                   }else{
                                     setState(() {
                                       tips = 'please select device';
                                     });
                                     print('please select device');
                                     print(addOn);

                                   }
                                 },
                               ),
                               SizedBox(width: 10.0),
                               OutlinedButton(
                                 child: Text('disconnect'),
                                 onPressed:  _connected?() async {
                                   await bluetoothPrint.disconnect();
                                 }:null,
                               ),
                             ],
                           ),
                           OutlinedButton(
                             child: Text('Print Receipt'),
                             onPressed:  _connected?() async {
                               Map<String, dynamic> config = Map();
                               List<LineText> list = [];
                               final invoice = Invoice(
                                   supplier:
                                   Supplier(name: 'Test', address: 'test', paymentInfo: 'test'),
                                   info: InvoiceInfo(
                                     description: 'Boofiya Faraula',
                                     number: '',
                                     date: DateTime.now(),
                                   ),
                                   salesItems: [],
                                   table: int.tryParse(selectedTable),
                                   discount: double.tryParse(discount.toString())??0);
                               List<Map<String, dynamic>> datas = [];
                               String itemString = '';
                               String itemTotal = '';
                               String itemGrossTotal = '';
                               String itemTax = '';
                               String addON='';


                               for (Map<String, dynamic> item in items) {
                                 double total = double.tryParse(item['price'].toString()) *
                                     double.tryParse(item['qty'].toString());
                                 double grossTotal = total * 100 / 115;
                                 double vat = total * 15 / 115;
                                 addOn=item['addOns'];
                                 addON=addOn.length==0?'':addOn.toString();
                                 double price = double.tryParse(item['price'].toString()) * 100 / 115;
                                 itemString += " \n ${item['pdtname']} $addON \n";
                                 itemString +=
                                 "${int.tryParse(item['qty'].toString())}  ${price.toStringAsFixed(2)}   ${grossTotal.toStringAsFixed(2)}   ${vat.toStringAsFixed(2)}   ${total.toStringAsFixed(2)}\n \n";
                                 itemTotal+= "${(totalAmount * ((100 + gst) / 100) - (double.tryParse(discount.toString()) ?? 0)).toStringAsFixed(2)}";
                                 itemGrossTotal+= "${grossTotal.toStringAsFixed(2)}";
                                 itemTax+= "${(totalAmount * gst / 100).toStringAsFixed(2)}";
                               }

                               // totalTax=grandTotal-total;
                               // String link="https://www.firstlogicinfolab.com/demo/vansales/View?a=${widget.invoiceNo}";
                               //https://worldcuisineksa.page.link/viewBill
                               // final DynamicLinkParameters parameters = DynamicLinkParameters(
                               //   // This should match firebase but without the username query param
                               //   uriPrefix: 'https://worldcuisineksa.page.link/viewBill',
                               //   // This can be whatever you want for the uri, https://yourapp.com/groupinvite?username=$userName
                               //   link: Uri.parse('https://worldcuisineksa.page.link/viewBill?invoiceNo=${widget.invoiceNo}'),
                               //   androidParameters: AndroidParameters(
                               //     packageName: 'com.firstlogicinfolab.qrcode',
                               //     minimumVersion: 1,
                               //   ),
                               //   iosParameters: IosParameters(
                               //     bundleId: 'com.firstlogicinfolab.qrcode',
                               //     minimumVersion: '1',
                               //     appStoreId: '',
                               //   ),
                               // );
                               // final link = await parameters.buildUrl();
                               // // final ShortDynamicLink shortenedLink = await DynamicLinkParameters.shortenUrl(
                               // //   link,
                               // //   DynamicLinkParametersOptions(shortDynamicLinkPathLength: ShortDynamicLinkPathLength.unguessable),
                               // // );

                               String dynamicLink= "https://qrcode-579db.web.app/viewBill?${widget.invoiceNo}";

                               list.add(LineText(type: LineText.TYPE_QRCODE, x:10, y:70, content: dynamicLink));
                               list.add(LineText(linefeed: 1));
                               list.add(LineText(type: LineText.TYPE_TEXT, content: '${invoice.info.description} ', weight: 5, align: LineText.ALIGN_CENTER,linefeed: 1,size: 50,width: 10,height: 10));
                               list.add(LineText(linefeed: 1));
                               list.add(LineText(type: LineText.TYPE_TEXT, content: 'Abushabth - abrag \n Al Rugama - Jeddah', weight: 0, align: LineText.ALIGN_CENTER,linefeed: 1));
                               list.add(LineText(linefeed: 1));
                               list.add(LineText(type: LineText.TYPE_TEXT, content: 'Ph No : +966 569817181', align: LineText.ALIGN_CENTER,linefeed: 1));
                               list.add(LineText(linefeed: 1));
                               list.add(LineText(type: LineText.TYPE_TEXT, content: 'Date : ${DateTime.now().toString().substring(0,19)}', align: LineText.ALIGN_CENTER,linefeed: 1));
                               list.add(LineText(linefeed: 1));
                               list.add(LineText(type: LineText.TYPE_TEXT, content: 'Invoice No : ${widget.invoiceNo}', align: LineText.ALIGN_CENTER,linefeed: 1));
                               list.add(LineText(linefeed: 1));
                               list.add(LineText(type: LineText.TYPE_TEXT, content: '................................\n',weight: 1, align: LineText.ALIGN_LEFT,linefeed: 1));
                               list.add(LineText(type: LineText.TYPE_TEXT, content: 'Product \n',weight: 1, align: LineText.ALIGN_LEFT,linefeed: 1));
                               list.add(LineText(type: LineText.TYPE_TEXT, content: 'Qty Rate  GrossTotal  VAT  Total', align: LineText.ALIGN_LEFT,linefeed: 1));
                               list.add(LineText(linefeed: 1));
                               list.add(LineText(type: LineText.TYPE_TEXT, content: '$itemString \n',weight: 1, align: LineText.ALIGN_LEFT,linefeed: 1));
                               list.add(LineText(linefeed: 1));
                               list.add(LineText(type: LineText.TYPE_TEXT, content: '................................\n',weight: 1, align: LineText.ALIGN_LEFT,linefeed: 1));

                               list.add(LineText(type: LineText.TYPE_TEXT, content: 'Gross Total : ${totalAmount.toStringAsFixed(2)}\n',weight: 5,size: 30, align: LineText.ALIGN_CENTER,linefeed: 1));
                               list.add(LineText(type: LineText.TYPE_TEXT, content: 'Vat Amount : ${(totalAmount * gst / 100).toStringAsFixed(2)} \n',weight: 2,size: 30, align: LineText.ALIGN_CENTER,linefeed: 1));
                               list.add(LineText(type: LineText.TYPE_TEXT, content: 'Discount : ${invoice.discount.toStringAsFixed(2)}\n',weight: 2,size: 30, align: LineText.ALIGN_CENTER,linefeed: 1));
                               list.add(LineText(type: LineText.TYPE_TEXT, content: 'Grant Total : ${(totalAmount * ((100 + gst) / 100) - (double.tryParse(discount.toString()) ?? 0)).toStringAsFixed(2)}\n',weight: 2,size: 30, align: LineText.ALIGN_CENTER,linefeed: 1));

                               list.add(LineText(linefeed: 1));
                               // ByteData data = await rootBundle.load("assets/images/logo1.png");
                               // List<int> imageBytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
                               // String base64Image = base64Encode(imageBytes);
                               // list.add(LineText(type: LineText.TYPE_IMAGE, content: base64Image, align: LineText.ALIGN_CENTER, linefeed: 1));

                               await bluetoothPrint.printReceipt(config, list);
                             }:null,
                           ),

                           FFButtonWidget(
                               onPressed: () async {
                                 Navigator.pop(context);
                                 showUploadMessage(context, 'Sale Successful..');

                               },
                               text:'Home',
                               options : FFButtonOptions(
                                 width: 200,
                                 height: 40,
                                 color: primaryColor,
                                 textStyle:
                                 FlutterFlowTheme.subtitle2.override(
                                   fontFamily: 'Poppins',
                                   color: Colors.white,
                                   fontSize: 15,
                                 ),
                                 borderSide: BorderSide(
                                   color: Colors.transparent,
                                   width: 2,
                                 ),
                                 borderRadius: 12,
                               )),
                           SizedBox(height: 50,),



                         ],
                       ),
                     )
                   ],
                 ),
                 Positioned(
                   bottom: 0,
                     right: 0,
                     child: Container(

                   child:    StreamBuilder<bool>(
                     stream: bluetoothPrint.isScanning,
                     initialData: false,
                     builder: (c, snapshot) {
                       if (snapshot.data) {
                         return IconButton(
                           icon: Icon(Icons.stop),
                           onPressed: () => bluetoothPrint.stopScan(),
                         );
                       } else {
                         return IconButton(
                             icon: Icon(Icons.refresh),
                             onPressed: () => bluetoothPrint.startScan(timeout: Duration(seconds: 4)));
                       }
                     },
                   ),
                 ))
               ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}