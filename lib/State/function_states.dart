import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:my_app/Models/user_db.dart';
import 'package:my_app/Pages/Add_Sharefolio/education_page.dart';
import 'package:my_app/Pages/Add_Sharefolio/skills_page.dart';
import 'package:my_app/Services/Authentication_service/auth_service.dart';
import 'package:my_app/Services/Backend_calls/all_calls.dart';
import 'package:my_app/Services/firebase_services/services.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class FirebaseFunctions extends ChangeNotifier {
  String _error;
  final FirebaseFirestore _instance = FirebaseFirestore.instance;
  final FirebaseService _firebaseService = FirebaseService();
  final AuthService _authService = AuthService();
  final BackendCalls _backendCalls = BackendCalls();

  Future<String> updateUserName(
      String docUID, String name, BuildContext context) async {
    try {
      await FirebaseService().updateUserName(docUID, name);
      Get.back();
      showTopSnackBar(
        context,
        const CustomSnackBar.success(
          message: "Display Name updated!",
        ),
      );
    } catch (e) {
      _error = e.message.toString();
      if (_error != null) {
        showTopSnackBar(
          context,
          CustomSnackBar.error(
            message: _error,
          ),
        );
      }
    }
  }

  Stream<UserModel> userInfo() {
    final _listModel =
        userDataStream().map((snapshot) => UserModel.fromMap(snapshot.data()));

    return _listModel;
  }

  Stream<DocumentSnapshot> userDataStream() {
    return _instance
        .collection("users")
        .doc(AuthService().getCurrentUserUID())
        .snapshots();
  }

  UserModel initialData() {
    return UserModel.fromMap({
      'email': '🐮',
      'name': '🐮',
      'profileImage':
          'https://mir-s3-cdn-cf.behance.net/project_modules/disp/4fd34c63874533.5abf6aa999a46.png',
      'ref_link': '',
      "uid": '🐮',
      "bio": '🐮',
    });
  }

  Future createAboutShareFolio(BuildContext context, String type, String name,
      String bio, String location, String userID) async {
    if (bio.length > 135) {
      showTopSnackBar(
        context,
        const CustomSnackBar.error(
          message: "Bio cannot be more than 135 characters!",
        ),
      );
    } else if (bio.isEmpty) {
      showTopSnackBar(
        context,
        const CustomSnackBar.error(
          message: "Bio cannot be empty!",
        ),
      );
    } else {
      try {
        await _backendCalls
            .userAboutData(
                _authService.getCurrentUserUID(), name, type, bio, location)
            .whenComplete(() {
          Get.off(
            () => SkillsPage(),
          );
        });
      } catch (_) {
        showTopSnackBar(
          context,
          const CustomSnackBar.error(
            message: "Something went wrong! :(",
          ),
        );
      }
    }
    notifyListeners();
  }

  Future createSkills(BuildContext context, List skills, String userID) async {
    if (skills.length > 20) {
      showTopSnackBar(
        context,
        const CustomSnackBar.error(
          message: "Maximum of 20 skills can be added.",
        ),
      );
    } else if (skills.isEmpty) {
      showTopSnackBar(
        context,
        const CustomSnackBar.error(
          message: "Skills cannot be empty!",
        ),
      );
    } else {
      try {
        await _backendCalls.sendUserSkills(userID, skills).whenComplete(() {
          Get.off(
            () => Education(),
          );
        });
      } catch (error) {
        showTopSnackBar(
          context,
          CustomSnackBar.error(
            message: error.toString(),
          ),
        );
      }
    }
    notifyListeners();
  }

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
    if (Name.isEmpty) {
      showTopSnackBar(
        context,
        const CustomSnackBar.error(
          message: "Name Field cannot be empty!",
        ),
      );
    } else {
      try {
        await _backendCalls
            .userEducationData(userID, Name, type, Description, Field,
                imageLogo, StartDate, EndDate)
            .whenComplete(() {
          Get.back();
        });
      } catch (e) {
        showTopSnackBar(
          context,
          CustomSnackBar.error(
            message: e.toString(),
          ),
        );
      }
    }
    notifyListeners();
  }
}
