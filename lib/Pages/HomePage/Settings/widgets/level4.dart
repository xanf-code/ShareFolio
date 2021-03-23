import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/Pages/HomePage/Settings/EditPage/edit_username.dart';
import 'package:my_app/Services/Authentication_service/auth_service.dart';

class Level4 extends StatelessWidget {
  final AuthService authService;
  const Level4({
    Key key,
    this.authService,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 25.0,
        right: 25,
        top: 25,
        bottom: 12,
      ),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: const Color(0xFF21212b),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20.0,
            right: 20,
            //top: 20,
          ),
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(authService.getCurrentUserUID())
                .snapshots(),
            builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              final userDocument = snapshot.data;
              if (!snapshot.hasData) {
                return const Center(
                  child: SpinKitThreeBounce(
                    color: Colors.white,
                    size: 18,
                  ),
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      HapticFeedback.mediumImpact();
                      Get.to(
                        () => EditUserName(
                          userName: userDocument["name"].toString(),
                        ),
                        fullscreenDialog: true,
                        preventDuplicates: true,
                      );
                    },
                    child: MenuItems(
                      title: "Display Name",
                      titleText: userDocument["name"].toString(),
                      button: "Edit",
                      visibility: true,
                      icon: FeatherIcons.user,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      HapticFeedback.mediumImpact();
                      //LOGIC
                      debugPrint("TAPPED");
                    },
                    child: MenuItems(
                      title: "Email",
                      titleText: userDocument["email"].toString(),
                      button: "Edit",
                      visibility: false,
                      icon: FeatherIcons.mail,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class MenuItems extends StatelessWidget {
  const MenuItems({
    Key key,
    this.title,
    this.titleText,
    this.button,
    this.visibility,
    this.icon,
  }) : super(key: key);
  final String title;
  final String titleText;
  final String button;
  final bool visibility;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 25.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    color: const Color(0xFF55555d),
                    size: 14,
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  Text(
                    title,
                    style: GoogleFonts.dmSans(
                      color: const Color(0xFF55555d),
                      fontWeight: FontWeight.w500,
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 6,
              ),
              Text(
                titleText,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          Visibility(
            visible: visibility,
            child: Container(
              height: 40,
              //width: 75,
              decoration: BoxDecoration(
                color: const Color(0xFF414052),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 20.0,
                    right: 20,
                  ),
                  child: Text(
                    button,
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
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
}
