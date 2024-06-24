import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:grocery_admin_project/utils/widgets/deliveryboy/approved_boys.dart';

import 'package:grocery_admin_project/utils/widgets/deliveryboy/create_deliveryboy.dart';
import 'package:grocery_admin_project/utils/widgets/deliveryboy/new_boys.dart';

import '../services/firebase_services.dart';
import '../services/sidebar.dart';

class DeliveryBoyScreen extends StatelessWidget {
  static const String id = 'delivery-screen';

  DeliveryBoyScreen({super.key});

  SidebarWidget _sidebarWidget = SidebarWidget();

  FirebaseService service = FirebaseService();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: AdminScaffold(
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
            height: MediaQuery.of(context).size.height,
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Delivery Boys',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 36,
                  ),
                ),
                Text('Create and manage delivery boys'),
                Divider(
                  thickness: 3,
                ),
                CreateNewBoyWidget(),
                Divider(
                  thickness: 3,
                ),
                TabBar(
                  splashFactory: NoSplash.splashFactory,
                  overlayColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                      return states.contains(MaterialState.focused)
                          ? null
                          : Colors.green[50];
                    },
                  ),
                  splashBorderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorColor: Colors.green,
                  labelColor: Colors.green,
                  unselectedLabelColor: Colors.grey,
                  tabs: [
                    Tab(
                      text: 'NEW',
                    ),
                    Tab(
                      text: 'APPROVED',
                    ),
                  ],
                ),
                Expanded(
                  child: Container(
                    child: TabBarView(
                      children: [
                        NewBoys(),
                        ApprovedBoys(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
