import 'package:flutter/cupertino.dart';


Widget customProgressIndicator(){
  return Center(
    child: CupertinoActivityIndicator(
      animating: true,
      color:
      Color(0xff2c4c3b),
      radius: 20,
    ),
  );
}