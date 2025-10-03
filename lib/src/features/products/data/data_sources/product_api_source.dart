// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:minimart/src/core/constants/data.dart';

import 'package:minimart/src/core/network/api_client.dart';

class ProductApiSource {
  final ApiClient client;
  ProductApiSource({required this.client});

  Future<Map<String, dynamic>> fetchProducts() async {
    await Future.delayed(Duration(seconds: 2));

    final response = await Future.value({'status': true});

    if (response['status'] == true) {
      return products;
    } else {
      throw Exception("Login failed: $response");
    }
  }
}
