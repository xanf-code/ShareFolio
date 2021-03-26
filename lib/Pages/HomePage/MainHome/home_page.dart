import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          stops: [0.0, 1.0, 1.5],
          colors: [
            Color(0xFF08051a),
            Color(0xFF07041b),
            Color(0xFF081631),
          ],
        ),
      ),
    );
  }
}
