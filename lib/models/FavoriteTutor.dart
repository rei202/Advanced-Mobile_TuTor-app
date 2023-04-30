
class FavoriteTutor {
  final String userId;

  FavoriteTutor(
      {required this.userId});

  factory FavoriteTutor.fromJson(Map<String, dynamic> json) {
    return FavoriteTutor(
      userId: json['secondId'],
     );
  }
}
