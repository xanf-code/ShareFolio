import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/Pages/HomePage/Settings/levels/settings_widget_main.dart';
import 'package:my_app/Services/Authentication_service/auth_service.dart';

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
        gradient: LinearGradient(
          stops: [0.0, 1.0, 1.5],
          colors: [
            Color(0xFF08051a),
            Color(0xFF07041b),
            Color(0xFF081631),
          ],
        ),
      ),
      child: ListView(
        shrinkWrap: true,
        children: [
          level1_profile(),
          GestureDetector(
            onTap: () {
              HapticFeedback.mediumImpact();
              showAlertDialog(context);
            },
            child: Padding(
              padding: const EdgeInsets.only(
                left: 25.0,
                top: 20,
                right: 25,
              ),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 65,
                decoration: BoxDecoration(
                  color: const Color(0xFF272732),
                  borderRadius: BorderRadius.circular(10),
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
    );
  }

  void signOut(BuildContext context) {
    try {
      final auth = AuthService();
      auth.signOut();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void showAlertDialog(BuildContext context) {
    Widget OkButton = TextButton(
      onPressed: () {
        signOut(context);
        Get.back();
      },
      child: const Text("OK"),
    );
    Widget Cancel_Button = TextButton(
      onPressed: () {
        Get.back();
      },
      child: const Text("CANCEL"),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
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
