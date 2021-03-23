import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:google_fonts/google_fonts.dart';

import 'level4.dart';

class Level5 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 25.0,
        right: 25,
        top: 20,
        //bottom: 12,
      ),
      child: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 180,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: const Color(0xFF21212b),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                left: 25.0,
                right: 25,
                top: 30,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MenuItems(
                        title: "Subscription",
                        titleText: "Free",
                        button: "Edit",
                        visibility: false,
                        icon: FeatherIcons.trendingUp,
                      ),
                      GestureDetector(
                        onTap: () {
                          HapticFeedback.mediumImpact();
                          debugPrint("TAPPED");
                        },
                        child: Container(
                          height: 50,
                          decoration: new BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            gradient: new LinearGradient(
                              colors: [
                                const Color(0xFF1565C0),
                                const Color(0xFFb92b27),
                              ],
                              begin: const FractionalOffset(0.0, 0.0),
                              end: const FractionalOffset(1.0, 0.0),
                              stops: [0.0, 1.0],
                              tileMode: TileMode.clamp,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 15.0,
                              right: 15,
                              top: 8,
                              bottom: 8,
                            ),
                            child: Center(
                              child: Text(
                                "Upgrade to Pro",
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: GestureDetector(
              onTap: () {
                HapticFeedback.mediumImpact();
                debugPrint("TAPPED");
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 65,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                  color: const Color(0xFF272732),
                ),
                child: Center(
                  child: Text(
                    "See the Pro Benefits  ➜",
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
}
