import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:grocery_admin_project/utils/widgets/setting/admin_profile.dart';

import '../services/sidebar.dart';
import '../utils/widgets/Vendors/vendor_dataTable_widget.dart';

class SettingScreen extends StatelessWidget {
  static const String id = 'setting-screen';
   SettingScreen({super.key});
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
      sideBar: _sidebarWidget.sidebarMenus(context, SettingScreen.id),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Admin Profile',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 36,
                ),
              ),
              //Text('Manage your profile'),
              Divider(
                thickness: 2,
              ),
            AdminProfile(),
              Divider(
                thickness: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
