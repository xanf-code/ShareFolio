import 'package:flutter/material.dart';
import 'package:my_app/Pages/AuthPage/Login/Widget/form_ui.dart';

class level1 extends StatelessWidget {
  const level1({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 35),
      child: Level1Form(
        type: "My Account",
      ),
    );
  }
}
