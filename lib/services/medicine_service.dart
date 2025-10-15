// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:medical_user_app/constant/api_constants.dart';
// import 'package:medical_user_app/models/medicine_model.dart';

// class MedicineService {
//   // static const String _baseUrl = 'http://194.164.148.244:7021/api/pharmacy/allmedicine';

//   static Future<List<MedicineModel>> fetchMedicines() async {
//     final response = await http.get(Uri.parse(ApiConstants.allMedicines));

//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       final List medicinesJson = data['medicines'];
//       return medicinesJson.map((e) => MedicineModel.fromJson(e)).toList();
//     } else {
//       throw Exception('Failed to load medicines');
//     }
//   }
// }

















import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:medical_user_app/constant/api_constants.dart';
import 'package:medical_user_app/models/medicine_model.dart';

class MedicineService {
  
  // Fetch all medicines
  static Future<List<MedicineModel>> fetchAllMedicines() async {
    final response = await http.get(Uri.parse('${ApiConstants.baseUrl}/pharmacy/allmedicine'));
    
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List medicinesJson = data['medicines'];
      return medicinesJson.map((e) => MedicineModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load medicines');
    }
  }
  
  // Fetch medicines by category
  static Future<List<MedicineModel>> fetchMedicinesByCategory(String categoryName) async {
    final response = await http.get(
      Uri.parse(ApiConstants.getMedicinesByCategory(categoryName))
    );
     
        print('category nameeeeeeeeeeeeeeeeee$categoryName');
        print('medicine category responseeeeeeeeeeeeeeeeeee${response.statusCode}');
        print('medicine bodyyyyyyyyyyyyyyyyyyyy${response.body}');

    
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List medicinesJson = data['medicines'];
      return medicinesJson.map((e) => MedicineModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load medicines for category: $categoryName');
    }
  }
}

