import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'file:///C:/Users/darshan/AndroidStudioProjects/my_app/lib/constants.dart';

class NextButton extends StatelessWidget {
  final String text;
  const NextButton({
    Key key,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: MediaQuery.of(context).size.width,
      color: primary,
      child: Center(
        child: Text(
          text,
          style: GoogleFonts.dmSans(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
