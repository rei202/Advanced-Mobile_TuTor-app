import 'dart:convert';

import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

import '../env/env.dart';
import '../models/AuthResponse.dart';
import '../models/ResponseEntity.dart';

class AuthSocialService {
  static Future<Map<String, Object>> signInWithGoogle() async {
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;
    print(gAuth.accessToken);

    // final credential = GoogleAuthProvider.credential(
    //     accessToken: gAuth.accessToken, idToken: gAuth.idToken);
    //
    // return await FirebaseAuth.instance.signInWithCredential(credential);
    return sendTokenToserver(gAuth.accessToken!, 'auth/google');
  }

  static Future<Map<String, Object>> signInWithFacebook() async {
    final LoginResult result = await FacebookAuth.instance
        .login(); // by default we request the email and the public profile
    if (result.status == LoginStatus.success) {
      // you are logged
      final AccessToken accessToken = result.accessToken!;
      return sendTokenToserver(accessToken.token, 'auth/facebook');
    } else {
      print(result.status);
      print(result.message);
      return {
        'isSuccess': false,
        'message': 'failed'
      };
    }
  }

  static Future<Map<String, Object>> sendTokenToserver(
      String accessToken, String urlServer) async {
    try {
      var url = Uri.https(baseUrl, urlServer);
      var body = {"access_token": accessToken};
      var response = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode(body));
      if (response.statusCode == 200) {
        final box = GetStorage();
        String token = AuthResponse.fromJson(jsonDecode(response.body)).token;
        await box.write("token", token);
        // 'message': response.fromJson(jsonDecode(response.body)).message
        return {
          'isSuccess': true,
        };
      } else {
        return {
          'isSuccess': false,
          'message': ResponseEntity.fromJson(jsonDecode(response.body)).message
        };
      }
    } on Error catch (_) {
      return {'isSuccess': false, 'message': _.toString()};
    }
  }
}
