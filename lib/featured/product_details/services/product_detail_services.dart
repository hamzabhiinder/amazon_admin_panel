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

class ProductDetailsServices {
  // Future<List<ProductModel>> rateProduct({
  //   required BuildContext context,
  //   required ProductModel product,
  //   required double rating,
  // }) async {
  //   final userProvider = Provider.of<UserProvider>(context, listen: false);
  //   List<ProductModel> productList = [];
  //   try {
  //     http.Response response =
  //         await http.post(Uri.parse('$uri/api/rate-product'),
  //             headers: <String, String>{
  //               'Content-Type': 'application/json; charset=UTF-8',
  //               'x-auth-token': userProvider.user.token,
  //             },
  //             body: jsonEncode({"id": product.id!, 'rating': rating}));
  //     httpErrorHandling(response: response, context: context, onSuccess: () {});
  //   } catch (e) {
  //     log("Error:From post rating  Screen  $e");
  //     showSnackBar(context, "$e");
  //   }
  //   return productList;
  // }

  void rateProduct({
    required BuildContext context,
    required ProductModel product,
    required double rating,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/rate-product'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'id': product.id!,
          'rating': rating,
        }),
      );

      log("Response from rating service ${res.statusCode}  or ${res.body}");

      httpErrorHandling(
        response: res,
        context: context,
        onSuccess: () {},
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
