import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_app/Pages/AuthPage/Login/Widget/FormUI.dart';
import 'package:my_app/Widget/auth.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../main.dart';

class PassReset extends StatefulWidget {
  @override
  _PassResetState createState() => _PassResetState();
}

class _PassResetState extends State<PassReset> {
  TextEditingController _resetPass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30.0),
                child: Row(
                  children: [
                    Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Color(0xFF212121),
                          ),
                        ),
                        child: IconButton(
                          icon: Icon(
                            CupertinoIcons.back,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            HapticFeedback.mediumImpact();
                            Navigator.pop(context);
                          },
                        )),
                    SizedBox(
                      width: 14,
                    ),
                    Level1Form(
                      type: "Reset Password",
                    ),
                  ],
                ),
              ), // Heading
              Level2Form(
                type: "Enter your email associated with the account",
              ), // Text
              FieldWidget(
                label: "Email",
                hint: 'john@example.com',
                controller: _resetPass,
                isObscure: false,
              ),
              SizedBox(
                height: 14,
              ),
              GestureDetector(
                onTap: () {
                  HapticFeedback.mediumImpact();
                  resetPass();
                },
                child: ButtonContainer(
                  type: "Reset Password",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _error;
  void resetPass() async {
    try {
      final auth = Provider.of(context).auth;
      await auth.sendPasswordResetEmail(
        _resetPass.text.trim(),
      );
      showTopSnackBar(
        context,
        CustomSnackBar.error(
          message: "A password reset link has been sent to ${_resetPass.text}",
        ),
      );
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => HomeController(),
          ),
          (route) => false);
    } catch (e) {
      setState(() {
        _error = e.message;
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
