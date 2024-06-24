import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class FirebaseService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  CollectionReference banners = FirebaseFirestore.instance.collection('slider');
  Stream<QuerySnapshot> vendors =
      FirebaseFirestore.instance.collection('vendors').snapshots();
  CollectionReference category =
      FirebaseFirestore.instance.collection('category');
  CollectionReference boys = FirebaseFirestore.instance.collection('boys');
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<QuerySnapshot?> getAdminCredentials() async {
    var result = firestore.collection('admin').get();
    return result;
  }

  // Banners
  Future<String> uploadBannerImageToDatabase(url) async {
    String downloadUrl = await firebaseStorage.ref(url).getDownloadURL();
    if (downloadUrl != null) {
      firestore.collection('slider').add({'img': downloadUrl}).then((value) {
        log('~~~~>>> Download URL ${downloadUrl}');
        log("~~~~~~~~>>>>> Success  ~~~~>>>>  ${value}");
      });
    }
    return downloadUrl;
  }

  deleteBannerImageFromDatabase(id) async {
    await firestore.collection('slider').doc(id).delete();
  }

  // Vendors
  updateVendorStatus({id, status}) {
    firestore.collection('vendors').doc(id).update({
      'accVerified': status ? true : false,
    });
  }

  updateVendorTopPiked({id, status}) {
    firestore
        .collection('vendors')
        .doc(id)
        .update({'isTopPiked': status ? true : false});
  }

  // Category
  Future<String> uploadCategoryImageToDatabase(url, catName) async {
    String downloadUrl = await firebaseStorage.ref(url).getDownloadURL();
    if (downloadUrl != null) {
      category.doc(catName).set({
        'img': downloadUrl,
        'catName': catName,
      }).then((value) {
        log('~~~~>>> Download URL ${downloadUrl}');
        log("~~~~~~~~>>>>> Success  ~~~~>>>> ");
      });
    }
    return downloadUrl;
  }

  // Delivery boys

  updateDeliveryBoyStatus({id, status}) {
    firestore.collection('boys').doc(id).update({
      'accVerified': status ? false : true,
    });
  }

  Future<void> saveDeliveryBoy(email, password) async {
    boys.doc(email).set({
      'accVerified': false,
      'Address': '',
      'boyEmail': email,
      'boyImage': '',
      'boyLocation': GeoPoint(0.0, 0.0),
      'boyMobileNo': '',
      'boyName': '',
      'boyPassword': password,
      'boyId': '',
    });
  }

  Future<DocumentSnapshot> getCurrentAdmin(String userId) async {
    return await FirebaseFirestore.instance
        .collection('admin')
        .doc(userId)
        .get();
  }

  Future<void> confirmDeleteDialog({title, message, context, id}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.green,
          title: Text(
            title,
            style: TextStyle(color: Colors.white),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  message,
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(
                'Delete',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                deleteBannerImageFromDatabase(id);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
