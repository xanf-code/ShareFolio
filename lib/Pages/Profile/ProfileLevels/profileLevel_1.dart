import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: camel_case_types
class level1_profile extends StatelessWidget {
  const level1_profile({
    Key key,
    @required this.uid,
    this.image,
    this.name,
    this.email,
  }) : super(key: key);

  final String uid;
  final String image;
  final String name;
  final String email;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Hero(
          tag: 'profile',
          child: CircleAvatar(
            radius: 40,
            backgroundImage: CachedNetworkImageProvider(
              image ??
                  "https://www.tenforums.com/geek/gars/images/2/types/thumb_15951118880user.png",
            ),
          ),
        ),
        SizedBox(
          height: 6,
        ),
        Hero(
          tag: 'nameText',
          child: Material(
            color: Colors.transparent,
            child: Text(
              name,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: Colors.white,
              ),
            ),
          ),
        ),
        Text(
          email,
          style: GoogleFonts.dmSans(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.white54,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Container(
            width: MediaQuery.of(context).size.width / 1.65,
            decoration: BoxDecoration(
              color: Color(0xFF1a2b3f),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  uid,
                  style: GoogleFonts.poppins(
                    color: Colors.white54,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    FontAwesomeIcons.copy,
                    color: Colors.white,
                    size: 18,
                  ),
                  onPressed: () {
                    HapticFeedback.mediumImpact();
                    Clipboard.setData(
                      new ClipboardData(
                        text: uid,
                      ),
                    ).whenComplete(() {
                      Fluttertoast.showToast(
                        msg: "copied to clipboard",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                      );
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
