//@dart=2.9
import 'package:built_collection/built_collection.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import '../backend/backend.dart';
import '../backend/firebase_storage/storage.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../flutter_flow/upload_media.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SubcategoryWidget extends StatefulWidget {
  SubcategoryWidget({Key key}) : super(key: key);

  @override
  _SubcategoryWidgetState createState() => _SubcategoryWidgetState();
}

class _SubcategoryWidgetState extends State<SubcategoryWidget> {
  String dropDownValue1;
  String uploadedFileUrl1;
  TextEditingController textController1;
  String dropDownValue2;
  TextEditingController textController2;
  String uploadedFileUrl2;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController categoryController = TextEditingController();
  String selectedCategory = "";
  final List<DropdownMenuItem> fetchedCategories = <DropdownMenuItem>[];

  @override
  void initState() {
    super.initState();
    dropDownValue1 = 'Option 1';
    textController1 = TextEditingController();
    dropDownValue2 = 'Option 1';
    textController2 = TextEditingController();
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
          'Sub Categories',
          style: FlutterFlowTheme.title2.override(
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
                tabs: const [
                  Tab(
                    text: 'Add',
                  ),
                  Tab(
                    text: 'Edit',
                  )
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          IconButton(
                            onPressed: () async {
                              final selectedMedia = await selectMedia();
                              if (selectedMedia != null &&
                                  validateFileFormat(
                                      selectedMedia.storagePath, context)) {
                                showUploadMessage(context, 'Uploading file...',
                                    showLoading: true);
                                final downloadUrl = await uploadData(
                                    selectedMedia.storagePath,
                                    selectedMedia.bytes);
                                ScaffoldMessenger.of(context)
                                    .hideCurrentSnackBar();
                                if (downloadUrl != null) {
                                  setState(
                                      () => uploadedFileUrl1 = downloadUrl);
                                  showUploadMessage(context, 'Success!');
                                } else {
                                  showUploadMessage(
                                      context, 'Failed to upload media');
                                }
                              }
                            },
                            icon: const Icon(
                              Icons.image,
                              color: Colors.black,
                              size: 50,
                            ),
                            iconSize: 50,
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
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: Color(0xFFE6E6E6),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
                                      child: TextFormField(
                                        controller: textController1,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          labelText: 'SubCategory',
                                          labelStyle: FlutterFlowTheme.bodyText2
                                              .override(
                                            fontFamily: 'Montserrat',
                                            color: Color(0xFF8B97A2),
                                            fontWeight: FontWeight.w500,
                                          ),
                                          hintText: 'enter sub-category name',
                                          hintStyle: FlutterFlowTheme.bodyText2
                                              .override(
                                            fontFamily: 'Montserrat',
                                            color: Color(0xFF8B97A2),
                                            fontWeight: FontWeight.w500,
                                          ),
                                          enabledBorder: const UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.transparent,
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.only(
                                              topLeft: Radius.circular(4.0),
                                              topRight: Radius.circular(4.0),
                                            ),
                                          ),
                                          focusedBorder: const UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.transparent,
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.only(
                                              topLeft: Radius.circular(4.0),
                                              topRight: Radius.circular(4.0),
                                            ),
                                          ),
                                        ),
                                        style:
                                            FlutterFlowTheme.bodyText2.override(
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
                              items: fetchedCategories,
                              value: selectedCategory,
                              hint: "Select one",
                              searchHint: "Select one",
                              onChanged: (value) {
                                setState(() {
                                  selectedCategory = value;
                                  categoryController.text = value;
                                });
                              },
                              isExpanded: true,
                            ),
                          ),
                          Align(
                            alignment: Alignment(0.95, 0),
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                              child: FFButtonWidget(
                                onPressed: () async {
                                  final imageUrl = uploadedFileUrl1;
                                  final categoryId = selectedCategory;
                                  final name = textController1.text;
                                  if (name == "" || name == null) {
                                    showUploadMessage(context,
                                        "please enter sub-category name");
                                  } else if (imageUrl == "" ||
                                      imageUrl == null) {
                                    showUploadMessage(context,
                                        "please choose a sub-category image");
                                  }else if (categoryId == "" ||
                                      categoryId == null) {
                                    showUploadMessage(context,
                                        "please choose a category");
                                  }
                                  else {
                                    bool proceed = await alert(context,
                                        'You want to upload this sub-category?');

                                    if (proceed) {
                                      final subCategoryRecordData =
                                          createSubCategoryRecordData(
                                        imageUrl: imageUrl,
                                        categoryId: categoryId,
                                        name: name,
                                        search: setSearchParam(name),
                                      );

                                      await SubCategoryRecord.collection
                                          .add(subCategoryRecordData)
                                          .then((DocumentReference doc) {
                                        String docId = doc.id;
                                        SubCategoryRecord.collection
                                            .doc(docId)
                                            .update({"subCategoryId": docId});
                                        showUploadMessage(context, 'Success!');
                                      });
                                    }
                                  }
                                },
                                text: 'Add ',
                                options: FFButtonOptions(
                                  width: 140,
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
                    ),
                    StreamBuilder<List<SubCategoryRecord>>(
                      stream: querySubCategoryRecord(),
                      builder: (context, snapshot) {
                        // Customize what your widget looks like when it's loading.
                        if (!snapshot.hasData) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        List<SubCategoryRecord> listViewSubCategoryRecordList =
                            snapshot.data;
                        // Customize what your widget looks like with no query results.
                        if (snapshot.data.isEmpty) {
                          return Container();
                          // For now, we'll just include some dummy data.

                        }
                        return ListView.builder(
                          padding: EdgeInsets.zero,
                          scrollDirection: Axis.vertical,
                          itemCount: listViewSubCategoryRecordList.length,
                          itemBuilder: (context, listViewIndex) {
                            final listViewSubCategoryRecord =
                                listViewSubCategoryRecordList[listViewIndex];
                            String selectedCategory$listViewIndex =
                                listViewSubCategoryRecord.categoryId;
                            TextEditingController
                                subCategoryController$listViewIndex =
                                TextEditingController();
                            subCategoryController$listViewIndex.text =
                                listViewSubCategoryRecord.name;
                            String uploadedFileUrl$listViewIndex =
                                listViewSubCategoryRecord.imageUrl;

                            return Card(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              color: Color(0xFFF5F5F5),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      final selectedMedia = await selectMedia();
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
                                          uploadedFileUrl$listViewIndex =
                                              downloadUrl;
                                          showUploadMessage(
                                              context, 'Success!');
                                        } else {
                                          showUploadMessage(context,
                                              'Failed to upload media');
                                        }
                                      }
                                    },
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          listViewSubCategoryRecord.imageUrl,
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Container(
                                        width: 200,
                                        child: TextFormField(
                                          controller:
                                              subCategoryController$listViewIndex,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            hintText:
                                                listViewSubCategoryRecord.name,
                                            hintStyle: FlutterFlowTheme
                                                .bodyText1
                                                .override(
                                              fontFamily: 'Poppins',
                                            ),
                                            enabledBorder: const UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.transparent,
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  BorderRadius.only(
                                                topLeft: Radius.circular(4.0),
                                                topRight: Radius.circular(4.0),
                                              ),
                                            ),
                                            focusedBorder: const UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.transparent,
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  BorderRadius.only(
                                                topLeft: Radius.circular(4.0),
                                                topRight: Radius.circular(4.0),
                                              ),
                                            ),
                                          ),
                                          style: FlutterFlowTheme.bodyText1
                                              .override(
                                            fontFamily: 'Poppins',
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Container(
                                        width: 170,
                                        // height: 70,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          border: Border.all(
                                            color: Color(0xFFE6E6E6),
                                          ),
                                        ),
                                        child: SearchableDropdown.single(
                                          items: fetchedCategories,
                                          value: selectedCategory$listViewIndex,
                                          hint: "Select Category",
                                          searchHint: "Select Category",
                                          onChanged: (value) {

                                              selectedCategory$listViewIndex =
                                                  value;

                                          },
                                          isExpanded: true,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      IconButton(
                                        onPressed: () async {
                                          final categoryId =
                                              selectedCategory$listViewIndex;
                                          final imageUrl =
                                              uploadedFileUrl$listViewIndex;
                                          final name =
                                              subCategoryController$listViewIndex
                                                  .text;
                                          if (name == "" || name == null) {
                                            showUploadMessage(context,
                                                "please enter sub-category name");
                                          } else if (imageUrl == "" ||
                                              imageUrl == null) {
                                            showUploadMessage(context,
                                                "please choose a sub-category image");
                                          } else {
                                            bool proceed = await alert(context,
                                                'You want to update this sub-category?');

                                            if (proceed) {
                                              final subCategoryRecordData =
                                                  createSubCategoryRecordData(
                                                categoryId: categoryId,
                                                imageUrl: imageUrl,
                                                name: name,
                                              );

                                              await listViewSubCategoryRecord
                                                  .reference
                                                  .update(
                                                      subCategoryRecordData);
                                              showUploadMessage(
                                                  context, 'Update Success!');
                                            }
                                          }
                                        },
                                        icon: const Icon(
                                          Icons.save,
                                          color: Colors.black,
                                          size: 30,
                                        ),
                                        iconSize: 30,
                                      ),
                                      IconButton(
                                        onPressed: () async {
                                          bool proceed = await alert(context,
                                              'You want to delete this sub-category?');

                                          if (proceed) {
                                            await listViewSubCategoryRecord
                                                .reference
                                                .delete();
                                            showUploadMessage(
                                                context, 'Delete Success!');
                                          }
                                        },
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Colors.black,
                                          size: 30,
                                        ),
                                        iconSize: 30,
                                      )
                                    ],
                                  )
                                ],
                              ),
                            );
                          },
                        );
                      },
                    )
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
