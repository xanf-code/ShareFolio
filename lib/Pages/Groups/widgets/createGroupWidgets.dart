import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/Pages/AuthPage/Login/Widget/FormUI.dart';

class CreateGroupWidget extends StatelessWidget {
  final TextEditingController groupName;

  const CreateGroupWidget({Key key, this.groupName}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: FieldWidget(
            label: "GROUP NAME",
            hint: 'Pick a group name',
            controller: groupName,
            isObscure: false,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 37.0,
            bottom: 12,
          ),
          child: Text(
            "Group Type".toUpperCase(),
            style: GoogleFonts.dmSans(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}
