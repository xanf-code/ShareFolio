import 'dart:developer';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/Pages/AuthPage/Login/Widget/form_ui.dart';
import 'package:my_app/Services/Authentication_service/auth_service.dart';
import 'package:my_app/State/BackendProvider/backend_provider.dart';
import 'package:my_app/Widget/cards_text_widget.dart';
import 'package:my_app/Widget/social_media_widget.dart';
import 'package:my_app/constants.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class AddCards extends StatefulWidget {
  @override
  _AddCardsState createState() => _AddCardsState();
}

class _AddCardsState extends State<AddCards> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController companyController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController facebookController = TextEditingController();
  final TextEditingController twitterController = TextEditingController();
  final TextEditingController instagramController = TextEditingController();
  final TextEditingController linkedinController = TextEditingController();
  final TextEditingController sharefolioController = TextEditingController();
  final AuthService authService = AuthService();
  bool socialSwitch = false;
  bool uploading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: pageGradient,
        ),
        child: ListView(
          shrinkWrap: true,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 12.0,
                bottom: 18,
                right: 12,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Level1Form(
                    type: "Add Cards 💳",
                  ),
                  if (uploading == false)
                    TextButton(
                      onPressed: () {
                        if (nameController.text.isEmpty ||
                            titleController.text.isEmpty ||
                            companyController.text.isEmpty ||
                            emailController.text.isEmpty) {
                          showTopSnackBar(
                            context,
                            const CustomSnackBar.error(
                              message: "One or more fields cannot be empty!",
                            ),
                          );
                        } else {
                          addCards();
                        }
                      },
                      child: const Text("Add"),
                    )
                  else
                    const Center(
                      child: CircularProgressIndicator(),
                    ),
                ],
              ),
            ),
            CardsTextField(
              type: "Name",
              controller: nameController,
            ),
            CardsTextField(
              type: "Title",
              controller: titleController,
            ),
            CardsTextField(
              type: "Company",
              controller: companyController,
            ),
            CardsTextField(
              type: "Email",
              controller: emailController,
            ),
            CardsTextField(
              type: "Phone Number",
              controller: phoneController,
              keyboardType: TextInputType.phone,
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 20.0,
                left: 8,
                right: 8,
                bottom: 20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Add Social Media Links",
                    style: GoogleFonts.dmSans(
                      color: Colors.white54,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  CupertinoSwitch(
                    value: socialSwitch,
                    onChanged: (value) {
                      setState(() {
                        socialSwitch = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            if (socialSwitch == true)
              SocialMediaWidget(
                facebookController: facebookController,
                instagramController: instagramController,
                twitterController: twitterController,
                linkedinController: linkedinController,
                sharefolioController: sharefolioController,
              ),
          ],
        ),
      ),
    );
  }

  void addCards() {
    setState(() {
      uploading = true;
      Provider.of<BackendProvider>(context, listen: false)
          .addUserCards(
        authService.getCurrentUserUID(),
        nameController.text,
        titleController.text,
        companyController.text,
        emailController.text,
        phoneController.text,
        facebookController.text,
        twitterController.text,
        instagramController.text,
        linkedinController.text,
        sharefolioController.text,
      )
          .whenComplete(() {
        uploading = false;
        Get.back();
      });
    });
  }
}
