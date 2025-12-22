import 'package:eventhub/controller/AuthController.dart';
import 'package:eventhub/controller/Create_event%20_controller.dart';
import 'package:eventhub/controller/Image_controller.dart';
import 'package:eventhub/controller/eventList_controller.dart';
import 'package:eventhub/firebase_options.dart';
import 'package:eventhub/screens/HomeScreen.dart';
import 'package:eventhub/screens/event-screen.dart';
import 'package:eventhub/screens/forgotPassword.dart';
import 'package:eventhub/screens/loginScreen.dart';
import 'package:eventhub/screens/signUpScreen.dart';
import 'package:eventhub/screens/splashScreen.dart';
import 'package:eventhub/service/cloudinary_service.dart';
import 'package:eventhub/service/firebase_services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:sublime/controller/AuthController.dart';
// import 'package:sublime/controller/Create_event%20_controller.dart';
// import 'package:sublime/controller/Image_controller.dart';
// import 'package:sublime/controller/event_controller.dart';
//import 'package:sublime/firebase_options.dart';
// import 'package:sublime/screens/HomeScreen.dart';
// import 'package:sublime/screens/event-screen.dart';
// import 'package:sublime/screens/forgotPassword.dart';
// import 'package:sublime/screens/loginScreen.dart';
// import 'package:sublime/screens/signUpScreen.dart';
// import 'package:sublime/screens/splashScreen.dart';
// import 'package:sublime/service/cloudinary_service.dart';
// import 'package:sublime/service/firebase_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e, st) {
    // Log initialization errors to help diagnose platform channel failures
    // (e.g., native plugin registration issues, missing configuration).
    debugPrint('Firebase.initializeApp error: $e');
    debugPrint('$st');
  }
  Get.put(AuthController());
  Get.put(CloudinaryService());
  Get.put(FirebaseService());
  Get.put(EventsController());
  Get.put(EventController());
  Get.put(ImageController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Firebase App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
      getPages: [
        GetPage(name: '/', page: () => const SplashScreen()),
        GetPage(name: '/login', page: () => LoginPage()),
        GetPage(name: '/signup', page: () => SignupPage()),
        GetPage(name: '/forgot_password', page: () => ForgotPasswordPage()),
        GetPage(name: '/home', page: () => HomeScreen()),
        GetPage(name: '/event', page: () => EventsScreen()),
      ],
    );
  }
}
