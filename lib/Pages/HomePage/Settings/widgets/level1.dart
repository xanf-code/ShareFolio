import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_app/Pages/AuthPage/Login/Widget/form_ui.dart';

class level1 extends StatelessWidget {
  level1({
    Key key,
  }) : super(key: key);

  final String type =
      FirebaseAuth.instance.currentUser.providerData[0].providerId;

  FirebaseAuth auth = FirebaseAuth.instance;
  final googleSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 35, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Level1Form(
            type: "My Account",
          ),
          if (type == "google.com")
            IconButton(
              icon: const Icon(
                FeatherIcons.moreHorizontal,
                color: Colors.white,
              ),
              onPressed: () {
                HapticFeedback.mediumImpact();
                _settingModalBottomSheet(context);
              },
            ),
        ],
      ),
    );
  }

  void _settingModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          height: 100,
          color: const Color(0xFF212121),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Disconnect from Google Account and Sign Out?",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        disconnect();
                      },
                      child: const Text("OK"),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: const Text("CANCEL"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<bool> disconnect() async {
    await googleSignIn.disconnect();
    await auth.signOut();
    return Future.value(true);
  }
}

//USER INFO JSON

//[
//  UserInfo(
//    displayName: Darshan Aswath,
//    email: darshanaswath@gmail.com,
//    phoneNumber: null,
//    photoURL: https://lh3.googleusercontent.com/a-/AOh14Gj4y8V26cgIiFrj70mTSyMScbz_Rzni8oY4Jef4thI=s96-c,
//    providerId: google.com,
//    uid: 109798187794852464406)
//]
