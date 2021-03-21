import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/Services/Authentication_service/auth_service.dart';

class level4 extends StatelessWidget {
  final AuthService authService;
  const level4({
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
        height: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: const Color(0xFF21212b),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20.0,
            //top: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  HapticFeedback.mediumImpact();
                  //LOGIC
                  debugPrint("TAPPED");
                },
                child: menu_items(
                  title: "Display Name",
                  title_text: authService.getCurrentUserName(),
                  button: "Edit",
                  visibility: true,
                ),
              ),
              GestureDetector(
                onTap: () {
                  HapticFeedback.mediumImpact();
                  //LOGIC
                  debugPrint("TAPPED");
                },
                child: menu_items(
                  title: "Email",
                  title_text: authService.getCurrentUserEmail(),
                  button: "Edit",
                  visibility: false,
                ),
              ),
              GestureDetector(
                onTap: () {
                  HapticFeedback.mediumImpact();
                  //LOGIC
                  debugPrint("TAPPED");
                },
                child: const menu_items(
                  title: "Password",
                  title_text: "•••••••••••",
                  button: "Change",
                  visibility: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class menu_items extends StatelessWidget {
  const menu_items({
    Key key,
    this.title,
    this.title_text,
    this.button,
    this.visibility,
  }) : super(key: key);
  final String title;
  final String title_text;
  final String button;
  final bool visibility;
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
              Text(
                title,
                style: GoogleFonts.dmSans(
                  color: const Color(0xFF55555d),
                  fontWeight: FontWeight.w500,
                  fontSize: 17,
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              Text(
                title_text,
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
