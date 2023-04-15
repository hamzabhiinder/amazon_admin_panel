import 'dart:convert';
import 'dart:developer';

import 'package:admin_panel/constant/error_handling.dart';
import 'package:admin_panel/constant/global_variable.dart';
import 'package:flutter/material.dart';

import '../../../constant/utils.dart';
import '../../../model/userModel.dart';
import 'package:http/http.dart' as http;

class AuthService {
  //signUp User

  void signUpUser({
    required String email,
    required String password,
    required String name,
    required BuildContext context,
  }) async {
    try {
      User user = User(
        id: "",
        name: name,
        email: email,
        password: password,
        address: "",
        type: "",
        token: "",
      );

      http.Response response = await http.post(
        Uri.parse("$uri/api/signup"),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      log("From Sign Up ${response.statusCode}");
      // ignore: use_build_context_synchronously
      httpErrorHandling(
        response: response,
        context: context,
        onSuccess: () {
          showSnackBar(
            context,
            'Account created! Login with the same credentials!',
          );
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void signInUser({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      http.Response response = await http.post(
        Uri.parse("$uri/api/signin"),
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      log("From Sign Up ${response.statusCode}");
      // ignore: use_build_context_synchronously
      httpErrorHandling(
        response: response,
        context: context,
        onSuccess: () {
          showSnackBar(
            context,
            'Sucessfull! Login with the same credentials!',
          );
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
