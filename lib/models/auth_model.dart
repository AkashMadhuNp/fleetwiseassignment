class AuthResponse {
  final String accessToken;
  final String refreshToken;
  final String tokenType;
  final bool exists;
  final String uuid;

  AuthResponse({
    required this.accessToken,
    required this.refreshToken,
    required this.tokenType,
    required this.exists,
    required this.uuid,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      accessToken: json['access_token'] ?? '',
      refreshToken: json['refresh_token'] ?? '',
      tokenType: json['token_type'] ?? '',
      exists: json['exists'] ?? false,
      uuid: json['uuid'] ?? '',
    );
  }
}