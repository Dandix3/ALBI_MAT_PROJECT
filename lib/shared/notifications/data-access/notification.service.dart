import '../../utils/http/data-access/api.service.dart';
import '../../utils/http/models/http_response.dart';

class NotificationService {
  final String apiEndpoint = 'achievement-actions';

  Future<HttpResponse> getAchievementActions() async {
    final response = await ApiService.autorizedGet('$apiEndpoint/', null);
    if (response.statusCode == 200) {
      return response;
    } else {
      return response;
    }
  }

  Future<HttpResponse> acknowledgeAchievementAction(int id) async {
    final response = await ApiService.autorizedPost('$apiEndpoint/ack/$id', {});
    if (response.statusCode == 200) {
      return response;
    } else {
      return response;
    }
  }

  Future<HttpResponse> rejectAchievementAction(int id) async {
    final response = await ApiService.autorizedPost('$apiEndpoint/reject/$id', {});
    if (response.statusCode == 200) {
      return response;
    } else {
      return response;
    }
  }
}
