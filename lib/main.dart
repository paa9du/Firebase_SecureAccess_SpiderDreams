import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:spider_dream/screens/HomeScreen/HomeScreen.dart';
import 'package:spider_dream/screens/LoginScreen/loginScreen.dart';
import 'package:spider_dream/screens/OnbordingScreen/onbordingScreen.dart';
import 'package:spider_dream/screens/SignUpScreen/signUpScreen.dart';
import 'package:spider_dream/screens/welcomeScreen/welcomeScreen.dart';
import 'package:spider_dream/services/authentication_repository.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((value) => Get.put(AuthenticationRepository()));
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  User? user;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: user != null ? HomeScreenMain() : LogInScreen(),
    );
  }
}
