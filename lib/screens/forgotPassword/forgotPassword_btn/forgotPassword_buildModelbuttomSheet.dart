import 'package:flutter/material.dart';
import 'package:spider_dream/screens/forgotPassword/forgotPassword_btn/forgotPassword_mail.dart';

import 'forgotPasswordBtnWidget.dart';
import 'package:get/get.dart';

import 'forgotPassword_Phone.dart';

class ForgotPasswordScreen {
  static Future<dynamic> forgotPassword_buildModelbuttomSheet(
      BuildContext context) {
    return showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      builder: (context) => Container(
        padding: EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Make Selection!',
              style: Theme.of(context).textTheme.headline5,
            ),
            Text(
                'Select one of the options given below to reset your password.',
                style: Theme.of(context).textTheme.bodyText2),
            SizedBox(
              height: 30.0,
            ),
            forgotPasswordBtnWidget(
              btnIcon: Icons.mail_outline_rounded,
              title: 'E-Mail',
              subtitle: 'Reset via E-Mail Verification',
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ForgotPasswordMail(),
                  ),
                );
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            Center(child: Form(child: Text('Or'))),
            SizedBox(
              height: 20.0,
            ),
            forgotPasswordBtnWidget(
              btnIcon: Icons.phone_android_rounded,
              title: 'Phone Number',
              subtitle: 'LogIn with Phone Number',
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ForgotPasswordPhone(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
