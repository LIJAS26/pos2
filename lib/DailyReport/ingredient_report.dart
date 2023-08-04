import 'package:awafi_pos/main.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Branches/branches.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../modals/Print/pdf_api.dart';
import 'genaratePDF/ingredinetPdf.dart';
import 'genaratePDF/ingredinetReportModel.dart';
import 'genaratePDF/productPdf.dart';
import 'genaratePDF/productReport_model.dart';


class IngredientReport extends StatefulWidget {
  final QuerySnapshot salesData;
  final DateTime From;
  final DateTime To;


  const IngredientReport({Key? key, required this.salesData, required this.From, required this.To  }) : super(key: key);

  @override
  State<IngredientReport> createState() => _IngredientReportState();
}

class _IngredientReportState extends State<IngredientReport> {


  List ingredients=[];

  @override
  void initState(){
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ingredient Report"),
        centerTitle: true,
        backgroundColor: default_color,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: IconButton(onPressed: () async {

              print(ingredients);
              print(widget.From);
              print(widget.To);


              try {
                final invoice =
                IncredientReportData(
                  ing:ingredients,
                  // From:widget.From,
                  // To:widget.To,


                );
                print('ameeeeeee');
                print(invoice.ing.length);
                print(invoice.ing[0]['quantity']);
                final pdfFile =
                await IncredinetPdfPage.generate(invoice);
                await PdfApi.openFile(pdfFile);
              } catch (e) {
                print(e);
                // return showDialog(
                //     context: context,
                //     builder: (context) {
                //       return AlertDialog(
                //         title: Text('error'),
                //         content: Text(e.toString()),
                //
                //         actions: <Widget>[
                //           new FlatButton(
                //             child: new Text('ok'),
                //             onPressed: () {
                //               Navigator.of(context).pop();
                //             },
                //           )
                //         ],
                //       );
                //     });
              }

            }, icon: Icon(Icons.picture_as_pdf)),


          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot<Map<String,dynamic>>>(
              stream: FirebaseFirestore.instance.collection('ingredients').snapshots(),
              builder: (context, snapshot) {
                if(!snapshot.hasData){
                  return Center(child: CircularProgressIndicator(),);
                }

                return ListView.builder(
                    itemCount: snapshot.data!.docs?.length??0,
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (buildContext,int index){
                      Map<String,dynamic> ing =snapshot.data!.docs![index].data();
                      ingredients=snapshot.data!.docs;

                      return Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 8),
                        child: Container(
                          width: double.infinity,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 5,
                                color: Color(0x520E151B),
                                offset: Offset(0, 2),
                              )
                            ],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                            child: Row(
                              // mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // ClipRRect(
                                //   borderRadius: BorderRadius.circular(6),
                                //   child: CachedNetworkImage(
                                //     imageUrl:
                                //     productImgByName[newPrd.keys.toList()[index]],
                                //     width: 80,
                                //     height: 80,
                                //     fit: BoxFit.cover,
                                //   ),
                                // ),
                                SizedBox(width: 50,),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width*0.3,
                                    child: Text(
                                      ing["ingredient"],
                                      style: FlutterFlowTheme.subtitle1.override(
                                        fontFamily: 'Lexend Deca',
                                        color: Color(0xFF090F13),
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width*0.3,
                                  child: Center(
                                    child: Text(
                                      'x ${ing["quantity"].toString()}',
                                      style: FlutterFlowTheme.bodyText2.override(
                                        fontFamily: 'Lexend Deca',
                                        color: Color(0xFF57636C),
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                // Container(
                                //   width: MediaQuery.of(context).size.width*0.3,
                                //   child: Center(
                                //     child: Text(
                                //       ' ${(ing["quantity"]*ing["price"]).toString()}',
                                //       style: FlutterFlowTheme.bodyText2.override(
                                //         fontFamily: 'Lexend Deca',
                                //         color: Color(0xFF57636C),
                                //         fontSize: 16,
                                //         fontWeight: FontWeight.bold,
                                //       ),
                                //     ),
                                //   ),
                                // ),
                                SizedBox(width: 50,),
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              }
            ),
          ),
        ],
      ),
    );
  }
}