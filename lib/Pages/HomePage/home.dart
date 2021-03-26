import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:my_app/Models/user_db.dart';
import 'package:my_app/Pages/HomePage/MainHome/home_page.dart';
import 'package:my_app/Pages/HomePage/SearchPage/search.dart';
import 'package:my_app/Pages/HomePage/Settings/settings.dart';
import 'package:my_app/State/function_states.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int pageIndex = 0;
  List<Widget> pages = [
    HomePage(),
    SearchPage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          getBody(),
          Align(
            alignment: Alignment.bottomCenter,
            child: getFooter(),
          ),
        ],
      ),
    );
  }

  Widget getBody() {
    return IndexedStack(
      index: pageIndex,
      children: pages,
    );
  }

  Widget getFooter() {
    final List<Widget> iconItems = [
      Icon(
        FeatherIcons.home,
        color: pageIndex == 0 ? Colors.yellow : Colors.white,
      ),
      Icon(
        FeatherIcons.search,
        color: pageIndex == 1 ? Colors.yellow : Colors.white,
      ),
      StreamProvider<UserModel>.value(
        initialData: Provider.of<FirebaseFunctions>(context).initialData(),
        value: Provider.of<FirebaseFunctions>(context).userInfo(),
        child: Consumer<UserModel>(
          builder: (context, UserModel document, child) {
            return CircleAvatar(
              radius: 15,
              backgroundColor: Colors.transparent,
              backgroundImage:
                  CachedNetworkImageProvider(document.profileImage),
            );
          },
        ),
      ),
    ];

    return Padding(
      padding: const EdgeInsets.only(
        left: 20.0,
        right: 20,
        bottom: 12,
      ),
      child: Container(
        width: MediaQuery.of(context).size.width / 1.4,
        height: 65,
        decoration: BoxDecoration(
          color: const Color(0xff121212),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              3,
              (int index) {
                return InkWell(
                  onTap: () {
                    HapticFeedback.mediumImpact();
                    selectedTab(index);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        color: Colors.transparent,
                        child: iconItems[index],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Visibility(
                        // ignore: avoid_bool_literals_in_conditional_expressions
                        visible: pageIndex == index ? true : false,
                        child: Container(
                          width: 5,
                          height: 5,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFFe0f2f1),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  // ignore: type_annotate_public_apis, always_declare_return_types
  selectedTab(int index) {
    setState(() {
      pageIndex = index;
    });
  }
}
