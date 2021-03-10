import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class WelcomeText extends StatelessWidget {
  final String userName;

  const WelcomeText({Key key, this.userName}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    DateTime now = new DateTime.now();

    return Padding(
      padding: const EdgeInsets.only(left: 25.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hero(
            tag: 'nameText',
            child: Material(
              color: Colors.transparent,
              child: Text(
                "Hi " + userName + " 👋",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),
          ),
          Text(
            "It's " + "${DateFormat('EEEE').format(now)}",
            style: GoogleFonts.dmSans(
              color: Colors.white60,
              fontWeight: FontWeight.bold,
              //fontSize: 38,
            ),
          ),
          SizedBox(
            height: 18,
          ),
          Container(
            decoration: BoxDecoration(
              color: Color(0xFF7934ff),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                "+ Create Project",
                style: GoogleFonts.dmSans(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
