import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/Pages/AuthPage/Login/Widget/FormUI.dart';
import 'package:my_app/Pages/AuthPage/PasswordReset/passReset.dart';
import 'package:my_app/Pages/AuthPage/SignUp/SignUp.dart';
import 'package:my_app/Services/firebase_services/services.dart';
import 'package:my_app/Widget/auth.dart';
import 'package:my_app/main.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String _error;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 35),
                child: Level1Form(
                  type: "Log In",
                ),
              ), // Heading
              Level2Form(
                type: "Log in with one of the following options.",
              ), // Text
              GestureDetector(
                onTap: () {
                  HapticFeedback.mediumImpact();
                  googleSignIn();
                },
                child: Level3Form(),
              ),
              FieldWidget(
                label: "Email",
                hint: 'john@example.com',
                controller: _emailController,
                isObscure: false,
              ),
              SizedBox(
                height: 20,
              ),
              FieldWidget(
                label: "Password",
                hint: 'Your Password here',
                controller: _passwordController,
                isObscure: true,
              ),
              GestureDetector(
                onTap: () {
                  HapticFeedback.mediumImpact();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PassReset(),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 35.0, top: 12),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Forgot Password?",
                      style: GoogleFonts.dmSans(
                        color: Colors.white70,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 18,
              ),
              GestureDetector(
                onTap: () {
                  HapticFeedback.mediumImpact();
                  signIn();
                },
                child: ButtonContainer(
                  type: "Log in",
                ),
              ),
              GestureDetector(
                onTap: () {
                  HapticFeedback.mediumImpact();
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        fullscreenDialog: true,
                        builder: (context) => SignUpScreen(),
                      ),
                      (route) => false);
                },
                child: BottomText(
                  text1: "Dont have an account? ",
                  text2: " Sign up",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void signIn() async {
    try {
      final auth = Providers.of(context).auth;
      await auth.signInWithEmailAndPassword(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => Wrapper(),
          ),
          (route) => false);
    } catch (e) {
      setState(() {
        _error = e.message;
        print(_error);
      });
      if (_error != null) {
        showTopSnackBar(
          context,
          CustomSnackBar.error(
            message: _error,
          ),
        );
      }
    }
  }

  void googleSignIn() async {
    try {
      final auth = Providers.of(context).auth;
      await auth.signInWithGoogle(context);
      FirebaseService().createUserDatabase(
          context,
          Providers.of(context).auth.getCurrentUserName(),
          Providers.of(context).auth.getCurrentUserEmail(),
          Providers.of(context).auth.getCurrentUserUID(),
          Providers.of(context).auth.getCurrentUserPic(),
          Providers.of(context).auth.getCurrentUserUID());
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => Wrapper(),
          ),
          (route) => false);
    } catch (e) {
      setState(() {
        _error = e.message;
        print(_error);
      });
      if (_error != null) {
        showTopSnackBar(
          context,
          CustomSnackBar.error(
            message: _error,
          ),
        );
      }
    }
  }
}
