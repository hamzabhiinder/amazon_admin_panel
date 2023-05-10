import 'package:admin_panel/featured/admin/screen/analytic_screen.dart';
import 'package:admin_panel/featured/admin/screen/order_Screen.dart';
import 'package:admin_panel/featured/admin/screen/post_screen.dart';
import 'package:badges/badges.dart' as b;
import 'package:flutter/material.dart';

import '../../../constant/global_variable.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  int _page = 0;
  double bottomBarWidth = 42;
  double bottomBarBorderWidth = 5;

  void updatePage(int value) {
    setState(() {
      _page = value;
    });
  }

  List pages = [
    const PostsScreen(),
    AnalyticalScreen(),
    OrderScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: Image.asset(
                  "assets/images/amazon_in.png",
                  width: 120,
                  height: 45,
                  color: Colors.black,
                ),
              ),
              const Text(
                "Admin",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                  color: Colors.black,
                ),
              )
            ],
          ),
        ),
      ),
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        selectedItemColor: GlobalVariables.selectedNavBarColor,
        unselectedItemColor: GlobalVariables.unselectedNavBarColor,
        iconSize: 28,
        onTap: updatePage,
        items: [
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(
                        color: _page == 0
                            ? GlobalVariables.selectedNavBarColor
                            : Colors.transparent,
                        width: bottomBarBorderWidth)),
              ),
              child: const Icon(Icons.home_outlined),
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                      color: _page == 1
                          ? GlobalVariables.selectedNavBarColor
                          : Colors.transparent,
                      width: bottomBarBorderWidth),
                ),
              ),
              child: const Icon(Icons.analytics_outlined),
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(
                        color: _page == 2
                            ? GlobalVariables.selectedNavBarColor
                            : Colors.transparent,
                        width: bottomBarBorderWidth)),
              ),
              child: const b.Badge(
                  badgeContent: Text("2"),
                  badgeStyle: b.BadgeStyle(
                    badgeColor: Colors.white,
                  ),
                  child: Icon(Icons.all_inbox_outlined)),
            ),
            label: "",
          )
        ],
      ),
    );
  }
}
