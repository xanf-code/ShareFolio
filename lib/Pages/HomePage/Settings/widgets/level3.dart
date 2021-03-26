import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/Models/user_db.dart';
import 'package:my_app/Services/Authentication_service/auth_service.dart';
import 'package:my_app/State/function_states.dart';
import 'package:my_app/State/generate_dynamic_link.dart';
import 'package:my_app/Widget/bottom_card.dart';
import 'package:provider/provider.dart';

class Level3 extends StatelessWidget {
  final AuthService authService;
  final GenerateLink dynamicLinkService;

  const Level3({Key key, this.authService, this.dynamicLinkService})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserModel>.value(
      initialData: Provider.of<FirebaseFunctions>(context).initialData(),
      value: Provider.of<FirebaseFunctions>(context).userInfo(),
      child: Consumer<UserModel>(
        builder: (context, UserModel document, child) {
          return document.ref_link != " "
              ? Padding(
                  padding: const EdgeInsets.only(
                    left: 25.0,
                    top: 25,
                    right: 25,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            FeatherIcons.share2,
                            color: Colors.blue,
                            size: 14,
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          Text(
                            "ShareFolio Link",
                            style: GoogleFonts.poppins(
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: const Color(0xFF21212b),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 1.3,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  document.ref_link.toString(),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.poppins(
                                    color: Colors.white54,
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(
                                FontAwesomeIcons.share,
                                color: Colors.white70,
                                size: 15,
                              ),
                              onPressed: () {
                                HapticFeedback.lightImpact();
                                _modalBottomSheetMenu(
                                    context, document.ref_link);
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(
                    left: 25.0,
                    top: 25,
                    right: 25,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "ShareFolio Link",
                        style: GoogleFonts.poppins(
                          color: const Color(0xFFBB86FC),
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Center(
                        child: TextButton(
                          onPressed: () {
                            dynamicLinkService.generateLink(
                              authService.getCurrentUserUID(),
                              context,
                              "${document.name} | ShareFolio",
                              "${document.name}(@${document.name}) | ShareFolio- Personal Profile Link",
                              document.profileImage.toString() == " "
                                  ? "https://www.tenforums.com/geek/gars/images/2/types/thumb_15951118880user.png"
                                  : document.profileImage.toString(),
                            );
                          },
                          child: const Text("Show Link"),
                        ),
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }

  void _modalBottomSheetMenu(BuildContext context, String userDocument) {
    showModalBottomSheet(
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      context: context,
      builder: (builder) {
        return CardBottom(
          userDocument: userDocument,
        );
      },
    );
  }
}
