import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_app/Pages/Add_Sharefolio/widgets/dropdown_suggestion.dart';
import 'package:my_app/Pages/Add_Sharefolio/widgets/edu_dropdown.dart';
import 'package:my_app/Pages/Add_Sharefolio/widgets/education_level_1.dart';
import 'package:my_app/Pages/Add_Sharefolio/widgets/education_name.dart';
import 'package:my_app/Pages/Add_Sharefolio/widgets/next_button.dart';
import 'package:my_app/Pages/AuthPage/Login/Widget/form_ui.dart';
import 'package:my_app/Services/Authentication_service/auth_service.dart';
import 'package:my_app/State/function_states.dart';
import 'file:///C:/Users/darshan/AndroidStudioProjects/my_app/lib/constants.dart';
import 'package:provider/provider.dart';

class Education extends StatefulWidget {
  @override
  _EducationState createState() => _EducationState();
}

class _EducationState extends State<Education> {
  String type;
  String logo;
  String startDate;
  String endDate;
  final TextEditingController description = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _field = TextEditingController();
  final List _placeList = [];
  bool _uploading = false;

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
            EducationForm_Level1(),
            EduDropDown(
              hint: "University/School",
              itemList: [
                'School',
                'University',
              ],
              onChange: (String value) {
                setState(() {
                  type = value;
                });
              },
            ),
            const Education_Name(
              text: "Name",
            ),
            DropDown_Suggestion(
              placeList: _placeList,
              name: _name,
              onSuggestionSelected: (suggestion) {
                setState(() {
                  _name.text = suggestion["tag"]["display_name"].toString();
                  logo = suggestion["tag"]["pic"].toString();
                });
              },
              type: "CollegeTag",
              hint: "Ex: Oxford University",
            ),
            FieldWidget(
              length: 1,
              label: "Field",
              hint: "Ex: Computer Science",
              isObscure: false,
              controller: _field,
              fillColor: Colors.grey.withOpacity(0.05),
            ),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Education_Name(
                      text: "Start Date",
                    ),
                    Container(
                      color: Colors.transparent,
                      width: MediaQuery.of(context).size.width / 2.5,
                      child: EduDropDown(
                        hint: "Start Date",
                        itemList: years,
                        onChange: (String value) {
                          setState(() {
                            startDate = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Education_Name(
                      text: "End Date",
                    ),
                    Container(
                      color: Colors.transparent,
                      width: MediaQuery.of(context).size.width / 2.5,
                      child: EduDropDown(
                        itemList: years,
                        hint: "End Date",
                        onChange: (String value) {
                          setState(() {
                            endDate = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
            FieldWidget(
              length: 7,
              label: "Description",
              hint: " ",
              isObscure: false,
              controller: description,
              fillColor: Colors.grey.withOpacity(0.05),
            ),
            GestureDetector(
              onTap: () {
                HapticFeedback.lightImpact();
                setState(() {
                  _uploading = true;
                });
                Provider.of<FirebaseFunctions>(context, listen: false)
                    .createEducation(
                  context,
                  type ?? "School",
                  _name.text,
                  _field.text,
                  startDate.toString() ?? "2021",
                  endDate.toString() ?? "2021",
                  description.text ?? " ",
                  logo ?? " ",
                  AuthService().getCurrentUserUID(),
                )
                    .whenComplete(() {
                  setState(() {
                    _uploading = false;
                  });
                });
              },
              child: NextButton(
                text: "Next Step",
                uploading: _uploading,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
