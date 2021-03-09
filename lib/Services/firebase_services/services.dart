import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_app/Widget/auth.dart';

class FirebaseService {
  Future getUserData(context) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(Provider.of(context).auth.getCurrentUserUID())
        .set({
      "name": Provider.of(context).auth.getCurrentUserName(),
      "email": Provider.of(context).auth.getCurrentUserEmail(),
      "uid": Provider.of(context).auth.getCurrentUserUID(),
    });
  }
}
