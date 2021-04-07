import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:my_app/Services/Authentication_service/auth_service.dart';
import 'package:my_app/constants.dart';

class BackendCalls {
  final AuthService _authService = AuthService();
  //Add user to register
  Future sendUserData(String uuid, String username, String email) async {
    final Dio dio = Dio();
    const String pathUrl = registerUserPath;
    final dynamic data = {
      "UUID": uuid,
      "username": username,
      "email": email,
    };
    final Options options = Options(
      contentType: Headers.jsonContentType,
      responseType: ResponseType.json,
      followRedirects: false,
      validateStatus: (status) {
        return status < 500;
      },
    );
    try {
      await dio.post(
        pathUrl,
        data: data,
        options: options,
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  //Add user about data
  Future<String> userAboutData(String uuid, String name, String type,
      String bio, String location) async {
    final Dio dio = Dio();
    const String pathUrl = sharefolioAboutUserPath;
    final dynamic data = {
      "UUID": uuid,
      "Name": name,
      "Type": type,
      "Bio": bio,
      "Location": location,
    };
    final Options options = Options(
      contentType: Headers.jsonContentType,
      responseType: ResponseType.json,
      followRedirects: false,
      validateStatus: (status) {
        return status < 500;
      },
    );
    try {
      await dio.post(
        pathUrl,
        data: data,
        options: options,
      );
    } catch (e) {
      debugPrint(e.toString());
    }
    return "success";
  }

  //Add user skills data
  Future sendUserSkills(String uuid, List skills) async {
    final Dio dio = Dio();
    const String pathUrl = sharefolioSkillsUserPath;
    final dynamic data = {
      "UUID": uuid,
      "skills": skills,
    };
    final Options options = Options(
      contentType: Headers.jsonContentType,
      responseType: ResponseType.json,
      followRedirects: false,
      validateStatus: (status) {
        return status < 500;
      },
    );
    try {
      await dio.post(
        pathUrl,
        data: data,
        options: options,
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  //Add user education data
  Future<String> userEducationData(
      String uuid,
      String name,
      String type,
      String description,
      String field,
      String logo,
      String startDate,
      String endDate) async {
    final Dio dio = Dio();
    const String pathUrl = sharefolioEducationUserPath;
    final dynamic data = {
      "UUID": uuid,
      "name": name,
      "type": type,
      "description": description,
      "field": field,
      "logo": logo,
      "startDate": startDate,
      "endDate": endDate,
    };
    final Options options = Options(
      contentType: Headers.jsonContentType,
      responseType: ResponseType.json,
      followRedirects: false,
      validateStatus: (status) {
        return status < 500;
      },
    );
    try {
      await dio.post(
        pathUrl,
        data: data,
        options: options,
      );
    } catch (e) {
      debugPrint(e.toString());
    }
    return "success";
  }
}
