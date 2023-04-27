import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../../../constant/error_handling.dart';
import '../../../constant/global_variable.dart';
import '../../../constant/utils.dart';
import '../../../model/productModel.dart';
import '../../../provider/user_provider.dart';

class HomeServices {
  //get all the data from the database
  Future<List<ProductModel>> fetchCategoryProducts({
    required BuildContext context,
    required String category,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<ProductModel> productList = [];
    try {
      http.Response response = await http.get(
        Uri.parse('$uri/api/products?category=$category'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      log('For checing ${userProvider.user.token}');
      log("jsonDecode(response.body).length ${jsonDecode(response.body).length}");
      httpErrorHandling(
          response: response,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(response.body).length; i++) {
              productList.add(
                ProductModel.fromJson(
                  jsonEncode(
                    jsonDecode(response.body.toString())[i],
                  ),
                ),
              );
            }
          });
    } catch (e) {
      log("Error:From Get Products Home   $e");
      showSnackBar(context, "$e");
    }
    return productList;
  }

  //get all the deal of the day
  Future<ProductModel> fetchDealOfDay({
    required BuildContext context,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    ProductModel products = ProductModel(
      name: "",
      description: '',
      price: 0,
      quantity: 0,
      category: '',
      images: [],
    );
    try {
      http.Response response = await http.get(
        Uri.parse('$uri/api/deal-of-day'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      log("jsonDecode(response.body).length ${jsonDecode(response.body).length}");
      httpErrorHandling(
          response: response,
          context: context,
          onSuccess: () {
            products = ProductModel.fromJson(response.body);
          });
    } catch (e) {
      log("Error:From Get Products Deal of Day   $e");
      showSnackBar(context, "$e");
    }
    return products;
  }
}
