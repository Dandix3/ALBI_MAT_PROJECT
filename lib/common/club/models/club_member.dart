

import 'package:albi_hry/common/user/models/user.dart';

class ClubMember {
  final int id;
  final User user;
  final int role;
  final DateTime createdAt;
  final DateTime updatedAt;

  ClubMember({
    required this.id,
    required this.user,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ClubMember.fromObject(dynamic data) {
    return ClubMember(
      id: data['id'],
      user: User.fromObject(data['user']),
      role: data['role'],
      createdAt: DateTime.parse(data['created_at']),
      updatedAt: DateTime.parse(data['updated_at']),
    );
  }

  factory ClubMember.fromJson(Map<String, dynamic> json) => ClubMember(
    id: json["id"],
    user: User.fromJson(json["user"]),
    role: json["role"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user": user.toJson(),
    "role": role,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}