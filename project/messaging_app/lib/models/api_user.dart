class ApiUser {
  final int id;
  final String name;
  final String email;
  final String city;

  ApiUser({
    required this.id,
    required this.name,
    required this.email,
    required this.city,
  });

  factory ApiUser.fromJson(Map<String, dynamic> json) {
    return ApiUser(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      city: (json['address']?['city']) ?? '',
    );
  }
}
