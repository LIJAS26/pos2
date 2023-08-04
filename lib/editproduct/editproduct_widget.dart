//@dart=2.9
import 'package:built_collection/built_collection.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:awafi_pos/auth/auth_util.dart';
import 'package:awafi_pos/backend/firebase_storage/storage.dart';
import 'package:awafi_pos/backend/schema/cut_record.dart';
import 'package:awafi_pos/flutter_flow/upload_media.dart';
import 'package:multiselect_dropdown/multiple_dropdown.dart';
import 'package:multiselect_dropdown/multiple_select.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class EditproductWidget extends StatefulWidget {
  const EditproductWidget({
    Key key,
    this.productId,
  }) : super(key: key);

  final String productId;

  @override
  _EditproductWidgetState createState() => _EditproductWidgetState();
}

class _EditproductWidgetState extends State<EditproductWidget> {
  String uploadedFileUrl1;
  String uploadedFileUrl2;
  TextEditingController textController1;
  TextEditingController textController2;
  TextEditingController textController3;
  TextEditingController discountPriceController;
  final pageViewController = PageController();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<DropdownMenuItem> fetchedCategories = [];
  List<DropdownMenuItem> fetchedSubCategory = [];
  List<DropdownMenuItem> fetchedBrand = [];
  List<DropdownMenuItem> fetchedShops = [];
  int selectedShopIndex = 0;
  String selectedCategory = "";
  String selectedSubCategory = "";
  String selectedBrand = "";
  List<String> _selectedColors = [];
  List<String> _selectedSize = [];
  List<CutRecord> _selectedCuts = [];
  List<String> images = [];
  QuerySnapshot subCategories;
  List<Map<String, dynamic>> unitList = [];
  List<DropdownMenuItem> units = [];
  List<Map<String, dynamic>> shopList = [];
  String basicUnit = '';
  TextEditingController startController;
  TextEditingController stepController;
  TextEditingController stopController;
  bool loaded = false;
  bool available;
  NewProductsRecord editproductNewProductsRecord;

  //

  @override
  void initState() {
    super.initState();
    textController1 = TextEditingController();
    textController2 = TextEditingController();
    textController3 = TextEditingController();
    discountPriceController = TextEditingController();
    startController = TextEditingController();
    stepController = TextEditingController();
    stopController = TextEditingController();
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

  Future getCuts() async {
    Stream cut = queryCutRecord();

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

  Future getShops() async {
    QuerySnapshot data1 =
    await FirebaseFirestore.instance.collection("shops").get();
    List<Map<String, dynamic>> temp = [];
    List<DropdownMenuItem> tempShop = [];
    int i = 0;
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
        fetchedShops = tempShop;
      });
    }
  }

  Future getUnits() async {
    DocumentSnapshot data1 =
    await FirebaseFirestore.instance.collection("units").doc("units").get();
    List<Map<String, dynamic>> temp = [];
    List<DropdownMenuItem> tempUnit = [];
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
        units = tempUnit;
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

  List<MultipleSelectItem> colors = [];
  List<MultipleSelectItem> sizes = [];
  List<MultipleSelectItem> cuts = [];

  Future getColors() async {
    DocumentSnapshot data1 = await FirebaseFirestore.instance
        .collection("colors")
        .doc("colors")
        .get();
    for (var color in data1.get('colorList')) {
      colors.add(MultipleSelectItem.build(
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.primaryColor,
          automaticallyImplyLeading: true,
          title: Text(
            'Edit Product',
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
                child: Column(children: [
                  TabBar(
                    labelColor: FlutterFlowTheme.primaryColor,
                    indicatorColor: FlutterFlowTheme.secondaryColor,
                    tabs: [
                      Tab(
                        text: 'Update',
                      ),
                      Tab(
                        text: 'Images',
                      )
                    ],
                  ),
                  Expanded(
                      child: StreamBuilder<List<NewProductsRecord>>(
                          stream: queryNewProductsRecord(
                            queryBuilder: (newProductsRecord) =>
                                newProductsRecord.where('productId',
                                    isEqualTo: widget.productId),
                            singleRecord: true,
                          ),
                          builder: (context, snapshot) {
                            // Customize what your widget looks like when it's loading.
                            if (!snapshot.hasData) {
                              return Center(child: CircularProgressIndicator());
                            }
                            List<NewProductsRecord>
                            editproductNewProductsRecordList =
                                snapshot.data;

                            // Customize what your widget looks like with no query results.
                            if (snapshot.data.isEmpty) {
                              return Container();
                              // For now, we'll just include some dummy data.

                            }

                            if (!loaded) {

                              editproductNewProductsRecord =
                                  editproductNewProductsRecordList.first;
                              images = (editproductNewProductsRecord.imageId
                                  ?.asList() ??
                                  [])
                                  .toList();
                              available=editproductNewProductsRecord.available;
                              textController1.text =
                                  editproductNewProductsRecord.name;
                              textController2.text =
                                  editproductNewProductsRecord.description;
                              textController3.text =
                                  editproductNewProductsRecord.price.toString();
                              discountPriceController.text =
                                  editproductNewProductsRecord.discountPrice
                                      .toString();
                              basicUnit =
                                  editproductNewProductsRecord.unit.toString();

                              selectedBrand =
                                  editproductNewProductsRecord.brand;
                              selectedCategory =
                                  editproductNewProductsRecord.category;
                              selectedShopIndex = 0;
                              for (int i = 0; i < shopList.length; i++) {
                                if (editproductNewProductsRecord.shopId ==
                                    shopList[i]['shopId']) {
                                  selectedShopIndex = i;
                                }
                              }
                              selectedSubCategory =
                                  editproductNewProductsRecord.subCategory;
                              uploadedFileUrl1 =
                              editproductNewProductsRecord.imageId.length ==
                                  0
                                  ? ""
                                  : editproductNewProductsRecord.imageId[0];
                              _selectedColors =
                                  editproductNewProductsRecord.color.toList();
                              _selectedSize =
                                  editproductNewProductsRecord.size.toList();
                              _selectedCuts =
                                  editproductNewProductsRecord.cuts.toList();
                              startController.text =
                                  editproductNewProductsRecord.start.toString();
                              stepController.text =
                                  editproductNewProductsRecord.step.toString();
                              stopController.text =
                                  editproductNewProductsRecord.stop.toString();
                              loaded = true;
                            }
                            return TabBarView(children: [
                              SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.stretch,
                                  children: [
                                    Builder(
                                      builder: (context) {
                                        return Container(
                                          width:
                                          MediaQuery.of(context).size.width,
                                          height: MediaQuery.of(context)
                                              .size
                                              .height *
                                              0.3,
                                          child: Stack(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    0, 0, 0, 0),
                                                child: PageView.builder(
                                                  controller:
                                                  pageViewController,
                                                  scrollDirection:
                                                  Axis.horizontal,
                                                  itemCount: images.length,
                                                  itemBuilder:
                                                      (context, imagesIndex) {
                                                    final imagesItem =
                                                    images[imagesIndex];

                                                    // return Image.network(
                                                    //   imagesItem,
                                                    //   width: 100,
                                                    //   height: 100,
                                                    //   fit: BoxFit.cover,
                                                    // );
                                                    return CachedNetworkImage(
                                                      imageUrl: imagesItem,
                                                      width: 100,
                                                      height: 100,
                                                      fit: BoxFit.cover,
                                                    );
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(0, 12, 0, 0),
                                      child: Row(
                                        children: [
                                          Text('Available product'),
                                          Switch(
                                            value: available,
                                            onChanged: (value) {
                                              setState(() {
                                                available = value;
                                              });
                                            },
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
                                                  controller: textController1,
                                                  obscureText: false,
                                                  decoration: InputDecoration(
                                                    labelText: 'Product Name',
                                                    labelStyle: FlutterFlowTheme
                                                        .bodyText2
                                                        .override(
                                                      fontFamily: 'Montserrat',
                                                      color: Color(0xFF8B97A2),
                                                      fontWeight:
                                                      FontWeight.w500,
                                                    ),
                                                    hintText:
                                                    'enter your product name',
                                                    hintStyle: FlutterFlowTheme
                                                        .bodyText2
                                                        .override(
                                                      fontFamily: 'Montserrat',
                                                      color: Color(0xFF8B97A2),
                                                      fontWeight:
                                                      FontWeight.w500,
                                                    ),
                                                    enabledBorder:
                                                    UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                        Colors.transparent,
                                                        width: 1,
                                                      ),
                                                      borderRadius:
                                                      const BorderRadius
                                                          .only(
                                                        topLeft:
                                                        Radius.circular(
                                                            4.0),
                                                        topRight:
                                                        Radius.circular(
                                                            4.0),
                                                      ),
                                                    ),
                                                    focusedBorder:
                                                    UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                        Colors.transparent,
                                                        width: 1,
                                                      ),
                                                      borderRadius:
                                                      const BorderRadius
                                                          .only(
                                                        topLeft:
                                                        Radius.circular(
                                                            4.0),
                                                        topRight:
                                                        Radius.circular(
                                                            4.0),
                                                      ),
                                                    ),
                                                  ),
                                                  style: FlutterFlowTheme
                                                      .bodyText2
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
                                                      fontWeight:
                                                      FontWeight.w500,
                                                    ),
                                                    hintText:
                                                    'product description',
                                                    hintStyle: FlutterFlowTheme
                                                        .bodyText2
                                                        .override(
                                                      fontFamily: 'Montserrat',
                                                      color: Color(0xFF8B97A2),
                                                      fontWeight:
                                                      FontWeight.w500,
                                                    ),
                                                    enabledBorder:
                                                    UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                        Colors.transparent,
                                                        width: 1,
                                                      ),
                                                      borderRadius:
                                                      const BorderRadius
                                                          .only(
                                                        topLeft:
                                                        Radius.circular(
                                                            4.0),
                                                        topRight:
                                                        Radius.circular(
                                                            4.0),
                                                      ),
                                                    ),
                                                    focusedBorder:
                                                    UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                        Colors.transparent,
                                                        width: 1,
                                                      ),
                                                      borderRadius:
                                                      const BorderRadius
                                                          .only(
                                                        topLeft:
                                                        Radius.circular(
                                                            4.0),
                                                        topRight:
                                                        Radius.circular(
                                                            4.0),
                                                      ),
                                                    ),
                                                  ),
                                                  style: FlutterFlowTheme
                                                      .bodyText2
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
                                                      fontWeight:
                                                      FontWeight.w500,
                                                    ),
                                                    hintText: 'product price',
                                                    hintStyle: FlutterFlowTheme
                                                        .bodyText2
                                                        .override(
                                                      fontFamily: 'Montserrat',
                                                      color: Color(0xFF8B97A2),
                                                      fontWeight:
                                                      FontWeight.w500,
                                                    ),
                                                    enabledBorder:
                                                    UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                        Colors.transparent,
                                                        width: 1,
                                                      ),
                                                      borderRadius:
                                                      const BorderRadius
                                                          .only(
                                                        topLeft:
                                                        Radius.circular(
                                                            4.0),
                                                        topRight:
                                                        Radius.circular(
                                                            4.0),
                                                      ),
                                                    ),
                                                    focusedBorder:
                                                    UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                        Colors.transparent,
                                                        width: 1,
                                                      ),
                                                      borderRadius:
                                                      const BorderRadius
                                                          .only(
                                                        topLeft:
                                                        Radius.circular(
                                                            4.0),
                                                        topRight:
                                                        Radius.circular(
                                                            4.0),
                                                      ),
                                                    ),
                                                  ),
                                                  style: FlutterFlowTheme
                                                      .bodyText2
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
                                                  controller:
                                                  discountPriceController,
                                                  obscureText: false,
                                                  decoration: InputDecoration(
                                                    labelText: 'discount price',
                                                    labelStyle: FlutterFlowTheme
                                                        .bodyText2
                                                        .override(
                                                      fontFamily: 'Montserrat',
                                                      color: Color(0xFF8B97A2),
                                                      fontWeight:
                                                      FontWeight.w500,
                                                    ),
                                                    hintText: 'discount price',
                                                    hintStyle: FlutterFlowTheme
                                                        .bodyText2
                                                        .override(
                                                      fontFamily: 'Montserrat',
                                                      color: Color(0xFF8B97A2),
                                                      fontWeight:
                                                      FontWeight.w500,
                                                    ),
                                                    enabledBorder:
                                                    UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                        Colors.transparent,
                                                        width: 1,
                                                      ),
                                                      borderRadius:
                                                      const BorderRadius
                                                          .only(
                                                        topLeft:
                                                        Radius.circular(
                                                            4.0),
                                                        topRight:
                                                        Radius.circular(
                                                            4.0),
                                                      ),
                                                    ),
                                                    focusedBorder:
                                                    UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                        Colors.transparent,
                                                        width: 1,
                                                      ),
                                                      borderRadius:
                                                      const BorderRadius
                                                          .only(
                                                        topLeft:
                                                        Radius.circular(
                                                            4.0),
                                                        topRight:
                                                        Radius.circular(
                                                            4.0),
                                                      ),
                                                    ),
                                                  ),
                                                  style: FlutterFlowTheme
                                                      .bodyText2
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
                                          basicUnit = value;
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
                                    SearchableDropdown.single(
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
                                    const Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10.0, horizontal: 0.0),
                                    ),
                                    SearchableDropdown.single(
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
                                    const Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10.0, horizontal: 0.0),
                                    ),
                                    SearchableDropdown.single(
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
                                    const Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10.0, horizontal: 0.0),
                                    ),
                                    MultipleDropDown(
                                      placeholder: 'Select Product Colors',
                                      disabled: false,
                                      values: _selectedColors,
                                      elements: colors,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10.0, horizontal: 0.0),
                                    ),
                                    MultipleDropDown(
                                      placeholder: 'Select Product Sizes',
                                      disabled: false,
                                      values: _selectedSize,
                                      elements: sizes,
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
                                                      fontWeight:
                                                      FontWeight.w500,
                                                    ),
                                                    hintText:
                                                    'min qty of purchase',
                                                    hintStyle: FlutterFlowTheme
                                                        .bodyText2
                                                        .override(
                                                      fontFamily: 'Montserrat',
                                                      color: Color(0xFF8B97A2),
                                                      fontWeight:
                                                      FontWeight.w500,
                                                    ),
                                                    enabledBorder:
                                                    UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                        Colors.transparent,
                                                        width: 1,
                                                      ),
                                                      borderRadius:
                                                      const BorderRadius
                                                          .only(
                                                        topLeft:
                                                        Radius.circular(
                                                            4.0),
                                                        topRight:
                                                        Radius.circular(
                                                            4.0),
                                                      ),
                                                    ),
                                                    focusedBorder:
                                                    UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                        Colors.transparent,
                                                        width: 1,
                                                      ),
                                                      borderRadius:
                                                      const BorderRadius
                                                          .only(
                                                        topLeft:
                                                        Radius.circular(
                                                            4.0),
                                                        topRight:
                                                        Radius.circular(
                                                            4.0),
                                                      ),
                                                    ),
                                                  ),
                                                  style: FlutterFlowTheme
                                                      .bodyText2
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
                                                      fontWeight:
                                                      FontWeight.w500,
                                                    ),
                                                    hintText: 'qty step',
                                                    hintStyle: FlutterFlowTheme
                                                        .bodyText2
                                                        .override(
                                                      fontFamily: 'Montserrat',
                                                      color: Color(0xFF8B97A2),
                                                      fontWeight:
                                                      FontWeight.w500,
                                                    ),
                                                    enabledBorder:
                                                    UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                        Colors.transparent,
                                                        width: 1,
                                                      ),
                                                      borderRadius:
                                                      const BorderRadius
                                                          .only(
                                                        topLeft:
                                                        Radius.circular(
                                                            4.0),
                                                        topRight:
                                                        Radius.circular(
                                                            4.0),
                                                      ),
                                                    ),
                                                    focusedBorder:
                                                    UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                        Colors.transparent,
                                                        width: 1,
                                                      ),
                                                      borderRadius:
                                                      const BorderRadius
                                                          .only(
                                                        topLeft:
                                                        Radius.circular(
                                                            4.0),
                                                        topRight:
                                                        Radius.circular(
                                                            4.0),
                                                      ),
                                                    ),
                                                  ),
                                                  style: FlutterFlowTheme
                                                      .bodyText2
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
                                                      fontWeight:
                                                      FontWeight.w500,
                                                    ),
                                                    hintText:
                                                    'max qty for purchase',
                                                    hintStyle: FlutterFlowTheme
                                                        .bodyText2
                                                        .override(
                                                      fontFamily: 'Montserrat',
                                                      color: Color(0xFF8B97A2),
                                                      fontWeight:
                                                      FontWeight.w500,
                                                    ),
                                                    enabledBorder:
                                                    UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                        Colors.transparent,
                                                        width: 1,
                                                      ),
                                                      borderRadius:
                                                      const BorderRadius
                                                          .only(
                                                        topLeft:
                                                        Radius.circular(
                                                            4.0),
                                                        topRight:
                                                        Radius.circular(
                                                            4.0),
                                                      ),
                                                    ),
                                                    focusedBorder:
                                                    UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                        Colors.transparent,
                                                        width: 1,
                                                      ),
                                                      borderRadius:
                                                      const BorderRadius
                                                          .only(
                                                        topLeft:
                                                        Radius.circular(
                                                            4.0),
                                                        topRight:
                                                        Radius.circular(
                                                            4.0),
                                                      ),
                                                    ),
                                                  ),
                                                  style: FlutterFlowTheme
                                                      .bodyText2
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
                                    Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Align(
                                            alignment: Alignment(-0.5, 0),
                                            child: Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 16, 0, 0),
                                              child: FFButtonWidget(
                                                icon: Icon(Icons.save),
                                                onPressed: () async {
                                                  final name =
                                                      textController1.text;
                                                  final description =
                                                      textController2.text;
                                                  if (name == "" ||
                                                      name == null) {
                                                    showUploadMessage(context,
                                                        "please enter product name");
                                                  } else if (uploadedFileUrl1 ==
                                                      "" ||
                                                      uploadedFileUrl1 ==
                                                          null) {
                                                    showUploadMessage(context,
                                                        "please choose a product image");
                                                  } else {
                                                    bool proceed = await alert(
                                                        context,
                                                        'You want to upload this product?');

                                                    print(selectedCategory);
                                                    if (proceed) {
                                                      final price =
                                                      double.parse(
                                                          textController3
                                                              .text);
                                                      final discountPrice =
                                                      double.parse(
                                                          discountPriceController
                                                              .text);
                                                      final userId =
                                                          currentUserUid;

                                                      final newProductsRecordData =
                                                      {
                                                        ...createNewProductsRecordData(
                                                          name: name,
                                                          description:
                                                          description,
                                                          price: price,
                                                          discountPrice:
                                                          discountPrice,
                                                          userId: userId,
                                                          category:
                                                          selectedCategory,
                                                          subCategory:
                                                          selectedSubCategory,
                                                          brand: selectedBrand,
                                                          search:
                                                          setSearchParam(
                                                              name),
                                                          color: convertListToListBuilder(
                                                              _selectedColors),
                                                          size:
                                                          convertListToListBuilder(
                                                              _selectedSize),
                                                          productId:
                                                          editproductNewProductsRecord
                                                              .productId,
                                                          unit: basicUnit,
                                                          cuts:
                                                          convertMapListToMapListBuilder(
                                                              _selectedCuts),
                                                          shopId: shopList[
                                                          selectedShopIndex]
                                                          ['shopId'],
                                                          shopName: shopList[
                                                          selectedShopIndex]
                                                          ['name'],
                                                          branchId:
                                                          "currentBranchId",
                                                          start: double.tryParse(
                                                              startController
                                                                  .text),
                                                          step: double.tryParse(
                                                              stepController
                                                                  .text),
                                                          stop: double.tryParse(
                                                              stopController
                                                                  .text),
                                                          available: available,
                                                        ),
                                                        'imageId': FieldValue
                                                            .arrayUnion([
                                                          uploadedFileUrl1
                                                        ]),
                                                      };

                                                      await NewProductsRecord
                                                          .collection
                                                          .doc(widget.productId)
                                                          .set(
                                                          newProductsRecordData);
                                                      showUploadMessage(context,
                                                          'Update Success!');
                                                    }
                                                  }
                                                },
                                                text: 'Save',
                                                options: FFButtonOptions(
                                                  width: 150,
                                                  height: 60,
                                                  color: FlutterFlowTheme
                                                      .primaryColor,
                                                  textStyle: FlutterFlowTheme
                                                      .subtitle2
                                                      .override(
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
                                          ),
                                          Align(
                                            alignment: Alignment(0.95, 0),
                                            child: Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 16, 0, 0),
                                              child: FFButtonWidget(
                                                icon: Icon(Icons.delete),
                                                onPressed: () async {
                                                  // final name = textController1.text;
                                                  // final description = textController2.text;
                                                  // final price =
                                                  // double.parse(textController3.text);
                                                  // final userId = currentUserUid;

                                                  bool proceed = await alert(
                                                      context,
                                                      'You want to delete this product?');

                                                  if (proceed) {
                                                    await NewProductsRecord
                                                        .collection
                                                        .doc(widget.productId)
                                                        .delete();
                                                    showUploadMessage(context,
                                                        'Delete Success!');
                                                  }
                                                },
                                                text: 'Delete',
                                                options: FFButtonOptions(
                                                  width: 150,
                                                  height: 60,
                                                  color: FlutterFlowTheme
                                                      .primaryColor,
                                                  textStyle: FlutterFlowTheme
                                                      .subtitle2
                                                      .override(
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
                                        ]),
                                    SizedBox(
                                      height: 20.0,
                                    )
                                  ],
                                ),
                              ),
                              Column(children: [
                                IconButton(
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
                                      await FirebaseFirestore.instance
                                          .collection('products')
                                          .doc(editproductNewProductsRecord
                                          .productId)
                                          .update({
                                        'imageId': FieldValue.arrayUnion(
                                            [downloadUrl]),
                                      }).then((value) {
                                        setState(() {
                                          images.add(downloadUrl);
                                        });
                                      });
                                      ScaffoldMessenger.of(context)
                                          .hideCurrentSnackBar();
                                      if (downloadUrl != null) {
                                        setState(() =>
                                        uploadedFileUrl1 = downloadUrl);
                                        showUploadMessage(context, 'Success!');
                                      } else {
                                        showUploadMessage(
                                            context, 'Failed to upload media');
                                      }
                                    }
                                  },
                                  icon: Icon(
                                    Icons.image,
                                    color: Colors.black,
                                    size: 30,
                                  ),
                                  iconSize: 30,
                                ),
                                // print(images);
                                Container(
                                  height:
                                  MediaQuery.of(context).size.height - 220,
                                  child: ListView.builder(
                                    padding: EdgeInsets.zero,
                                    scrollDirection: Axis.vertical,
                                    itemCount: images.length,
                                    itemBuilder: (context, listViewIndex) {
                                      final imagesItem = images[listViewIndex];

                                      return ListTile(
                                        title: Image.network(
                                          imagesItem,
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.cover,
                                        ),
                                        trailing: IconButton(
                                          onPressed: () async {
                                            await FirebaseFirestore.instance
                                                .collection('products')
                                                .doc(
                                                editproductNewProductsRecord
                                                    .productId)
                                                .update({
                                              'imageId': FieldValue.arrayRemove(
                                                  [imagesItem]),
                                            }).then((value) {
                                              FirebaseStorage.instance
                                                  .refFromURL(imagesItem)
                                                  .delete();
                                              setState(() {
                                                images.remove(imagesItem);
                                              });
                                            });
                                          },
                                          icon: Icon(
                                            Icons.delete,
                                            color: Colors.black,
                                            size: 30,
                                          ),
                                          iconSize: 30,
                                        ),
                                      );
                                      // return CachedNetworkImage(
                                      //   imageUrl:imagesItem,
                                      //   width: 100,
                                      //   height: 100,
                                      //   fit: BoxFit.cover,
                                      // );
                                    },
                                  ),
                                )
                              ]),
                            ]);
                          }))
                ]))));
  }
}
