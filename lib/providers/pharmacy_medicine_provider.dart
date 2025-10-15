import 'package:flutter/material.dart';
import 'package:medical_user_app/models/pharmacy_category_model.dart';

import '../services/pharmacy_service.dart';

enum LoadingState { idle, loading, success, error }

class PharmacyMedicineProvider extends ChangeNotifier {
  final PharmacyService _pharmacyService = PharmacyService();

  // State variables
  LoadingState _loadingState = LoadingState.idle;
  String? _errorMessage;
  PharmacyMedicinesResponse? _medicinesResponse;
  List<Medicine> _medicines = [];
  List<Medicine> _filteredMedicines = [];
  List<String> _availableCategories = [];
  String _selectedCategory = '';
  String _searchQuery = '';
  PharmacyInfo? _currentPharmacy;

  // Getters
  LoadingState get loadingState => _loadingState;
  String? get errorMessage => _errorMessage;
  PharmacyMedicinesResponse? get medicinesResponse => _medicinesResponse;
  List<Medicine> get medicines => _filteredMedicines.isEmpty ? _medicines : _filteredMedicines;
  List<String> get availableCategories => _availableCategories;
  String get selectedCategory => _selectedCategory;
  String get searchQuery => _searchQuery;
  PharmacyInfo? get currentPharmacy => _currentPharmacy;
  bool get isLoading => _loadingState == LoadingState.loading;
  bool get hasError => _loadingState == LoadingState.error;
  bool get hasData => _medicines.isNotEmpty;
  int get totalMedicines => medicines.length;

  // Load medicines from a specific pharmacy
  Future<void> loadMedicinesByPharmacy({
    required String pharmacyId,
    String? category,
  }) async {
    try {
      _setLoadingState(LoadingState.loading);
      
      final response = await _pharmacyService.getMedicinesByPharmacy(
        pharmacyId: pharmacyId,
        category: category,
      );
      
      _medicinesResponse = response;
      _medicines = response.medicines;
      _currentPharmacy = response.pharmacy;
      _selectedCategory = category ?? '';
      _filteredMedicines = [];
      _clearError();
      
      // Load available categories
      await _loadAvailableCategories(pharmacyId);
      
      _setLoadingState(LoadingState.success);
    } catch (e) {
      _setError(e.toString());
    }
  }

  // Load available categories for the current pharmacy
  Future<void> _loadAvailableCategories(String pharmacyId) async {
    try {
      _availableCategories = await _pharmacyService.getAvailableCategories(pharmacyId);
    } catch (e) {
      // Don't fail the entire operation if categories can't be loaded
      _availableCategories = [];
    }
  }

  // Filter medicines by category
  Future<void> filterByCategory({
    required String pharmacyId,
    required String category,
  }) async {

    print('categoryyyyyyyyyyyyyyyyyyyyy$category');
    if (_selectedCategory == category) return;

    try {
      _setLoadingState(LoadingState.loading);
      
      final response = await _pharmacyService.getMedicinesByCategory(
        pharmacyId: pharmacyId,
        category: category,
      );

      print('heloooooooooooooooooooooooooooo${response.message}');
      
      _medicinesResponse = response;
      _medicines = response.medicines;
      _selectedCategory = category;
      _filteredMedicines = [];
      _searchQuery = '';
      _clearError();
      
      _setLoadingState(LoadingState.success);
      notifyListeners();
    } catch (e) {
      _setError(e.toString());
    }
  }

  // Clear category filter
  Future<void> clearCategoryFilter(String pharmacyId) async {
    if (_selectedCategory.isEmpty) return;
    
    await loadMedicinesByPharmacy(pharmacyId: pharmacyId);
  }

  // Search medicines
  void searchMedicines(String query) {
    _searchQuery = query;
    
    if (query.isEmpty) {
      _filteredMedicines = [];
    } else {
      _filteredMedicines = _medicines.where((medicine) {
        return medicine.name.toLowerCase().contains(query.toLowerCase()) ||
               medicine.description.toLowerCase().contains(query.toLowerCase()) ||
               medicine.categoryName.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
    
    notifyListeners();
  }

  // Clear search
  void clearSearch() {
    _searchQuery = '';
    _filteredMedicines = [];
    notifyListeners();
  }

  // Filter by price range
  void filterByPriceRange({
    required double minPrice,
    required double maxPrice,
  }) {
    _filteredMedicines = _medicines.where((medicine) {
      return medicine.price >= minPrice && medicine.price <= maxPrice;
    }).toList();
    
    notifyListeners();
  }

  // Sort medicines
  void sortMedicines(SortOption sortOption) {
    List<Medicine> medicinesToSort = medicines;
    
    switch (sortOption) {
      case SortOption.nameAsc:
        medicinesToSort.sort((a, b) => a.name.compareTo(b.name));
        break;
      case SortOption.nameDesc:
        medicinesToSort.sort((a, b) => b.name.compareTo(a.name));
        break;
      case SortOption.priceLowToHigh:
        medicinesToSort.sort((a, b) => a.price.compareTo(b.price));
        break;
      case SortOption.priceHighToLow:
        medicinesToSort.sort((a, b) => b.price.compareTo(a.price));
        break;
      case SortOption.discountHighToLow:
        medicinesToSort.sort((a, b) => b.discountPercentage.compareTo(a.discountPercentage));
        break;
    }
    
    if (_filteredMedicines.isNotEmpty) {
      _filteredMedicines = List.from(medicinesToSort);
    } else {
      _medicines = List.from(medicinesToSort);
    }
    
    notifyListeners();
  }

  // Get medicines by discount percentage
  List<Medicine> getMedicinesOnDiscount({double minDiscount = 10.0}) {
    return medicines.where((medicine) {
      return medicine.discountPercentage >= minDiscount;
    }).toList();
  }

  // Get medicine by ID
  Medicine? getMedicineById(String medicineId) {
    try {
      return _medicines.firstWhere((medicine) => medicine.id == medicineId);
    } catch (e) {
      return null;
    }
  }

  // Refresh data
  Future<void> refresh({required String pharmacyId, String? category}) async {
    await loadMedicinesByPharmacy(pharmacyId: pharmacyId, category: category);
  }

  // Private helper methods
  void _setLoadingState(LoadingState state) {
    _loadingState = state;
    notifyListeners();
  }

  void _setError(String error) {
    _errorMessage = error;
    _setLoadingState(LoadingState.error);
  }

  void _clearError() {
    _errorMessage = null;
  }

  // Clear all data
  void clearData() {
    _medicinesResponse = null;
    _medicines = [];
    _filteredMedicines = [];
    _availableCategories = [];
    _selectedCategory = '';
    _searchQuery = '';
    _currentPharmacy = null;
    _loadingState = LoadingState.idle;
    _errorMessage = null;
    notifyListeners();
  }

  @override
  void dispose() {
    clearData();
    super.dispose();
  }
}

// Sort options enum
enum SortOption {
  nameAsc,
  nameDesc,
  priceLowToHigh,
  priceHighToLow,
  discountHighToLow,
}