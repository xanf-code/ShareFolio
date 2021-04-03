import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EduDropDown extends StatelessWidget {
  final Function(String value) onChange;
  final String hint;
  final List<String> itemList;
  const EduDropDown({Key key, this.onChange, this.hint, this.itemList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 8.0,
        left: 45,
        bottom: 12,
        right: 22,
      ),
      child: DropdownButtonFormField<String>(
        dropdownColor: Colors.black,
        icon: const Icon(
          FluentSystemIcons.ic_fluent_chevron_down_regular,
          color: Colors.white54,
          size: 14,
        ),
        elevation: 0,
        focusColor: Colors.white,
        style: const TextStyle(color: Colors.white),
        iconEnabledColor: Colors.black,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.transparent,
              width: 0.0,
            ),
          ),
          filled: false,
          fillColor: Colors.grey.withOpacity(0.05),
        ),
        items: itemList.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }).toList(),
        hint: Text(
          hint,
          style: GoogleFonts.dmSans(
            fontSize: 16,
            color: Colors.white54,
            fontWeight: FontWeight.bold,
          ),
        ),
        onChanged: onChange,
      ),
    );
  }
}
