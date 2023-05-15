import 'dart:convert';
import 'dart:developer';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lettutor/env/env.dart';
import 'package:lettutor/models/Booking.dart';
import 'package:lettutor/models/FavoriteTutor.dart';
import 'package:lettutor/models/Tutor.dart';
import 'package:http/http.dart' as http;
import '../models/Feedback.dart';

import '../models/TutorSchedule.dart';

class ClassService {
  static Future<Map<String, dynamic>> cancelBookingClass(
      String scheduleId, int cancelReasonId, String note) async {
    try {
      final box = GetStorage();
      String? token = await box.read('token');
      final url = Uri.https(baseUrl, 'booking/schedule-detail');
      final cancelInfo = {'cancelReasonId': cancelReasonId, 'note': note};
      final body = {'scheduleDetailId': scheduleId, 'cancelInfo': cancelInfo};

      final response = await http.delete(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        final jsonRes = json.decode(response.body);
        final String message = jsonRes["message"];
        return {'isSuccess': true, 'message': message};
      } else {
        final jsonRes = json.decode(response.body);
        final String message = jsonRes["message"];
        return {
          'isSuccess': false,
          'message': message,
        };
      }
    } on Error catch (_) {
      return {'isSuccess': false};
    }
  }
  static Future<Map<String, dynamic>> bookClass(
      String scheduleId, String notes) async {
    try {
      final box = GetStorage();
      String? token = await box.read('token');
      List<String> array = [];
      array.add(scheduleId);
      final url = Uri.https(baseUrl, 'booking');
      final body = {'scheduleDetailIds': array, 'note': notes};

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
        final String message = jsonRes["message"];
        return {'isSuccess': true, 'message': message};
      } else {
        final jsonRes = json.decode(response.body);
        final String message = jsonRes["message"];
        final int statusCode = jsonRes["statusCode"];
        return {
          'isSuccess': false,
          'message': message,
          'statusCode': statusCode
        };
      }
    } on Error catch (_) {
      return {'isSuccess': false};
    }
  }

  static Future<List<Booking>?> getBookingList(int timeStampNow) async {
    try {
      final box = GetStorage();
      String? token = await box.read('token');
      final url = Uri.https(baseUrl, 'booking/next', {
        'dateTime': '${timeStampNow}',
      });

      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      });

      if (response.statusCode == 200) {
        final jsonRes = json.decode(response.body);
        final List<dynamic> bookingListJson = jsonRes["data"];
        return bookingListJson.map((item) => Booking.fromJson(item)).toList();
      } else {
        return null;
      }
    } on Error catch (_) {
      return null;
    }
  }

  static Future<List<Booking>?> getsortedBookingList(
      int page, int perPage, int timeStampNow, String sortBy) async {
    try {
      final box = GetStorage();
      String? token = await box.read('token');
      final url = sortBy == 'asc' ? Uri.https(baseUrl, 'booking/list/student', {
        'page': '$page',
        'perPage': '$perPage',
        'dateTimeGte': '$timeStampNow',
        'orderBy': 'meeting',
        'sortBy': sortBy,
      }) : Uri.https(baseUrl, 'booking/list/student', {
        'page': '$page',
        'perPage': '$perPage',
        'dateTimeLte': '$timeStampNow',
        'orderBy': 'meeting',
        'sortBy': sortBy,
      });

      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      });
      print(page);
      if (response.statusCode == 200) {
        final jsonRes = json.decode(response.body);
        final List<dynamic> bookingListJson = jsonRes["data"]["rows"];
        return bookingListJson.map((item) => Booking.fromJson(item)).toList();
      } else {
        return null;
      }
    } on Error catch (_) {
      return null;
    }
  }
}
