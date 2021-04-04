import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/Pages/Add_Sharefolio/widgets/dropdown_suggestion.dart';
import 'package:my_app/Pages/Add_Sharefolio/widgets/next_button.dart';
import 'package:my_app/Services/Authentication_service/auth_service.dart';
import 'package:my_app/State/function_states.dart';
import 'package:my_app/Widget/constants.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class SkillsPage extends StatefulWidget {
  @override
  _SkillsPageState createState() => _SkillsPageState();
}

class _SkillsPageState extends State<SkillsPage> {
  List<String> skills = [];
  final TextEditingController skill = TextEditingController();
  String logo;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: pageGradient,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: ListView(
                shrinkWrap: true,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.15,
                        child: DropDown_Suggestion(
                          placeList: skills,
                          name: skill,
                          onSuggestionSelected: (suggestion) {
                            setState(() {
                              skill.text =
                                  suggestion["tag"]["display_name"].toString();
                              logo = suggestion["tag"]["pic"].toString();
                            });
                          },
                          type: "SkillTag",
                          hint: "Ex: Google Analytics",
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          if (skill.text.isEmpty) {
                            showTopSnackBar(
                              context,
                              const CustomSnackBar.error(
                                message: "Field cannot be empty!",
                              ),
                            );
                          } else {
                            setState(() {
                              skills.add(skill.text);
                              skill.clear();
                            });
                          }
                        },
                      ),
                    ],
                  ),
                  GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      childAspectRatio: 1.7,
                    ),
                    shrinkWrap: true,
                    itemCount: skills.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            skills.removeAt(index);
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey.withOpacity(0.1),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                skills[index],
                                style: GoogleFonts.dmSans(
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                HapticFeedback.lightImpact();
                Provider.of<FirebaseFunctions>(context, listen: false)
                    .createSkills(
                  context,
                  skills,
                  AuthService().getCurrentUserUID(),
                );
              },
              child: const NextButton(
                text: "Next Step",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
