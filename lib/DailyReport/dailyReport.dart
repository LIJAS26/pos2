//@dart=2.9
import 'dart:typed_data';
import 'package:awafi_pos/DailyReport/ProductReport.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:awafi_pos/Branches/branches.dart';
import 'package:awafi_pos/main.dart';
import 'package:awafi_pos/orders/orders_widget.dart';
import 'package:awafi_pos/reports/expense_reports.dart';
import 'package:awafi_pos/reports/purchase_reports.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:screenshot/screenshot.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import '../flutter_flow/upload_media.dart';
import '../modals/Print/pdf_api.dart';
import '../reports/VatReportPage.dart';
import 'categoryReport.dart';
import 'genaratePDF/dailyReport_model.dart';
import 'genaratePDF/pdfPage.dart';
import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:image/image.dart' as im;

import 'ingredient_report.dart';

class DailyReportsWidget extends StatefulWidget {
  DailyReportsWidget({Key key}) : super(key: key);

  @override
  _DailyReportsWidgetState createState() => _DailyReportsWidgetState();
}

class _DailyReportsWidgetState extends State<DailyReportsWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  ScreenshotController screenshotController = ScreenshotController();
  List salesData=[];
  var capturedImage1;
  Timestamp datePicked1;
  Timestamp datePicked2;
  DateTime selectedDate1 = DateTime.now();
  DateTime selectedDate2 = DateTime.now();
  double totalvat=0;
  
  List<int> bytes=[];
  List<int> kotBytes=[];
  abc(List items) async {
    final CapabilityProfile profile = await CapabilityProfile.load();

    final generator = Generator(PaperSize.mm80, profile);
    bytes = [];



    bytes += generator.text('Sales Reports', styles: const PosStyles(align: PosAlign.center,underline: false));
    bytes+=generator.feed(2);
    bytes += generator.text('From ${DateFormat("yyyy-MM-dd hh:mm aaa").format(selectedFromDate)} To ${DateFormat("yyyy-MM-dd hh:mm aaa").format(selectedOutDate)}', styles: PosStyles(align: PosAlign.center,height: PosTextSize.size1,width: PosTextSize.size1,underline: false));
    bytes+=generator.feed(2);
    bytes += generator.text('No     Bill No     Amt', styles: const PosStyles(align: PosAlign.center,underline: false));
    bytes += generator.text('.........................', styles: const PosStyles(align: PosAlign.center,underline: false));
    int i=1;
    double total=0;
    for(var data in items){
      bytes+=generator.text('$i     ${data['no']}     ${data['amount']}',styles: const PosStyles(align: PosAlign.center));

      total+=data['amount'];

      i++;
    }
    bytes += generator.text('........................', styles: PosStyles(align: PosAlign.center,underline: false));

    bytes +=generator.text('Total : ${total.toStringAsFixed(2)}',styles: const PosStyles(align: PosAlign.center));

    bytes += generator.feed(2);

    bytes += generator.cut();
    try {

      flutterUsbPrinter.write(Uint8List.fromList(bytes));
    }
    catch (error) {
      print(error.toString(),);
    }
    print("end");
    print(Timestamp.now().seconds);
  }
  daily_user_report(posUsers,name,cash ,bank,total, UID,arabicName)async{
    final CapabilityProfile profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm80, profile);
    bytes = [];
    bytes += generator.text('Sales Reports ', styles: const PosStyles(align: PosAlign.center,underline: false));
    bytes+=generator.feed(2);
    bytes += generator.text('From ${DateFormat("yyyy-MM-dd hh:mm aaa").format(selectedFromDate)} To ${DateFormat("yyyy-MM-dd hh:mm aaa").format(selectedOutDate)}', styles: PosStyles(align: PosAlign.center,height: PosTextSize.size1,width: PosTextSize.size1,underline: false));
    bytes+=generator.feed(2);
    ScreenshotController screenshotController = ScreenshotController();
    var  capturedImage1= await    screenshotController
        .captureFromWidget(Container(
        color: Colors.white,
        width: printWidth*2,
        height: 55,
        child:
        Column(
          mainAxisAlignment:MainAxisAlignment.center,
          children: [
            Text('CASHIER : $name',style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),),
              Text('  المحاسب :$arabicName ',style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),),

          ],)));
    final im.Image image1 = im.decodeImage(capturedImage1);
    bytes += generator.image(image1,);






      bytes += generator.text('No     Bill No     Amt', styles: const PosStyles(align: PosAlign.center,underline: false));
    bytes += generator.text('........................', styles: const PosStyles(align: PosAlign.center,underline: false));
    int i=0;
    double total=0;
    for(var data in sale){
      if (data.get('currentUserId') == UID) {
        i++;
        bytes += generator.text(
            '$i       ${data['invoiceNo']}       ${data['grandTotal']}',
            styles: const PosStyles(align: PosAlign.center));

        total += data['grandTotal'];
      }

    }
    bytes += generator.text('.........................', styles: PosStyles(align: PosAlign.center,underline: false));
    bytes += generator.text('Cash = $cash', styles: PosStyles(align: PosAlign.center,underline: false));
    bytes += generator.text('Bank = $bank', styles: PosStyles(align: PosAlign.center,underline: false));

    bytes +=generator.text('Total : $total',styles: const PosStyles(align: PosAlign.center));
    // bytes +=generator.text('أمير',styles: const PosStyles(align: PosAlign.center));

    bytes += generator.feed(2);

    bytes += generator.cut();
    try {

      flutterUsbPrinter.write(Uint8List.fromList(bytes));
    }
    catch (error) {
      print(error.toString(),);
    }
    print("end");
    print(Timestamp.now().seconds);
  }
  dailyPrint() async {
    final CapabilityProfile profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm80, profile);
    bytes = [];


    bytes += generator.text('Reports', styles: PosStyles(align: PosAlign.center,underline: false));
    bytes+=generator.feed(2);
    bytes += generator.text('From ${DateFormat("yyyy-MM-dd hh:mm aaa").format(selectedFromDate)} To ${DateFormat("yyyy-MM-dd hh:mm aaa").format(selectedOutDate)}', styles: PosStyles(align: PosAlign.center,height: PosTextSize.size1,width: PosTextSize.size1,underline: false));
    bytes+=generator.feed(1);
    bytes += generator.text('Sales : ${sale==null?'0':sale.length.toString()}', styles: PosStyles(align: PosAlign.center,underline: false));
    bytes += generator.text('Purchase : ${purchase==null?'0':purchase.length.toString()}', styles: PosStyles(align: PosAlign.center,underline: false));
    bytes += generator.text('Expense : ${expense==null?'0':expense.length.toString()}', styles: PosStyles(align: PosAlign.center,underline: false));
    bytes += generator.text('Return : ${noOfReturn.toString()==null?"0":noOfReturn.toString()}', styles: PosStyles(align: PosAlign.center,underline: false));
    bytes += generator.text('.........................', styles: PosStyles(align: PosAlign.center,underline: false));
    bytes += generator.text('Total Sales : ${totalSales.toStringAsFixed(2)}', styles: PosStyles(align: PosAlign.center,underline: false));
    bytes+=generator.feed(1);
    bytes += generator.text('Total Purchase : ${totalPurchase.toStringAsFixed(2)}', styles: PosStyles(align: PosAlign.center,underline: false));
    bytes+=generator.feed(1);
    bytes += generator.text('Total Expense : ${totalExp.toStringAsFixed(2)}', styles: PosStyles(align: PosAlign.center,underline: false));
    bytes+=generator.feed(1);
    bytes += generator.text('Total Return : ${returnAmount.toStringAsFixed(2)}', styles: PosStyles(align: PosAlign.center,underline: false));
    bytes+=generator.feed(1);
    bytes += generator.text('Vat Payable : ${((totVatSale*15/100)-totalvat).toStringAsFixed(2)}', styles: PosStyles(align: PosAlign.center,underline: false));
    bytes+=generator.feed(1);
    bytes += generator.text('Balance : ${(totalSales-totalPurchase-totalExp).toStringAsFixed(2)}', styles: PosStyles(align: PosAlign.center,underline: false));
    bytes+= generator.emptyLines(1);
    bytes += generator.feed(2);
    bytes += generator.cut();
    try {

      flutterUsbPrinter.write(Uint8List.fromList(bytes));
    }
    catch (error) {
      print(error.toString(),);
    }
    print("end");
    print(Timestamp.now().seconds);
  }
  getPurchase() async {
    print(datePicked1.toDate());
    print(datePicked2.toDate());

    QuerySnapshot purchases =await FirebaseFirestore.instance.collection('purchases')
        .doc(currentBranchId)
        .collection('purchases')
        .where('salesDate', isGreaterThanOrEqualTo:datePicked1)
        .where('salesDate', isLessThanOrEqualTo:datePicked2)
        .get();
    print('helloooooooooo subCollection');
    print(purchases.docs.length);
    purchase=purchases.docs;
    totalPurchase=0;
    totalvat=0;
    for(var data in purchases.docs){
      totalPurchase+=double.tryParse(data['amount'].toString());
      totalvat+=double.tryParse(data['gst'].toString());
    }
    setState(() {
      print('lengthhhhhhhh');
      print(totalPurchase);
      print(totalvat);
    });
  }

  var sale;
  double cashInHand=0;
  // double cashSaleNo=0;
  double cashInBank=0;
  // double bankSaleNo=0;
  double totalSales=0;
  double totVatSale=0;
  QuerySnapshot sales;
  getSales() async {
    print(datePicked1.toDate().toString().substring(0,10));
    print(datePicked2.toDate().toString().substring(0,10));
     sales =await FirebaseFirestore.instance.collection('sales')
        .doc(currentBranchId)
        .collection('sales')
        .where('salesDate', isGreaterThanOrEqualTo:datePicked1)
        .where('salesDate', isLessThanOrEqualTo:datePicked2)
        .get();
    sale=sales.docs;
    totalSales=0;
    cashInHand=0;
    // cashSaleNo=0;
    cashInBank=0;
    // bankSaleNo=0;
    salesList=[];
totVatSale=0;
    for(var data in sales.docs){
      totVatSale+=data.get('totalAmount');
    }

    for(var data in sales.docs){
      totalSales+=data.get('grandTotal');
      if(data.get('cash')==true&&data.get('bank')==true){
        // cashInHand+=data.get('grandTotal');
        cashInHand+=(double.tryParse(data.get('paidCash').toString())+double.tryParse(data.get('balance').toString()));
        cashInBank+=(double.tryParse(data.get('paidBank').toString()));
        // cashSaleNo+=1;
      }else if(data.get('cash')==true&&data.get('bank')==false){
        cashInHand+=(double.tryParse(data.get('paidCash').toString())+double.tryParse(data.get('balance').toString()));
        // cashInBank+=data.get('grandTotal');
        // bankSaleNo+=1;
      }else{
        cashInBank+=(double.tryParse(data.get('paidBank').toString()));
      }

      salesList.add({
        'no': data.get('invoiceNo'),
        'amount':data.get('grandTotal'),
      }
      );
    }

    setState(() {
      print(salesList.length);
      print(salesList);

    });

  }

  var purchase;
  double totalPurchase=0;
  double purchaseCash=0;
  double purchaseBank=0;


  var expense;
  double totalExp=0;
  double expCash=0;
  double expBank=0;
  DateTime selectedOutDate = DateTime.now();
  DateTime selectedFromDate = DateTime.now();
  getExpense() async {
    QuerySnapshot exp =await FirebaseFirestore.instance.collection('expenses')
        .doc(currentBranchId)
        .collection('expenses')
        .where('salesDate', isGreaterThanOrEqualTo:datePicked1)
        .where('salesDate', isLessThanOrEqualTo:datePicked2)
        .get();
    expense=exp.docs;
    totalExp=0;
    for(var data in exp.docs){
      totalExp+=data.get('amount');
      if(data.get('cash')==true){
        expCash+=double.tryParse(data.get('amount').toString());
      }else{
        expBank+=double.tryParse(data.get('amount').toString());
      }
    }
    setState(() {

    });
  }

  var rtns;
  int noOfReturn=0;
  double returnAmount=0;
  getReturn() async {
    QuerySnapshot rtn =await FirebaseFirestore.instance.collection('salesReturn')
        .doc(currentBranchId)
        .collection('salesReturn')
        .where('salesReturnDate', isGreaterThanOrEqualTo:datePicked1)
        .where('salesReturnDate', isLessThanOrEqualTo:datePicked2)
        .get();
    rtns=rtn.docs;
    noOfReturn=rtn.docs.length;
    returnAmount=0;
    for(var data in rtn.docs){
      print(data.get('grandTotal'));
      returnAmount+=double.tryParse(data.get('grandTotal').toString());

    }
    setState(() {

    });
  }

  List salesList=[];
  final format = DateFormat("yyyy-MM-dd hh:mm aaa");

  @override
  void initState() {
    super.initState();
    DateTime today=DateTime.now();
    selectedFromDate =DateTime(today.year,today.month,today.day,0,0,0);
    datePicked1 =Timestamp.fromDate(DateTime(today.year,today.month,today.day,0,0,0));
    datePicked2 =Timestamp.fromDate(DateTime(today.year,today.month,today.day,23,59,59));
    getSales();
    getPurchase();
    getExpense();
    getReturn();
  }
  @override
  Widget build(BuildContext context) {
    salesData=[];
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: default_color,
        automaticallyImplyLeading: true,
        title: Text(
          'Daily Report',
          style: FlutterFlowTheme.bodyText1.override(
            fontFamily: 'Poppins',
            color: Colors.white,
            fontSize: fontSize+5,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: InkWell(
                onTap: (){

                  if(blue){
                    bluetooth.printCustom('Reports', 2, 1);
                    bluetooth.printCustom('From ${DateFormat("yyyy-MM-dd hh:mm aaa").format(selectedFromDate)} To ${DateFormat("yyyy-MM-dd hh:mm aaa").format(selectedOutDate)}', 1, 1);
                    bluetooth.printCustom('Sales : ${sale==null?'0':sale.length.toString()}', 1, 1);
                    bluetooth.printCustom('Purchase : ${purchase==null?'0':purchase.length.toString()}', 1, 1);
                    bluetooth.printCustom('Expense : ${expense==null?'0':expense.length.toString()}', 1, 1);
                    bluetooth.printCustom('Return : ${noOfReturn.toString()}', 1, 1);
                    bluetooth.printCustom('........................................', 1, 1);
                    bluetooth.printCustom('Total sales : ${totalSales.toStringAsFixed(2)}', 1, 1);
                    bluetooth.printCustom('Total Purchase : ${totalPurchase.toStringAsFixed(2)}', 1, 1);
                    bluetooth.printCustom('Total Expense : ${totalExp.toStringAsFixed(2)}', 1, 1);
                    bluetooth.printCustom('Total Return : ${returnAmount.toStringAsFixed(2)}', 1, 1);
                    bluetooth.printCustom('Vat Payable : ${((totVatSale*15/100)-totalvat).toStringAsFixed(2)}', 1, 1);
                    bluetooth.printCustom('Balance : ${(totalSales-totalPurchase-totalExp).toStringAsFixed(2)}', 1, 1);
                    bluetooth.printNewLine();
                    bluetooth.printNewLine();

                    bluetooth.paperCut();

                  }else{
                    dailyPrint();

                  }



                },
                child: const Icon(Icons.print)),
          ),

        ],
        centerTitle: true,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {

          if(salesList.isNotEmpty){

            if(blue){
              bluetooth.printCustom('Sales Reports', 2, 1);
              bluetooth.printNewLine();
              bluetooth.printCustom('From ${DateFormat("yyyy-MM-dd hh:mm aaa").format(selectedFromDate)} To ${DateFormat("yyyy-MM-dd hh:mm aaa").format(selectedOutDate)}', 1, 1);
              bluetooth.printCustom('.....................................', 1, 1);
              bluetooth.printCustom('          No        Bill No        Amt', 1, 0);
              bluetooth.printCustom('.....................................', 1, 1);

              int i=1;
              double total=0;
              for(var item in salesList){
                bluetooth.printCustom('          $i         ${item['no']}         ${item['amount']}', 1, 0);

                total+=item['amount'];
                i++;
              }
              bluetooth.printCustom('........................................', 1, 1);
              bluetooth.printCustom('      Total : ${total.toStringAsFixed(2)}       ', 2, 2);
              bluetooth.printNewLine();
              bluetooth.printNewLine();
              bluetooth.printNewLine();
              bluetooth.printNewLine();
              bluetooth.paperCut();
            }else{
              abc(salesList);
            }

          }else{
            showUploadMessage(context, 'No Sales');
          }
        },
        backgroundColor: Color(0xFF2b0e10),
        elevation: 10,
        child: Icon(
          Icons.print,
          color: Colors.white,
          size: 24,
        ),
      ),


      backgroundColor: Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                // TextButton(
                //
                //     onPressed: () {
                //       showDatePicker(
                //           context: context,
                //           initialDate: selectedDate1,
                //           firstDate: DateTime(1901, 1),
                //           lastDate: DateTime(2100,1)).then((value){
                //
                //         setState(() {
                //           DateFormat("yyyy-MM-dd").format(value);
                //           datePicked1 = Timestamp.fromDate(DateTime(value.year,value.month,value.day,0,0,0));
                //           selectedDate1=value;
                //         });
                //       });
                //
                //     },
                //     child: Text(
                //       datePicked1==null?'Choose Ending Date': datePicked1.toDate().toString().substring(0,10),
                //       style: FlutterFlowTheme.bodyText1.override(
                //         fontFamily: 'Poppins',
                //         color: Colors.blue,
                //         fontSize: 13,
                //         fontWeight: FontWeight.w600,),
                //     )),
                // Text(
                //   'To',
                //   style: FlutterFlowTheme.bodyText1.override(
                //     fontFamily: 'Poppins',
                //   ),
                // ),
                // TextButton(
                //
                //     onPressed: () {
                //       showDatePicker(
                //           context: context,
                //           initialDate: selectedDate2,
                //           firstDate: DateTime(1901, 1),
                //           lastDate: DateTime(2100,1)).then((value){
                //
                //         setState(() {
                //           DateFormat("yyyy-MM-dd").format(value);
                //
                //           datePicked2 = Timestamp.fromDate(DateTime(value.year,value.month
                //               ,value.day,0,0,0));
                //
                //           selectedDate2=value;
                //         });
                //       });
                //
                //     },
                //     child: Text(
                //       datePicked2==null?'Choose Ending Date': datePicked2.toDate().toString().substring(0,10),
                //       style: FlutterFlowTheme.bodyText1.override(
                //         fontFamily: 'Poppins',
                //         color: Colors.blue,
                //         fontSize: 13,
                //         fontWeight: FontWeight.w600,),
                //     )),
                Container(
                  height: 50,
                  width: 220,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.white,
                          width: 1),
                      borderRadius:
                      BorderRadius.circular(
                          10)),
                  child: DateTimeField(
                    initialValue:selectedFromDate ,
                    format: format,
                    onShowPicker: (context,
                        currentValue) async {
                      final date =
                      await showDatePicker(
                          context: context,
                          firstDate:
                          DateTime(1900),
                          initialDate:
                          currentValue ??
                              DateTime
                                  .now(),
                          lastDate:
                          DateTime(2100));
                      if (date != null) {
                        final time =
                        await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay
                              .fromDateTime(
                              currentValue ??
                                  DateTime
                                      .now()),
                        );
                        selectedFromDate =
                            DateTime(
                                date.year,
                                date.month,
                                date.day,
                                time.hour,
                                time.minute);
                        datePicked1=Timestamp.fromDate(selectedFromDate);
                        return DateTimeField
                            .combine(date, time);
                      } else {
                        return currentValue;
                      }
                    },
                  ),
                ),
                Text(
                  'To',
                  style: FlutterFlowTheme.bodyText1.override(
                    fontFamily: 'Poppins',
                  ),
                ),
                Container(
                  height: 50,
                  width: 220,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.white,
                          width: 1),
                      borderRadius:
                      BorderRadius.circular(
                          10)),
                  child: DateTimeField(
                    initialValue:selectedOutDate ,
                    format: format,
                    onShowPicker: (context,
                        currentValue) async {
                      final date =
                      await showDatePicker(
                          context: context,
                          firstDate:
                          DateTime(1900),
                          initialDate:
                          currentValue ??
                              DateTime
                                  .now(),
                          lastDate:
                          DateTime(2100));
                      if (date != null) {
                        final time =
                        await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay
                              .fromDateTime(
                              currentValue ??
                                  DateTime
                                      .now()),
                        );
                        selectedOutDate =
                            DateTime(
                                date.year,
                                date.month,
                                date.day,
                                time.hour,
                                time.minute);
                        datePicked2=Timestamp.fromDate(selectedOutDate) ;
                        return DateTimeField
                            .combine(date, time);
                      } else {
                        return currentValue;
                      }
                    },
                  ),
                ),
                FlutterFlowIconButton(
                  borderColor: Colors.transparent,
                  borderRadius: 30,
                  borderWidth: 1,
                  buttonSize: 50,
                  icon: const FaIcon(
                    FontAwesomeIcons.search,
                    color: Colors.black,
                    size: 30,
                  ),
                  onPressed: () async {
                    if(datePicked1!=null&&datePicked2!=null){
                      print('pressed');
                      getSales();
                      getExpense();
                      getPurchase();
                      getReturn();

                      print('pressed1');
                    }else{
                      datePicked1==null? showUploadMessage(context, 'Please Choose Starting Date'):
                      showUploadMessage(context, 'Please Choose Ending Date');
                    }



                  },
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder:(context) => ProductReport(
                      salesData:sales,
                      From:selectedFromDate,
                      To:selectedOutDate,

                    ),));
                  },
                  child: Container(
                    width: 150,
                    height: 40,
                    decoration: BoxDecoration(
                        color: const Color(0xFF2b0e10),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: const Center(
                      child: Text('Product Report',style: TextStyle(
                          fontSize: 16,
                          color: Colors.white
                      ),),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder:(context) => CategoryReport(
                      salesData:sales,
                      From:selectedFromDate,
                      To:selectedOutDate,

                    ),));
                  },
                  child: Container(
                    width: 150,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Color(0xFF2b0e10),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Center(
                      child: Text('Category Report',style: TextStyle(
                          fontSize: 16,
                          color: Colors.white
                      ),),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder:(context) => IngredientReport(
                      salesData:sales,
                      From:selectedFromDate,
                      To:selectedOutDate,

                    ),));
                  },
                  child: Container(
                    width: 150,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Color(0xFF2b0e10),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Center(
                      child: Text('Ingredient  Report',style: TextStyle(
                          fontSize: 16,
                          color: Colors.white
                      ),),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {

                    try {
                      final invoice =
                      DailyReportData(

                        from:selectedFromDate,
                        to: selectedOutDate,
                        purchaseAmount: totalPurchase,
                        expenseAmount: totalExp,
                        saleAmount: totalSales,
                        balance: totalSales-totalPurchase-totalExp-returnAmount,
                        rtn:noOfReturn,
                        rtnAmount: returnAmount,
                        sale:double.tryParse(sale.length.toString()),
                        purchase:double.tryParse(purchase.length.toString()),
                        expense:double.tryParse(expense.length.toString()),
                        userSaleData: salesData,
                        vatPayable:double.tryParse(((totVatSale*15/100)-totalvat).toStringAsFixed(2))

                      );

                      final pdfFile =
                          await B2bPdfInvoiceApi.generate(invoice);
                      await PdfApi.openFile(pdfFile);
                    } catch (e) {
                      print(e);
                      // return showDialog(
                      //     context: context,
                      //     builder: (context) {
                      //       return AlertDialog(
                      //         title: Text('error'),
                      //         content: Text(e.toString()),
                      //
                      //         actions: <Widget>[
                      //           new FlatButton(
                      //             child: new Text('ok'),
                      //             onPressed: () {
                      //               Navigator.of(context).pop();
                      //             },
                      //           )
                      //         ],
                      //       );
                      //     });
                    }

                  },
                  child: Container(
                    width: 150,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Color(0xFF2b0e10),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Center(
                      child: Text('Genarate PDF',style: TextStyle(
                        fontSize: 16,
                        color: Colors.white
                      ),),
                    ),
                  ),
                ),

              ],
            ),

            SizedBox(height:40),
            Padding(
              padding: const EdgeInsets.only(left: 30,right: 30),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Material(
                    color: Colors.transparent,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: InkWell(
                      onTap: () async {
                        await  Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>  SalesReport()),
                        );
                      },
                      child: Container(
                        width: 170,
                        height: 150,
                        decoration: BoxDecoration(
                          color: Color(0xFFEEEEEE),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Sales',
                              style: FlutterFlowTheme.bodyText1.override(
                                fontFamily: 'Poppins',
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              sale==null?'0':sale.length.toString(),
                              style: FlutterFlowTheme.bodyText1.override(
                                fontFamily: 'Poppins',
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              'TOTAL SAR ${totalSales.toStringAsFixed(2)}',
                              style: FlutterFlowTheme.bodyText1.override(
                                fontFamily: 'Poppins',
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10,right: 10),
                              child: Divider(color: Colors.grey,thickness: 1,),
                            ),
                            Text(
                              'CASH : SAR ${cashInHand.toStringAsFixed(2)}',
                              style: FlutterFlowTheme.bodyText1.override(
                                fontFamily: 'Poppins',
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              'Bank : SAR ${cashInBank.toStringAsFixed(2)}',
                              style: FlutterFlowTheme.bodyText1.override(
                                fontFamily: 'Poppins',
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: InkWell(
                      onTap: () async {

                        await  Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>  PurchaseReport()),
                        );
                      },
                      child: Container(
                        width: 170,
                        height: 150,
                        decoration: BoxDecoration(
                          color: Color(0xFFEEEEEE),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Purchase',
                              style: FlutterFlowTheme.bodyText1.override(
                                fontFamily: 'Poppins',
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              purchase==null?'0':purchase.length.toString(),
                              style: FlutterFlowTheme.bodyText1.override(
                                fontFamily: 'Poppins',
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                               // 'SAR ${(totalPurchase+totalvat).toStringAsFixed(2)}',
                               'SAR ${totalPurchase.toStringAsFixed(2)}',
                              style: FlutterFlowTheme.bodyText1.override(
                                fontFamily: 'Poppins',
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10,right: 10),
                              child: Divider(color: Colors.grey,thickness: 1,),
                            ),
                            Text(
                              'CASH : SAR ${purchaseCash.toStringAsFixed(2)}',
                              style: FlutterFlowTheme.bodyText1.override(
                                fontFamily: 'Poppins',
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              'Bank : SAR ${purchaseBank.toStringAsFixed(2)}',
                              style: FlutterFlowTheme.bodyText1.override(
                                fontFamily: 'Poppins',
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: InkWell(
                      onTap: () async {
                        await  Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>  ExpenseReport()),
                        );

                      },
                      child: Container(
                        width: 170,
                        height: 150,
                        decoration: BoxDecoration(
                          color: Color(0xFFEEEEEE),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Expense',
                              style: FlutterFlowTheme.bodyText1.override(
                                fontFamily: 'Poppins',
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              expense==null?'0':expense.length.toString(),
                              style: FlutterFlowTheme.bodyText1.override(
                                fontFamily: 'Poppins',
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              'SAR ${totalExp.toStringAsFixed(2)}',
                              style: FlutterFlowTheme.bodyText1.override(
                                fontFamily: 'Poppins',
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10,right: 10),
                              child: Divider(color: Colors.grey,thickness: 1,),
                            ),
                            Text(
                              'CASH : SAR ${expCash.toStringAsFixed(2)}',
                              style: FlutterFlowTheme.bodyText1.override(
                                fontFamily: 'Poppins',
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              'Bank : SAR ${expBank.toStringAsFixed(2)}',
                              style: FlutterFlowTheme.bodyText1.override(
                                fontFamily: 'Poppins',
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Container(
                      width: 170,
                      height: 150,
                      decoration: BoxDecoration(
                        color: Color(0xFFEEEEEE),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Return',
                            style: FlutterFlowTheme.bodyText1.override(
                              fontFamily: 'Poppins',
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 1,),
                          Text(
                            noOfReturn.toString(),
                            style: FlutterFlowTheme.bodyText1.override(
                              fontFamily: 'Poppins',
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 1,),
                          Text(
                            'SAR ${returnAmount.toStringAsFixed(2)}',
                            style: FlutterFlowTheme.bodyText1.override(
                              fontFamily: 'Poppins',
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    // onTap: (){
                    //   Navigator.of(context).push(MaterialPageRoute(builder: (context) => VatReport(),));
                    // },
                    child: Material(
                      color: Colors.transparent,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Container(
                        width: 170,
                        height: 150,
                        decoration: BoxDecoration(
                          color: Color(0xFFEEEEEE),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'VAT Payable',
                              style: FlutterFlowTheme.bodyText1.override(
                                fontFamily: 'Poppins',
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 1,),
                            Text(
                              'SAR ${((totVatSale*15/100)-totalvat).toStringAsFixed(2)}',

                              style: FlutterFlowTheme.bodyText1.override(
                                fontFamily: 'Poppins',
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Container(
                      width: 170,
                      height: 150,
                      decoration: BoxDecoration(
                        color: Color(0xFFEEEEEE),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Balance',
                            style: FlutterFlowTheme.bodyText1.override(
                              fontFamily: 'Poppins',
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 1,),
                          Text(
                            'SAR ${(totalSales-totalExp-totalPurchase-returnAmount).toStringAsFixed(2)}',
                            style: FlutterFlowTheme.bodyText1.override(
                              fontFamily: 'Poppins',
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  

                ],
              ),
            ),

            SizedBox(height: 20,),

            Expanded(
              child:   FittedBox(
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text(
                        'Name',
                        style: TextStyle(fontWeight: FontWeight.bold)
                    )),
                    DataColumn(label: Text(
                        'Sale',
                        style: TextStyle( fontWeight: FontWeight.bold)
                    )),
                    DataColumn(label: Text(
                        'Cash (S)',
                        style: TextStyle( fontWeight: FontWeight.bold)
                    )),
                    DataColumn(label: Text(
                        'Bank  (S)',
                        style: TextStyle(fontWeight: FontWeight.bold)
                    )),
                    DataColumn(label: Text(
                        'Purchase',
                        style: TextStyle( fontWeight: FontWeight.bold)
                    )),
                    DataColumn(label: Text(
                        'Cash (P)',
                        style: TextStyle(fontWeight: FontWeight.bold)
                    )),
                    DataColumn(label: Text(
                        'Bank (P)',
                        style: TextStyle( fontWeight: FontWeight.bold)
                    )),
                    DataColumn(label: Text(
                        'Expense',
                        style: TextStyle( fontWeight: FontWeight.bold)
                    )),
                    DataColumn(label: Text(
                        'Cash (E)',
                        style: TextStyle( fontWeight: FontWeight.bold)
                    )),
                    DataColumn(label: Text(
                        'Bank (E)',
                        style: TextStyle( fontWeight: FontWeight.bold)
                    )),
                    DataColumn(label: Text(
                        'Return',
                        style: TextStyle( fontWeight: FontWeight.bold)
                    )),
                    DataColumn(label: Text(
                        'Print',
                        style: TextStyle( fontWeight: FontWeight.bold)
                    )),
                    // DataColumn(label: Text(
                    //     'Balance',
                    //     style: TextStyle( fontWeight: FontWeight.bold)
                    // )),
                  ],
                  rows: List.generate(
                      posUsers.length,
                          (index) {


                        double usrBalance=0;
                            int userTotalSaleNo=0;
                            double userTotalSaleAmount=0;
                            double userTotalSaleAmountInCash=0;
                            double userTotalSaleAmountInBank=0;
                            if(sale!=null){
                              String uId=posUsers[index].id;
                              for(var userSale in sale){
                                if(userSale.get('currentUserId')==uId){
                                  userTotalSaleNo+=1;
                                  userTotalSaleAmount+=userSale.get('grandTotal');

                                  if(userSale.get('cash')==true&&userSale.get('bank')==true){
                                    userTotalSaleAmountInCash+=(double.tryParse(userSale.get('paidCash').toString())+double.tryParse(userSale.get('balance').toString()));
                                    userTotalSaleAmountInBank+=userSale.get('paidBank');

                                  }else if(userSale.get('cash')==true&&userSale.get('bank')==false){
                                    userTotalSaleAmountInCash+=(double.tryParse(userSale.get('paidCash').toString())+double.tryParse(userSale.get('balance').toString()));
                                  }else{
                                    userTotalSaleAmountInBank+=userSale.get('paidBank');

                                  }
                                }
                              }


                            }

                            int userPurchaseNo=0;
                            double userPurchaseAmount=0;
                            double userPurchaseAmountInCash=0;
                            double userPurchaseAmountInBank=0;
                            if(purchase!=null){
                              String uId=posUsers[index].id;
                              for(var userPurchase in purchase){
                                if(userPurchase.get('currentUserId')==uId){
                                  userPurchaseNo+=1;
                                  userPurchaseAmount+=double.tryParse(userPurchase.get('amount').toString())??0;
                                  if(userPurchase.get('cash')==true){
                                    userPurchaseAmountInCash+=userPurchase.get('amount');
                                  }else{
                                    userPurchaseAmountInBank+=userPurchase.get('amount');
                                  }
                                }
                              }
                            }

                            int userExpNo=0;
                            double userExpAmount=0;
                            double userExpAmountInCash=0;
                            double userExpAmountInBank=0;
                            if(expense!=null){
                              String uId=posUsers[index].id;
                              for(var userPurchase in expense){
                                if(userPurchase.get('currentUserId')==uId){
                                  userExpNo+=1;
                                  userExpAmount+=userPurchase.get('amount');
                                  if(userPurchase.get('cash')==true){
                                    userExpAmountInCash+=userPurchase.get('amount');
                                  }else{
                                    userExpAmountInBank+=userPurchase.get('amount');
                                  }
                                }
                              }
                            }
                            
                            double userReturnAmount=0;
                            if(rtns!=null){
                              String uId=posUsers[index].id;
                              for(var item in rtns){
                                if(item.get('currentUserId')==uId) {
                                  userReturnAmount+=double.tryParse(item.get('grandTotal').toString());
                                }
                              }
                            }


                        salesData.add({
                          'name':posUsers[index]['name'],
                          'saleAmount':userTotalSaleAmount,
                          'saleAmountCash':userTotalSaleAmountInCash,
                          'saleAmountBank':userTotalSaleAmountInBank,
                          'puchaseAmount':userPurchaseAmount,
                          'purchaseAmountCash':userPurchaseAmountInCash,
                          'purchaseAmountBank':userPurchaseAmountInBank,
                          'expenseAmount':userExpAmount,
                          'expenseAmountInCash':userExpAmountInCash,
                          'expenseAmountInBank':userExpAmountInBank,
                          'returnAmount':userReturnAmount
                        });

                        usrBalance=userTotalSaleAmount-(userPurchaseAmount+userExpAmount);
                        return DataRow(
                            cells: [
                              DataCell(Text(posUsers[index]['name'],style: TextStyle(fontWeight: FontWeight.w500),)),
                              DataCell(Text(userTotalSaleAmount.toStringAsFixed(2))),
                              DataCell(Text(userTotalSaleAmountInCash.toStringAsFixed(2))),
                              DataCell(Text(userTotalSaleAmountInBank.toStringAsFixed(2))),
                              DataCell(Text(userPurchaseAmount.toStringAsFixed(2))),
                              DataCell(Text(userPurchaseAmountInCash.toStringAsFixed(2))),
                              DataCell(Text(userPurchaseAmountInBank.toStringAsFixed(2))),
                              DataCell(Text(userExpAmount.toStringAsFixed(2))),
                              DataCell(Text(userExpAmountInCash.toStringAsFixed(2))),
                              DataCell(Text(userExpAmountInBank.toStringAsFixed(2))),
                              DataCell(Text(userReturnAmount.toStringAsFixed(2))),
                              // DataCell(Text(usrBalance.toStringAsFixed(2))),
                              DataCell(InkWell(
                                  onTap: () async {
                                    if(salesList.isNotEmpty){
                                      if(blue) {
                                        bluetooth.printCustom('Sales Reports', 2, 1);
                                        bluetooth.printNewLine();
                                        bluetooth.printCustom(
                                            'From ${DateFormat("yyyy-MM-dd hh:mm aaa").format(selectedFromDate)} To ${DateFormat("yyyy-MM-dd hh:mm aaa").format(selectedOutDate)}', 1,
                                            1);
                                        bluetooth.printNewLine();
                                        // bluetooth.printCustom('  user Name: ${posUsers[index]['name']}', 1, 0);
                                        // bluetooth.printCustom('  user Name: ${posUsers[index]['name']}', 1, 0);
                                        ScreenshotController screenshotController = ScreenshotController();
                                        var  capturedImage1= await    screenshotController
                                            .captureFromWidget(Container(
                                            color: Colors.white,
                                            width: printWidth*2,
                                            height: 55,
                                            child:
                                            Column(
                                              mainAxisAlignment:MainAxisAlignment.center,
                                              children: [
                                                Text('CASHIER : ${posUsers[index]['name']}',style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),),
                                                 Text('  المحاسب :${posUsers[index]['arabicName']} ',style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),),

                                              ],)));
                                        bluetooth.printImageBytes(capturedImage1);

                                        bluetooth.printNewLine();
                                        bluetooth.printCustom(
                                            '           No         Bill No      Amt', 1, 0);
                                        bluetooth.printCustom(
                                            '..................................', 1, 1);


                                        int i = 1;
                                        double total = 0;
                                        if (sale != null) {
                                          String uId = posUsers[index].id;

                                          for (var item in sale) {
                                            print(item);
                                            if (item.get('currentUserId') == uId) {
                                              bluetooth.printCustom('           $i         ${item['invoiceNo']}         ${item['grandTotal']}', 1, 0);

                                              total += item['grandTotal'];
                                              i++;
                                            }
                                          }
                                        }
                                        bluetooth.printCustom(
                                            '................................', 1, 1);
                                        bluetooth.printCustom(
                                            'CASH  = ${userTotalSaleAmountInCash.toStringAsFixed(2)}', 1, 1);
                                        bluetooth.printNewLine();
                                        bluetooth.printCustom(
                                            'BANK  = ${(userTotalSaleAmountInBank.toStringAsFixed(2))}', 1, 1);
                                        bluetooth.printNewLine();
                                        bluetooth.printCustom(
                                            'Total : ${(userTotalSaleAmount.toStringAsFixed(2))}       ', 2, 2);
                                        bluetooth.printNewLine();
                                        bluetooth.printNewLine();
                                        bluetooth.printNewLine();
                                        bluetooth.printNewLine();
                                        bluetooth.paperCut();

                                      }else{
                                        daily_user_report(salesList,posUsers[index]['name'],userTotalSaleAmountInCash.toStringAsFixed(2),(userTotalSaleAmountInBank.toStringAsFixed(2)),(userTotalSaleAmount.toStringAsFixed(2)),posUsers[index].id.toString(),posUsers[index]['arabicName']);
                                      }

                                    }else{
                                      showUploadMessage(context, 'No Sales');
                                    }
                                  },
                                  child: CircleAvatar(backgroundColor: Color(0xFF2b0e10),radius: 17,child: Icon(Icons.print,size: 18,),))),
                            ]);
                      }
                ),
                ),
              )


            )

          ],
        ),
      ),
    );





  }
}