import 'dart:convert';
import 'dart:developer';
import 'dart:math';

import 'package:get_storage/get_storage.dart';
import 'package:lettutor/env/url.dart';
import 'package:lettutor/models/FavoriteTutor.dart';
import 'package:lettutor/models/Tutor.dart';
import 'package:http/http.dart' as http;

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
        var favoriteTutors =
            jsonDecode(response.body)['favoriteTutor'];
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

// static Future<Tutor?> getTutorInfomation(String id) async {
//   try {
//     var storage = const FlutterSecureStorage();
//     String? token = await storage.read(key: 'accessToken');
//     var url = Uri.https(apiUrl, 'tutor/$id');
//     var response = await http.get(
//       url,
//       headers: {
//         'Content-Type': 'application/json',
//         'Authorization': 'Bearer $token'
//       },
//     );
//
//     if (response.statusCode == 200) {
//       return Tutor.fromJson2(jsonDecode(response.body));
//     } else {
//       return null;
//     }
//   } on Error catch (_) {
//     return null;
//   }
// }

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

// static Future<List<Tutor>?> searchTutor(
//   int page,
//   int perPage, {
//   String search = '',
// }) async {
//   try {
//     var storage = const FlutterSecureStorage();
//     String? token = await storage.read(key: 'accessToken');
//     final Map<String, dynamic> args = {
//       'page': page,
//       'perPage': perPage,
//       'search': search,
//     };
//
//     final url = Uri.https(apiUrl, 'tutor/search');
//     final response = await http.post(
//       url,
//       headers: {
//         'Content-Type': 'application/json',
//         'Authorization': 'Bearer $token'
//       },
//       body: json.encode(args),
//     );
//
//     if (response.statusCode == 200) {
//       final jsonRes = json.decode(response.body);
//       final List<dynamic> tutors = jsonRes["rows"];
//       return tutors.map((tutor) => Tutor.fromJson(tutor)).toList();
//     } else {
//       return null;
//     }
//   } on Error catch (_) {
//     return null;
//   }
// }
}
