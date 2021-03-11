import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_app/Pages/AuthPage/Login/Widget/FormUI.dart';
import 'package:my_app/Pages/Groups/widgets/createGroupWidgets.dart';
import 'package:my_app/Pages/Groups/widgets/formHead.dart';
import 'package:my_app/Services/firebase_services/groupServices.dart';
import 'package:my_app/Widget/auth.dart';
import 'package:my_app/Widget/const_gradient.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CreateGroup extends StatefulWidget {
  @override
  _CreateGroupState createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  int activeCategory = 0;
  TextEditingController groupName = TextEditingController();
  String type = "PUBLIC";
  TextEditingController groupBio = TextEditingController();
  File bannerImage;
  File profileImage;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: pageGradient,
          ),
          child: ListView(
            children: [
              Stack(
                children: [
                  Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.indigo,
                    child: bannerImage == null
                        ? IconButton(
                            icon: Icon(
                              FontAwesomeIcons.upload,
                              size: 20,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              HapticFeedback.mediumImpact();
                              pickBannerImage();
                            },
                          )
                        : Image.file(
                            bannerImage,
                            fit: BoxFit.cover,
                          ),
                  ),
                  Positioned(
                    top: 30,
                    left: 20,
                    child: Container(
                      width: 120,
                      height: 120,
                      child: profileImage == null
                          ? IconButton(
                              icon: Icon(
                                FontAwesomeIcons.upload,
                                size: 20,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                HapticFeedback.mediumImpact();
                                pickProfileImage();
                              },
                            )
                          : ClipOval(
                              child: CircleAvatar(
                                child: Image.file(
                                  profileImage,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFe0f2f1),
                        border: Border.all(
                          width: 2,
                          color: Color(0xFFD90B0B),
                          style: BorderStyle.solid,
                        ),
                      ),
                    ),
                  ),
                  bannerImage != null
                      ? Positioned(
                          right: 10,
                          bottom: 10,
                          child: GestureDetector(
                            onTap: () {
                              HapticFeedback.mediumImpact();
                              setState(() {
                                bannerImage = null;
                              });
                            },
                            child: Container(
                              height: 30,
                              width: 100,
                              decoration: BoxDecoration(
                                color: Colors.black87,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                child: Text(
                                  "Clear",
                                  style: GoogleFonts.dmSans(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      : SizedBox.shrink(),
                  profileImage != null
                      ? Positioned(
                          top: 80,
                          left: 30,
                          child: GestureDetector(
                            onTap: () {
                              HapticFeedback.mediumImpact();
                              setState(() {
                                profileImage = null;
                              });
                            },
                            child: Container(
                              height: 30,
                              width: 100,
                              decoration: BoxDecoration(
                                color: Colors.black87,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                child: Text(
                                  "Clear",
                                  style: GoogleFonts.dmSans(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      : SizedBox.shrink()
                ],
              ),
              FormHead(),
              createForm(),
            ],
          ),
        ),
      ),
    );
  }

  Widget createForm() {
    String currentUser = Providers.of(context).auth.getCurrentUserUID();
    String currentUserName = Providers.of(context).auth.getCurrentUserName();
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CreateGroupWidget(
          groupName: groupName,
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 37.0,
            bottom: 10,
          ),
          child: Row(
            children: List.generate(
              2,
              (index) {
                return Padding(
                  padding: const EdgeInsets.only(
                    right: 12,
                    bottom: 8,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      setState(
                        () {
                          activeCategory = index;
                          index == 0 ? type = "PUBLIC" : type = "PRIVATE";
                        },
                      );
                    },
                    child: Container(
                      width: 90,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        border: Border.all(
                          width: 2,
                          color: activeCategory == index
                              ? Color(0xffbb85fb)
                              : Colors.transparent,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 3.0,
                          right: 3,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            activeCategory == index
                                ? Icon(
                                    FeatherIcons.check,
                                    color: Color(0xff6506d5),
                                    size: 15,
                                  )
                                : Icon(
                                    FeatherIcons.circle,
                                    color: Colors.white60,
                                    size: 15,
                                  ),
                            Text(
                              index == 0 ? "PUBLIC" : "PRIVATE",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: FieldWidget(
            length: 10,
            label: "GROUP DESCRIPTION",
            hint: 'What is this group about?',
            controller: groupBio,
            isObscure: false,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {
                reset();
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 30.0, top: 10.0),
                child: Container(
                  width: 75,
                  height: 75,
                  child: Icon(
                    FeatherIcons.x,
                    size: 24,
                    color: Colors.white,
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF7934ff),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                HapticFeedback.mediumImpact();
                if (groupName.text.isEmpty && groupBio.text.isEmpty) {
                  showTopSnackBar(
                    context,
                    CustomSnackBar.error(
                      message: "One or More fields empty",
                    ),
                  );
                } else {
                  switch (type) {
                    case "PRIVATE":
                      privateGroups(currentUser, currentUserName);
                      break;
                    case "PUBLIC":
                      publicGroups(currentUser, currentUserName);
                      break;
                    default:
                      showTopSnackBar(
                        context,
                        CustomSnackBar.error(
                          message: "something went wrong :(",
                        ),
                      );
                      break;
                  }
                }
              },
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 30.0,
                  right: 30,
                  top: 10,
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.8,
                  height: 75,
                  decoration: BoxDecoration(
                    color: Color(0xFF7934ff),
                    borderRadius: BorderRadius.circular(35),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Create Group",
                        style: GoogleFonts.dmSans(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Icon(
                        FeatherIcons.arrowRightCircle,
                        color: Colors.white,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  privateGroups(
    currentUser,
    currentUserName,
  ) async {
    String downloadImage = await groupServices().uploadImage(bannerImage);
    String profileImageURL = await groupServices().uploadImage(profileImage);
    groupServices()
        .createPrivateGroup(groupName.text, groupBio.text, type, currentUser,
            currentUserName, downloadImage, profileImageURL)
        .whenComplete(() {
      groupName.clear();
      groupBio.clear();
      setState(() {
        profileImage = null;
        bannerImage = null;
      });
      showTopSnackBar(
        context,
        CustomSnackBar.success(
          message: "Group Created",
        ),
      );
    });
  }

  publicGroups(currentUser, currentUserName) async {
    String downloadImage = await groupServices().uploadImage(bannerImage);
    String profileImageURL = await groupServices().uploadImage(profileImage);
    groupServices()
        .createPublicGroup(groupName.text, groupBio.text, type, currentUser,
            currentUserName, downloadImage, profileImageURL)
        .whenComplete(() {
      groupName.clear();
      groupBio.clear();
      setState(() {
        bannerImage = null;
        profileImage = null;
      });
      showTopSnackBar(
        context,
        CustomSnackBar.success(
          message: "Group Created",
        ),
      );
    });
  }

  reset() {
    HapticFeedback.mediumImpact();
    groupName.clear();
    groupBio.clear();
    setState(() {
      bannerImage = null;
      profileImage = null;
    });
  }

  Future pickProfileImage() async {
    final fileImage = await ImagePicker().getImage(source: ImageSource.gallery);
    if (fileImage != null) {
      setState(() {
        profileImage = File(fileImage.path);
      });
    }
  }

  Future pickBannerImage() async {
    final fileImage = await ImagePicker().getImage(source: ImageSource.gallery);
    if (fileImage != null) {
      setState(() {
        bannerImage = File(fileImage.path);
      });
    }
  }
}
