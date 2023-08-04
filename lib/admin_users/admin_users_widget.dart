//@dart=2.9
import 'package:awafi_pos/main.dart';

import '../backend/backend.dart';
import '../flutter_flow/flutter_flow_theme.dart';

import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';


class AdminUsersWidget extends StatefulWidget {
  AdminUsersWidget({Key key}) : super(key: key);

  @override
  _AdminUsersWidgetState createState() => _AdminUsersWidgetState();
}

class _AdminUsersWidgetState extends State<AdminUsersWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: default_color,
        automaticallyImplyLeading: true,
        title: Text(
          'Admin Users',
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
                  StreamBuilder<List<AdminUsersRecord>>(
                    stream: queryAdminUsersRecord(
                      singleRecord: true,
                    ),
                    builder: (context, snapshot) {
                      // Customize what your widget looks like when it's loading.
                      if (!snapshot.hasData) {
                        return Center(child: CircularProgressIndicator());
                      }
                      // List<AdminUsersRecord> tabAdminUsersRecordList =
                      //     snapshot.data;
                      // Customize what your widget looks like with no query results.
                      if (snapshot.data.isEmpty) {
                        return Container();
                        // For now, we'll just include some dummy data.
                        // tabAdminUsersRecordList =
                        //     createDummyAdminUsersRecord(count: 1);
                      }
                      // final tabAdminUsersRecord = tabAdminUsersRecordList.first;
                      return Tab(
                        text: 'Approved Users',
                      );
                    },
                  ),
                  const Tab(
                    text: 'Pending Users',
                  )
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    StreamBuilder<List<AdminUsersRecord>>(
                      stream: queryAdminUsersRecord(
                        queryBuilder: (adminUsersRecord) => adminUsersRecord
                            .where('verified', isEqualTo: true)
                            .orderBy('created_time', descending: true),
                      ),
                      builder: (context, snapshot) {

                        if (!snapshot.hasData) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        List<AdminUsersRecord> listViewAdminUsersRecordList =
                            snapshot.data;
                        // Customize what your widget looks like with no query results.
                        if (snapshot.data.isEmpty) {
                          return Container();
                        }
                        return ListView.builder(
                          padding: EdgeInsets.zero,
                          scrollDirection: Axis.vertical,
                          itemCount: listViewAdminUsersRecordList.length,
                          itemBuilder: (context, listViewIndex) {
                            final listViewAdminUsersRecord =
                            listViewAdminUsersRecordList[listViewIndex];
                            return Card(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              color: Color(0xFFF5F5F5),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    width: 70,
                                    height: 70,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: CachedNetworkImage(
                                      imageUrl:
                                      listViewAdminUsersRecord.photoUrl,
                                    ),
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(
                                        listViewAdminUsersRecord.displayName,
                                        style:
                                        FlutterFlowTheme.bodyText1.override(
                                          fontFamily: 'Poppins',
                                        ),
                                      ),
                                      Text(
                                        listViewAdminUsersRecord.email,
                                        style:
                                        FlutterFlowTheme.bodyText1.override(
                                          fontFamily: 'Poppins',
                                        ),
                                      ),
                                      Text(
                                        listViewAdminUsersRecord.mobileNumber,
                                        style:
                                        FlutterFlowTheme.bodyText1.override(
                                          fontFamily: 'Poppins',
                                        ),
                                      )
                                    ],
                                  ),
                                  IconButton(
                                    onPressed: () async {
                                      final verified = false;

                                      final adminUsersRecordData =
                                      createAdminUsersRecordData(
                                        verified: verified,
                                      );

                                      await listViewAdminUsersRecord.reference
                                          .update(adminUsersRecordData);
                                      await FirebaseFirestore.instance.collection('branches').doc("currentBranchId").update(
                                          {
                                            'admins' :FieldValue.arrayRemove([listViewAdminUsersRecord.email]),
                                          });
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.black,
                                      size: 30,
                                    ),
                                    iconSize: 30,
                                  )
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                    StreamBuilder<List<AdminUsersRecord>>(
                      stream: queryAdminUsersRecord(
                        queryBuilder: (adminUsersRecord) => adminUsersRecord
                            .where('verified', isNotEqualTo: true)
                            .orderBy('verified', descending: true)
                            .orderBy('created_time', descending: true),
                      ),
                      builder: (context, snapshot) {
                        // Customize what your widget looks like when it's loading.
                        if (!snapshot.hasData) {
                          // return Center(child: CircularProgressIndicator());
                          return Container();
                        }
                        List<AdminUsersRecord> listViewAdminUsersRecordList =
                            snapshot.data;
                        // Customize what your widget looks like with no query results.
                        if (snapshot.data.isEmpty) {
                          return Container();
                          // For now, we'll just include some dummy data.

                        }
                        return ListView.builder(
                          padding: EdgeInsets.zero,
                          scrollDirection: Axis.vertical,
                          itemCount: listViewAdminUsersRecordList.length,
                          itemBuilder: (context, listViewIndex) {
                            final listViewAdminUsersRecord =
                            listViewAdminUsersRecordList[listViewIndex];
                            return Card(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              color: Color(0xFFF5F5F5),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    width: 70,
                                    height: 70,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: CachedNetworkImage(
                                      imageUrl:
                                      listViewAdminUsersRecord.photoUrl,
                                    ),
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(
                                        listViewAdminUsersRecord.displayName,
                                        style:
                                        FlutterFlowTheme.bodyText1.override(
                                          fontFamily: 'Poppins',
                                        ),
                                      ),
                                      Text(
                                        listViewAdminUsersRecord.email,
                                        style:
                                        FlutterFlowTheme.bodyText1.override(
                                          fontFamily: 'Poppins',
                                        ),
                                      ),
                                      Text(
                                        listViewAdminUsersRecord.mobileNumber,
                                        style:
                                        FlutterFlowTheme.bodyText1.override(
                                          fontFamily: 'Poppins',
                                        ),
                                      )
                                    ],
                                  ),
                                  IconButton(
                                    onPressed: () async {
                                      final verified = true;

                                      final adminUsersRecordData =
                                      createAdminUsersRecordData(
                                        verified: verified,
                                      );

                                      await listViewAdminUsersRecord.reference
                                          .update(adminUsersRecordData);
                                      await FirebaseFirestore.instance.collection('branches').doc("currentBranchId").update(
                                          {
                                            'admins' :FieldValue.arrayUnion([listViewAdminUsersRecord.email]),
                                          });
                                    },
                                    icon: const Icon(
                                      Icons.verified,
                                      color: Colors.black,
                                      size: 30,
                                    ),
                                    iconSize: 30,
                                  )
                                ],
                              ),
                            );
                          },
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
