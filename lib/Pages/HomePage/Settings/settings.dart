import 'package:flutter/material.dart';
import 'package:my_app/Pages/HomePage/Settings/levels/settings_widget_main.dart';
import 'package:my_app/Widget/constants.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        gradient: pageGradient,
      ),
      child: ListView(
        shrinkWrap: true,
        children: [
          level1_profile(),
        ],
      ),
    );
  }
}
