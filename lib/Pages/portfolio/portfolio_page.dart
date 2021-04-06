import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/Pages/AuthPage/Login/Widget/form_ui.dart';
import 'package:my_app/Pages/Error_page/dynamic_no_exits_error.dart';
import 'file:///C:/Users/darshan/AndroidStudioProjects/my_app/lib/constants.dart';

class ShareFolioPage extends StatefulWidget {
  final String uid;

  const ShareFolioPage({Key key, this.uid}) : super(key: key);

  @override
  _ShareFolioPageState createState() => _ShareFolioPageState();
}

class _ShareFolioPageState extends State<ShareFolioPage>
    with SingleTickerProviderStateMixin {
  final FirebaseFirestore _instance = FirebaseFirestore.instance;
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: pageGradient,
        ),
        child: StreamBuilder(
          stream: _instance.collection('users').doc(widget.uid).snapshots(),
          builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            final userDocument = snapshot.data;
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (!snapshot.data.exists) {
              return Dynamic404();
            }
            return Padding(
              padding: const EdgeInsets.only(
                top: 20.0,
                left: 12,
                right: 12,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 20.0),
                    child: Level1Form(
                      type: "About me",
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 22.0),
                    child: Center(
                      child: Container(
                        height: 110,
                        width: MediaQuery.of(context).size.width / 1.2,
                        color: Colors.transparent,
                        child: TabBar(
                          controller: _tabController,
                          indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              20.0,
                            ),
                            color: const Color(0xFF1f1e25),
                          ),
                          tabs: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  FeatherIcons.user,
                                  color: Colors.white,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "About Me",
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  FeatherIcons.briefcase,
                                  color: Colors.white,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Experience",
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  FeatherIcons.award,
                                  color: Colors.white,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Education",
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      physics: const BouncingScrollPhysics(),
                      controller: _tabController,
                      children: [
                        Center(
                          child: Text(
                            userDocument["name"].toString(),
                            style: GoogleFonts.redHatDisplay(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Page1(),
                        Page1(),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class Page1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Place Bid',
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }
}
