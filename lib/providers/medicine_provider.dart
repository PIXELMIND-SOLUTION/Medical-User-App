import 'package:flutter/material.dart';
import 'package:medical_user_app/models/medicine_model.dart';
import 'package:medical_user_app/services/medicine_service.dart';

class MedicineProvider with ChangeNotifier {
  List<MedicineModel> _medicines = [];

  List<MedicineModel> get medicines => _medicines;

  bool isLoading = false;

  Future<void> loadMedicines() async {
    isLoading = true;
    notifyListeners();

    try {
      _medicines = await MedicineService.fetchMedicines();
    } catch (e) {
      _medicines = [];
    }

    isLoading = false;
    notifyListeners();
  }
}
