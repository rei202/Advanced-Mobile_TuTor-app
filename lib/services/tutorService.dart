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

class TutorService {
  static Future<List<Tutor>?> getTutorList(int page, int perPage) async {
    List<Tutor> tutorList = <Tutor>[];

    try {
      final box = GetStorage();
      String? token = await box.read('token');
      // print("token: " + token!);
      var url = Uri.https(baseUrl, 'tutor/more', {
        'perPage': '$perPage',
        'page': '$page',
      });
      var response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      print(page);
      if (response.statusCode == 200) {
        var tutors = jsonDecode(response.body)['tutors']['rows'];
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
  static Future<List<FeedBack>?> getReview(int page, int perPage, String userId) async {
  List<FeedBack> feedbackList = <FeedBack>[];

  try {
  final box = GetStorage();
  String? token = await box.read('token');
  // print("token: " + token!);
  var url = Uri.https(baseUrl, 'feedback/v2/${userId}', {
  'perPage': '$perPage',
  'page': '$page',
  });
  var response = await http.get(
  url,
  headers: {
  'Content-Type': 'application/json',
  'Authorization': 'Bearer $token'
  },
  );
  if (response.statusCode == 200) {
  var feedbacks = jsonDecode(response.body)['data']['rows'];
  for (var feedback in feedbacks) {
    feedbackList.add(FeedBack.fromJson(feedback));
  }
  print(page);
  return feedbackList;
  } else {
  return null;
  }
  } on Error catch (_) {
  return null;
  }
  }

  static Future<List<FavoriteTutor>?> getFavoriteTutorList(
      int page, int perPage) async {
    List<FavoriteTutor> favoriteTutorList = <FavoriteTutor>[];

    try {
      final box = GetStorage();
      String? token = await box.read('token');
      // print("token: " + token!);
      var url = Uri.https(baseUrl, 'tutor/more', {
        'perPage': '$perPage',
        'page': '$page',
      });
      var response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );

      if (response.statusCode == 200) {
        var favoriteTutors = jsonDecode(response.body)['favoriteTutor'];
        for (var favorite in favoriteTutors) {
          favoriteTutorList.add(FavoriteTutor.fromJson(favorite));
        }
        return favoriteTutorList;
      } else {
        return null;
      }
    } on Error catch (_) {
      return null;
    }
  }

  static Future<Tutor?> getTutorInfomation(String userId) async {
    try {
      final box = GetStorage();
      String? token = await box.read('token');
      var url = Uri.https(baseUrl, 'tutor/$userId');
      var response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );

      if (response.statusCode == 200) {
        return Tutor.fromTutorInforJson(jsonDecode(response.body));
      } else {
        return null;
      }
    } on Error catch (_) {
      return null;
    }
  }

// static Future<bool> manageFavoriteTutor(String id) async {
//   try {
//     var storage = const FlutterSecureStorage();
//     String? token = await storage.read(key: 'accessToken');
//     var url = Uri.https(apiUrl, 'user/manageFavoriteTutor');
//     var response = await http.post(url,
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer $token'
//         },
//         body: json.encode({
//           'tutorId': id,
//         }));
//
//     if (response.statusCode == 200) {
//       return true;
//     } else {
//       return false;
//     }
//   } on Error catch (_) {
//     return false;
//   }
// }

  static Future<List<ScheduleItem>?> getTutorSchedule(String userId) async {
    try {
      final box = GetStorage();
      String? token = await box.read('token');

      final url = Uri.https(baseUrl, 'schedule');
      final body = {'tutorId': userId};

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        final jsonRes = json.decode(response.body);
        final List<dynamic> schedule = jsonRes["data"];
        return schedule.map((item) => ScheduleItem.fromJson(item)).toList();
      } else {
        return null;
      }
    } on Error catch (_) {
      return null;
    }
  }

  static Future<bool> addTutortoFavorite(String userId) async {
    try {
      final box = GetStorage();
      String? token = await box.read('token');

      final url = Uri.https(baseUrl, 'user/manageFavoriteTutor');
      final body = {'tutorId': userId};

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on Error catch (_) {
      return false;
      ;
    }
  }

  static Future<bool> reportTutor(String userId, String content) async {
    try {
      final box = GetStorage();
      String? token = await box.read('token');

      final url = Uri.https(baseUrl, 'report');
      final body = {'tutorId': userId, 'content': content};

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on Error catch (_) {
      return false;
      ;
    }
  }
}
