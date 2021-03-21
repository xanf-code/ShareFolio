import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:my_app/Pages/AuthPage/Login/Widget/FormUI.dart';
import 'package:my_app/Pages/AuthPage/Login/login.dart';
import 'package:my_app/State/authentication.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(left: 35),
                child: Level1Form(
                  type: "Sign up",
                ),
              ), // Heading
              const Level2Form(
                type: "Sign up with the following options.",
              ), // Text
              FieldWidget(
                label: "Name",
                hint: 'Pick a name',
                controller: _fullNameController,
                isObscure: false,
              ),
              const SizedBox(
                height: 20,
              ),
              FieldWidget(
                label: "Email",
                hint: 'john@example.com',
                controller: _emailController,
                isObscure: false,
              ),
              const SizedBox(
                height: 20,
              ),
              FieldWidget(
                label: "Password",
                hint: 'Pick a strong password',
                controller: _passwordController,
                isObscure: true,
              ),
              const SizedBox(
                height: 20,
              ),
              FieldWidget(
                label: "Confirm Password",
                hint: 'Confirm password',
                controller: _confirmPasswordController,
                isObscure: true,
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  HapticFeedback.mediumImpact();
                  Provider.of<Authentication>(context, listen: false).signUp(
                      _passwordController,
                      _confirmPasswordController,
                      _emailController,
                      _fullNameController,
                      context);
                },
                child: const ButtonContainer(
                  type: "Sign up",
                ),
              ),
              GestureDetector(
                onTap: () {
                  HapticFeedback.mediumImpact();
                  Get.offAll(
                    () => LoginScreen(),
                  );
                },
                child: const BottomText(
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
