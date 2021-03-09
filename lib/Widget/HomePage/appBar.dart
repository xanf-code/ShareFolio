import 'package:avatar_glow/avatar_glow.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class MainAppBar extends StatelessWidget {
  final String image;
  final String userName;
  const MainAppBar({Key key, this.image, this.userName}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 16.0,
          right: 8,
          top: 12,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome",
                  style: GoogleFonts.dmSans(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                Text(
                  userName,
                  style: GoogleFonts.dmSans(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ],
            ),
            AvatarGlow(
              endRadius: 40.0,
              child: CircleAvatar(
                radius: 22,
                backgroundImage: CachedNetworkImageProvider(
                  image == " "
                      ? "https://mir-s3-cdn-cf.behance.net/user/115/2b34d1156252643.5cb89af1a9b06.jpg"
                      : image,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
