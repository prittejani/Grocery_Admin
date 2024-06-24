
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:grocery_admin_project/services/sidebar.dart';
import 'package:grocery_admin_project/utils/widgets/category/category_card_widget.dart';
import 'package:grocery_admin_project/utils/widgets/category/category_list_widget.dart';
import 'package:grocery_admin_project/utils/widgets/category/category_upload_widget.dart';

class CategoryScreen extends StatelessWidget {
  static const String id = 'category-screen';
   CategoryScreen({super.key});

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
      sideBar: _sidebarWidget.sidebarMenus(context, CategoryScreen.id),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.all(10),
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Categories',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 36,
                ),
              ),
              Text('Add New Categories and Sub Categories'),
              Divider(thickness: 5,),
              CategoryCreateWidget(),
              Divider(thickness: 5,),
              CategoryListWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
