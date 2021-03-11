import 'package:flutter/material.dart';
import 'package:my_app/Pages/Profile/ProfileLevels/profileLevel_2.dart';
import 'package:my_app/Widget/auth.dart';

import 'ProfileLevels/profileLevel_1.dart';

class ProfilePage extends StatelessWidget {
  final String image;
  final String name;
  final String email;
  final String uid;
  final String status;
  const ProfilePage(
      {Key key, this.image, this.name, this.email, this.uid, this.status})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: myBoxDecoration(),
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: ListView(
              children: [
                level1_profile(
                  uid: uid,
                  name: name,
                  email: email,
                  image: image,
                ),
                SizedBox(
                  height: 20,
                ),
                Divider(
                  color: Colors.white54,
                ),
                profileLevel2(
                  uid: uid,
                  status: status,
                ),
                OutlinedButton(
                  child: Text("Sign Out"),
                  onPressed: () {
                    signOut(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      gradient: const LinearGradient(
        stops: [0.0, 1.0, 1.5],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          Color(0xFF08051a),
          Color(0xFF07041b),
          Color(0xFF081631),
        ],
      ),
    );
  }

  void signOut(context) async {
    try {
      final auth = Providers.of(context).auth;
      await auth.signOut();
    } catch (e) {
      print(e);
    }
  }
}
