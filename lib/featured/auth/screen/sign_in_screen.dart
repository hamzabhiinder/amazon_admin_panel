import 'package:admin_panel/featured/auth/screen/register_screen.dart';
import 'package:admin_panel/featured/auth/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/customButton.dart';
import '../../../common/custom_textfield.dart';
import '../../../common/custom_textfield_login.dart';
import '../../../common/loader.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const String routeName = '/login-screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final AuthService authService = AuthService();

  final _signInFormKey = GlobalKey<FormState>();

  bool isLoding = false;
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void signInUser() {
    authService.signInUser(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    final showLoader = Provider.of<ShowLoader>(context).isSignInLoading;
    return Scaffold(
      //  backgroundColor: Colors.grey[200],

      body: SingleChildScrollView(
        child: Form(
          key: _signInFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Image(
                    height: 200,
                    width: 200,
                    image: AssetImage("assets/images/shapes.png")),
              ),
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
                  height: 250, child: Image.asset('assets/images/signin.png')),
              // const Image(
              //   image: AssetImage("assets/images/signup.jpg"),
              //   height: 400,
              // ),
              const SizedBox(height: 15),

              CustomTextFieldLogin(
                controller: _emailController,
                hintText: 'Email',
              ),
              const SizedBox(height: 15),
              CustomTextFieldLogin(
                obsecureText: true,
                controller: _passwordController,
                hintText: 'Password',
              ),
              const SizedBox(height: 15),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: CustomButton(
                  //color: GlobalVariables.secondaryColor,
                  text: 'Sign In',
                  isLoading: showLoader,
                  onTap: () {
                    if (_signInFormKey.currentState!.validate()) {
                      signInUser();
                    }
                  },
                ),
              ),
              const SizedBox(height: 15),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => SignUpScreen()),
                  );
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don\'t have a account ? ",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "Sign Up",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
