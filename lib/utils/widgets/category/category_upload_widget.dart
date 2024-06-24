import 'dart:developer';
import 'dart:html';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import '../../../services/firebase_services.dart';
import '../../constants/custom_alert.dart';

class CategoryCreateWidget extends StatefulWidget {
  const CategoryCreateWidget({super.key});

  @override
  State<CategoryCreateWidget> createState() => _CategoryCreateWidgetState();
}

class _CategoryCreateWidgetState extends State<CategoryCreateWidget> {
  FirebaseService service = FirebaseService();
  TextEditingController _fileNameController = TextEditingController();
  TextEditingController _categoryNameController = TextEditingController();
  bool _visible = false;
  bool _imageSelected = false;
  String? _url;
  String? imgUrl;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
                  SizedBox(
                    width: size.width / 6,
                    height: size.height / 17.5,
                    child: TextField(
                      controller: _categoryNameController,
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
                        hintText: 'No category name given',
                      ),
                    ),
                  ),
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
                      'Save New Category',
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
                        if (_categoryNameController.text.isEmpty) {
                          return CustomAlertDialog(
                              context: context,
                              title: "Add new category",
                              message: "New category not given",
                              btnText: "OK");
                        }
                        service
                            .uploadCategoryImageToDatabase(_url,_categoryNameController.text.trim())
                            .then((downloadUrl) {
                          log('${downloadUrl}');
                          if (downloadUrl != null) {
                            CustomAlertDialog(
                                context: context,
                                title: 'New Category',
                                message: 'Saved New Category Successfully',
                                btnText: 'OK');
                          }else{
                            log("~~>> Add error");
                          }

                        });
                        _categoryNameController.clear();
                        _fileNameController.clear();
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              _imageSelected ? Colors.yellow : Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(size.height / 80))),
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
                'Add Category',
                style: TextStyle(color: Color(0xff2c4c3b)),
              ),
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(size.height / 80))),
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
    final path = 'categoryImage/$dateTime';
    uploadImage(onSelected: (file) async {
      if (file != null) {
        setState(() {
          _fileNameController.text = file.name;
          _imageSelected = false;
          _url = path;
        });
        FirebaseStorage firebaseStorage = FirebaseStorage.instance;
        await firebaseStorage
            .refFromURL('gs://grocery-app-980ba.appspot.com')
            .child(path)
            .putBlob(file);
      }
    });
  }
}
