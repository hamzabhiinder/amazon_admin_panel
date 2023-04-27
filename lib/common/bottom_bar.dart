import 'package:admin_panel/featured/account/screeen/account_screen.dart';
import 'package:admin_panel/featured/cart/screen/cart_screen.dart';
import 'package:admin_panel/provider/user_provider.dart';
import 'package:badges/badges.dart' as b;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constant/global_variable.dart';
import '../featured/home/screen/home_screen.dart';

class BottomBar extends StatefulWidget {
  static const String routeName = "/actual-home";
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _page = 0;
  double bottomBarWidth = 42;
  double bottomBarBorderWidth = 5;

  void updatePage(int value) {
    setState(() {
      _page = value;
    });
  }

  List pages = [
    const HomeScreen(),
    const AccountScreen(),
    const CartScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final userCartLength = context.watch<UserProvider>().user.cart.length;
    return Scaffold(
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
            label: "Home",
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
              child: const Icon(Icons.person_outline),
            ),
            label: "Profile",
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
              child: b.Badge(
                  badgeContent: Text(userCartLength.toString()),
                  badgeStyle: const b.BadgeStyle(
                    badgeColor: Colors.white,
                  ),
                  child: Icon(Icons.shopping_cart_outlined)),
            ),
            label: "Cart",
          )
        ],
      ),
    );
  }
}
