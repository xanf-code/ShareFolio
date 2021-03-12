import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_app/Models/userDB.dart';
import 'package:my_app/Pages/AuthPage/Login/login.dart';
import 'package:my_app/Pages/HomePage/home.dart';
import 'package:my_app/Pages/Onbarding/onboarding.dart';
import 'package:my_app/Services/auth_service.dart';
import 'package:my_app/Widget/auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

int initScreen;

Future<void> main() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  initScreen = preferences.getInt('initScreen');
  await preferences.setInt('initScreen', 1);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Providers(
      db: FirebaseFirestore.instance,
      auth: AuthService(),
      child: StreamProvider<UserModel>.value(
        value: AuthService().user,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home:
              initScreen == 0 || initScreen == null ? OnBoarding() : Wrapper(),
        ),
      ),
    );
  }
}

class Wrapper extends StatelessWidget {
  const Wrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);

    if (user == null) {
      return LoginForm();
    }
    return MyHomePage();
  }
}
