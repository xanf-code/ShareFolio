import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:my_app/Pages/HomePage/Settings/widgets/level4.dart';

import '../settings_screen.dart';

class Level_settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 25.0,
        right: 25,
        top: 10,
        //bottom: 12,
      ),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: const Color(0xFF21212b),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20.0,
            right: 20,
            top: 20,
          ),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  HapticFeedback.mediumImpact();
                  Get.to(
                    () => const SettingsScreen(),
                    fullscreenDialog: true,
                  );
                },
                child: const MenuItems(
                  title: "Extras",
                  titleText: "Settings",
                  button: "Open",
                  visibility: true,
                  icon: FeatherIcons.settings,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
