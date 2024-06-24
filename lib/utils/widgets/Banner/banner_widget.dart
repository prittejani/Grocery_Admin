import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grocery_admin_project/services/firebase_services.dart';
import 'package:grocery_admin_project/utils/constants/custom_progress_indicator.dart';

class BannerWidget extends StatelessWidget {
  BannerWidget({super.key});

  FirebaseService service = FirebaseService();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return StreamBuilder<QuerySnapshot>(
      stream: service.banners.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return customProgressIndicator();
        }

        return Container(
          width: size.width,
          height: size.height / 2.5,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              return Padding(
                padding: EdgeInsets.all(8.0),
                child: Stack(
                  children: [
                    SizedBox(
                      height: size.height / 2,
                      child: Card(
                        elevation: 10,
                        borderOnForeground: true,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(size.height / 45),
                          child: Image.network(
                            data['img'],
                            scale: 1,
                            width: size.width / 3.3,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: IconButton(
                          onPressed: () {
                            service.confirmDeleteDialog(
                                context: context,
                                id: document.id,
                                message: 'Are you sure you want to delete?',
                                title: 'Delete Banner');
                          },
                          icon: Icon(
                            CupertinoIcons.delete,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
