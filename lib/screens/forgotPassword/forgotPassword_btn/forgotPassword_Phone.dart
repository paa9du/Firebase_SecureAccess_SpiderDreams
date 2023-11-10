import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:spider_dream/services/signUpController.dart';

import '../../OTPScreen/otp_Screen.dart';

class ForgotPasswordPhone extends StatelessWidget {
  const ForgotPasswordPhone({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
    final _formkey = GlobalKey<FormState>();

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
              margin: EdgeInsets.only(left: 30),
              child: const Text(
                'You choosed Reset Password Via Phone Number.!\n Please Enter Registered Number',
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
                key: _formkey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: controller.phoneNo,
                      decoration: InputDecoration(
                        hintText: 'Phone Number',
                        label: Text('Phone Number'),
                        prefixIcon: Icon(Icons.phone_android),
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
                        onPressed: () {
                          if (_formkey.currentState!.validate()) {
                            SignUpController.instance.phoneAuthentication(
                                controller.phoneNo.text.trim());
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OTPScreen(),
                              ),
                            );
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
