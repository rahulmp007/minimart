import 'package:minimart/src/core/network/api_client.dart';

class AuthApiService {
  final ApiClient client;
  final String baseUrl;

  AuthApiService({required this.client, required this.baseUrl});

  Future<Map<String, dynamic>> login(String email, String password) async {
    // final response = await client.post(
    //   url: '$baseUrl/login',
    //   data: {'email': email, 'password': password},
    // );
    await Future.delayed(Duration(seconds: 2));

    final response = await Future.value({'status': true});

    if (response['status'] == true) {
      return {"id": "1", "name": "rahul", "email": "rahul@gmail.com"};
    } else {
      throw Exception("Login failed: $response");
    }
  }

  Future<Map<String, dynamic>> signup(
    String name,
    String email,
    String password,
  ) async {
    // final response = await client.post(
    //   url: '$baseUrl/signup',
    //   data: {'name': name, 'email': email, 'password': password},
    // );
    await Future.delayed(Duration(seconds: 2));

    final response = await Future.value({'status': true});

    if (response['status'] == true) {
      return {"id": "1", "name": "rahul", "email": "rahul@gmail.com"};
    } else {
      throw Exception("Login failed: $response");
    }
  }
}
