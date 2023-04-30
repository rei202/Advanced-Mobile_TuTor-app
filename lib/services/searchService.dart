import 'dart:convert';
import 'dart:developer';
import 'dart:math';

import 'package:get_storage/get_storage.dart';
import 'package:lettutor/env/url.dart';
import 'package:lettutor/models/FavoriteTutor.dart';
import 'package:lettutor/models/Tutor.dart';
import 'package:http/http.dart' as http;

class SearchService {
  static Future<List<Tutor>?> search(
      List<String> filter, String searchString, int page, int perPage) async {
    List<Tutor> tutorList = <Tutor>[];

    try {
      final box = GetStorage();
      String? token = await box.read('token');
      final url = Uri.https(baseUrl, 'tutor/search');
      final filters = {
        'specialties': filter
      };
      final body = {
        'page': page,
        'perPage': perPage,
        'search': searchString,
        'filters': filters
      };
      print(json.encode(body)); // in ra body của request
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: json.encode(body),
      );
      print('Body: ${response.statusCode}'); // in ra body của request
      if (response.statusCode == 200) {
        var tutors = jsonDecode(response.body)['rows'];
        for (var tutor in tutors) {
          tutorList.add(Tutor.fromJson(tutor));
        }
        return tutorList;
      } else {
        return null;
      }
    } on Error catch (_) {
      return null;
    }
  }
}
