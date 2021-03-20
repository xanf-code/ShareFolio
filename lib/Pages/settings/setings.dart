import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  const Settings({this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(text),
      ),
    );
  }
}
