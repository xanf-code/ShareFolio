import 'package:flutter/material.dart';
import 'package:my_app/Widget/auth.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: myBoxDecoration(),
        child: Center(
          child: OutlinedButton(
            child: Text("Sign Out"),
            onPressed: () {
              signOut(context);
            },
          ),
        ),
      ),
    );
  }

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      gradient: const LinearGradient(
        stops: [0.0, 1.0, 1.5],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          Color(0xFF08051a),
          Color(0xFF07041b),
          Color(0xFF081631),
        ],
      ),
    );
  }

  void signOut(context) async {
    try {
      final auth = Provider.of(context).auth;
      await auth.signOut();
    } catch (e) {
      print(e);
    }
  }
}
