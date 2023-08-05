//@dart=2.9
import 'dart:async';
import 'dart:convert' show Base64Encoder, utf8;
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:awafi_pos/return/sales_return.dart';
import 'package:awafi_pos/salesPrint/ePrint.dart';
import 'package:basic_utils/basic_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esc_pos_printer/esc_pos_printer.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_usb_printer/flutter_usb_printer.dart';
import 'package:geocoding/geocoding.dart';
import 'package:awafi_pos/productandcat.dart';
import 'package:awafi_pos/purchase.dart';
import 'package:awafi_pos/reports/expense_reports.dart';
import 'package:awafi_pos/reports/purchase_reports.dart';
import 'package:awafi_pos/salesPrint/new_sales_print.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'Branches/branches.dart';
import 'DailyReport/dailyReport.dart';
import 'History/history.dart';
import 'add_on.dart';
import 'arabictext.dart';
import 'auth/auth_util.dart';
import 'auth/firebase_user_provider.dart';
import 'backend/backend.dart';
import 'backend/settingModal.dart';
import 'bill.dart';
import 'expenses.dart';
import 'flutter_flow/flutter_flow_theme.dart';
import 'flutter_flow/flutter_flow_widgets.dart';
import 'flutter_flow/upload_media.dart';
import 'login.dart';
import 'modals/Print/Invoice.dart';
import 'modals/Print/pdf_invoice_api.dart';
import 'modals/Print/supplier.dart';
import 'modals/user.dart';
import 'orders/live_orders.dart';
import 'orders/order_confirm.dart';
import 'orders/orders_widget.dart';
import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import '../product_card.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:image/image.dart' as im;
import 'package:arabic_numbers/arabic_numbers.dart';




final default_color=Color(0xffBF0F1B);
bool _connected = false;
bool _pressed = false;
 bool offer =false;
int vendorId=0;
int productId=0;
bool bluetoothConnected=false;
int kotPrinter;
String currentUserId;
String currentUserName;
Map PosUserIdToName={};
Map PosUserIdToArabicName={};
var posUsers;
Map<String,dynamic> printers={};
getPosUser(){
  FirebaseFirestore.instance
      .collection('posUsers')
      .where('deleted',isEqualTo: false)
      .snapshots()
      .listen((event) {
        posUsers=event.docs;
    for(var doc in event.docs){
      PosUserIdToName[doc.id] = doc.get('name');
      PosUserIdToArabicName[doc.id] = doc.get('arabicName');
    }

  });
}
ScreenshotController screenshotController = ScreenshotController();
var capturedImage1;
var capturedhead;
var footerImage;
var itemImage;
List<im.Image> imageList=[];
setPrinterImages() async {
  while(printWidth==0){
    await Future.delayed(Duration(seconds: 1));
  }
  capturedImage1= await    screenshotController
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
              Text(currentBranchArabic,style:  TextStyle(fontFamily:'GE Dinar One Medium',color: Colors.black, fontSize: fontSize+2,fontWeight: FontWeight.w600),),
              Text(" : اسم الفرع",style:  TextStyle(fontFamily:'GE Dinar One Medium',color: Colors.black, fontSize: fontSize+2,fontWeight: FontWeight.w600),),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Branch Name:",style:  TextStyle(fontFamily:'GE Dinar One Medium',color: Colors.black, fontSize: fontSize+2,fontWeight: FontWeight.w600),),
              Text(currentBranchAddress,style:  TextStyle(fontFamily:'GE Dinar One Medium',color: Colors.black, fontSize: fontSize+2,fontWeight: FontWeight.w600),),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Contact No: ', style: TextStyle(color: Colors.black, fontSize: fontSize + 2, fontWeight: FontWeight.w600),),
              Text('$currentBranchPhNo ', style: TextStyle(color: Colors.black, fontSize: fontSize, fontWeight: FontWeight.w600),),

            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:  [
              Text('Vat No:',style: TextStyle(color: Colors.black,fontSize: fontSize+2,fontWeight: FontWeight.w600),),
              Text('311202993300003',style: TextStyle(color: Colors.black,fontSize: fontSize,fontWeight: FontWeight.w600),),
            ],),


        ]
    ),
  )
  );
  capturedhead = await screenshotController
      .captureFromWidget(Container(
    color: Colors.white,
    width: printWidth * 3,
    height: 85,
    padding: const EdgeInsets.only(top: 4),
    child: Column(
      children: [
        Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //pdt
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('منتج',
                    style: TextStyle(
                      fontFamily: 'GE Dinar One Medium',
                      fontSize: fontSize,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  Text('Product',
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'GE Dinar One Medium',
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
                  Text('كمية',
                    style: TextStyle(
                        fontFamily: 'GE Dinar One Medium',
                        color: Colors.black,
                        fontSize: fontSize,
                        fontWeight: FontWeight.w600),
                  ),
                  Text('Qty',
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
                  Text('سعر',
                    style: TextStyle(
                        fontFamily: 'GE Dinar One Medium',
                        color: Colors.black,
                        fontSize: fontSize,
                        fontWeight: FontWeight.w600),
                  ),
                  Text('Rate',
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
                  Text('ضريبة',
                    style: TextStyle(
                        fontFamily: 'GE Dinar One Medium',
                        color: Colors.black,
                        fontSize: fontSize,
                        fontWeight: FontWeight.w600),
                  ),
                  Text('vat',
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
                  Text('المجموع',
                    style: TextStyle(
                        fontFamily: 'GE Dinar One Medium',
                        color: Colors.black,
                        fontSize: fontSize,
                        fontWeight: FontWeight.w600),
                  ),
                  Text('Total',
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
        Container(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child:  Center(child: Text('-------------------------------------------',
              style: TextStyle(color: Colors.black,fontSize: printWidth*.25),))
        ),
      ],
    ),
  ));
  while(PosUserIdToArabicName[currentUserId]==null){
    await Future.delayed(Duration(seconds: 1));
  }
  print("finished");
  footerImage=await screenshotController
      .captureFromWidget(Container(
    width: printWidth * 3,
    height: printWidth * 2,
    color: Colors.white,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            SizedBox(height: 8,),
            Text('${PosUserIdToArabicName[currentUserId]}: المحاسب  ',
              style: TextStyle(color: Colors.black,
                fontSize: fontSize + 2,
                fontWeight: FontWeight.bold,),),
            Text('Cashier : ${PosUserIdToName[currentUserId]}',
              style: TextStyle(color: Colors.black,
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold),),

            SizedBox(height: 8,),
            Text('شكرًا لزيارتك ونتشوق لرؤيتك مرة أخرى', style: TextStyle(
                fontFamily: 'GE Dinar One Medium',
                color: Colors.black,
                fontSize: fontSize + 3,
                fontWeight: FontWeight.w600),),
            Text('THANK YOU VISIT AGAIN', style: TextStyle(
                fontFamily: 'GE Dinar One Medium',
                color: Colors.black,
                fontSize: fontSize + 3,
                fontWeight: FontWeight.w600),),
          ],
        ),
      ],
    ),
  ));
}
bool working=false;
setItemWidgets(List items) async {

  while(working){

    await Future.delayed(const Duration(milliseconds: 300));
  }
  print("starrrrrrrrrrrrrrrrrrrrt");
  print(DateTime.now());
  working=true;

  List itemWidgets1=[];
  imageList=[];

  for (Map<String, dynamic> item in items) {
    double addOnPrice = item['addOnPrice'];
    double total = (double.tryParse(item['price'].toString()) + addOnPrice) *
        double.tryParse(item['qty'].toString());
    double grossTotal = total * 100 / 115;
    double vat = (double.tryParse(item['price'].toString()) + addOnPrice) * 15 /
        115;
    List newAddOn = item['addOns'];
    String arabic = item['arabicName'];
    String english = item['pdtname'];



    newAddOn = item['addOns'];
    newAddOnArabic = item['addOnArabic'];
    String addOnArabic = newAddOnArabic.isEmpty ? '' : newAddOnArabic.toString();
    String addON = newAddOn.isEmpty ? '' : newAddOn.toString();
    double price = (double.tryParse(item['price'].toString()) + addOnPrice) *
        100 / 115;

    itemWidgets1.add(
        Container(
            width: printWidth * 3,
            padding: const EdgeInsets.all(1.0),
            decoration: const BoxDecoration(
              color: Colors.white,
            ),

            child: ListView(
                shrinkWrap: true,
                children: [
                  Container(
                    width: printWidth*3,
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
                        SizedBox(height:10)
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
            )
        )
    );
    if (itemWidgets1.length == itemCount) {
      itemImage = await screenshotController
          .captureFromWidget(Container(
        width: printWidth * 3,

        child: ListView.builder(
            shrinkWrap: true,
            itemCount: itemWidgets1.length,
            itemBuilder: (context, index) {
              return itemWidgets1[index];
            }),
      ));

      final im.Image image22 = im.decodeImage(itemImage);
      imageList.add(image22);
      itemWidgets1 = [];
    }



  }
  if (itemWidgets1.isNotEmpty) {
    var capturedIm = await screenshotController
        .captureFromWidget(Container(
      width: printWidth * 3,

      child: ListView.builder(
          shrinkWrap: true,
          itemCount: itemWidgets1.length,
          itemBuilder: (context, index) {
            return itemWidgets1[index];
          }),
    ));

    final im.Image image22 = im.decodeImage(capturedIm);
    imageList.add(image22);

    itemWidgets1 = [];
  }
  working=false;
  print("endddddddddddddddddddddddddddddddddddddddddddd");
  print(DateTime.now());
}

ingredientsUpdate(List billItems){
  for(var a in billItems){
    for(var b in a['ingredients']??[]){
      FirebaseFirestore.instance.collection("ingredients").doc(b['ingredientId']).update({
        "quantity":FieldValue.increment(-1*((b['quantity'])*a['qty'])),
      });
    }
    for(var b in a['variants']){
      print("1111");
      for(var c in b['ingredients']){
        print("2222");
        print(c.toString());
        FirebaseFirestore.instance.collection("ingredients").doc(c['ingredientId']).update({
          "quantity":FieldValue.increment(-1*(c['quantity']*a['qty'])),
        });
      }

    }
  }
}
bool blue=false;
ByteData data;
ByteData data1;
double charset = 0;
double qrCode = 0;
double size = 0;
String heading;
String topImage;
bool disable = false;
bool product = false;

Stream categoryChange;
double xOffset = 0;
double yOffset = 0;
int count=300;
double scaleFactor = 1;
String discount = '';
String delivery = '';
int table;
List items = [];
final primaryColor = Color(0xffBF0F1B);
const secondaryColor = Colors.black;
bool isDrawerOpen = false;
QuerySnapshot branches;
// List shippingAddress = [];
int selectedShippingAddress = 0;
User currentUserModel;
String loggedInAs;
String promoCode;
String branchName;
bool fromBucket = false;
bool products = false;
int noOfAlerts = 0;
double fontSize = 0;
double printWidth=0;
double qr=0;
int paymentMethod = 0;
String currentPage = 'HomePage';
DesignSettings currentSetting;
Function homeSet;
Placemark plcmrk;
String selectedTable = '1';
bool keyboard = false;
int selectedTableIndex = 0;
bool cash = true;
bool bank = false;
double totalAmount = 0;
String tableName='';
double gst = 15;
String webApi = "AIzaSyDMik73EbwPr20maocafDBHS6GjccIMuUA";
List<Map<String, dynamic>> devices = [];
FlutterUsbPrinter flutterUsbPrinter = FlutterUsbPrinter();
bool connected = false;
bool pressed = false;
bool lastCut = false;
BlueThermalPrinter bluetooth ;
List<BluetoothDevice> btDevices = [];
BluetoothDevice device;
int itemCount=5;
bool display_image=true;
Map<String,dynamic> allCategories={};
double cashPaid=0;
double bankPaid=0;
double balance=0;

// var capturedImage1;
var capturedImage2;
var capturedImage3;
var capturedImage5;
var capturedImage6;
var capturedImage7;
var capturedImage8;
var capturedImage9;
var capturedImage10;
var capturedImage11;
var capturedImage13;
var capturedImage23;
var capturedImage33;
var capturedImage43;

bool notificationArrived=false;
AndroidNotificationChannel channel=const AndroidNotificationChannel(
    'high_importance_channel',
    // 'High importance Notifications',
    'this is a channel test',
    importance: Importance.high,
    playSound: true,
    enableVibration: true);
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =FlutterLocalNotificationsPlugin();
Future<void>_firebaseMessagingBackgroundHandler(RemoteMessage message) async{
  await Firebase.initializeApp();
  notificationArrived=true;

}
Future<void> main() async {
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    await FirebaseMessaging.instance.subscribeToTopic('admin-app');
    await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    // The following lines are the same as previously explained in "Handling uncaught errors"
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

    runApp(const HomePage());
  }, (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack));


}

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}
String dropdownvalue;

var abcd = [
  'Dine-In',
  'Take Away',
  'Drive-Thru',
];
int DelCharge;
class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> devices = [];
  FlutterUsbPrinter flutterUsbPrinter = FlutterUsbPrinter();
  DhaboEcommerceFirebaseUser initialUser;
  Stream<DhaboEcommerceFirebaseUser> userStream;

printerr() async {
  // const PaperSize paper = PaperSize.mm80;
  // var profile = await CapabilityProfile.load();
  // printer = NetworkPrinter(paper, profile);
}

  @override
  void initState() {
    printerr();
    try{

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {

        RemoteNotification notification =message.notification;
        AndroidNotification android =message.notification?.android;
        if(notification!=null && android !=null){

          flutterLocalNotificationsPlugin.show(
              notification.hashCode,
              notification.title,
              notification.body,
              NotificationDetails(
                  android: AndroidNotificationDetails(
                    channel.id,
                    channel.name,
                    // channel.description,
                    color:Colors.blue,
                    playSound: true,
                    icon: '@mipmap/ic_launcher',
                  )
              ));
        }
      });
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
        RemoteNotification notification =message.notification;
        AndroidNotification android =message.notification?.android;
        if(notification!=null && android !=null){

          setState(() {
            notificationArrived=true;
            // orderData =json.decode(message.data['extradata']);
          });


        }
        else{
          print('else');
        }
      });
    }
    catch(exception){
      print(exception);
    }
    super.initState();
    getPrintImages();
    userStream = dhaboEcommerceFirebaseUserStream()
      ..listen((user) => initialUser ?? setState(() => initialUser = user));
  }

  set() {
    setState(() {});
  }

  getPrintImages() async {
    data = await rootBundle.load('assets/faraula_hida.png');
    data1 = await rootBundle.load('assets/nnnn.jpg');
  }



  @override
  Widget build(BuildContext context) {
    // if (initialUser != null) {
    //   if (initialUser.loggedIn) {
    //     print('-------------------------------------------------');
    //     loggedInAs = "Google";
    //     maybeCreateUser(initialUser.user).then((value) {
    //       setState(() {});
    //     });
    //   }
    // }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
      ),
      home: initialUser == null
          ? const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Color(0xff4b39ef)),
        ),
      )
          : currentUser.loggedIn && currentUserModel != null
          ? const HomeBody()
          : const Login(),
      // :HomeBody(),
    );
  }
}

class HomeBody extends StatefulWidget {
  const HomeBody({Key key}) : super(key: key);

  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {

  ArabicNumbers arabicNumber = ArabicNumbers();

  List<String> tables = [];
  TextEditingController discountController;
  TextEditingController deliveryCharge;
  TextEditingController paidCash;
  TextEditingController paidBank;
  TextEditingController tableController;

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




  List<int> bytes = [];
  List<int> kotBytes = [];

  counter() async {

    for(int i=count;i>0;i--){
      await Future.delayed(const Duration(seconds: 1));
      if(i==5){

        final CapabilityProfile profile = await CapabilityProfile.load();
        final generator = Generator(PaperSize.mm80, profile);

        bytes=generator.beep(duration: PosBeepDuration.beep50ms,n:1 );
        flutterUsbPrinter.write(Uint8List.fromList(bytes));
        bytes=[];
        i=count;
      }

    }
  }

  // int countVar=0;
  // counter() async {
  //
  //   for(countVar=count;countVar>0;countVar--){
  //       print("=====================================================$countVar");
  //     await Future.delayed(const Duration(seconds: 1));
  //     if(countVar==5){
  //       while(bytes.isNotEmpty){
  //         print("whilllllllllllllllllllllllllllllllllllllllllllllllllllllle");
  //         await Future.delayed(const Duration(seconds:2));
  //       }
  //       final CapabilityProfile profile = await CapabilityProfile.load();
  //       final generator = Generator(PaperSize.mm80, profile);
  //
  //       bytes=generator.beep(duration: PosBeepDuration.beep50ms,n:1 );
  //       flutterUsbPrinter.write(Uint8List.fromList(bytes));
  //       bytes=[];
  //       countVar=count;
  //     }
  //
  //   }
  // }
List previousItems=[];
@override
  void deactivate() {
  print("deactivate");
  // countVar=0;
    super.deactivate();
  }
  @override
  void dispose() {
    print("disposeeeeeeeee");

    super.dispose();
  }
  // ScreenshotController screenshotController = ScreenshotController();
  qr(String vatTotal1, String grantTotal) {
    // seller name
    String sellerName = 'Boofiya Faraula';
    String vat_registration = '$vatNumber';
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
    List<int> date = utf8.encode(DateTime.now().toString().substring(0,16));
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
    const Base64Encoder base64encoder = Base64Encoder();
    return base64encoder.convert(qrCodeAsBytes);
  }

  abc(int invNo,double discount,List items,int token,String selectedTable,double deliveryAmount,double pc,double pb,double bal) async {
try {
  print("abc start");
  print(DateTime.now());


  final CapabilityProfile profile = await CapabilityProfile.load(name: "TP806L");
  const PaperSize paper1 = PaperSize.mm80;
  var profile1 = await CapabilityProfile.load();
  var printer1 = NetworkPrinter(paper1, profile1);
  print(DateTime.now());
  final generator = Generator(PaperSize.mm80, profile);
  bytes = [];
  kotBytes = [];


  final Uint8List imgBytes = data.buffer.asUint8List();
  final im.Image image = im.decodeImage(imgBytes);
  bytes += generator.image(image);
  bytes += generator.feed(2);

  print(DateTime.now());

  final im.Image image1 = im.decodeImage(capturedImage1);
  print("here");

  bytes += generator.image(image1,);

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
            children: [
              Text('Order Type', style: TextStyle(color: Colors.black, fontSize: fontSize + 2, fontWeight: FontWeight.w600),),
              Text(dropdownvalue, style: TextStyle(color: Colors.black, fontSize: fontSize, fontWeight: FontWeight.w600),),

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
  ));

  final im.Image image10 = im.decodeImage(capturedImage10);
  bytes += generator.image(image10);


  bytes +=generator.text("-------------------------------------------",styles: PosStyles(bold: true,align: PosAlign.center,height: PosTextSize.size2,));
  bytes +=generator.text("TOKEN NUMBER : $token",styles: PosStyles(bold: true,align: PosAlign.center,height: PosTextSize.size2,width: PosTextSize.size2));
  bytes +=generator.text("-------------------------------------------",styles: PosStyles(bold: true,align: PosAlign.center,height: PosTextSize.size2,));


  print(DateTime.now());

  final im.Image imagehead = im.decodeImage(capturedhead);
  bytes += generator.image(imagehead,);


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
  List<Widget> itemWidgets = [];
  List<Widget> itemWidgets1 = [];
  for (Map<String, dynamic> item in items) {
    addOnPrice = item['addOnPrice'];
    double total = (double.tryParse(item['price'].toString()) + addOnPrice) * double.tryParse(item['qty'].toString());
    double grossTotal = total * 100 / 115;
    double vat = (double.tryParse(item['price'].toString()) + addOnPrice) * 15 / 115;
    newAddOn = item['addOns'];
    arabic = item['arabicName'];
    english = item['pdtname'];


    grantTotal += total;

    deliveryCharge = item['deliveryCharge'] == null ? 0 : double.tryParse(item['deliveryCharge'].toString());
    newAddOn = item['addOns'];
    newAddOnArabic = item['addOnArabic'];
    addOnArabic = newAddOnArabic.isEmpty ? '' : newAddOnArabic.toString();
    addON = newAddOn.isEmpty ? '' : newAddOn.toString();
    double price = (double.tryParse(item['price'].toString()) + addOnPrice) * 100 / 115;
    totalAmount += price * double.tryParse(item['qty'].toString());
    itemTotal += (totalAmount * ((100 + gst) / 100) - (double.tryParse(discount.toString()) ?? 0)).toStringAsFixed(2);
    itemGrossTotal += grossTotal.toStringAsFixed(2);
    itemTax += (totalAmount * gst / 100).toStringAsFixed(2);
  }


  for(im.Image a in imageList){
    bytes += generator.image(a);
  }



  itemWidgets.add(
      Column(
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
                Text('${deliveryAmount.toStringAsFixed(2)}',style:  TextStyle(color: Colors.black,fontSize: fontSize+4,fontWeight: FontWeight.w600),),
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
                Text((discount == null ? "0.00" : (discount).toStringAsFixed(2)), style: TextStyle(color: Colors.black, fontSize: fontSize+4, fontWeight: FontWeight.w600),),

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
                Text((grantTotal-(double.tryParse(discount.toString())??0)+(deliveryAmount??0)).toStringAsFixed(2) ,style:  TextStyle(color: Colors.black,fontSize: fontSize+7,fontWeight: FontWeight.w700),),
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
      )
  );


  String qrVat = (totalAmount * gst / 100).toStringAsFixed(2);
  String qrTotal = (grantTotal - (double.tryParse(discount.toString()) ?? 0) +
      (deliveryAmount ?? 0)).toStringAsFixed(2);

  itemWidgets.add(
      Container(
        color: Colors.white,
        width: printWidth * 2.4,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            QrImage(
              data: qr(qrVat, qrTotal),
              version: 6,
              size: size / 1.5,
            ),
          ],
        ),
      )
  );


  bytes += generator.drawer(pin: PosDrawer.pin2);

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
  print(DateTime.now());

  final im.Image image2 = im.decodeImage(capturedImage2);
  bytes += generator.image(image2);
  final im.Image footerImage1 = im.decodeImage(footerImage);
  bytes += generator.image(footerImage1);
  bytes += generator.feed(2);
  bytes += generator.cut();

  print('kot ********************************');
  try {
    List categories = [];
    for (Map<String, dynamic> item in items) {

      if (!categories.contains(item['category'])) {
        categories.add(item['category']);
      }
    }

    Map<String, dynamic> printerMap = {};
    for (var category in categories) {
      if(category!="Beverage") {
        String printerID = allCategories[category]['printer'];


        if (printerMap[printerID] == null) {
          printerMap[printerID] = [category];
        } else {
          printerMap[printerID].add(category);
        }
      }
    }
    for (var printerID in printerMap.keys.toList()) {

      kotPrinter = printers[printerID]['type'];
      List categoryLists = printerMap[printerID];
       if (kotPrinter == 0) {
         bytes += generator.feed(4);
        bytes += generator.text('Token No : ' + token.toString(),
            styles: const PosStyles(align: PosAlign.center,height: PosTextSize.size2,width: PosTextSize.size2,));
         bytes += generator.feed(1);
        bytes += generator.text(
            'Date : ' + DateTime.now().toString().substring(0, 16),
            styles: const PosStyles(align: PosAlign.center,height: PosTextSize.size1,width: PosTextSize.size2));
         bytes += generator.feed(1);
        bytes += generator.text('Invoice No : ' + invNo.toString(),
            styles: const PosStyles(align: PosAlign.center,height: PosTextSize.size1,width: PosTextSize.size2));
         bytes += generator.feed(2);


        for (Map<String, dynamic> item in items) {
          if (categoryLists.contains(item['category'])) {
            newAddOn = item['addOns'];
            newAddOnArabic = item['addOnArabic'];
            addON = newAddOn.isEmpty ? '' : newAddOn.toString();
            bytes += generator.text("${int.tryParse(item['qty']
                .toString())} x ${item['pdtname']} $addON",styles: const PosStyles(height: PosTextSize.size1,width: PosTextSize.size2));
            bytes += generator.feed(1);
          }
        }
        bytes += generator.feed(2);
        bytes += generator.cut();
      }
    }
    try {
      bool printSuccess = false;
      int i = 0;
      while (!printSuccess && i < 5) {
        printSuccess = await flutterUsbPrinter.write(Uint8List.fromList(bytes));

        i++;
        if (!printSuccess) {
          final snackBar = SnackBar(
            content: const Text('print not success'),
            action: SnackBarAction(
              label: 'Undo',
              onPressed: () {
                // Some code to undo the change.
              },
            ),
          );
          await _getDevicelist();
          await Future.delayed(Duration(milliseconds: 200));
        }
        else{
          print("end");
          print(DateTime.now());
        }
      }
      for (var printerID in printerMap.keys.toList()) {

        kotPrinter = printers[printerID]['type'];
        List categoryLists = printerMap[printerID];
        if (kotPrinter == 1) {

          String ip = printers[printerID]['ip'];
          int port = printers[printerID]['port'];

          try {
            PosPrintResult res = await printer1.connect(
                ip, port: port, timeout: const Duration(seconds: 10));
            int j=0;
            while (res != PosPrintResult.success && j<5 ) {
              res = await printer1.connect(
                  ip, port: port, timeout: const Duration(seconds: 2));
              j++;
            }
            if (res == PosPrintResult.success) {
              printer1.feed(4);
              printer1.text('Token No : ' + token.toString(),
                  styles: const PosStyles(align: PosAlign.center,height: PosTextSize.size2,width: PosTextSize.size2));
              printer1.feed(1);
              printer1.text(
                  'Date : ' + DateTime.now().toString().substring(0, 16),
                  styles: const PosStyles(align: PosAlign.center,height: PosTextSize.size1,width: PosTextSize.size2));
              printer1.feed(1);
              printer1.text('Invoice No : ' + invNo.toString(),
                  styles: const PosStyles(align: PosAlign.center,height: PosTextSize.size1,width: PosTextSize.size2));
              printer1.feed(4);


              for (Map<String, dynamic> item in items) {
                if (categoryLists.contains(item['category'])) {
                  newAddOn = item['addOns'];
                  newAddOnArabic = item['addOnArabic'];
                  addON = newAddOn.isEmpty ? '' : newAddOn.toString();
                  printer1.text("${int.tryParse(item['qty']
                      .toString())} x ${item['pdtname']} $addON",styles: const PosStyles(height: PosTextSize.size1,width: PosTextSize.size2));
                  printer1.feed(1);
                }
              }

              if (lastCut == true) {
                printer1.feed(4);
                printer1.cut();
                printer1.disconnect(delayMs: 10);
              }
            } else {
              print(res.msg);
              print("no printer found");
            }
          } catch (e) {
            print("button catch");
            print(e.toString());
          }
        }


      }
    }
    catch (ex) {
      print("usb exceptionnnnnnnnnnnnnnnnnn");
      print(ex.toString());
      await await flutterUsbPrinter.write(Uint8List.fromList(bytes));
    }

  }
  catch (error) {
    print(error.toString(),);
  }
  print("end");

}catch(e){
  print("error occuredddddddddddddddddd");
  print(e.toString());
}
  }

  _connect(int vendorId, int productId) async {
    bool returned;
    try {
      returned = await flutterUsbPrinter.connect(vendorId, productId);
    } on PlatformException {
    }
    if (returned) {
      setState(() {
        connected = true;
      });
    }
  }



  getAlert(){
    FirebaseFirestore.instance.collection('orders')
        .where('branchId',isEqualTo: currentBranchId)
        .orderBy('salesDate',descending: true)
        .where('status',isEqualTo: 0)
        .snapshots()
        .listen((event) {
          if(event.docs.isNotEmpty){
            // print('mmm');
            for(var doc in event.docs){
             if(doc.get('orderId')!=null&&doc.get('status')==0){
               showDialog(
                 context: context,
                 builder: (ctx) => AlertDialog(
                   shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(10),
                   ),
                   title:  Text('Online Order'),
                   content: Container(
                     height: MediaQuery.of(context).size.width*0.09,
                     padding: EdgeInsets.all(8),
                     child: Column(
                       mainAxisAlignment: MainAxisAlignment.spaceAround,
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Text("You have received a new order",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17
                            ),),
                          ),
                          Text("OrederId :${(doc.get('orderId'))}"),
                          Text("Customer Name :${(doc.get('name'))}"),
                       ],
                     ),
                   ),
                   actions: <Widget>[
                     TextButton(
                       onPressed: () {
                         Navigator.of(ctx).pop();
                         Navigator.push(context,MaterialPageRoute(builder: (context)=>OrderConfirmWidget(
                             orderId:doc.get('orderId'))));

                       },
                       child: Container(
                         decoration: BoxDecoration(
                             color: default_color,
                           borderRadius: BorderRadius.circular(7)
                         ),
                         padding: const EdgeInsets.all(14),
                         child: const Text("view",style: TextStyle(
                           color: Colors.white,
                         ),),
                       ),
                     ),
                   ],
                 ),
               );
             }
            }
          }
    });
  }
//   var capturedImage1;
//   var capturedhead;
//   var footerImage;
//   var itemImage;
//   List<im.Image> imageList=[];
//   setPrinterImages() async {
//     while(printWidth==0){
//       await Future.delayed(Duration(seconds: 1));
//     }
//    capturedImage1= await    screenshotController
//       .captureFromWidget(Container(
//   color: Colors.white,
//   width: printWidth*3,
//   child: ListView(
//
//   shrinkWrap: true,
//   // physics: NeverScrollableScrollPhysics(),
//   children:[
//   Row(
//   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//   children: [
//   Text(currentBranchArabic,style:  TextStyle(fontFamily:'GE Dinar One Medium',color: Colors.black, fontSize: fontSize+2,fontWeight: FontWeight.w600),),
//   Text(" : اسم الفرع",style:  TextStyle(fontFamily:'GE Dinar One Medium',color: Colors.black, fontSize: fontSize+2,fontWeight: FontWeight.w600),),
//   ],
//   ),
//   Row(
//   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//   children: [
//   Text("Branch Name:",style:  TextStyle(fontFamily:'GE Dinar One Medium',color: Colors.black, fontSize: fontSize+2,fontWeight: FontWeight.w600),),
//   Text(currentBranchAddress,style:  TextStyle(fontFamily:'GE Dinar One Medium',color: Colors.black, fontSize: fontSize+2,fontWeight: FontWeight.w600),),
//   ],
//   ),
//
//   Row(
//   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//   children: [
//   Text('Contact No: ', style: TextStyle(color: Colors.black, fontSize: fontSize + 2, fontWeight: FontWeight.w600),),
//   Text('$currentBranchPhNo ', style: TextStyle(color: Colors.black, fontSize: fontSize, fontWeight: FontWeight.w600),),
//
//   ],
//   ),
//   Row(
//   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//   children:  [
//   Text('Vat No:',style: TextStyle(color: Colors.black,fontSize: fontSize+2,fontWeight: FontWeight.w600),),
//   Text('311202993300003',style: TextStyle(color: Colors.black,fontSize: fontSize,fontWeight: FontWeight.w600),),
//   ],),
//
//
//   ]
//   ),
//   )
//   );
//     capturedhead = await screenshotController
//        .captureFromWidget(Container(
//      color: Colors.white,
//      width: printWidth * 3,
//      height: 85,
//      padding: const EdgeInsets.only(top: 4),
//      child: Column(
//        children: [
//          Row(
//            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//            children: [
//              //pdt
//              Expanded(
//                child: Column(
//                  crossAxisAlignment: CrossAxisAlignment.start,
//                  children: [
//                    Text('منتج',
//                      style: TextStyle(
//                        fontFamily: 'GE Dinar One Medium',
//                        fontSize: fontSize,
//                        fontWeight: FontWeight.w600,
//                        color: Colors.black,
//                      ),
//                    ),
//                    Text('Product',
//                      style: TextStyle(
//                          color: Colors.black,
//                          fontFamily: 'GE Dinar One Medium',
//                          fontSize: fontSize,
//                          fontWeight: FontWeight.w600),
//                    ),
//
//                  ],
//                ),
//              ),
//              Container(
//                width: 45,
//                child: Column(
//                  crossAxisAlignment: CrossAxisAlignment.start,
//                  children: [
//                    Text('كمية',
//                      style: TextStyle(
//                          fontFamily: 'GE Dinar One Medium',
//                          color: Colors.black,
//                          fontSize: fontSize,
//                          fontWeight: FontWeight.w600),
//                    ),
//                    Text('Qty',
//                      style: TextStyle(
//                          fontFamily: 'GE Dinar One Medium',
//                          color: Colors.black,
//                          fontSize: fontSize,
//                          fontWeight: FontWeight.w600),
//                    ),
//
//                  ],
//                ),
//              ),
//              Container(
//                width: 45,
//                child: Column(
//                  crossAxisAlignment: CrossAxisAlignment.start,
//                  children: [
//                    Text('سعر',
//                      style: TextStyle(
//                          fontFamily: 'GE Dinar One Medium',
//                          color: Colors.black,
//                          fontSize: fontSize,
//                          fontWeight: FontWeight.w600),
//                    ),
//                    Text('Rate',
//                      style: TextStyle(
//                          fontFamily: 'GE Dinar One Medium',
//                          color: Colors.black,
//                          fontSize: fontSize,
//                          fontWeight: FontWeight.w600),
//                    ),
//
//                  ],
//                ),
//              ),
//              Container(
//                width: 45,
//                child: Column(
//                  crossAxisAlignment: CrossAxisAlignment.start,
//                  children: [
//                    Text('ضريبة',
//                      style: TextStyle(
//                          fontFamily: 'GE Dinar One Medium',
//                          color: Colors.black,
//                          fontSize: fontSize,
//                          fontWeight: FontWeight.w600),
//                    ),
//                    Text('vat',
//                      style: TextStyle(
//                          fontFamily: 'GE Dinar One Medium',
//                          color: Colors.black,
//                          fontSize: fontSize,
//                          fontWeight: FontWeight.w600),
//                    ),
//
//                  ],
//                ),
//              ),
//              Container(
//                width: 50,
//                child: Column(
//                  crossAxisAlignment: CrossAxisAlignment.start,
//                  children: [
//                    Text('المجموع',
//                      style: TextStyle(
//                          fontFamily: 'GE Dinar One Medium',
//                          color: Colors.black,
//                          fontSize: fontSize,
//                          fontWeight: FontWeight.w600),
//                    ),
//                    Text('Total',
//                      style: TextStyle(
//                          fontFamily: 'GE Dinar One Medium',
//                          color: Colors.black,
//                          fontSize: fontSize,
//                          fontWeight: FontWeight.w600),
//                    ),
//
//                  ],
//                ),
//              ),
//
//            ],
//          ),
//          Container(
//              decoration: const BoxDecoration(
//                color: Colors.white,
//              ),
//              child:  Center(child: Text('-------------------------------------------',
//                style: TextStyle(color: Colors.black,fontSize: printWidth*.25),))
//          ),
//        ],
//      ),
//    ));
//     while(PosUserIdToArabicName[currentUserId]==null){
//       await Future.delayed(Duration(seconds: 1));
//     }
//     print("finished");
//    footerImage=await screenshotController
//        .captureFromWidget(Container(
//      width: printWidth * 3,
//      height: printWidth * 2,
//      color: Colors.white,
//      child: Row(
//        mainAxisAlignment: MainAxisAlignment.center,
//        children: [
//          Column(
//            children: [
//              SizedBox(height: 8,),
//              Text('${PosUserIdToArabicName[currentUserId]}: المحاسب  ',
//                style: TextStyle(color: Colors.black,
//                  fontSize: fontSize + 2,
//                  fontWeight: FontWeight.bold,),),
//              Text('Cashier : ${PosUserIdToName[currentUserId]}',
//                style: TextStyle(color: Colors.black,
//                    fontSize: fontSize,
//                    fontWeight: FontWeight.bold),),
//
//              SizedBox(height: 8,),
//              Text('شكرًا لزيارتك ونتشوق لرؤيتك مرة أخرى', style: TextStyle(
//                  fontFamily: 'GE Dinar One Medium',
//                  color: Colors.black,
//                  fontSize: fontSize + 3,
//                  fontWeight: FontWeight.w600),),
//              Text('THANK YOU VISIT AGAIN', style: TextStyle(
//                  fontFamily: 'GE Dinar One Medium',
//                  color: Colors.black,
//                  fontSize: fontSize + 3,
//                  fontWeight: FontWeight.w600),),
//            ],
//          ),
//        ],
//      ),
//    ));
// }
//   bool working=false;
//   setItemWidgets(List items) async {
//
//     while(working){
//
//       await Future.delayed(const Duration(milliseconds: 300));
//     }
//     print("starrrrrrrrrrrrrrrrrrrrt");
//     print(DateTime.now());
//     working=true;
//
//     List itemWidgets1=[];
//     imageList=[];
//
//     for (Map<String, dynamic> item in items) {
//       double addOnPrice = item['addOnPrice'];
//       double total = (double.tryParse(item['price'].toString()) + addOnPrice) *
//           double.tryParse(item['qty'].toString());
//       double grossTotal = total * 100 / 115;
//       double vat = (double.tryParse(item['price'].toString()) + addOnPrice) * 15 /
//           115;
//       List newAddOn = item['addOns'];
//       String arabic = item['arabicName'];
//       String english = item['pdtname'];
//
//
//
//       newAddOn = item['addOns'];
//       newAddOnArabic = item['addOnArabic'];
//       String addOnArabic = newAddOnArabic.isEmpty ? '' : newAddOnArabic.toString();
//       String addON = newAddOn.isEmpty ? '' : newAddOn.toString();
//       double price = (double.tryParse(item['price'].toString()) + addOnPrice) *
//           100 / 115;
//
//       itemWidgets1.add(
//           Container(
//               width: printWidth * 3,
//               padding: const EdgeInsets.all(1.0),
//               decoration: const BoxDecoration(
//                 color: Colors.white,
//               ),
//
//               child: ListView(
//                   shrinkWrap: true,
//                   children: [
//                     Container(
//                       width: printWidth*3,
//                       child: Column(
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//
//                             children: [
//                               Expanded(
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text('$arabic $addOnArabic',
//                                       // textDirection: TextDirection.rtl,
//                                       style:  TextStyle(
//                                         fontFamily: 'GE Dinar One Medium',
//                                         fontSize: 17,
//                                         fontWeight: FontWeight.w600,
//                                         color: Colors.black,
//                                       ),
//                                     ),
//                                     Text('$english $addON',
//                                       // textDirection: TextDirection.rtl,
//                                       style:  TextStyle(
//                                         fontFamily: 'GE Dinar One Medium',
//                                         fontSize: fontSize,
//                                         fontWeight: FontWeight.w600,
//                                         color: Colors.black,
//                                       ),
//                                     ),
//
//                                   ],
//                                 ),
//                               ),
//
//
//                               Container(
//                                 width: 45,
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     // Text('${arabicNumber.convert(double.tryParse(item['qty'].toString()).toStringAsFixed(2))}',
//                                     //   style:  TextStyle(
//                                     //       fontFamily: 'GE Dinar One Medium',
//                                     //       color: Colors.black,
//                                     //       fontSize: fontSize+2,
//                                     //       fontWeight: FontWeight.w600),
//                                     // ),
//                                     Text('${double.tryParse(item['qty'].toString())}',
//                                       style:  TextStyle(
//                                           fontFamily: 'GE Dinar One Medium',
//                                           color: Colors.black,
//                                           fontSize: fontSize,
//                                           fontWeight: FontWeight.w600),
//                                     ),
//
//                                   ],
//                                 ),
//                               ),
//                               Container(
//                                 width: 45,
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     // Text('${arabicNumber.convert(price.toStringAsFixed(2))} ',
//                                     //   style:  TextStyle(
//                                     //       fontFamily: 'GE Dinar One Medium',
//                                     //       color: Colors.black,
//                                     //       fontSize: fontSize+2,
//                                     //       fontWeight: FontWeight.w600),
//                                     // ),
//                                     Text('${price.toStringAsFixed(2)} ',
//                                       style:  TextStyle(
//                                           fontFamily: 'GE Dinar One Medium',
//                                           color: Colors.black,
//                                           fontSize: fontSize,
//                                           fontWeight: FontWeight.w600),
//                                     ),
//
//                                   ],
//                                 ),
//                               ),
//                               Container(
//                                 width: 45,
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     // Text('${arabicNumber.convert(vat.toStringAsFixed(2))}',
//                                     //   style:  TextStyle(
//                                     //       fontFamily: 'GE Dinar One Medium',
//                                     //       color: Colors.black,
//                                     //       fontSize: fontSize+2,
//                                     //       fontWeight: FontWeight.w600),
//                                     // ),
//                                     Text('${vat.toStringAsFixed(2)}',
//                                       style:  TextStyle(
//                                           fontFamily: 'GE Dinar One Medium',
//                                           color: Colors.black,
//                                           fontSize: fontSize,
//                                           fontWeight: FontWeight.w600),
//                                     ),
//
//                                   ],
//                                 ),
//                               ),
//                               Container(
//                                 width: 50,
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     // Text('${arabicNumber.convert(total.toStringAsFixed(2))}',
//                                     //   style:  TextStyle(
//                                     //       fontFamily: 'GE Dinar One Medium',
//                                     //       color: Colors.black,
//                                     //       fontSize: fontSize+2,
//                                     //       fontWeight: FontWeight.w600),
//                                     // ),
//                                     Text('${total.toStringAsFixed(2)}',
//                                       style:  TextStyle(
//                                           fontFamily: 'GE Dinar One Medium',
//                                           color: Colors.black,
//                                           fontSize: fontSize,
//                                           fontWeight: FontWeight.w600),
//                                     ),
//
//                                   ],
//                                 ),
//                               ),
//
//
//                             ],
//                           ),
//                           SizedBox(height:10)
//                         ],
//                       ),
//                     ),
//                     // Text("${item['pdtname']} $addON",
//                     //   textDirection: TextDirection.ltr,
//                     //   style: const TextStyle(
//                     //     fontSize: 14,
//                     //     color: Colors.black,
//                     //   ),
//                     // ),
//
//                   ]
//               )));
//       if (itemWidgets1.length == itemCount) {
//         itemImage = await screenshotController
//             .captureFromWidget(Container(
//           width: printWidth * 3,
//
//           child: ListView.builder(
//               shrinkWrap: true,
//               itemCount: itemWidgets1.length,
//               itemBuilder: (context, index) {
//                 return itemWidgets1[index];
//               }),
//         ));
//
//         final im.Image image22 = im.decodeImage(itemImage);
//         imageList.add(image22);
//         itemWidgets1 = [];
//       }
//
//
//
//     }
//     if (itemWidgets1.isNotEmpty) {
//       var capturedIm = await screenshotController
//           .captureFromWidget(Container(
//         width: printWidth * 3,
//
//         child: ListView.builder(
//             shrinkWrap: true,
//             itemCount: itemWidgets1.length,
//             itemBuilder: (context, index) {
//               return itemWidgets1[index];
//             }),
//       ));
//
//       final im.Image image22 = im.decodeImage(capturedIm);
//       imageList.add(image22);
//
//       itemWidgets1 = [];
//     }
//     working=false;
//     print("endddddddddddddddddddddddddddddddddddddddddddd");
//     print(DateTime.now());
//   }
  @override
  void initState() {
    dropdownvalue="Dine-In";
    setPrinterImages();
    super.initState();
    getPosUser();
    print("currentBranchId");
    print(currentBranchId);
            // updateSales();
     // updateTable();
    getTables();
    getPrinters();
    getAllCategories();
     getToken();
    counter();
    getSettings();
    _getDevicelist();
    bluetooth = BlueThermalPrinter.instance;
    initPlatformState();
    initSavetoPath();
    discountController = TextEditingController();
    deliveryCharge = TextEditingController();
    paidCash = TextEditingController(text: '');
    paidBank = TextEditingController(text: '');
    tableController = TextEditingController();
    getAlert();

  }
  getPrinters(){
    FirebaseFirestore.instance.collection('printer')
        .where("branchId",isEqualTo: currentBranchId).
    where("available",isEqualTo: true).
    get().then((value){
      for(DocumentSnapshot<Map<String,dynamic>> printer in value.docs){
        printers[printer.id]=printer.data();
      }
    });
  }
  getAllCategories(){
    FirebaseFirestore.instance.collection('category').where("branchId",isEqualTo:currentBranchId).get().then((value){
      for(DocumentSnapshot<Map<String,dynamic>> category in value.docs){
        allCategories[category['name']]=category.data();
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

  getSettings() async {
    FirebaseFirestore.instance
        .collection('settings')
        .snapshots()
        .listen((value) {
      var data = value.docs;
      printWidth = double.tryParse(data[0]['logo']);
      qrCode = double.tryParse(data[0]['qr']);
      lastCut=data[0]['lastCut'];

      fontSize = double.tryParse(data[0]['fontSize']);
      size = double.tryParse(data[0]['size']);
      products = data[0]['product'];
      itemCount=data[0]['itemCount'];
      display_image=data[0]['display_image'];
      kotPrinter=data[0]['kotPrinter'];
      setState(() {
        // print(products);
        // print(display_image);
      });
    });
  }
  int token=0;

  getToken() async {
    FirebaseFirestore.instance
        .collection('invoiceNo').doc(currentBranchId)
        .snapshots()
        .listen((value) {
      // var token = value.get('token');
      token=value.get('token');

if(mounted)
      setState(() {
        // print(token);
      });
    });
  }
  initSavetoPath() async {
    //read and write
    //image max 300px X 300px
    const filename = 'faraula_hida.png';
    const filename1 = 'print.png';
    var bytes = await rootBundle.load("assets/faraula_hida.png");
    var bytes1= await rootBundle.load("assets/awafi/print.png");
    String dir = (await getApplicationDocumentsDirectory()).path;
    writeToFile(bytes, '$dir/$filename');
    writeToFile(bytes1, '$dir/$filename1');
    setState(() {
      topImage = '$dir/$filename';
      heading = '$dir/$filename1';
    });
  }
  Future<File> writeToFile(ByteData data, String path) {
    final buffer = data.buffer;
    return File(path).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }

  Future<void> initPlatformState() async {
    List<BluetoothDevice> devices = [];

    try {
      devices = await bluetooth.getBondedDevices();
    } on PlatformException {
      // TODO - Error
    }
    bluetooth.onStateChanged().listen((state) {
      print("connect");
      switch (state) {
        case BlueThermalPrinter.CONNECTED:
          setState(() {
            _connected = true;
            _pressed = false;
          });
          break;
        case BlueThermalPrinter.DISCONNECTED:
          setState(() {
            _connected = false;
            _pressed = false;
          });
          break;
        default:
          break;
      }
    });

    if (!mounted) return;
    setState(() {
      btDevices = devices;
    });
  }

  getTables() async {
    FirebaseFirestore.instance.collection('tables')
        .doc(currentBranchId)
        .collection('tables')
        .orderBy('tableNo',descending:false)
        .snapshots().listen((event) {
      tables = [];
      for (DocumentSnapshot doc in event.docs) {
        tables.add(doc.get('name'));
      }
      // selectedTable = tables[0];
      if(mounted){
        setState(() {

        });
      }

    });
  }


  List<DropdownMenuItem<BluetoothDevice>> _getDeviceItems() {
    List<DropdownMenuItem<BluetoothDevice>> items = [];
    if (btDevices.isEmpty) {
      print('             BLUETHOOTH DEVICES                   NO');
      items.add(const DropdownMenuItem(
        child: Text('NONE'),
      ));
    } else {
      print('             BLUETHOOTH DEVICES                   BLU');
      btDevices.forEach((device) {
        items.add(DropdownMenuItem(
          child: Text(device.name),
          value: device,
        ));
      });
    }
    return items;
  }
  Future show(
      String message, {
        Duration duration: const Duration(seconds: 3),
      }) async {
    await  Future.delayed( const Duration(milliseconds: 100));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content:  Text(
          message,
          style:  const TextStyle(
            color: Colors.white,
          ),
        ),
        duration: duration,
      ),
    );
  }
  void btConnect() {

    if (device == null) {
      show('No device selected.');
    } else {
      bluetooth.isConnected.then((isConnected) {
        // print("here");
        if (!isConnected) {
          bluetooth.connect(device).catchError((error) {
            print(error);
            setState((){pressed = false;
            connected=false;
            });
          });
          setState((){pressed = true;
          connected=true;
          });
        }
        else{
          setState((){pressed = true;
          connected=true;
          });
        }
        Navigator.pop(context);

      }
      );
    }
  }
  void _disconnect() {
    bluetooth.disconnect();
    setState(() => pressed = true);
    
  }
set(){
    setState(() {
      
    });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(

          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
            child: Column(
              children: [
                Container(
                  height: 170,
                  color: default_color,
                  padding: const EdgeInsets.all(10),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height:20),
                        Text(
                          currentBranchName,
                          style: const TextStyle(
                              fontSize: 20,
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10,),
                        Text(
                          "${PosUserIdToName[currentUserId]}",
                          style: TextStyle(color: Colors.white),
                        ),


                        //image close
                        Container(
                          child: SwitchListTile.adaptive(
                            value: display_image ??= true,
                            onChanged: (newValue) async {
                              setState(()  {
                                display_image = newValue;
                                // print(display_image.toString()+" bbbdndb");

                                FirebaseFirestore.instance
                                    .collection('settings')
                                    .doc('settings')
                                    .update({
                                  "display_image":display_image,
                                });

                              }

                              );

                            },
                            title: Text(
                              'Image',
                              style: FlutterFlowTheme.title3.override(
                                fontFamily: 'Lexend Deca',
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            tileColor:Colors.grey,
                            inactiveTrackColor: Colors.grey.shade100,
                            activeColor: Colors.green,
                            activeTrackColor: Colors.yellow,
                            dense: true,
                            controlAffinity: ListTileControlAffinity.leading,
                            contentPadding: EdgeInsetsDirectional.fromSTEB(24, 12, 24, 12),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),

                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  const history_View_Widget()),
                    );
                  },
                  child: Container(
                      padding: const EdgeInsets.only(right: 10),
                      width: double.infinity,
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                      ),
                      child:  Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: Text(
                          'HISTORY',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: default_color,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Expenses()),
                    );
                  },
                  child: Container(
                      padding: const EdgeInsets.only(right: 10),
                      width: double.infinity,
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                      ),
                      child:  Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: Text(
                          'ADD EXPENSE',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: default_color,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Purchases()),
                    );
                  },
                  child: Container(
                      padding: const EdgeInsets.only(right: 10),
                      width: double.infinity,
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                      ),
                      child:  Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: Text(
                          'ADD PURCHASE',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: default_color,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )),
                ),

                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SalesReport()),
                    );
                  },
                  child: Container(
                      padding: const EdgeInsets.only(right: 10),
                      width: double.infinity,
                      height: 45,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child:  Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: Text(
                          'SALES REPORT',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: default_color,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SalesReturnReport()),
                    );
                  },
                  child: Container(
                      padding: const EdgeInsets.only(right: 10),
                      width: double.infinity,
                      height: 45,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: Text(
                          'RETURN REPORT',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: default_color,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )),
                ),

                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ExpenseReport()),
                    );
                  },
                  child: Container(
                      padding: const EdgeInsets.only(right: 10),
                      width: double.infinity,
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                      ),
                      child:  Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: Text(
                          'EXPENSE REPORT',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: default_color,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PurchaseReport()),
                    );
                  },
                  child: Container(
                      padding: const EdgeInsets.only(right: 10),
                      width: double.infinity,
                      height: 45,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: Text(
                          'PURCHASE REPORTS',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: default_color,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DailyReportsWidget()),
                    );
                  },
                  child: Container(
                      padding: const EdgeInsets.only(right: 10),
                      width: double.infinity,
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                      ),
                      child: Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: Text(
                          'DAILY REPORTS',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: default_color,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )),
                ),


                InkWell(
                  onTap: () async {
                    await signOut();
                    await Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Login(),
                      ),
                          (r) => false,
                    );
                  },
                  child: Container(
                      padding: const EdgeInsets.only(right: 10),
                      width: double.infinity,
                      margin: const EdgeInsets.only(top: 50),
                      height: 45,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children:[
                            Icon(
                              Icons.logout,
                              color: Colors.black,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Log out',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: default_color,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          ],
                        ),
                      )),
                ),
              ],
            )),
        body:
        // !connected?AlertDialog(
        //
        //   content: Column(
        //     mainAxisSize: MainAxisSize.min,
        //     children: <Widget>[
        //       Row(
        //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //         children: <Widget>[
        //           const Text(
        //             'Device:',
        //             style: TextStyle(
        //               fontWeight: FontWeight.bold,
        //             ),
        //           ),
        //           DropdownButton(
        //             items: _getDeviceItems(),
        //             onChanged: (value) => setState(() => device = value),
        //             value: device,
        //           ),
        //           RaisedButton(
        //             onPressed:
        //             pressed ? null : connected ? _disconnect : btConnect,
        //             child: Text(connected ? 'Disconnect' : 'Connect'),
        //           ),
        //
        //         ],
        //       ),
        //       RaisedButton(
        //         onPressed:() async {
        //           if(connected ){
        //
        //
        //           }else{
        //
        //           }
        //         },
        //         child: const Text('Print'),
        //       ),
        //
        //     ],
        //   ),
        // ):
        Builder(
          builder: (context) => Row(
            children: [

              Container(
                width: MediaQuery.of(context).size.width * 0.08,
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.05),
                color: Color(0xffBF0F1B),
                // decoration: BoxDecoration(
                //   image: DecorationImage(
                //     image: AssetImage("assets/awafi/coffeeAppBar1.jpg"),fit: BoxFit.cover
                //   )
                // ),
                child: Column(
                  children: [
                    IconButton(
                        onPressed: () => Scaffold.of(context).openDrawer(),
                        tooltip: MaterialLocalizations.of(context)
                            .openAppDrawerTooltip,
                        icon: const Icon(
                          Icons.menu,
                          color: Colors.white,
                          size: 30,
                        )),
                    SingleChildScrollView(
                      child: const SizedBox(
                        height: 20,
                      ),
                    ),
                    IconButton(
                        onPressed: () async {
                          Map<String, dynamic> items;

                          items = await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return StatefulBuilder(
                                    builder: (context, setState) {
                                      return AlertDialog(
                                        title: Container(
                                          padding: const EdgeInsets.only(
                                              left: 20, right: 20),
                                          height: 100,
                                          child: Column(
                                            children: [
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              const Text(
                                                "Add Token",
                                                style: TextStyle(fontSize: 12),
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              Expanded(
                                                child: Container(
                                                  padding: const EdgeInsets.all(3),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.circular(5),
                                                    color: Colors.black,
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        width: 200,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(3),
                                                            color: Colors.white),
                                                        child: Center(
                                                          child: TextFormField(

                                                            onEditingComplete: () {
                                                              FocusScope.of(context)
                                                                  .unfocus();

                                                              setState(() {
                                                                keyboard = false;
                                                              });
                                                            },
                                                            onTap: () {
                                                              setState(() {
                                                                keyboard = true;
                                                              });
                                                            },
                                                            controller:
                                                            tableController,
                                                            keyboardType:
                                                            TextInputType.number,
                                                            decoration:
                                                            InputDecoration(
                                                              labelText:
                                                              'Token No',
                                                              hoverColor:
                                                              default_color,
                                                              hintText:
                                                              'Token No',
                                                              border:
                                                              OutlineInputBorder(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    5.0),
                                                              ),
                                                              focusedBorder:
                                                              OutlineInputBorder(
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .pink
                                                                        .shade900,
                                                                    width: 1.0),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              FocusScope.of(context).unfocus();
                                              Navigator.pop(context,);
                                              keyboard = false;
                                            },
                                            child: const Text('Cancel'),
                                          ),
                                          TextButton(
                                            onPressed: () async {
                                              FocusScope.of(context).unfocus();
                                              keyboard = false;
                                              Navigator.pop(context,);
                                              await FirebaseFirestore.instance
                                                  .collection('tables')
                                                  .doc(currentBranchId)
                                                  .collection('tables')
                                                  .doc(tableController.text)
                                                  .set({
                                                'items': [],
                                                'name': tableController.text,
                                                'tableNo':int.parse(tableController.text),
                                              });

                                              // Navigator.pop(context, items);
                                            },
                                            child: const Text('Add'),
                                          ),
                                        ],
                                      );
                                    });
                              });
                        },
                        icon: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 30,
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: tables.length,
                          itemBuilder: (context, index) {
                            return Column(children: [
                              const SizedBox(
                                height: 10,
                              ),
                              InkWell(
                                onLongPress: ()async{
                                  QuerySnapshot doc=await FirebaseFirestore.instance.collection('tables')
                                      .doc(currentBranchId)
                                      .collection('tables')
                                      .where('name',isEqualTo: tables[index].toString())
                                      // .orderBy('tableNo',descending:true)
                                      .get();
                                  int tb=0;
                                  var data=doc.docs;

                                  // for(var item in doc.docs){
                                  //   int tableNo=int.tryParse(item['name']);
                                  //   tb=tb++;
                                  //   if(tb==tableNo){
                                  //     data.add(item);
                                  //   }
                                  // }
                                  // data.sort((a, b) {
                                  //   return b['name'].compareTo(a['name']);
                                  // });
                                  DocumentSnapshot docs=data[0];
                                  await docs.reference.delete();

                                  showUploadMessage(context, 'Table Deleted...');



                                },
                                child: Container(
                                  padding:
                                  const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: index == selectedTableIndex
                                          ? Colors.white
                                          : default_color,
                                      border: Border.all(
                                          color: Colors.white)),
                                  child: Center(
                                    child: Text(
                                      tables[index],
                                      style: TextStyle(
                                          color: index != selectedTableIndex
                                              ? Colors.white
                                              : default_color,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  selectedTable = tables[index];
                                  selectedTableIndex = index;

                                 if(mounted){
                                   setState(() {
                                     selectedTable = tables[index];

                                     selectedTableIndex = index;
                                   });
                                 }
                                },
                              ),
                            ]);
                          }),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(

                  child: Column(
                    children: [

                      //appbar
                      Container(
                        color: Color(0xffBF0F1B),
                        // decoration: BoxDecoration(
                        //     image: DecorationImage(
                        //         image: AssetImage("assets/awafi/coffeeappbar.jpg"),fit: BoxFit.cover
                        //     )
                        // ),
                        height: MediaQuery.of(context).size.height * 0.15,
                        padding: const EdgeInsets.only(right: 15, top: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height:70 ,
                                width:150,
                                decoration: BoxDecoration(

                                    borderRadius: BorderRadius.circular(6),
                                    color: Colors.blue,
                                    border: Border.all(color: Colors.grey)
                                ),
                                child: Center(
                                  child: DropdownButton(
                                    borderRadius: BorderRadius.circular(10),
                                    alignment: AlignmentDirectional.centerStart,
                                    underline: Column(),
                                    dropdownColor: Colors.black,
                                    iconEnabledColor: Colors.white,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500
                                    ),
                                    value: dropdownvalue,
                                    icon: const Icon(
                                      Icons.expand_more,

                                    ),
                                    items: abcd.map((String items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: Text(
                                          items,
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (String newValue) {
                                      dropdownvalue = newValue;
                                      dropdownvalue=="Drive-Thru" && (deliveryCharge.text.isEmpty || deliveryCharge.text=="0")? delivery=DelCharge.toStringAsFixed(2): delivery=deliveryCharge.text;
                                      if(mounted){
                                        setState(() {
                                         if(dropdownvalue=="Drive-Thru"){
                                         deliveryCharge.text=DelCharge.toString();
                                         }
                                        });
                                      }
                                    },
                                  ),
                                ),
                              ),

                            ),
                            // Padding(
                            //   padding: const EdgeInsets.all(8.0),
                            //   child: FFButtonWidget(
                            //     onPressed: () {
                            //       Navigator.push(context, MaterialPageRoute(builder: (context)=>const Live_Orders_Widget()));
                            //
                            //     },
                            //     text: 'Online Orders',
                            //     options: FFButtonOptions(
                            //       width: 150,
                            //       height: 70,
                            //       color: Colors.blue,
                            //       textStyle: FlutterFlowTheme.subtitle2.override(
                            //         fontFamily: 'Overpass',
                            //         color: Colors.white,
                            //         fontSize: 18,
                            //         fontWeight: FontWeight.w500,
                            //       ),
                            //       elevation: 10,
                            //       borderSide: const BorderSide(
                            //         color: Colors.grey,
                            //         width: 1,
                            //       ),
                            //       borderRadius: 12,
                            //     ),
                            //   ),
                            // ),
                            Expanded(
                              child: SwitchListTile.adaptive(
                                value: blue ??= true,
                                onChanged: (newValue) async {

                                  blue = newValue;

                                  if(blue&&!bluetoothConnected){
                                    if(_getDeviceItems().length==0){
                                      await   initPlatformState();
                                    }
                                    // print('aaaaaa');

                                    showDialog(context: context,
                                        builder: (alertDialogContext){

                                          return   AlertDialog(
                                            content: Container(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: <Widget>[
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: <Widget>[
                                                      Text(
                                                        'Device:',
                                                        style: TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                      DropdownButton(
                                                        items: _getDeviceItems(),
                                                        onChanged: (value) =>
                                                            setState(() => device = value),
                                                        value: device,
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                    children: [
                                                      ElevatedButton(
                                                        onPressed: () async {
                                                          blue=false;
                                                          bluetoothConnected=false;
                                                          pressed=false;
                                                          setState(() {


                                                          });
                                                          Navigator.pop(context);
                                                        },
                                                        child: Text('Reset'),
                                                      ),
                                                      ElevatedButton(
                                                        onPressed: pressed
                                                            ? null
                                                            : bluetoothConnected
                                                            ? _disconnect
                                                            : btConnect,

                                                        child: Text(bluetoothConnected ? 'Disconnect' : 'Connect'),
                                                      ),

                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        }
                                    );

                                  }

                                  setState(()  {
                                    blue = newValue;

                                  }

                                  );

                                },
                                title: Text(
                                  'Bluetooth',
                                  style: FlutterFlowTheme.title3.override(
                                    fontFamily: 'Lexend Deca',
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                tileColor:Colors.grey,
                                inactiveTrackColor: Colors.grey.shade100,
                                activeColor: Colors.green,
                                activeTrackColor: Colors.yellow,
                                dense: true,
                                controlAffinity: ListTileControlAffinity.leading,
                                contentPadding: EdgeInsetsDirectional.fromSTEB(24, 12, 24, 12),
                              ),
                            ),


                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  currentBranchName,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25),
                                ),
                                const SizedBox(height: 10,),
                                const Text(
                                  "LOGGED IN USER",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            // const CircleAvatar(
                            //   backgroundImage: NetworkImage("https://scontent.fcok4-1.fna.fbcdn.net/v/t1.6435-9/41645109"
                            //       "_1747771551988756_2209695106821259264_n.jpg?_nc_cat=102&ccb=1-5&_nc_sid=09cbfe&_nc_ohc=Ir5KrY_qwQcAX-4TTg1&_nc_ht=scontent.fcok4-1.fna&oh=6f210f4258122449225c7fc2ab0606dd&oe=6176D772"),
                            // ),
                            Expanded(
                                child: Center(
                                    child: Text(
                                      "Token : $token",
                                      style: const TextStyle(
                                        fontSize: 25,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ))),
                            const SizedBox(
                              width: 15,
                            ),

                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: InkWell(
                                onTap: () async {
                                  await showDialog(
                                    context: context,
                                    builder: (alertDialogContext) {
                                      return AlertDialog(
                                        title: const Text('Clear Tokens !'),
                                        content: const Text('Do  You want to clear Tokens?'),
                                        actions: [
                                          TextButton(
                                            onPressed: () => Navigator.pop(alertDialogContext),
                                            child: const Text('Cancel'),
                                          ),
                                          TextButton(
                                            onPressed: () async {

                                              FirebaseFirestore.instance
                                                  .collection('invoiceNo')
                                                  .doc(currentBranchId)
                                                  .update({
                                                'token':0,
                                              });

                                              Navigator.pop(alertDialogContext);
                                              showUploadMessage(context, 'Token Cleared');

                                            },
                                            child: Text('Confirm'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                      color: Colors.white,width: 2
                                    )
                                  ),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 10.0,right: 10),
                                      child: Text('Token Clear $token',style: TextStyle(
                                        fontWeight: FontWeight.bold,color: Colors.white
                                      ),),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),


                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              decoration: const BoxDecoration(
                              ),
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            offset: const Offset(
                                              0.0,
                                              -1.0,
                                            ),
                                            blurRadius: 20.0,
                                            spreadRadius: 1.0,
                                          ), //BoxShadow
                                          //BoxShadow
                                        ],
                                      ),
                                      child: Column(
                                        children: [
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
                                                        style: TextStyle(
                                                            fontWeight:
                                                            FontWeight.bold),
                                                      )),
                                                ),
                                                Expanded(
                                                  flex: 6,
                                                  child: Center(
                                                      child: Text(
                                                        "NAME",
                                                        style: TextStyle(
                                                            fontWeight:
                                                            FontWeight.bold),
                                                      )),
                                                ),
                                                Expanded(
                                                  flex: 3,
                                                  child: Center(
                                                      child: Text(
                                                        "PRICE",
                                                        style: TextStyle(
                                                            fontWeight:
                                                            FontWeight.bold),
                                                      )),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Center(
                                                      child: Text(
                                                        "QTY",
                                                        style: TextStyle(
                                                            fontWeight:
                                                            FontWeight.bold),
                                                      )),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Center(
                                                      child: Text(
                                                        "",
                                                        style: TextStyle(
                                                            fontWeight:
                                                            FontWeight.bold),
                                                      )),
                                                )
                                              ],
                                            ),
                                          ),
                                          //Add Section
                                          Expanded(
                                            child:
                                            StreamBuilder<DocumentSnapshot>(
                                                stream: FirebaseFirestore
                                                    .instance
                                                    .collection('tables')
                                                    .doc(currentBranchId)
                                                    .collection('tables')
                                                    .doc(selectedTable)
                                                    .snapshots(),
                                                builder:
                                                    (context, snapshot) {
                                                  items = [];
                                                  itemList=[];

                                                  if (!snapshot.hasData) {
                                                    return Container();
                                                  }
                                                  totalAmount = 0;
                                                  if (snapshot.data
                                                      .get('items') !=
                                                      null) {
                                                    items = snapshot.data
                                                        .get('items');

                                                    previousItems=[];
                                                    for (dynamic item
                                                    in snapshot.data
                                                        .get('items')) {
                                                      previousItems.add(item);

                                                      // if(item['variants'].length==0){
                                                      //   print('0000000000');
                                                      //
                                                      //
                                                      //
                                                      // }else{
                                                      //   print('MORE MORE MORE MORE');
                                                      //
                                                      //
                                                      // }


                                                      itemList.add(
                                                          {
                                                            'arabicName':item['arabicName'],
                                                            'addOnArabic':item['addOnArabic'],
                                                            'variants':item['variants'],
                                                            'pdtname':item['pdtname'],
                                                            'price':item['price'],
                                                            'category':item['category'],
                                                            'qty':item['qty'],
                                                            'addOns':item['addOns']??[],
                                                            'addOnPrice':item['addOnPrice'],
                                                            'ingredients':item['ingredients']
                                                          });
                                                        // print(item);
                                                        // print('gggggggg');

                                                      totalAmount += (double.tryParse(item['price'].toString())
                                                          +double.tryParse(item['addOnPrice'].toString())) * item['qty'];

                                                      double grandTotal=(totalAmount - (double.tryParse(discount) ?? 0)+(double.tryParse(delivery) ??0))??0;
                                                      // paidCash.text=grandTotal.toStringAsFixed(2)??0;


                                                    }
                                                  }
                                                  return Column(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                      children: [
                                                        Container(
                                                          padding:
                                                          const EdgeInsets
                                                              .only(
                                                              top: 10),
                                                          // child:  Container(),
                                                          child: keyboard
                                                              ? Container()
                                                              : BillWidget(
                                                            items: snapshot
                                                                .data
                                                                .get(
                                                                'items'),
                                                          ),
                                                        ),
                                                        Container(
                                                          padding:
                                                          const EdgeInsets
                                                              .fromLTRB(
                                                              20,
                                                              10,
                                                              20,
                                                              10),
                                                          color: Colors
                                                              .blueGrey
                                                              .shade100,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                            children: [
                                                              Column(
                                                                crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                                children: [
                                                                  Text(
                                                                    "Total Amount",
                                                                    style: TextStyle(
                                                                        fontWeight: FontWeight
                                                                            .bold,
                                                                        fontSize:
                                                                        15,
                                                                        color:
                                                                        Colors.grey.shade700),
                                                                  ),
                                                                  Text(
                                                                    "Discount",
                                                                    style: TextStyle(
                                                                        fontWeight: FontWeight
                                                                            .bold,
                                                                        fontSize:
                                                                        15,
                                                                        color:
                                                                        Colors.grey.shade700),
                                                                  ),
                                                                  Text(
                                                                    "Vat ",
                                                                    style: TextStyle(
                                                                        fontWeight: FontWeight
                                                                            .bold,
                                                                        fontSize:
                                                                        15,
                                                                        color:
                                                                        Colors.grey.shade700),
                                                                  ),
                                                                  Text(
                                                                    "Delivery ",
                                                                    style: TextStyle(
                                                                        fontWeight: FontWeight
                                                                            .bold,
                                                                        fontSize:
                                                                        15,
                                                                        color:
                                                                        Colors.grey.shade700),
                                                                  ),
                                                                  const SizedBox(
                                                                    height:
                                                                    10,
                                                                  ),
                                                                  Text(
                                                                    "Grand Total",
                                                                    style: TextStyle(
                                                                        fontWeight: FontWeight
                                                                            .bold,
                                                                        fontSize:
                                                                        16,
                                                                        color:
                                                                        Colors.grey.shade700),
                                                                  ),
                                                                ],
                                                              ),
                                                              Column(
                                                                crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .end,
                                                                children: [
                                                                  Text(
                                                                    "SR ${(totalAmount*100/(100+gst)).toStringAsFixed(2)}",
                                                                    style: TextStyle(
                                                                        fontWeight: FontWeight
                                                                            .bold,
                                                                        fontSize:
                                                                        15,
                                                                        color:
                                                                        Colors.grey.shade700),
                                                                  ),
                                                                  Text(
                                                                    double.tryParse(discount) ==
                                                                        null
                                                                        ? "0.00"
                                                                        : "SR ${double.tryParse(discount).toStringAsFixed(2)}",
                                                                    style: TextStyle(
                                                                        fontWeight: FontWeight
                                                                            .bold,
                                                                        fontSize:
                                                                        16,
                                                                        color:
                                                                        Colors.grey.shade700),
                                                                  ),
                                                                  Text(
                                                                    " SR ${(totalAmount * gst /(100+gst)).toStringAsFixed(2)}",
                                                                    style: TextStyle(
                                                                        fontWeight: FontWeight
                                                                            .bold,
                                                                        fontSize:
                                                                        15,
                                                                        color:
                                                                        Colors.grey.shade700),
                                                                  ),
                                                                  Text(
                                                                    double.tryParse(delivery) ==
                                                                        null
                                                                        ? "0.00"
                                                                        : "SR ${double.tryParse(delivery).toStringAsFixed(2)}",
                                                                    style: TextStyle(
                                                                        fontWeight: FontWeight
                                                                            .bold,
                                                                        fontSize:
                                                                        16,
                                                                        color:
                                                                        Colors.grey.shade700),
                                                                  ),
                                                                  const SizedBox(
                                                                    height:
                                                                    10,
                                                                  ),
                                                                  Text(
                                                                    "SR ${(totalAmount - (double.tryParse(discount) ?? 0)+(double.tryParse(delivery) ??0)).toStringAsFixed(2)}",
                                                                    style: TextStyle(

                                                                        fontWeight: FontWeight
                                                                            .bold,
                                                                        fontSize:
                                                                        15,
                                                                        color:
                                                                        Colors.grey.shade700),
                                                                  ),
                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ]);
                                                }),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.12,
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: const [
                                            Expanded(
                                              child: Text(
                                                "DISCOUNT  :",
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                "DELIVERY  :",
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                height: 45,
                                                child: TextFormField(

                                                  onEditingComplete: () {
                                                    FocusScope.of(context)
                                                        .unfocus();
                                                    if(discountController.text.contains("%")){
                                                      double disc =double.tryParse(discountController.text.replaceAll("%", "").trim())??0;
                                                      discount = (totalAmount*disc/100).toStringAsFixed(2);
                                                    }else{
                                                      discount = discountController.text;
                                                    }
                                                    
                                                    setState(() {
                                                      keyboard = false;
                                                    });
                                                  },
                                                  onTap: () {
                                                    setState(() {
                                                      // keyboard = true;
                                                    });
                                                  },
                                                  controller: discountController,
                                                  keyboardType:
                                                  TextInputType.text,
                                                  decoration: InputDecoration(
                                                    // labelText: 'DISCOUNT',
                                                    hoverColor: default_color,
                                                    hintText: 'Discount',
                                                    border:
                                                    OutlineInputBorder(
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(5.0),
                                                    ),
                                                    focusedBorder:
                                                    OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors
                                                              .pink.shade900,
                                                          width: 1.0),
                                                    ),
                                                    contentPadding: EdgeInsets.all(5)
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            InkWell(
                                              onTap: () {
                                                setState(() {
                                                  keyboard = false;
                                                  FocusScope.of(context)
                                                      .unfocus();
                                                  if(discountController.text.contains("%")){
                                                    double disc =double.tryParse(discountController.text.replaceAll("%", "").trim())??0;
                                                    discount = (totalAmount*disc/100).toStringAsFixed(2);
                                                  }else{
                                                    discount = discountController.text;
                                                  }

                                                });
                                              },
                                              child: Container(
                                                width: 100,
                                                height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                    0.06,
                                                decoration: BoxDecoration(
                                                    color: Colors.green,
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        10)),
                                                child: const Center(
                                                  child: Text(
                                                    "ENTER",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                        FontWeight.bold,
                                                        fontSize: 16),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                  height: 45,
                                                child: TextFormField(
                                                  onEditingComplete: () {
                                                    FocusScope.of(context)
                                                        .unfocus();
                                                    delivery = deliveryCharge.text;
                                                    setState(() {
                                                      keyboard = false;
                                                    });
                                                  },
                                                  onTap: () {
                                                    setState(() {
                                                      // keyboard = true;
                                                    });
                                                  },
                                                  controller:
                                                  deliveryCharge,
                                                  keyboardType:
                                                  TextInputType.number,
                                                  decoration: InputDecoration(
                                                    // labelText: 'DELIVERY',
                                                    hoverColor: default_color,
                                                    hintText: 'Delivery Charge',
                                                    border:
                                                    OutlineInputBorder(
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(5.0),
                                                    ),
                                                    focusedBorder:
                                                    OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors
                                                              .pink.shade900,
                                                          width: 1.0),
                                                    ),
                                                      contentPadding: EdgeInsets.all(5)
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            InkWell(
                                              onTap: () {
                                                setState(() {
                                                  keyboard = false;
                                                  FocusScope.of(context)
                                                      .unfocus();
                                                  delivery =
                                                      deliveryCharge.text;
                                                });
                                              },
                                              child: Container(
                                                width: 100,
                                                height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                    0.06,
                                                decoration: BoxDecoration(
                                                    color: Colors.green,
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        10)),
                                                child: const Center(
                                                  child: Text(
                                                    "ENTER",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                        FontWeight.bold,
                                                        fontSize: 16),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.5,
                              decoration: const BoxDecoration(),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            offset: const Offset(0.0, -1.0,),
                                            blurRadius: 20.0,
                                            spreadRadius: 1.0,
                                          ), //BoxShadow
                                          //BoxShadow
                                        ],
                                      ),
                                       child: products?const ItemsPage():Container(),
                                      // child: const ItemsPage(),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.15,
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(

                                          height: MediaQuery.of(context).size.height * 0.13,
                                          width: 150,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                                offset: const Offset(0.0, -1.0,),
                                                blurRadius: 20.0,
                                                spreadRadius: 1.0,
                                              ), //BoxShadow
                                              //BoxShadow
                                            ],
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                            children: [



                                              //ADDON BUTTON
                                              // FFButtonWidget(
                                              //   onPressed: () {
                                              //     showDialog(
                                              //         context: context,
                                              //         builder: (BuildContext context) {
                                              //
                                              //           return StatefulBuilder(
                                              //               builder: (context,setState)
                                              //               {
                                              //                 return const AddOn();
                                              //               }
                                              //           );
                                              //         }
                                              //     );
                                              //
                                              //   },
                                              //   text: 'ADD ON',
                                              //   options: FFButtonOptions(
                                              //     width: 100,
                                              //     height: 70,
                                              //     color: Colors.green,
                                              //     textStyle: FlutterFlowTheme.subtitle2.override(
                                              //       fontFamily: 'Overpass',
                                              //       color: Colors.white,
                                              //       fontWeight: FontWeight.w800,
                                              //     ),
                                              //     elevation: 10,
                                              //     borderSide: const BorderSide(
                                              //       color: Colors.grey,
                                              //       width: 1,
                                              //     ),
                                              //     borderRadius: 12,
                                              //   ),
                                              // ),


                                              FFButtonWidget(
                                                onPressed: () async {
                                                  // print('paidCash.text');
                                                  // print(paidCash.text);
                                                  // print(paidBank.text);


                                                  // if(paidBank.text!=''  || paidCash.text!=''){
                                                    if(blue){



                                                      // print('paidCash.text');
                                                      // print(paidCash.text);

                                                      await showDialog(
                                                          barrierDismissible: false,
                                                          context: context,
                                                          builder: (BuildContext context) {

                                                            return mytest(items:printCopy,
                                                              token: copyToken,
                                                              salesDate: copyDate,
                                                              delivery: copyDelivery,
                                                              customer: 'Walking Customer',
                                                              discountPrice: copyDiscount,
                                                              invoiceNo: copyInvoice.toString(),
                                                              cashPaid:double.tryParse(paidCash.text)??0,
                                                              bankPaid:double.tryParse(paidBank.text)??0,
                                                              balance:balance??0
                                                            );
                                                          });

                                                      paidCash.text='';
                                                      paidCash.text='';

                                                    }else{

                                                      flutterUsbPrinter.write(Uint8List.fromList(bytes));
                                                      bytes=[];
                                                      if(lastCut==true){
                                                         flutterUsbPrinter.write(Uint8List.fromList(kotBytes));
                                                      }
                                                      // if(lastCut==true){
                                                      //   // flutterUsbPrinter.write(Uint8List.fromList(kotBytes));
                                                      //   print('kot ********************************');
                                                      //   const PaperSize paper1 = PaperSize.mm80;
                                                      //   var profile1 = await CapabilityProfile.load();
                                                      //   var printer1 = NetworkPrinter(paper1, profile1);
                                                      //   try {
                                                      //     List categories = [];
                                                      //     for (Map<String, dynamic> item in items) {
                                                      //       print("item['category']");
                                                      //       print(item['category']);
                                                      //       if (!categories.contains(item['category'])) {
                                                      //         categories.add(item['category']);
                                                      //       }
                                                      //     }
                                                      //     print("----------------categories ------------------");
                                                      //     print(categories);
                                                      //     Map<String, dynamic> printerMap = {};
                                                      //     for (var category in categories) {
                                                      //       print("allCategories*******************************");
                                                      //       print("$allCategories*******************************");
                                                      //       print("category_____________________");
                                                      //       print(category);
                                                      //       String printerID = allCategories[category]['printer'];
                                                      //       print("$printerID              printer iddddddd");
                                                      //
                                                      //
                                                      //       if (printerMap[printerID] == null) {
                                                      //         printerMap[printerID] = [category];
                                                      //       } else {
                                                      //         printerMap[printerID].add(category);
                                                      //       }
                                                      //     }
                                                      //     for (var printerID in printerMap.keys.toList()) {
                                                      //       print("printers[printerID]['type']----------------------");
                                                      //       print(printers[printerID]['type']);
                                                      //       kotPrinter = printers[printerID]['type'];
                                                      //       List categoryLists = printerMap[printerID];
                                                      //       if (kotPrinter == 1) {
                                                      //         // await Future.delayed(Duration(seconds: 10));
                                                      //
                                                      //
                                                      //         String ip = printers[printerID]['ip'];
                                                      //         int port = printers[printerID]['port'];
                                                      //         print("$printerID ip iddddddddd ethernet");
                                                      //         print("$ip ip adressssssssssssssssss");
                                                      //         print("$port port");
                                                      //
                                                      //         try {
                                                      //           PosPrintResult res = await printer1.connect(
                                                      //               ip, port: port, timeout: const Duration(seconds: 10));
                                                      //           while (res != PosPrintResult.success) {
                                                      //             res = await printer1.connect(
                                                      //                 ip, port: port, timeout: const Duration(seconds: 10));
                                                      //           }
                                                      //           if (res == PosPrintResult.success) {
                                                      //             printer1.text('Token No : ' + token.toString(),
                                                      //                 styles: const PosStyles(align: PosAlign.center,));
                                                      //             printer1.text(
                                                      //                 'Date : ' + DateTime.now().toString().substring(0, 16),
                                                      //                 styles: const PosStyles(align: PosAlign.center,));
                                                      //             // printer1.text('Invoice No : ' + invNo.toString(),
                                                      //             //     styles: const PosStyles(align: PosAlign.center,));
                                                      //
                                                      //
                                                      //             for (Map<String, dynamic> item in items) {
                                                      //               if (categoryLists.contains(item['category'])) {
                                                      //                 newAddOn = item['addOns'];
                                                      //                 newAddOnArabic = item['addOnArabic'];
                                                      //                 // addON = newAddOn.isEmpty ? '' : newAddOn.toString();
                                                      //                 // printer1.text("${int.tryParse(item['qty']
                                                      //                 //     .toString())} x ${item['pdtname']} $addON");
                                                      //                 // print("ethernet Items*********************\n ${int.tryParse(
                                                      //                 //     item['qty'].toString())} x ${item['pdtname']} $addON");
                                                      //               }
                                                      //             }
                                                      //             if (lastCut == true) {
                                                      //               print("laaaaaaaaast cuuuuuuuuuuuuuuuuuut");
                                                      //               printer1.feed(2);
                                                      //               printer1.cut();
                                                      //               printer1.disconnect(delayMs: 10);
                                                      //             }
                                                      //           } else {
                                                      //             print(res.msg);
                                                      //             print("no printer found");
                                                      //             // printer.disconnect(delayMs: 10);
                                                      //           }
                                                      //         } catch (e) {
                                                      //           print("button catch");
                                                      //           print(e.toString());
                                                      //         }
                                                      //       } else if (kotPrinter == 2) {
                                                      //         String ip = printers[printerID]['ip'];
                                                      //         int port = printers[printerID]['port'];
                                                      //         print("$printerID ip iddddddddd ethernet");
                                                      //         print("$ip ip adressssssssssssssssss");
                                                      //         print("$port port");
                                                      //
                                                      //         try {
                                                      //           PosPrintResult res = await printer1.connect(
                                                      //               ip, port: port, timeout: const Duration(seconds: 10));
                                                      //           while (res != PosPrintResult.success) {
                                                      //             res = await printer1.connect(
                                                      //                 ip, port: port, timeout: const Duration(seconds: 10));
                                                      //           }
                                                      //           if (res == PosPrintResult.success) {
                                                      //             printer1.text('Token No : ' + token.toString(),
                                                      //                 styles: const PosStyles(align: PosAlign.center,));
                                                      //             printer1.text(
                                                      //                 'Date : ' + DateTime.now().toString().substring(0, 16),
                                                      //                 styles: const PosStyles(align: PosAlign.center,));
                                                      //             // printer1.text('Invoice No : ' + invNo.toString(),
                                                      //             //     styles: const PosStyles(align: PosAlign.center,));
                                                      //
                                                      //
                                                      //             for (Map<String, dynamic> item in items) {
                                                      //               if (categoryLists.contains(item['category'])) {
                                                      //                 newAddOn = item['addOns'];
                                                      //                 newAddOnArabic = item['addOnArabic'];
                                                      //                 // addON = newAddOn.isEmpty ? '' : newAddOn.toString();
                                                      //                 // printer1.text("${int.tryParse(item['qty']
                                                      //                 //     .toString())} x ${item['pdtname']} $addON");
                                                      //                 // print("ethernet Items*********************\n ${int.tryParse(
                                                      //                 //     item['qty'].toString())} x ${item['pdtname']} $addON");
                                                      //               }
                                                      //             }
                                                      //             if (lastCut == true) {
                                                      //               printer1.feed(2);
                                                      //               printer1.cut();
                                                      //               printer1.disconnect(delayMs: 10);
                                                      //             }
                                                      //           } else {
                                                      //             print(res.msg);
                                                      //             print("no printer found");
                                                      //             // printer.disconnect(delayMs: 10);
                                                      //           }
                                                      //         } catch (e) {
                                                      //           print("button catch");
                                                      //           print(e.toString());
                                                      //         }
                                                      //       }
                                                      //     }
                                                      //     try {
                                                      //       bool printSuccess = false;
                                                      //       int i = 0;
                                                      //       while (!printSuccess && i < 5) {
                                                      //         printSuccess = await flutterUsbPrinter.write(Uint8List.fromList(bytes));
                                                      //         i++;
                                                      //         if (!printSuccess) {
                                                      //           final snackBar = SnackBar(
                                                      //             content: const Text('print not success'),
                                                      //             action: SnackBarAction(
                                                      //               label: 'Undo',
                                                      //               onPressed: () {
                                                      //                 // Some code to undo the change.
                                                      //               },
                                                      //             ),
                                                      //           );
                                                      //           await _getDevicelist();
                                                      //           await Future.delayed(Duration(milliseconds: 200));
                                                      //         }
                                                      //       }
                                                      //     }
                                                      //     catch (ex) {
                                                      //       print("usb exceptionnnnnnnnnnnnnnnnnn");
                                                      //       print(ex.toString());
                                                      //       await await flutterUsbPrinter.write(Uint8List.fromList(bytes));
                                                      //     }
                                                      //
                                                      //     // bytes = [];
                                                      //   }
                                                      //   catch (error) {
                                                      //     print(error.toString(),);
                                                      //   }
                                                      //
                                                      // }

                                                    }
                                                  // }
                                                  // else{
                                                  //   showUploadMessage(context, 'PLEASE SELECT THE PAYMENT METHOD');
                                                  // }

                                                },
                                                text: 'COPY',
                                                options: const FFButtonOptions(
                                                  width: 70,
                                                  height: 60,
                                                  // color: Colors.green.shade700,
                                                  // textStyle: FlutterFlowTheme.subtitle2.override(
                                                  //   fontFamily: 'Overpass',
                                                  //   fontSize: 15,
                                                  //   color: Colors.white,
                                                  //   fontWeight: FontWeight.w800,
                                                  // ),
                                                  elevation: 10,
                                                  borderSide: BorderSide(
                                                    color: Colors.grey,
                                                    width: 1,
                                                  ),
                                                  borderRadius: 12,
                                                ),
                                              ),
                                              FFButtonWidget(
                                                onPressed: () async {
                                                  if(paidCash.text!='' || paidBank.text!=''){
                                                    String billDiscount = discount;
                                                    if (!disable) {
                                                      disable = true;

                                                      DocumentSnapshot tableDoc =
                                                      await FirebaseFirestore
                                                          .instance
                                                          .collection('tables')
                                                          .doc(currentBranchId)
                                                          .collection('tables')
                                                          .doc(selectedTable)
                                                          .get();
                                                      List billItems =
                                                      tableDoc.get('items');
                                                      if (billItems.isNotEmpty) {
                                                        DocumentSnapshot invoiceNoDoc =
                                                        await FirebaseFirestore
                                                            .instance
                                                            .collection('invoiceNo')
                                                            .doc(currentBranchId)
                                                            .get();
                                                        FirebaseFirestore.instance
                                                            .collection('invoiceNo')
                                                            .doc(currentBranchId)
                                                            .update({
                                                          'sales':
                                                          FieldValue.increment(1),
                                                          'token':
                                                          FieldValue.increment(1)
                                                        });
                                                        int invoiceNo =
                                                        invoiceNoDoc.get('sales');
                                                        int token =
                                                        invoiceNoDoc.get('token');
                                                        invoiceNo++;
                                                        token++;
                                                        // if(!kIsWeb) {
                                                        //   // connected == true
                                                        //   //     ? _print()
                                                        //   //     : const ScaffoldMessenger(
                                                        //   //     child: Text(
                                                        //   //         "Printer not Connected"));
                                                        // }
                                                        // else{
                                                        //   printFunction(invoiceNo,double.tryParse(
                                                        //       discount) ?? 0);
                                                        // }
                                                        List<String> ingredientIds=[];
                                                        for(var a in billItems){
                                                          for(var b in a['ingredients']){
                                                            ingredientIds.add(b['ingredientId']);
                                                          }
                                                          for(var b in a['variants']){
                                                            for(var c in b['ingredients']){
                                                              ingredientIds.add(c['ingredientId']);
                                                            }

                                                          }
                                                        }
                                                        await FirebaseFirestore.instance
                                                            .collection('sales')
                                                            .doc(currentBranchId)
                                                            .collection('sales')
                                                            .doc(invoiceNo.toString())
                                                            .set({
                                                          'salesDate': DateTime.now(),
                                                          'invoiceNo': invoiceNo,
                                                          'cash': cash,
                                                          'token': token,
                                                          'currentUserId':currentUserId,
                                                          'currentBranchId':currentBranchId,
                                                          'currentBranchPhNo': currentBranchPhNo,
                                                          'currentBranchAddress': currentBranchAddress,
                                                          'currentBranchArabic': currentBranchArabic,
                                                          'deliveryCharge':double.tryParse(delivery) ?? 0,
                                                          'table': selectedTable,
                                                          'billItems': billItems,
                                                          'discount': double.tryParse(discount) ?? 0,
                                                          'totalAmount': totalAmount*100/(100+gst),
                                                          'tax': totalAmount * gst / (100+gst),
                                                          'grandTotal': totalAmount  - (double.tryParse(discount) ?? 0)+(double.tryParse(delivery) ??0),

                                                          'paidCash':double.tryParse(paidCash.text)??0,
                                                          'paidBank':double.tryParse(paidBank.text)??0,
                                                          'cash': paidCash.text=='0'?false:true,
                                                          'bank': paidBank.text=='0'?false:true,
                                                          'balance':balance,
                                                          "ingredientIds":ingredientIds
                                                        });

                                                        paidCash.text='';
                                                        paidCash.text='';


                                                        await FirebaseFirestore.instance
                                                            .collection('tables')
                                                            .doc(currentBranchId)
                                                            .collection('tables')
                                                            .doc(selectedTable)
                                                            .update({'items': []});
                                                        setState(() {
                                                          discountController.text =
                                                          '0';
                                                          discount = '0.00';
                                                          deliveryCharge.text =
                                                          '0';
                                                          delivery = '0.00';
                                                          qty=0;
                                                          paidCash.text='';
                                                          paidBank.text='';
                                                          totalAmount=0;
                                                          balance=0;
                                                          cashPaid=0;
                                                          bankPaid=0;
                                                          disable = false;
                                                        });
                                                      }
                                                      showUploadMessage(context, 'Saved Successfully');



                                                    }
                                                  }else{
                                                    showUploadMessage(context, 'PLEASE SELECT PAYMET METHOD');
                                                  }



                                                },
                                                text: 'SAVE',
                                                options: const FFButtonOptions(
                                                  width: 70,
                                                  height: 60,
                                                  // color: Colors.green.shade700,
                                                  // textStyle: FlutterFlowTheme.subtitle2.override(
                                                  //   fontFamily: 'Overpass',
                                                  //   fontSize: 15,
                                                  //   color: Colors.white,
                                                  //   fontWeight: FontWeight.w800,
                                                  // ),
                                                  elevation: 10,
                                                  borderSide: BorderSide(
                                                    color: Colors.grey,
                                                    width: 1,
                                                  ),
                                                  borderRadius: 12,
                                                ),
                                              ),

                                            ],
                                          ),
                                        ),

                                        //Cash and bank
                                        Expanded(
                                          child: Container(
                                            height: MediaQuery.of(context).size.height * 0.15,
                                            width: 100,

                                            child: Container(
                                              child: Column(
                                                children: [
                                                  Expanded(
                                                    child: Container(
                                                      child: Row(
                                                        children: [
                                                          SizedBox(width: 10,),
                                                          Expanded(
                                                            child: SizedBox(
                                                              child: Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  Text(
                                                                    "CASH :",
                                                                    textAlign: TextAlign.start,
                                                                    style: TextStyle(
                                                                        fontWeight: FontWeight.bold),
                                                                  ),
                                                                  Container(
                                                                    height: 45,
                                                                    child: TextFormField(
                                                                      onEditingComplete: () {
                                                                        FocusScope.of(context)
                                                                            .unfocus();
                                                                        // textController.selection =
                                                                        //     TextSelection.collapsed(offset: textController.text.length);


                                                                        setState(() {
                                                                           keyboard = false;
                                                                        });
                                                                      },
                                                                      onTap: () {
                                                                        setItemWidgets(items);
                                                                        double grandTotal=(totalAmount - (double.tryParse(discount) ?? 0)+(double.tryParse(delivery) ??0));
                                                                        // print(grandTotal);


                                                                          cashPaid=grandTotal-bankPaid;
                                                                          if(cashPaid<0){
                                                                            cashPaid=0;
                                                                            balance=grandTotal-cashPaid-bankPaid;
                                                                          }
                                                                          paidCash.text=cashPaid.toStringAsFixed(1);


                                                                        setState(() {
                                                                          // keyboard = true;
                                                                        });
                                                                      },
                                                                      onChanged: (value){
                                                                        double grandTotal=(totalAmount - (double.tryParse(discount) ?? 0)+(double.tryParse(delivery) ??0));

                                                                        cashPaid=double.tryParse(value)??0;
                                                                        bankPaid=grandTotal-cashPaid??0;
                                                                        if(bankPaid<0){
                                                                          bankPaid=0;
                                                                        }
                                                                        paidBank.text=bankPaid.toString();
                                                                        balance=grandTotal-cashPaid-bankPaid;
                                                                        setState(() {
                                                                          // keyboard = true;
                                                                        });
                                                                      },
                                                                      controller: paidCash,
                                                                      keyboardType:
                                                                      TextInputType.number,
                                                                      decoration: InputDecoration(
                                                                        // labelText: 'DISCOUNT',
                                                                          hoverColor: default_color,
                                                                          hintText: 'Cash',
                                                                          border:
                                                                          OutlineInputBorder(
                                                                            borderRadius:
                                                                            BorderRadius
                                                                                .circular(5.0),
                                                                          ),
                                                                          focusedBorder:
                                                                          OutlineInputBorder(
                                                                            borderSide: BorderSide(
                                                                                color: Colors
                                                                                    .pink.shade900,
                                                                                width: 1.0),
                                                                          ),
                                                                          prefixIcon: Padding(
                                                                            padding: EdgeInsets.all(0.0),
                                                                            child: Icon(
                                                                              Icons.money_outlined,
                                                                              color: Colors.grey,
                                                                            ), // icon is 48px widget.
                                                                          ),
                                                                          contentPadding: EdgeInsets.all(5)
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(width: 10,),
                                                          Expanded(
                                                            child: SizedBox(
                                                              child: Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  const Text(
                                                                    "BANK :",
                                                                    textAlign: TextAlign.start,
                                                                    style: TextStyle(
                                                                        fontWeight: FontWeight.bold),
                                                                  ),
                                                                  Container(
                                                                    height: 45,
                                                                    child: TextFormField(

                                                                      onEditingComplete: () {
                                                                        FocusScope.of(context)
                                                                            .unfocus();


                                                                        setState(() {
                                                                          keyboard = false;
                                                                        });
                                                                      },
                                                                      onTap: () {
                                                                        setItemWidgets(items);

                                                                        double grandTotal=(totalAmount - (double.tryParse(discount) ?? 0)+(double.tryParse(delivery) ??0));
                                                                        // print(grandTotal);


                                                                        bankPaid=grandTotal-cashPaid;
                                                                        if(bankPaid<0){
                                                                          bankPaid=0;

                                                                        }
                                                                        paidBank.text=bankPaid.toStringAsFixed(1);


                                                                        balance=grandTotal-cashPaid-bankPaid;
                                                                        setState(() {
                                                                          // keyboard = true;
                                                                        });
                                                                      },
                                                                      onChanged: (value){
                                                                        // print(value);
                                                                        bankPaid=double.tryParse(value)??0;
                                                                        double grandTotal=(totalAmount - (double.tryParse(discount) ?? 0)+(double.tryParse(delivery) ??0));
                                                                        cashPaid=grandTotal-bankPaid;
                                                                        if(cashPaid<0){
                                                                          cashPaid=0;
                                                                        }
                                                                        paidCash.text=cashPaid.toString();
                                                                        // print(bankPaid);
                                                                        balance=grandTotal-cashPaid-bankPaid;
                                                                        setState(() {
                                                                          // keyboard = true;
                                                                        });
                                                                      },
                                                                      controller: paidBank,
                                                                      keyboardType:
                                                                      TextInputType.number,
                                                                      decoration: InputDecoration(
                                                                        // labelText: 'DISCOUNT',
                                                                          prefixIcon: const Padding(
                                                                            padding: EdgeInsets.all(0.0),
                                                                            child: Icon(
                                                                              Icons.home_repair_service_rounded,
                                                                              color: Colors.grey,
                                                                            ), // icon is 48px widget.
                                                                          ),
                                                                          hoverColor: default_color,
                                                                          hintText: 'Bank',
                                                                          border:
                                                                          OutlineInputBorder(
                                                                            borderRadius:
                                                                            BorderRadius
                                                                                .circular(5.0),
                                                                          ),
                                                                          focusedBorder:
                                                                          OutlineInputBorder(
                                                                            borderSide: BorderSide(
                                                                                color: Colors
                                                                                    .pink.shade900,
                                                                                width: 1.0),
                                                                          ),
                                                                          contentPadding: EdgeInsets.all(5)
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(width: 10,),



                                                        ],
                                                      ),
                                                    ),
                                                  ),

                                                  Container(
                                                    height:MediaQuery.of(context).size.height * 0.05,
                                                    child: Center(child: Text('Balance : $balance',style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                      fontSize: 17
                                                    ),)),
                                                  )

                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () async {

                                            await FirebaseFirestore.instance
                                                .collection('tables')
                                            .doc(currentBranchId)
                                                .collection('tables')
                                                .doc(selectedTable)
                                                .update({'items': []});
                                            setState(() {
                                              discountController.text = '0';
                                              discount = '0';
                                              deliveryCharge.text = '0';
                                              paidBank.text = '';
                                              paidCash.text = '';
                                              balance = 0;
                                              delivery = '0';
                                              qty = 0;
                                              totalAmount=0;
                                              balance=0;
                                              cashPaid=0;
                                              bankPaid=0;
                                            });
                                          },
                                          child: Container(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.15,
                                            width: 120,
                                            decoration: BoxDecoration(
                                                color: default_color),
                                           child: Column(
                                               mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: const [
                                                Icon(
                                                  Icons.delete,
                                                  size: 35,
                                                  color: Colors.white,
                                                ),
                                                Text(
                                                  "CANCEL",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                      FontWeight.bold),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () async {
                                            print("start");
                                            print(DateTime.now());
                                            if(paidCash.text!='' || paidBank.text!=''){
                                              print("abcd====================");
                                            String billDiscount = discount;

                                            // disable=false;
                                            if (!disable) {
                                              disable = true;

                                              // DocumentSnapshot tableDoc =
                                              // await FirebaseFirestore
                                              //     .instance
                                              //     .collection('tables')
                                              //     .doc(currentBranchId)
                                              //     .collection('tables')
                                              //     .doc(selectedTable)
                                              //     .get();
                                              // List billItems =
                                              // tableDoc.get('items');
                                              print(DateTime.now());
                                              if (items.isNotEmpty) {
                                                DocumentSnapshot invoiceNoDoc =
                                                await FirebaseFirestore
                                                    .instance
                                                    .collection('invoiceNo')
                                                    .doc(currentBranchId)
                                                    .get();

                                                // print(DateTime.now());
                                                int invoiceNo =
                                                invoiceNoDoc.get('sales');
                                                int token =
                                                invoiceNoDoc.get('token');
                                                invoiceNo++;
                                                token++;
                                                List<String> ingredientIds=[];
                                                for(var a in items){
                                                  for(var b in a['ingredients']??[]){
                                                    ingredientIds.add(b['ingredientId']);
                                                  }
                                                }
                                                print(DateTime.now());
                                                if(blue) {
                                                   showDialog(
                                                      barrierDismissible: false,
                                                      context: context,
                                                      builder:
                                                          (
                                                          BuildContext context) {
                                                        items = items;
                                                        printCopy = items;
                                                        copyToken = token;
                                                        copyInvoice = invoiceNo;
                                                        copyCustomer =
                                                        'Walking Customer';
                                                        copyDate =
                                                            DateTime.now();
                                                        copyDelivery =
                                                            double.tryParse(
                                                                discount) ?? 0;
                                                        copyDiscount =
                                                            double.tryParse(
                                                                discount);
                                                        return mytest(
                                                            salesDate: DateTime
                                                                .now(),
                                                            items: items,
                                                            token: token,
                                                            delivery: double
                                                                .tryParse(
                                                                discount),
                                                            customer: 'Walking Customer',
                                                            discountPrice: double
                                                                .tryParse(
                                                                discount),
                                                            invoiceNo: invoiceNo
                                                                .toString(),
                                                            selectedTable: selectedTable,
                                                            cashPaid: double
                                                                .tryParse(
                                                                paidCash
                                                                    .text) ?? 0,
                                                            bankPaid: double
                                                                .tryParse(
                                                                paidBank
                                                                    .text) ?? 0,
                                                            balance: balance ??
                                                                0
                                                        );
                                                      });
                                                }else{
                                                  print(DateTime.now());
                                                   abc(invoiceNo,double.tryParse(discountController.text),
                                                       items, token,selectedTable,
                                                       double.tryParse(deliveryCharge.text)??0,
                                                       double.tryParse(paidCash.text)??0,
                                                       double.tryParse(paidBank.text)??0,balance??0
                                                      );

                                                }
                                                print(DateTime.now());
                                                 ingredientsUpdate(items);
                                                FirebaseFirestore.instance
                                                    .collection('sales')
                                                    .doc(currentBranchId)
                                                    .collection('sales')
                                                    .doc(invoiceNo.toString())
                                                    .set({
                                                  'currentUserId':currentUserId,
                                                  'salesDate': DateTime.now(),
                                                  'invoiceNo': invoiceNo,
                                                  'token': token,
                                                  'currentBranchId':currentBranchId,
                                                  'currentBranchPhNo': currentBranchPhNo,
                                                  'currentBranchAddress': currentBranchAddress,
                                                  'currentBranchArabic': currentBranchArabic,
                                                  'deliveryCharge':double.tryParse(delivery) ?? 0,
                                                  'table': selectedTable,
                                                  'billItems': items,
                                                  'discount': double.tryParse(discount) ?? 0,
                                                  'totalAmount': totalAmount*100/(100+gst),
                                                  'tax': totalAmount * gst / (100+gst),
                                                  'grandTotal': totalAmount  - (double.tryParse(discount) ?? 0)+(double.tryParse(delivery) ??0),
                                                  'paidCash':double.tryParse(paidCash.text)??0,
                                                  'paidBank':double.tryParse(paidBank.text)??0,
                                                  'cash': paidCash.text==''|| paidCash.text=='0.0'?false:true ,
                                                  'bank': paidBank.text==''||paidBank.text=='0.0'?false:true,
                                                  'balance':balance,
                                                  "ingredientIds":ingredientIds

                                                });



                                                FirebaseFirestore.instance
                                                    .collection('invoiceNo')
                                                    .doc(currentBranchId)
                                                    .update({
                                                  'sales':
                                                  FieldValue.increment(1),
                                                  'token':
                                                  FieldValue.increment(1)
                                                });
                                                 FirebaseFirestore.instance
                                                    .collection('tables')
                                                    .doc(currentBranchId)
                                                    .collection('tables')
                                                    .doc(selectedTable)
                                                    .update({'items': []});
                                                setState(() {
                                                  discountController.text = '0';
                                                  deliveryCharge.text = '0';

                                                  qty=0;
                                                }


                                                );
                                              }



                                              discount = '0.00';
                                              delivery = '0.00';
                                              disable = false;
                                              paidCash.text='';
                                              paidBank.text='';
                                              totalAmount=0;
                                              balance=0;
                                              cashPaid=0;
                                              bankPaid=0;

                                            }
                                            }
                                            else{
                                              disable = false;
                                              showUploadMessage(context, 'PLEASE SELECT THE PAYMENT METHOD');
                                            }

                                          },
                                          child: Container(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height *
                                                0.15,
                                            width: 120,
                                            decoration: BoxDecoration(
                                              color: Colors.green.shade700,
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: const [
                                                Icon(
                                                  Icons.print,
                                                  size: 35,
                                                  color: Colors.white,
                                                ),
                                                Text(
                                                  "PRINT",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                      FontWeight.bold),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),

            ],
          ),
        ));
  }

  List<Widget> _buildList(List<Map<String, dynamic>> devices) {
    return devices
        .map((device) => ListTile(
      onTap: () {

        _connect(int.parse(device['vendorId']),
            int.parse(device['productId']));
      },
      leading: const Icon(Icons.usb),
      title: Text(device['manufacturer'] + " " + device['productName']),
      subtitle: Text(device['vendorId'] + " " + device['productId']),
    ))
        .toList();
  }
}

