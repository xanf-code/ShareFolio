import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class APIServices {
  Future<List> getLocationResults(
      String input, List suggestionList, String type) async {
    if (input.isEmpty) {
      debugPrint("INPUT EMPTY");
    }
    try {
      const String baseURL = 'https://angel.co/autocomplete/new_tags';
      final String request = '$baseURL?query=$input&tag_type=$type';
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
