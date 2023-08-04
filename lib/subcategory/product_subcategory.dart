//@dart=2.9

import 'package:awafi_pos/products/product_editlist.dart';
import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:http/http.dart' as http;

class ProductSubcategoryWidget extends StatefulWidget {
  final String categoryId;

  ProductSubcategoryWidget({this.categoryId, Key key}) : super(key: key);

  @override
  _ProductSubcategoryWidgetState createState() =>
      _ProductSubcategoryWidgetState();
}

class _ProductSubcategoryWidgetState extends State<ProductSubcategoryWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

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
        child: Column(children: [
          Expanded(
            child: StreamBuilder<List<SubCategoryRecord>>(
              stream: querySubCategoryRecord(
                  // ignore: non_constant_identifier_names
                  queryBuilder: (SubCategoryRecord) => SubCategoryRecord.where(
                      'categoryId',
                      isEqualTo: widget.categoryId)),
              builder: (context, snapshot) {
                // Customize what your widget looks like when it's loading.
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                List<SubCategoryRecord> listViewSubCategoryRecordList =
                    snapshot.data;
                // Customize what your widget looks like with no query results.
                if (snapshot.data.isEmpty) {
                  return Container();
                  // For now, we'll just include some dummy data.

                }
                return ListView.separated(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: listViewSubCategoryRecordList.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(height: 20.0);
                  },
                  itemBuilder: (context, index) {
                    var item = listViewSubCategoryRecordList[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductsEditListWidget(
                                subCategoryId: item.subCategoryId),
                          ),
                        );
                      },
                      child: Container(
                        constraints: new BoxConstraints.expand(height: 130.0),
                        alignment: Alignment.bottomLeft,
                        padding: EdgeInsets.only(left: 16.0, bottom: 8.0),
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                            image: DecorationImage(
                                image:
                                    CachedNetworkImageProvider(


                                        item.imageUrl),
                                // filterQuality: FilterQuality.low,
                                fit: BoxFit.cover,
                                colorFilter: ColorFilter.mode(
                                    Color.fromRGBO(90, 90, 90, 0.8),
                                    BlendMode.modulate))),
                        child: Center(
                          child: Text(
                            item.name.toString().toUpperCase(),
                            style: TextStyle(
                                fontFamily: 'NovaSquare',
                                fontWeight: FontWeight.w600,
                                fontSize: 35.0,
                                color: Colors.white,
                                letterSpacing: 1.0),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ]),
      ),
    );
  }
}
