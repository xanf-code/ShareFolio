import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/Models/user_db.dart';
import 'package:my_app/Pages/Add_Sharefolio/main_add_page.dart';
import 'package:my_app/Pages/HomePage/MainHome/widgets/sliver_app_bar.dart';
import 'package:my_app/Pages/demo.dart';
import 'package:my_app/State/function_states.dart';
import 'file:///C:/Users/darshan/AndroidStudioProjects/my_app/lib/constants.dart';
import 'package:provider/provider.dart';
import 'MainPage_columns/popular_categories.dart';
import 'MainPage_columns/ranked_sharefolios.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            stops: [0.0, 1.0, 1.5],
            colors: [
              Color(0xFF08051a),
              Color(0xFF07041b),
              Color(0xFF081631),
            ],
          ),
        ),
        child: StreamProvider<UserModel>.value(
          initialData: Provider.of<FirebaseFunctions>(context).initialData(),
          value: Provider.of<FirebaseFunctions>(context).userInfo(),
          child: Consumer<UserModel>(
            builder: (context, UserModel document, child) {
              return CustomScrollView(
                shrinkWrap: true,
                slivers: [
                  SliverAppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    expandedHeight: 120,
                    floating: true,
                    flexibleSpace: FlexibleSpaceBar(
                      background: SliverBar(
                        name: document.name,
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: 20.0,
                            top: 22,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 2.5,
                                height: 100,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: primary,
                                  ),
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    HapticFeedback.lightImpact();
                                    Get.to(
                                      () => MainAddPage(),
                                      fullscreenDialog: true,
                                    );
                                  },
                                  icon: const Icon(
                                    FluentSystemIcons
                                        .ic_fluent_add_circle_filled,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                //REMOVE LATER
                                onTap: () {
                                  Get.to(
                                    () => Demo(),
                                  );
                                },
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width / 2.5,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: primary,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "CARDS",
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Ranked(),
                        const SizedBox(
                          height: 20,
                        ),
                        const PopularCategories(),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
