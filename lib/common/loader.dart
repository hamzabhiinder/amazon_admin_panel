import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class ShowLoader extends ChangeNotifier {
  // bool isSignUpLoading = false;

  // void setIsSignUpLoading(bool isSignUpLoading) {
  //   this.isSignUpLoading   notifyListeners();
  //notifyListeners();

  // }

  bool isSignInLoading = false;

  void setIsSignInLoading(bool isSignInLoading) {
    this.isSignInLoading = isSignInLoading;
    notifyListeners();
  }
}
