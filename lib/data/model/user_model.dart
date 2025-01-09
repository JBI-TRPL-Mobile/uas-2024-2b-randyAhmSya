class UserModel {
  final String id;
  final String name;
  final String email;
  final String avatar;
  final bool isOnline;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.avatar,
    this.isOnline = false,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      avatar: json['avatar'],
      isOnline: json['isOnline'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'avatar': avatar,
      'isOnline': isOnline,
    };
  }
}
