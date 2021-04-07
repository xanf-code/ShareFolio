import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:my_app/Models/EducationModel/education_model.dart';
import 'package:my_app/Models/SkillsModel/skills_model.dart';
import 'package:my_app/Models/UserAboutModel/about_model.dart';
import 'package:my_app/Services/Authentication_service/auth_service.dart';

class BackendProvider extends ChangeNotifier {
  EducationModel educationModel;
  AboutModel aboutModel;
  SkillsModel skillsModel;
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

  // ignore: missing_return
  Future<AboutModel> getUserAboutData() async {
    try {
      final Dio dio = Dio();
      final response = await dio.get(
          "https://sharefoliodevapi.herokuapp.com/sharefolio/${_authService.getCurrentUserUID()}");
      if (response.statusCode == 200) {
        aboutModel = AboutModel.fromJson(response.data as Map<String, dynamic>);
        notifyListeners();
        return aboutModel;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  // ignore: missing_return
  Future<SkillsModel> getUserSkillsData() async {
    try {
      final Dio dio = Dio();
      final response = await dio.get(
          "https://sharefoliodevapi.herokuapp.com/skills/${_authService.getCurrentUserUID()}");
      if (response.statusCode == 200) {
        skillsModel =
            SkillsModel.fromJson(response.data as Map<String, dynamic>);
        notifyListeners();
        return skillsModel;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
