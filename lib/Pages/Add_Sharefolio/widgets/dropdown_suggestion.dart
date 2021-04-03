import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/Services/API/suggestion.dart';

class DropDown_Suggestion extends StatelessWidget {
  final APIServices _apiServices = APIServices();
  final List placeList;
  final TextEditingController name;
  final Function(dynamic) onSuggestionSelected;

  DropDown_Suggestion(
      {Key key, this.onSuggestionSelected, this.placeList, this.name})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 35.0, right: 35, bottom: 8),
      child: TypeAheadField(
        suggestionsBoxDecoration: const SuggestionsBoxDecoration(
          color: Colors.black,
        ),
        hideSuggestionsOnKeyboardHide: true,
        textFieldConfiguration: TextFieldConfiguration(
          textCapitalization: TextCapitalization.words,
          controller: name,
          style: GoogleFonts.dmSans(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          decoration: InputDecoration(
            hintText: "Ex: Oxford University",
            hintStyle: GoogleFonts.dmSans(fontSize: 16, color: Colors.white54),
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
            fillColor: Colors.grey.withOpacity(0.05),
            contentPadding: const EdgeInsets.all(25),
          ),
        ),
        itemBuilder: (context, suggestion) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.transparent,
                  backgroundImage: ExtendedNetworkImageProvider(
                    suggestion["logo"].toString(),
                    cache: true,
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Text(
                  suggestion["name"].toString(),
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        },
        onSuggestionSelected: onSuggestionSelected,
        suggestionsCallback: (String pattern) {
          return _apiServices.getLocationResults(pattern, placeList);
        },
      ),
    );
  }
}
