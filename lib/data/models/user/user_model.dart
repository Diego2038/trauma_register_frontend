class UserModel {
  final String username;
  final String email;

  UserModel({
    required this.username,
    required this.email,
  });

  UserModel copyWith({
    String? username,
    String? email,
  }) =>
      UserModel(
        username: username ?? this.username,
        email: email ?? this.email,
      );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        username: json["username"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
      };
}
