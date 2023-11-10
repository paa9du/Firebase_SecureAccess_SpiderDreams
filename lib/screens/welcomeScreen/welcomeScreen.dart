import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:spider_dream/components/background.dart';
import 'package:spider_dream/screens/LoginScreen/loginScreen.dart';
import 'package:spider_dream/screens/OnbordingScreen/onbordingScreen.dart';
import 'package:spider_dream/screens/SignUpScreen/signUpScreen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    Future.delayed(const Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => const OnBordingScreen(),
        ),
      );
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.red,
              Colors.orange,
              Colors.grey,
              Colors.yellow,
              Colors.green,
              Colors.blue,
              Colors.indigo,
              Colors.pinkAccent,
              Colors.black,
              Colors.white,
            ],
            // stops: [0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('asset/spider.json',
                height: 300, reverse: true, repeat: true, fit: BoxFit.cover),
            Center(
              child: TweenAnimationBuilder(
                curve: Curves.bounceOut,
                duration: const Duration(seconds: 4),
                tween: Tween<double>(begin: 15.0, end: 30.0),
                builder: (BuildContext context, dynamic value, Widget? child) {
                  return Text(
                    'Spider Dreams',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: value,
                        color: Colors.limeAccent),
                  );
                },
              ),
            ),

            // const SizedBox(
            //   height: 150,
            // ),
            // ElevatedButton(
            //   onPressed: () {},
            //   child: const Text(
            //     'Get Started',
            //     style: TextStyle(
            //         fontSize: 30,
            //         backgroundColor: Colors.white,
            //         color: Colors.black),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
