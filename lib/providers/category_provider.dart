// // providers/category_provider.dart

// import 'package:flutter/material.dart';
// import '../models/category_model.dart';
// import '../services/category_service.dart';

// class CategoryProvider with ChangeNotifier {
//   final CategoryService _categoryService = CategoryService();
  
//   // Private variables
//   List<Category> _categories = [];
//   List<Category> _filteredCategories = [];
//   bool _isLoading = false;
//   String _errorMessage = '';
//   String _searchQuery = '';
//   String _selectedServiceName = ''; // Track selected service

//   // Getters
//   List<Category> get categories => _categories;
//   List<Category> get filteredCategories => _filteredCategories;
//   bool get isLoading => _isLoading;
//   String get errorMessage => _errorMessage;
//   String get searchQuery => _searchQuery;
//   String get selectedServiceName => _selectedServiceName;
//   bool get hasError => _errorMessage.isNotEmpty;
//   bool get hasCategories => _categories.isNotEmpty;
//   int get totalCategories => _categories.length;
//   int get filteredCategoriesCount => _filteredCategories.length;

//   /// Fetch categories from the API
//   /// If serviceName is provided, only categories for that service will be fetched
//   /// If serviceName is null or empty, all categories will be fetched
//   Future<void> fetchCategories({String? serviceName}) async {
//     _setLoading(true);
//     _clearError();
    
//     try {
//       final CategoryResponse response = await _categoryService.getAllCategories(serviceName: serviceName);
//       _categories = response.categories;
//       _selectedServiceName = serviceName ?? '';
//       print("Keeeeeeeeeeeee$_categories");
      
//       // Apply filters
//       _applyFilters();
      
//       _setLoading(false);
//       notifyListeners();
//     } on CategoryException catch (e) {
//       _setError(e.message);
//       _setLoading(false);
//     } catch (e) {
//       _setError('An unexpected error occurred: ${e.toString()}');
//       _setLoading(false);
//     }
//   }

//   /// Refresh categories (pull-to-refresh functionality)
//   /// Maintains the current service filter
//   Future<void> refreshCategories() async {
//     await fetchCategories(serviceName: _selectedServiceName.isNotEmpty ? _selectedServiceName : null);
//   }

//   /// Load all categories (clear service filter)
//   Future<void> loadAllCategories() async {
//     await fetchCategories(serviceName: null);
//   }

//   /// Load categories for a specific service
//   Future<void> loadCategoriesByService(String serviceName) async {
//     await fetchCategories(serviceName: serviceName);
//   }

//   /// Search/Filter categories by name
//   void searchCategories(String query) {
//     _searchQuery = query.toLowerCase().trim();
//     _applyFilters();
//     notifyListeners();
//   }

//   /// Clear search and show filtered categories based on current service
//   void clearSearch() {
//     _searchQuery = '';
//     _applyFilters();
//     notifyListeners();
//   }

//   /// Apply all filters (search + service filter)
//   void _applyFilters() {
//     List<Category> result = List.from(_categories);
    
//     // Apply search filter if query exists
//     if (_searchQuery.isNotEmpty) {
//       result = result.where((category) {
//         return category.categoryName.toLowerCase().contains(_searchQuery) ||
//                category.serviceName.toLowerCase().contains(_searchQuery);
//       }).toList();
//     }
    
//     _filteredCategories = result;
//   }

//   /// Get categories by service name from current loaded categories
//   List<Category> getCategoriesByService(String serviceName) {
//     return _categories.where((category) => 
//         category.serviceName.toLowerCase() == serviceName.toLowerCase()).toList();
//   }

//   /// Get category by ID
//   Category? getCategoryById(String id) {
//     try {
//       return _categories.firstWhere((category) => category.id == id);
//     } catch (e) {
//       return null;
//     }
//   }

//   /// Check if a category exists
//   bool categoryExists(String id) {
//     return _categories.any((category) => category.id == id);
//   }

//   /// Get unique service names from current categories
//   List<String> get uniqueServiceNames {
//     final Set<String> serviceNames = _categories.map((category) => category.serviceName).toSet();
//     return serviceNames.toList()..sort();
//   }

//   /// Check if currently showing all categories or filtered by service
//   bool get isShowingAllCategories => _selectedServiceName.isEmpty;

//   /// Sort categories by name (A-Z)
//   void sortCategoriesAZ() {
//     _categories.sort((a, b) => a.categoryName.compareTo(b.categoryName));
//     _filteredCategories.sort((a, b) => a.categoryName.compareTo(b.categoryName));
//     notifyListeners();
//   }

//   /// Sort categories by name (Z-A)
//   void sortCategoriesZA() {
//     _categories.sort((a, b) => b.categoryName.compareTo(a.categoryName));
//     _filteredCategories.sort((a, b) => b.categoryName.compareTo(a.categoryName));
//     notifyListeners();
//   }

//   /// Sort categories by creation date (newest first)
//   void sortCategoriesByDateNewest() {
//     _categories.sort((a, b) => b.createdAt.compareTo(a.createdAt));
//     _filteredCategories.sort((a, b) => b.createdAt.compareTo(a.createdAt));
//     notifyListeners();
//   }

//   /// Sort categories by creation date (oldest first)
//   void sortCategoriesByDateOldest() {
//     _categories.sort((a, b) => a.createdAt.compareTo(b.createdAt));
//     _filteredCategories.sort((a, b) => a.createdAt.compareTo(b.createdAt));
//     notifyListeners();
//   }

//   /// Private helper methods
//   void _setLoading(bool loading) {
//     _isLoading = loading;
//     if (loading) _clearError();
//   }

//   void _setError(String error) {
//     _errorMessage = error;
//     _isLoading = false;
//     notifyListeners();
//   }

//   void _clearError() {
//     _errorMessage = '';
//   }

//   /// Clear all data (useful for logout)
//   void clearData() {
//     _categories.clear();
//     _filteredCategories.clear();
//     _clearError();
//     _searchQuery = '';
//     _selectedServiceName = '';
//     _isLoading = false;
//     notifyListeners();
//   }

//   @override
//   void dispose() {
//     _categories.clear();
//     _filteredCategories.clear();
//     super.dispose();
//   }
// }













// providers/category_provider.dart

import 'package:flutter/material.dart';
import '../models/category_model.dart';
import '../services/category_service.dart';

class CategoryProvider with ChangeNotifier {
  final CategoryService _categoryService = CategoryService();
  
  // Private variables
  List<Category> _categories = [];
  bool _isLoading = false;
  String _errorMessage = '';
  String _selectedServiceName = '';

  // Getters
  List<Category> get categories => _categories;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  String get selectedServiceName => _selectedServiceName;
  bool get hasError => _errorMessage.isNotEmpty;
  bool get isShowingAllCategories => _selectedServiceName.isEmpty;

  /// Fetch categories from the API
  // Future<void> fetchCategories({String? serviceName}) async {
  //   _setLoading(true);
  //   _clearError();
    
  //   try {
  //     final CategoryResponse response = await _categoryService.getAllCategories(serviceName: serviceName);
  //     _categories = response.categories;
  //     _selectedServiceName = serviceName ?? '';
      
  //     _setLoading(false);
  //     notifyListeners();
  //   } on CategoryException catch (e) {
  //     _setError(e.message);
  //     _setLoading(false);
  //   } catch (e) {
  //     _setError('An unexpected error occurred: ${e.toString()}');
  //     _setLoading(false);
  //   }
  // }

  // /// Load all categories (clear service filter)
  // Future<void> loadAllCategories() async {
  //   await fetchCategories(serviceName: null);
  // }

  // /// Load categories for a specific service
  // Future<void> loadCategoriesByService(String serviceName) async {
  //   await fetchCategories(serviceName: serviceName);
  // }


  /// Load all categories (clear service filter)
Future<void> loadAllCategories() async {
  print("loadAllCategories called");
  _selectedServiceName = ''; // Clear selection BEFORE fetching
  await fetchCategories(serviceName: null);
  print("After loadAllCategories - selectedServiceName: '$_selectedServiceName'");
}

/// Load categories for a specific service
Future<void> loadCategoriesByService(String serviceName) async {
  print("loadCategoriesByService called with: $serviceName");
  _selectedServiceName = serviceName; // Set selection BEFORE fetching
  await fetchCategories(serviceName: serviceName);
  print("After loadCategoriesByService - selectedServiceName: '$_selectedServiceName'");
}

/// Fetch categories from the API
Future<void> fetchCategories({String? serviceName}) async {
  _setLoading(true);
  _clearError();
  
  try {
    final CategoryResponse response = await _categoryService.getAllCategories(serviceName: serviceName);
    _categories = response.categories;
    // Don't override _selectedServiceName here since we set it in the calling methods
    
    _setLoading(false);
    notifyListeners();
  } on CategoryException catch (e) {
    _setError(e.message);
    _setLoading(false);
  } catch (e) {
    _setError('An unexpected error occurred: ${e.toString()}');
    _setLoading(false);
  }
}

  /// Private helper methods
  void _setLoading(bool loading) {
    _isLoading = loading;
    if (loading) _clearError();
  }

  void _setError(String error) {
    _errorMessage = error;
    _isLoading = false;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = '';
  }

  /// Clear all data
  void clearData() {
    _categories.clear();
    _clearError();
    _selectedServiceName = '';
    _isLoading = false;
    notifyListeners();
  }

  @override
  void dispose() {
    _categories.clear();
    super.dispose();
  }
}