import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/Pages/HomePage/Settings/EditPage/edit_image.dart';
import 'package:my_app/Services/Authentication_service/auth_service.dart';
import 'package:my_app/Services/firebase_services/services.dart';
import 'package:path_provider/path_provider.dart';
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
            .doc(widget._authService.getCurrentUserUID())
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
                visible: userDocument["audioLink"] != " " ? true : false,
                child: IconButton(
                  icon: const Icon(
                    FeatherIcons.volume,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    HapticFeedback.mediumImpact();
                    await audioPlayer.play(
                      userDocument["audioLink"].toString(),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  File _audio;
  Future<void> recordAudio() async {
    const String folderName = "bio_audio_files";
    final bool result = await Record.hasPermission();
    if (result == true && Platform.isAndroid) {
      final Directory tempDir = await getExternalStorageDirectory();
      final String tempPath =
          '${tempDir.path}/${DateTime.now().toString()}.m4a';
      final File audioFile = File(tempPath);
      await Record.start(path: tempPath);
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
