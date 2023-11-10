import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:spider_dream/screens/HomeScreen/HomeScreen.dart';
import 'package:spider_dream/screens/LoginScreen/loginScreen.dart';
import '../../services/OtpController.dart';

class OTPScreen extends StatelessWidget {
  const OTPScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var otpController = Get.put(OTPController());
    var otp;
    return Scaffold(
        body: Container(
      padding: EdgeInsets.all(15),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          'OTP Code',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline1,
        ),
        Text(
          'OTP Sent To Your E-Mail',
        ),
        OTPTextField(
          length: 6,
          width: MediaQuery.of(context).size.width,
          fieldWidth: 50,
          style: TextStyle(fontSize: 17),
          textFieldAlignment: MainAxisAlignment.spaceAround,
          fieldStyle: FieldStyle.underline,

          onCompleted: (pin) {
            print("Completed: " + pin);
            onSubmit:
            (code) {
              // print("otp is => $code");
              otp = code;
              OTPController.instance.verifyOTp(otp);
            };
          },
          // keyboardType: TextInputType.,
        ),
        SizedBox(
          height: 20.0,
        ),
        SizedBox(
          width: double.infinity,
        ),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  OTPController.instance.verifyOTp(otp);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreenMain(),
                    ),
                  );
                },
                child: Text('Next'),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Expanded(
                child: ElevatedButton(
              child: Text('Cancle'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LogInScreen(),
                  ),
                );
              },
            ))
          ],
        ),
      ]),
    ));
  }
}
