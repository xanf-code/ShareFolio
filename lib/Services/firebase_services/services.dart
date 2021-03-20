import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_app/Models/userDB.dart';

class FirebaseService {
  final String uid;

  FirebaseService({this.uid});

  Future createUserDatabase(context, name, email, uid, photoURL, docUID) async {
    await FirebaseFirestore.instance.collection("users").doc(docUID).set({
      "name": name,
      "email": email,
      "uid": uid,
      'profileImage': photoURL ?? " ",
      "ref_link": " ",
    });
  }

  // user data from snapshots
  UserModel _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return snapshot != null
        ? UserModel(
            uid: uid,
            name: snapshot.data()['name'],
            email: snapshot.data()["email"],
            profileImage: snapshot.data()["profileImage"],
            ref_link: snapshot.data()["ref_link"])
        : null;
  }

  // get user doc stream
  Stream<UserModel> get userData {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .snapshots()
        .map(_userDataFromSnapshot);
  }

  // List<UserModel> _userListFromQuerySnapshot(QuerySnapshot snapshot) {
  //   return snapshot.docs.map((doc) {
  //     return UserModel(
  //       uid: doc.id,
  //       name: doc.data()['name'] ?? '',
  //       profileImage: doc.data()['profileImage'] ?? '',
  //       email: doc.data()['email'] ?? '',
  //     );
  //   }).toList();
  // }
  //
  // Stream<List<UserModel>> queryByName(search) {
  //   return FirebaseFirestore.instance
  //       .collection("users")
  //       .orderBy("name")
  //       .startAt([search])
  //       .endAt([search + '\uf8ff'])
  //       .limit(10)
  //       .snapshots()
  //       .map(_userListFromQuerySnapshot);
  // }
}
