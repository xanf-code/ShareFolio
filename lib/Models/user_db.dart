import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String name;
  String email;
  String uid;
  String profileImage;
  String ref_link;
  String bio;
  UserModel({
    this.bio,
    this.name,
    this.email,
    this.uid,
    this.profileImage,
    this.ref_link,
  });

  UserModel.fromMap(Map<String, dynamic> map)
      : name = map['name'].toString() ?? '',
        email = map['email'].toString() ?? '',
        uid = map['uid'].toString() ?? '',
        profileImage = map['profileImage'].toString() ?? '',
        ref_link = map['ref_link'].toString() ?? '',
        bio = map['bio'].toString();

  UserModel.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(
          snapshot.data(),
        );
}
