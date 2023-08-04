//@dart=2.9
import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:awafi_pos/backend/schema/cut_record.dart';

import 'package:multiple_select/Item.dart';
import 'package:multiple_select/multi_filter_select.dart';
import 'package:multiselect_dropdown/multiple_dropdown.dart';
import 'package:multiselect_dropdown/multiple_select.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../backend/firebase_storage/storage.dart';
import '../editproduct/editproduct_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../flutter_flow/upload_media.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class ProductsWidget extends StatefulWidget {
  ProductsWidget({Key key}) : super(key: key);

  @override
  _ProductsWidgetState createState() => _ProductsWidgetState();
}

class _ProductsWidgetState extends State<ProductsWidget> {
  String uploadedFileUrl1;
  String uploadedFileUrl2;
  TextEditingController textController1;
  TextEditingController textController2;
  TextEditingController textController3;
  TextEditingController discountPriceController;
  TextEditingController searchController;
  final pageViewController = PageController();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<DropdownMenuItem> fetchedCategories = [];
  List<DropdownMenuItem> fetchedShops = [];
  List<DropdownMenuItem> fetchedSubCategory = [];
  List<DropdownMenuItem> fetchedBrand = [];
  String selectedCategory = "";
  int selectedShopIndex = 0;

  String selectedSubCategory = "";
  String selectedBrand = "";
  List<String> _selectedColors = [];
  List<String> _selectedSize = [];
  List<CutRecord> _selectedCuts = [];

  QuerySnapshot subCategories;
  List<Map<String,dynamic>> unitList = [];
  List<Map<String,dynamic>> shopList = [];
  List<DropdownMenuItem> units = [];
  String  basicUnit='';
  TextEditingController startController;
  TextEditingController stepController;
  TextEditingController stopController;

  @override
  void initState() {
    super.initState();
    textController1 = TextEditingController();
    textController2 = TextEditingController();
    textController3 = TextEditingController(text: '');
    discountPriceController=TextEditingController(text: '');
    searchController = TextEditingController(text: '');
    startController = TextEditingController(text: '1.0');
    stepController = TextEditingController(text: '1.0');
    stopController = TextEditingController(text: '20.0');
    if (fetchedShops.isEmpty) {
      getShops().then((value) {
        setState(() {});
      });
    }
    if (fetchedCategories.isEmpty) {
      getCategories().then((value) {
        setState(() {});
      });
    }
    if (fetchedSubCategory.isEmpty) {
      getSubCategories().then((value) {
        setState(() {});
      });
    }
    if (fetchedBrand.isEmpty) {
      getBrands().then((value) {
        setState(() {});
      });
    }
    if (_selectedColors.isEmpty) {
      getColors().then((value) {
        setState(() {});
      });
    }
    if (_selectedSize.isEmpty) {
      getSizes().then((value) {
        setState(() {});
      });
    }
    getUnits();
    if (_selectedCuts.isEmpty) {
      getCuts().then((value) {
        setState(() {});
      });
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

  Future getUnits() async {
    DocumentSnapshot data1 =
    await FirebaseFirestore.instance.collection("units").doc("units").get();
    List<Map<String,dynamic>> temp = [];
    List<DropdownMenuItem> tempUnit =[];
    for (var unit in data1.get('unitlist')) {
      temp.add(unit);
      tempUnit.add(DropdownMenuItem(
        child: Text(unit['name']),
        value: unit['name'],
      ));
    }
    if (mounted) {
      setState(() {
        unitList = temp;
        units=tempUnit;
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

  List<Item> colors = [];
  List<MultipleSelectItem> sizes = [];
  List<MultipleSelectItem> cuts = [];

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

  Future getColors() async {
    DocumentSnapshot data1 = await FirebaseFirestore.instance
        .collection("colors")
        .doc("colors")
        .get();

    for (var color in data1.get('colorList')) {
      colors.add(Item.build(
        value: '0xFF${color['code']}',
        display: color['name'],

        content: color['name'],
      ));
    }
  }

  Future getSizes() async {
    DocumentSnapshot data1 =
    await FirebaseFirestore.instance.collection("DailyReport").doc("DailyReport").get();
    // int rowIndex=1;
    for (var size in data1.get('sizeList')) {
      sizes.add(MultipleSelectItem.build(
        value: size,
        display: size,
        content: size,
      ));
      // rowIndex++;
    }
  }

  Future getBrands() async {
    QuerySnapshot data1 =
    await FirebaseFirestore.instance.collection("brands").get();
    for (var doc in data1.docs) {
      // Map<String , dynamic> data = doc.data();

      fetchedBrand.add(DropdownMenuItem(
        child: Text(doc.get('brand')),
        value: doc.get('brandId'),
      ));
    }
  }

  Future getSubCategories() async {
    QuerySnapshot data1 =
    await FirebaseFirestore.instance.collection("subCategory").get();
    setState(() {
      subCategories = data1;
    });
    for (var doc in data1.docs) {
      // Map<String , dynamic> data = doc.data();

      fetchedSubCategory.add(DropdownMenuItem(
        child: Text(doc.get('name')),
        value: doc.get('subCategoryId'),
      ));
    }
  }

  getSubCategoriesByCategory(String categoryId) {
    List<DropdownMenuItem> subcategories = <DropdownMenuItem>[];

    for (var doc in subCategories.docs) {
      // Map<String , dynamic> data = doc.data();

      if (doc.get('categoryId') == categoryId ||
          categoryId == "" ||
          categoryId == null) {
        subcategories.add(DropdownMenuItem(
          child: Text(doc.get('name')),
          value: doc.get('subCategoryId'),
        ));
      }
    }

    setState(() {
      selectedSubCategory = "";
      selectedCategory = categoryId;
      fetchedSubCategory = subcategories;
    });
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
  Future getCuts() async {

    Stream cut=queryCutRecord();

    cut.listen((value) {
      for (var cutRecord in value) {
        cuts.add(MultipleSelectItem.build(
          value: cutRecord,
          display: cutRecord.name,
          content: cutRecord.name,
        ));
      }
    });


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
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
        child: DefaultTabController(
          length: 2,
          initialIndex: 0,
          child: Column(
            children: [
              TabBar(
                labelColor: FlutterFlowTheme.primaryColor,
                indicatorColor: FlutterFlowTheme.secondaryColor,
                tabs: [
                  Tab(
                    text: 'Upload',
                  ),
                  Tab(
                    text: 'Edit',
                  )
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
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
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: [
                                    IconButton(
                                      onPressed: () async {

                                        final selectedMedia = await selectMedia(
                                          maxWidth: 1080.00,
                                          maxHeight: 1320.00,
                                        );
                                        print(selectedMedia.storagePath);
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
                                            showUploadMessage(
                                                context, 'Success!');
                                          } else {
                                            showUploadMessage(context,
                                                'Failed to upload media');
                                          }
                                        }
                                      },
                                      icon: Icon(
                                        Icons.camera_alt,
                                        color: Colors.black,
                                        size: 30,
                                      ),
                                      iconSize: 30,
                                    ),
                                    IconButton(
                                      onPressed: () async {
                                        print('----------------------');
                                        final selectedMedia = await selectMedia(
                                          maxWidth: 1080.00,
                                          maxHeight: 1320.00,
                                        );
                                        print('************************************************');
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
                                      icon: Icon(
                                        Icons.image,
                                        color: Colors.black,
                                        size: 30,
                                      ),
                                      iconSize: 30,
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
                                              controller: textController1,
                                              obscureText: false,
                                              decoration: InputDecoration(
                                                labelText: 'Product Name',
                                                labelStyle: FlutterFlowTheme
                                                    .bodyText2
                                                    .override(
                                                  fontFamily: 'Montserrat',
                                                  color: Color(0xFF8B97A2),
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                hintText:
                                                'enter your product name',
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
                                                hintText: 'product description',
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
                                                labelText: 'price',
                                                labelStyle: FlutterFlowTheme
                                                    .bodyText2
                                                    .override(
                                                  fontFamily: 'Montserrat',
                                                  color: Color(0xFF8B97A2),
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                hintText: 'product price',
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
                                      ),
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
                                              controller: discountPriceController,
                                              obscureText: false,
                                              decoration: InputDecoration(
                                                labelText: 'discount price',
                                                labelStyle: FlutterFlowTheme
                                                    .bodyText2
                                                    .override(
                                                  fontFamily: 'Montserrat',
                                                  color: Color(0xFF8B97A2),
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                hintText: 'discount price',
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
                                    items: units,
                                    value: basicUnit,
                                    hint: "Select Base Unit",
                                    searchHint: "Select Base Unit",
                                    onChanged: (value) {
                                      setState(() {
                                        basicUnit = value;

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
                                    hint: "Select Product Shop",
                                    searchHint: "Select Product Shop",
                                    onChanged: (value) {
                                      setState(() {
                                        selectedShopIndex = value;

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
                                    items: fetchedBrand,
                                    value: selectedBrand,
                                    hint: "Select Brand",
                                    searchHint: "Select Brand",
                                    onChanged: (value) {
                                      setState(() {
                                        selectedBrand = value;
                                        // categoryController.text=value;
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
                                    hint: "Select Category",
                                    searchHint: "Select Category",
                                    onChanged: (value) {
                                      // setState(() {
                                      //   fetchedSubCategory=<DropdownMenuItem>[];
                                      //   selectedSubCategory="";
                                      //   selectedCategory = value;
                                      //   // categoryController.text=value;
                                      // });
                                      getSubCategoriesByCategory(value);
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
                                    items: fetchedSubCategory,
                                    value: selectedSubCategory,
                                    hint: "Select Sub-category",
                                    searchHint: "Select Sub-category",
                                    onChanged: (value) {
                                      setState(() {
                                        selectedSubCategory = value;
                                        // subCategoryController.text=value;
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
                                      allItems: colors,
                                      initValue: _selectedColors,
                                      hintText: 'Select Product Colors',
                                      selectCallback: (List selectedValue) =>
                                      _selectedColors = selectedValue,
                                    )

                                  // MultipleDropDown(
                                  //   placeholder: 'Select Product Colors',
                                  //   disabled: false,
                                  //   values: _selectedColors,
                                  //   elements: colors,
                                  // ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 20.0, horizontal: 0.0),
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
                                  child: MultipleDropDown(
                                    placeholder: 'Select Product Sizes',
                                    disabled: false,
                                    values: _selectedSize,
                                    elements: sizes,
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 20.0, horizontal: 0.0),
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
                                  child: MultipleDropDown(
                                    placeholder: 'Select Product Cuts',
                                    disabled: false,
                                    values: _selectedCuts,
                                    elements: cuts,
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 20.0, horizontal: 0.0),
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
                                              controller: startController,
                                              obscureText: false,
                                              decoration: InputDecoration(
                                                labelText: 'min qty',
                                                labelStyle: FlutterFlowTheme
                                                    .bodyText2
                                                    .override(
                                                  fontFamily: 'Montserrat',
                                                  color: Color(0xFF8B97A2),
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                hintText: 'min qty of purchase',
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
                                      ),
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
                                              controller: stepController,
                                              obscureText: false,
                                              decoration: InputDecoration(
                                                labelText: 'qty step',
                                                labelStyle: FlutterFlowTheme
                                                    .bodyText2
                                                    .override(
                                                  fontFamily: 'Montserrat',
                                                  color: Color(0xFF8B97A2),
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                hintText: 'qty step',
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
                                      ),
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
                                              controller: stopController,
                                              obscureText: false,
                                              decoration: InputDecoration(
                                                labelText: 'max qty',
                                                labelStyle: FlutterFlowTheme
                                                    .bodyText2
                                                    .override(
                                                  fontFamily: 'Montserrat',
                                                  color: Color(0xFF8B97A2),
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                hintText: 'max qty for purchase',
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
                                Align(
                                  alignment: Alignment(0.95, 0),
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                                    child: FFButtonWidget(
                                      onPressed: () async {
                                        final name = textController1.text;
                                        final description =
                                            textController2.text;
                                        final price =
                                        double.parse(textController3.text);
                                        final discountPrice =
                                        double.parse(discountPriceController.text);
                                        final userId = currentUserUid;
                                        if (name == "" || name == null) {
                                          showUploadMessage(context,
                                              "please enter product name");
                                        } else if (uploadedFileUrl1 == "" ||
                                            uploadedFileUrl1 == null) {
                                          showUploadMessage(context,
                                              "please choose a product image");
                                        } else {
                                          bool proceed = await alert(context,
                                              'You want to upload this product?');

                                          if (proceed) {
                                            final newProductsRecordData = {
                                              ...createNewProductsRecordData(
                                                name: name,
                                                description: description,
                                                price: price,
                                                discountPrice: discountPrice,
                                                userId: userId,
                                                category: selectedCategory,
                                                subCategory:
                                                selectedSubCategory,
                                                brand: selectedBrand,
                                                search: setSearchParam(name),
                                                color: convertListToListBuilder(
                                                    _selectedColors),
                                                size: convertListToListBuilder(
                                                    _selectedSize),
                                                unit: basicUnit,
                                                cuts: convertMapListToMapListBuilder( _selectedCuts),
                                                shopId: shopList[selectedShopIndex]['shopId'],
                                                shopName: shopList[selectedShopIndex]['name'],
                                                available: true,
                                                open: shopList[selectedShopIndex]['online'],
                                                branchId: "currentBranchId",
                                                start: double.tryParse(startController.text),
                                                step: double.tryParse(stepController.text),
                                                stop: double.tryParse(stopController.text),
                                              ),
                                              'imageId': FieldValue.arrayUnion(
                                                  [uploadedFileUrl1]),
                                            };

                                            await NewProductsRecord.collection
                                                .add(newProductsRecordData)
                                                .then((DocumentReference doc) {
                                              String docId = doc.id;
                                              NewProductsRecord.collection
                                                  .doc(docId)
                                                  .update({"productId": docId});
                                              showUploadMessage(
                                                  context, 'Success!');
                                              setState(() {
                                                uploadedFileUrl1 = '';
                                                textController1.text = "";
                                                textController2.text = "";
                                                textController3.text = "";
                                                discountPriceController.text = "";
                                                // selectedCategory = "";
                                                // selectedSubCategory = "";
                                                // selectedBrand = "";
                                                _selectedSize = [];
                                                _selectedColors = [];
                                                _selectedCuts = [];
                                              });
                                            });
                                          }
                                        }
                                      },
                                      text: 'Add Product',
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
                    Column(children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 12, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * .95,
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: Color(0xFFE6E6E6),
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
                                child: TextFormField(
                                  // controller: searchController,
                                  initialValue: searchController.text,
                                  onFieldSubmitted:(value){

                                    setState(() {
                                      if(value!=null) {
                                        searchController.text = value.toUpperCase();
                                      }
                                      else{
                                        searchController.text="";
                                      }
                                    });

                                  },
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText: 'search product',
                                    labelStyle:
                                    FlutterFlowTheme.bodyText2.override(
                                      fontFamily: 'Montserrat',
                                      color: Color(0xFF8B97A2),
                                      fontWeight: FontWeight.w500,
                                    ),
                                    hintText: 'product price',
                                    hintStyle:
                                    FlutterFlowTheme.bodyText2.override(
                                      fontFamily: 'Montserrat',
                                      color: Color(0xFF8B97A2),
                                      fontWeight: FontWeight.w500,
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                        width: 1,
                                      ),
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(4.0),
                                        topRight: Radius.circular(4.0),
                                      ),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                        width: 1,
                                      ),
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(4.0),
                                        topRight: Radius.circular(4.0),
                                      ),
                                    ),
                                  ),
                                  style: FlutterFlowTheme.bodyText2.override(
                                    fontFamily: 'Montserrat',
                                    color: Color(0xFF8B97A2),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Flexible(
                        child: StreamBuilder<List<NewProductsRecord>>(
                          stream: queryNewProductsRecord(
                            // ignore: non_constant_identifier_names
                              queryBuilder: (NewProductsRecord) =>
                                  NewProductsRecord.where('search',
                                      arrayContains: searchController.text)
                                      .where('branchId',isEqualTo: "currentBranchId")),
                          builder: (context, snapshot) {

                            // Customize what your widget looks like when it's loading.
                            if (!snapshot.hasData) {
                              return Center(child: CircularProgressIndicator());
                            }
                            List<NewProductsRecord>
                            listViewNewProductsRecordList = snapshot.data;
                            // Customize what your widget looks like with no query results.
                            if (snapshot.data.isEmpty) {
                              return Container();
                              // For now, we'll just include some dummy data.

                            }
                            print('----------------------------------------------------------');
                            return ListView.builder(
                              padding: EdgeInsets.zero,
                              scrollDirection: Axis.vertical,
                              itemCount: listViewNewProductsRecordList.length,
                              itemBuilder: (context, listViewIndex) {
                                final listViewNewProductsRecord =
                                listViewNewProductsRecordList[listViewIndex];
                                return Card(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  color: Color(0xFFF5F5F5),
                                  child: Stack(
                                    children: [
                                      InkWell(
                                        onTap: () async {
                                          await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  EditproductWidget(
                                                    productId:
                                                    listViewNewProductsRecord
                                                        .productId,
                                                  ),
                                            ),
                                          );
                                        },
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Align(
                                              alignment: Alignment(0, -0.11),
                                              child: Text(
                                                listViewNewProductsRecord.name,
                                                style: FlutterFlowTheme.title2
                                                    .override(
                                                  fontFamily: 'Poppins',
                                                ),
                                              ),
                                            ),
                                            Container(
                                              height: 200,
                                              child: Builder(
                                                builder: (context) {
                                                  final List images =
                                                  (listViewNewProductsRecord
                                                      .imageId
                                                      .asList() ??
                                                      [])
                                                      .take(1)
                                                      .toList();
                                                  return Container(
                                                    width: double.infinity,
                                                    height: 500,
                                                    child: Stack(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                          EdgeInsets.fromLTRB(
                                                              0, 0, 0, 50),
                                                          child: PageView.builder(
                                                            controller:
                                                            pageViewController,
                                                            scrollDirection:
                                                            Axis.horizontal,
                                                            itemCount:
                                                            images.length,
                                                            itemBuilder: (context,
                                                                imagesIndex) {
                                                              final imagesItem =
                                                              images[
                                                              imagesIndex];
                                                              return Image
                                                                  .network(
                                                                imagesItem,
                                                                width: 100,
                                                                height: 100,
                                                                fit: BoxFit.cover,
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                        // Align(
                                                        //   alignment:
                                                        //       Alignment(0, 1),
                                                        //   child: Padding(
                                                        //     padding:
                                                        //         EdgeInsets.fromLTRB(
                                                        //             0, 0, 0, 10),
                                                        //     child:
                                                        //         SmoothPageIndicator(
                                                        //       controller:
                                                        //           pageViewController,
                                                        //       count: images.length,
                                                        //       axisDirection:
                                                        //           Axis.horizontal,
                                                        //       onDotClicked: (i) {
                                                        //         pageViewController
                                                        //             .animateToPage(
                                                        //           i,
                                                        //           duration: Duration(
                                                        //               milliseconds:
                                                        //                   500),
                                                        //           curve:
                                                        //               Curves.ease,
                                                        //         );
                                                        //       },
                                                        //       effect:
                                                        //           ExpandingDotsEffect(
                                                        //         expansionFactor: 2,
                                                        //         spacing: 8,
                                                        //         radius: 16,
                                                        //         dotWidth: 16,
                                                        //         dotHeight: 16,
                                                        //         dotColor: Color(
                                                        //             0xFF9E9E9E),
                                                        //         activeDotColor:
                                                        //             Color(
                                                        //                 0xFF3F51B5),
                                                        //         paintStyle:
                                                        //             PaintingStyle
                                                        //                 .fill,
                                                        //       ),
                                                        //     ),
                                                        //   ),
                                                        // ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ])
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
