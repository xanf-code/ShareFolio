import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:floating_navbar/floating_navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:my_app/Models/user_db.dart';
import 'package:my_app/Pages/HomePage/MainHome/home_page.dart';
import 'package:my_app/Pages/HomePage/SearchPage/search.dart';
import 'package:my_app/Pages/HomePage/Settings/settings.dart';
import 'package:my_app/Services/Authentication_service/auth_service.dart';
import 'package:my_app/Services/GeneralFunctions/functions.dart';
import 'package:my_app/State/function_states.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  AuthService _authService = AuthService();
  @override
  void initState() {
    Functions().connectivityStatus(context);
    super.initState();
  }

  final List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    SearchPage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: FloatingNavBar(
          color: const Color(0xff121212),
          iconColor: const Color(0xFFCF6679),
          hapticFeedback: true,
          horizontalPadding: MediaQuery.of(context).size.width / 8,
          pages: _widgetOptions,
          borderRadius: 30,
          icons: [
            Icon(
              FeatherIcons.home,
              color: Colors.white,
              size: 22,
            ),
            Icon(
              FeatherIcons.search,
              color: Colors.white,
              size: 22,
            ),
            StreamProvider<UserModel>.value(
              initialData:
                  Provider.of<FirebaseFunctions>(context).initialData(),
              value: Provider.of<FirebaseFunctions>(context).userInfo(),
              child: Consumer<UserModel>(
                builder: (context, UserModel document, child) {
                  return CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.transparent,
                    backgroundImage:
                        CachedNetworkImageProvider(document.profileImage),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
