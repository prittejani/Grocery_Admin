import 'dart:async';
import 'dart:developer';
import 'dart:html';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:grocery_admin_project/utils/constants/custom_alert.dart';

import '../../../services/firebase_services.dart';
import '../../constants/custom_progress_indicator.dart';

class BannerUploadWidget extends StatefulWidget {
  const BannerUploadWidget({super.key});

  @override
  State<BannerUploadWidget> createState() => _BannerUploadWidgetState();
}

class _BannerUploadWidgetState extends State<BannerUploadWidget> {
  FirebaseService service = FirebaseService();
  TextEditingController _fileNameController = TextEditingController();
  bool _visible = false;
  bool _imageSelected = false;
  String? _url;
  String? imgUrl;
  @override
  Widget build(BuildContext context) {
    final size  = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(left: size.width / 30),
      width: size.width,
      height: size.height / 8,
      decoration: BoxDecoration(
          color: Color(0xff2c4c3b),
          borderRadius: BorderRadius.circular(size.height / 60)),
      child: Row(
        children: [
          Visibility(
            visible: _visible,
            child: Container(
              child: Row(
                children: [
                  AbsorbPointer(
                    absorbing: true,
                    child: SizedBox(
                      child: TextField(
                        controller: _fileNameController,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.green.shade200,
                              width: 1,
                            ),
                          ),
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.only(left: 20),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Please select image',
                        ),
                      ),
                      width: size.width / 6,
                      height: size.height / 17.5,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      uploadStorage();
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0))),
                    child: Text(
                      'Upload Image',
                      style: TextStyle(color: Color(0xff2c4c3b)),
                    ),
                  ),
                  SizedBox(
                    width: size.width / 60,
                  ),
                  AbsorbPointer(
                    absorbing: _imageSelected,
                    child: ElevatedButton(
                      onPressed: () {
                        service.uploadBannerImageToDatabase(_url).then((downloadUrl){
                          log('${downloadUrl}');
                          if (downloadUrl!=null){
                            Timer(Duration(seconds: 2), () {
                              customProgressIndicator();
                            });
                            _fileNameController.text = "";
                            CustomAlertDialog(context: context, title: 'New Banner Image', message: 'Saved Banner Image Successfully', btnText: 'OK');
                          }
                        });
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: _imageSelected
                              ? Colors.yellow
                              : Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  size.height / 80))),
                      child: Text(
                        'Save Image',
                        style: TextStyle(color: Color(0xff2c4c3b)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: _visible ? false : true,
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  _visible = true;
                });
              },
              child: Text(
                'Add New Banner',
                style: TextStyle(color: Color(0xff2c4c3b)),
              ),
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(size.height / 80))),
            ),
          ),
        ],
      ),
    );
  }
  void uploadImage({required Function(File file) onSelected}) {
    FileUploadInputElement uploadInputElement = FileUploadInputElement()
      ..accept = 'image/*';
    uploadInputElement.click();
    uploadInputElement.onChange.listen((event) {
      final file = uploadInputElement.files?.first;
      final reader = FileReader();
      reader.readAsDataUrl(file!);
      reader.onLoadEnd.listen((event) {
        onSelected(file);
      });
    });
  }

  void uploadStorage() {
    final dateTime = DateTime.now();
    final path = 'bannerImage/$dateTime';
    uploadImage(onSelected: (file) async{
      if (file != null) {
        setState(() {
          _fileNameController.text = file.name;
          _imageSelected = false;
          _url = path;
        });
        FirebaseStorage firebaseStorage = FirebaseStorage.instance;
        await firebaseStorage.refFromURL('gs://grocery-app-980ba.appspot.com').child(path).putBlob(file);
      }
    });
  }
}
