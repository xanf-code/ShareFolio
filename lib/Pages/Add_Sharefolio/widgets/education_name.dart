import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Education_Name extends StatelessWidget {
  final String text;
  const Education_Name({
    Key key,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 37.0,
        bottom: 8,
      ),
      child: Text(
        text,
        style: GoogleFonts.dmSans(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
    );
  }
}
