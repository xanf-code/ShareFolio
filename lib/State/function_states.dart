import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:my_app/Services/firebase_services/services.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class FirebaseFunctions extends ChangeNotifier {
  String _error;

  Future<String> updateUserName(
      String docUID, String name, BuildContext context) {
    try {
      FirebaseService().updateUserName(docUID, name);
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
}
