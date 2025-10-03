// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:minimart/src/core/network/api_client.dart';

class CategoryApiSource {
  final ApiClient client;
  CategoryApiSource({required this.client});

  Future<List<Map<String, dynamic>>> fetchCategories() async {
    await Future.delayed(Duration(seconds: 2));

    final response = await Future.value({'status': true});

    if (response['status'] == true) {
      return [
        {"id": "1", "name": "For You"},
        {"id": "2", "name": "Fashion"},
        {"id": "3", "name": "Mobile"},
        {"id": "4", "name": "Electronics"},
        {"id": "5", "name": "Appliances"},
        {"id": "6", "name": "Beauty"},
      ];
    } else {
      throw Exception("fetch category failed: $response");
    }
  }
}
