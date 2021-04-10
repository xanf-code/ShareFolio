import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardsTextField extends StatelessWidget {
  final String type;
  final TextInputType keyboardType;
  final TextEditingController controller;
  const CardsTextField({
    Key key,
    this.type,
    this.controller,
    this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          color: const Color(0xff1b1d21),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 12.0,
                  top: 12,
                ),
                child: Row(
                  children: [
                    Text(
                      type,
                      style: GoogleFonts.dmSans(
                        color: Colors.white54,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    const Icon(
                      FluentSystemIcons.ic_fluent_chevron_down_circle_regular,
                      size: 16,
                      color: Colors.white54,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 8.0,
                  top: 8,
                  bottom: 8,
                  right: 12,
                ),
                child: CupertinoTextField.borderless(
                  controller: controller,
                  keyboardType: keyboardType,
                  suffixMode: OverlayVisibilityMode.editing,
                  suffix: GestureDetector(
                    onTap: () {
                      controller.clear();
                    },
                    child: const Icon(
                      CupertinoIcons.clear_circled_solid,
                      color: Colors.white54,
                      size: 17,
                    ),
                  ),
                  textCapitalization: TextCapitalization.sentences,
                  style: GoogleFonts.dmSans(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
