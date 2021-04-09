import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:my_app/Models/CardsModel/cards_model.dart';
import 'package:my_app/Models/EducationModel/education_model.dart';
import 'package:my_app/Models/SkillsModel/skills_model.dart';
import 'package:my_app/Models/UserAboutModel/about_model.dart';
import 'package:my_app/Services/Authentication_service/auth_service.dart';

class BackendProvider extends ChangeNotifier {
  EducationModel educationModel;
  AboutModel aboutModel;
  SkillsModel skillsModel;
  CardsModel cardsModel;
  final AuthService _authService = AuthService();

  //GET USER EDUCATION
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

  //GET USER ABOUT
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

  //GET USER SKILLS
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

  //GET USER CARDS
  // ignore: missing_return
  Future<CardsModel> getUserCards() async {
    try {
      final Dio dio = Dio();
      final response = await dio.get(
          "https://sharefoliodevapi.herokuapp.com/cards/${_authService.getCurrentUserUID()}");
      if (response.statusCode == 200) {
        cardsModel = CardsModel.fromJson(response.data as Map<String, dynamic>);
        notifyListeners();
        return cardsModel;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  //ADD USER CARDS
  Future addUserCards(
    String UUID,
    String name,
    String title,
    String company,
    String email,
    String phno,
    String fb,
    String twitter,
    String insta,
    String linkedin,
    String shareFolio,
  ) async {
    dynamic formData = {
      "UUID": UUID,
      "name": name,
      "title": title,
      "company": company,
      "email": email,
      "phoneNumber": phno,
      "socials": {
        "facebook": fb,
        "twitter": twitter,
        "instagram": insta,
        "linkedin": linkedin,
        "sharefolio": shareFolio,
      },
    };
    try {
      final Dio dio = Dio();
      final response = await dio.post(
        "https://sharefoliodevapi.herokuapp.com/cards/add",
        data: formData,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
      );
      if (response.data["Status"] == "OK") {
        return response;
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
