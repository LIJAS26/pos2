//@dart=2.9
import 'package:awafi_pos/Branches/branches.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:awafi_pos/backend/backend.dart';
import 'package:awafi_pos/product_card.dart';
import 'flutter_flow/flutter_flow_theme.dart';
import 'main.dart';

class AddOn extends StatefulWidget {
  final String product;
  final int index;
  const AddOn({Key key, this.product, this.index}) : super(key: key);

  @override
  _AddOnState createState() => _AddOnState();
}

class _AddOnState extends State<AddOn> {
  int selectedIndex;
  List selectedAddOn;
  List selectedAddOnArabic;
  double addOnPrice=0;
  List addOnList=[];

  getaddOns(){
     FirebaseFirestore.instance
         .collection("addOn")
         .get()
         .then((value){

           for(var item in value.docs){
             addOnList.add(item);
           }

           setState(() {

           });
     });

  }

  @override
  void initState() {
    getaddOns();
    selectedAddOn=selectedItems['addOns'];
    selectedAddOnArabic=selectedItems['addOnArabic'];
    addOnPrice=double.tryParse(selectedItems['addOnPrice'].toString());
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Container(
        height: 550,
        width: MediaQuery.of(context).size.width*0.5,

        child:widget.product==null?const Center(child: Text('Choose A product first'),):Column(
            children: [
              const SizedBox(height: 10,),
              const Text("SELECT ADD ON",style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),),
              const SizedBox(height: 10,),

              // Container(
              //   width: MediaQuery.of(context).size.width*0.4,
              //   height: 500,
              //   child:
              //   !addOn.containsKey(currentProduct)||addOn[currentProduct].length==0
              //       ?Center(child: Text('No Add ons Found'),)
              //       : GridView.builder(
              //     shrinkWrap: true,
              //     padding: EdgeInsets.zero,
              //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              //       crossAxisCount: 4,
              //       crossAxisSpacing: 10,
              //       mainAxisSpacing: 10,
              //       childAspectRatio: 1,
              //     ),
              //     scrollDirection: Axis.vertical,
              //     itemCount: addOn[currentProduct].length,
              //     itemBuilder: (context, int index) {
              //       bool added=false;
              //
              //       return InkWell(
              //         onTap: () async{
              //           print(selectedTable);
              //           print(selectedItems);
              //           print("*****************");
              //           await FirebaseFirestore.instance
              //           .collection('tables')
              //           .doc(currentBranchId)
              //               .collection('tables')
              //               .doc(selectedTable)
              //               .update({
              //             'items' :FieldValue.arrayRemove([selectedItems])
              //               });
              //
              //           added=true;
              //           selectedIndex=index;
              //         if(selectedAddOn.contains(addOn[currentProduct][index]['addOn'])&&
              //             selectedAddOnArabic.contains(addOn[currentProduct][index]['addOnArabic'])){
              //           print("IF   IF");
              //           selectedAddOn.remove(addOn[currentProduct][index]['addOn']);
              //           selectedAddOnArabic.remove(addOn[currentProduct][index]['addOnArabic']);
              //           addOnPrice-=double.tryParse(addOn[currentProduct][index]['price'].toString());
              //         }
              //         else{
              //           print("ELSE");
              //           selectedAddOn.add(addOn[currentProduct][index]['addOn']);
              //           selectedAddOnArabic.add(addOn[currentProduct][index]['addOnArabic']);
              //           addOnPrice+=double.tryParse(addOn[currentProduct][index]['price'].toString());
              //         }
              //
              //
              //         selectedItems['addOns']=selectedAddOn;
              //         selectedItems['addOnArabic']=selectedAddOnArabic;
              //         selectedItems['addOnPrice']=addOnPrice;
              //
              //           FirebaseFirestore.instance
              //               .collection('tables')
              //               .doc(currentBranchId)
              //               .collection('tables')
              //               .doc(selectedTable)
              //               .update({
              //                   'items' :FieldValue.arrayUnion([selectedItems])
              //               });
              //
              //       setState(() {
              //
              //       });
              //       // Navigator.pop(context);
              //
              //         },
              //
              //         child: Container(
              //           width: 100,
              //           height: 100,
              //           decoration: BoxDecoration(
              //             border: Border.all(width: 3,
              //               color: selectedAddOn.contains(addOn[currentProduct][index]['addOn'])
              //                   ? Colors.blue
              //                   : Colors.white30,
              //             ),
              //             color: const Color(0xFFEEEEEE),
              //             borderRadius: BorderRadius.circular(15),
              //           ),
              //           child: Column(
              //             mainAxisSize: MainAxisSize.max,
              //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //             children: [
              //               Expanded(
              //                 child: ClipRRect(
              //                   borderRadius: BorderRadius.circular(15),
              //                   child: CachedNetworkImage(
              //                     imageUrl: addOn[currentProduct][index]['imageUrl'],
              //                     width: 80,
              //                     height: 80,
              //                     fit: BoxFit.cover,
              //                   ),
              //                 ),
              //               ),
              //               Text(
              //                 addOn[currentProduct][index]['addOn'],
              //                 style: FlutterFlowTheme.bodyText1,
              //               ),
              //               Text(
              //                 'SR ${addOn[currentProduct][index]['price']}',
              //                 style: FlutterFlowTheme.bodyText1,
              //               )
              //             ],
              //           ),
              //         ),
              //       );
              //     },
              //   ),
              // ),


             Container(
               width: MediaQuery.of(context).size.width*0.4,
                  height: 500,
                 child:GridView.builder(
                       shrinkWrap: true,
                       padding: EdgeInsets.zero,
                       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                         crossAxisCount: 4,
                         crossAxisSpacing: 10,
                         mainAxisSpacing: 10,
                         childAspectRatio: 1,
                       ),
                       scrollDirection: Axis.vertical,
                       itemCount: addOnList.length,
                       itemBuilder: (context, int index) {
                         bool added=false;

                         return InkWell(
                           onTap: () async{
                             print(widget.product);
                             print(addOn[widget.product]);
                             print(selectedTable);
                             print(selectedItems);
                             print(selectedAddOn);
                             print("*****************");

                             if( selectedAddOn.contains(addOnList[index]['addOn'])){
                               DocumentSnapshot doc=  await FirebaseFirestore.instance
                                   .collection('tables')
                                   .doc(currentBranchId)
                                   .collection('tables')
                                   .doc(selectedTable).get();
                               List items=doc.get('items');
                               Map test=items[widget.index];
                               items.removeAt(widget.index);

                               selectedIndex=index;
                               selectedAddOn.remove(addOnList[index]['addOn']);
                               selectedAddOnArabic.remove(addOnList[index]['addOnArabic']);
                               addOnPrice-=double.tryParse(addOnList[index]['price'].toString());
                               test['addOns']=selectedAddOn;
                               test['addOnArabic']=selectedAddOnArabic;
                               test['addOnPrice']=addOnPrice;
                               items.insert(widget.index, test);
                               FirebaseFirestore.instance
                                   .collection('tables')
                                   .doc(currentBranchId)
                                   .collection('tables')
                                   .doc(selectedTable)
                                   .update({
                                 'items' :items
                               });

                               setState(() {

                               });
                             }else{
                               print("1234");

                               DocumentSnapshot doc=  await FirebaseFirestore.instance
                                   .collection('tables')
                                   .doc(currentBranchId)
                                   .collection('tables')
                                   .doc(selectedTable).get();
                               List items=doc.get('items');
                               Map test=items[widget.index];
                               // test['pdtname']='${test['pdtname']}-${addOnList[index]['addOn']}';
                               test['pdtname']='${test['pdtname']}';
                               print('trgrggreferferfr');
                               items.removeAt(widget.index);



                               selectedIndex=index;
                               selectedAddOn.add(addOnList[index]['addOn']);
                               selectedAddOnArabic.add(addOnList[index]['addOnArabic']);
                               addOnPrice+=double.tryParse(addOnList[index]['price'].toString());
                               test['addOns']=selectedAddOn;
                               test['addOnArabic']=selectedAddOnArabic;
                               test['addOnPrice']=addOnPrice;
                               items.insert(widget.index, test);
                               FirebaseFirestore.instance
                                   .collection('tables')
                                   .doc(currentBranchId)
                                   .collection('tables')
                                   .doc(selectedTable)
                                   .update({
                                 'items' :items
                               });

                               setState(() {

                               });

                             }

                           },

                           child: Container(
                             width: 100,
                             height: 100,
                             decoration: BoxDecoration(
                               border: Border.all(width: 3,
                                 color: selectedAddOn.contains(addOnList[index]['addOn'])
                                     ? Colors.blue
                                     : Colors.white30,
                               ),
                               color: const Color(0xFFEEEEEE),
                               borderRadius: BorderRadius.circular(15),
                             ),
                             child: Column(
                               mainAxisSize: MainAxisSize.max,
                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                               children: [
                                 Expanded(
                                   child: ClipRRect(
                                     borderRadius: BorderRadius.circular(15),
                                     child: CachedNetworkImage(
                                       imageUrl: addOnList[index]['imageUrl'],
                                       width: 80,
                                       height: 80,
                                       fit: BoxFit.cover,
                                     ),
                                   ),
                                 ),
                                 Text(
                                   addOnList[index]['addOn'],
                                   style: FlutterFlowTheme.bodyText1,
                                 ),
                                 Text(
                                   'SR ${addOnList[index]['price']}',
                                   style: FlutterFlowTheme.bodyText1,
                                 )
                               ],
                             ),
                           ),
                         );
                       },
                     ),
             )

            ]
        ),
      ),

      actions: <Widget>[
        TextButton(
          onPressed: () {

            Navigator.pop(context);
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
