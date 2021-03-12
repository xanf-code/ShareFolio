import 'package:flutter/material.dart';
import 'package:my_app/Pages/AuthPage/Login/Widget/FormUI.dart';

class FormHead extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 35,
            top: 12,
          ),
          child: Level1Form(
            type: "Create Circle",
          ),
        ), // Heading
        Level2Form(
          type: "This section contains the basic details of your group.",
        ),
      ],
    );
  }
}
