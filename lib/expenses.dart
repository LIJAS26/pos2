//@dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';

import 'Branches/branches.dart';
import 'backend/firebase_storage/storage.dart';
import 'flutter_flow/upload_media.dart';
import 'main.dart';
class Expenses extends StatefulWidget {
  const Expenses({Key key}) : super(key: key);

  @override
  _ExpensesState createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  String uploadedFileUrl1;
  String invoiceNo;
  String supplier;
  String amount;
  String gst;
  String description;
  bool cashPayment=false;
  bool bankPayment=false;
  TextEditingController invoiceNoController;
  TextEditingController supplierController;
  TextEditingController amountController;
  TextEditingController gstController;
  TextEditingController descriptionController;
  @override
  void initState() {
    invoiceNoController=TextEditingController();
    supplierController=TextEditingController();
    amountController=TextEditingController();
    gstController=TextEditingController();
    descriptionController=TextEditingController();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: default_color,
        foregroundColor: Colors.black,
        automaticallyImplyLeading: true,
        title: const Text("Expense",style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white
        ),),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding:  EdgeInsets.fromLTRB(MediaQuery.of(context).size.width*0.15,MediaQuery.of(context).size.height*0.05,MediaQuery.of(context).size.width*0.15,MediaQuery.of(context).size.width*0.05),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20)
            ),
            child: ListView(
              children: [
                if (uploadedFileUrl1==null||uploadedFileUrl1=='')
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: IconButton(
                          onPressed: () async {
                            final selectedMedia = await selectMedia(
                              maxWidth: 1080.00,
                              maxHeight: 1320.00,
                            );
                            if (selectedMedia != null &&
                                validateFileFormat(
                                    selectedMedia.storagePath,
                                    context)) {
                              showUploadMessage(
                                  context, 'Uploading file...',
                                  showLoading: true);
                              final downloadUrl = await uploadData(
                                  selectedMedia.storagePath,
                                  selectedMedia.bytes);
                              ScaffoldMessenger.of(context)
                                  .hideCurrentSnackBar();
                              if (downloadUrl != null) {
                                setState(() =>
                                uploadedFileUrl1 = downloadUrl);
                                showUploadMessage(context,
                                    'Media upload Success!');
                              } else {
                                showUploadMessage(context,
                                    'Failed to upload media');
                              }
                            }
                          },
                          icon: const Icon(
                            Icons.image_rounded,
                            color: Colors.black,
                            size: 50,
                          ),
                          iconSize: 50,
                        ),
                      ),
                    ],
                  )
                else Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height*0.1,
                        width: MediaQuery.of(context).size.width*0.1,
                        color: Colors.grey.shade300,
                        child: Image.network(uploadedFileUrl1,fit: BoxFit.cover,),
                      ),
                      SizedBox(width: 20,),
                      InkWell(
                        onTap: () async {
                          final selectedMedia = await selectMedia(
                            maxWidth: 1080.00,
                            maxHeight: 1320.00,
                          );
                          if (selectedMedia != null &&
                              validateFileFormat(
                                  selectedMedia.storagePath,
                                  context)) {
                            showUploadMessage(
                                context, 'Uploading file...',
                                showLoading: true);
                            final downloadUrl = await uploadData(
                                selectedMedia.storagePath,
                                selectedMedia.bytes);
                            ScaffoldMessenger.of(context)
                                .hideCurrentSnackBar();
                            if (downloadUrl != null) {
                              setState(() =>
                              uploadedFileUrl1 = downloadUrl);
                              showUploadMessage(context,
                                  'Media upload Success!');
                            } else {
                              showUploadMessage(context,
                                  'Failed to upload media');
                            }
                          }
                        },
                        child: Container(
                          height: 40,
                          width: 150,
                          decoration: BoxDecoration(
                              color: Color(0xFF2b0e10),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Center(
                            child: Text('Change Image'
                              ,style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15
                              ),),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20,),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        onChanged: (value){
                          setState(() {
                            invoiceNo=value;
                          });
                        },
                        controller: invoiceNoController,
                        decoration: InputDecoration(

                          labelText: 'INVOICE NO',
                          hoverColor: Color(0xFF2b0e10),
                          hintText: 'Enter Invoice Number',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF2b0e10), width: 1.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 20,),
                    Container(
                      width: MediaQuery.of(context).size.width*0.09,
                      height: 50,
                      child: Row(
                        children: [
                          Text('Cash',style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 17
                          ),
                          ),
                          Checkbox(
                            value: cashPayment,
                            onChanged: (value) {
                              setState(() {
                                cashPayment = !cashPayment;
                                if(cashPayment==true){
                                  bankPayment=false;
                                }
                              });
                            },
                          ),

                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width*0.1,
                      height: 50,
                      child: Row(
                        children: [
                          Text('Bank',style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 17
                          ),
                          ),
                          Checkbox(
                            value: bankPayment,
                            onChanged: (value) {
                              setState(() {
                                bankPayment = !bankPayment;
                                if(bankPayment==true){
                                  cashPayment=false;
                                }

                              });
                            },
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20,),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        onChanged: (value){
                          setState(() {
                            amount=value;
                          });
                        },
                        controller: amountController,
                        decoration: InputDecoration(
                          labelText: 'AMOUNT',
                          hoverColor: Color(0xFF2b0e10),
                          hintText: 'Enter Amount',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF2b0e10), width: 1.0),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20,),
                    // Expanded(
                    //   child: TextField(
                    //     keyboardType: TextInputType.number,
                    //     onChanged: (value){
                    //       setState(() {
                    //         gst=value;
                    //       });
                    //     },
                    //     controller: gstController,
                    //     decoration: InputDecoration(
                    //       labelText: 'Vat',
                    //       hoverColor: Color(0xFF2b0e10),
                    //       hintText: 'Enter Vat',
                    //       border: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(5.0),
                    //       ),
                    //       focusedBorder: OutlineInputBorder(
                    //         borderSide: BorderSide(color: Color(0xFF2b0e10), width: 1.0),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
                const SizedBox(height: 20,),
                // TextFormField(
                //   onChanged: (value){
                //     setState(() {
                //       supplier=value;
                //     });
                //   },
                //   controller: supplierController,
                //   decoration: InputDecoration(
                //     labelText: 'SUPPLIER NAME',
                //     hoverColor: Color(0xFF2b0e10),
                //     hintText: 'Enter Supplier Name',
                //     border: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(5.0),
                //     ),
                //     focusedBorder: OutlineInputBorder(
                //       borderSide: BorderSide(color: Color(0xFF2b0e10), width: 1.0),
                //     ),
                //   ),
                // ),
                // const SizedBox(height: 20,),
                TextField(
                  keyboardType: TextInputType.multiline,
                  onChanged: (value){
                    setState(() {
                      description=value;
                    });
                  },
                  maxLines: 5,
                  controller: descriptionController,
                  decoration: InputDecoration(
                    labelText: 'DESCRIPTION',
                    hoverColor: Color(0xFF2b0e10),
                    hintText: 'Enter Description',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF2b0e10), width: 1.0),
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () async {

                        if(invoiceNo!=null&&description!=null
                            &&amount!=null&&(cashPayment==true||bankPayment==true)){

                          DocumentSnapshot doc = await FirebaseFirestore.instance
                              .collection('invoiceNo').doc(currentBranchId).get();
                          int voucherNo = doc.get('expense') + 1;
                          await FirebaseFirestore.instance.collection('expenses')
                              .doc(currentBranchId)
                              .collection('expenses')
                              .add(
                              {
                                'voucherNo': voucherNo,
                                'invoiceNo': invoiceNo,
                                'supplier': supplier,
                                'amount': double.tryParse(amount),
                                // 'gst': double.tryParse(gst),
                                'cash':cashPayment==true?true:false,
                                'image': uploadedFileUrl1,
                                'description': description,
                                'salesDate' :DateTime.now(),
                                'currentUserId':currentUserId,
                              });
                          FirebaseFirestore.instance.collection('invoiceNo').doc(
                              currentBranchId).update(
                              {
                                'expense': FieldValue.increment(1)
                              });
                          showUploadMessage(
                            context, 'Expense Added Succesfully',);
                          setState(() {
                            invoiceNoController.text = '';
                            supplierController.text = '';
                            amountController.text = '';
                            gstController.text = '';
                            uploadedFileUrl1 = '';
                            descriptionController.text = '';
                            description = '';
                            invoiceNo = '';
                            supplier = '';
                            amount = '';
                            // gst = '';
                            cashPayment=false;
                            bankPayment=false;
                          });

                        }else{
                          invoiceNo==null?showUploadMessage(context, 'Please Enter Invoice Number')
                              :(cashPayment==false&&bankPayment==false)?showUploadMessage(context, 'Please Select Payment Method')
                              :amount==null?showUploadMessage(context, 'Please Enter Amount')
                              // :gst==null?showUploadMessage(context, 'Please Enter vat Amount')
                              :showUploadMessage(context, 'Please Enter description');
                        }


                      },
                      child: Container(
                        height: 40,
                        width: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xFF2b0e10)
                        ),
                        child: const Center(
                          child: Text("ENTER",style: TextStyle(
                            color: Colors.white,fontWeight: FontWeight.bold
                          ),),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
