import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:get/get.dart';

import 'package:grocery_admin_project/auth/login.dart';
import 'package:grocery_admin_project/screens/category_screen.dart';
import 'package:grocery_admin_project/screens/delivery_boy_screen.dart';
import 'package:grocery_admin_project/screens/manage_banners.dart';
import 'package:grocery_admin_project/screens/settings.dart';
import 'package:grocery_admin_project/screens/vendors_screen.dart';


class SidebarWidget{

  sidebarMenus(context,selectedRoute){
    return SideBar(
      activeBackgroundColor: Colors.green,
      activeIconColor: Colors.white,
      activeTextStyle: TextStyle(color: Colors.white),
      iconColor: Colors.green,
      textStyle: TextStyle(color: Colors.green),
      items: const [
        // AdminMenuItem(
        //   title: 'Dashboard',
        //   route: HomeScreen.id,
        //   icon: CupertinoIcons.home,
        // ),
        AdminMenuItem(
          title: 'Vendors',
          route: VendorScreen.id,
          icon: CupertinoIcons.group,
        ),
        AdminMenuItem(
          title: 'Delivery Boy',
          route: DeliveryBoyScreen.id,
          icon: Icons.delivery_dining_outlined,
        ),
        AdminMenuItem(
          title: 'Banners',
          route: BannerScreen.id,
          icon: CupertinoIcons.photo,
        ),
        AdminMenuItem(
          title: 'Categories',
          route: CategoryScreen.id,
          icon: Icons.category,
        ),
        // AdminMenuItem(
        //   title: 'Orders',
        //   route: OrderScreen.id,
        //   icon: CupertinoIcons.cart_badge_plus,
        // ),
        //
        // AdminMenuItem(
        //   title: 'Admin Users',
        //   route: AdminUsersScreen.id,
        //   icon: CupertinoIcons.person_circle,
        // ),
        AdminMenuItem(
          title: 'Profile',
          route: SettingScreen.id,
          icon: CupertinoIcons.person,
        ),
      ],
      selectedRoute: selectedRoute,
      onSelected: (item) {
        if (item.route != null) {
          Navigator.of(context).pushNamed(item.route!);
        }
      },
      header: Container(
        height: 50,
        width: double.infinity,
        color: const Color(0xff306844),
        child: const Center(
          child: Text(
            'MENU',
            style: TextStyle(
              letterSpacing: 2,
              color: Colors.white,
            ),
          ),
        ),
      ),
      footer: GestureDetector(
        onTap: (){
          FirebaseAuth auth = FirebaseAuth.instance;
          auth.signOut();
          Get.offAllNamed(LoginScreen.id);
        },
        child: Container(
          height: 50,
          width: double.infinity,
          color: const Color(0xff306844),
          child: const Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 10,),
                Icon(CupertinoIcons.power,color: Colors.white,),
                SizedBox(width: 10,),
                Text(
                  'Logout',
                  style: TextStyle(
                    color: Colors.white,
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