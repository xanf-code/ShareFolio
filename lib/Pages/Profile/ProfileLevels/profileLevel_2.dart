import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: camel_case_types
class profileLevel2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20.0,
        top: 12,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TagWidget(
            label: "Roles / Tags",
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Color(0xFFb615dd),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                left: 5.0,
                right: 5,
                top: 3,
                bottom: 3,
              ),
              child: Text(
                "Expert".toUpperCase(),
                style: GoogleFonts.dmSans(
                  color: Color(0xFFf87272),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          TagWidget(
            label: "Status",
          ),
        ],
      ),
    );
  }
}

class TagWidget extends StatelessWidget {
  final String label;
  const TagWidget({
    Key key,
    this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: GoogleFonts.dmSans(
        color: Colors.white54,
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
    );
  }
}
