import 'dart:io';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/Models/user_db.dart';
import 'package:my_app/Pages/HomePage/Settings/EditPage/edit_image.dart';
import 'package:my_app/Services/Authentication_service/auth_service.dart';
import 'package:my_app/State/function_states.dart';
import 'package:provider/provider.dart';

class Level2 extends StatefulWidget {
  const Level2({
    Key key,
    @required AuthService authService,
  })  : _authService = authService,
        super(key: key);

  final AuthService _authService;

  @override
  _Level2State createState() => _Level2State();
}

class _Level2State extends State<Level2> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 25.0,
        top: 25,
        bottom: 8,
      ),
      child: StreamProvider<UserModel>.value(
        initialData: Provider.of<FirebaseFunctions>(context).initialData(),
        value: Provider.of<FirebaseFunctions>(context).userInfo(),
        child: Consumer<UserModel>(
          builder: (context, UserModel document, child) {
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
                    backgroundImage: ExtendedNetworkImageProvider(
                      document.profileImage.toString() == " "
                          ? "https://www.tenforums.com/geek/gars/images/2/types/thumb_15951118880user.png"
                          : document.profileImage.toString(),
                      cache: true,
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
                      document.name.toString(),
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      document.email.toString(),
                      style: GoogleFonts.dmSans(
                        fontWeight: FontWeight.w300,
                        fontSize: 16,
                        color: Colors.white54,
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
