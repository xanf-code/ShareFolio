import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Checking app state (User logged in or logged Out?)
  Stream<String> get onAuthStateChange =>
      _firebaseAuth.authStateChanges().map((User user) => user?.uid);

  // GET UID
  String getCurrentUserUID() {
    return _firebaseAuth.currentUser.uid;
  }

  // Email and Pass Sign up
  Future<String> createUserWithEmailAndPassword(
      String email, String password, String name) async {
    final currentUser = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);

    User firebaseUser = currentUser.user;
    await firebaseUser.updateProfile(displayName: name);
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
  Future<String> signInWithGoogle() async {
    final GoogleSignInAccount account = await _googleSignIn.signIn();
    final GoogleSignInAuthentication _googleAuth = await account.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      idToken: _googleAuth.idToken,
      accessToken: _googleAuth.accessToken,
    );
    return (await _firebaseAuth.signInWithCredential(credential)).user.uid;
  }
}
