import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/Pages/HomePage/Settings/EditPage/edit_image.dart';
import 'package:my_app/Services/Authentication_service/auth_service.dart';

class Level2 extends StatelessWidget {
  const Level2({
    Key key,
    @required AuthService authService,
  })  : _authService = authService,
        super(key: key);

  final AuthService _authService;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 25.0,
        top: 25,
        bottom: 8,
      ),
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(_authService.getCurrentUserUID())
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
          return Row(
            children: [
              GestureDetector(
                onTap: () {
                  HapticFeedback.mediumImpact();
                  Get.to(
                    () => EditImage(),
                    fullscreenDialog: true,
                  );
                },
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.transparent,
                  backgroundImage: CachedNetworkImageProvider(
                    userDocument["profileImage"].toString() == " "
                        ? "https://www.tenforums.com/geek/gars/images/2/types/thumb_15951118880user.png"
                        : userDocument["profileImage"].toString(),
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userDocument["name"].toString(),
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    userDocument["email"].toString(),
                    style: GoogleFonts.dmSans(
                      fontWeight: FontWeight.w300,
                      fontSize: 16,
                      color: Colors.white54,
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
