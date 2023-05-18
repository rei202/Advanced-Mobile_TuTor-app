import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:lettutor/env/env.dart';
import 'package:http/http.dart' as http;
import 'package:lettutor/models/Course.dart';

class CourseService {
  static Future<List<CourseModel>?> getCourseList(int page, int size) async {
    List<CourseModel> courseList = <CourseModel>[];

    try {
      final box = GetStorage();
      String? token = await box.read('token');
      // print("token: " + token!);
      var url = Uri.https(baseUrl, 'course', {
        'size': '$size',
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
        var courses = jsonDecode(response.body)['data']['rows'];
        for (var course in courses) {
          courseList.add(CourseModel.fromJson(course));
        }
        return courseList;
      } else {
        return null;
      }
    } on Error catch (_) {
      return null;
    }
  }

  static Future<List<CourseModel>?> searchCourse(int page, int size,
      String searchString, String categoryId, int level) async {
    List<CourseModel> courseList = <CourseModel>[];

    try {
      final box = GetStorage();
      String? token = await box.read('token');
      // print("token: " + token!);
      var queryParams = {
        'size': '$size',
        'page': '$page',
        'q': '$searchString'
      };
      if (categoryId != "-1" && level != -1)
        queryParams = {
          'size': '$size',
          'page': '$page',
          'q': '$searchString',
          'level[]': '$level',
          'categoryId[]': '$categoryId'
        };
      else if (categoryId == "-1" && level != -1)
        queryParams = {
          'size': '$size',
          'page': '$page',
          'q': '$searchString',
          'level[]': '$level',
        };
      else if (categoryId != "-1" && level == -1)
        queryParams = {
          'size': '$size',
          'page': '$page',
          'q': '$searchString',
          'categoryId[]': '$categoryId'
        };
      var url = Uri.https(baseUrl, 'course', queryParams);
      var response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      print(page);
      if (response.statusCode == 200) {
        var courses = jsonDecode(response.body)['data']['rows'];
        for (var course in courses) {
          courseList.add(CourseModel.fromJson(course));
        }
        return courseList;
      } else {
        return null;
      }
    } on Error catch (_) {
      return null;
    }
  }

  static Future<CourseModel?> getCourse(String courseId) async {
    try {
      final box = GetStorage();
      String? token = await box.read('token');
      // print("token: " + token!);
      var url = Uri.https(baseUrl, 'course/$courseId');
      var response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      if (response.statusCode == 200) {
        var course = jsonDecode(response.body)['data'];

        return CourseModel.fromJson(course);
      } else {
        return null;
      }
    } on Error catch (_) {
      return null;
    }
  }
}
