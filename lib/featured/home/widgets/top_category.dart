import 'dart:ui';

import 'package:admin_panel/featured/home/screen/category_screen_deal.dart';
import 'package:flutter/material.dart';

import '../../../constant/global_variable.dart';

class TopCategory extends StatelessWidget {
  const TopCategory({super.key});
  void navigatorToCategoryScreen(BuildContext context, String category) {
    Navigator.pushNamed(context, CategoryScreenDeal.routeName,
        arguments: category);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemExtent: 70,
        itemCount: GlobalVariables.categoryImages.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () => navigatorToCategoryScreen(
                context, GlobalVariables.categoryImages[index]['title']!),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.asset(
                      GlobalVariables.categoryImages[index]["image"]!,
                      fit: BoxFit.cover,
                      height: 40,
                      width: 40,
                    ),
                  ),
                ),
                Text(
                  GlobalVariables.categoryImages[index]["title"]!,
                  style: const TextStyle(
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
