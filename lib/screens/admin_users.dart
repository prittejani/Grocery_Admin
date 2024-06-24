import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:grocery_admin_project/services/sidebar.dart';

class AdminUsersScreen extends StatelessWidget {
  static const String id = 'admin-user screen';
   AdminUsersScreen({super.key});
  SidebarWidget _sidebarWidget = SidebarWidget();
  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xff2c4c3b),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          'Grocery App Dashboard',
          style: TextStyle(color: Colors.white),
        ),
      ),
      sideBar: _sidebarWidget.sidebarMenus(context, AdminUsersScreen.id),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.topLeft,
          padding:  EdgeInsets.all(10),
          child:  Text(
            'Admin User',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 36,
            ),
          ),
        ),
      ),
    );
  }
}
