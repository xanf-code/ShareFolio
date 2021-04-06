import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_app/Services/Authentication_service/auth_service.dart';
import 'package:my_app/Services/firebase_services/services.dart';
import 'package:my_app/Services/utils/upload_utils.dart';
import 'file:///C:/Users/darshan/AndroidStudioProjects/my_app/lib/constants.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class EditImage extends StatefulWidget {
  @override
  _EditImageState createState() => _EditImageState();
}

class _EditImageState extends State<EditImage> {
  File _profileImage;
  final picker = ImagePicker();
  final FirebaseService _firebaseService = FirebaseService();
  bool uploading = false;
  final UtilsService _utils = UtilsService();
  int _selectedIndex = 0;
  final AuthService _authService = AuthService();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            gradient: pageGradient,
          ),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 20.0,
                  right: 20,
                  top: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        getImage();
                      },
                      child: Row(
                        children: [
                          Text(
                            "Upload",
                            style: GoogleFonts.dmSans(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          const Icon(
                            FeatherIcons.image,
                            color: Colors.blue,
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        HapticFeedback.mediumImpact();
                        if (_profileImage != null) {
                          setState(() {
                            uploading = true;
                          });
                          _firebaseService.updateProfile(_profileImage);
                        } else {
                          showTopSnackBar(
                            context,
                            const CustomSnackBar.error(
                              message: "No Image Picked!",
                            ),
                          );
                        }
                      },
                      child: Center(
                        child: uploading == true
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : Text(
                                "Save",
                                style: GoogleFonts.dmSans(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
              if (_profileImage != null)
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10.0,
                    bottom: 20,
                  ),
                  child: Container(
                    height: 400,
                    width: MediaQuery.of(context).size.width,
                    child: Image.file(
                      _profileImage,
                    ),
                  ),
                )
              else
                StreamBuilder(
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
                    return Padding(
                      padding: const EdgeInsets.only(
                        top: 10.0,
                        bottom: 20,
                      ),
                      child: Container(
                        height: 400,
                        child: ExtendedImage.network(
                          userDocument["profileImage"].toString() == " "
                              ? "https://www.tenforums.com/geek/gars/images/2/types/thumb_15951118880user.png"
                              : userDocument["profileImage"].toString(),
                        ),
                      ),
                    );
                  },
                ),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: images.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      _selectedIndex = index;
                      selectImage(index);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 0,
                        shadowColor: Colors.transparent,
                        color: _selectedIndex == index
                            ? const Color(0xFF1e1d19)
                            : Colors.transparent,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipOval(
                            child: ExtendedImage.network(
                              images[index].toString(),
                              height: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future selectImage(int index) async {
    final File obtainedFile = await _utils.urlToFile(images[index].toString());
    setState(() {
      _profileImage = obtainedFile;
    });
  }
}
