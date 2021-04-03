import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class Level3 extends StatelessWidget {
  final IconData icon;
  const Level3({
    Key key,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width / 2.2,
        margin: const EdgeInsets.only(
          top: 30.0,
          bottom: 30,
          //left: 12,
        ),
        padding: const EdgeInsets.only(
          top: 20.0,
          bottom: 20,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFF101010),
          border: Border.all(
            color: const Color(0xFF212121),
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          icon,
          color: Colors.white,
        ),
      ),
    );
  }
}

class Level2Form extends StatelessWidget {
  final String type;
  const Level2Form({
    Key key,
    this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 35.0,
        top: 30,
        bottom: 16,
      ),
      child: Text(
        type,
        style: GoogleFonts.dmSans(
          color: Colors.white54,
          fontSize: 16,
        ),
      ),
    );
  }
}

class Level1Form extends StatelessWidget {
  final String type;
  const Level1Form({
    Key key,
    this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      type,
      style: GoogleFonts.dmSans(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 36,
      ),
    );
  }
}

class FieldWidget extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final bool isObscure;
  final int length;
  final Color fillColor;
  final MaxLengthEnforcement maxLengthEnforcement;

  const FieldWidget({
    Key key,
    this.label,
    this.hint,
    this.controller,
    this.isObscure,
    this.length,
    this.fillColor,
    this.maxLengthEnforcement,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 37.0,
            bottom: 10,
          ),
          child: Text(
            label,
            style: GoogleFonts.dmSans(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 35.0,
            right: 35,
          ),
          child: TextFormField(
            textCapitalization: TextCapitalization.sentences,
            maxLengthEnforcement:
                maxLengthEnforcement ?? MaxLengthEnforcement.none,
            maxLength: 130,
            maxLines: length ?? 1,
            obscureText: isObscure,
            controller: controller,
            style: GoogleFonts.dmSans(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle:
                  GoogleFonts.dmSans(fontSize: 16, color: Colors.white54),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  width: 2,
                  style: BorderStyle.none,
                ),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.transparent,
                  width: 0.0,
                ),
              ),
              filled: true,
              fillColor: fillColor,
              contentPadding: const EdgeInsets.all(25),
            ),
          ),
        ),
      ],
    );
  }
}

class ButtonContainer extends StatelessWidget {
  final String type;

  const ButtonContainer({Key key, this.type}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 30.0,
        right: 30,
        top: 10,
      ),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 75,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: [0.1, 0.5],
            colors: [
              Color(0xFF00c6ff),
              Color(0xFF0072ff),
            ],
          ),
        ),
        child: Center(
          child: Text(
            type,
            style: GoogleFonts.dmSans(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class BottomText extends StatelessWidget {
  final String text1;
  final String text2;

  const BottomText({Key key, this.text1, this.text2}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text1,
            style: GoogleFonts.dmSans(
              color: Colors.white54,
              fontWeight: FontWeight.w200,
              fontSize: 16,
            ),
          ),
          Text(
            text2,
            style: GoogleFonts.dmSans(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
