import 'package:albi_hry/data/helpers/http/data-access/api.service.dart';

import 'package:albi_hry/common/club/models/club.dart';
import 'package:albi_hry/data/helpers/http/models/http_response.dart';

class ClubService {
  String apiEndpoint = 'clubs';

  Future<Object?> getClubById(int id) async {
    final response = await ApiService.autorizedGet('$apiEndpoint/$id', {});

    if (response.statusCode == 200) {
      return Club.fromObject(response.data);
    } else {
      return response.message;
    }
  }

  Future<HttpResponse> getAllClubs() async {
    final response = await ApiService.autorizedGet('$apiEndpoint', {});

    return response;
  }

  Future<HttpResponse> getNearbyClubs(double lat, double lng, int? radius, int? limit) async {
    final response = await ApiService.autorizedGet('$apiEndpoint/nearby', {
      'lat': lat.toString(),
      'lng': lng.toString(),
      'radius': radius.toString(),
      'limit': limit.toString(),
    });

    return response;
  }

  Future<HttpResponse> createClub(String name, String? description, double lat, double lng, String address, String city, String? country, int postalCode) async {
    print('lat: $lat, lng: $lng');
    final response = await ApiService.autorizedPost('$apiEndpoint', {
      'name': name,
      'description': description ?? '',
      'lat': lat.toString(),
      'lng': lng.toString(),
      'address': address,
      'city': city,
      'country': country,
      'postal_code': postalCode,
    });

    return response;
  }

  Future<Object?> updateClub(String name, String description, double lat, double lng, String address, String city, String? country, int postalCode) async {
    final response = await ApiService.autorizedPut('$apiEndpoint', {
      'name': name,
      'description': description,
      'lat': lat,
      'lng': lng,
      'address': address,
      'city': city,
      'country': country,
      'postal_code': postalCode,
    });

    if (response.statusCode == 200) {
      return Club.fromObject(response.data);
    } else {
      return response.message;
    }
  }

  Future<Object?> deleteClub(int id) async {
    final response = await ApiService.autorizedDelete('$apiEndpoint/$id');

    if (response.statusCode == 200) {
      return response;
    } else {
      return response.message;
    }
  }

  Future<Object?> removeMember(int id, int memberId) async {
    final response = await ApiService.autorizedPost('$apiEndpoint/$id/remove/$memberId', {});

    if (response.statusCode == 200) {
      return response;
    } else {
      return response.message;
    }
  }

  Future<Object?> acceptMember(int id, int memberId) async {
    final response = await ApiService.autorizedPost('$apiEndpoint/$id/accept/$memberId', {});

    if (response.statusCode == 200) {
      return response;
    } else {
      return response.message;
    }
  }

  Future<Object?> declineMemberRequest(int id, int memberId) async {
    final response = await ApiService.autorizedPost('$apiEndpoint/$id/decline/$memberId', {});

    if (response.statusCode == 200) {
      return response.data;
    } else {
      return response.message;
    }
  }

  Future<Object?> inviteMembers(int id, List memberIds) async {
    final response = await ApiService.autorizedPost('$apiEndpoint/invite/$id', {
      "user_ids": memberIds.toString(),
    });

    if (response.statusCode == 200) {
      return response.data;
    } else {
      return response.message;
    }
  }

  Future<HttpResponse> joinToClub(int id) async {
    final response = await ApiService.autorizedPost('$apiEndpoint/join/$id', {});

    return response;
  }

  Future<Object?> leaveClub(int id) async {
    final response = await ApiService.autorizedPost('$apiEndpoint/leave/$id', {});

    if (response.statusCode == 200) {
      return response.data;
    } else {
      return response.message;
    }
  }

}