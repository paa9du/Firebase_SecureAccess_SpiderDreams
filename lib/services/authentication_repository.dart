import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spider_dream/screens/LoginScreen/loginScreen.dart';
import 'package:spider_dream/screens/welcomeScreen/welcomeScreen.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;
  var verificationId = ''.obs;

  @override
  void onReady() {
    Future.delayed(const Duration(seconds: 100));
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    user == null
        ? Get.offAll(() => WelcomeScreen())
        : Get.offAll(() => LogInScreen());
  }

  void phoneAuthentication(String phoneNo) async {
    await _auth.verifyPhoneNumber(
        phoneNumber: phoneNo,
        verificationCompleted: (credentials) async {
          await _auth.signInWithCredential(credentials);
        },
        verificationFailed: (e) {
          if (e.code == 'invalid-phone-number') {
            Get.snackbar('Error', 'The provided phoneNumber is Not valid');
          } else {
            Get.snackbar('Error', 'Somthing Went Wrong.Try again');
          }
        },
        codeSent: (verificationId, resendToken) {
          this.verificationId.value = verificationId;
        },
        codeAutoRetrievalTimeout: (verificationId) {
          this.verificationId.value = verificationId;
        });
  }

  Future<bool> verifyOTP(String OTP) async {
    var credentials = await _auth.signInWithCredential(
        PhoneAuthProvider.credential(
            verificationId: this.verificationId.value, smsCode: OTP));
    return credentials.user != null ? true : false;
  }

  // Future<void> CreateUserWithEmailAndPassword(
  //     String email, String Password) async {
  //   try {
  //     await _auth.createUserWithEmailAndPassword(
  //         email: email, password: Password);
  //     firebaseUser.value != null
  //         ? Get.offAll(() => LogInScreen())
  //         : Get.to(() => WelcomeScreen());
  //   } on FirebaseAuthException catch (e) {
  //     final ex = SignUpEmailAndPasswordFailure.code(e.code);
  //     print('FireBase Auth exception -${ex.message}');
  //     throw ex;
  //   } catch (_) {
  //     // const ex = SignUpEmailAndPasswordFailure();
  //     // print('exception -${ex.message}');
  //     // throw ex;
  //   }
  // }

  Future<void> LogInWithEmailAndPassword(String email, String Password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: Password);
    } on FirebaseAuthException catch (e) {
    } catch (_) {}
  }
}
