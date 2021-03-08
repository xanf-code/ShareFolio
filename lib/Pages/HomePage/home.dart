import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_app/Widget/auth.dart';
import 'package:my_app/main.dart';

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
            signOut();
          },
          child: Text("Sign Out"),
        ),
      ),
    );
  }

  void signOut() async {
    try {
      final auth = Provider.of(context).auth;
      await auth.signOut();
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomeController()),
          (route) => false);
    } catch (e) {
      print(e);
    }
  }
}
