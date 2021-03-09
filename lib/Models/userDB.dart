import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String name;
  String email;
  String uid;

  UserModel(
    this.name,
    this.email,
    this.uid,
  );

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'uid': uid,
      };

  UserModel.fromSnapshot(DocumentSnapshot snapshot)
      : name = snapshot.data()["name"],
        email = snapshot.data()["email"],
        uid = snapshot.data()["uid"];
}
