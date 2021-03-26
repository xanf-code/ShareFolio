import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:my_app/Models/user_db.dart';
import 'package:my_app/Pages/HomePage/Settings/EditPage/edit_username.dart';
import 'package:my_app/Services/Authentication_service/auth_service.dart';
import 'package:my_app/State/function_states.dart';
import 'package:my_app/Widget/menu_items.dart';
import 'package:provider/provider.dart';

class Level4 extends StatelessWidget {
  final AuthService authService;
  const Level4({
    Key key,
    this.authService,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 25.0,
        right: 25,
        top: 25,
        bottom: 12,
      ),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: const Color(0xFF21212b),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20.0,
            right: 20,
            //top: 20,
          ),
          child: StreamProvider<UserModel>.value(
            initialData: Provider.of<FirebaseFunctions>(context).initialData(),
            value: Provider.of<FirebaseFunctions>(context).userInfo(),
            child: Consumer<UserModel>(
              builder: (context, UserModel document, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        HapticFeedback.mediumImpact();
                        Get.to(
                          () => EditUserName(
                            userName: document.name.toString(),
                          ),
                          fullscreenDialog: true,
                          preventDuplicates: true,
                        );
                      },
                      child: MenuItems(
                        title: "Display Name",
                        titleText: document.name.toString(),
                        button: "Edit",
                        visibility: true,
                        icon: FeatherIcons.user,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        HapticFeedback.mediumImpact();
                        //LOGIC
                        debugPrint("TAPPED");
                      },
                      child: MenuItems(
                        title: "Email",
                        titleText: document.email.toString(),
                        button: "Edit",
                        visibility: false,
                        icon: FeatherIcons.mail,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
