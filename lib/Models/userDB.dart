import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String name;
  String email;
  String uid;
  String profileImage;
  String status;

  UserModel({
    this.name,
    this.email,
    this.uid,
    this.profileImage,
    this.status,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'uid': uid,
        'profileImage': profileImage,
        'status': status,
      };

  // UserModel.fromSnapshot(DocumentSnapshot snapshot)
  //     : name = snapshot.data()["name"],
  //       email = snapshot.data()["email"],
  //       uid = snapshot.data()["uid"],
  //       profileImage = snapshot.data()["profileImage"];
}
