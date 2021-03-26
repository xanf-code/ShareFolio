import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String name;
  String email;
  String uid;
  String profileImage;
  String ref_link;
  String audioLink;

  UserModel({
    this.name,
    this.email,
    this.uid,
    this.profileImage,
    this.ref_link,
    this.audioLink,
  });

  UserModel.fromMap(Map<String, dynamic> map)
      : name = map['name'].toString() ?? '',
        email = map['email'].toString() ?? '',
        uid = map['uid'].toString() ?? '',
        profileImage = map['profileImage'].toString() ?? '',
        ref_link = map['ref_link'].toString() ?? '',
        audioLink = map['audioLink'].toString() ?? '';

  UserModel.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(
          snapshot.data(),
        );
}
