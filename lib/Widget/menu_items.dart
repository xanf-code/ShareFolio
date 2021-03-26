import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuItems extends StatelessWidget {
  const MenuItems({
    Key key,
    this.title,
    this.titleText,
    this.button,
    this.visibility,
    this.icon,
  }) : super(key: key);
  final String title;
  final String titleText;
  final String button;
  final bool visibility;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 25.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    color: const Color(0xFF55555d),
                    size: 14,
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  Text(
                    title,
                    style: GoogleFonts.dmSans(
                      color: const Color(0xFF55555d),
                      fontWeight: FontWeight.w500,
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 6,
              ),
              Text(
                titleText,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          Visibility(
            visible: visibility,
            child: Container(
              height: 40,
              //width: 75,
              decoration: BoxDecoration(
                color: const Color(0xFF414052),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 20.0,
                    right: 20,
                  ),
                  child: Text(
                    button,
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
