// import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';

// import '../../constant/global_variable.dart';

// class SplashScreen extends StatefulWidget {
//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _animation;

//   @override
//   void initState() {
//     super.initState();

//     // Create an animation controller with vsync
//     _controller = AnimationController(
//       duration: const Duration(seconds: 2),
//       vsync: this,
//     );

//     // Create a curved animation
//     _animation = CurvedAnimation(
//       parent: _controller,
//       curve: Curves.easeInOut,
//     );

//     // Start the animation
//     _controller.forward();

//     // Schedule navigation to the next screen after the animation completes
//     SchedulerBinding.instance.addPostFrameCallback((_) {
//       _controller.addStatusListener((status) {
//         if (status == AnimationStatus.completed) {
//           // Replace `NextScreen()` with your desired screen to navigate to
//           Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(builder: (context) => NextScreen()),
//           );
//         }
//       });
//     });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: FadeTransition(
//         opacity: _animation,
//         child: Container(
//           color: GlobalVariables.secondaryColor,
//           child: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Image.asset(
//                     'assets/images/splash.png'), // Replace with your first image
//                 SizedBox(height: 20),
//                 Image.asset(
//                     'assets/images/sport_wear.png'), // Replace with your second image
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:async';
import 'dart:developer' as devtools show log;

import 'package:admin_panel/featured/auth/screen/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/bottom_bar.dart';
import '../../provider/user_provider.dart';
import '../admin/screen/admin_screen.dart';
import '../auth/screen/auth_screen.dart';

class NextScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Next Screen'),
      ),
      body: Center(
        child: Text('Welcome to the Next Screen!'),
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    Key? key,
  }) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _logoAnimation;
  late Animation<double> _textAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize animation controller
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    // Logo animation
    _logoAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0, 0.5, curve: Curves.easeIn),
      ),
    );

    // Text animation
    _textAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.5, 1, curve: Curves.easeIn),
      ),
    );

    // Start the animation
    _controller.forward();

    // Delay for 2 seconds and then navigate to the login screen
    Timer(Duration(seconds: 5), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => Authentication()));
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromARGB(255, 194, 21, 21),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FadeTransition(
                opacity: _logoAnimation,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: Offset(0, 0.5),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(
                      parent: _controller,
                      curve: Interval(0, 0.5, curve: Curves.easeIn),
                    ),
                  ),
                  child: Image.asset(
                    'assets/images/splash.png',
                    width: 500,
                    height: 300,
                  ),
                ),
              ),
              SizedBox(height: 16),
              FadeTransition(
                opacity: _textAnimation,
                child: SlideTransition(
                    position: Tween<Offset>(
                      begin: Offset(0, 0.5),
                      end: Offset.zero,
                    ).animate(
                      CurvedAnimation(
                        parent: _controller,
                        curve: Interval(0.5, 1, curve: Curves.easeIn),
                      ),
                    ),
                    child: Image.asset('assets/images/sport_wear.png')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class Authentication extends StatefulWidget {
//   const Authentication({super.key});

//   @override
//   State<Authentication> createState() => _AuthenticationState();
// }

// class _AuthenticationState extends State<Authentication> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: FutureBuilder(
//         builder: (context, snapshot) {
//           switch (snapshot.connectionState) {
//             case ConnectionState.done:
//               if (Provider.of<UserProvider>(context).user.token.isNotEmpty) {
//                 if (Provider.of<UserProvider>(context).user.type == "user") {
//                   devtools.log(" VERIFY EMAIL ");
//                   return BottomBar();
//                 } else {
//                   devtools.log("NOt VERIFY EMAIL");
//                   return const AdminScreen();
//                 }
//               } else {
//                 return LoginScreen();
//               }

//             default:
//               return const CircularProgressIndicator();
//           }
//         },
//       ),
//     );
//   }
// }

class Authentication extends StatefulWidget {
  const Authentication({Key? key}) : super(key: key);

  @override
  State<Authentication> createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  bool _showSplash = true; // Flag to control showing the splash screen

  @override
  void initState() {
    super.initState();
    // Simulate a delay for the splash screen (e.g., 2 seconds)
    Future.delayed(const Duration(seconds: 0), () {
      setState(() {
        _showSplash = false; // Update the flag to hide the splash screen
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _showSplash ? _buildSplashScreen() : _buildAuthenticationScreen(),
    );
  }

  Widget _buildSplashScreen() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildAuthenticationScreen() {
    return FutureBuilder(
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            if (Provider.of<UserProvider>(context).user.token.isNotEmpty) {
              if (Provider.of<UserProvider>(context).user.type == "user") {
                devtools.log("VERIFY EMAIL");
                return BottomBar();
              } else {
                devtools.log("NOT VERIFY EMAIL");
                return const AdminScreen();
              }
            } else {
              return const LoginScreen();
            }
          default:
            return const SizedBox();
        }
      },
      future: _checkAuthentication(),
    );
  }

  Future<void> _checkAuthentication() async {
    await Future.delayed(const Duration(seconds: 0));
    // Perform your authentication check here
  }
}
