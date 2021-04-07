import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:my_app/Models/user_db.dart';
import 'package:my_app/Pages/Onbarding/onboarding.dart';
import 'package:my_app/Services/Authentication_service/auth_service.dart';
import 'package:my_app/Services/Backend_calls/all_calls.dart';
import 'package:my_app/State/BackendProvider/backend_provider.dart';
import 'package:my_app/State/authentication.dart';
import 'package:my_app/State/function_states.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_app/State/generate_dynamic_link.dart';
import 'package:my_app/Pages/Wrapper/wrapper.dart';
import 'Services/dynamic_link/dynamic_link_service.dart';

int initScreen;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Provider.debugCheckInvalidValueType = null;
  await Firebase.initializeApp();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  initScreen = prefs.getInt("initScreen");
  await prefs.setInt("initScreen", 1);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final DynamicLinkService _dynamicLinkService = DynamicLinkService();

  @override
  void initState() {
    _dynamicLinkService.handleDynamicLinks(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<GenerateLink>(
          create: (_) => GenerateLink(),
        ),
        Provider<Authentication>(
          create: (_) => Authentication(),
        ),
        Provider<FirebaseFunctions>(
          create: (_) => FirebaseFunctions(),
        ),
        Provider<BackendProvider>(
          create: (_) => BackendProvider(),
        ),
      ],
      child: StreamProvider<UserModel>.value(
        value: AuthService().user,
        child: GetMaterialApp(
          navigatorKey: Get.key,
          debugShowCheckedModeBanner: false,
          home: initScreen == 0 || initScreen == null
              ? OnBoarding()
              : const Wrapper(),
          //: Material(child: SettingsPage()),
        ),
      ),
    );
  }
}
