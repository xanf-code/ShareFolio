import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class LoadingWidget extends StatefulWidget {
  @override
  _LoadingWidgetState createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(),
        SpinKitFadingCircle(
          color: Colors.white,
          size: 50.0,
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: Text(
            "Creating Group...",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              color: Colors.white60,
            ),
          ),
        ),
      ],
    );
  }
}
