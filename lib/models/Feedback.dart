import 'package:lettutor/models/FirstInfo.dart';

class FeedBack {
  late String id;
  String? bookingId;
  late String firstId;
  late String secondId;
  late double rating;
  late String content;
  late String createdAt;
  late String updatedAt;
  late FirstInfo firstInfo;

  FeedBack(
      {required this.id,
      this.bookingId,
      required this.firstId,
      required this.secondId,
      required this.rating,
      required this.content,
      required this.createdAt,
      required this.updatedAt,
      required this.firstInfo});

  factory FeedBack.fromJson(Map<String, dynamic> json) {
    return FeedBack(
      id: json['id'],
      bookingId: json['bookingId'],
      firstId: json['firstId'],
      secondId: json['secondId'],
      rating: json['rating'].runtimeType == double
          ? json['rating']
          : double.parse(json['rating'].toString()),
      content: json['content'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      firstInfo: FirstInfo.fromJson(json['firstInfo']),
    );
  }
}

