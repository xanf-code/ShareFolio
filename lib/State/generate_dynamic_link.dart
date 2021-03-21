import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_app/Services/Authentication_service/auth_service.dart';
import 'package:my_app/Services/dynamic_link/dynamic_link_service.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class GenerateLink extends ChangeNotifier {
  String _error;
  String _link = " ";
  final DynamicLinkService _dynamicLinkService = DynamicLinkService();
  final AuthService _authService = AuthService();

  Future<String> generateLink(String userID, BuildContext context, String title,
      String desc, String image) async {
    try {
      _link = await _dynamicLinkService.createUserLink(
        _authService.getCurrentUserUID(),
        title,
        desc,
        image,
      );
      if (_link != null) {
        FirebaseFirestore.instance
            .collection("users")
            .doc(_authService.getCurrentUserUID())
            .update({
          "ref_link": _link,
        });
      } else {
        debugPrint("LINK IS NULL");
      }
    } catch (error) {
      _error = error.message.toString();

      if (_error != null) {
        showTopSnackBar(
          context,
          CustomSnackBar.error(
            message: _error,
          ),
        );
      }
    }
    notifyListeners();
    return "success";
  }
}
