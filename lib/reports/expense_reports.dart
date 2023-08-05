//@dart=2.9
import 'package:awafi_pos/Branches/branches.dart';
import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:esc_pos_printer/esc_pos_printer.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:awafi_pos/order_details/order_details_widget.dart';
import 'package:awafi_pos/view_invoice/view_invoice.dart';
import 'package:intl/intl.dart';

import '../DailyReport/genaratePDF/expensePdf.dart';
import '../DailyReport/genaratePDF/expenseReportModel.dart';
import '../DailyReport/genaratePDF/pdf_api.dart';
import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../flutter_flow/upload_media.dart';
import '../main.dart';


import 'package:ping_discover_network/ping_discover_network.dart';
// import 'package:wifi/wifi.dart';

class ExpenseReport extends StatefulWidget {
  const ExpenseReport({Key key}) : super(key: key);

  @override
  _ExpenseReportState createState() => _ExpenseReportState();
}

class _ExpenseReportState extends State<ExpenseReport> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController invoiceController;
  DateTime fromDate=DateTime.now();
  DateTime toDate=DateTime.now();
  QuerySnapshot invoices;
  final format = DateFormat("yyyy-MM-dd hh:mm aaa");
  DateTime selectedOutDate = DateTime.now();
  DateTime selectedFromDate = DateTime.now();
  @override
  void initState() {
    invoiceController=TextEditingController();
    super.initState();
    getDailyInvoice();
    DateTime today=DateTime.now();
    selectedFromDate =DateTime(today.year,today.month,today.day,0,0,0);
  }
  getInvoiceByNo() async {
    invoices = await FirebaseFirestore.instance
        .collection('expenses')
        .doc(currentBranchId)
        .collection('expenses')
        .where('invoiceNo', isEqualTo: invoiceController.text)
        .get();
    setState(() {});
  }

  List invoiceList = [];
  getInvoiceByDate() async {
    if (fromDate != null && toDate != null) {
      print(fromDate);
      print(toDate);
      print(selectedFromDate);
      print(selectedOutDate);
      Timestamp fromDateTimeStamp = Timestamp.fromDate(selectedFromDate);
      Timestamp toDateTimeStamp = Timestamp.fromDate(selectedOutDate);
      FirebaseFirestore.instance
          .collection('expenses')
          .doc(currentBranchId)
          .collection('expenses')
          .where('salesDate', isGreaterThanOrEqualTo: fromDateTimeStamp)
          .where('salesDate', isLessThan: toDateTimeStamp)
          .get()
          .then((value) {
        invoices = value;
        for (var item in value.docs) {
          invoiceList.add({
            'staff': PosUserIdToName[item['currentUserId']],
            'amount': item['amount'],
            'invoiceNo': item['invoiceNo'],
            'description': item['description'],
            'voucherNo': item['voucherNo'],
          });
          setState(() {});
        }
      });
    }
  }

  getDailyInvoice() async {
    var now = DateTime.now();
    var lastMidnight =
    Timestamp.fromDate(DateTime(now.year, now.month, now.day));

    FirebaseFirestore.instance
        .collection('expenses')
        .doc(currentBranchId)
        .collection('expenses')
        .where('salesDate', isGreaterThanOrEqualTo: lastMidnight)
        .get()
        .then((value) {
      invoices = value;
      for (var item in value.docs) {
        print(123);
        invoiceList.add({
          'staff': PosUserIdToName[item['currentUserId']],
          'amount': item['amount'],
          'invoiceNo': item['invoiceNo'],
          'description': item['description'],
          'voucherNo': item['voucherNo'],
          'salesDate':item['salesDate']
        });
        setState(() {});
      }
    });
    setState(() {});
  }



  void checkPortRange(String subnet, int fromPort, int toPort) {
    if (fromPort > toPort) {
      return;
    }

    print('port ${fromPort}');

    final stream = NetworkAnalyzer.discover2(subnet, fromPort);

    stream.listen((NetworkAddress addr) {
      if (addr.exists) {
        print('Found device: ${addr.ip}:${fromPort}');
      }
    }).onDone(() {
      checkPortRange(subnet, fromPort + 1, toPort);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: default_color,
        automaticallyImplyLeading: true,
        title: Text(
          'Expense Reports',
          style: FlutterFlowTheme.title1.override(
              fontFamily: 'Poppins',color: Colors.white
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: InkWell(
              onTap: () async {
                try {
                  final invoice = ExpenseReportData(
                    InvoiceList: invoiceList,
                    From: selectedFromDate,
                    To: selectedOutDate,
                  );

                  final pdfFile = await ExpensePdfPage.generate(invoice);
                  await PdfApi.openFile(pdfFile);
                } catch (e) {
                  print(e);
                  return showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('error'),
                          content: Text(e.toString()),
                          actions: <Widget>[
                            TextButton(
                              child: new Text('ok'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                        );
                      });
                }
              },
              child: Container(
                height: 30,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.white, width: 2)),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10),
                    child: Text(
                      "Download pdf",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Container(
                    width: 200,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.white),
                    child: Center(
                      child: TextFormField(
                        controller: invoiceController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: 'Bill No',
                          hoverColor: Colors.red,
                          hintText: 'search bill no',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.pink.shade900, width: 1.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20,),
                  TextButton(
                    onPressed: (){
                      FocusScope.of(context).unfocus();
                      getInvoiceByNo();

                    },
                    child: const Text('Search By invoiceNo'),
                  ),
                  // const SizedBox(width: 50,),
                  // InkWell(
                  //   onTap: () async {
                  //     final DateTime picked = await showDatePicker(
                  //         context: context,
                  //         initialDate: fromDate??DateTime.now(),
                  //         firstDate: DateTime(2015, 8),
                  //         lastDate: DateTime(2101));
                  //     if (picked != null && picked != fromDate) {
                  //       setState(() {
                  //         fromDate = picked;
                  //       });
                  //     }
                  //   },
                  //   child:Container(
                  //     width: 200,
                  //     decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(3),
                  //         color: Colors.white),
                  //     child: Center(
                  //       child: Text(
                  //           fromDate==null?'Date From':fromDate.toLocal().toString().substring(0,10)
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // const SizedBox(width: 20,),
                  // InkWell(
                  //   onTap: () async {
                  //     final DateTime picked = await showDatePicker(
                  //         context: context,
                  //         initialDate: toDate??DateTime.now(),
                  //         firstDate: DateTime(2015, 8),
                  //         lastDate: DateTime(2101));
                  //     if (picked != null && picked != toDate) {
                  //       setState(() {
                  //         toDate = picked;
                  //       });
                  //     }
                  //   },
                  //   child:Container(
                  //     width: 200,
                  //     decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(3),
                  //         color: Colors.white),
                  //     child: Center(
                  //       child: Text(
                  //           toDate==null?'To Date ':toDate.toLocal().toString().substring(0,10)
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // const SizedBox(width: 20,),
                  const SizedBox(width: 50,),
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
                          // datePicked1=Timestamp.fromDate(selectedFromDate);
                          return DateTimeField
                              .combine(date, time);
                        } else {
                          return currentValue;
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 50,),
                  Text(
                    'To',
                    style: FlutterFlowTheme.bodyText1.override(
                        fontFamily: 'Poppins',fontWeight: FontWeight.bold
                    ),
                  ),
                  const SizedBox(width: 50,),
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
                          // datePicked2=Timestamp.fromDate(selectedOutDate) ;
                          return DateTimeField
                              .combine(date, time);
                        } else {
                          return currentValue;
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 50,),
                  TextButton(
                    onPressed: (){
                      getInvoiceByDate();
                    },
                    child: const Text('Search By Date'),
                  ),
                  // InkWell
                  //   (
                  //     onTap: () async {
                  //       // checkPortRange('192.168.1', 9100, 9110);
                  //       // return;
                  //       const PaperSize paper = PaperSize.mm80;
                  //       final profile = await CapabilityProfile.load();
                  //       final printer = NetworkPrinter(paper, profile);
                  //
                  //      print('1.                $printer');
                  //
                  //       try{
                  //         // await printer.connect('192.168.123.100', port: 9100);
                  //         final PosPrintResult res = await printer.connect('192.168.1.222', port: 9100,timeout: const Duration(seconds: 10));
                  //       print('0.                ${res.value}');
                  //       print(res.msg);
                  //       if (res == PosPrintResult.success) {
                  //         print('SUUUUUUUUU');
                  //         testReceipt(printer);
                  //       }else
                  //       {
                  //         print("no printer found");
                  //       }
                  //       }catch(e){
                  //         print("button catch");
                  //         print(e.toString());
                  //       }
                  //     },
                  //     child: const Text('Eprint test',style: TextStyle(color: Colors.red),)),
                ],

              ),
            ),

            Expanded(
              child: GridView.builder(
                shrinkWrap: true,
                primary: false,
                padding: const EdgeInsets.all(10),
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  crossAxisSpacing: 10,
                  mainAxisSpacing:10,
                  childAspectRatio: .7,
                ),

                itemCount:
                invoices==null?0:invoices.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot invoice =
                  invoices.docs[index];
                  return  InkWell(
                    // onTap: () async {
                    //   await Navigator.push(
                    //     context,
                    //     MaterialPageRoute(builder: (context) =>  ViewInvoice(invoiceNo: int.tryParse(invoice.id)??0,)),
                    //   );
                    // },
                    child:  Card(
                      child: Column(
                        children: [
                          Expanded(
                            child: Container(
                              color: Colors.grey.shade300,
                                height: 200,
                                child:invoice.get('image')!='' && invoice.get('image')!=null
                                    ? CachedNetworkImage(
                                    imageUrl: invoice.get('image')
                                  ,fit: BoxFit.cover,
                                )
                                :Container(
                                    height:220
                                ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10,right: 10),
                            child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Voucher No"),
                                  Text(":"),
                                  Text(invoice
                                      .get('voucherNo')
                                      .toString())
                                ]),
                          ),
                          Divider(),
                          Padding(
                              padding: const EdgeInsets.only(left: 10,right: 10),
                              child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Invoice No"),
                                    Text(":"),
                                    Text(invoice
                                        .get('invoiceNo')
                                        .toString()),
                                  ])),
                          Divider(),
                          Padding(
                            padding: const EdgeInsets.only(left: 10,right: 10),
                            child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(" Amount"),
                                  Text(":"),
                                  Text(
                                      invoice.get('amount').toString()),
                                ]),
                          ),
                          Divider(),
                          // Padding(
                          //     padding: const EdgeInsets.only(left: 10,right: 10),
                          //     child: Row(
                          //         mainAxisAlignment:
                          //         MainAxisAlignment.spaceBetween,
                          //         children: [
                          //           Text("Vat Amount"),
                          //           Text(":"),
                          //           Text(invoice.get('gst').toString()),
                          //         ])
                          // ),
                          // Divider(),
                          Padding(
                              padding: const EdgeInsets.only(left: 10,right: 10),
                              child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Description"),
                                    Text(":"),
                                    Text(invoice
                                        .get('description')
                                        .toString()),
                                  ]
                              )
                          ),
                          Divider(),
                          Padding(
                              padding: const EdgeInsets.only(left: 10,right: 10),
                              child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Staff"),
                                    Text(":"),
                                    Text(PosUserIdToName[invoice
                                        .get('currentUserId')
                                        .toString()]),
                                  ]
                              )
                          ),
                          IconButton(onPressed: () async {

                            bool proceed = await alert(context, 'You want to Delete?');
                            if(proceed){
                              invoice.reference.delete();
                              setState(() {

                              });
                              Navigator.pop(context);
                            }



                          }, icon: Icon(Icons.delete,color: Colors.red,))

                        ],
                      ),
                    ),
                  ) ;
                },
              ),
            )
          ],
        ),
      ),
    );

  }

}





