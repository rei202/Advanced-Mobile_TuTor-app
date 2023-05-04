import 'dart:convert';
import 'dart:developer';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lettutor/env/env.dart';
import 'package:lettutor/models/FavoriteTutor.dart';
import 'package:lettutor/models/Tutor.dart';
import 'package:http/http.dart' as http;
import '../models/Feedback.dart';

import '../models/TutorSchedule.dart';

class CallService {
  static Future<int> getTotalTimeLesson() async {
    try {
      final box = GetStorage();
      String? token = await box.read('token');
      // print("token: " + token!);
      var url = Uri.https(baseUrl, 'call/total');
      var response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      if (response.statusCode == 200) {
        int timeInMinutes = jsonDecode(response.body)['total'];

        return timeInMinutes;
      } else {
        return 0;
      }
    } on Error catch (_) {
      return 0;
    }
  }
}
