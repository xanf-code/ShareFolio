import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_app/Models/userDB.dart';
import 'package:my_app/Pages/AuthPage/Login/login.dart';
import 'package:my_app/Pages/AuthPage/SignUp/SignUp.dart';
import 'package:my_app/Pages/HomePage/home.dart';
import 'package:my_app/Services/auth_service.dart';
import 'package:my_app/Widget/auth.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  //@override
  // Widget build(BuildContext context) {
  //   return Provider(
  //     db: FirebaseFirestore.instance,
  //     auth: AuthService(),
  //     child: MaterialApp(
  //       debugShowCheckedModeBanner: false,
  //       home: HomeController(),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Providers(
      db: FirebaseFirestore.instance,
      auth: AuthService(),
      child: StreamProvider<UserModel>.value(
        value: AuthService().user,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Wrapper(),
        ),
      ),
    );
  }
}

class Wrapper extends StatelessWidget {
  const Wrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);

    if (user == null) {
      return LoginForm();
    }
    return MyHomePage();
  }
}
//
// class HomeController extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final AuthService auth = Provider.of(context).auth;
//     return StreamBuilder<String>(
//       stream: auth.onAuthStateChange,
//       builder: (context, AsyncSnapshot<String> snapshot) {
//         if (snapshot.connectionState == ConnectionState.active) {
//           final bool signedIn = snapshot.hasData;
//           return signedIn ? MyHomePage() : SignUpScreen();
//         }
//         return CircularProgressIndicator();
//       },
//     );
//   }
// }
