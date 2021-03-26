import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:my_app/Models/user_db.dart';
import 'package:my_app/Services/Authentication_service/auth_service.dart';
import 'package:my_app/Services/firebase_services/services.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class FirebaseFunctions extends ChangeNotifier {
  String _error;
  final FirebaseFirestore _instance = FirebaseFirestore.instance;

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
      'audioLink': '',
      'email': '🐮',
      'name': '🐮',
      'profileImage':
          'https://mir-s3-cdn-cf.behance.net/project_modules/disp/4fd34c63874533.5abf6aa999a46.png',
      'ref_link': '',
      "uid": '🐮',
      "bio": '🐮',
    });
  }
}
