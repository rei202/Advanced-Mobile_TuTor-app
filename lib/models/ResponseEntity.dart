class ResponseEntity {
  final int statusCode;
  final String message;

  ResponseEntity({required this.statusCode, required this.message});

  factory ResponseEntity.fromJson(Map<String, dynamic> json) {
    return ResponseEntity(
      statusCode: json['statusCode'],
      message: json['message'],
    );
  }
}
