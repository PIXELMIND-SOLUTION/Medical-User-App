// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:medical_user_app/services/address_service.dart';
// import 'package:medical_user_app/models/user_model.dart';
// import 'package:medical_user_app/utils/shared_preferences_helper.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class AddressProvider extends ChangeNotifier {
//   List<dynamic> _addresses = [];
//   bool _isLoading = false;
//   String _errorMessage = '';

//   // Getters
//   List<dynamic> get addresses => _addresses;
//   bool get isLoading => _isLoading;
//   String get errorMessage => _errorMessage;

//   // Set loading state
//   void _setLoading(bool loading) {
//     _isLoading = loading;
//     notifyListeners();
//   }

//   // Set error message
//   void _setError(String error) {
//     _errorMessage = error;
//     notifyListeners();
//   }

//   // Clear error message
//   void clearError() {
//     _errorMessage = '';
//     notifyListeners();
//   }

//   // Fetch user addresses
//   // Future<void> fetchAddresses() async {
//   //   try {
//   //     _setLoading(true);
//   //     _setError('');

//   //     // Get user data from shared preferences
//   //     final User? user = await SharedPreferencesHelper.getUser();
      
//   //     if (user == null || user.id == null) {
//   //       _setError('User not found. Please login again.');
//   //       return;
//   //     }

//   //     final result = await AddressService.getUserAddresses(user.id!);

//   //     if (result['success']) {
//   //       _addresses = result['data'] ?? [];
//   //     } else {
//   //       _setError(result['message'] ?? 'Failed to fetch addresses');
//   //     }
//   //   } catch (e) {
//   //     _setError('An error occurred: ${e.toString()}');
//   //   } finally {
//   //     _setLoading(false);
//   //   }
//   // }


// Future<void> _debugUserData() async {
//   try {
//     print('=== DEBUG USER DATA ===');
    
//     // Check if SharedPreferences has the user key
//     final prefs = await SharedPreferences.getInstance();
//     final userJson = prefs.getString('user_data');
//     print('Raw user JSON from SharedPreferences: $userJson');
    
//     if (userJson != null) {
//       try {
//         final userMap = json.decode(userJson);
//         print('Decoded user map: $userMap');
//         print('User ID from map: ${userMap['id']}');
//       } catch (e) {
//         print('Error decoding user JSON: $e');
//       }
//     }
    
//     // Try to get user using your helper
//     final User? user = await SharedPreferencesHelper.getUser();
//     print('User from helper: $user');
    
//     if (user != null) {
//       print('User ID: ${user.id}');
//       print('User name: ${user.name}');
//       print('User mobile: ${user.mobile}');
//     } else {
//       print('User is null from helper');
//     }
    
//     // Check auth data
//     final authData = await SharedPreferencesHelper.getAuthData();
//     print('Complete auth data: $authData');
    
//     print('=== END DEBUG ===');
//   } catch (e) {
//     print('Debug error: $e');
//   }
// }



//   Future<void> fetchAddresses() async {
//   try {
//     _setLoading(true);
//     _setError('');

//     // Add debug call
//     await _debugUserData();

//     // Get user data from shared preferences
//     final User? user = await SharedPreferencesHelper.getUser();
    
//     if (user == null) {
//       print('User is null');
//       _setError('User not found. Please login again.');
//       return;
//     }
    
//     if (user.id == null || user.id.isEmpty) {
//       print('User ID is null or empty: ${user.id}');
//       _setError('User ID not found. Please login again.');
//       return;
//     }

//     print('Fetching addresses for user ID: ${user.id}');

//     final result = await AddressService.getUserAddresses(user.id);

//     if (result['success']) {
//       _addresses = result['data'] ?? [];
//     } else {
//       _setError(result['message'] ?? 'Failed to fetch addresses');
//     }
//   } catch (e) {
//     print('Error in fetchAddresses: $e');
//     _setError('An error occurred: ${e.toString()}');
//   } finally {
//     _setLoading(false);
//   }
// }

//   // Add new address
//   Future<bool> addAddress({
//     required String house,
//     required String street,
//     required String city,
//     required String state,
//     required String pincode,
//     required String country,
//   }) async {
//     try {
//       _setLoading(true);
//       _setError('');

//       // Get user data from shared preferences
//       final User? user = await SharedPreferencesHelper.getUser();


//       print('user idddddddddddddddddddddddddddd ${user?.id}');
      
//       if (user == null || user.id == null) {
//         _setError('User not found. Please login again.');
//         return false;
//       }

//       final result = await AddressService.addAddress(
//         userId: user.id!,
//         house: house,
//         street: street,
//         city: city,
//         state: state,
//         pincode: pincode,
//         country: country,
//       );

//       if (result['success']) {
//         // Refresh addresses list after adding
//         await fetchAddresses();
//         return true;
//       } else {
//         _setError(result['message'] ?? 'Failed to add address');
//         return false;
//       }
//     } catch (e) {
//       _setError('An error occurred: ${e.toString()}');
//       return false;
//     } finally {
//       _setLoading(false);
//     }
//   }

//   // Add address to local list (for immediate UI update)
//   void addAddressToList(Map<String, dynamic> address) {
//     _addresses.add(address);
//     notifyListeners();
//   }

//   // Update specific address
//   void updateAddressInList(int index, Map<String, dynamic> updatedAddress) {
//     if (index >= 0 && index < _addresses.length) {
//       _addresses[index] = updatedAddress;
//       notifyListeners();
//     }
//   }

//   // Remove address from list
//   void removeAddressFromList(int index) {
//     if (index >= 0 && index < _addresses.length) {
//       _addresses.removeAt(index);
//       notifyListeners();
//     }
//   }

//   // Clear all addresses
//   void clearAddresses() {
//     _addresses.clear();
//     notifyListeners();
//   }

//   // Get address by index
//   Map<String, dynamic>? getAddressAt(int index) {
//     if (index >= 0 && index < _addresses.length) {
//       return _addresses[index];
//     }
//     return null;
//   }

//   // Check if addresses list is empty
//   bool get hasAddresses => _addresses.isNotEmpty;

//   // Get addresses count
//   int get addressCount => _addresses.length;
// }














import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:medical_user_app/services/address_service.dart';
import 'package:medical_user_app/models/user_model.dart';
import 'package:medical_user_app/utils/shared_preferences_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddressProvider extends ChangeNotifier {
  List<dynamic> _addresses = [];
  bool _isLoading = false;
  String _errorMessage = '';

  // Getters
  List<dynamic> get addresses => _addresses;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

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

  Future<void> _debugUserData() async {
    try {
      print('=== DEBUG USER DATA ===');
      
      // Check if SharedPreferences has the user key
      final prefs = await SharedPreferences.getInstance();
      final userJson = prefs.getString('user_data');
      print('Raw user JSON from SharedPreferences: $userJson');
      
      if (userJson != null) {
        try {
          final userMap = json.decode(userJson);
          print('Decoded user map: $userMap');
          print('User ID from map: ${userMap['id']}');
        } catch (e) {
          print('Error decoding user JSON: $e');
        }
      }
      
      // Try to get user using your helper
      final User? user = await SharedPreferencesHelper.getUser();
      print('User from helper: $user');
      
      if (user != null) {
        print('User ID: ${user.id}');
        print('User name: ${user.name}');
        print('User mobile: ${user.mobile}');
      } else {
        print('User is null from helper');
      }
      
      // Check auth data
      final authData = await SharedPreferencesHelper.getAuthData();
      print('Complete auth data: $authData');
      
      print('=== END DEBUG ===');
    } catch (e) {
      print('Debug error: $e');
    }
  }

  // Future<void> fetchAddresses() async {
  //   try {
  //     print('=== FETCH ADDRESSES STARTED ===');
  //     _setLoading(true);
  //     _setError('');

  //     // Add debug call
  //     await _debugUserData();

  //     // Get user data from shared preferences
  //     final User? user = await SharedPreferencesHelper.getUser();
      
  //     if (user == null) {
  //       print('User is null');
  //       _setError('User not found. Please login again.');
  //       return;
  //     }
      
  //     if (user.id == null || user.id.isEmpty) {
  //       print('User ID is null or empty: ${user.id}');
  //       _setError('User ID not found. Please login again.');
  //       return;
  //     }

  //     print('Fetching addresses for user ID: ${user.id}');

  //     // Add API endpoint debug
  //     await AddressService.debugApiEndpoint(user.id);

  //     final result = await AddressService.getUserAddresses(user.id);
      
  //     print('Service result: $result');

  //     if (result['success']) {
  //       _addresses = result['data'] ?? [];
  //       print('Successfully loaded ${_addresses.length} addresses');
        
  //       // Clear any previous errors on success
  //       _errorMessage = '';
  //     } else {
  //       final errorMessage = result['message'] ?? 'Failed to fetch addresses';
  //       print('Service returned error: $errorMessage');
  //       _setError(errorMessage);
  //     }
  //   } catch (e, stackTrace) {
  //     print('=== FETCH ADDRESSES ERROR ===');
  //     print('Error in fetchAddresses: $e');
  //     print('Stack trace: $stackTrace');
  //     print('=== END ERROR ===');
  //     _setError('An error occurred: ${e.toString()}');
  //   } finally {
  //     _setLoading(false);
  //     print('=== FETCH ADDRESSES COMPLETED ===');
  //   }
  // }

  Future<void> fetchAddresses() async {
    try {
      print('=== FETCH ADDRESSES STARTED ===');
      _setLoading(true);
      _setError('');

      await _debugUserData();

      final User? user = await SharedPreferencesHelper.getUser();
      
      if (user == null) {
        print('User is null');
        _setError('User not found. Please login again.');
        return;
      }
      
      if (user.id == null || user.id.isEmpty) {
        print('User ID is null or empty: ${user.id}');
        _setError('User ID not found. Please login again.');
        return;
      }

      print('Fetching addresses for user ID: ${user.id}');
      final result = await AddressService.getUserAddresses(user.id);
      
      print('Service result keys: ${result.keys}');
      print('Address data type: ${result['data']?.runtimeType}');
      print('Address data content: ${result['data']}');

      if (result['success']) {
        _addresses = List<dynamic>.from(result['data'] ?? []);
        print('Successfully loaded ${_addresses.length} addresses');
        _errorMessage = '';
      } else {
        final errorMessage = result['message'] ?? 'Failed to fetch addresses';
        print('Service returned error: $errorMessage');
        _setError(errorMessage);
      }
    } catch (e, stackTrace) {
      print('=== FETCH ADDRESSES ERROR ===');
      print('Error in fetchAddresses: $e');
      print('Stack trace: $stackTrace');
      _setError('An error occurred: ${e.toString()}');
    } finally {
      _setLoading(false);
      print('=== FETCH ADDRESSES COMPLETED ===');
    }
  }


  // Add new address
  Future<bool> addAddress({
    required String house,
    required String street,
    required String city,
    required String state,
    required String pincode,
    required String country,
  }) async {
    try {
      print('=== ADD ADDRESS STARTED ===');
      _setLoading(true);
      _setError('');

      // Get user data from shared preferences
      final User? user = await SharedPreferencesHelper.getUser();

      print('User ID for adding address: ${user?.id}');
      
      if (user == null || user.id == null || user.id.isEmpty) {
        _setError('User not found. Please login again.');
        return false;
      }

      final result = await AddressService.addAddress(
        userId: user.id!,
        house: house,
        street: street,
        city: city,
        state: state,
        pincode: pincode,
        country: country,
      );

      print('Add address service result: $result');

      if (result['success']) {
        // Refresh addresses list after adding
        await fetchAddresses();
        return true;
      } else {
        final errorMessage = result['message'] ?? 'Failed to add address';
        print('Add address service returned error: $errorMessage');
        _setError(errorMessage);
        return false;
      }
    } catch (e, stackTrace) {
      print('=== ADD ADDRESS ERROR ===');
      print('Error in addAddress: $e');
      print('Stack trace: $stackTrace');
      print('=== END ERROR ===');
      _setError('An error occurred: ${e.toString()}');
      return false;
    } finally {
      _setLoading(false);
      print('=== ADD ADDRESS COMPLETED ===');
    }
  }

  // Add address to local list (for immediate UI update)
  void addAddressToList(Map<String, dynamic> address) {
    _addresses.add(address);
    notifyListeners();
  }

  // Update specific address
  void updateAddressInList(int index, Map<String, dynamic> updatedAddress) {
    if (index >= 0 && index < _addresses.length) {
      _addresses[index] = updatedAddress;
      notifyListeners();
    }
  }

  // Remove address from list
  void removeAddressFromList(int index) {
    if (index >= 0 && index < _addresses.length) {
      _addresses.removeAt(index);
      notifyListeners();
    }
  }

  // Clear all addresses
  void clearAddresses() {
    _addresses.clear();
    notifyListeners();
  }

  // Get address by index
  Map<String, dynamic>? getAddressAt(int index) {
    if (index >= 0 && index < _addresses.length) {
      return _addresses[index];
    }
    return null;
  }

  // Check if addresses list is empty
  bool get hasAddresses => _addresses.isNotEmpty;

  // Get addresses count
  int get addressCount => _addresses.length;
}