import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShareButton extends StatelessWidget {
  final String text;
  final Color color;
  final IconData icon;

  const ShareButton({Key key, this.text, this.color, this.icon})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 12.0,
        right: 20,
        bottom: 8,
      ),
      child: Column(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
            ),
            child: Icon(
              icon,
              size: 20,
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          Text(
            text,
            style: GoogleFonts.dmSans(
              color: Colors.white70,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}
