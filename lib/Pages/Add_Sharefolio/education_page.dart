import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/Pages/AuthPage/Login/Widget/form_ui.dart';
import 'package:my_app/Widget/constants.dart';
import 'package:dio/dio.dart';

class Education extends StatefulWidget {
  @override
  _EducationState createState() => _EducationState();
}

class _EducationState extends State<Education> {
  String type;
  final TextEditingController _name = TextEditingController();
  final TextEditingController _field = TextEditingController();
  List _placesList = [];

  @override
  void initState() {
    super.initState();
    _name.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _name.removeListener(_onSearchChanged);
    _name.dispose();
    super.dispose();
  }

  // ignore: always_declare_return_types
  _onSearchChanged() {
    getLocationResults(_name.text);
  }

  // ignore: avoid_void_async
  void getLocationResults(String input) async {
    if (input.isEmpty) {
      debugPrint("INPUT EMPTY");
    }
    try {
      const String baseURL =
          'https://autocomplete.clearbit.com/v1/companies/suggest';
      final String request = '$baseURL?query=$input';
      final Response response = await Dio().get(request);
      final List predictions = response.data as List;

      setState(() {
        _placesList = predictions;
      });
    } catch (e) {
      debugPrint(e.message.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: pageGradient,
        ),
        child: ListView(
          shrinkWrap: true,
          children: [
            const Padding(
              padding: EdgeInsets.only(
                left: 22.0,
                top: 8,
              ),
              child: Level1Form(
                type: "Education",
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 22,
                left: 22,
              ),
              child: Text(
                "Tell us about yourself",
                style: GoogleFonts.poppins(
                  color: primary,
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 37.0,
              ),
              child: Text(
                "Type",
                style: GoogleFonts.dmSans(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 8.0,
                left: 22,
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
                items: <String>[
                  'School',
                  'University',
                ].map<DropdownMenuItem<String>>((String value) {
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
                  "University/School",
                  style: GoogleFonts.dmSans(
                    color: Colors.white54,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                onChanged: (String value) {
                  setState(() {
                    type = value;
                  });
                },
              ),
            ),
            FieldWidget(
              length: 1,
              label: "Name",
              hint: "Ex: Oxford University",
              isObscure: false,
              controller: _name,
              fillColor: Colors.grey.withOpacity(0.05),
            ),
            FieldWidget(
              length: 1,
              label: "Field",
              hint: "Ex: Computer Science",
              isObscure: false,
              controller: _field,
              fillColor: Colors.grey.withOpacity(0.05),
            ),
            GestureDetector(
              onTap: () {
                HapticFeedback.lightImpact();
                // Provider.of<FirebaseFunctions>(context, listen: false)
                //     .createEducation(
                //   context,
                //   type,
                //   _name.text,
                //   _field.text,
                //   " ",
                //   " ",
                //   " ",
                //   " ",
                //   AuthService().getCurrentUserUID(),
                // );
              },
              child: Container(
                height: 60,
                width: MediaQuery.of(context).size.width,
                color: primary,
                child: Center(
                  child: Text(
                    "Next Step",
                    style: GoogleFonts.dmSans(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            // ListView.builder(
            //   shrinkWrap: true,
            //   itemCount: _placesList.length,
            //   itemBuilder: (BuildContext context, int index) {
            //     return Padding(
            //       padding: const EdgeInsets.all(8.0),
            //       child: GestureDetector(
            //         onTap: () {
            //           setState(() {
            //             _name.text = _placesList[index]["name"].toString();
            //           });
            //         },
            //         child: Text(
            //           _placesList[index]["name"].toString(),
            //           style: const TextStyle(
            //             color: Colors.white,
            //           ),
            //         ),
            //       ),
            //     );
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}

//School/University ..
//Name ..
//Field
//Start Date
//End Date
//Description
//Years
