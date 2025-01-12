// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:sublime/controller/AuthServices.dart';
// import 'package:sublime/screens/HomeScreen.dart';
// import 'package:sublime/screens/loginScreen.dart';
// // replace with your login page

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({Key? key}) : super(key: key);

//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   final AuthService _authService = AuthService();

//   @override
//   void initState() {
//     super.initState();
//     _checkAuthState();
//   }

//   // Check user's auth state
//   Future<void> _checkAuthState() async {
//     final prefs = await SharedPreferences.getInstance();
//     final userState = prefs.getString('userState');

//     if (userState == 'logged_in') {
//       // If user is logged in, navigate to home page
//       navigateToHomePage();
//     } else {
//       // If user is not logged in, navigate to login page
//       navigateToLoginPage();
//     }
//   }

//   // Navigate to home page
//   void navigateToHomePage() {
//     Future.delayed(Duration(seconds: 8), () {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => HomeScreen()),
//       );
//     });
//   }

//   // Navigate to login page
//   void navigateToLoginPage() {
//     Future.delayed(Duration(seconds: 8), () {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => LoginPage()),
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [Colors.blue[100]!, Colors.white],
//           ),
//         ),
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               CircularProgressIndicator(
//                 valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
//               ),
//               const SizedBox(height: 20),
//               Text(
//                 'Welcome',
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.blue[900],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:eventhub/controller/AuthServices.dart';
import 'package:eventhub/screens/HomeScreen.dart';
import 'package:eventhub/screens/loginScreen.dart';
import 'package:eventhub/utils/Theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _checkAuthState();
  }

  void _setupAnimations() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _controller.forward();
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
        decoration: BoxDecoration(gradient: AppColors.primaryGradient),
        child: Center(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.secondaryWhite.withOpacity(0.1),
                    border: Border.all(
                      color: AppColors.secondaryWhite.withOpacity(0.2),
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primaryDeepPurple.withOpacity(0.2),
                        blurRadius: 20,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.event,
                    size: 80,
                    color: AppColors.secondaryWhite,
                  ),
                ),
                SizedBox(height: 30),
                Text(
                  'EventHub',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: AppColors.secondaryWhite,
                    letterSpacing: 2,
                    shadows: [
                      Shadow(
                        color: AppColors.primaryDeepPurple.withOpacity(0.5),
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  width: 40,
                  height: 40,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppColors.secondaryWhite,
                    ),
                    strokeWidth: 3,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _checkAuthState() async {
    final prefs = await SharedPreferences.getInstance();
    final userState = prefs.getString('userState');

    await Future.delayed(Duration(seconds: 3));

    if (userState == 'logged_in') {
      Get.offAll(() => HomeScreen());
    } else {
      Get.offAll(() => LoginPage());
    }
  }
}
