import 'dart:convert';
import 'package:http/http.dart' as http;

class BaseAPI {
  BaseAPI();

  Future<Map<String, dynamic>> get(String baseUrl, {Map<String, String>? headers}) async {
    try {
      final response = await http.get(
        Uri.parse(baseUrl),
        headers: headers,
      );
      return _processResponse(response);
    } catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }

  Future<Map<String, dynamic>> post(String baseUrl, dynamic body,
      {Map<String, String>? headers}) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: headers,
        body: jsonEncode(body),
      );
      return _processResponse(response);
    } catch (e) {
      throw Exception('Failed to post data: $e');
    }
  }

  Map<String, dynamic> _processResponse(http.Response response) {
    final statusCode = response.statusCode;

    // 使用 UTF-8 解码响应体
    final body = utf8.decode(response.bodyBytes);

    if (statusCode >= 200 && statusCode < 300) {
      try {
        return jsonDecode(body);
      } catch (e) {
        throw Exception('Failed to parse JSON: $e');
      }
    } else {
      throw Exception('Error: $statusCode, $body');
    }
  }
}