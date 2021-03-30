import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/Pages/AuthPage/Login/Widget/form_ui.dart';
import 'package:my_app/Pages/AuthPage/SignUp/sign_up.dart';
import 'package:my_app/State/authentication.dart';
import 'package:provider/provider.dart';
import 'package:my_app/Pages/AuthPage/PasswordReset/pass_reset.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(left: 35),
                child: Level1Form(
                  type: "Log In",
                ),
              ), // Heading
              const Level2Form(
                type: "Log in with one of the following options.",
              ), // Text
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      HapticFeedback.mediumImpact();
                      Provider.of<Authentication>(context, listen: false)
                          .googleSignIn(context);
                    },
                    child: const Level3(
                      icon: FontAwesomeIcons.google,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      HapticFeedback.mediumImpact();
                      Provider.of<Authentication>(context, listen: false)
                          .facebook(context);
                    },
                    child: const Level3(
                      icon: FontAwesomeIcons.facebook,
                    ),
                  ),
                ],
              ),

              FieldWidget(
                label: "Email",
                hint: 'john@example.com',
                controller: _emailController,
                isObscure: false,
                fillColor: const Color(0xFF171717),
              ),
              const SizedBox(
                height: 20,
              ),
              FieldWidget(
                label: "Password",
                hint: 'Your Password here',
                controller: _passwordController,
                isObscure: true,
                fillColor: const Color(0xFF171717),
              ),
              GestureDetector(
                onTap: () {
                  HapticFeedback.mediumImpact();
                  Get.to(
                    PassReset(),
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
              const SizedBox(
                height: 18,
              ),
              GestureDetector(
                onTap: () {
                  HapticFeedback.mediumImpact();
                  Provider.of<Authentication>(context, listen: false)
                      .signIn(_emailController, _passwordController, context);
                },
                child: const ButtonContainer(
                  type: "Log in",
                ),
              ),
              GestureDetector(
                onTap: () {
                  HapticFeedback.mediumImpact();
                  Get.offAll(
                    () => SignUpScreen(),
                  );
                },
                child: const BottomText(
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
}
