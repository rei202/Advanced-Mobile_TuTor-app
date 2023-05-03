class Topic {
  late String id;
  late String courseId;
  late int orderCourse;
  late String name;
  late String nameFile;
  String? description;
  String? videoUrl;
  late String createdAt;
  late String updatedAt;

  Topic({
    required this.id,
    required this.courseId,
    required this.orderCourse,
    required this.name,
    required this.nameFile,
    this.description,
    this.videoUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Topic.fromJson(Map<String, dynamic> json) {
    return Topic(
      id: json['id'],
      courseId: json['courseId'],
      orderCourse: json['orderCourse'],
      name: json['name'],
      nameFile: json['nameFile'],
      description: json['description'],
      videoUrl: json['videoUrl'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}
