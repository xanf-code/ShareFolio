import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pop_bottom_menu/pop_bottom_menu.dart';

class Functions {
  void showMenu(context) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return PopBottomMenu(
          backgroundColor: Color(0xff121212),
          title: TitlePopBottomMenu(
            label: "Menu",
            style: GoogleFonts.poppins(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          items: [
            ItemPopBottomMenu(
              onPressed: () {
                HapticFeedback.mediumImpact();
                Navigator.of(context).pop();
              },
              label: "Menu 1",
              style: GoogleFonts.dmSans(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              icon: Icon(
                FeatherIcons.arrowRightCircle,
                color: Colors.grey,
              ),
            ),
            ItemPopBottomMenu(
              onPressed: () {
                HapticFeedback.mediumImpact();
                Navigator.of(context).pop();
              },
              label: "Menu 2",
              style: GoogleFonts.dmSans(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              icon: Icon(
                FeatherIcons.arrowRightCircle,
                color: Colors.grey,
              ),
            ),
            ItemPopBottomMenu(
              onPressed: () {
                HapticFeedback.mediumImpact();
                Navigator.of(context).pop();
              },
              label: "Menu 3",
              style: GoogleFonts.dmSans(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              icon: Icon(
                FeatherIcons.arrowRightCircle,
                color: Colors.grey,
              ),
            ),
            ItemPopBottomMenu(
              onPressed: () {
                HapticFeedback.mediumImpact();
                Navigator.of(context).pop();
              },
              label: "Menu 4",
              style: GoogleFonts.dmSans(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              icon: Icon(
                FeatherIcons.arrowRightCircle,
                color: Colors.grey,
              ),
            ),
          ],
        );
      },
    );
  }
}
