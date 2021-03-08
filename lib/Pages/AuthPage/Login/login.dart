import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_app/Pages/AuthPage/Login/Widget/FormUI.dart';
import 'package:my_app/Pages/AuthPage/SignUp/SignUp.dart';
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
              Level1Form(
                type: "Log In",
              ), // Heading
              Level2Form(
                type: "Log in with one of the following options.",
              ), // Text
              GestureDetector(
                onTap: () {
                  HapticFeedback.mediumImpact();
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
              SizedBox(
                height: 20,
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
      final auth = Provider.of(context).auth;
      String uid = await auth.signInWithEmailAndPassword(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );
      print("Signed In $uid");
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomeController()),
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
