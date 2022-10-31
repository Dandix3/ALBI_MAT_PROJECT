
class User {
  final int id;
  final String email;
  final String name;
  final String surname;
  final String nickname;
  final DateTime createdAt;
  final DateTime updatedAt;

  set name(String name) => this.name = name;
  set surname(String surname) => this.surname = surname;
  set nickname(String nickname) => this.nickname = nickname;
  set email(String email) => this.email = email;
  set createdAt(DateTime createdAt) => this.createdAt = createdAt;
  set updatedAt(DateTime updatedAt) => this.updatedAt = updatedAt;

  User({
    required this.id,
    required this.email,
    required this.name,
    required this.surname,
    required this.nickname,
    required this.createdAt,
    required this.updatedAt,
  });


  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    email: json["email"],
    name: json["first_name"],
    surname: json["last_name"],
    nickname: json["nickname"],
    createdAt: DateTime.parse(json['created_at']),
    updatedAt: DateTime.parse(json['updated_at']),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "first_name": name,
    "last_name": surname,
    "nickname": nickname,
    "created_at": createdAt.toString(),
    "updated_at": updatedAt.toString(),
  };

}