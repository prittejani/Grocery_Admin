import 'dart:async';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_admin_project/screens/vendors_screen.dart';
import 'package:grocery_admin_project/services/firebase_services.dart';
import 'package:grocery_admin_project/utils/constants/custom_alert.dart';
import 'package:grocery_admin_project/utils/constants/custom_progress_indicator.dart';
import 'package:grocery_admin_project/utils/widgets/setting/admin_profile.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login-screen';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formkey = GlobalKey<FormState>();
  FirebaseService service = FirebaseService();
  AdminProfile adminProfile = AdminProfile();
  bool _passObsecure = true;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String id = "";

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return
      Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: size.height,
              width: size.width / 2.3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: size.height / 30,
                  ),
                  Container(
                    height: size.height / 4.3,
                    width: size.width / 9.2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(size.width / 45),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(4, 2),
                          blurRadius: 12,
                          color: Color.fromRGBO(0, 0, 0, 0.25),
                        )
                      ],
                      color: Colors.yellow,
                      image: DecorationImage(
                        image: NetworkImage(
                            "https://firebasestorage.googleapis.com/v0/b/grocery-app-980ba.appspot.com/o/logoManagment.png?alt=media&token=7cb66806-78ad-4974-be29-bc8223c69d38"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height / 30,
                  ),
                  Text(
                    "Grocify Team",
                    style: GoogleFonts.poppins(
                        color: Colors.green,
                        fontSize: 23,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "Delivering your essentials with utmost care.",
                    style: GoogleFonts.poppins(
                        color: Colors.green,
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: size.height,
              width: size.width / 1.78,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(size.width / 50),
                  bottomLeft: Radius.circular(size.width / 50),
                ),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(2, 2),
                    blurRadius: 12,
                    color: Color.fromRGBO(0, 0, 0, 0.50),
                  )
                ],
              ),
              child: Form(
                key: _formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Sign In",
                      style: GoogleFonts.dancingScript(
                          color: Colors.green, fontSize: 45,fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: size.height/10,
                    ),
                    Container(
                      width: size.width / 2.2,
                      height: size.height / 12,
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(.25),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextFormField(
                        autofocus: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "username can't be empty";
                          } else if (!RegExp("[a-zA-Z]").hasMatch(value)) {
                            return "enter valid username";
                          } else {
                            return null;
                          }
                        },
                        controller: usernameController,
                        cursorColor: Colors.green,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(
                            borderSide: BorderSide.none
                          ),
                          focusColor: Colors.white,
                          hintText: 'Username',
                          hintStyle: TextStyle(
                            color: Colors.grey.withOpacity(.50),
                            fontWeight: FontWeight.normal,
                          ),
                          prefixIcon: Icon(
                            CupertinoIcons.person,
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: size.height/30,),
                    Container(
                      width: size.width / 2.2,
                      height: size.height / 12,
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(.25),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextFormField(
                        obscureText: _passObsecure,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "password can't be empty";
                          }
                          else if (!RegExp(
                              r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                              .hasMatch(value)) {
                            return "enter valid password";
                          }
                          else {
                            return null;
                          }
                        },
                        controller: passwordController,
                        cursorColor: Colors.green,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          focusColor: Colors.green,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none
                          ),

                          hintText: 'Password',
                          hintStyle: TextStyle(
                            color: Colors.grey.withOpacity(.50),
                            fontWeight: FontWeight.normal,
                          ),
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Colors.green,
                          ),
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
                    SizedBox(height: size.height/30,),
                    InkWell(
                      onTap: (){
                        if (_formkey.currentState!.validate()) {
                          login();
                          log("${id}");

                        } else {
                          CustomAlertDialog(
                              context: context,
                              title: 'Alert!!',
                              message: "Invalid credentials",
                              btnText: "Ok");
                        }

                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: size.width / 2.2,
                        height: size.height / 12,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text("Sign in",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w600),),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  login() async {
    service.getAdminCredentials().then((value) {
      value?.docs.forEach((doc) async {
        if (doc.get('username') == usernameController.text) {
          if (doc.get('password') == passwordController.text) {
            log("~~~>>> ${id}");
            try {
              UserCredential userCredential =
                  await FirebaseAuth.instance.signInAnonymously();

              if (userCredential.user?.uid != null) {
                log(usernameController.text);
                Get.offNamed(VendorScreen.id, arguments: doc.get('uid'));
                Timer(Duration(seconds: 4), () {
                  customProgressIndicator();
                });
              } else {
                CustomAlertDialog(
                  context: context,
                  title: 'Alert !!',
                  message: 'Login Failed',
                  btnText: 'Ok',
                );
              }
            } on FirebaseAuthException catch (exception) {
              CustomAlertDialog(
                  context: context,
                  title: 'Alert!!',
                  message: exception,
                  btnText: 'Ok');
            }
          } else {
            CustomAlertDialog(
              context: context,
              title: 'Alert!!',
              message: "Invalid username or password",
              btnText: "Ok",
            );
          }
        }
      });
    });
  }
}
