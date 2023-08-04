
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../modals/Print/pdf_api.dart';
import 'genaratePDF/categoryPdf.dart';
import 'genaratePDF/categoryReportModel.dart';



class CategoryReport extends StatefulWidget {
  final QuerySnapshot salesData;
  final DateTime From;
  final DateTime To;

  const CategoryReport({Key? key, required this.salesData, required this.From, required this.To  }) : super(key: key);

  @override
  State<CategoryReport> createState() => _CategoryReportState();
}

class _CategoryReportState extends State<CategoryReport> {



  double totalSales=0;
  List products=[];
  List fullProducts=[];

  Map<String,dynamic> productImgByName={};
  Map<String,dynamic> productPriceByName={};
  Map<String,dynamic> newPrd={};


  // getSales() async {
  //   totalSales=0;
  //   List salesList=[];
  //   products=[];
  //   newPrd={};
  //
  //   for(var data in widget.salesData.docs){
  //
  //     List items=data['billItems'];
  //     for(var product in items){
  //       String name=product['category']??" ";
  //       fullProducts.add(name);
  //       if(newPrd[name]==null){
  //         newPrd[name]=product['qty'];
  //
  //       }else{
  //         newPrd[name]+=product['qty'];
  //       }
  //       if(!products.contains(name)){
  //         products.add(product['category']);
  //       }
  //     }
  //     totalSales+=data.get('grandTotal');
  //     salesList.add({
  //       'no': data.get('invoiceNo'),
  //       'amount':data.get('grandTotal'),
  //     }
  //     );
  //   }
  //
  //   setState(() {
  //     fullProducts.sort((a, b) => a.compareTo(b));
  //
  //
  //   });
  // }
  // getProducts()async{
  //   QuerySnapshot snap =await FirebaseFirestore.instance.collection('product').get();
  //   for(DocumentSnapshot doc in snap.docs){
  //     // productImgByName[doc.get('name')]=doc.get('imageUrl');
  //     productPriceByName[doc.get('name')]=doc.get('price');
  //   }
  //
  //   if(mounted){
  //     setState(() {
  //
  //     });
  //   }
  // }


  List a=[];
  List prdList=[];
  getDetailes(){
    for (var data in widget.salesData.docs){

      List items=data['billItems'];
      for(var product in items){
        print(product);
         double price=product["price"];
        String name=product['category']??" ";
        int? quantity=int.tryParse(product['qty'].toString());

        if(!prdList.contains(name)){
          prdList.add(name);
          a.add({
            "name":name,
            "qty":quantity,
            "price":price*quantity!
          });

        }else{
          for(var pdt in a){
            if(pdt["name"]==name){
              pdt['qty']+=quantity;
              pdt['price']+=price*quantity!;

            }
          }
        }

      }

    }

    print('prdLIsttttttttttttttttttttttttttt');
    print(prdList);

    print('');
    print(a);
    print('');
    setState(() {

    });

  }



  @override
  void initState(){
    super.initState();
    // getSales();
    // getProducts();
    getDetailes();
    print(widget.From);
    print(widget.To);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Category Report"),
        centerTitle: true,
        backgroundColor: Color(0xffBF0F1B),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: IconButton(onPressed: () async {

              try {
                final invoice =
                CategoryReportData(
                  categoryWiseData: a,
                  From:widget.From,
                  To:widget.To,
                );

                final pdfFile =
                await CategoryPdfPage.generate(invoice);
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
            child: ListView.builder(
                itemCount: a.length,
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (buildContext,int index){


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
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  // mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      a[index]["name"],
                                      style: FlutterFlowTheme.subtitle1.override(
                                        fontFamily: 'Lexend Deca',
                                        color: Color(0xFF090F13),
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    // Padding(
                                    //   padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                                    //   child: Text(
                                    //     'SAR : '+a[index]["price"].toString(),
                                    //     style: FlutterFlowTheme.bodyText2.override(
                                    //       fontFamily: 'Lexend Deca',
                                    //       color: Color(0xFF57636C),
                                    //       fontSize: 13,
                                    //       fontWeight: FontWeight.bold,
                                    //     ),
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width*0.3,
                              child: Center(
                                child: Text(
                                  'x ${a[index]['qty'].toString()}',
                                  style: FlutterFlowTheme.bodyText2.override(
                                    fontFamily: 'Lexend Deca',
                                    color: Color(0xFF57636C),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width*0.3,
                              child: Center(
                                child: Text(
                                  // ' ${(a[index]["qty"]*a[index]["price"]).toString()}',
                                  ' ${(a[index]["price"]).toString()}',
                                  style: FlutterFlowTheme.bodyText2.override(
                                    fontFamily: 'Lexend Deca',
                                    color: Color(0xFF57636C),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            // SizedBox(width: 50,),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}