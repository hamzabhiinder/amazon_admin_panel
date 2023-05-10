import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:admin_panel/constant/error_handling.dart';
import 'package:admin_panel/model/orderModel.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../../constant/global_variable.dart';
import '../../../constant/utils.dart';
import '../../../model/productModel.dart';
import '../../../provider/user_provider.dart';
import '../model/sale_model.dart';

class AdminServices {
  void sellProduct({
    required BuildContext context,
    required String name,
    required String description,
    required double price,
    required double quantity,
    required String category,
    required List<File> images,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      final cloudinary = CloudinaryPublic('dfoqnku2j', 'p5zszud7');
      List<String> imageUrl = [];

      for (int i = 0; i < images.length; i++) {
        CloudinaryResponse res = await cloudinary
            .uploadFile(CloudinaryFile.fromFile(images[i].path, folder: name));
        imageUrl.add(res.secureUrl);
      }

      ProductModel productModel = ProductModel(
        name: name,
        description: description,
        price: price,
        quantity: quantity,
        category: category,
        images: imageUrl,
      );

      http.Response res = await http.post(
        Uri.parse("$uri/admin/add-products"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: productModel.toJson(),
      );
      log("Response: ${res.statusCode}");
      httpErrorHandling(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(context, "Product Added Success");
            Navigator.pop(context);
          });
    } catch (e) {
      log("Error: $e");
      showSnackBar(context, "$e");
    }
  }

  //get all the data from the database
  Future<List<ProductModel>> fetchAllProduct(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<ProductModel> productList = [];
    try {
      http.Response response = await http.get(
        Uri.parse('$uri/admin/get-products'),
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
      log("Error:From Get Products   $e");
      showSnackBar(context, "$e");
    }
    return productList;
  }

  //delete products

  void deleteProduct(
      {required BuildContext context,
      required ProductModel productModel,
      required VoidCallback onSuccess}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response response = await http.post(
        Uri.parse('$uri/admin/delete-product'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'id': productModel.id,
        }),
      );

      httpErrorHandling(
          response: response, context: context, onSuccess: onSuccess);
    } catch (e) {
      log("Error:From Delete Products   $e");
      showSnackBar(context, "$e");
    }
  }

  Future<List<OrderModel>> fetchAllOrder(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<OrderModel> orderList = [];
    try {
      http.Response response = await http.get(
        Uri.parse('$uri/admin/get-orders'),
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
              orderList.add(
                OrderModel.fromJson(
                  jsonEncode(
                    jsonDecode(response.body.toString())[i],
                  ),
                ),
              );
            }
          });
    } catch (e) {
      log("Error:From Get Products   $e");
      showSnackBar(context, "$e");
    }
    return orderList;
  }

  void changeOrderStatus(
      {required BuildContext context,
      required int status,
      required OrderModel order,
      required VoidCallback onSuccess}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response response = await http.post(
        Uri.parse('$uri/admin/change-order-status'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'id': order.id,
          'status': status,
        }),
      );

      httpErrorHandling(
        response: response,
        context: context,
        onSuccess: onSuccess,
      );
    } catch (e) {
      log("Error:From Delete Products   $e");
      showSnackBar(context, "$e");
    }
  }

  Future<Map<String, dynamic>> getEarning(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Sales> sales = [];
    int totalEarning = 0;
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/admin/analytics'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      httpErrorHandling(
          response: res,
          context: context,
          onSuccess: () {
            var response = jsonDecode(res.body);
            totalEarning = response['totalEarnings'];
            sales = [
              Sales(label: "Mobiles", earning: response['mobileEarning']),
              Sales(label: "Essentials", earning: response['essentialEarning']),
              Sales(label: "Appliances", earning: response['applianceEarning']),
              Sales(label: "Books", earning: response['bookEarning']),
              Sales(label: "Fashion", earning: response['fashionEarning']),
            ];
          });
    } catch (e) {
      log("Error:From Get Products   $e");
      showSnackBar(context, "$e");
    }

    return {
      'sales': sales,
      'totalEarning': totalEarning,
    };
  }
}
