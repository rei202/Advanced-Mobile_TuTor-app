import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lettutor/env/env.dart';
import 'package:lettutor/models/FavoriteTutor.dart';
import 'package:lettutor/models/Tutor.dart';
import 'package:http/http.dart' as http;
import '../models/Feedback.dart';
import 'dart:async';
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';

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

  static Future<List<FeedBack>?> getReview(
      int page, int perPage, String userId) async {
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

  static Future<List<Tutor>?> getFavoriteTutorList(
      int page, int perPage) async {
    List<Tutor> favoriteTutorList = <Tutor>[];

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
          if(favorite['secondInfo'] != null)
            favoriteTutorList.add(Tutor.fromJsonFavorite(favorite['secondInfo']));
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


  // static Future<Map<String,>> becomeTutor(String name, String country, String birthday, String interests, String education, String experience,
  //     String profession, String languages, String bio, String targetStudent, String specialties, File avatar, File video, int price) async {
  //   FormData formData = FormData.fromMap({
  //     'name': name,
  //     'country': country,
  //     'birthday': birthday,
  //     'interests': interests,
  //     'education': education,
  //     'experience': experience,
  //     'profession': profession,
  //     'languages': languages,
  //     'bio': bio,
  //     'targetStudent': targetStudent,
  //     'specialties': specialties,
  //     'avatar': await MultipartFile.fromFile(avatar.path, filename: avatar.path.split('/').last),
  //     'video': await MultipartFile.fromFile(video.path, filename: video.path.split('/').last),
  //     'price': price
  //   });
  //
  //   Dio dio = Dio();
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //
  //   dio.options.headers["Content-Type"] = "multipart/form-data; boundary=<calculated when request is sent>";
  //   dio.options.headers["Authorization"] = "Bearer ${prefs.getString("access")}";
  //
  //   final response = await dio.postUri(Uri.parse('$_url/tutor/register'), data: formData);
  //   if (response.statusCode == 200) {
  //     return _parseMessage("Become a teacher success!", 200);
  //   } else {
  //     return _parseMessage(response.data, response.statusCode!);
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
      print(response.body);
      if (response.statusCode == 200) {
        final jsonRes = json.decode(response.body);
        if (jsonRes["result"] == 1) return false;
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
