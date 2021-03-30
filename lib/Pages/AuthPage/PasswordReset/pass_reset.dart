import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:my_app/Pages/AuthPage/Login/Widget/form_ui.dart';
import 'package:my_app/State/authentication.dart';
import 'package:provider/provider.dart';

class PassReset extends StatefulWidget {
  @override
  _PassResetState createState() => _PassResetState();
}

class _PassResetState extends State<PassReset> {
  final TextEditingController _resetPass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Column(
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
                          color: const Color(0xFF212121),
                        ),
                      ),
                      child: IconButton(
                        icon: const Icon(
                          CupertinoIcons.back,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          HapticFeedback.mediumImpact();
                          Get.back();
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 14,
                    ),
                    const Level1Form(
                      type: "Reset Password",
                    ),
                  ],
                ),
              ), // Heading
              const Level2Form(
                type: "Enter your email associated with the account",
              ), // Text
              FieldWidget(
                label: "Email",
                hint: 'john@example.com',
                controller: _resetPass,
                isObscure: false,
                fillColor: const Color(0xFF171717),
              ),
              const SizedBox(
                height: 14,
              ),
              GestureDetector(
                onTap: () {
                  HapticFeedback.mediumImpact();
                  Provider.of<Authentication>(context, listen: false)
                      .resetPass(_resetPass, context);
                },
                child: const ButtonContainer(
                  type: "Reset Password",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
