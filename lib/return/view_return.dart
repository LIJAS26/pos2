//@dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:awafi_pos/flutter_flow/flutter_flow_theme.dart';
import '../Branches/branches.dart';
import '../main.dart';

List<Map<String, dynamic>> returnItems = [];

class ViewReturnInvoice extends StatefulWidget {
  final int invoiceNo;
  const ViewReturnInvoice({
    Key key,
    this.invoiceNo,
  }) : super(key: key);

  @override
  _ViewReturnInvoiceState createState() => _ViewReturnInvoiceState();
}

class _ViewReturnInvoiceState extends State<ViewReturnInvoice> {
  QuerySnapshot invoices;
  DocumentSnapshot invoice;
  int token=0;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    returnItems = [];
    super.initState();
    getInvoiceByNo();

  }

  getInvoiceByNo() async {
    invoices = await FirebaseFirestore.instance
        .collection('salesReturn')
        .doc(currentBranchId)
        .collection('salesReturn')
        .where('invoiceNo', isEqualTo: widget.invoiceNo)
        .get();
    print("sdfghjkl");
    print(invoices.docs.length);
    if (invoices.docs.isNotEmpty) {
      invoice = invoices.docs[0];
      token=invoice.get('token');
      selectedTable=invoice.get('table');
      discount=invoice.get('discount').toString();
      delivery=invoice.get('deliveryCharge').toString();
      totalAmount=invoice.get('grandTotal');
print(delivery+'                  mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm');
    }
    setState(() {});
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
          'Return Invoice',
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
                          border: Border.all(color: Colors.white)),
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
                    ElevatedButton(onPressed: () {
                      Navigator.pop(context);
                    }, child: const Text('Cancel')),
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
                            String price = items[index]['price'].toString();
                            String qty = items[index]['qty'].toString();
                            double addOnPrice = items[index]['addOnPrice'];
                            List addOns = items[index]['addOns'];
                            return ReturnItem(
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
                              "₹ ${invoice==null?0:invoice.get('totalAmount').toStringAsFixed(2)}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.grey.shade700),
                            ),
                            Text(
                              invoice ==
                                  null
                                  ? "0.00"
                                  : "₹ ${double.tryParse(invoice.get('discount').toString()).toStringAsFixed(2)}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.grey.shade700),
                            ),
                            Text(
                              " ₹ ${(invoice==null?0:invoice.get('tax')).toStringAsFixed(2)}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.grey.shade700),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "₹ ${(invoice==null?0:invoice.get('grandTotal')).toStringAsFixed(2)}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.grey.shade700),
                            ),
                            Text(
                              "₹ ${returnTotal.toStringAsFixed(2)}",
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

class ReturnItem extends StatefulWidget {
  final Map<String, dynamic> item;
  final int index;
  final Function calculate;
  const ReturnItem({Key key, this.item, this.index, this.calculate}) : super(key: key);

  @override
  _ReturnItemState createState() => _ReturnItemState();
}

class _ReturnItemState extends State<ReturnItem> {
  int index;
  String item;
  String price;
  String qty;
  TextEditingController _controller;
  double progress = 0;
  bool checked = false;
  @override
  void initState() {
    index = widget.index;
    item = widget.item['pdtname'];
    price = (widget.item['price']+widget.item['addOnPrice']).toString();
    qty = widget.item['qty'].toString();
    _controller = TextEditingController(text: progress.toString());


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


          ],
        ),
        const Divider(),
      ],
    );
  }
}
