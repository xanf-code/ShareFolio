import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/Services/Authentication_service/auth_service.dart';

class level2 extends StatelessWidget {
  const level2({
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
      ),
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(_authService.getCurrentUserUID())
            .snapshots(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          var userDocument = snapshot.data;
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Row(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundImage: CachedNetworkImageProvider(
                  userDocument["profileImage"] == " "
                      ? "https://www.tenforums.com/geek/gars/images/2/types/thumb_15951118880user.png"
                      : userDocument["profileImage"],
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userDocument["name"],
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    userDocument["email"],
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
