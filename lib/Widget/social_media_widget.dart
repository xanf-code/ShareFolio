import 'package:flutter/material.dart';

import 'cards_text_widget.dart';

class SocialMediaWidget extends StatelessWidget {
  const SocialMediaWidget({
    Key key,
    @required this.facebookController,
    @required this.instagramController,
    @required this.twitterController,
    @required this.linkedinController,
    @required this.sharefolioController,
  }) : super(key: key);

  final TextEditingController facebookController;
  final TextEditingController instagramController;
  final TextEditingController twitterController;
  final TextEditingController linkedinController;
  final TextEditingController sharefolioController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CardsTextField(
          type: "Facebook",
          controller: facebookController,
        ),
        CardsTextField(
          type: "Instagram",
          controller: instagramController,
        ),
        CardsTextField(
          type: "Twitter",
          controller: twitterController,
        ),
        CardsTextField(
          type: "LinkedIn",
          controller: linkedinController,
        ),
        CardsTextField(
          type: "ShareFolio",
          controller: sharefolioController,
        ),
      ],
    );
  }
}
