// import 'package:flutter/material.dart';
// import 'package:medical_user_app/models/medicine_model.dart';
// import 'package:medical_user_app/services/medicine_service.dart';

// class MedicineProvider with ChangeNotifier {
//   List<MedicineModel> _medicines = [];

//   List<MedicineModel> get medicines => _medicines;

//   bool isLoading = false;

//   Future<void> loadMedicines() async {
//     isLoading = true;
//     notifyListeners();

//     try {
//       _medicines = await MedicineService.fetchMedicines();
//     } catch (e) {
//       _medicines = [];
//     }

//     isLoading = false;
//     notifyListeners();
//   }
// }









import 'package:flutter/material.dart';
import 'package:medical_user_app/models/medicine_model.dart';
import 'package:medical_user_app/services/medicine_service.dart';

class MedicineProvider with ChangeNotifier {
  List<MedicineModel> _medicines = [];
  String _selectedCategory = '';
  bool _isLoading = false;
  String _errorMessage = '';

  List<MedicineModel> get medicines => _medicines;
  String get selectedCategory => _selectedCategory;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  // Load all medicines
  Future<void> loadAllMedicines() async {
    _isLoading = true;
    _errorMessage = '';
    _selectedCategory = '';
    notifyListeners();

    try {
      _medicines = await MedicineService.fetchAllMedicines();
    } catch (e) {
      _medicines = [];
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  // Load medicines by category
  Future<void> loadMedicinesByCategory(String categoryName) async {
    _isLoading = true;
    _errorMessage = '';
    _selectedCategory = categoryName;
    notifyListeners();

    try {
      _medicines = await MedicineService.fetchMedicinesByCategory(categoryName);
    } catch (e) {
      _medicines = [];
      _errorMessage = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  // Refresh current data
  Future<void> refreshMedicines() async {
    if (_selectedCategory.isNotEmpty) {
      await loadMedicinesByCategory(_selectedCategory);
    } else {
      await loadAllMedicines();
    }
  }

  // Clear selection and show all medicines
  Future<void> clearCategoryFilter() async {
    await loadAllMedicines();
  }

  // Backward compatibility - this method now calls loadAllMedicines
  Future<void> loadMedicines() async {
    await loadAllMedicines();
  }
}

