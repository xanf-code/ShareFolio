import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_app/Models/userDB.dart';
import 'package:my_app/Pages/Wrapper/wrapper.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class AuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;
  //final GoogleSignIn _googleSignIn = GoogleSignIn();

  UserModel _userFromFirebaseUser(User user) {
    return user != null ? UserModel(uid: user.uid) : null;
  }

  Stream<UserModel> get user {
    return auth.authStateChanges().map(_userFromFirebaseUser);
  }

  Future signUp(email, password, context, name) async {
    try {
      UserCredential user = await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.user.uid)
          .set({
        'name': name,
        'profileImageUrl': ' ',
        'email': email,
        'uid': user.user.uid,
        'accCreated': Timestamp.now(),
      });
      _userFromFirebaseUser(user.user);

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => Wrapper(),
          ),
          (route) => false);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showTopSnackBar(
          context,
          CustomSnackBar.error(
            message: e.message,
          ),
        );
      } else if (e.code == 'email-already-in-use') {
        showTopSnackBar(
          context,
          CustomSnackBar.error(
            message: e.message,
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  Future signIn(email, password, context) async {
    try {
      User user = (await auth.signInWithEmailAndPassword(
          email: email, password: password)) as User;

      _userFromFirebaseUser(user);

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => Wrapper(),
          ),
          (route) => false);
    } on FirebaseAuthException catch (e) {
      showTopSnackBar(
        context,
        CustomSnackBar.error(
          message: e.message,
        ),
      );
    } catch (e) {
      showTopSnackBar(
        context,
        CustomSnackBar.error(
          message: e.message,
        ),
      );
    }
  }

  Future signOut() async {
    try {
      return await auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Reset Password
  Future sendPasswordResetEmail(String email) async {
    return auth.sendPasswordResetEmail(email: email);
  }

  // -------------------------------------OLD-----------------------------------------
  // Google Sign-In (Removed temporarily)
  // Future<String> signInWithGoogle() async {
  //   final GoogleSignInAccount account = await _googleSignIn.signIn();
  //   final GoogleSignInAuthentication _googleAuth = await account.authentication;
  //   final AuthCredential credential = GoogleAuthProvider.credential(
  //     idToken: _googleAuth.idToken,
  //     accessToken: _googleAuth.accessToken,
  //   );
  //   return (await auth.signInWithCredential(credential)).user.uid;
  // }
}
