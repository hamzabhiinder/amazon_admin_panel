import 'dart:convert';
import 'dart:developer';

import 'package:admin_panel/featured/auth/screen/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constant/error_handling.dart';
import '../../../constant/global_variable.dart';
import '../../../constant/utils.dart';
import '../../../model/orderModel.dart';
import '../../../model/productModel.dart';
import '../../../provider/user_provider.dart';

class AccountService {
  //get all the data from the database
  Future<List<OrderModel>> fetchMyOrder({
    required BuildContext context,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<OrderModel> orderList = [];
    try {
      http.Response response = await http.get(
        Uri.parse('$uri/api/orders/me'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      // httpErrorHandling(
      //     response: response,
      //     context: context,
      //     onSuccess: () {
      //       for (int i = 0; i < jsonDecode(response.body).length; i++) {
      //         orderList.add(
      //           OrderModel.fromJson(
      //             jsonEncode(
      //               jsonDecode(response.body)[i],
      //             ),
      //           ),
      //         );
      //       }
      //     });

      httpErrorHandling(
        response: response,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(response.body).length; i++) {
            orderList.add(
              OrderModel.fromJson(
                jsonEncode(
                  jsonDecode(response.body.toString())[i],
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      log("Error:From Get     $e");
      showSnackBar(context, "$e");
    }
    return orderList;
  }

  void logOut(BuildContext context) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      await pref.setString("x-auth-token", "");
      Navigator.pushNamedAndRemoveUntil(
        context,
        AuthScreen.routeName,
        (route) => false,
      );
    } catch (e) {
      showSnackBar(context, "$e");
    }
  }
}
