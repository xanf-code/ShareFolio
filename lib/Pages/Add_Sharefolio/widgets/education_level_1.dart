import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/Pages/AuthPage/Login/Widget/form_ui.dart';
import 'package:my_app/Widget/constants.dart';

class EducationForm_Level1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: [
        const Padding(
          padding: EdgeInsets.only(
            left: 22.0,
            top: 8,
          ),
          child: Level1Form(
            type: "Education",
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            bottom: 22,
            left: 22,
          ),
          child: Text(
            "Tell us about yourself",
            style: GoogleFonts.poppins(
              color: primary,
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 37.0,
          ),
          child: Text(
            "Type",
            style: GoogleFonts.dmSans(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}
