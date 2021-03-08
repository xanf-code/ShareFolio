import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_app/Pages/AuthPage/Login/Widget/FormUI.dart';
import 'package:my_app/Pages/AuthPage/Login/login.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Level1Form(
                type: "Sign up",
              ), // Heading
              Level2Form(
                type: "Sign up with one of the following options.",
              ), // Text
              FieldWidget(
                label: "Name",
                hint: 'Pick a name',
                controller: _fullNameController,
                isObscure: false,
              ),
              SizedBox(
                height: 20,
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
                hint: 'Pick a strong password',
                controller: _passwordController,
                isObscure: true,
              ),
              SizedBox(
                height: 20,
              ),
              FieldWidget(
                label: "Confirm Password",
                hint: 'Confirm password',
                controller: _confirmPasswordController,
                isObscure: true,
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  HapticFeedback.mediumImpact();
                },
                child: ButtonContainer(
                  type: "Sign up",
                ),
              ),
              GestureDetector(
                onTap: () {
                  HapticFeedback.mediumImpact();
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginForm(),
                      ),
                      (route) => false);
                },
                child: BottomText(
                  text1: "Already have an account? ",
                  text2: " Log in",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
