import 'package:flutter/material.dart';
import 'package:my_app/Pages/Add_Sharefolio/widgets/ind_business_widget.dart';
import 'package:my_app/Pages/AuthPage/Login/Widget/form_ui.dart';
import 'package:my_app/Widget/constants.dart';

class ProfileShareFolio extends StatefulWidget {
  @override
  _ProfileShareFolioState createState() => _ProfileShareFolioState();
}

class _ProfileShareFolioState extends State<ProfileShareFolio> {
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
              ),
              child: Level1Form(
                type: "Profile",
              ),
            ),
            TypeContainer(),
          ],
        ),
      ),
    );
  }
}
