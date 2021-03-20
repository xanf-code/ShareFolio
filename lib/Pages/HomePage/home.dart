import 'package:floating_navbar/floating_navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:my_app/Pages/HomePage/SearchPage/search.dart';
import 'package:my_app/Pages/HomePage/Settings/settings.dart';
import 'package:my_app/Pages/HomePage/Widget/homepage_home.dart';
import 'package:my_app/Services/GeneralFunctions/functions.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    Functions().connectivityStatus(context);
    super.initState();
  }

  final List<Widget> _widgetOptions = <Widget>[
    HomeWidget(),
    SearchPage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FloatingNavBar(
        color: Color(0xff121212),
        iconColor: Color(0xFFCF6679),
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
          Icon(
            FeatherIcons.settings,
            color: Colors.white,
            size: 22,
          )
        ],
      ),
    );
  }
}
