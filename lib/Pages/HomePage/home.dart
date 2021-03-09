import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/Models/userDB.dart';
import 'package:my_app/Services/auth_service.dart';
import 'package:my_app/Services/utilService.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF121212),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(0xFF1f1f1f),
        ),
        body: Center(
          child: MaterialButton(
            onPressed: () async {
              HapticFeedback.mediumImpact();
              AuthService().signOut();
            },
            child: Text(
              "Sign Out",
              style: GoogleFonts.dmSans(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
