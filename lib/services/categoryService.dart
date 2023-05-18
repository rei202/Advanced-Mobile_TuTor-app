import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:lettutor/env/env.dart';
import 'package:http/http.dart' as http;
import 'package:lettutor/models/Category.dart';
import 'package:lettutor/models/Course.dart';


class CategoryService {
  static Future<List<Category>?> getCategoryList() async {
    List<Category> categoryList = <Category>[];

    try {
      final box = GetStorage();
      String? token = await box.read('token');
      // print("token: " + token!);
      var url = Uri.https(baseUrl, 'content-category');
      var response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      if (response.statusCode == 200) {
        var categories = jsonDecode(response.body)['rows'];
        for (var c in categories) {
          categoryList.add(Category.fromJson(c));
        }
        return categoryList;
      } else {
        return null;
      }
    } on Error catch (_) {
      return null;
    }
  }

}
