import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery_admin_project/services/firebase_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../constants/custom_progress_indicator.dart';

class VendorDetailBox extends StatefulWidget {
  final String? uid;

  VendorDetailBox({super.key, this.uid});

  @override
  State<VendorDetailBox> createState() => _VendorDetailBoxState();
}

class _VendorDetailBoxState extends State<VendorDetailBox> {
  FirebaseService service = FirebaseService();

  @override
  void initState() {
    log("${widget.uid}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('vendors')
            .doc(widget.uid)
            .get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Something went wrong'),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: customProgressIndicator());
          }
          return Dialog(
            backgroundColor: Colors.white,
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: Stack(
                children: [
                  Container(
                    height: size.height/1.5,
                    width: size.width * .3,
                    child: ListView(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          snapshot.data?['shopImage']),
                                      fit: BoxFit.cover)),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  snapshot.data?['shopName'],
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25),
                                ),
                                Text(
                                  snapshot.data?['shopDialog'],
                                ),
                              ],
                            ),
                          ],
                        ),
                        Divider(
                          thickness: 4,
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: Container(
                                    child: Text('Contact Number'),
                                  )),
                                  Container(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: Text(":"),
                                    ),
                                  ),
                                  Expanded(
                                      child: Container(
                                    child: Text(snapshot.data?['shopMobileNo']),
                                  )),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: Container(
                                    child: Text('Email'),
                                  )),
                                  Container(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: Text(":"),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: Text(snapshot.data?['shopEmail']),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                      child: Container(
                                    child: Text('Address'),
                                  )),
                                  Container(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: Text(":"),
                                    ),
                                  ),
                                  Expanded(
                                      child: Container(
                                    child: Text(snapshot.data?['shopAddress']),
                                  )),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Divider(
                                thickness: 2,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: Container(
                                    child: Text('Top Pick Status'),
                                  )),
                                  Container(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: Text(":"),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: snapshot.data?['isTopPiked']
                                          ? Chip(
                                              backgroundColor: Colors.green,
                                              label: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Icon(
                                                    CupertinoIcons.checkmark,
                                                    color: Colors.white,
                                                  ),
                                                  Text(
                                                    "Top Picked",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ],
                                              ),
                                            )
                                          : Chip(
                                              backgroundColor: Colors.red,
                                              label: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Icon(
                                                    CupertinoIcons.xmark,
                                                    color: Colors.white,
                                                  ),
                                                  Text(
                                                    "Not Top Picked",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ],
                                              ),
                                            ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Divider(
                                thickness: 2,
                              ),
                            ),
                            // Wrap(
                            //   children: [
                            //     SizedBox(
                            //       height: 120,
                            //       width: 120,
                            //       child: Card(
                            //         color: Color(0xB18FFF89),
                            //         elevation: 4,
                            //         child: Padding(
                            //           padding: EdgeInsets.all(10.0),
                            //           child: Center(
                            //             child: Column(
                            //               mainAxisSize: MainAxisSize.min,
                            //               children: [
                            //                 Icon(
                            //                   CupertinoIcons
                            //                       .money_dollar_circle,
                            //                   size: 50,
                            //                   semanticLabel: "50",
                            //                   color: Colors.black54,
                            //                 ),
                            //                 Text('Total Revenue'),
                            //                 Text('120000'),
                            //               ],
                            //             ),
                            //           ),
                            //         ),
                            //       ),
                            //     ),
                            //     SizedBox(
                            //       height: 120,
                            //       width: 120,
                            //       child: Card(
                            //         color: Color(0xB18FFF89),
                            //         elevation: 4,
                            //         child: Padding(
                            //           padding: EdgeInsets.all(10.0),
                            //           child: Center(
                            //             child: Column(
                            //               mainAxisSize: MainAxisSize.min,
                            //               children: [
                            //                 Icon(
                            //                   CupertinoIcons.shopping_cart,
                            //                   size: 50,
                            //                   semanticLabel: "50",
                            //                   color: Colors.black54,
                            //                 ),
                            //                 Text('Active Orders'),
                            //                 Text('6'),
                            //               ],
                            //             ),
                            //           ),
                            //         ),
                            //       ),
                            //     ),
                            //     SizedBox(
                            //       height: 120,
                            //       width: 120,
                            //       child: Card(
                            //         color: Color(0xB18FFF89),
                            //         elevation: 4,
                            //         child: Padding(
                            //           padding: EdgeInsets.all(10.0),
                            //           child: Center(
                            //             child: Column(
                            //               mainAxisSize: MainAxisSize.min,
                            //               children: [
                            //                 Icon(
                            //                   CupertinoIcons.bag,
                            //                   size: 50,
                            //                   semanticLabel: "50",
                            //                   color: Colors.black54,
                            //                 ),
                            //                 Text('Total Orders'),
                            //                 Text('136'),
                            //               ],
                            //             ),
                            //           ),
                            //         ),
                            //       ),
                            //     ),
                            //     SizedBox(
                            //       height: 120,
                            //       width: 120,
                            //       child: Card(
                            //         color: Color(0xB18FFF89),
                            //         elevation: 4,
                            //         child: Padding(
                            //           padding: EdgeInsets.all(10.0),
                            //           child: Center(
                            //             child: Column(
                            //               mainAxisSize: MainAxisSize.min,
                            //               children: [
                            //                 Icon(
                            //                   CupertinoIcons.cube_box,
                            //                   size: 50,
                            //                   color: Colors.black54,
                            //                 ),
                            //                 Text('Products'),
                            //                 Text('Total 170'),
                            //               ],
                            //             ),
                            //           ),
                            //         ),
                            //       ),
                            //     ),
                            //     SizedBox(
                            //       height: 120,
                            //       width: 120,
                            //       child: Card(
                            //         color: Color(0xB18FFF89),
                            //         elevation: 4,
                            //         child: Padding(
                            //           padding: EdgeInsets.all(10.0),
                            //           child: Center(
                            //             child: Column(
                            //               mainAxisSize: MainAxisSize.min,
                            //               children: [
                            //                 Icon(
                            //                   CupertinoIcons.square_list,
                            //                   size: 50,
                            //                   semanticLabel: "50",
                            //                   color: Colors.black54,
                            //                 ),
                            //                 Text('Statement'),
                            //               ],
                            //             ),
                            //           ),
                            //         ),
                            //       ),
                            //     ),
                            //   ],
                            // ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: snapshot.data?['accVerified']
                        ? Chip(
                            backgroundColor: CupertinoColors.activeGreen,
                            label: Row(
                              children: [
                                Icon(
                                  CupertinoIcons.check_mark_circled,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Text(
                                  'Active',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          )
                        : Chip(
                            backgroundColor: CupertinoColors.destructiveRed,
                            label: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  CupertinoIcons.xmark_circle,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Text(
                                  'Inactive',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
