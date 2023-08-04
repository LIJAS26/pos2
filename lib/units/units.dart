//@dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:awafi_pos/flutter_flow/upload_media.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UnitWidget extends StatefulWidget {
  UnitWidget({Key key}) : super(key: key);

  @override
  _UnitWidgetState createState() => _UnitWidgetState();
}

class _UnitWidgetState extends State<UnitWidget> {
  TextEditingController textController1;
  TextEditingController conversionController;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<Map<String,dynamic>> unitList = [];
  List<DropdownMenuItem> units = [];
  String  basicUnit='';

  @override
  void initState() {
    super.initState();
    textController1 = TextEditingController();
    conversionController =TextEditingController();
    getUnits();
  }

  Future getUnits() async {
    DocumentSnapshot data1 =
    await FirebaseFirestore.instance.collection("units").doc("units").get();
    List<Map<String,dynamic>> temp = [];
    List<DropdownMenuItem> tempUnit =[];
    for (var unit in data1.get('unitlist')) {
      temp.add(unit);
      tempUnit.add(DropdownMenuItem(
        child: Text(unit['name']),
        value: unit['name'],
      ));
    }
    if (mounted) {
      setState(() {
        unitList = temp;
        units=tempUnit;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.primaryColor,
        automaticallyImplyLeading: true,
        title: Text(
          'Units',
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
                tabs: [
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
                                          labelText: 'Unit ',
                                          labelStyle: FlutterFlowTheme.bodyText2
                                              .override(
                                            fontFamily: 'Montserrat',
                                            color: Color(0xFF8B97A2),
                                            fontWeight: FontWeight.w500,
                                          ),
                                          hintText: 'Enter your Unit name',
                                          hintStyle: FlutterFlowTheme.bodyText2
                                              .override(
                                            fontFamily: 'Montserrat',
                                            color: Color(0xFF8B97A2),
                                            fontWeight: FontWeight.w500,
                                          ),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.transparent,
                                              width: 1,
                                            ),
                                            borderRadius:
                                            const BorderRadius.only(
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
                                            const BorderRadius.only(
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
                          SearchableDropdown.single(
                            items: units,
                            value: basicUnit,
                            hint: "Select Base Unit",
                            searchHint: "Select Base Unit",
                            onChanged: (value) {
                              setState(() {
                                basicUnit = value;

                              });
                            },
                            isExpanded: true,
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
                                        controller: conversionController,
                                        obscureText: false,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          labelText: 'Conversion ',
                                          labelStyle: FlutterFlowTheme.bodyText2
                                              .override(
                                            fontFamily: 'Montserrat',
                                            color: Color(0xFF8B97A2),
                                            fontWeight: FontWeight.w500,
                                          ),
                                          hintText: 'Enter Conversion rate',
                                          hintStyle: FlutterFlowTheme.bodyText2
                                              .override(
                                            fontFamily: 'Montserrat',
                                            color: Color(0xFF8B97A2),
                                            fontWeight: FontWeight.w500,
                                          ),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.transparent,
                                              width: 1,
                                            ),
                                            borderRadius:
                                            const BorderRadius.only(
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
                                            const BorderRadius.only(
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
                            alignment: Alignment(0.95, 0),
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                              child: FFButtonWidget(
                                onPressed: () async {
                                  final unit = { "name": textController1.text,
                                    "basicunit" : basicUnit,
                                    "conversion" : double.tryParse(conversionController.text),
                                  };
                                  if (unit["name"] == "" || unit["name"] == null) {
                                    showUploadMessage(
                                        context, "please enter Unit name");
                                  } else {
                                    bool proceed = await alert(context,
                                        'You want to upload this size?');

                                    if (proceed) {
                                      await FirebaseFirestore.instance
                                          .collection('units')
                                          .doc('units')
                                          .update({
                                        'unitlist':
                                        FieldValue.arrayUnion([unit]),
                                      }).then((value) {
                                        showUploadMessage(context, "Unit Adding Success");
                                        unitList.add(unit);
                                        setState(() {
                                          textController1.text="";
                                          conversionController.text="";
                                        });
                                      });
                                    }
                                  }
                                },
                                text: 'Add Unit',
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
                                  borderSide: BorderSide(
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

                    // Customize what your widget looks like when it's loading.

                    ListView.builder(
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.vertical,
                      itemCount: unitList.length,
                      itemBuilder: (context, listViewIndex) {
                        final currentUnit = unitList[listViewIndex];
                        return ListTile(
                          title: Text(currentUnit['name']),
                          trailing: IconButton(
                            onPressed: () async {
                              bool proceed = await alert(
                                  context, 'You want to delete this unit?');

                              if (proceed) {
                                await FirebaseFirestore.instance
                                    .collection('units')
                                    .doc('units')
                                    .update({
                                  'unitlist':
                                  FieldValue.arrayRemove([currentUnit]),
                                }).then((value) {
                                  unitList.remove(currentUnit);
                                  setState(() {});
                                });
                              }
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Colors.black,
                              size: 30,
                            ),
                            iconSize: 30,
                          ),
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
