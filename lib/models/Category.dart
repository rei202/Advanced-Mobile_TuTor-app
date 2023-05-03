class Category {
  late String id;
  late String createdAt;
  String? description;
  late String title;
  late String key;
  late String updatedAt;

  Category({
    required this.id,
    required this.createdAt,
    required this.title,
    required this.key,
    this.description,
    required this.updatedAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      key: json['key'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}
