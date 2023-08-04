//@dart=2.9
import 'package:awafi_pos/Branches/branches.dart';
import 'package:awafi_pos/return/view_return.dart';
import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../main.dart';

class SalesReturnReport extends StatefulWidget {
  const SalesReturnReport({Key key}) : super(key: key);

  @override
  _SalesReturnReportState createState() => _SalesReturnReportState();
}

class _SalesReturnReportState extends State<SalesReturnReport> {
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
    invoiceController = TextEditingController();
    super.initState();
    getDailyInvoice();
    DateTime today=DateTime.now();
    selectedFromDate =DateTime(today.year,today.month,today.day,0,0,0);
  }

  getInvoiceByNo() async {
    invoices = await FirebaseFirestore.instance
        .collection('salesReturn')
        .doc(currentBranchId)
        .collection('salesReturn')
        .where('invoiceNo', isEqualTo: int.tryParse(invoiceController.text))
        .get();
    setState(() {});
  }

  getInvoiceByDate() async {
    if (fromDate != null && toDate != null) {
      Timestamp fromDateTimeStamp = Timestamp.fromDate(selectedFromDate);
      Timestamp toDateTimeStamp = Timestamp.fromDate(DateTime(toDate.year, toDate.month, toDate.day));
      invoices = await FirebaseFirestore.instance
          .collection('salesReturn')
          .doc(currentBranchId)
          .collection('salesReturn')
          .where('salesReturnDate', isGreaterThanOrEqualTo: fromDateTimeStamp)
          .where('salesReturnDate', isLessThan: toDateTimeStamp)
          .get();
      setState(() {});
    }
  }

  getDailyInvoice() async {
    var now = DateTime.now();
    var lastMidnight =
    Timestamp.fromDate(DateTime(now.year, now.month, now.day));

    invoices = await FirebaseFirestore.instance
        .collection('salesReturn')
        .doc(currentBranchId)
        .collection('salesReturn')
        .where('salesReturnDate', isGreaterThanOrEqualTo: lastMidnight)
        .get();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: default_color,
        automaticallyImplyLeading: true,
        title: Text(
          'Returns',
          style: FlutterFlowTheme.title1
              .override(fontFamily: 'Poppins', color: Colors.white),
        ),
        actions: [],
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Row(
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
                        labelText: 'Return No',
                        hoverColor: Colors.red,
                        hintText: 'search Return no',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.pink.shade900, width: 1.0),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                TextButton(
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    getInvoiceByNo();
                  },
                  child: const Text('Search By Return no'),
                ),
                const SizedBox(
                  width: 50,
                ),
                // InkWell(
                //   onTap: () async {
                //     final DateTime picked = await showDatePicker(
                //         context: context,
                //         initialDate: fromDate ?? DateTime.now(),
                //         firstDate: DateTime(2015, 8),
                //         lastDate: DateTime(2101));
                //     if (picked != null && picked != fromDate) {
                //       setState(() {
                //         fromDate = picked;
                //       });
                //     }
                //   },
                //   child: Container(
                //     width: 200,
                //     decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(3),
                //         color: Colors.white),
                //     child: Center(
                //       child: Text(fromDate == null
                //           ? 'Date From'
                //           : fromDate.toLocal().toString().substring(0, 10)),
                //     ),
                //   ),
                // ),
                // const SizedBox(
                //   width: 20,
                // ),
                // InkWell(
                //   onTap: () async {
                //     final DateTime picked = await showDatePicker(
                //         context: context,
                //         initialDate: toDate ?? DateTime.now(),
                //         firstDate: DateTime(2015, 8),
                //         lastDate: DateTime(2101));
                //     if (picked != null && picked != toDate) {
                //       setState(() {
                //         toDate = picked;
                //       });
                //     }
                //   },
                //   child: Container(
                //     width: 200,
                //     decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(3),
                //         color: Colors.white),
                //     child: Center(
                //       child: Text(toDate == null
                //           ? 'To Date '
                //           : toDate.toLocal().toString().substring(0, 10)),
                //     ),
                //   ),
                // ),
                // const SizedBox(
                //   width: 20,
                // ),
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
                  onPressed: () {
                    getInvoiceByDate();
                  },
                  child: const Text('Search By Date'),
                ),
              ],
            ),
            Expanded(
              child: GridView.builder(
                shrinkWrap: true,
                primary: false,
                padding: const EdgeInsets.all(10),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1.0,
                ),
                itemCount: invoices == null ? 0 : invoices.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot invoice = invoices.docs[index];
                  double price = invoice.get('totalAmount');
                  double vat = invoice.get('tax');
                  return InkWell(
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ViewReturnInvoice(
                              invoiceNo: int.tryParse(invoice.id) ?? 0,
                            )),
                      );
                    },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Invoice No',style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16
                                ),),
                                Text(':',style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16
                                ),),
                                Text(invoice.id,style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16
                                ),),
                              ],
                            ),
                            SizedBox(height: 5,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Sale Invoice',style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16
                                ),),
                                Text(':',style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16
                                ),),
                                Text(invoice.get('salesInvoiceNo'),style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16
                                ),),
                              ],
                            ),
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Total Amount'),
                                Text(':'),
                                Text(price.toStringAsFixed(2)),
                              ],
                            ),
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Vat Amount'),
                                Text(':'),
                                Text(vat.toStringAsFixed(2)),
                              ],
                            ),
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Discount'),
                                Text(':'),
                                Text(invoice.get('discount').toString()),
                              ],
                            ),
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Grand Total',style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16
                                ),),
                                Text(':',style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16
                                ),),
                                Text(invoice.get('grandTotal').toStringAsFixed(2),style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16
                                ),),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
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
