import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiClient {
  static ApiClient? _singleton;
  ApiClient._internal();
  factory ApiClient() => _singleton ??= ApiClient._internal();

  final _defaultHeaders = {'Content-Type': 'application/json'};

  /// GET
  Future<Map<String, dynamic>> get({required String url}) async {
    final http.Response response = await http.get(Uri.parse(url));
    return _processResponse(response);
  }

  /// POST
  Future<Map<String, dynamic>> post({
    required String url,
    required Map<String, dynamic> data,
    Map<String, String>? headers,
  }) async {
    final http.Response response = await http.post(
      Uri.parse(url),
      headers: {..._defaultHeaders, ...?headers},
      body: jsonEncode(data),
    );
    return _processResponse(response);
  }

  /// PUT
  Future<Map<String, dynamic>> put({
    required String url,
    required Map<String, dynamic> data,
    Map<String, String>? headers,
  }) async {
    final http.Response response = await http.put(
      Uri.parse(url),
      headers: {..._defaultHeaders, ...?headers},
      body: jsonEncode(data),
    );
    return _processResponse(response);
  }

  /// Common Response Handler
  Map<String, dynamic> _processResponse(http.Response response) {
    final statusCode = response.statusCode;

    if (statusCode >= 200 && statusCode < 300) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception(
        'Request failed: ${response.statusCode}, body: ${response.body}',
      );
    }
  }

  void dispose() {
    _singleton = null;
  }
}
