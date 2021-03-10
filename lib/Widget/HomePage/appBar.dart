import 'package:avatar_glow/avatar_glow.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:my_app/Pages/Profile/profile.dart';

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
          left: 20.0,
          right: 8,
          top: 12,
          bottom: 6,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0xFFb615dd),
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(
                FeatherIcons.menu,
                color: Colors.white,
              ),
            ),
            AvatarGlow(
              endRadius: 40.0,
              glowColor: Color(0xFFb615dd),
              child: GestureDetector(
                onTap: () {
                  HapticFeedback.mediumImpact();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfilePage(),
                    ),
                  );
                },
                child: CircleAvatar(
                  radius: 22,
                  backgroundImage: CachedNetworkImageProvider(
                    image == " "
                        ? "https://mir-s3-cdn-cf.behance.net/user/115/2b34d1156252643.5cb89af1a9b06.jpg"
                        : image,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}