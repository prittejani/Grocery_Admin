import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:grocery_admin_project/utils/widgets/category/category_card_widget.dart';

import '../../constants/custom_progress_indicator.dart';

class CategoryListWidget extends StatelessWidget {
  const CategoryListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      child: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('category').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return customProgressIndicator();
          }

          return Wrap(
            direction: Axis.horizontal,
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              // Map<String, dynamic> data =
              // document.data()! as Map<String, dynamic>;
              return CategoryCard(document);
            }).toList(),
          );
        },
      ),
    );
  }
}
