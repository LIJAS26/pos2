//@dart=2.9
import 'package:awafi_pos/backend/schema/categories_record.dart';
import 'package:awafi_pos/subcategory/product_subcategory.dart';
import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProductCategoryWidget extends StatefulWidget {
  ProductCategoryWidget({Key key}) : super(key: key);

  @override
  _ProductCategoryWidgetState createState() => _ProductCategoryWidgetState();
}

class _ProductCategoryWidgetState extends State<ProductCategoryWidget> {

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
        child: Column(
          children: [

            Expanded(
              child: StreamBuilder<List<CategoriesRecord>>(
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
                  return ListView.separated(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: listViewCategoriesRecordList.length,
                    separatorBuilder: (BuildContext context, int index){
                      return SizedBox(height: 20.0);
                    },
                    itemBuilder: (context,index){
                      var item = listViewCategoriesRecordList[index];
                      return GestureDetector(
                        onTap: (){
                           Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductSubcategoryWidget(categoryId: item.categoryId,),
                            ),
                          );
                        },
                        child: Container(
                          constraints: new BoxConstraints.expand(
                              height: 130.0
                          ),
                          alignment: Alignment.bottomLeft,
                          padding: EdgeInsets.only(left: 16.0, bottom: 8.0),
                          decoration: BoxDecoration(
                            color: Colors.black,
                              borderRadius: BorderRadius.all(Radius.circular(15.0)),
                              image: DecorationImage(
                                  image: CachedNetworkImageProvider(item.imageUrl),
                                  fit: BoxFit.cover,
                                  colorFilter: ColorFilter.mode(Color.fromRGBO(90,90,90, 0.8), BlendMode.modulate)
                              )
                          ),
                          child: Center(
                            child: Text(
                              item.name.toString().toUpperCase(),
                              style: TextStyle(
                                  fontFamily: 'NovaSquare',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 35.0,
                                  color: Colors.white,
                                  letterSpacing: 1.0
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
