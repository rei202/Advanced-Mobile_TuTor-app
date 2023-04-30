
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:get_storage/get_storage.dart';
import 'package:lettutor/env/url.dart';
import 'package:lettutor/models/ResponseEntity.dart';
import 'package:http/http.dart' as http;


import '../models/AuthResponse.dart';
import '../models/User.dart';


class AuthenService {
  static Future<Map<String, Object>> register(String name, String  email, String password) async {
    try {
      var url = Uri.https(baseUrl!, 'auth/register');
      var response = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: json.encode({
            'name': name,
            'email': email,
            'password': password,
            'source': null
          }));
      print(response);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return {
          'isSuccess': true,
          'message':
          'Register successfully, check your email to activate your account'
        };
      } else {
        return {
          'isSuccess': false,
        };
      }
    } on Error catch (_, error) {
      return {'isSuccess': false, 'message': error.toString()};
    }
  }
  static Future<Map<String, Object>> login(User user) async {
    try {
      var url = Uri.https(baseUrl, 'auth/login');
      var response = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: json.encode({
            'email': user.email,
            'password': user.password,
          }));
      print(response.body);
      if (response.statusCode == 200) {
        final box = GetStorage();
        String token = AuthResponse.fromJson(jsonDecode(response.body)).token;
        await box.write("token", token);
        // 'message': response.fromJson(jsonDecode(response.body)).message
        return{
          'isSuccess': true,
        };
      } else {
        return {
          'isSuccess': false,
          'message': ResponseEntity.fromJson(jsonDecode(response.body)).message
        };
      }
    } on Error catch (_, error) {
      return {'isSuccess': false, 'message': error.toString()};
    }
  }
  static Future<Map<String, Object>> forgotPassword(String email) async {
    try {
      var url = Uri.https(baseUrl, 'user/forgotPassword');
      var response = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: json.encode({
            'email': email,
          }));

      if (response.statusCode == 200) {
        print(response.body);
        return{
          'isSuccess': true,
        };
        // var storage = const FlutterSecureStorage();
        // String token = LoginResponse.fromJson(jsonDecode(response.body)).token;
        // await storage.write(key: 'accessToken', value: token);
        // return {
        //   'isSuccess': true,
        //   'token': token,
        // };
      } else {
        return {
          'isSuccess': false,
          'message': ResponseEntity.fromJson(jsonDecode(response.body)).message
        };
      }
    } on Error catch (_, error) {
      return {'isSuccess': false, 'message': error.toString()};
    }
  }

}
