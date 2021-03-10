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
          Text(
            "Hi " + userName + " 👋",
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 24,
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
        ],
      ),
    );
  }
}
