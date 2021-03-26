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
      'email': '',
      'name': '',
      'profileImage':
          'https://firebasestorage.googleapis.com/v0/b/mynewapp-4d204.appspot.com/o/user%2Fprofile%2FDTWyAsbvSadZSjv26HcpqjK5rSu1%2Fprofile?alt=media&token=4a90e16e-dca3-42ab-8a1f-0eaed9c542e5',
      'ref_link': '',
      "uid": '',
    });
  }
}
