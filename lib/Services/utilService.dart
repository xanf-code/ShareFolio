import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_app/Models/userDB.dart';

class UserService {
  UserModel _userFromFirebaseSnapshot(DocumentSnapshot snapshot) {
    return snapshot != null
        ? UserModel(
            accCreated: snapshot.data()["accCreated"] ?? '',
            email: snapshot.data()['email'] ?? '',
            name: snapshot.data()['name'] ?? '',
            profileImageUrl: snapshot.data()['profileImageUrl'] ?? '',
            uid: snapshot.data()["uid"],
          )
        : null;
  }

  Stream<UserModel> getUserInfo(uid) {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .snapshots()
        .map(_userFromFirebaseSnapshot);
  }
}
