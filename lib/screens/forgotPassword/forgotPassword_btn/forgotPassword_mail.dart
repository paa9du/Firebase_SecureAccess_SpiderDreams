import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:spider_dream/screens/LoginScreen/loginScreen.dart';

class ForgotPasswordMail extends StatefulWidget {
  const ForgotPasswordMail({super.key});

  @override
  State<ForgotPasswordMail> createState() => _ForgotPasswordMailState();
}

class _ForgotPasswordMailState extends State<ForgotPasswordMail> {
  TextEditingController forgetPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: 70),
              child: const Text(
                'Forgot Password ?',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.only(left: 60),
              child: const Text(
                'You choosed Reset Password Via E-Mail.!\n Please Enter Registered E-Mail',
                textAlign: TextAlign.center,
                style: TextStyle(
                    height: 1, fontWeight: FontWeight.w700, fontSize: 15),
                // style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Form(
                child: Column(
              children: [
                TextFormField(
                  controller: forgetPasswordController,
                  decoration: InputDecoration(
                    hintText: 'E-Mail',
                    label: Text('E-Mail'),
                    prefixIcon: Icon(Icons.mail),
                    border: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(0.0),
                      ),
                      borderSide: new BorderSide(
                        color: Colors.black,
                        width: 1.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () async {
                      var forgotEmail = forgetPasswordController.text.trim();

                      try {
                        await FirebaseAuth.instance
                            .sendPasswordResetEmail(email: forgotEmail)
                            .then((value) => {
                                  print("Email Sent"),
                                  Get.off(() => LogInScreen())
                                });
                      } on FirebaseAuthException catch (e) {
                        print("Error $e");
                      }
                    },
                    style: ElevatedButton.styleFrom(primary: Colors.black),
                    child: Text(
                      'Next',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}
