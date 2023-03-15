

import 'package:albi_hry/common/club/models/club_member.dart';
import 'package:albi_hry/common/user/models/user.dart';

class Club {
  final int id;
  final String name;
  final String? description;
  final User owner;
  List<ClubMember>? members;
  final String address;
  final String city;
  final String? country;
  final int postalCode;
  final double latitude;
  final double longitude;
  final DateTime createdAt;
  final DateTime updatedAt;

  Club({
    required this.id,
    required this.name,
    required this.description,
    required this.owner,
    required this.members,
    required this.address,
    required this.city,
    required this.country,
    required this.postalCode,
    required this.latitude,
    required this.longitude,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Club.fromObject(dynamic data) {
    return Club(
      id: data['id'],
      name: data['name'],
      description: data['description'],
      owner: User.fromObject(data['owner']),
      members: data['members'] != null ? List<ClubMember>.from(data['members'].map((x) => ClubMember.fromObject(x))) : null,
      address: data['address'],
      city: data['city'],
      country: data['country'],
      postalCode: data['postal_code'] is int ? data['postal_code'] : int.parse(data['postal_code']),
      latitude: double.parse(data['lat']),
      longitude: double.parse(data['lng']),
      createdAt: DateTime.parse(data['created_at']),
      updatedAt: DateTime.parse(data['updated_at']),
    );
  }

  factory Club.fromJson(Map<String, dynamic> json) => Club(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    owner: User.fromJson(json["owner"]),
    members: json["members"] != null ? List<ClubMember>.from(json["members"].map((x) => ClubMember.fromJson(x))) : null,
    address: json["address"],
    city: json["city"],
    country: json["country"],
    postalCode: json["postal_code"],
    latitude: json["lat"],
    longitude: json["lng"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "owner": owner.toJson(),
    "members": members != null ? List<dynamic>.from(members!.map((x) => x.toJson())) : null,
    "address": address,
    "city": city,
    "country": country,
    "postal_code": postalCode,
    "lat": latitude,
    "lng": longitude,
    "created_at": createdAt.toString(),
    "updated_at": updatedAt.toString(),
  };
}