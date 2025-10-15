// services/add_query_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:medical_user_app/constant/api_constants.dart';
import '../models/query_model.dart';

class AddQueryService {
  Future<AddQueryResponse?> submitQuery(QueryModel query) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConstants.addqueryapi),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(query.toJson()),
      );

      print('response status codeeeeeeeeeeeeeeeee ${response.statusCode}');
      print('response bodyyyyyyyyyyyyyyyyyy ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        return AddQueryResponse.fromJson(responseData);
      } else {
        throw Exception('Failed to submit query: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
}
