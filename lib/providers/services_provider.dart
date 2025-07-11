import 'package:flutter/foundation.dart';
import 'package:medical_user_app/models/services_model.dart';
import 'package:medical_user_app/services/services_service.dart';

class ServiceProvider extends ChangeNotifier {
  final ServiceService _serviceService = ServiceService();
  
  // Private variables
  List<ServiceModel> _services = [];
  bool _isLoading = false;
  String _errorMessage = '';
  int _totalServices = 0;

  // Getters
  List<ServiceModel> get services => _services;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  int get totalServices => _totalServices;
  bool get hasError => _errorMessage.isNotEmpty;
  bool get hasServices => _services.isNotEmpty;

  // Set loading state
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  // Set error message
  void _setError(String error) {
    _errorMessage = error;
    notifyListeners();
  }

  // Clear error message
  void clearError() {
    _errorMessage = '';
    notifyListeners();
  }

  // Fetch all services
  Future<void> fetchAllServices() async {
    try {
      _setLoading(true);
      clearError();

      final ServiceResponse response = await _serviceService.getAllServices();
      
      _services = response.services;
      _totalServices = response.total;
      
      _setLoading(false);
    } catch (e) {
      _setLoading(false);
      _setError(e.toString());
      if (kDebugMode) {
        print('Error fetching services: $e');
      }
    }
  }

  // Refresh services (useful for pull-to-refresh)
  Future<void> refreshServices() async {
    await fetchAllServices();
  }

  // Get service by ID
  ServiceModel? getServiceById(String id) {
    try {
      return _services.firstWhere((service) => service.id == id);
    } catch (e) {
      return null;
    }
  }

  // Search services by name
  List<ServiceModel> searchServices(String query) {
    if (query.isEmpty) return _services;
    
    return _services.where((service) =>
      service.servicesName.toLowerCase().contains(query.toLowerCase())
    ).toList();
  }

  // Filter services by creation date (newest first)
  List<ServiceModel> getServicesSortedByDate({bool ascending = false}) {
    List<ServiceModel> sortedServices = List.from(_services);
    sortedServices.sort((a, b) => ascending 
      ? a.createdAt.compareTo(b.createdAt)
      : b.createdAt.compareTo(a.createdAt)
    );
    return sortedServices;
  }

  // Get services count
  int get servicesCount => _services.length;

  // Check if services are loaded
  bool get isServicesLoaded => _services.isNotEmpty && !_isLoading;

  // Reset provider state
  void reset() {
    _services = [];
    _isLoading = false;
    _errorMessage = '';
    _totalServices = 0;
    notifyListeners();
  }

  // Dispose method
  @override
  void dispose() {
    super.dispose();
  }
}