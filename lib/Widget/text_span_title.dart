import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextSpanTitle extends StatelessWidget {
  const TextSpanTitle({
    Key key,
    this.string1,
    this.string2,
  }) : super(key: key);

  final String string1;
  final String string2;
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: string1,
        style: GoogleFonts.poppins(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 22,
        ),
        children: [
          TextSpan(
            text: string2,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontWeight: FontWeight.normal,
              fontSize: 22,
            ),
          ),
        ],
      ),
    );
  }
}
