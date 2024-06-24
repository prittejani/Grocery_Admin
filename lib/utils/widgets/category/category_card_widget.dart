import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:grocery_admin_project/utils/widgets/category/subcategory_widget.dart';


class CategoryCard extends StatelessWidget {
  DocumentSnapshot documentSnapshot;

  CategoryCard(this.documentSnapshot);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(4),
      onTap: (){
        showDialog(context: context, builder: (BuildContext context){
          return SubCategoryWidget(documentSnapshot['catName']);
        });
      },
      child: SizedBox(
        height: 120,
        width: 120,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            boxShadow:[BoxShadow(
              offset: Offset(2, 2),
              blurRadius: 12,
              color: Color.fromRGBO(0, 0, 0, 0.16),
            ),],
          color: Colors.white,
          ),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                      height: 70,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(documentSnapshot['img']),
                          fit: BoxFit.cover
                        ),
                      ),
                  ),
                  FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      documentSnapshot['catName'],
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
