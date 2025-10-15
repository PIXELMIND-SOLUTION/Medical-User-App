// providers/add_query_provider.dart
import 'package:flutter/material.dart';
import '../models/query_model.dart';
import '../services/add_query_service.dart';

class AddQueryProvider extends ChangeNotifier {
  final AddQueryService _queryService = AddQueryService();
  
  bool _isLoading = false;
  String? _errorMessage;
  String? _successMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String? get successMessage => _successMessage;

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String? error) {
    _errorMessage = error;
    notifyListeners();
  }

  void _setSuccess(String? message) {
    _successMessage = message;
    notifyListeners();
  }

  Future<bool> submitQuery({
    required String name,
    required String email,
    required String mobile,
    required String message,
  }) async {
    _setLoading(true);
    _setError(null);
    _setSuccess(null);

    try {
      final query = QueryModel(
        name: name,
        email: email,
        mobile: mobile,
        message: message,
      );

      final response = await _queryService.submitQuery(query);
      
      if (response != null) {
        _setSuccess(response.message);
        _setLoading(false);
        return true;
      } else {
        _setError('Failed to submit query');
        _setLoading(false);
        return false;
      }
    } catch (e) {
      _setError(e.toString().replaceAll('Exception: ', ''));
      _setLoading(false);
      return false;
    }
  }

  void clearMessages() {
    _errorMessage = null;
    _successMessage = null;
    notifyListeners();
  }
}