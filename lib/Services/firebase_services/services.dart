import 'dart:collection';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:my_app/Models/user_db.dart';
import 'package:my_app/Services/Authentication_service/auth_service.dart';
import 'package:my_app/Services/Backend_calls/all_calls.dart';
import 'package:my_app/Services/utils/upload_utils.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class FirebaseService {
  final String uid;
  final UtilsService _utilsService = UtilsService();
  final AuthService _authService = AuthService();
  final BackendCalls _backendCalls = BackendCalls();
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
        "bio": " ",
      });
      await _backendCalls.sendUserData(uid, name, email);
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

  //CREATE USER SHAREFOLIO-ABOUT
  Future createAboutShareFolio(BuildContext context, String type, String name,
      String bio, String location, String userID) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(userID)
        .collection("shareFolio")
        .doc('about')
        .set({
      "name": name,
      "type": type,
      "bio": bio,
      "location": location,
      "userID": userID,
    });
  }

  //CREATE USER SHAREFOLIO-SKILLS
  Future createSkills(BuildContext context, List skills, String userID) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(userID)
        .collection("shareFolio")
        .doc('skills')
        .set({
      "skills": FieldValue.arrayUnion(skills),
    });
  }

  //CREATE USER SHAREFOLIO-EDUCATION
  String docID = Uuid().v4();
  Future createEducation(
      BuildContext context,
      String type,
      String Name,
      String Field,
      String StartDate,
      String EndDate,
      String Description,
      String imageLogo,
      String userID) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(userID)
        .collection("shareFolio")
        .doc('education')
        .collection("list")
        .doc(docID)
        .set({
      "DocID": docID,
      "Type": type,
      "Name": Name,
      "Field": Field,
      "Start Date": StartDate,
      "End Date": EndDate,
      "Description": Description,
      "Logo": imageLogo,
    }).whenComplete(() {
      docID = Uuid().v4();
    });
  }
}
