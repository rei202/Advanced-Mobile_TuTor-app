import 'Category.dart';
import 'Topic.dart';

class CourseModel {
  late String id;
  late String name;
  late String description;
  late String level;
  late String imageUrl;
  late String reason;
  late int defaultPrice;
  late int coursePrice;
  late String otherDetails;
  late bool visible;
  late String purpose;
  late String createdAt;
  late String updatedAt;
  List<Topic> topics = [];
  List<Category> categories = [];

  CourseModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.reason,
    required this.level,
    required this.purpose,
    required this.defaultPrice,
    required this.otherDetails,
    required this.coursePrice,
    required this.createdAt,
    required this.visible,
    required this.updatedAt,
    required this.topics,
    required List<Category>? categories,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    // List<Category> categories = [];
    // if (json['categories'] != null) {
    //   for (var v in json['categories']) {
    //     categories.add(Category.fromJson(v));
    //   }
    // }

    return CourseModel(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      description: json['description'],
      level: json['level'],
      purpose: json['purpose'],
      reason: json['reason'],
      otherDetails: json['other_details'],
      coursePrice: json['course_price'],
      visible: json['visible'],
      defaultPrice: json['default_price'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      topics:
          (json['topics'] as List).map((i) => Topic.fromJson(i)).toList(),
      categories: json['categories'] != null ? (json['categories'] as List).map((i)=> Category.fromJson(i)).toList(): null,
    );
  }
}
