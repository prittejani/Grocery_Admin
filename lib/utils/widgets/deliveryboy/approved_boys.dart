import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery_admin_project/services/firebase_services.dart';
import 'package:grocery_admin_project/utils/constants/custom_progress_indicator.dart';

import '../../constants/custom_alert.dart';

class ApprovedBoys extends StatefulWidget {
  const ApprovedBoys({super.key});

  @override
  State<ApprovedBoys> createState() => _ApprovedBoysState();
}

class _ApprovedBoysState extends State<ApprovedBoys> {

  FirebaseService service = FirebaseService();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("boys")
            .where('accVerified', isEqualTo: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: customProgressIndicator(),
            );
          }
          QuerySnapshot<Object?>? snap = snapshot.data;
          if (snap!.size==0){
            return Center(child: Text('No Approved delivery boys found'),);
          }
          return SingleChildScrollView(
            child: DataTable(
              showBottomBorder: true,
              dataRowHeight: 60,
              headingRowColor: MaterialStateProperty.all(
                Colors.grey[200],
              ),
              columns: [
                DataColumn(
                  label: Text("Profile Pic"),
                ),
                DataColumn(
                  label: Text("Name"),
                ),
                DataColumn(
                  label: Text("Email"),
                ),
                DataColumn(
                  label: Text("Mobile No"),
                ),
                DataColumn(
                  label: Text("Action"),
                ),
              ],
              rows: _boysList(snapshot.data!),
            ),
          );
        },
      ),
    );
  }

  List<DataRow> _boysList(QuerySnapshot snapshot) {
    List<DataRow> newList = snapshot.docs.map((DocumentSnapshot document) {
      Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
      return DataRow(
        cells: [
          DataCell(
            Container(
              height: 50,
              decoration: BoxDecoration(
                  shape: BoxShape.circle
              ),
              width: 50,

              child: data["boyImage"] == "" ? Icon(CupertinoIcons.person,size: 40,):ClipRRect(borderRadius: BorderRadius.circular(40),child: Image.network(data["boyImage"],fit: BoxFit.fill,)),
            ),
          ),
          DataCell(
            Text(data['boyName']),
          ),
          DataCell(
            Text(data['boyEmail']),
          ),
          DataCell(
            Text(data['boyMobileNo']),
          ),
          DataCell(
            CupertinoSwitch(
              value: data['accVerified'],
              onChanged: (value) {
                service.updateDeliveryBoyStatus(
                    id: document.id, status: data['accVerified']);
                CustomAlertDialog(context: context, title: 'Alert!!', message: "Status changed successfully", btnText: "OK");
                setState(() {});
              },
            ),
          )
        ],
      );
    }).toList();
    return newList;
  }
}
