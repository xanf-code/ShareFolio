import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_app/Services/firebase_services/services.dart';
import 'package:my_app/Services/utils/image_utils.dart';
import 'package:my_app/Widget/constants.dart';
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
            shrinkWrap: true,
            children: [
              TextButton(
                onPressed: () {
                  getImage();
                },
                child: const Text("Pick Image"),
              ),
              if (_profileImage != null)
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _profileImage = null;
                    });
                  },
                  // ignore: sized_box_for_whitespace
                  child: Container(
                    height: 300,
                    width: MediaQuery.of(context).size.width,
                    child: Image.file(
                      _profileImage,
                    ),
                  ),
                  // ignore: sized_box_for_whitespace
                )
              else
                // ignore: sized_box_for_whitespace
                Container(
                  height: 300,
                  width: MediaQuery.of(context).size.width,
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
                child: Container(
                  height: 50,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF1565C0),
                        Color(0xFFb92b27),
                      ],
                      begin: FractionalOffset(0.0, 0.0),
                      end: FractionalOffset(1.0, 0.0),
                      stops: [0.0, 1.0],
                    ),
                  ),
                  child: Center(
                    child: uploading == true
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : Text(
                            "Submit",
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                  ),
                ),
              ),
              //GRID VIEW OF IMAGES
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
                    child: Card(
                      color: _selectedIndex == index
                          ? Colors.blue
                          : Colors.transparent,
                      child: ClipOval(
                        child: CachedNetworkImage(
                          height: 20,
                          imageUrl: images[index].toString(),
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
