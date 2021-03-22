import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_app/Models/user_db.dart';
import 'package:my_app/Services/firebase_services/services.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  // Checking app state (User logged in or logged Out?)
  // Stream<String> get onAuthStateChange => _firebaseAuth.authStateChanges().map(
  //       (User user) => user?.uid,
  //     );
  // temp
  UserModel _userFromFirebaseUser(User user) {
    return user != null ? UserModel(uid: user.uid) : null;
  }

  Stream<UserModel> get user {
    return FirebaseAuth.instance.authStateChanges().map(_userFromFirebaseUser);
  }

  // GET UID
  String getCurrentUserUID() {
    final String currentUserID = _firebaseAuth.currentUser.uid;
    return currentUserID;
  }

  // GET EMAIL
  String getCurrentUserEmail() {
    return _firebaseAuth.currentUser.email;
  }

  // GET NAME
  String getCurrentUserName() {
    return _firebaseAuth.currentUser.displayName;
  }

  // GET PIC
  String getCurrentUserPic() {
    return _firebaseAuth.currentUser.photoURL;
  }

  // Email and Pass Sign up
  Future<String> createUserWithEmailAndPassword(
      String email, String password, String name, BuildContext context) async {
    final currentUser = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);

    final User firebaseUser = currentUser.user;
    await firebaseUser.updateProfile(displayName: name);

    FirebaseService().createUserDatabase(context, name, email, firebaseUser.uid,
        firebaseUser.photoURL, AuthService().getCurrentUserUID());
    await firebaseUser.reload();

    return firebaseUser.uid;
  }

  // Email Sign-In
  Future<String> signInWithEmailAndPassword(
      String email, String password) async {
    return (await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    ))
        .user
        .uid;
  }

  // Reset Password
  Future sendPasswordResetEmail(String email) async {
    return _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  // Sign-Out
  signOut() {
    return _firebaseAuth.signOut();
  }

  // Google Sign-In
  Future<String> signInWithGoogle(BuildContext context) async {
    final GoogleSignInAccount account = await _googleSignIn.signIn();
    final GoogleSignInAuthentication _googleAuth = await account.authentication;
    //final GoogleSignInAccount gCurrentUser = _googleSignIn.currentUser;
    final AuthCredential credential = GoogleAuthProvider.credential(
      idToken: _googleAuth.idToken,
      accessToken: _googleAuth.accessToken,
    );

    return (await _firebaseAuth.signInWithCredential(credential)).user.uid;
  }
}
