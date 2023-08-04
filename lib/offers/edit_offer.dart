// @dart=2.9
import 'package:built_collection/built_collection.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:awafi_pos/backend/schema/cut_record.dart';
import 'package:awafi_pos/backend/schema/offer_record.dart';

import 'package:multiple_select/Item.dart';
import 'package:multiple_select/multi_filter_select.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../flutter_flow/upload_media.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditOfferWidget extends StatefulWidget {
  final OfferRecord offer;
  EditOfferWidget({Key key, this.offer}) : super(key: key);

  @override
  _EditOfferWidgetState createState() => _EditOfferWidgetState();
}

class _EditOfferWidgetState extends State<EditOfferWidget> {
   OfferRecord offer;
  DateTime expiryDate;
  TextEditingController textController1;
  TextEditingController textController2;
  TextEditingController textController3;
  TextEditingController textController4;
  bool amount = false;
  bool unlimited=false;
  bool global =true;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  List<DropdownMenuItem> fetchedShops = [];
  List<Item> fetchedUsers = [];
  List<DropdownMenuItem> fetchedProducts = [];
  int selectedShopIndex = 0;

  String selectedProduct = "";


  List<String> _selectedUsers = [];

  QuerySnapshot products;
  List<Map<String,dynamic>> userList = [];
  List<Map<String,dynamic>> shopList = [];
  List<DropdownMenuItem> fetchedCategories = [];
  String selectedCategory = "";




  @override
  void initState() {
    super.initState();
    offer=widget.offer;
    textController1 = TextEditingController(text:offer.title);
    textController2 = TextEditingController(text: offer.description);
    textController3 = TextEditingController(text: offer.code);
    textController4 = TextEditingController(text: offer.value.toString());
    selectedProduct=offer.productId;
    selectedCategory=offer.categoryId;
    _selectedUsers=offer.userId.asList();
    global=offer.global;
    unlimited=offer.unlimited;
    expiryDate=offer.expiryDate.toDate();
    amount=offer.amount;



    if (fetchedShops.isEmpty) {
      getShops().then((value) {
        for(int i=0;i<shopList.length;i++){
          Map<String,dynamic> shop=shopList[i];
          if(shop['shopId']==offer.shopId){
            selectedShopIndex=i;
          }
        }
        setState(() {});
      });
    }
    if (fetchedProducts.isEmpty) {
      getProducts().then((value) {
        setState(() {});
      });
    }
    if (fetchedUsers.isEmpty) {
      getUsers().then((value) {
        setState(() {});
      });
    }
    if (fetchedCategories.isEmpty) {
      getCategories().then((value) {
        setState(() {});
      });
    }

  }
  Future getCategories() async {
    QuerySnapshot data1 =
    await FirebaseFirestore.instance.collection("category").get();
    for (var doc in data1.docs) {
      fetchedCategories.add(DropdownMenuItem(
        child: Text(doc.get('name')),
        value: doc.get('categoryId'),
      ));
    }
  }
  Future getShops() async {
    QuerySnapshot data1 = await FirebaseFirestore.instance.collection("shops").get();
    List<Map<String,dynamic>> temp = [];
    List<DropdownMenuItem> tempShop =[];
    int i=0;
    for (var doc in data1.docs) {
      temp.add(doc.data());
      tempShop.add(DropdownMenuItem(
        child: Text(doc.get('name')),
        value: i,
      ));
      i++;
    }
    if (mounted) {
      setState(() {
        shopList = temp;
        fetchedShops=tempShop;
      });
    }
  }

  ListBuilder<String> convertListToListBuilder(List<String> list) {
    ListBuilder<String> listBuilder = ListBuilder<String>();
    for (var items in list) {
      listBuilder.add(items);
    }
    return listBuilder;
  }
  ListBuilder<CutRecord> convertMapListToMapListBuilder(List<CutRecord> list) {
    ListBuilder<CutRecord> listBuilder = ListBuilder<CutRecord>();
    for (var items in list) {
      listBuilder.add(items);
    }
    return listBuilder;
  }




  setSearchParam(String caseNumber) {
    ListBuilder<String> caseSearchList = ListBuilder<String>();
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


  Future getUsers() async {
    QuerySnapshot data1 =
    await FirebaseFirestore.instance.collection("users").get();

    for (var doc in data1.docs) {
      // Map<String , dynamic> data = doc.data();
      fetchedUsers.add(Item.build(
        value: doc.get('userId'),
        display: doc.get('fullName'),

        content: doc.get('fullName'),
      ));

    }
    setState(() {
      // pr = data1;
    });
  }



  Future getProducts() async {
    QuerySnapshot data1 =
    await FirebaseFirestore.instance.collection("products").get();
    for (var doc in data1.docs) {
      fetchedProducts.add(DropdownMenuItem(
        child: Text(doc.get('name')),
        value: doc.get('productId'),
      ));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.primaryColor,
        automaticallyImplyLeading: true,
        title: Text(
          'Products',
          style: FlutterFlowTheme.bodyText1.override(
            fontFamily: 'Poppins',
          ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 4,
      ),
      body: SafeArea(
        child:
              Expanded(
                child:
                    SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [

                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 12, 0, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          width: 330,
                                          height: 60,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                            BorderRadius.circular(8),
                                            border: Border.all(
                                              color: Color(0xFFE6E6E6),
                                            ),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                16, 0, 0, 0),
                                            child: TextFormField(
                                              controller: textController1,
                                              obscureText: false,
                                              decoration: InputDecoration(
                                                labelText: 'Title',
                                                labelStyle: FlutterFlowTheme
                                                    .bodyText2
                                                    .override(
                                                  fontFamily: 'Montserrat',
                                                  color: Color(0xFF8B97A2),
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                hintText:
                                                'enter your offer name',
                                                hintStyle: FlutterFlowTheme
                                                    .bodyText2
                                                    .override(
                                                  fontFamily: 'Montserrat',
                                                  color: Color(0xFF8B97A2),
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                enabledBorder:
                                                UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.transparent,
                                                    width: 1,
                                                  ),
                                                  borderRadius:
                                                  const BorderRadius.only(
                                                    topLeft:
                                                    Radius.circular(4.0),
                                                    topRight:
                                                    Radius.circular(4.0),
                                                  ),
                                                ),
                                                focusedBorder:
                                                UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.transparent,
                                                    width: 1,
                                                  ),
                                                  borderRadius:
                                                  const BorderRadius.only(
                                                    topLeft:
                                                    Radius.circular(4.0),
                                                    topRight:
                                                    Radius.circular(4.0),
                                                  ),
                                                ),
                                              ),
                                              style: FlutterFlowTheme.bodyText2
                                                  .override(
                                                fontFamily: 'Montserrat',
                                                color: Color(0xFF8B97A2),
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 12, 0, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          width: 330,
                                          height: 60,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                            BorderRadius.circular(8),
                                            border: Border.all(
                                              color: Color(0xFFE6E6E6),
                                            ),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                16, 0, 0, 0),
                                            child: TextFormField(
                                              controller: textController2,
                                              obscureText: false,
                                              decoration: InputDecoration(
                                                labelText: 'Description',
                                                labelStyle: FlutterFlowTheme
                                                    .bodyText2
                                                    .override(
                                                  fontFamily: 'Montserrat',
                                                  color: Color(0xFF8B97A2),
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                hintText: 'offer description',
                                                hintStyle: FlutterFlowTheme
                                                    .bodyText2
                                                    .override(
                                                  fontFamily: 'Montserrat',
                                                  color: Color(0xFF8B97A2),
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                enabledBorder:
                                                UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.transparent,
                                                    width: 1,
                                                  ),
                                                  borderRadius:
                                                  const BorderRadius.only(
                                                    topLeft:
                                                    Radius.circular(4.0),
                                                    topRight:
                                                    Radius.circular(4.0),
                                                  ),
                                                ),
                                                focusedBorder:
                                                UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.transparent,
                                                    width: 1,
                                                  ),
                                                  borderRadius:
                                                  const BorderRadius.only(
                                                    topLeft:
                                                    Radius.circular(4.0),
                                                    topRight:
                                                    Radius.circular(4.0),
                                                  ),
                                                ),
                                              ),
                                              style: FlutterFlowTheme.bodyText2
                                                  .override(
                                                fontFamily: 'Montserrat',
                                                color: Color(0xFF8B97A2),
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 12, 0, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          width: 330,
                                          height: 60,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                            BorderRadius.circular(8),
                                            border: Border.all(
                                              color: Color(0xFFE6E6E6),
                                            ),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                16, 0, 0, 0),
                                            child: TextFormField(
                                              controller: textController3,
                                              obscureText: false,
                                              decoration: InputDecoration(
                                                labelText: 'Code',
                                                labelStyle: FlutterFlowTheme
                                                    .bodyText2
                                                    .override(
                                                  fontFamily: 'Montserrat',
                                                  color: Color(0xFF8B97A2),
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                hintText: 'offer code',
                                                hintStyle: FlutterFlowTheme
                                                    .bodyText2
                                                    .override(
                                                  fontFamily: 'Montserrat',
                                                  color: Color(0xFF8B97A2),
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                enabledBorder:
                                                UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.transparent,
                                                    width: 1,
                                                  ),
                                                  borderRadius:
                                                  const BorderRadius.only(
                                                    topLeft:
                                                    Radius.circular(4.0),
                                                    topRight:
                                                    Radius.circular(4.0),
                                                  ),
                                                ),
                                                focusedBorder:
                                                UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.transparent,
                                                    width: 1,
                                                  ),
                                                  borderRadius:
                                                  const BorderRadius.only(
                                                    topLeft:
                                                    Radius.circular(4.0),
                                                    topRight:
                                                    Radius.circular(4.0),
                                                  ),
                                                ),
                                              ),
                                              style: FlutterFlowTheme.bodyText2
                                                  .override(
                                                fontFamily: 'Montserrat',
                                                color: Color(0xFF8B97A2),
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 0.0),
                                ),
                                Container(
                                  width: 330,
                                  // height: 70,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: Color(0xFFE6E6E6),
                                    ),
                                  ),
                                  child: SearchableDropdown.single(
                                    items: fetchedProducts,
                                    value: selectedProduct,
                                    hint: "Select Offer Product",
                                    searchHint: "Select a product for product-wise offer",
                                    onChanged: (value) {
                                      setState(() {
                                        selectedProduct = value;

                                      });
                                    },
                                    isExpanded: true,
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 0.0),
                                ),
                                Container(
                                  width: 330,
                                  // height: 70,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: Color(0xFFE6E6E6),
                                    ),
                                  ),
                                  child: SearchableDropdown.single(
                                    items: fetchedCategories,
                                    value: selectedCategory,
                                    hint: "Offer Category",
                                    searchHint: "Select Offer Category",
                                    onChanged: (value) {
                                      setState(() {

                                        selectedCategory = value;

                                      });

                                    },
                                    isExpanded: true,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 0.0),
                                ),
                                Container(
                                  width: 330,
                                  // height: 70,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: Color(0xFFE6E6E6),
                                    ),
                                  ),
                                  child: SearchableDropdown.single(
                                    items: fetchedShops,
                                    value: selectedShopIndex,
                                    hint: "Select Offer Shop",
                                    searchHint: "Select Offer Shop",
                                    onChanged: (value) {
                                      setState(() {
                                        selectedShopIndex = value;

                                      });
                                    },
                                    isExpanded: true,
                                  ),
                                ),


                                const Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 0.0),
                                ),

                                Container(
                                    width: 330,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: Color(0xFFE6E6E6),
                                      ),
                                    ),
                                    child: MultiFilterSelect(
                                      allItems: fetchedUsers,
                                      initValue: _selectedUsers,
                                      hintText: 'Select Users for exclusive offer',
                                      selectCallback: (List selectedValue) =>
                                      _selectedUsers = selectedValue,
                                    )


                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 20.0, horizontal: 0.0),
                                ),
                                Row(
                                  children: [
                                    Text('Global Offer'),
                                    Switch(
                                      value: global,
                                      onChanged: (value) {
                                        setState(() {
                                          global = value;
                                        });
                                      },
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(10, 5, 0, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'Expiry',
                                          style: FlutterFlowTheme.bodyText1.override(
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                                        child: Text(
                                          ':',
                                          style: FlutterFlowTheme.bodyText1.override(
                                            fontFamily: 'Poppins',
                                          ),
                                        ),
                                      ),
                                      FFButtonWidget(
                                        onPressed: () async {
                                          await DatePicker.showDatePicker(context,
                                              showTitleActions: true, onConfirm: (date) {

                                                setState(() => expiryDate = date);
                                              }, currentTime: DateTime.now());
                                        },
                                        text: expiryDate.toString(),
                                        options: FFButtonOptions(
                                          width: 100,
                                          height: 35,
                                          color: Colors.white,
                                          textStyle: FlutterFlowTheme.subtitle2.override(
                                            fontFamily: 'Poppins',
                                            color: Color(0xFF242224),
                                          ),
                                          borderSide: BorderSide(
                                            color: Color(0x8A242222),
                                            width: 1,
                                          ),
                                          borderRadius: 10,
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text('Unlimited'),
                                    Switch(
                                      value: unlimited,
                                      onChanged: (value) {
                                        setState(() {
                                          unlimited = value;
                                        });
                                      },
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text('Offer in Amount'),
                                    Switch(
                                      value: amount,
                                      onChanged: (value) {
                                        setState(() {
                                          amount = value;
                                        });
                                      },
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 12, 0, 0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          width: 330,
                                          height: 60,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                            BorderRadius.circular(8),
                                            border: Border.all(
                                              color: Color(0xFFE6E6E6),
                                            ),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                16, 0, 0, 0),
                                            child: TextFormField(
                                              controller: textController4,
                                              obscureText: false,
                                              decoration: InputDecoration(
                                                labelText: 'Offer',
                                                labelStyle: FlutterFlowTheme
                                                    .bodyText2
                                                    .override(
                                                  fontFamily: 'Montserrat',
                                                  color: Color(0xFF8B97A2),
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                hintText:
                                                'enter your offer amount or %',
                                                hintStyle: FlutterFlowTheme
                                                    .bodyText2
                                                    .override(
                                                  fontFamily: 'Montserrat',
                                                  color: Color(0xFF8B97A2),
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                enabledBorder:
                                                UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.transparent,
                                                    width: 1,
                                                  ),
                                                  borderRadius:
                                                  const BorderRadius.only(
                                                    topLeft:
                                                    Radius.circular(4.0),
                                                    topRight:
                                                    Radius.circular(4.0),
                                                  ),
                                                ),
                                                focusedBorder:
                                                UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.transparent,
                                                    width: 1,
                                                  ),
                                                  borderRadius:
                                                  const BorderRadius.only(
                                                    topLeft:
                                                    Radius.circular(4.0),
                                                    topRight:
                                                    Radius.circular(4.0),
                                                  ),
                                                ),
                                              ),
                                              style: FlutterFlowTheme.bodyText2
                                                  .override(
                                                fontFamily: 'Montserrat',
                                                color: Color(0xFF8B97A2),
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 20.0, horizontal: 0.0),
                                ),

                                Align(
                                  alignment: Alignment(0.95, 0),
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                                    child: FFButtonWidget(
                                      onPressed: () async {
                                        final title = textController1.text;
                                        final description =
                                            textController2.text;
                                        final code =textController3.text;
                                        final value =double.tryParse(textController4.text);

                                        // final userId = currentUserUid;
                                        if (title == "" || title == null) {
                                          showUploadMessage(context,
                                              "please enter offer name");
                                        } else if (code == "" ||
                                            code == null) {
                                          showUploadMessage(context,
                                              "please choose a offer code");
                                        } else {
                                          bool proceed = await alert(context,
                                              'You want to upload this offer?');

                                          if (proceed) {
                                            final newOfferRecordData = {
                                              ...createOfferRecordData(
                                                  title: title,
                                                  description: description,
                                                  code: code,
                                                  userId: convertListToListBuilder(
                                                      _selectedUsers),
                                                  search: setSearchParam(title),
                                                  shopId:selectedShopIndex==null?"": shopList[selectedShopIndex]['shopId'],
                                                  expiryDate: Timestamp.fromDate(expiryDate),
                                                  categoryId: selectedCategory==null?"":selectedCategory,
                                                  amount: amount,
                                                  unlimited: unlimited,
                                                  value: value,
                                                  productId: selectedProduct==null?"":selectedProduct,
                                                  global: global,


                                              )};

                                            await offer.reference
                                                .update(newOfferRecordData);


                                              showUploadMessage(
                                                  context, 'Update Success!');
                                              setState(() {


                                              });

                                          }
                                        }
                                      },
                                      text: 'Update Offer',
                                      options: FFButtonOptions(
                                        width: 180,
                                        height: 60,
                                        color: FlutterFlowTheme.primaryColor,
                                        textStyle:
                                        FlutterFlowTheme.subtitle2.override(
                                          fontFamily: 'Montserrat',
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        elevation: 2,
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
                                          width: 2,
                                        ),
                                        borderRadius: 8,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),



              ),

          ),


    );
  }
}
