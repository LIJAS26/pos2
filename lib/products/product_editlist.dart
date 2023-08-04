//@dart=2.9
import 'package:cached_network_image/cached_network_image.dart';

import '../backend/backend.dart';
import '../editproduct/editproduct_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class ProductsEditListWidget extends StatefulWidget {
  final String subCategoryId;

  ProductsEditListWidget({this.subCategoryId, Key key}) : super(key: key);

  @override
  _ProductsEditListWidgetState createState() => _ProductsEditListWidgetState();
}

class _ProductsEditListWidgetState extends State<ProductsEditListWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
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
        child: Column(children: [
          Expanded(
            child: StreamBuilder<List<NewProductsRecord>>(
              stream: queryNewProductsRecord(
                  // ignore: non_constant_identifier_names
                  queryBuilder: (NewProductsRecord) => NewProductsRecord.where(
                      'subCategory',
                      isEqualTo: widget.subCategoryId)
                      .where('branchId',isEqualTo: "currentBranchId")),
              builder: (context, snapshot) {
                // Customize what your widget looks like when it's loading.
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                List<NewProductsRecord> listViewNewProductsRecordList =
                    snapshot.data;
                // Customize what your widget looks like with no query results.
                if (snapshot.data.isEmpty) {
                  return Container();
                  // For now, we'll just include some dummy data.

                }
                return ListView.separated(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: listViewNewProductsRecordList.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(height: 20.0);
                  },
                  itemBuilder: (context, index) {
                    var item = listViewNewProductsRecordList[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditproductWidget(
                              productId: item.productId,
                            ),
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
                                    CachedNetworkImageProvider(item.imageId[0]),
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
