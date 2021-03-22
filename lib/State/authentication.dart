import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:get/get.dart';
import 'package:my_app/Pages/Wrapper/wrapper.dart';
import 'package:my_app/Services/Authentication_service/auth_service.dart';
import 'package:my_app/Services/firebase_services/services.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class Authentication extends ChangeNotifier {
  String _error;

  Future<String> signIn(
      _emailController, _passwordController, BuildContext context) async {
    try {
      final auth = AuthService();
      await auth.signInWithEmailAndPassword(
        _emailController.text.trim().toString(),
        _passwordController.text.trim().toString(),
      );
      Get.off(
        () => const Wrapper(),
      );
    } catch (error) {
      _error = error.message.toString();

      if (_error != null) {
        showTopSnackBar(
          context,
          CustomSnackBar.error(
            message: _error,
          ),
        );
      }
    }
    notifyListeners();
    return "success";
  }

  Future<String> googleSignIn(BuildContext context) async {
    try {
      final auth = AuthService();

      await auth.signInWithGoogle(context);
      FirebaseService().createUserDatabase(
          context,
          auth.getCurrentUserName(),
          auth.getCurrentUserEmail(),
          auth.getCurrentUserUID(),
          auth.getCurrentUserPic(),
          auth.getCurrentUserUID());
      Get.off(
        () => const Wrapper(),
      );
    } catch (e) {
      _error = e.message.toString();
      if (_error != null) {
        showTopSnackBar(
          context,
          CustomSnackBar.error(
            message: _error,
          ),
        );
      }
    }
    notifyListeners();
    return "success";
  }

  Future<String> signUp(_passwordController, _confirmPasswordController,
      _emailController, _fullNameController, BuildContext context) async {
    try {
      final auth = AuthService();
      if (_passwordController.text == _confirmPasswordController.text) {
        await auth.createUserWithEmailAndPassword(
            _emailController.text.trim().toString(),
            _passwordController.text.trim().toString(),
            _fullNameController.text.toString().trim(),
            context);
        Get.off(
          () => const Wrapper(),
        );
      } else if (_passwordController.text != _confirmPasswordController.text) {
        showTopSnackBar(
          context,
          const CustomSnackBar.error(
            message: "Passwords should match",
          ),
        );
      }
    } catch (e) {
      _error = e.message.toString();

      if (_error != null) {
        showTopSnackBar(
          context,
          CustomSnackBar.error(
            message: _error,
          ),
        );
      }
    }
    notifyListeners();
    return "success";
  }

  Future<String> resetPass(_resetPass, BuildContext context) async {
    try {
      final auth = AuthService();
      await auth.sendPasswordResetEmail(
        _resetPass.text.toString().trim(),
      );
      showTopSnackBar(
        context,
        CustomSnackBar.error(
          message: "A password reset link has been sent to ${_resetPass.text}",
        ),
      );
      Get.off(
        () => const Wrapper(),
      );
    } catch (e) {
      _error = e.message.toString();

      if (_error != null) {
        showTopSnackBar(
          context,
          CustomSnackBar.error(
            message: _error,
          ),
        );
      }
    }
    notifyListeners();
    return "success";
  }

  Future<String> facebook(BuildContext context) async {
    try {
      final fb = FacebookLogin();

      final res = await fb.logIn(permissions: [
        FacebookPermission.publicProfile,
        FacebookPermission.email,
      ]);
      final FacebookAccessToken accessToken = res.accessToken;
      final AuthCredential authCredential =
          FacebookAuthProvider.credential(accessToken.token);

      final User user =
          (await FirebaseAuth.instance.signInWithCredential(authCredential))
              .user;

      final profile = await fb.getUserProfile();
      final userName = profile.name;
      final imageUrl = await fb.getProfileImageUrl(width: 100);
      final email = await fb.getUserEmail();

      FirebaseService().createUserDatabase(
          context, userName, email, user.uid, imageUrl, user.uid);
    } catch (e) {
      _error = e.message.toString();
      if (_error != null) {
        showTopSnackBar(
          context,
          CustomSnackBar.error(
            message: _error,
          ),
        );
      }
    }
    notifyListeners();
    return "success";
  }
}
