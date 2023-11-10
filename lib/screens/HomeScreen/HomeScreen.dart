import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:spider_dream/screens/LoginScreen/loginScreen.dart';

class HomeScreenMain extends StatefulWidget {
  const HomeScreenMain({super.key});

  @override
  State<HomeScreenMain> createState() => _HomeScreenMainState();
}

class _HomeScreenMainState extends State<HomeScreenMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('lovers'),
        actions: [
          GestureDetector(
            onTap: () {
              // FirebaseAuth.instance.signOut();
              Get.off(() => LogInScreen());
            },
            child: Icon(Icons.logout),
          ),
        ],
      ),
    );
  }
}
