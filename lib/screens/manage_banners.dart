import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

import 'package:grocery_admin_project/services/sidebar.dart';
import 'package:grocery_admin_project/utils/widgets/Banner/banner_upload_widget.dart';
import 'package:grocery_admin_project/utils/widgets/Banner/banner_widget.dart';

class BannerScreen extends StatelessWidget {
  static const String id = 'banner-screen';

  BannerScreen({super.key});

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
      sideBar: _sidebarWidget.sidebarMenus(context, id),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Banners Screen',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 36,
                ),
              ),
              Text('Add / Delete Banner images'),
              Divider(
                thickness: 2,
              ),
              BannerWidget(),
              Divider(
                thickness: 2,
              ),
              BannerUploadWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
