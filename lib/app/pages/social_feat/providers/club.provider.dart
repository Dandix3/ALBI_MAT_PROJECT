import 'package:albi_hry/app/widgets/snackbars/success_snackbar.dart';
import 'package:albi_hry/common/club/models/club.dart';
import 'package:albi_hry/data/helpers/http/models/http_response.dart';
import 'package:flutter/material.dart';

import 'package:albi_hry/data/repositories/club/data-access/club.service.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../common/club/models/club_member.dart';
import '../../../widgets/snackbars/error_snackbar.dart';



class ClubProvider extends ChangeNotifier {

  final ClubService _clubService = ClubService();

  List<Club> _clubs = [];
  List<Club> _nearbyClubs = [];
  List<Club> _myClubs = [];
  Club? _currentClub;

  bool isLoading = false;

  List<Club> get clubs => _clubs;
  List<Club> get nearbyClubs => _nearbyClubs;
  List<Club> get myClubs => _myClubs;
  Club? get currentClub => _currentClub;

  ClubProvider() {
    fetchAndSetClubs();
  }

  Future<void> fetchClubById(int id) async {
    isLoading = true;
    return _clubService.getClubById(id).then((value) {
      if (value is List<Club>) {
        _currentClub = value[0];
        isLoading = false;
        notifyListeners();
      } else {
        //todo: handle error
      }
    });
  }

  Future<void> fetchAndSetClubs() async {
    return _clubService.getAllClubs().then((value) {
      if (value.status == true) {
        _setClubs(value);
        notifyListeners();
      } else {
        print("error: ${value}value");
        //todo: handle error
      }
    });
  }

  Future<List<Club>> fetchAndSetNearbyClubs(int radius, int limit) async {
    isLoading = true;
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    return _clubService.getNearbyClubs(position.latitude, position.longitude, radius, limit).then((value) {
      if (value.statusCode == 200) {
        _setNearbyClubs(value);
        isLoading = false;
        //notifyListeners();
        return _nearbyClubs;
      } else {
        print('error: $value');
        return [];
        //todo: handle error
      }
    });
  }

  Future<void> createClub({required BuildContext context, required String name, String? description, required double lat, required double lng, required String address, required String city, String? country, required int postalCode}) async {
    return _clubService.createClub(name, description, lat, lng, address, city, country, postalCode).then((value) {
      if (value.status == true) {
        _currentClub = Club.fromObject(value.data);
        notifyListeners();
        throwSuccess(context: context, title: "Skupina vytvořena");
      } else {
        if (value.statusCode == 400) {
          throwError(context: context, errors: value.errors, title: "Chyba vytvoření skupiny");
        }
      }
    });
  }

  Future<void> updateClub(String name, String description, double lat, double lng, String address, String city, String? country, int postalCode) async {
    return _clubService.updateClub(name, description, lat, lng, address, city, country, postalCode).then((value) {
      if (value is Club) {
        _currentClub = value;
        notifyListeners();
      } else {

      }
    });
  }

  Future<void> deleteClub(int id, BuildContext context) async {
    return _clubService.deleteClub(id).then((value) {
      if (value.status == true) {
        _nearbyClubs.removeWhere((element) => element.id == id);
        notifyListeners();
        throwSuccess(context: context, title: "Skupina smazána");
      } else {

      }
    });
  }

  Future<bool> removeMember(int id) async {
    return _clubService.removeMember(id).then((value) {
      if (value.status == true) {
        return true;
      } else {
        return false;
      }
    });
  }

  Future<void> acceptMember(ClubMember clubMember) async {
    return _clubService.acceptMember(clubMember.id).then((value) {
      if (value.status == true) {
        clubMember.role = 1;
        notifyListeners();
      } else {

      }
    });
  }

  Future<void> declineMemberRequest(int id) async {
    return _clubService.declineMemberRequest(id).then((value) {
      if (value.status == true) {

      } else {

      }
    });
  }

  Future<void> inviteMembers(int id, List<int> members) async {
    return _clubService.inviteMembers(id, members).then((value) {
      if (value.status == true) {

      } else {

      }
    });
  }

  Future<List<ClubMember>?> joinClub(Club club, BuildContext context) async {
    return _clubService.joinToClub(club.id).then((value) {
      if (value.status == true) {
        club.members = value.data.map<ClubMember>((e) => ClubMember.fromObject(e)).toList();
        notifyListeners();
        throwSuccess(context: context, title: "Byl jste přidán do skupiny");
      } else {
        return null;
      }
    });
  }

  Future<void> leaveClub(Club club, BuildContext context) async {
    return _clubService.leaveClub(club.id).then((value) {
      if (value.status == true) {
        club.members = value.data.map<ClubMember>((e) => ClubMember.fromObject(e)).toList();
        notifyListeners();
        throwSuccess(context: context, title: "Opustil jste skupinu");
      } else {

      }
    });
  }


  void _setClubs(HttpResponse response) {
    _clubs = response.data.map<Club>((e) => Club.fromObject(e)).toList();
  }

  void _setNearbyClubs(HttpResponse response) {
    _nearbyClubs = response.data.map<Club>((e) => Club.fromObject(e)).toList();
  }

}