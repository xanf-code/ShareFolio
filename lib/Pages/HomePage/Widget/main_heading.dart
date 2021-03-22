import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class main_heading extends StatelessWidget {
  final String type;
  final String type2;
  const main_heading({
    Key key,
    this.type,
    this.type2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 30.0,
        bottom: 8,
      ),
      child: Row(
        children: [
          Text(
            type,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontWeight: FontWeight.normal,
              fontSize: 24,
            ),
          ),
          Text(
            type2,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        ],
      ),
    );
  }
}
