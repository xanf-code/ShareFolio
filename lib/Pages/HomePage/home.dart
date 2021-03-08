import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _postController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: MaterialButton(
              onPressed: () async {
                HapticFeedback.mediumImpact();
              },
              child: Text("Sign Out"),
            ),
          ),
          TextField(
            obscureText: false,
            controller: _postController,
            style: GoogleFonts.dmSans(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.start,
            decoration: InputDecoration(
              hintText: "post",
              hintStyle:
                  GoogleFonts.dmSans(fontSize: 16, color: Colors.white54),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  width: 2,
                  style: BorderStyle.none,
                ),
              ),
              filled: true,
              fillColor: Color(0xFF171717),
              contentPadding: EdgeInsets.all(25),
            ),
          ),
          MaterialButton(
            onPressed: () {
              HapticFeedback.mediumImpact();
            },
            child: Text("Post"),
          ),
        ],
      ),
    );
  }
}
