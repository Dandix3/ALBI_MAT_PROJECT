
import 'package:albi_hry/data/helpers/http/models/http_response.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:albi_hry/data/constants/api-config.dart';

import '../../../repositories/auth/data-access/auth.service.dart';

class ApiService {
  static Future<String?> getToken() async {
    final token = await AuthService.getToken();
    return token;
  }

  static Future<HttpResponse> get(String url, Map<String, dynamic> data) async {
    final response = await http.get(Uri.parse('${ApiConfig.apiUrl}$url'), headers: {
      'Content-Type': 'application/json',
    });
    final res = HttpResponse.fromJson(jsonDecode(response.body), response.statusCode);
    return res;
  }

  static Future<HttpResponse> post(String url, Map<String, dynamic> data) async {
    final response = await http.post(Uri.parse('${ApiConfig.apiUrl}$url'), body: jsonEncode(data), headers: {
      'Content-Type': 'application/json',

    });
    return HttpResponse.fromJson(jsonDecode(response.body), response.statusCode);
  }

  static Future<HttpResponse> put(String url, Map<String, dynamic> data) async {
    final response = await http.put(Uri.parse('${ApiConfig.apiUrl}$url'), body: jsonEncode(data));

    return HttpResponse.fromJson(jsonDecode(response.body), response.statusCode);
  }

  static Future<HttpResponse> delete(String url) async {
    final response = await http.delete(Uri.parse('${ApiConfig.apiUrl}$url'));
    final res =
        HttpResponse.fromJson(jsonDecode(response.body), response.statusCode);
    return res;
  }

  static Future<HttpResponse> autorizedGet(
      String url, Map<String, dynamic>? data) async {
    final token = await getToken();
    final uri = Uri.https(ApiConfig.uriUrl, ApiConfig.uriPath + url, data);
    final response = await http.get(uri, headers: {
      'Authorization': 'Bearer $token',
    });
    print(response.body);
    final res =
        HttpResponse.fromJson(jsonDecode(response.body), response.statusCode);
    return res;
  }

  static Future<HttpResponse> autorizedPost(String url, Map<String, dynamic> data) async {
    final token = await getToken();
    final response = await http.post(Uri.parse(ApiConfig.apiUrl+url), body: jsonEncode(data), headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json; charset=UTF-8',
      'Access-Control-Allow-Origin': '*',
    });
    return HttpResponse.fromJson(jsonDecode(response.body), response.statusCode);
  }

  static Future<HttpResponse> autorizedPut(
      String url, Map<String, dynamic> data) async {
    final token = await getToken();
    final response =
        await http.put(Uri.parse('${ApiConfig.apiUrl}$url'), body: data, headers: {
      'Authorization': 'Bearer $token',
    });
    final res =
        HttpResponse.fromJson(jsonDecode(response.body), response.statusCode);
    return res;
  }

  static Future<HttpResponse> autorizedDelete(String url) async {
    final token = await getToken();
    final response =
        await http.delete(Uri.parse('${ApiConfig.apiUrl}$url'), headers: {
      'Authorization': 'Bearer $token',
    });
    final res =
        HttpResponse.fromJson(jsonDecode(response.body), response.statusCode);
    return res;
  }
}
