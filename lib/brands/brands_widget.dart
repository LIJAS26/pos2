//@dart=2.9
import 'package:built_collection/built_collection.dart';


import '../backend/backend.dart';
import '../backend/firebase_storage/storage.dart';
import '../flutter_flow/flutter_flow_theme.dart';

import '../flutter_flow/flutter_flow_widgets.dart';
import '../flutter_flow/upload_media.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class BrandsWidget extends StatefulWidget {
  BrandsWidget({Key key}) : super(key: key);

  @override
  _BrandsWidgetState createState() => _BrandsWidgetState();
}

class _BrandsWidgetState extends State<BrandsWidget> {
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
    ListBuilder<String> caseSearchList=ListBuilder<String>() ;
    String temp = "";

    List<String> nameSplits=caseNumber.split(" ");
    for(int i=0;i<nameSplits.length;i++) {
      String name = "";

      for(int k=i;k<nameSplits.length;k++){
        name=name+nameSplits[k]+" ";
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
          'Brands',
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
                            icon: const Icon(
                              Icons.image_outlined,
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
                                          labelText: 'Brand ',
                                          labelStyle: FlutterFlowTheme.bodyText2
                                              .override(
                                            fontFamily: 'Montserrat',
                                            color: Color(0xFF8B97A2),
                                            fontWeight: FontWeight.w500,
                                          ),
                                          hintText: 'Enter your Brand name',
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
                          Align(
                            alignment: const Alignment(0.95, 0),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                              child: FFButtonWidget(
                                onPressed: () async {
                                  final brand = textController1.text;
                                  final imageUrl = uploadedFileUrl1;
    if(brand=="" ||brand==null ){
    showUploadMessage(context, "please enter product name");
    }
    else if(imageUrl=="" ||imageUrl==null){
    showUploadMessage(context, "please choose a product image");
    }
    else {
    bool proceed = await alert(context,
    'You want to add this brand?');


    if (proceed) {
    final brandsRecordData =
    createBrandsRecordData(
    brand: brand,
    imageUrl: imageUrl,
    search: setSearchParam(brand),
    );

    await BrandsRecord.collection
        .add(brandsRecordData)
        .then((DocumentReference doc) {
    String docId = doc.id;

    BrandsRecord.collection.doc(docId).update({"brandId": docId});
    showUploadMessage(
    context, 'Success!');
    });
    }
    }
                                },
                                text: 'Continue',
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
                                  borderSide: const BorderSide(
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
                    StreamBuilder<List<BrandsRecord>>(
                      stream: queryBrandsRecord(),
                      builder: (context, snapshot) {
                        // Customize what your widget looks like when it's loading.
                        if (!snapshot.hasData) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        List<BrandsRecord> listViewBrandsRecordList =
                            snapshot.data;
                        // Customize what your widget looks like with no query results.
                        if (snapshot.data.isEmpty) {
                          return Container();
                          // For now, we'll just include some dummy data.

                        }
                        return ListView.builder(
                          padding: EdgeInsets.zero,
                          scrollDirection: Axis.vertical,
                          itemCount: listViewBrandsRecordList.length,
                          itemBuilder: (context, listViewIndex) {
                            TextEditingController textControllerList$listViewIndex=TextEditingController();
                            String uploadFileUrlList$listViewIndex="";
                            final listViewBrandsRecord =
                                listViewBrandsRecordList[listViewIndex];
                            textControllerList$listViewIndex.text=listViewBrandsRecord.brand;
                            uploadFileUrlList$listViewIndex=listViewBrandsRecord.imageUrl;
                            return Card(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              color: Color(0xFFF5F5F5),
                              child: Stack(
                                children: [
                                  Align(
                                    alignment: Alignment(0, 0),
                                    child: InkWell(
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
                                            uploadFileUrlList$listViewIndex=downloadUrl;
                                            print(uploadFileUrlList$listViewIndex);

                                            showUploadMessage(
                                                context, 'Image upload Success!');
                                          } else {
                                            showUploadMessage(context,
                                                'Failed to upload media');
                                          }
                                        }
                                      },
                                      child: CachedNetworkImage(
                                        imageUrl: listViewBrandsRecord.imageUrl,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 150,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: const Alignment(0, 0),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                                      child: TextFormField(
                                        controller: textControllerList$listViewIndex,
                                        obscureText: false,
                                        decoration: const InputDecoration(

                                          enabledBorder: UnderlineInputBorder(
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
                                          focusedBorder: UnderlineInputBorder(
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
                                        style: FlutterFlowTheme.title2.override(
                                          fontFamily: 'Poppins',
                                          color: Color(0xFF000000),
                                          fontWeight: FontWeight.w900,
                                          fontSize: 40,
                                        ),
                                        textAlign: TextAlign.center,

                                      ),
                                    ),
                                  ),

                                  Align(
                                    alignment: const Alignment(1, 1),
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        color: Colors.black,
                                      ),
                                      child: Column(
                                        children: [
                                          IconButton(
                                            onPressed: () async {
                                              final brand = textControllerList$listViewIndex.text;
                                              final imageUrl = uploadFileUrlList$listViewIndex;
    if(brand=="" ||brand==null ){
    showUploadMessage(context, "please enter brand name");
    }
    else if(imageUrl=="" ||imageUrl==null){
    showUploadMessage(context, "please choose a brand image");
    }
    else {
      bool proceed = await alert(context,
          'You want to update this brand?');


      if (proceed) {
        final brandsRecordData =
        createBrandsRecordData(
          brand: brand,
          imageUrl: imageUrl,
          search: setSearchParam(brand),
        );

        await listViewBrandsRecord.reference
            .update(brandsRecordData).then((value) => setState(() => null));
        showUploadMessage(
            context, 'Update Success!');
      }
    }
                                            },
                                            icon: const Icon(
                                              Icons.save,
                                              color: Color(0xFFE4E1E9),
                                              size: 30,
                                            ),
                                            iconSize: 30,
                                          ),
                                          Padding(padding: EdgeInsets.only(top: 55.0)),
                                          IconButton(
                                            onPressed: () async {

                                              bool proceed = await alert(context,
                                               'You want to Delete this brand?');


                                            if (proceed) {
                                              await listViewBrandsRecord
                                                  .reference
                                                  .delete();
                                              showUploadMessage(
                                                  context, 'Delete Success!');
                                            }
                                            },
                                            icon: const Icon(
                                              Icons.delete,
                                              color: Colors.white,
                                              size: 30,
                                            ),
                                            iconSize: 30,
                                          )
                                        ],
                                      ),
                                    ),
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
