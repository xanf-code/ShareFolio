import 'package:flutter/material.dart';
import 'package:my_app/Models/userDB.dart';
import 'package:my_app/Services/firebase_services/services.dart';
import 'package:my_app/Widget/HomePage/appBar.dart';
import 'package:my_app/Widget/auth.dart';
import 'package:my_app/main.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of(context).auth.getCurrentUserUID();
    return StreamBuilder<UserModel>(
      stream: FirebaseService(uid: user).userData,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return Container(
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color(0xFF08051a),
                Color(0xFF07041b),
              ],
            ),
          ),
          child: ListView(
            children: [
              MainAppBar(
                image: snapshot.data.profileImage,
                userName: snapshot.data.name,
              ),
              Center(
                child: OutlinedButton(
                  child: Text("Sign Out"),
                  onPressed: () {
                    signOut(context);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void signOut(context) async {
    try {
      final auth = Provider.of(context).auth;
      await auth.signOut();
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => HomeController(),
          ),
          (route) => false);
    } catch (e) {
      print(e);
    }
  }
}
