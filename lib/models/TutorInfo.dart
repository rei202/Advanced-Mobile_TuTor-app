import 'Feedback.dart';

class TutorInfo {
  final String userId;
  final String? avatar;
  final String? name;
  final String? country;

  TutorInfo({
    required this.userId,
    this.avatar,
    this.name,
    this.country,
  });

  factory TutorInfo.fromTutorInforJson(Map<String, dynamic> json) {
    return TutorInfo(
      userId: json['id'],
      name: json['name'],
      country: json['country'],
      avatar: json['avatar'],
    );
  }
}
