import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_app/Models/userDB.dart';
import 'package:my_app/Pages/Onbarding/onboarding.dart';
import 'package:my_app/Services/auth_service.dart';
import 'package:my_app/Services/dynamic_link_service.dart';
import 'package:my_app/State/authentication.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_app/State/generate_dynamic_link.dart';
import 'package:my_app/Pages/Wrapper/wrapper.dart';

int initScreen;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Provider.debugCheckInvalidValueType = null;
  DynamicLinkService().handleDynamicLinks();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  initScreen = prefs.getInt("initScreen");
  await prefs.setInt("initScreen", 1);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<GenerateLink>(create: (_) => GenerateLink()),
        Provider<Authentication>(create: (_) => Authentication()),
      ],
      child: StreamProvider<UserModel>.value(
        value: AuthService().user,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: initScreen == 0 || initScreen == null
              ? OnBoarding()
              : const Wrapper(),
        ),
      ),
    );
  }
}
