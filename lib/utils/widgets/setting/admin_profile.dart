

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:grocery_admin_project/services/firebase_services.dart';


import '../../constants/custom_progress_indicator.dart';

class AdminProfile extends StatefulWidget {

  AdminProfile({super.key});

  @override
  State<AdminProfile> createState() => _AdminProfileState();
}

class _AdminProfileState extends State<AdminProfile> {
  @override

  void initState() {
    super.initState();

  }


  FirebaseService service = FirebaseService();
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("admin")
          .where('uid', isEqualTo: "X0hxYju65Glrtefq50QD")
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
        if (snap!.size == 0) {
          return Center(
            child: Text('No Approved delivery boys found'),
          );
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
                label: Text("Name"),
              ),
              DataColumn(
                label: Text("Password"),
              ),
            ],
            rows: _boysList(snapshot.data!),
          ),
        );
      },
    );
  }

  List<DataRow> _boysList(QuerySnapshot snapshot) {
    List<DataRow> newList = snapshot.docs.map((DocumentSnapshot document) {
      Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

      return DataRow(
        cells: [
          DataCell(
            Text(data['username']),
          ),
          DataCell(
            Text(data['password']),
          ),
        ],
      );
    }).toList();
    return newList;
  }
}
