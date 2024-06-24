import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grocery_admin_project/utils/constants/custom_progress_indicator.dart';

import '../../../services/firebase_services.dart';
import '../../constants/custom_alert.dart';

class CreateNewBoyWidget extends StatefulWidget {
  const CreateNewBoyWidget({super.key});

  @override
  State<CreateNewBoyWidget> createState() => _CreateNewBoyWidgetState();
}

class _CreateNewBoyWidgetState extends State<CreateNewBoyWidget> {
  FirebaseService service = FirebaseService();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool _visible = false;

  bool _passObsecure = true;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height / 8,
      decoration: BoxDecoration(
        color: Color(0xff2c4c3b),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Visibility(
            visible: _visible ? false : true,
            child: Container(
              child: Padding(
                padding: EdgeInsets.only(left: 30),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _visible = true;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(size.height / 80))),
                  child: Text(
                    'Create New Delivery Boy',
                    style: TextStyle(color: Colors.green),
                  ),
                ),
              ),
            ),
          ),
          Visibility(
            visible: _visible,
            child: Container(
                padding: EdgeInsets.only(left: size.width / 30),
                decoration: BoxDecoration(
                    color: Color(0xff2c4c3b),
                    borderRadius: BorderRadius.circular(size.height / 60)),
                child: Container(
                  child: Row(
                    children: [
                      Container(
                        width: size.width / 6,
                        height: size.height / 17.5,
                        decoration: BoxDecoration(
                            color: CupertinoColors.systemGrey6,
                            borderRadius: BorderRadius.circular(10)),
                        child: TextField(
                          controller: _emailController,
                          cursorColor: Colors.green,
                          decoration: InputDecoration(
                            border:
                                OutlineInputBorder(borderSide: BorderSide.none),
                            contentPadding: EdgeInsets.only(left: 20),
                            hintText: 'Email',
                            hintStyle: TextStyle(
                                color: CupertinoColors.inactiveGray,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: size.width / 60,
                      ),
                      Container(
                        width: size.width / 6,
                        height: size.height / 17.5,
                        decoration: BoxDecoration(
                            color: CupertinoColors.systemGrey6,
                            borderRadius: BorderRadius.circular(10)),
                        child: TextField(
                          obscureText: _passObsecure,
                          cursorColor: Colors.green,
                          controller: _passwordController,
                          decoration: InputDecoration(
                            border:
                                OutlineInputBorder(borderSide: BorderSide.none),
                            contentPadding: EdgeInsets.only(left: 20),
                            hintText: 'Password',
                            hintStyle: TextStyle(
                                color: CupertinoColors.inactiveGray,
                                fontWeight: FontWeight.normal),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _passObsecure = !_passObsecure;
                                });
                              },
                              child: _passObsecure
                                  ? Icon(
                                      CupertinoIcons.eye,
                                      color: Colors.grey,
                                    )
                                  : Icon(
                                      CupertinoIcons.eye_slash,
                                      color: Colors.grey,
                                    ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: size.width / 60,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (_emailController.text.isEmpty &&
                              _passwordController.text.isEmpty) {
                            return CustomAlertDialog(
                              context: context,
                              title: "Alert!!",
                              message: "Please enter email and password",
                              btnText: "OK",
                            );
                          } else if (_emailController.text.isEmpty) {
                            return CustomAlertDialog(
                              context: context,
                              title: "Email!!",
                              message: "Please enter email",
                              btnText: "OK",
                            );
                          } else if (_passwordController.text.isEmpty) {
                            return CustomAlertDialog(
                              context: context,
                              title: "Password!!",
                              message: "Please enter password",
                              btnText: "OK",
                            );
                          } else if (validatePassword(
                                  _passwordController.text.trim()) !=
                              null) {
                            return CustomAlertDialog(
                              context: context,
                              title: "Password!!",
                              message:
                                  "should contain at least one upper case \nshould contain at least one lower case\nshould contain at least one digit \nshould contain at least one Special character \nmust be at least 8 characters in length",
                              btnText: "OK",
                            );
                          } else if (validateEmail(
                                  _emailController.text.trim()) !=
                              null) {
                            return CustomAlertDialog(
                              context: context,
                              title: "Email!!",
                              message: "Please enter valid email !!",
                              btnText: "OK",
                            );
                          } else {
                            Timer(
                              Duration(seconds: 3),
                              () {
                                customProgressIndicator();
                              },
                            );
                            service
                                .saveDeliveryBoy(_emailController.text.trim(),
                                    _passwordController.text.trim())
                                .whenComplete(() {
                              _emailController.clear();
                              _passwordController.clear();
                              CustomAlertDialog(
                                  context: context,
                                  title: "Done...",
                                  message: "Delivery boy create successfully",
                                  btnText: "OK");
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(size.height / 80))),
                        child: Text(
                          'Save',
                          style: TextStyle(color: Colors.green),
                        ),
                      ),
                    ],
                  ),
                )),
          ),
        ],
      ),
    );
  }

  String? validateEmail(String? value) {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);

    return value!.isNotEmpty && !regex.hasMatch(value)
        ? 'Enter a valid email address'
        : null;
  }

  String? validatePassword(String value) {
    RegExp regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    if (value.isEmpty) {
      return 'Please enter password';
    } else {
      if (!regex.hasMatch(value)) {
        return 'Enter valid password';
      } else {
        return null;
      }
    }
  }
}
