import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chip_tags/flutter_chip_tags.dart';
import 'package:my_app/Pages/AuthPage/Login/Widget/form_ui.dart';
import 'package:my_app/Services/Authentication_service/auth_service.dart';
import 'package:my_app/State/function_states.dart';
import 'package:my_app/Widget/constants.dart';
import 'package:provider/provider.dart';

class SkillsPage extends StatefulWidget {
  @override
  _SkillsPageState createState() => _SkillsPageState();
}

class _SkillsPageState extends State<SkillsPage> {
  List<String> skills = [];
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
                top: 8.0,
                left: 22,
                bottom: 12,
              ),
              child: Level1Form(
                type: "Skills",
              ),
            ),
            ChipTags(
              list: skills,
              separator: ",",
            ),
            TextButton(
              onPressed: () {
                HapticFeedback.lightImpact();
                Provider.of<FirebaseFunctions>(context, listen: false)
                    .createSkills(
                  context,
                  skills,
                  AuthService().getCurrentUserUID(),
                );
              },
              child: const Text("Click here"),
            ),
          ],
        ),
      ),
    );
  }
}
