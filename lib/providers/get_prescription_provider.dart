import 'package:flutter/material.dart';
import 'package:medical_user_app/models/prescription_model.dart';
import 'package:medical_user_app/services/get_user_prescription_service.dart';

class GetPrescriptionProvider extends ChangeNotifier {
  // State variables
  List<UserPrescription> _prescriptions = [];
  bool _isLoading = false;
  bool _isRefreshing = false;
  String? _errorMessage;
  String? _successMessage;

  // Getters
  List<UserPrescription> get prescriptions => _prescriptions;
  bool get isLoading => _isLoading;
  bool get isRefreshing => _isRefreshing;
  String? get errorMessage => _errorMessage;
  String? get successMessage => _successMessage;
  bool get hasPrescriptions => _prescriptions.isNotEmpty;
  int get prescriptionCount => _prescriptions.length;

  // Initialize and fetch prescriptions
  Future<void> initialize() async {
    await fetchUserPrescriptions();
  }

  // Fetch user prescriptions
  Future<void> fetchUserPrescriptions() async {
    if (_isLoading) return; // Prevent multiple simultaneous calls

    _setLoading(true);
    _clearMessages();

    try {
      print('Starting to fetch user prescriptions...');
      
      final prescriptions = await GetUserPrescriptionService.getUserPrescriptions();
      
      _prescriptions = prescriptions;
      _setSuccessMessage('Prescriptions loaded successfully');
      
      print('Successfully loaded ${prescriptions.length} prescriptions');
      
    } catch (e) {
      print('Error fetching prescriptions: $e');
      _setErrorMessage(e.toString());
      _prescriptions = []; // Clear any existing data on error
    } finally {
      _setLoading(false);
    }
  }

  // Refresh prescriptions (pull-to-refresh)
  Future<void> refreshPrescriptions() async {
    if (_isRefreshing) return; // Prevent multiple simultaneous refreshes

    _setRefreshing(true);
    _clearMessages();

    try {
      print('Refreshing prescriptions...');
      
      final prescriptions = await GetUserPrescriptionService.refreshUserPrescriptions();
      
      _prescriptions = prescriptions;
      _setSuccessMessage('Prescriptions refreshed successfully');
      
      print('Successfully refreshed ${prescriptions.length} prescriptions');
      
    } catch (e) {
      print('Error refreshing prescriptions: $e');
      _setErrorMessage('Failed to refresh prescriptions: ${e.toString()}');
    } finally {
      _setRefreshing(false);
    }
  }

  // Get prescription by ID
  UserPrescription? getPrescriptionById(String id) {
    try {
      return _prescriptions.firstWhere((prescription) => prescription.id == id);
    } catch (e) {
      return null;
    }
  }

  // Get prescriptions by pharmacy
  List<UserPrescription> getPrescriptionsByPharmacy(String pharmacyId) {
    return _prescriptions
        .where((prescription) => prescription.pharmacy.id == pharmacyId)
        .toList();
  }

  // Get recent prescriptions (last 30 days)
  List<UserPrescription> getRecentPrescriptions() {
    final thirtyDaysAgo = DateTime.now().subtract(Duration(days: 30));
    return _prescriptions
        .where((prescription) => prescription.createdAt.isAfter(thirtyDaysAgo))
        .toList();
  }

  // Sort prescriptions by date (newest first)
  List<UserPrescription> getSortedPrescriptions({bool newestFirst = true}) {
    List<UserPrescription> sorted = List.from(_prescriptions);
    sorted.sort((a, b) {
      return newestFirst 
          ? b.createdAt.compareTo(a.createdAt)
          : a.createdAt.compareTo(b.createdAt);
    });
    return sorted;
  }

  // Check if image is accessible
  Future<bool> checkImageAccessibility(String imageUrl) async {
    try {
      return await GetUserPrescriptionService.isImageAccessible(imageUrl);
    } catch (e) {
      print('Error checking image accessibility: $e');
      return false;
    }
  }

  // Get image size
  Future<String> getImageSize(String imageUrl) async {
    try {
      return await GetUserPrescriptionService.getImageSize(imageUrl);
    } catch (e) {
      print('Error getting image size: $e');
      return 'Unknown size';
    }
  }

  // Clear all messages
  void clearMessages() {
    _clearMessages();
  }

  // Private helper methods
  void _setLoading(bool loading) {
    if (_isLoading != loading) {
      _isLoading = loading;
      notifyListeners();
    }
  }

  void _setRefreshing(bool refreshing) {
    if (_isRefreshing != refreshing) {
      _isRefreshing = refreshing;
      notifyListeners();
    }
  }

  void _setErrorMessage(String message) {
    _errorMessage = message;
    _successMessage = null;
    notifyListeners();
  }

  void _setSuccessMessage(String message) {
    _successMessage = message;
    _errorMessage = null;
    notifyListeners();
  }

  void _clearMessages() {
    if (_errorMessage != null || _successMessage != null) {
      _errorMessage = null;
      _successMessage = null;
      notifyListeners();
    }
  }

  // Reset provider state
  void reset() {
    _prescriptions = [];
    _isLoading = false;
    _isRefreshing = false;
    _errorMessage = null;
    _successMessage = null;
    notifyListeners();
  }

  @override
  void dispose() {
    // Clean up any resources if needed
    super.dispose();
  }
}