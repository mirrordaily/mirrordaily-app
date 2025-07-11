import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class ApiBaseHelper {
  ApiBaseHelper();

  Map<String, String> getHeaders({Map<String, String>? additionalHeaders}) {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (additionalHeaders != null) ...additionalHeaders,
    };
  }

  /// 🟢 GET 請求
  Future<dynamic> get(
      {required String url, Map<String, String>? headers}) async {
    try {
      final response = await http.get(Uri.parse(url),
          headers: getHeaders(additionalHeaders: headers));
      return _handleResponse(response);
    } catch (e) {
      debugPrint("GET Error: $e");
      throw Exception("Error while fetching data");
    }
  }

  /// 🟠 POST 請求
  Future<dynamic> post(
      {required String url, Map<String, String>? headers, dynamic body}) async {
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: getHeaders(additionalHeaders: headers),
        body: jsonEncode(body),
      );
      return _handleResponse(response);
    } catch (e) {
      debugPrint("POST Error: $e");
      throw Exception("Error while sending data");
    }
  }

  /// 🔵 PUT 請求
  Future<dynamic> put(
      {required String url, Map<String, String>? headers, dynamic body}) async {
    try {
      final response = await http.put(
        Uri.parse(url),
        headers: getHeaders(additionalHeaders: headers),
        body: jsonEncode(body),
      );
      return _handleResponse(response);
    } catch (e) {
      debugPrint("PUT Error: $e");
      throw Exception("Error while updating data");
    }
  }

  /// 🔴 DELETE 請求
  Future<dynamic> delete(
      {required String url, Map<String, String>? headers}) async {
    try {
      final response = await http.delete(Uri.parse(url),
          headers: getHeaders(additionalHeaders: headers));
      return _handleResponse(response);
    } catch (e) {
      debugPrint("DELETE Error: $e");
      throw Exception("Error while deleting data");
    }
  }

  /// 📦 檔案上傳（Multipart 請求）
  Future<dynamic> uploadFile({
    required String url,
    required String fileKey,
    required String filePath,
    Map<String, String>? headers,
    Map<String, String>? fields,
  }) async {
    try {
      final request = http.MultipartRequest('POST', Uri.parse(url));
      request.headers.addAll(getHeaders(additionalHeaders: headers));

      // 加入其他欄位
      fields?.forEach((key, value) => request.fields[key] = value);

      // 加入檔案
      request.files.add(await http.MultipartFile.fromPath(fileKey, filePath));

      final response = await request.send();
      final responseData = await http.Response.fromStream(response);
      return _handleResponse(responseData);
    } catch (e) {
      debugPrint("File Upload Error: $e");
      throw Exception("Error while uploading file");
    }
  }

  /// 🎯 處理 HTTP Response
  dynamic _handleResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        return jsonDecode(utf8.decode(response.bodyBytes));
      case 400:
        throw Exception("Bad Request: ${response.body}");
      case 401:
        throw Exception("Unauthorized: ${response.body}");
      case 403:
        throw Exception("Forbidden: ${response.body}");
      case 404:
        throw Exception("Not Found: ${response.body}");
      case 500:
      default:
        throw Exception("Server Error: ${response.body}");
    }
  }
}
