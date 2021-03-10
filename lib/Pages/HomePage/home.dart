import 'package:floating_navbar/floating_navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'Widget/HomePage_home.dart';

class MyHomePage extends StatelessWidget {
  final List<Widget> _widgetOptions = <Widget>[
    HomeWidget(),
    Center(
      child: Text("Home"),
    ),
    Center(
      child: Text("2"),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FloatingNavBar(
        color: Color(0xff121212),
        pages: _widgetOptions,
        icons: [
          Icon(
            FeatherIcons.home,
            color: Colors.white,
            size: 22,
          ),
          Icon(
            FeatherIcons.trendingUp,
            color: Colors.white,
            size: 22,
          ),
          Icon(
            FeatherIcons.settings,
            color: Colors.white,
            size: 22,
          )
        ],
        iconColor: Color(0xFFCF6679),
      ),
    );
  }
}
