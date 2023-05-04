import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:lettutor/env/env.dart';
import 'package:http/http.dart' as http;
import 'package:lettutor/models/Course.dart';
import 'package:lettutor/models/UserInfo.dart';
class ProfileService {
  static Future<UserInfo?> getUserInfo() async {
    try {
      final box = GetStorage();
      String? token = await box.read('token');
      // print("token: " + token!);
      var url = Uri.https(baseUrl, 'user/info');
      var response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      if (response.statusCode == 200) {
        var userInfo = jsonDecode(response.body)['user'];
        return UserInfo.fromJson(userInfo);
      } else {
        return null;
      }
    } on Error catch (_) {
      return null;
    }
  }

  static Future<UserInfo?> updateUserInfo(String name, String phone, String dob,
      String country, String level) async {
    try {
      final box = GetStorage();
      String? token = await box.read('token');
      // print("token: " + token!);
      var url = Uri.https(baseUrl, 'user/info');
      var body = {
        "name": name,
        "country": country,
        "phone": phone,
        "birthday": dob,
        "level": level,
      };
      var response = await http.put(url,
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          },
          body: json.encode(body));
      if (response.statusCode == 200) {
        var userInfo = jsonDecode(response.body)['user'];
        return UserInfo.fromJson(userInfo);
      } else {
        return null;
      }
    } on Error catch (_) {
      return null;
    }
  }
}
