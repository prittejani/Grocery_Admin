import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:grocery_admin_project/utils/widgets/Vendors/vendor_dataTable_widget.dart';

import '../services/sidebar.dart';

class VendorScreen extends StatefulWidget {
  static const String id = 'vendor-screen';

  const VendorScreen({super.key});

  @override
  State<VendorScreen> createState() => _VendorScreenState();
}

class _VendorScreenState extends State<VendorScreen> {
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
      sideBar: _sidebarWidget.sidebarMenus(context, VendorScreen.id),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Manage Vendors',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 36,
                ),
              ),
              Text('Manage all the vendors activities'),
              Divider(
                thickness: 2,
              ),
              VendorTable(),
              Divider(
                thickness: 2,
              ),
            ],
          ),
        ),
      ),
    );
    ;
  }
}
