import 'dart:collection';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:my_app/Models/user_db.dart';
import 'package:my_app/Services/Authentication_service/auth_service.dart';
import 'package:my_app/Services/utils/upload_utils.dart';

class FirebaseService {
  final String uid;
  final UtilsService _utilsService = UtilsService();
  final AuthService _authService = AuthService();

  FirebaseService({this.uid});

  Future createUserDatabase(BuildContext context, String name, String email,
      String uid, String photoURL, String docUID) async {
    final snapShot =
        await FirebaseFirestore.instance.collection('users').doc(docUID).get();
    if (!snapShot.exists) {
      await FirebaseFirestore.instance.collection("users").doc(docUID).set({
        "name": name,
        "email": email,
        "uid": uid,
        'profileImage': photoURL ?? " ",
        "ref_link": " ",
        "audioLink": " ",
        "bio": " ",
      });
    }
  }

  // user data from snapshots
  UserModel _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return snapshot != null
        ? UserModel(
            uid: uid,
            name: snapshot.data()['name'].toString(),
            email: snapshot.data()["email"].toString(),
            profileImage: snapshot.data()["profileImage"].toString(),
            ref_link: snapshot.data()["ref_link"].toString(),
            audioLink: snapshot.data()["audioLink"].toString(),
            bio: snapshot.data()['bio'].toString(),
          )
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

  Future updateUserName(String docUID, String name) async {
    await FirebaseFirestore.instance.collection("users").doc(docUID).update({
      "name": name,
    });
  }

  Future<void> updateProfile(File _profileImage) async {
    String profileImage = '';

    if (_profileImage != null) {
      profileImage = await _utilsService.uploadFile(_profileImage,
          'user/profile/${FirebaseAuth.instance.currentUser.uid}/profile');
    }

    final Map<String, Object> data = HashMap();

    data['profileImage'] = profileImage;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(_authService.getCurrentUserUID())
        .update(data);

    Get.back();
  }

  Future<void> addAudio(File _audio) async {
    String audioInitial = '';

    if (_audio != null) {
      audioInitial = await _utilsService.uploadAudioFile(_audio,
          'user/profile/${FirebaseAuth.instance.currentUser.uid}/bio.m4a');
    }

    final Map<String, Object> data = HashMap();

    data['audioLink'] = audioInitial;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(_authService.getCurrentUserUID())
        .update(data);

    Get.back();
  }
}
