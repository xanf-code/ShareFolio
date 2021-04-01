import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/Pages/Add_Sharefolio/add_page.dart';
import 'package:my_app/Pages/Add_Sharefolio/skills_page.dart';
import 'package:my_app/Pages/AuthPage/Login/Widget/form_ui.dart';
import 'package:my_app/Widget/constants.dart';

import 'education_page.dart';

class MainAddPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: pageGradient,
        ),
        child: ListView(
          children: [
            const Padding(
              padding: EdgeInsets.only(
                left: 22.0,
                bottom: 8,
              ),
              child: Level1Form(
                type: "Complete Profile",
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 22.0,
                top: 12,
                bottom: 8,
              ),
              child: GestureDetector(
                onTap: () {
                  Get.to(
                    () => ProfileShareFolio(),
                  );
                },
                child: const Text(
                  "Profile",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 22.0,
                top: 12,
                bottom: 8,
              ),
              child: GestureDetector(
                onTap: () {
                  Get.to(
                    () => SkillsPage(),
                  );
                },
                child: const Text(
                  "Skills",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 22.0,
                top: 12,
                bottom: 8,
              ),
              child: GestureDetector(
                onTap: () {
                  Get.to(
                    () => Education(),
                  );
                },
                child: const Text(
                  "Education",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
