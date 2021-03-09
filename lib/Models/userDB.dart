import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final Timestamp accCreated;
  final String email;
  final String name;
  final String profileImageUrl;
  final String uid;

  UserModel({
    this.accCreated,
    this.email,
    this.name,
    this.profileImageUrl,
    this.uid,
  });
}
