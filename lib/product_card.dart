//@dart=2.9
import 'dart:developer';
import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:awafi_pos/flutter_flow/upload_media.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:awafi_pos/bill.dart';
import 'package:awafi_pos/services/shoppingBagService.dart';
import 'package:awafi_pos/services/userService.dart';
import 'Branches/branches.dart';
import 'backend/schema/new_products_record.dart';
import 'flutter_flow/flutter_flow_theme.dart';
import 'main.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';


int qty=0;
Map <String,dynamic>addOn={};
List newAddOn=[];
List newAddOnArabic=[];
double addOnPrice=0;
Map <String,dynamic>selectedItems={};
Map <String,dynamic>originalSelectedItems={};
String currentProduct;
class ProductCard extends StatefulWidget {
  final  String name;
  final  String category;
  final  String arabicName;
  final  String pid;
  final  double discountPrice;
  final  String imageUrl;
  final Function set;
  final List addOns;
  final List variants;
  final List ingredients;

  const ProductCard({this.name, this.set, this.discountPrice, this.imageUrl, this.pid, this.addOns, this.variants,this.arabicName, this.category, this.ingredients,});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<State> keyLoader = GlobalKey<State>();
  final UserService _userService = UserService();
  final ShoppingBagService _shoppingBagService = ShoppingBagService();
  int counter = 0;
  // Future<void> compressImage(File file) async {
  //   final result = await FlutterImageCompress.compressWithFile(
  //     widget.imageUrl,
  //     quality: 50,
  //   );
  //
  //   // The compressed image is now stored in the 'result' variable.
  //   // You can use it however you like, such as uploading it to a server.
  // }
  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      counter++;
    });
  }

  int totalReviews = 0;
  double avgRating = 0;
  int _itemCount = 1;
  bool userLiked;
  bool exist =false;
 NewProductsRecord product;
  Map<String, dynamic> currentItem;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    offCatLower();
    print("offCategoryLowercase--------------------------------------");
    print(offCategoryLowercase);
    // product=widget.gridViewProductsRecord;
if(counter==0){
  qty=counter;

}

  }
  bucketExistence() {
    String uid = currentUserModel.id;
    List bag = currentUserModel.bag;
    for (int i = 0; i < bag.length; i++) {
      Map<String, dynamic> item = bag[i];

      if (item['id'] == product.productId &&
          item['size'] == "" &&
          item['color'] == "" &&
          item['cut'] == "" &&
          item['unit'] == product.unit &&
          item['quantity'] == 1.00) {
        setState(() {
          exist = true;
          currentItem=item;

        })
        ;
        break;
      } else {
        setState(() {
          exist = false;
        });
      }
    }
  }
  List offCategoryLowercase=[];
  offCatLower(){
    for(var i in offerCategory){
      offCategoryLowercase.add(i.toLowerCase());
    }
  }



  Future getReviews() async {
    double totalRating = 0;
    try {

      double totRating = 0;

      int noRating = product.ones+product.twos+product.threes+product.fours+product.fives;
      totRating=(1.00*product.ones)+(2.00*product.twos)+(3.00*product.threes)+(4.00*product.fours)+(5.00*product.fives);


      setState(() {
        totalReviews = noRating;

        avgRating =noRating==0?0: (totRating / noRating);

      });
    } catch (exception) {
      print(exception.toString());
    }
  }


  set(){
    setState(() {

    });
  }



  @override
  Widget build(BuildContext context) {
    return
      GestureDetector(
      onTap: () async {
       if(widget.variants.length==0){

         // items=await   showDialog(
         //   context: context,
         //   builder: (BuildContext context) {
         //
         //     return StatefulBuilder(
         //       builder: (context,setState)
         //        {
         //          return AlertDialog(
         //            title: Container(
         //              padding: const EdgeInsets.only(left: 20,right: 20),
         //              height: 100,
         //              child:  Column(
         //                children: [
         //                  const SizedBox(height: 10,),
         //                  const Text("SELECT QUANTITY",style: TextStyle(
         //                      fontSize: 12
         //                  ),),
         //                  const SizedBox(height: 20,),
         //                  Expanded(
         //                    child: Container(
         //                      padding: const EdgeInsets.all(3),
         //
         //                      decoration: BoxDecoration(
         //                        borderRadius: BorderRadius.circular(5),
         //                        color: Colors.black,),
         //                      child: Row(
         //                        children: [
         //                          Expanded(
         //                            child: InkWell(
         //                                onTap: () {
         //                                  if(_itemCount>1) {
         //                                    setState(() =>
         //                                    _itemCount--);
         //                                  }
         //                                  },
         //                                child: const SizedBox (
         //                                  width: 30,
         //                                  child: Icon(
         //                                    Icons.remove,
         //                                    color: Colors.white,
         //                                    size: 16,
         //                                  ),
         //                                )),
         //                          ),
         //                          Container(
         //                            width: 60,
         //                            decoration: BoxDecoration(
         //                                borderRadius: BorderRadius.circular(3),
         //                                color: Colors.white),
         //                            child: Center(
         //                              child: Text(
         //                                _itemCount.toString(),
         //                                style: const TextStyle(color: Colors.black, fontSize: 16),
         //                              ),
         //                            ),
         //                          ),
         //                          Expanded(
         //                            child: InkWell(
         //                                onTap: () {
         //                                  setState(()=>_itemCount++);
         //                                },
         //                                child: const SizedBox(
         //                                  width: 30,
         //                                  child: Icon(
         //                                    Icons.add,
         //                                    color: Colors.white,
         //                                    size: 16,
         //                                  ),
         //                                )),
         //                          ),
         //                        ],
         //                      ),
         //                    ),
         //                  ),
         //                ],
         //              ),
         //            ),
         //
         //            actions: <Widget>[
         //              TextButton(
         //                onPressed: () {
         //
         //                  Navigator.pop(context);
         //                  },
         //                child: const Text('Cancel'),
         //              ),
         //              TextButton(
         //                onPressed: ()  async {
         //
         //
         //
         //
         //             items={
         //                    'pdtname':widget.name,
         //                    'price':widget.discountPrice,
         //                    'qty':_itemCount,
         //               'orderTime' :DateTime.now(),
         //
         //                  };
         //
         //
         //
         //
         //                FirebaseFirestore.instance.collection('tables').doc(selectedTable).update(
         //
         //                    {
         //                     'items':FieldValue.arrayUnion([items])
         //
         //                   });
         //
         //
         //                  Navigator.pop(context, items);},
         //
         //                child: const Text('OK'),
         //              ),
         //            ],
         //          );
         //        }
         //      );
         //   }
         // );
         // _incrementCounter();

         bool notInCart =true;
         currentProduct=widget.name;
         for(Map<String,dynamic> doc in itemList){
           Map item =doc;
           int index=itemList.indexOf(doc);


           // if(item['pdtname']==widget.name && item['price']==widget.discountPrice
           //     && item['addOns'].toString()==widget.addOns.toString()){
           if(item['pdtname']==widget.name &&
               item['price']== (((offCategoryLowercase.contains(widget.category.toLowerCase()))&&offer)
                   ?widget.discountPrice*(1-(offerValue/100)):widget.discountPrice)
               && item['addOns'].toString()==widget.addOns.toString()){
             print('saaaaaaaaaaaaaaaaa');
             print(item);
             print('111111111');
             notInCart=false;
//ne
             await itemList.removeAt(index);
                   item['qty']=int.tryParse(item['qty'].toString())+1;
             print("item['ingredients']__________________________");
                   print(item["ingredients"]);
                  await itemList.insert(index, item);
                 await  FirebaseFirestore.instance.collection('tables')
                       .doc(currentBranchId)
                       .collection('tables')
                       .doc(selectedTable).update(
                       {
                         'items':itemList
                       });

                 setState(() {

                 });


           }

         }
         if(notInCart){
           print('22222222');
           FirebaseFirestore.instance.collection('tables')
               .doc(currentBranchId)
               .collection('tables')
               .doc(selectedTable).update(

               {
                 'items':FieldValue.arrayUnion([{
                   'pdtname':widget.name,
                   'arabicName':widget.arabicName,
                   'price':((offCategoryLowercase.contains(widget.category.toLowerCase()))&&offer)?widget.discountPrice*(1-(offerValue/100)):widget.discountPrice,
                   'discount':((offCategoryLowercase.contains(widget.category.toLowerCase()))&&offer)?widget.discountPrice*(offerValue/100):0,
                   'qty':1,
                   'addOns':[],
                   'addOnArabic':[],
                   'addOnPrice':0.0,
                   'variants':widget.variants,
                   'category':widget.category,
                   'ingredients':widget.ingredients
                 }])

               });
           addOn[widget.name]=widget.addOns;
         }

       }
       else{
         //ALERT BOX
         showDialog(
           context: context,
           builder: (ctx){
             return Box(
                 varList:widget.variants,
                 discountPrice:widget.discountPrice,
                 name:widget.name,
                 arabicName:widget.arabicName,
                 addOns:widget.addOns,
                 category: widget.category,
                 ingredients:widget.ingredients
             );
           }
         );
       }
         },
        child:  Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          color: FlutterFlowTheme.tertiaryColor,
          elevation: 10,
          child: Container(
            width: MediaQuery.of(context).size.width * 1,
            decoration:
                const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(10),
                topLeft: Radius.circular(10),
                topRight: Radius.circular(0),
              ),
              color: FlutterFlowTheme.tertiaryColor,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    // color: Colors.yellow,
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)
                      ),
                      child: display_image
                          ?CachedNetworkImage (
                        errorWidget: (context, url, error) => Icon(Icons.error), // Placeholder for failed image loading
                        cacheKey: widget.imageUrl, // Set a custom cache key
                        memCacheWidth: 200, // Set a custom width for memory cache
                        memCacheHeight: 100, // Set a custom height for memory cache
                        httpHeaders: {}, // Set custom headers for network requests
                        useOldImageOnUrlChange: true, // Use old image when the URL changes
                        imageUrl: widget.imageUrl,
                        fit: BoxFit.contain,
                        width: 300,
                      )
                      :Container(
                        padding: const EdgeInsets.only(left: 5,right:5,top: 5),
                        child: Container(
                          color: Colors.blueGrey.shade100,
                        ),
                      ),
                    ),
                  ),
                ),
                // Row(
                //   children: [
                //     RatingBar(
                //       ignoreGestures: true,
                //       itemSize: 10,
                //       glow: true,
                //       allowHalfRating: true,
                //       initialRating: avgRating,
                //       itemPadding: EdgeInsets.symmetric(
                //           horizontal: 0.0),
                //       ratingWidget: RatingWidget(
                //         empty: Icon(Icons.star_border,
                //             color: Colors.grey,
                //             size: 25.w),
                //         full: Icon(
                //           Icons.star,
                //           color: Colors.amber,
                //           size: 25.w,
                //         ),
                //         half: Icon(
                //           Icons.star_half,
                //           color: Colors.amber,
                //           size: 25.w,
                //         ),
                //       ),
                //     ),
                //     Text(" ($totalReviews) ",style: TextStyle(color: Colors.grey.shade500,fontWeight: FontWeight.bold,fontSize: 18.w),)
                //   ],
                // ),
                AutoSizeText(
                  widget.name,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // Text(
                //   widget.gridViewProductsRecord.shopName,
                //   style: TextStyle(
                //     color:Colors.red,
                //     fontWeight: FontWeight.bold,
                //     fontSize: 26.w,
                //   ),
                // ),
                Text(widget.discountPrice
                            .toString(),
                    style: const TextStyle(
                        color: Color(0xFF33CC33),
                        fontWeight: FontWeight.bold,
                        fontSize: 20)),

                const SizedBox(
                    height: 5
                ),

              ],
            ),
          ),
        ),);
  }



  void showInSnackBar(String msg, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: color,
        content: new Text(msg),
        action: SnackBarAction(
          label: 'Close',
          textColor: Colors.white,
          onPressed: () {
            if (mounted) {
              ScaffoldMessenger.of(context).clearSnackBars();
            }
          },
        ),
      ),
    );
  }

  addToShoppingBag() async {
    String msg = await _shoppingBagService.add(
        widget.pid,
        widget.name,
        "",
        "",
        "",
        widget.discountPrice.toString(),
        1.00,
        double.tryParse(widget.discountPrice.toString()));
    bucketExistence();

    widget.set();
    setState(() {

    });
  }
}



class Box extends StatefulWidget {
  List varList;
  String name;
  double discountPrice;
  String arabicName;
  String category;
  List addOns;
  List ingredients;
   Box({Key key,this.varList,this.name,this.discountPrice,this.arabicName,this.addOns,this.category,this.ingredients}) : super(key: key);

  @override
  _BoxState createState() => _BoxState();
}

class _BoxState extends State<Box> {

  int selectedIndex;
  double selectedvariantPrice=0;
  String selectedvariantName='';
  String selectedvariantArName='';
  List selectedVarient=[];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AlertDialog(
        title: const Text("Choose Variant"),
        content:  Container(
          width: MediaQuery.of(context).size.width*0.2,
          height: MediaQuery.of(context).size.height*0.2,
          child: ListView.builder(
            padding: EdgeInsets.zero,
            scrollDirection: Axis.vertical,
            itemCount: widget.varList.length,
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, int index) {
              return Padding(
                padding:
                const EdgeInsetsDirectional.fromSTEB(
                    10, 0, 10, 10),
                child: InkWell(
                  onTap: () async {
                    log("selected----------------------------------------------");
                    log(widget.varList[index]['variant']);

                    setState(() {
                      selectedIndex=index;
                      selectedvariantPrice=double.tryParse(widget.varList[index]['price']);
                      selectedvariantName=widget.varList[index]['variant'];
                      selectedvariantArName=widget.varList[index]['variantArabic'];
                      print(selectedvariantPrice);


                      List data=[];
                      data.add(widget.varList[selectedIndex]);
                      selectedVarient=data;
                      log(selectedVarient.toString()+"                     kkkkkkkk");

                    });
// DocumentSnapshot ingName =
//     await FirebaseFirestore
//     .instance
//     .collection('invoiceNo')
//     .doc(currentBranchId)
//     .get();
// if(selectedvariantName==ingName.reference)
                  },
                  child: Container(
                    color: selectedIndex!=index?Colors.white:Colors.blueGrey.shade200,
                    width: MediaQuery.of(context).size.width*0.15,
                    height: 30,
                    // child: RadioListTile(
                    child:  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(' ${widget.varList[index]['variant']}',
                          style: FlutterFlowTheme.bodyText1.override(
                            fontFamily: 'Poppins',
                          ),
                        ),
                        SizedBox(width: 5,),
                        Text(
                          ' ${widget.varList[index]['price']}',
                          style: FlutterFlowTheme
                              .bodyText1
                              .override(
                            fontFamily: 'Poppins',
                          ),
                        ),

                      ],
                    ),

                  ),
                ),
              );
            },
          ),
        ),

        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Container(
              padding: const EdgeInsets.all(14),
              child:  Text("Cancel",style:TextStyle(
                  fontSize: 17,
                  color: Colors.red
              )),
            ),
          ),
          TextButton(
            onPressed: () {
              log("DONE      *************************************");
              log(selectedVarient.toString()+'-----------------');
           if(selectedIndex!=null){
             print(selectedvariantPrice);
             bool notInCart =true;
             currentProduct=widget.name;
             for(Map<String,dynamic> item in itemList){
               if(item['pdtname']==widget.name&&item['price']==widget.discountPrice){
                 print(selectedvariantPrice);
                 print('TRUE TRUE TRUE TRUE');
                 notInCart=false;
                 FirebaseFirestore.instance.collection('tables')
                     .doc(currentBranchId)
                     .collection('tables')
                     .doc(selectedTable).update(
                     {
                       'items':FieldValue.arrayRemove([{
                         'pdtname':'${widget.name} $selectedvariantName',
                         'arabicName':'${widget.arabicName} $selectedvariantArName',
                         'price':selectedvariantPrice,
                         'qty':item['qty'],
                         'addOns':[],
                         'addOnArabic':[],
                         'addOnPrice':0.0,
                         'category':widget.category,
                         'ingredients':widget.ingredients,
                         'variants':selectedVarient,
                       }])
                     });
                 FirebaseFirestore.instance.collection('tables')
                     .doc(currentBranchId)
                     .collection('tables')
                     .doc(selectedTable).update(
                     {
                       'items':FieldValue.arrayUnion([{
                         'pdtname':'${widget.name} $selectedvariantName',
                         'arabicName':'${widget.arabicName} $selectedvariantArName',
                         'price':selectedvariantPrice,
                         'qty':item['qty']+1,
                         'addOns':[],
                         'addOnArabic':[],
                         'addOnPrice':0.0,
                         'variants':selectedVarient,
                         'category':widget.category,
                         'ingredients':widget.ingredients




                       }])

                     });
               }

             }
             if(notInCart){
               FirebaseFirestore.instance.collection('tables')
                   .doc(currentBranchId)
                   .collection('tables')
                   .doc(selectedTable).update(

                   {
                     'items':FieldValue.arrayUnion([{
                       'pdtname':'${widget.name} $selectedvariantName',
                       'arabicName':'${widget.arabicName} $selectedvariantArName',
                       'price':selectedvariantPrice,
                       'qty':1,
                       'addOns':[],
                       'addOnArabic':[],
                       'addOnPrice':0.0,
                       'variants':selectedVarient,
                       'category':widget.category,
                       'ingredients':widget.ingredients
                     }])

                   });
               addOn[widget.name]=widget.addOns;
             }

             Navigator.of(context).pop();

           }
           showUploadMessage(context, 'please select variant');
            },
            child: Container(
              padding: const EdgeInsets.all(14),
              child:  Text("Done",style:TextStyle(
                  fontSize: 17,
                  color: Colors.blue
              )),
            ),
          ),
        ],
      ),
    );
  }
}
