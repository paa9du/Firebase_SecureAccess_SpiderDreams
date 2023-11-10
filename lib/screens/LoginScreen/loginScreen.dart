import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:spider_dream/Animations/fadeAnimation.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spider_dream/config/palette.dart';
import 'package:spider_dream/screens/HomeScreen/HomeScreen.dart';
import 'package:spider_dream/screens/forgotPassword/forgotPassword_btn/forgotPassword_buildModelbuttomSheet.dart';
import 'package:spider_dream/screens/SignUpScreen/signUpScreen.dart';
import 'package:spider_dream/services/GoogleServices.dart';

import '../forgotPassword/forgotPassword_btn/forgotPasswordBtnWidget.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  // Future<void> signInWithGoogle() async {
  //   //create an instance of the firebase auth and google signin
  //   FirebaseAuth auth = FirebaseAuth.instance;
  //   final GoogleSignIn googleSignIn = GoogleSignIn();
  //   //triger the authentication flow
  //   final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

  //   //obtain the auth details from the request
  //   final GoogleSignInAuthentication googleAuth =
  //       await googleUser!.authentication;

  //   //ceate a new credentials
  //   final AuthCredential credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

  //   //sign in the user with the credentials
  //   final UserCredential userCredential =
  //       await auth.signInWithCredential(credential);
  // }

  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  void _submitform1() {
    if (formkey.currentState!.validate()) {}
  }

  String? _validateEmail1(value) {
    if (value!.isEmpty) {
      return 'Please Enter an Email';
    }
    RegExp emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegExp.hasMatch(value)) {
      return 'Please Enter a valid Email';
    }
    return null;
  }

  String? _validpassword(value) {
    if (value!.isEmpty) {
      return 'Please Enter Password';
    } else if (value.length <= 6) {
      return 'Correct Password More than 6 Characters';
    } else {
      return null;
    }
  }

  bool isRemember = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                // height: MediaQuery.of(context).size.height,
                height: 400,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        'asset/images/loginscreen/background.png',
                      ),
                      fit: BoxFit.fill),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      left: 30,
                      width: 100,
                      height: 200,
                      child: FadeAnimation(
                        1,
                        Container(
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                'asset/images/loginscreen/light-1.png',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 170,
                      width: 100,
                      height: 140,
                      child: FadeAnimation(
                        1.3,
                        Container(
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                'asset/images/loginscreen/light-2.png',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 300,
                      width: 80,
                      height: 160,
                      child: FadeAnimation(
                        1.5,
                        Container(
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                'asset/images/loginscreen/clock.png',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      child: FadeAnimation(
                        1.6,
                        Container(
                          margin: EdgeInsets.only(top: 50),
                          child: const Center(
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(30.0),
                child: Column(
                  children: [
                    FadeAnimation(
                      1.7,
                      Form(
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromRGBO(143, 148, 251, 1),
                                blurRadius: 20.0,
                                offset: Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Form(
                            key: formkey,
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(8.0),
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(color: Colors.grey),
                                    ),
                                  ),
                                  child: TextFormField(
                                    controller: loginEmailController,
                                    decoration: const InputDecoration(
                                      prefixIcon: Icon(Icons.person),
                                      labelText: 'E-Mail',
                                      hintText: "Email",
                                      border: OutlineInputBorder(),
                                      hintStyle: TextStyle(color: Colors.grey),
                                      //  enabledBorder: OutlineInputBorder(),
                                    ),
                                    validator: _validateEmail1,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  padding: EdgeInsets.all(8.0),
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(color: Colors.grey),
                                    ),
                                  ),
                                  child: TextFormField(
                                    controller: loginPasswordController,
                                    decoration: const InputDecoration(
                                      prefixIcon: Icon(Icons.fingerprint),
                                      labelText: "Password",
                                      hintText: "Password",
                                      border: OutlineInputBorder(),
                                      hintStyle: TextStyle(color: Colors.grey),
                                    ),
                                    validator: _validpassword,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    FadeAnimation(
                      1.5,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                  value: isRemember,
                                  activeColor: Palette.textColor2,
                                  onChanged: (value) {
                                    setState(() {
                                      isRemember = !isRemember;
                                    });
                                  }),
                              const Text(
                                'Remember Me',
                                style: TextStyle(
                                    fontSize: 12, color: Palette.textColor1),
                              ),
                            ],
                          ),
                          TextButton(
                            onPressed: () {
                              ForgotPasswordScreen
                                  .forgotPassword_buildModelbuttomSheet(
                                      context);
                            },
                            child: Text('Forget Password?'),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 1,
                    ),
                    FadeAnimation(
                      2,
                      Container(
                        // height: 50,
                        margin: EdgeInsets.symmetric(horizontal: 50),
                        child: ElevatedButton(
                          onPressed: () async {
                            var logemail = loginEmailController.text.trim();
                            var logpassword =
                                loginPasswordController.text.trim();

                            try {
                              final User? firebaseUser = (await FirebaseAuth
                                      .instance
                                      .signInWithEmailAndPassword(
                                          email: logemail,
                                          password: logpassword))
                                  .user;
                              if (firebaseUser != null) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            HomeScreenMain()));
                                // Get.to(() => HomeScreenMain());
                                // GestureDetector(
                                //   onTap: () => Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //       builder: (context) => HomeScreenMain(),
                                //     ),
                                //   ),
                                // );
                              } else {
                                print('Check Email & Password');
                              }
                            } on FirebaseAuthException catch (e) {
                              print('Error $e');
                            }
                          },
                          child: Center(
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            // fixedSize: Size.fromHeight(45),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 10.0),
                            shape: StadiumBorder(),
                            backgroundColor: Color.fromARGB(255, 223, 4, 175),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    FadeAnimation(
                      1.5,
                      Container(
                        child: Text('Or'),
                      ),
                    ),
                    FadeAnimation(
                      1.5,
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                // final provider =
                                //     Provider.of<GoogleSignInProvider>(context,
                                //         listen: false);
                                // provider.googleLogins();
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
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                              style: ElevatedButton.styleFrom(
                                // fixedSize: Size.fromHeight(45),
                                // padding: const EdgeInsets.symmetric(
                                //     horizontal: 20.0, vertical: 10.0),
                                padding: EdgeInsets.zero,
                                shape: StadiumBorder(),
                                backgroundColor:
                                    Color.fromARGB(255, 241, 10, 10),
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
                                backgroundColor:
                                    Color.fromARGB(255, 21, 10, 241),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    FadeAnimation(
                      1.5,
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUpScreen()),
                          );
                        },
                        child: const Text.rich(
                          TextSpan(
                            text: 'Not a Member?  ',
                            style: TextStyle(color: Color.fromRGBO(0, 0, 0, 1)),
                            children: [
                              TextSpan(
                                  text: 'Register now',
                                  style: TextStyle(color: Colors.blue)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
