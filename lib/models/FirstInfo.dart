import 'Feedback.dart';

class FirstInfo {
  late String name;
  late String avatar;

  FirstInfo({
    required this.name,
    required this.avatar,
  });

  factory FirstInfo.fromJson(Map<String, dynamic> json) {

    return FirstInfo(
      name: json['name'],
      avatar: json['avatar'],
    );
  }
}
