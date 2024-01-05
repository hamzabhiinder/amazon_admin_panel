import 'package:admin_panel/constant/utils.dart';
import 'package:admin_panel/featured/auth/screen/sign_in_screen.dart';
import 'package:admin_panel/featured/auth/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/customButton.dart';
import '../../../common/custom_textfield.dart';
import '../../../common/custom_textfield_login.dart';
import '../../../common/loader.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _conPasswordController = TextEditingController();
  final AuthService authService = AuthService();

  final _signUpFormKey = GlobalKey<FormState>();

  bool isLoding = false;
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _conPasswordController.dispose();
  }

  void signUpUser() {
    authService.signUpUser(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
      name: _nameController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: SafeArea(
          child: Form(
            key: _signUpFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Center(
                  child: Text(
                    "Welcome to SportsZone",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 15),

                Container(
                    height: 300,
                    child: Image.asset('assets/images/signup.jpg')),
                // const Image(
                //   image: AssetImage("assets/images/signup.jpg"),
                //   height: 400,
                // ),
                const SizedBox(height: 15),

                CustomTextFieldLogin(
                  controller: _nameController,
                  hintText: 'Name',
                ),
                const SizedBox(height: 15),
                CustomTextFieldLogin(
                  controller: _emailController,
                  hintText: 'Email',
                ),
                const SizedBox(height: 15),
                CustomTextFieldLogin(
                  controller: _passwordController,
                  hintText: 'Password',
                  obsecureText: true,
                ),
                const SizedBox(height: 15),
                CustomTextFieldLogin(
                  controller: _conPasswordController,
                  hintText: 'Confirm Password',
                  obsecureText: true,
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: CustomButton(
                    //color: GlobalVariables.secondaryColor,
                    text: 'Register',
                    isLoading: Provider.of<ShowLoader>(context, listen: false)
                        .isSignInLoading,
                    onTap: () {
                      if (_signUpFormKey.currentState!.validate()) {
                        if (_passwordController.text !=
                            _conPasswordController.text) {
                          return showSnackBar(
                              context, "Password does not match");
                        }
                        signUpUser();
                        // _emailController.text = "";
                        // _passwordController.text = "";
                        // _conPasswordController.text = "";

                        // _nameController.text = "";
                      }
                    },
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have a account ? ",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => LoginScreen()),
                        );
                      },
                      child: const Text(
                        "Sign in",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
