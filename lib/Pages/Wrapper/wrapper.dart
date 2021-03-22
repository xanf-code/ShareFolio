import 'package:flutter/material.dart';
import 'package:my_app/Models/user_db.dart';
import 'package:my_app/Pages/AuthPage/Login/login.dart';
import 'package:my_app/Pages/HomePage/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);

    if (user == null) {
      return LoginScreen();
    }
    return MyHomePage();
  }
}
