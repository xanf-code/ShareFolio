import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/Services/auth_service.dart';
import 'package:my_app/State/generate_dynamic_link.dart';

class level3 extends StatelessWidget {
  final AuthService authService;
  final GenerateLink dynamicLinkService;

  const level3({Key key, this.authService, this.dynamicLinkService})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(authService.getCurrentUserUID())
          .snapshots(),
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        var userDocument = snapshot.data;
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return userDocument["ref_link"] != " "
            ? Padding(
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
                                userDocument['ref_link'].toString(),
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
                              FontAwesomeIcons.copy,
                              color: Colors.white,
                              size: 18,
                            ),
                            onPressed: () {
                              HapticFeedback.mediumImpact();
                              Clipboard.setData(
                                ClipboardData(
                                  text: userDocument['ref_link'].toString(),
                                ),
                              ).whenComplete(
                                () {
                                  Fluttertoast.showToast(
                                    msg: "copied to clipboard",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                  );
                                },
                              );
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
                              authService.getCurrentUserUID(), context);
                        },
                        child: const Text("Show Link"),
                      ),
                    ),
                  ],
                ),
              );
      },
    );
  }
}
