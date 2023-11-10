import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

// class AuthService {
//   Future<UserCredential> signInWithGoogle() async {
//     try {
//       // Trigger the authentication flow
//       final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

//       // Obtain the auth details from the request
//       final GoogleSignInAuthentication? googleAuth =
//           await googleUser?.authentication;

//       // Create a new credential
//       final credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth?.accessToken,
//         idToken: googleAuth?.idToken,
//       );

//       // Once signed in, return the UserCredential
//       return await FirebaseAuth.instance.signInWithCredential(credential);
//     } on FirebaseAuthException catch (e) {
//       final ex = TExceptions.fromCode(e.code);
//       throw ex.message;
//     } catch (_) {
//       const ex = TExceptions();
//       throw ex.message;
//     }
//   }
// }




//////////////////////////////
// class GoogleSignInProvider extends ChangeNotifier {
//   final googleSignIn = GoogleSignIn();
//   GoogleSignInAccount? _user;
//   GoogleSignInAccount get user => _user!;
//   Future googleLogins() async {
//     final googleUser = await googleSignIn.signIn();
//     if (googleUser == null) return;
//     _user = googleUser;

//     final googleAuth = await googleUser.authentication;
//     final credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
//     await FirebaseAuth.instance.signInWithCredential(credential);
//     notifyListeners();
//   }
// }
