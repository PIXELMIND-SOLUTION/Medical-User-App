import 'package:flutter/foundation.dart';
import 'package:medical_user_app/models/user_model.dart';
import 'package:medical_user_app/services/auth_service.dart';
import 'package:medical_user_app/utils/shared_preferences_helper.dart';

enum AuthState {
  initial,
  loading,
  authenticated,
  unauthenticated,
  error,
}

class AuthProvider with ChangeNotifier {
  AuthState _state = AuthState.initial;
  User? _user;
  String? _token;
  String _errorMessage = '';

  // Getters
  AuthState get state => _state;
  User? get user => _user;
  String? get token => _token;
  String get errorMessage => _errorMessage;
  bool get isAuthenticated => _state == AuthState.authenticated;
  bool get isLoading => _state == AuthState.loading;

  // Initialize auth state on app start
  // Future<void> initializeAuth() async {
  //   _setState(AuthState.loading);
    
  //   try {
  //     final authData = await SharedPreferencesHelper.getAuthData();
  //     final isLoggedIn = authData['isLoggedIn'] as bool;
      
  //     if (isLoggedIn) {
  //       _user = authData['user'] as User?;
  //       _token = authData['token'] as String?;
        
  //       // Validate token if needed
  //       final isValid = await AuthService.validateToken();
        
  //       if (isValid && _user != null && _token != null) {
  //         _setState(AuthState.authenticated);
  //       } else {
  //         await logout();
  //       }
  //     } else {
  //       _setState(AuthState.unauthenticated);
  //     }
  //   } catch (e) {
  //     _setError('Failed to initialize auth: $e');
  //   }
  // }

  // Register user
  Future<bool> register({
    required String name,
    required String mobile,
  }) async {
    _setState(AuthState.loading);
    
    try {
      final response = await AuthService.register(
        name: name,
        mobile: mobile,
      );
      
      _user = response.user;
      _token = response.token;
      
      // Save to shared preferences if token is provided
      // if (_token != null) {
      //   await SharedPreferencesHelper.saveAuthData(
      //     token: _token!,
      //     user: _user!,
      //   );
      //   _setState(AuthState.authenticated);
      // } else {
      //   _setState(AuthState.unauthenticated);
      // }
      
      return true;
    } catch (e) {
      _setError(e.toString());
      return false;
    }
  }

  // Login user
  Future<bool> login({
    required String mobile,
  }) async {
    _setState(AuthState.loading);
    
    try {
      final response = await AuthService.login(mobile: mobile);
      
      _user = response.user;
      _token = response.token;
      
      if (_token != null && _user != null) {
        // await SharedPreferencesHelper.saveAuthData(
        //   token: _token!,
        //   user: _user!,
        // );
        // _setState(AuthState.authenticated);
        return true;
      } else {
        _setError('Invalid response from server');
        return false;
      }
    } catch (e) {
      _setError(e.toString());
      return false;
    }
  }

  // Logout user
  Future<void> logout() async {
    _setState(AuthState.loading);
    
    try {
      // await SharedPreferencesHelper.clearAuthData();
      _user = null;
      _token = null;
      _errorMessage = '';
      _setState(AuthState.unauthenticated);
    } catch (e) {
      _setError('Failed to logout: $e');
    }
  }

  // Update user profile
  void updateUser(User updatedUser) {
    _user = updatedUser;
    // SharedPreferencesHelper.saveUser(updatedUser);
    notifyListeners();
  }

  // Clear error
  void clearError() {
    _errorMessage = '';
    notifyListeners();
  }

  // Private methods
  void _setState(AuthState newState) {
    _state = newState;
    notifyListeners();
  }

  void _setError(String error) {
    _errorMessage = error;
    _setState(AuthState.error);
  }
}
