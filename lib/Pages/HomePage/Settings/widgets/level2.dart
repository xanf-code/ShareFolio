import 'dart:io';

import 'package:audioplayer/audioplayer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/Models/user_db.dart';
import 'package:my_app/Pages/HomePage/Settings/EditPage/edit_image.dart';
import 'package:my_app/Services/Authentication_service/auth_service.dart';
import 'package:my_app/Services/firebase_services/services.dart';
import 'package:my_app/State/function_states.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:record/record.dart';

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
  bool isRecording = false;
  AudioPlayer audioPlayer = AudioPlayer();
  File _audio;

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
                    backgroundImage: CachedNetworkImageProvider(
                      document.profileImage.toString() == " "
                          ? "https://www.tenforums.com/geek/gars/images/2/types/thumb_15951118880user.png"
                          : document.profileImage.toString(),
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
                    GestureDetector(
                      onTap: () {
                        HapticFeedback.mediumImpact();
                        isRecording == false ? recordAudio() : stopRecording();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            isRecording == false
                                ? FeatherIcons.mic
                                : FeatherIcons.stopCircle,
                            color: Colors.white54,
                            size: 15,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          if (isRecording == false)
                            Text(
                              "Record Bio",
                              style: GoogleFonts.dmSans(
                                color: Colors.white54,
                              ),
                            )
                          else
                            const Padding(
                              padding: EdgeInsets.only(left: 4.0),
                              child: SpinKitWave(
                                color: Colors.white,
                                size: 15,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Visibility(
                  // ignore: avoid_bool_literals_in_conditional_expressions
                  visible: document.audioLink != " " ? true : false,
                  child: IconButton(
                    icon: const Icon(
                      FeatherIcons.volume,
                      color: Colors.white,
                    ),
                    onPressed: () async {
                      HapticFeedback.mediumImpact();
                      await audioPlayer.play(
                        document.audioLink.toString(),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Future<void> recordAudio() async {
    final bool result = await Record.hasPermission();
    if (result == true && Platform.isAndroid) {
      final Directory tempDir = await getExternalStorageDirectory();
      final String tempPath =
          '${tempDir.path}/${DateTime.now().toString()}.m4a';
      final File audioFile = File(tempPath);
      await Record.start(
        path: tempPath,
        encoder: AudioEncoder.AAC_HE,
        bitRate: 256000,
        samplingRate: 48000.0,
      );
      setState(() {
        isRecording = true;
        _audio = audioFile;
      });
    }
  }

  Future<void> stopRecording() async {
    await Record.stop();
    setState(() {
      isRecording = false;
      FirebaseService().addAudio(_audio);
    });
  }
}
