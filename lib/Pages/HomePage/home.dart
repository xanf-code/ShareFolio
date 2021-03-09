import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_app/Services/auth_service.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: Center(
        child: MaterialButton(
          onPressed: () async {
            HapticFeedback.mediumImpact();
            AuthService().signOut();
          },
          child: Text("Sign Out"),
        ),
      ),
    );
  }
}
