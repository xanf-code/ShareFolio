import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

class SliverBar extends StatelessWidget {
  final String name;

  const SliverBar({Key key, this.name}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20.0,
        right: 20,
        top: 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Good ${greeting().toString()}",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w300,
                ),
              ),
              Text(
                "$name 👋",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                subHeading(),
                style: GoogleFonts.poppins(
                  color: Colors.white30,
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
          IconButton(
            icon: const Icon(
              FluentSystemIcons.ic_fluent_channel_notifications_regular,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Morning 🌞';
    }
    if (hour < 18) {
      return 'Afternoon ⛅';
    }
    return 'Evening 🌇';
  }

  String subHeading() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return "Let's be productive today.";
    }
    if (hour < 18) {
      return "There's something in you the world needs.";
    }
    return 'Cheer up, tomorrow is another chance.';
  }
}
