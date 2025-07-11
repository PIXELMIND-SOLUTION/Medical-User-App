import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:medical_user_app/models/medicine_model.dart';

class MedicineService {
  static const String _baseUrl = 'http://194.164.148.244:7021/api/pharmacy/allmedicine';

  static Future<List<MedicineModel>> fetchMedicines() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List medicinesJson = data['medicines'];
      return medicinesJson.map((e) => MedicineModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load medicines');
    }
  }
}
