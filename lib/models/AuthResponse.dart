class AuthResponse {
  final String token;
  final String refresh;



  AuthResponse({required this.token, required this.refresh});

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      token: json['tokens']['access']['token'],
      refresh: json['tokens']['refresh']['token'],
    );
  }
}
