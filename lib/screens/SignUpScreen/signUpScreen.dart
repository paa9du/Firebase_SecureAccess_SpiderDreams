import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:spider_dream/config/palette.dart';
import 'package:spider_dream/screens/HomeScreen/HomeScreen.dart';
import 'package:spider_dream/screens/LoginScreen/loginScreen.dart';
import 'package:spider_dream/screens/OTPScreen/otp_Screen.dart';
import 'package:spider_dream/services/SignUpServices.dart';
import 'package:spider_dream/services/signUpController.dart';

import '../../Animations/fadeAnimation.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  //SignUpController for phoneAuthentication
  final controller = Get.put(SignUpController());
  final _formkey = GlobalKey<FormState>();

//Google login
  Future<void> signInWithGoogle() async {
    //create an instance of the firebase auth and google signin
    FirebaseAuth auth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();
    //triger the authentication flow
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    //obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    //ceate a new credentials
    final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

    //sign in the user with the credentials
    final UserCredential userCredential =
        await auth.signInWithCredential(credential);
  }

  TextEditingController usernameController = TextEditingController();
  TextEditingController userphoneController = TextEditingController();
  TextEditingController useremailController = TextEditingController();
  TextEditingController userpasswordController = TextEditingController();
  TextEditingController usergenderController = TextEditingController();

  User? currentUser = FirebaseAuth.instance.currentUser;

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  void _submitform() {
    if (formkey.currentState!.validate()) {
      ScaffoldMessenger.of(formkey.currentContext!).showSnackBar(
          const SnackBar(content: Text('Form Submitted Successfully')));
    }
  }

  String? _validateEmail(value) {
    if (value!.isEmpty) {
      return 'Please Enter an Email';
    }
    RegExp emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegExp.hasMatch(value)) {
      return 'Please Enter a valid Email';
    }
    return null;
  }

  String? _validphonenumber(value) {
    if (value!.isEmpty) {
      return 'Please Enter a Phone Number';
    }
    if (value.length != 13) {
      return 'Please Enter a 10 digit phone Number with country code';
    }
    return null;
  }

  // final passController = TextEditingController();

  String? _validpassword(value) {
    if (value!.isEmpty) {
      return 'Please Enter Password';
    } else if (value.length <= 6) {
      return 'Correct Password More than 6 Characters';
    } else {
      return null;
    }
  }

  bool isMale = true;
  bool isSignupScreen1 = true;
  bool isRememberMe = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.backgroundColor,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: Container(
              height: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('asset/images/signUpScreen/background.jpg'),
                  fit: BoxFit.fill,
                ),
              ),
              child: Container(
                padding: EdgeInsets.only(top: 90, left: 20),
                color: Color(0xFF3b5999).withOpacity(0.85),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                          text: 'Welcome To',
                          style: TextStyle(
                            fontSize: 25,
                            letterSpacing: 2,
                            color: Colors.yellow[700],
                          ),
                          children: [
                            TextSpan(
                              text: ' Spider Dreams,',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.yellow[700],
                              ),
                            ),
                          ]),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    const Text(
                      'SignUp To Continue',
                      style: TextStyle(
                        letterSpacing: 1,
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 200,
            child: Container(
              height: 450,
              padding: EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width - 40,
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 15,
                    spreadRadius: 15,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LogInScreen(),
                            ),
                          );
                          setState(() {
                            isSignupScreen1 = false;
                          });
                        },
                        child: Column(
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LogInScreen()),
                                );
                              },
                              child: const Text(
                                'LOGIN',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: !true
                                        ? Palette.textColor1
                                        : Palette.activeColor),
                              ),
                            ),
                            if (!isSignupScreen1)
                              Container(
                                margin: EdgeInsets.only(top: 3),
                                height: 2,
                                width: 55,
                                color: Colors.orange,
                              )
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isSignupScreen1 = true;
                          });
                        },
                        child: Column(
                          children: [
                            const Text(
                              'SIGNUP',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: true
                                      ? Palette.activeColor
                                      : Palette.textColor1),
                            ),
                            if (isSignupScreen1)
                              Container(
                                margin: EdgeInsets.only(top: 3),
                                height: 2,
                                width: 55,
                                color: Colors.orange,
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  FadeAnimation(
                    1,
                    Form(
                      key: formkey,
                      child: Container(
                        child: Container(
                          padding: EdgeInsets.only(bottom: 8),
                          margin: EdgeInsets.only(top: 20),
                          child: Column(
                            children: [
                              TextFormField(
                                controller: usernameController,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.person,
                                    color: Palette.iconColor,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Palette.textColor1),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(35.0),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Palette.textColor1),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(35.0),
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.all(10),
                                  hintText: "User Name",
                                  hintStyle: TextStyle(
                                      fontSize: 14, color: Palette.textColor1),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please Enter Valid Name';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Form(
                                key: _formkey,
                                child: TextFormField(
                                  controller: controller.phoneNo,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  decoration: const InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.phone,
                                      color: Palette.iconColor,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Palette.textColor1),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(35.0),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Palette.textColor1),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(35.0),
                                      ),
                                    ),
                                    contentPadding: EdgeInsets.all(10),
                                    hintText: "Phone Number",
                                    hintStyle: TextStyle(
                                        fontSize: 14,
                                        color: Palette.textColor1),
                                  ),
                                  validator: _validphonenumber,
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              TextFormField(
                                controller: useremailController,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.email,
                                    color: Palette.iconColor,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Palette.textColor1),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(35.0),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Palette.textColor1),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(35.0),
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.all(10),
                                  hintText: "Email",
                                  hintStyle: TextStyle(
                                      fontSize: 14, color: Palette.textColor1),
                                ),
                                validator: _validateEmail,
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                controller:
                                    userpasswordController, //passController,
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.fingerprint,
                                    color: Palette.iconColor,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Palette.textColor1),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(35.0),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Palette.textColor1),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(35.0),
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.all(10),
                                  hintText: "Password",
                                  hintStyle: TextStyle(
                                      fontSize: 14, color: Palette.textColor1),
                                ),
                                validator: _validpassword,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  FadeAnimation(
                    1,
                    Container(
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isMale = true;
                              });
                            },
                            child: Row(
                              children: [
                                Container(
                                  width: 30,
                                  height: 30,
                                  margin: EdgeInsets.only(right: 8),
                                  decoration: BoxDecoration(
                                      color: isMale
                                          ? Palette.textColor2
                                          : Colors.transparent,
                                      border: Border.all(
                                          width: 1,
                                          color: isMale
                                              ? Colors.transparent
                                              : Palette.textColor1),
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Icon(
                                    Icons.male_rounded,
                                    color: isMale
                                        ? Colors.white
                                        : Palette.iconColor,
                                  ),
                                ),
                                Text(
                                  "Male",
                                  style: TextStyle(color: Palette.textColor1),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isMale = false;
                              });
                            },
                            child: Row(
                              children: [
                                Container(
                                  width: 30,
                                  height: 30,
                                  margin: EdgeInsets.only(right: 8),
                                  decoration: BoxDecoration(
                                      color: isMale
                                          ? Colors.transparent
                                          : Palette.textColor2,
                                      border: Border.all(
                                          width: 1,
                                          color: isMale
                                              ? Palette.textColor1
                                              : Colors.transparent),
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Icon(
                                    Icons.female_rounded,
                                    color: isMale
                                        ? Palette.iconColor
                                        : Colors.white,
                                  ),
                                ),
                                Text(
                                  "Female",
                                  style: TextStyle(color: Palette.textColor1),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  FadeAnimation(
                    1,
                    Container(
                      width: 200,
                      margin: EdgeInsets.only(top: 10),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            text: "By Pressing 'submit' you agree to our ",
                            style: TextStyle(color: Palette.textColor2),
                            children: [
                              TextSpan(
                                  text: "terms & conditions",
                                  style: TextStyle(color: Colors.orange))
                            ]),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            top: 620,
            right: 0,
            left: 0,
            child: Center(
              child: Container(
                height: 90,
                width: 90,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(.3),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: Offset(0, 1))
                    ]),
                child: ElevatedButton(
                  onPressed: _submitform,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.orange, Colors.red],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.3),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    child: GestureDetector(
                      onTap: () async {
                        var username = usernameController.text.trim();
                        var userphone = userphoneController.text.trim();
                        var useremail = useremailController.text.trim();
                        var userpassword = userpasswordController.text.trim();

                        try {
                          await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                                  email: useremail, password: userpassword)
                              .then((value) => {
                                    log("User Created"),
                                    signUpUser(username, userphone, useremail,
                                        userpassword),
                                  });
                        } catch (signUpError) {
                          if (signUpError is PlatformException) {
                            if (signUpError.code ==
                                'ERROR_EMAIL_ALREADY_IN_USE') {
                              /// `foo@bar.com` has alread been registered.
                            }
                          }
                        }

                        if (_formkey.currentState!.validate()) {
                          SignUpController.instance.phoneAuthentication(
                              controller.phoneNo.text.trim());
                        }
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OTPScreen(),
                          ),
                        );
                        setState(() {
                          isSignupScreen1 = false;
                        });
                      },
                      child: Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height - 150,
            right: 20,
            left: 20,
            child: Column(
              children: [
                Text("Or SignUp With"),
                SizedBox(
                  height: 10,
                ),
                FadeAnimation(
                  1,
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () async {
                            await signInWithGoogle();
                            if (mounted) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => HomeScreenMain(),
                                ),
                              );
                            }
                          },
                          icon: SvgPicture.asset(
                            'asset/images/loginscreen/g_logo.svg',
                            width: 20,
                            color: Colors.white,
                          ),
                          label: const Text(
                            'Sign-In with Google',
                            maxLines: 1,
                            textAlign: TextAlign.left,
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                          style: ElevatedButton.styleFrom(
                            // fixedSize: Size.fromHeight(45),
                            // padding: const EdgeInsets.symmetric(
                            //     horizontal: 20.0, vertical: 10.0),
                            padding: EdgeInsets.zero,
                            shape: StadiumBorder(),
                            backgroundColor: Color.fromARGB(255, 241, 10, 10),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 18,
                      ),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          icon: SvgPicture.asset(
                            'asset/images/loginscreen/f_logo.svg',
                            width: 20,
                            color: Colors.white,
                          ),
                          label: const Text(
                            'facebook',
                            maxLines: 1,
                            textAlign: TextAlign.left,
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            shape: StadiumBorder(),
                            backgroundColor: Color.fromARGB(255, 21, 10, 241),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
