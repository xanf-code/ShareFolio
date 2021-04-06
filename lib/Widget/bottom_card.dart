import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'file:///C:/Users/darshan/AndroidStudioProjects/my_app/lib/constants.dart';
import 'package:my_app/Widget/share_button.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CardBottom extends StatelessWidget {
  final String userDocument;

  const CardBottom({Key key, this.userDocument}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 190,
      decoration: const BoxDecoration(
        gradient: pageGradient,
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 30.0,
          left: 30.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Share Profile",
              style: GoogleFonts.poppins(
                color: Colors.white30,
                fontWeight: FontWeight.w400,
                fontSize: 15,
              ),
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    HapticFeedback.lightImpact();
                    Get.back();
                    Clipboard.setData(
                      ClipboardData(
                        text: "Check out my ShareFolio profile $userDocument",
                      ),
                    ).whenComplete(
                      () {
                        Fluttertoast.showToast(
                          msg: "Copied",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          backgroundColor: Colors.black,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                      },
                    );
                  },
                  child: const ShareButton(
                    text: "Copy Link",
                    icon: FeatherIcons.link,
                    color: Color(0xFFbdbdbd),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    HapticFeedback.lightImpact();
                    Get.back();
                    launch(
                        "sms:?body=Check out my ShareFolio profile $userDocument");
                  },
                  child: const ShareButton(
                    text: "Message",
                    icon: FeatherIcons.messageCircle,
                    color: Color(0xFF0acc38),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    HapticFeedback.lightImpact();
                    Get.back();
                    FlutterShareMe().shareToTwitter(
                      url: userDocument,
                      msg: "Check out my ShareFolio profile",
                    );
                  },
                  child: const ShareButton(
                    text: "Twitter",
                    icon: FeatherIcons.twitter,
                    color: Color(0xFF58aff1),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    HapticFeedback.lightImpact();
                    Get.back();
                    FlutterShareMe().shareToWhatsApp(
                      msg: "Check out my ShareFolio profile $userDocument",
                    );
                  },
                  child: const ShareButton(
                    text: "Whatsapp",
                    icon: FontAwesomeIcons.whatsapp,
                    color: Color(0xFF58aff1),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    HapticFeedback.lightImpact();
                    Get.back();
                    Share.share(
                      "Check out my ShareFolio profile $userDocument",
                    );
                  },
                  child: const ShareButton(
                    text: "Other",
                    icon: FeatherIcons.moreHorizontal,
                    color: Color(0xFFbdbdbd),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
