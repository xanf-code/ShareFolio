import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Checking app state (User logged in or logged Out?)
  Stream<String> get onAuthStateChange =>
      _firebaseAuth.authStateChanges().map((User user) => user?.uid);

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

  // Sign-Out
  signOut() {
    return _firebaseAuth.signOut();
  }
}
