import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class APIServices {
  Future<List> getLocationResults(String input, List suggestionList) async {
    if (input.isEmpty) {
      debugPrint("INPUT EMPTY");
    }
    try {
      const String baseURL =
          'https://autocomplete.clearbit.com/v1/companies/suggest';
      final String request = '$baseURL?query=$input';
      final Response response = await Dio().get(request);
      final List predictions = response.data as List;
      // ignore: parameter_assignments
      suggestionList = predictions;
    } catch (e) {
      debugPrint(e.message.toString());
    }
    return suggestionList;
  }
}
