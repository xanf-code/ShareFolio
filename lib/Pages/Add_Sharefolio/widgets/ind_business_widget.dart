import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/Pages/AuthPage/Login/Widget/form_ui.dart';
import 'package:my_app/Services/API/suggestion.dart';
import 'package:my_app/Services/Authentication_service/auth_service.dart';
import 'package:my_app/State/function_states.dart';
import 'package:my_app/Widget/constants.dart';
import 'package:provider/provider.dart';

import 'dropdown_suggestion.dart';
import 'education_name.dart';

class TypeContainer extends StatefulWidget {
  @override
  _TypeContainerState createState() => _TypeContainerState();
}

class _TypeContainerState extends State<TypeContainer> {
  int _selectedIndex = 0;
  String type = 'Individual';
  final TextEditingController nameController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final APIServices _apiServices = APIServices();
  String location;
  String logo;
  final List _location = [];

  @override
  void initState() {
    super.initState();
    locationController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    locationController.removeListener(_onSearchChanged);
    locationController.dispose();
    super.dispose();
  }

  // ignore: always_declare_return_types
  _onSearchChanged() {
    _apiServices.getLocationResults(
        locationController.text, _location, "LocationTag");
  }

  List name = [
    {
      "name": "Individual",
    },
    {
      "name": "Organisation",
    },
  ];

  final List<IconData> iconsImage = [
    FluentSystemIcons.ic_fluent_person_accounts_regular,
    FluentSystemIcons.ic_fluent_organization_regular,
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 8.0,
            left: 22,
          ),
          child: Text(
            "Who are you?",
            style: GoogleFonts.poppins(
              color: primary,
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 20.0,
            right: 22,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              name.length,
              (index) {
                return GestureDetector(
                  onTap: () {
                    setState(
                      () {
                        _selectedIndex = index;
                        type = name[index]["name"].toString();
                      },
                    );
                  },
                  child: Stack(
                    children: [
                      Positioned(
                        top: 10,
                        left: 20,
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: primary,
                            ),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          child: Visibility(
                            // ignore: avoid_bool_literals_in_conditional_expressions
                            visible: _selectedIndex == index ? true : false,
                            child: const Center(
                              child: Icon(
                                FluentSystemIcons
                                    .ic_fluent_checkmark_circle_filled,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width / 2.5,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: _selectedIndex == index
                                ? primary
                                : Colors.transparent,
                          ),
                          color: Colors.grey.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              iconsImage[index],
                              color: _selectedIndex == index
                                  ? Colors.white
                                  : Colors.white54,
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Text(
                              name[index]["name"].toString(),
                              style: GoogleFonts.redHatDisplay(
                                color: _selectedIndex == index
                                    ? Colors.white
                                    : Colors.white54,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 22.0,
            //bottom: 8,
          ),
          child: FieldWidget(
            label: _selectedIndex == 0 ? "Your Name" : "Organisation Name",
            length: 1,
            controller: nameController,
            isObscure: false,
            hint: "Name",
            fillColor: Colors.grey.withOpacity(0.05),
          ),
        ),
        const Education_Name(
          text: "Location",
        ),
        DropDown_Suggestion(
          placeList: _location,
          name: locationController,
          onSuggestionSelected: (suggestion) {
            setState(() {
              locationController.text =
                  suggestion["tag"]["display_name"].toString();
              logo = suggestion["tag"]["pic"].toString();
            });
          },
          type: "LocationTag",
          hint: "Ex: London",
        ),
        Padding(
          padding: const EdgeInsets.only(
            bottom: 8.0,
            top: 8,
          ),
          child: FieldWidget(
            label:
                _selectedIndex == 0 ? "About Yourself" : "About Organisation",
            length: 6,
            controller: bioController,
            isObscure: false,
            hint: "About",
            fillColor: Colors.grey.withOpacity(0.05),
            maxLengthEnforcement: MaxLengthEnforcement.enforced,
          ),
        ),
        GestureDetector(
          onTap: () {
            HapticFeedback.lightImpact();
            Provider.of<FirebaseFunctions>(context, listen: false)
                .createAboutShareFolio(
              context,
              type,
              nameController.text,
              bioController.text,
              locationController.text,
              AuthService().getCurrentUserUID(),
            );
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
      ],
    );
  }
}
