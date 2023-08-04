//@dart=2.9
import 'dart:developer';

import 'package:awafi_pos/Branches/branches.dart';
import 'package:awafi_pos/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../add_on.dart';
import '../product_card.dart';

class billWidget extends StatefulWidget {
  final int index;
  final String name;
  final String arabicName;
  final List addOns;
  final List addOnsArabic;
  final List items;
  final double price;
  final int progrss;
  final double addOnPrice;
  final String category;
  final List ingredients;
  final List variants;
  const   billWidget({Key key, this.index, this.name, this.arabicName, this.addOns, this.addOnsArabic, this.items, this.price, this.progrss, this.addOnPrice, this.category, this.ingredients, this.variants,   }) : super(key: key);

  @override
  _billWidgetState createState() => _billWidgetState();
}

class _billWidgetState extends State<billWidget> {

  int progress = 0;

  @override
  Widget build(BuildContext context) {
    progress = widget.progrss;
    log(progress.toString());
    print('progress');
    log('progress');

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Center(child: Text((widget.index+1).toString(),style: const TextStyle(
                  fontWeight: FontWeight.bold
              ),)),
            ),
            Expanded(
              flex: 6,
              child: Column(
                children: [
                  InkWell(
                    onTap: (){
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            print('indexxxxxxxxxxxxxxxx');
                            print(widget.index);

                            return StatefulBuilder(
                                builder: (context,setState)
                                {
                                  return  AddOn(
                                    product:widget.name,
                                    index: widget.index,

                                  );
                                }
                            );
                          }
                      );
                      // print("derfghjkml");
                      // currentProduct=widget.name;
                      //
                      // selectedItems = widget.items[widget.index];
                      // print(selectedItems);
                    },
                    child: Center(child: Text(widget.name,style: const TextStyle(
                        fontWeight: FontWeight.bold
                    ),)),
                  ),
                   Text(widget.addOns!=null ? widget.addOns.toString().split('[')[1].split(']')[0] : ''),
                ],
              ),
            ),
            Expanded(
              flex: 2,

              child: Center(
                  child: Text((widget.price + widget.addOnPrice).toString(),
                    style: const TextStyle(
                  fontWeight: FontWeight.bold
              ),)),
            ),
            Expanded(
                flex: 3,
                child: Container(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      IconButton(
                        onPressed: () {
                          if(progress!=0){
                             // List incredients=[];
                            int i=0;
                            for(int k=0;k<items.length;k++){
                              if(items[k]['pdtname']==widget.name&&items[k]['price']==widget.price && items[k]['addOns'].toString()==widget.addOns.toString()){
                                i=k;
                                // for( var i in incredients){
                                //   i["quantity"]=i["quantity"]+i["SingleQty"];
                                // }
                                break;
                              }
                            }
                            items.removeAt(i);

                            if (progress != 1) {
                              items.insert(i,{
                                'pdtname': widget.name,
                                'arabicName': widget.arabicName,
                                'price': widget.price,
                                'qty': progress - 1,
                                'addOns': widget.addOns,
                                'addOnArabic':widget.addOnsArabic,
                                'addOnPrice': widget.addOnPrice,
                                "category":widget.category,
                                "variants":widget.variants,
                                'ingredients':widget.ingredients

                              });
                            }



                            FirebaseFirestore.instance.collection(
                                'tables')
                                .doc(currentBranchId)
                                .collection('tables')
                                .doc(selectedTable).update(
                                {'items': items
                                });

                            setState(() {
                              progress = progress - 1;


                            });
                          }
                        },
                        icon:  const FaIcon(
                          FontAwesomeIcons.minusCircle,
                          color: Colors.black,
                          size: 20,
                        ),
                        iconSize: 20,
                      ),
                      Text(progress.toString()),
                      IconButton(
                        onPressed: () {

                          int i=0;
                          List incredients=[];
                          // List varIncredient=[];
                          for(int k=0;k<items.length;k++){
                            if(items[k]['pdtname']==widget.name&&items[k]['price']==widget.price && items[k]['addOns'].toString()==widget.addOns.toString()){
                              i=k;
                               incredients=items[k]["ingredients"];
                              // for( var i in incredients){
                              //   i["quantity"]=i["quantity"]+i["SingleQty"];
                              // }
                              // varIncredient=items[k]['variants']['ingredients'];
                              // for( var j in varIncredient){
                              //   j["quantity"]=j["quantity"]+j["SingleQty"];
                              // }
                              break;
                            }
                          }
                          items.removeAt(i);
                            items.insert(i,{
                              'pdtname':widget.name,
                              'arabicName':widget.arabicName,
                              'price':widget.price,
                              'qty':progress+1,
                              'addOns':widget.addOns,
                              'addOnArabic':widget.addOnsArabic,
                              'addOnPrice':widget.addOnPrice,
                              "category":widget.category,
                              'ingredients':incredients,
                              "variants":widget.variants

                            }
                            );


                          FirebaseFirestore.instance.collection('tables')
                              .doc(currentBranchId)
                              .collection('tables')
                              .doc(selectedTable).update(
                              {
                                'items' :items
                              });

                          setState(() {
                            progress = progress + 1;

                          });
                        },
                        icon: const FaIcon(
                          FontAwesomeIcons.plusCircle,
                          color: Colors.black,
                          size: 20,
                        ),
                        iconSize: 20,
                      )
                    ],
                  ),
                )
            ),
            const SizedBox(width: 20,),
            Expanded(
              flex: 1,
              child:  InkWell(
                onTap: (){

                  FirebaseFirestore.instance.collection('tables')
                      .doc(currentBranchId)
                      .collection('tables')
                      .doc(selectedTable).update(
                      {
                        'items': FieldValue.arrayRemove([widget.items[widget.index]])
                      });
                },
                child: const Icon(Icons.delete,
                  color:Colors.teal,),
              ),
            ),
          ],
        ),
        const Divider(),
      ],
    );
  }
}
