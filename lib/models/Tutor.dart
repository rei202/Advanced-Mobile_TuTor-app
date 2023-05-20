
import 'Feedback.dart';

class Tutor {
  final String userId;
  final String? avatar;
  final String? name;
  final String? bio;
  final String? video;
  final String? experience;
  final String? languages;
  final String? interests;
  final String? country;
  final double? rating;
  late final bool? isFavorite;
  final String? specialties;
  List<FeedBack>? feedbacks;

  Tutor(
      {required this.userId,
      this.avatar,
      this.name,
      this.bio,
      this.specialties,
      this.rating,
      this.video,
      this.experience,
      this.languages,
      this.interests,
      this.country,
      this.isFavorite,
      this.feedbacks});

  factory Tutor.fromTutorInforJson(Map<String, dynamic> json) {
    return Tutor(
      userId: json['User']['id'],
      name: json['User']['name'],
      bio: json['bio'],
      country: json['User']['country'],
      avatar: json['User']['avatar'],
      specialties: json['specialties'],
      experience: json['experience'],
      video: json['video'],
      rating: json['rating'],
      interests: json['interests'],
      isFavorite: json['isFavorite'],
      languages: json['languages'],
    );
  }

  factory Tutor.fromJson(Map<String, dynamic> json) {
    List<FeedBack> feedbacks = [];
    if (json['feedbacks'] != null) {
      for (var feedBack in json['feedbacks']) {
        feedbacks.add(FeedBack.fromJson(feedBack));
      }
    }
    return Tutor(
      userId: json['userId'],
      avatar: json['avatar'],
      name: json['name'],
      country: json['country'],
      bio: json['bio'],
      rating: json['rating'],
      video: json['video'],
      experience: json['experience'],
      languages: json['languages'],
      interests: json['interests'],
      isFavorite: json['isFavorite'],
      specialties: json['specialties'],
      feedbacks: feedbacks,
    );
  }
  factory Tutor.fromJsonFavorite(Map<String, dynamic> json) {
    List<FeedBack> feedbacks = [];
    if (json['feedbacks'] != null) {
      for (var feedBack in json['feedbacks']) {
        feedbacks.add(FeedBack.fromJson(feedBack));
      }
    }
    return Tutor(
      userId: json['id'],
      avatar: json['avatar'],
      name: json['name'],
      country: json['country'],
      bio: json['tutorInfo']['bio'],
      rating: json['tutorInfo']['rating'],
      video: json['tutorInfo']['video'],
      experience: json['tutorInfo']['experience'],
      languages: json['tutorInfo']['languages'],
      interests: json['tutorInfo']['interests'],
      isFavorite: json['isFavorite'],
      specialties: json['tutorInfo']['specialties'],
      feedbacks: feedbacks,
    );
  }


}
