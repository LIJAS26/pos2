//@dart=2.9
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:awafi_pos/product_card.dart';
import 'BillWidget/bill_wdget.dart';
import 'backend/backend.dart';
import 'flutter_flow/flutter_flow_theme.dart';
import 'main.dart';
import 'modals/bag.dart';

List<Map<String,dynamic>> itemList=[];

class BillWidget extends StatefulWidget {
final  List items;
  const BillWidget({Key key, this.items}) : super(key: key);

  @override
  _BillWidgetState createState() => _BillWidgetState();
}

class _BillWidgetState extends State<BillWidget> {
  TextEditingController textController;
  List items=[];


  final scaffoldKey = GlobalKey<ScaffoldState>();




  @override
  initState(){

    super.initState();
    items=[];

    textController=TextEditingController();

  }

  @override
  Widget build(BuildContext context) {
   
// if(items.isEmpty){
  items=widget.items;

//
// }
    return Container(
      // color: Colors.green,
      height: MediaQuery.of(context).size.height*.46,
      padding: const EdgeInsets.only(left: 5,right: 5),
      child:  ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: items.length ?? 0,
          itemBuilder: (context,index){
            selectedItems=items[index];
            String item = items[index]['pdtname'];
            String arabicName = items[index]['arabicName'];
           List  addOns = items[index]['addOns'];
           List  addOnsArabic = items[index]['addOnArabic'];
            double price=double.tryParse(items[index]['price'].toString());
            String catogery=items[index]['category'];
            int progrss = items[index]['qty'];
            double  addOnPrice=double.tryParse(items[index]['addOnPrice'].toString());
            List ing=items[index]["ingredients"];
             List variants=items[index]["variants"];

            return  billWidget(
              index: index,
              name: item,
              items: widget.items,
              arabicName: arabicName,
              addOns: addOns,
              addOnsArabic: addOnsArabic,
              price: price,
              progrss: progrss,
              addOnPrice: addOnPrice,
              category:catogery,
                ingredients:ing,
                variants:variants
            );
          }
      ),
    );
  }

  Widget deleteCard() {
    return Container(
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(right: 20),
      decoration: const BoxDecoration(
          color: Colors.grey
      ),
      child:  Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: const [
          Text("Remove from Bag"),
          Icon(Icons.delete,
            color:Colors.teal,),
        ],
      ),
    );
  }
}
