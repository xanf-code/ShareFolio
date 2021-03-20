import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_app/Services/auth_service.dart';
import 'package:my_app/Services/dynamic_link_service.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class GenerateLink extends ChangeNotifier {
  String _error;
  String _link = " ";
  final DynamicLinkService _dynamicLinkService = DynamicLinkService();
  final AuthService _authService = AuthService();

  Future<String> generateLink(userID, BuildContext context) async {
    try {
      _link = await _dynamicLinkService.createUserLink(
        _authService.getCurrentUserUID(),
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
