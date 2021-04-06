import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:my_app/constants.dart';

class BackendCalls {
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
}
