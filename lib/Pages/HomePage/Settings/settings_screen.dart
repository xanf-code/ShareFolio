import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:intl/intl.dart';
import 'package:my_app/Pages/AuthPage/Login/Widget/form_ui.dart';
import 'package:my_app/Widget/constants.dart';
import 'package:my_app/Services/Authentication_service/auth_service.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    //SCAFFOLD
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: pageGradient,
        ),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 15.0,
                top: 15,
                bottom: 22,
              ),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: IconButton(
                      icon: const Icon(
                        CupertinoIcons.back,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        HapticFeedback.mediumImpact();
                        Get.back();
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  const Level1Form(
                    type: "Settings",
                  ),
                ],
              ),
            ),
            //TEMPORARY MENU ITEMS
            const temp_menuitems(),
            const temp_menuitems(),
            const temp_menuitems(),
            const temp_menuitems(),
            const temp_menuitems(),
            const temp_menuitems(),
            const SizedBox(
              height: 20,
            ),
            //CHANGE LOGO LATER
            const FlutterLogo(),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: Text(
                "ShareFolio v0.0.1 (Beta)",
                style: GoogleFonts.dmSans(
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Center(
              child: Text(
                "${DateFormat.yMMMMd().format(DateTime.now())} at ${DateFormat.jm().format(DateTime.now())}",
                style: GoogleFonts.dmSans(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                HapticFeedback.mediumImpact();
                showAlertDialog(context);
              },
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 8.0,
                  top: 10,
                  right: 8,
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 65,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                    ),
                    color: const Color(0xFF272732),
                    //borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      "Sign Out",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void signOut(BuildContext context) {
    try {
      final auth = AuthService();
      auth.signOut();
      Get.back();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void showAlertDialog(BuildContext context) {
    final Widget OkButton = TextButton(
      onPressed: () {
        signOut(context);
        Get.back();
      },
      child: const Text("OK"),
    );
    final Widget Cancel_Button = TextButton(
      onPressed: () {
        Get.back();
      },
      child: const Text("CANCEL"),
    );

    // set up the AlertDialog
    final AlertDialog alert = AlertDialog(
      backgroundColor: const Color(0xFF212121),
      title: const Text(
        "Log out",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      content: const Text(
        "Are you sure? Logging out will remove all ShareFolio data from this device.",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      actions: [
        OkButton,
        Cancel_Button,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

class temp_menuitems extends StatelessWidget {
  const temp_menuitems({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        "Account",
        style: GoogleFonts.poppins(
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        "Profle, Subscription, Presence",
        style: GoogleFonts.poppins(
          color: Colors.white54,
        ),
      ),
    );
  }
}
