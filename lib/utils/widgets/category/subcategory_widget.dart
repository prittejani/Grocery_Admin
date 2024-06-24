import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:grocery_admin_project/services/firebase_services.dart';
import 'package:grocery_admin_project/utils/constants/custom_alert.dart';
import 'package:grocery_admin_project/utils/constants/custom_progress_indicator.dart';

class SubCategoryWidget extends StatefulWidget {
  final String CategoryName;

  SubCategoryWidget(this.CategoryName);

  @override
  State<SubCategoryWidget> createState() => _SubCategoryWidgetState();
}

class _SubCategoryWidgetState extends State<SubCategoryWidget> {
  TextEditingController _subCategoryController = TextEditingController();
  FirebaseService service = FirebaseService();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Dialog(
      child: Container(
        height: size.height,
        width: 400,
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: FutureBuilder<DocumentSnapshot>(
            future: FirebaseFirestore.instance
                .collection('category')
                .doc(widget.CategoryName)
                .get(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text("Something went wrong");
              }

              if (snapshot.hasData && !snapshot.data!.exists) {
                return Text("Document does not exist");
              }

              if (snapshot.connectionState == ConnectionState.done) {
                if (!snapshot.hasData) {
                  return Center(child: Text('No Subcategories Added'));
                } else {
                  Map<String, dynamic> data =
                      snapshot.data!.data() as Map<String, dynamic>;
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text('Main Category : '),
                                Text(
                                  "${widget.CategoryName}",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Divider(
                              thickness: 3,
                            ),
                            // subcategory list
                          ],
                        ),
                      ),
                      Container(
                        child: Expanded(
                          child: ListView.builder(
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                contentPadding: EdgeInsets.zero,
                                leading: CircleAvatar(
                                  backgroundColor: Colors.green,
                                  child: Text('${index + 1}',style: TextStyle(color: Colors.white),),
                                ),
                                title: Text(data['subCat'][index]['subCatName']),
                              );
                            },
                            itemCount: data['subCat'] == null
                                ? 0
                                : data['subCat'].length,
                          ),
                        ),
                      ),
                      Container(
                        child: Column(
                          children: [
                            Divider(
                              thickness: 4,
                            ),
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Add New Sub Category',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          width: 100,
                                          height: 35,
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade400,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: TextField(
                                            controller: _subCategoryController,
                                            decoration: InputDecoration(
                                              hintText: "Sub Category Name",
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide.none),
                                              contentPadding:
                                                  EdgeInsets.only(left: 10),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 30,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          if (_subCategoryController
                                              .text.isEmpty) {
                                            return CustomAlertDialog(
                                                context: context,
                                                title: "Alert!!",
                                                message:
                                                    "Please add subcategory name",
                                                btnText: "OK");
                                          }
                                          DocumentReference docRef = service
                                              .category
                                              .doc(widget.CategoryName);
                                          docRef.update({
                                            'subCat': FieldValue.arrayUnion([
                                              {
                                                'subCatName':
                                                    _subCategoryController.text
                                                        .trim(),
                                              }
                                            ]),
                                          }).then((value) {
                                            CustomAlertDialog(
                                                context: context,
                                                title:
                                                    "Done...",
                                                message: "Subcategory added successfully",
                                                btnText: "OK");
                                          });
                                          setState(() {});
                                          _subCategoryController.clear();
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          height: 35,
                                          width: 100,
                                          decoration: BoxDecoration(
                                            color: Colors.green,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Text(
                                            'Save',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }
              }

              return customProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
