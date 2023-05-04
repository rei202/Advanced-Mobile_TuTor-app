import 'LearnTopic.dart';

class UserInfo {
  late String id;
  late String email;
  late String name;
  late String avatar;
  String? country;
  String? phone;
  List<String>? roles;
  String? language;
  String? birthday;
  late bool isActivated;
  String? studySchedule;
  String? level;
  List<LearnTopic>? learnTopics;
  List<String>? testPreparations;
  bool? isPhoneActivated;
  int? timezone;
  String? facebook;
  String? google;
  String? apple;

  UserInfo({
    required this.id,
    required this.email,
    this.google,
    this.facebook,
    this.apple,
    required this.name,
    required this.avatar,
    this.country,
    this.phone,
    this.roles,
    this.language,
    this.birthday,
    required this.isActivated,
    this.studySchedule,
    this.level,
    this.learnTopics,
    this.testPreparations,
    this.isPhoneActivated,
    this.timezone,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    List<LearnTopic> learnTopics = [];
    if (json['learnTopics'] != null) {
      for (var v in json['learnTopics']) {
        learnTopics.add(LearnTopic.fromJson(v));
      }
    }
    return UserInfo(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      avatar: json['avatar'],
      country: json['country'],
      language: json['language'],
      birthday: json['birthday'],
      isActivated: json['isActivated'],
      apple: json['apple'],
      roles: json['roles']?.cast<String>(),
      studySchedule: json['studySchedule'],
      level: json['level'],
      isPhoneActivated: json['isPhoneActivated'],
      timezone: json['timezone'],
      phone: json['phone'],
      google: json['google'],
      facebook: json['facebook'],
      learnTopics: learnTopics,
    );
  }
}
