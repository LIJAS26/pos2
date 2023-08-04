//@dart=2.9
import 'package:built_collection/built_collection.dart';
import 'package:awafi_pos/backend/schema/categories_record.dart';

import '../backend/backend.dart';
import '../backend/firebase_storage/storage.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../flutter_flow/upload_media.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CategoryWidget extends StatefulWidget {
  CategoryWidget({Key key}) : super(key: key);

  @override
  _CategoryWidgetState createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  String uploadedFileUrl1;
  TextEditingController textController1;
  String uploadedFileUrl2;
  TextEditingController textController2;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    textController1 = TextEditingController();
    textController2 = TextEditingController();
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
          'Categories',
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
                tabs: [
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
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          IconButton(
                            onPressed: () async {
                              final selectedMedia = await selectMedia(
                                maxWidth: 1080.00,
                                maxHeight: 1320.00,
                              );
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
                            icon: Icon(
                              Icons.image_rounded,
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
                                          labelText: 'Category',
                                          labelStyle: FlutterFlowTheme.bodyText2
                                              .override(
                                            fontFamily: 'Montserrat',
                                            color: Color(0xFF8B97A2),
                                            fontWeight: FontWeight.w500,
                                          ),
                                          hintText: 'name',
                                          hintStyle: FlutterFlowTheme.bodyText2
                                              .override(
                                            fontFamily: 'Montserrat',
                                            color: Color(0xFF8B97A2),
                                            fontWeight: FontWeight.w500,
                                          ),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.transparent,
                                              width: 1,
                                            ),
                                            borderRadius:
                                                const BorderRadius.only(
                                              topLeft: Radius.circular(4.0),
                                              topRight: Radius.circular(4.0),
                                            ),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.transparent,
                                              width: 1,
                                            ),
                                            borderRadius:
                                                const BorderRadius.only(
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
                          Align(
                            alignment: Alignment(0.95, 0),
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                              child: FFButtonWidget(
                                onPressed: () async {
                                  final name = textController1.text;
                                  final imageUrl = uploadedFileUrl1;
                                  if (name == "" || name == null) {
                                    showUploadMessage(
                                        context, "please enter category name");
                                  } else if (imageUrl == "" ||
                                      imageUrl == null) {
                                    showUploadMessage(context,
                                        "please choose a category image");
                                  } else {
                                    bool proceed = await alert(context,
                                        'You want to add this category?');

                                    if (proceed) {
                                      final categoriesRecordData =
                                          createCategoriesRecordData(
                                        name: name,
                                        imageUrl: imageUrl,
                                        search: setSearchParam(name),
                                      );

                                      await CategoriesRecord.collection
                                          .add(categoriesRecordData)
                                          .then((DocumentReference doc) {
                                        String docId = doc.id;
                                        CategoriesRecord.collection
                                            .doc(docId)
                                            .update({"categoryId": docId});
                                        showUploadMessage(
                                            context, 'Upload Success!');
                                      });
                                    }
                                  }
                                },
                                text: 'Add',
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
                    StreamBuilder<List<CategoriesRecord>>(
                      stream: queryCategoriesRecord(),
                      builder: (context, snapshot) {
                        // Customize what your widget looks like when it's loading.
                        if (!snapshot.hasData) {
                          return Center(child: CircularProgressIndicator());
                        }
                        List<CategoriesRecord> listViewCategoriesRecordList =
                            snapshot.data;
                        // Customize what your widget looks like with no query results.
                        if (snapshot.data.isEmpty) {
                          return Container();
                          // For now, we'll just include some dummy data.

                        }
                        return ListView.builder(
                          padding: EdgeInsets.zero,
                          scrollDirection: Axis.vertical,
                          itemCount: listViewCategoriesRecordList.length,
                          itemBuilder: (context, listViewIndex) {
                            TextEditingController
                                textControllerList$listViewIndex =
                                TextEditingController();
                            String uploadFileUrlList$listViewIndex = "";
                            final listViewCategoriesRecord =
                                listViewCategoriesRecordList[listViewIndex];
                            textControllerList$listViewIndex.text =
                                listViewCategoriesRecord.name;
                            uploadFileUrlList$listViewIndex =
                                listViewCategoriesRecord.imageUrl;
                            return Card(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              color: Colors.blue,
                              elevation: 5,
                              child: Align(
                                alignment: Alignment(0, 0),
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Align(
                                        alignment: Alignment(0, 0),
                                        child: TextFormField(
                                          controller:
                                              textControllerList$listViewIndex,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.transparent,
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(4.0),
                                                topRight: Radius.circular(4.0),
                                              ),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.transparent,
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(4.0),
                                                topRight: Radius.circular(4.0),
                                              ),
                                            ),
                                          ),
                                          style:
                                              FlutterFlowTheme.title2.override(
                                            fontFamily: 'Poppins',
                                            color: Color(0xFF000000),
                                            fontWeight: FontWeight.w900,
                                            fontSize: 40,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment(0, 0),
                                        child: InkWell(
                                          onTap: () async {
                                            final selectedMedia =
                                                await selectMedia(
                                              maxWidth: 1290.00,
                                              maxHeight: 1200.00,
                                            );
                                            if (selectedMedia != null &&
                                                validateFileFormat(
                                                    selectedMedia.storagePath,
                                                    context)) {
                                              showUploadMessage(
                                                  context, 'Uploading file...',
                                                  showLoading: true);
                                              final downloadUrl =
                                                  await uploadData(
                                                      selectedMedia.storagePath,
                                                      selectedMedia.bytes);
                                              ScaffoldMessenger.of(context)
                                                  .hideCurrentSnackBar();
                                              if (downloadUrl != null) {
                                                uploadFileUrlList$listViewIndex =
                                                    downloadUrl;
                                                showUploadMessage(context,
                                                    'Image Upload Success!');
                                              } else {
                                                showUploadMessage(context,
                                                    'Failed to upload media');
                                              }
                                            }
                                          },
                                          child: CachedNetworkImage(
                                            imageUrl: listViewCategoriesRecord
                                                .imageUrl,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 200,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          IconButton(
                                            onPressed: () async {
                                              final imageUrl =
                                                  uploadFileUrlList$listViewIndex;
                                              final name =
                                                  textControllerList$listViewIndex
                                                      .text;
                                              if (name == "" || name == null) {
                                                showUploadMessage(context,
                                                    "please enter category name");
                                              } else if (imageUrl == "" ||
                                                  imageUrl == null) {
                                                showUploadMessage(context,
                                                    "please choose a category image");
                                              } else {
                                                bool proceed = await alert(
                                                    context,
                                                    'You want to update this category?');

                                                if (proceed) {
                                                  final categoriesRecordData =
                                                      createCategoriesRecordData(
                                                    imageUrl: imageUrl,
                                                    name: name,
                                                    search:
                                                        setSearchParam(name),
                                                  );

                                                  await listViewCategoriesRecord
                                                      .reference
                                                      .update(
                                                          categoriesRecordData);
                                                  showUploadMessage(context,
                                                      'Update Success!');
                                                }
                                              }
                                            },
                                            icon: Icon(
                                              Icons.save,
                                              color: Colors.black,
                                              size: 30,
                                            ),
                                            iconSize: 30,
                                          ),
                                          IconButton(
                                            onPressed: () async {
                                              bool proceed = await alert(
                                                  context,
                                                  'You want to delete this category?');

                                              if (proceed) {
                                                await listViewCategoriesRecord
                                                    .reference
                                                    .delete();
                                                showUploadMessage(
                                                    context, 'Delete Success!');
                                              }
                                            },
                                            icon: Icon(
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
                                ),
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
