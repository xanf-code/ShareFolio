import 'package:flutter/material.dart';
import 'package:my_app/Models/userDB.dart';
import 'package:my_app/Pages/HomePage/Widget/welcome_widget.dart';
import 'package:my_app/Services/firebase_services/services.dart';
import 'package:my_app/Widget/HomePage/appBar.dart';
import 'package:my_app/Widget/auth.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserModel>(
      stream:
          FirebaseService(uid: Provider.of(context).auth.getCurrentUserUID())
              .userData,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return Container(
          decoration: myBoxDecoration(),
          child: ListView(
            children: [
              MainAppBar(
                image: snapshot.data.profileImage,
                userName: snapshot.data.name,
              ),
              WelcomeText(
                userName: snapshot.data.name,
              ),
            ],
          ),
        );
      },
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
}
