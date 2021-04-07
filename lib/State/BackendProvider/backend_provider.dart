import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:my_app/Models/EducationModel/education_model.dart';
import 'package:my_app/Services/Authentication_service/auth_service.dart';

class BackendProvider extends ChangeNotifier {
  EducationModel educationModel;
  final AuthService _authService = AuthService();

  // ignore: missing_return
  Future<EducationModel> getUserEducationData() async {
    try {
      final Dio dio = Dio();
      final response = await dio.get(
          "https://sharefoliodevapi.herokuapp.com/education/${_authService.getCurrentUserUID()}");
      if (response.statusCode == 200) {
        educationModel =
            EducationModel.fromJson(response.data as Map<String, dynamic>);
        notifyListeners();
        return educationModel;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
