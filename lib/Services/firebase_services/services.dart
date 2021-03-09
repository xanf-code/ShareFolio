import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_app/Widget/auth.dart';

class FirebaseService {
  Future createUserDatabase(context, name, email, uid, photoURL, docUID) async {
    await FirebaseFirestore.instance.collection("users").doc(docUID).set({
      "name": name,
      "email": email,
      "uid": uid,
      'profileImage': photoURL ?? " ",
    });
  }
}
