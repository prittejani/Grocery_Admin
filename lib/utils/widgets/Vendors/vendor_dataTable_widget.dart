import 'dart:developer';

import 'package:chips_choice/chips_choice.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery_admin_project/services/firebase_services.dart';
import 'package:grocery_admin_project/utils/widgets/Vendors/vendor_details_box.dart';

import '../../constants/custom_progress_indicator.dart';

class VendorTable extends StatefulWidget {
  VendorTable({super.key});

  @override
  State<VendorTable> createState() => _VendorTableState();
}

class _VendorTableState extends State<VendorTable> {
  FirebaseService service = FirebaseService();

  int tag = 1;
  List<String> options = [
    'All Vendors',
    'Active Vendors',
    'Inactive Vendors',
    'Top picked',
    'Top Rated'
  ];
  bool? topPicked;
  bool? active;

  filterTag(val) {
    if (val == 1) {
      setState(() {
        active = true;
      });
    }
    if (val == 2) {
      setState(() {
        active = false;
      });
    }
    if (val == 3) {
      setState(() {
        topPicked = true;
      });
    }
    if (val == 0) {
      setState(() {
        topPicked = null;
        active = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ChipsChoice<int>.single(
          choiceStyle: C2ChipStyle.filled(
            selectedStyle: C2ChipStyle(
              borderRadius: BorderRadius.all(
                Radius.circular(25),
              ),
              backgroundColor: Colors.green,
              checkmarkColor: CupertinoColors.white,
            ),
          ),
          choiceCheckmark: true,
          value: tag,
          onChanged: (val) {
            setState(() {
              tag = val;
            });
            filterTag(val);
          },
          choiceItems: C2Choice.listFrom<int, String>(
            source: options,
            value: (i, v) => i,
            label: (i, v) => v,
          ),
        ),
        StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('vendors')
              .where('accVerified', isEqualTo: active)
              .where('isTopPiked', isEqualTo: topPicked)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Something went wrong'));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return customProgressIndicator();
            }

            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                border: TableBorder(
                    verticalInside: BorderSide(color: Colors.green),
                    horizontalInside: BorderSide(color: Colors.green)),
                columns: [
                  DataColumn(
                    label: Text(
                      'Active / Inactive',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Top Picked',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Shop Name',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Shop Rating',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Mobile',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Email',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'View Details',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
                rows: _vendorDetailsRow(
                  snapshot.data!,
                ),
                showBottomBorder: true,
                dataRowHeight: 60,
                headingRowColor: MaterialStateProperty.all(Color(0xff306844)),
              ),
            );
          },
        ),
      ],
    );
  }

  List<DataRow> _vendorDetailsRow(QuerySnapshot snapshot) {
    List<DataRow> newList =
        snapshot.docs.map((DocumentSnapshot documentSnapshot) {
      Map<String, dynamic> data =
          documentSnapshot.data()! as Map<String, dynamic>;
      return DataRow(cells: [
        DataCell(Center(
          child: IconButton(
            onPressed: () {
              service.updateVendorStatus(
                  id: data['shopId'], status: !data['accVerified']);
            },
            icon: data['accVerified'] == true
                ? Icon(
                    CupertinoIcons.check_mark_circled,
                    color: CupertinoColors.activeGreen,
                  )
                : Icon(
                    CupertinoIcons.xmark_circle,
                    color: CupertinoColors.destructiveRed,
                  ),
          ),
        )),
        DataCell(Center(
          child: IconButton(
            onPressed: () {
              service.updateVendorTopPiked(
                  id: data['shopId'], status: !data['isTopPiked']);
            },
            icon: data['isTopPiked'] == true
                ? Icon(
                    CupertinoIcons.check_mark_circled,
                    color: CupertinoColors.activeGreen,
                  )
                : Icon(
                    CupertinoIcons.xmark_circle,
                    color: CupertinoColors.destructiveRed,
                  ),
          ),
        )),
        DataCell(Center(child: Text(data['shopName']))),
        DataCell(Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(
              CupertinoIcons.star_fill,
              color: CupertinoColors.systemYellow,
            ),
            Text('3.7'),
          ],
        )),

        DataCell(Center(child: Text(data['shopMobileNo']))),
        DataCell(Center(child: Text(data['shopEmail']))),
        DataCell(Center(
          child: IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context){
                  return VendorDetailBox(uid: data['shopId'],);
                },
              );
            },
            icon: Icon(
              CupertinoIcons.info,
              color: CupertinoColors.activeGreen,
            ),
          ),
        )),
      ]);
    }).toList();
    return newList;
  }
}
