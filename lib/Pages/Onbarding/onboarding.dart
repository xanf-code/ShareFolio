import 'package:flutter/material.dart';
import 'package:my_app/main.dart';

class OnBoarding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Wrapper(),
                fullscreenDialog: true,
              ),
            );
          },
          child: Text("Login"),
        ),
      ),
    );
  }
}
