import 'package:flutter/material.dart';
import 'package:medical_user_app/services/order_status_service.dart';
import 'package:medical_user_app/utils/shared_preferences_helper.dart';

class OrderStatusProvider extends ChangeNotifier {
  // Loading states
  bool _isLoading = false;
  bool _isRefreshing = false;

  // Data
  OrderStatusResponse? _orderStatus;
  String? _currentUserId;
  String? _errorMessage;

  // Auto-refresh timer
  DateTime? _lastFetchTime;
  static const Duration _cacheTimeout = Duration(minutes: 2);

  // Getters
  bool get isLoading => _isLoading;
  bool get isRefreshing => _isRefreshing;
  OrderStatusResponse? get orderStatus => _orderStatus;
  String? get errorMessage => _errorMessage;
  List<StatusTimeline> get statusTimeline => _orderStatus?.statusTimeline ?? [];
  List<OrderMedicine> get medicines => _orderStatus?.medicines ?? [];
  String? get deliveryNote => _orderStatus?.deliveryNote;
  
  // Helper getters
  bool get hasOrderStatus => _orderStatus != null;
  bool get hasActiveOrder => hasOrderStatus && statusTimeline.isNotEmpty;
  
  StatusTimeline? get currentStatus {
    if (statusTimeline.isEmpty) return null;
    // Return the latest status (last in the list)
    return statusTimeline.last;
  }

  String get currentStatusText => currentStatus?.status ?? 'No Status';
  String get currentStatusMessage => currentStatus?.message ?? '';

  bool get isOrderCompleted {
    if (currentStatus == null) return false;
    final status = currentStatus!.status.toLowerCase();
    return ['delivered', 'completed', 'cancelled'].contains(status);
  }

  bool get isOrderCancelled {
    if (currentStatus == null) return false;
    return currentStatus!.status.toLowerCase() == 'cancelled';
  }

  // Initialize provider
  Future<void> initialize() async {
    try {
      final user = await SharedPreferencesHelper.getUser();
      if (user != null) {
        _currentUserId = user.id;
        await fetchOrderStatus();
      } else {
        _setError('User not found. Please login again.');
      }
    } catch (e) {
      _setError('Failed to initialize: ${e.toString()}');
    }
  }

  // Fetch order status
  Future<void> fetchOrderStatus({bool showLoading = true}) async {
    if (_currentUserId == null) {
      _setError('User ID not available');
      return;
    }

    // Check cache validity
    if (_shouldUseCachedData() && _orderStatus != null) {
      print('Using cached order status data');
      return;
    }

    if (showLoading) {
      _setLoading(true);
    }

    try {
      _clearError();
      
      final response = await OrderStatusService.getOrderStatusParsed(_currentUserId!);
      
      if (response != null) {
        _orderStatus = response;
        _lastFetchTime = DateTime.now();
        print('Order status fetched successfully');
        print('Status timeline count: ${response.statusTimeline.length}');
        print('Current status: ${currentStatusText}');
      } else {
        _setError('No order status data available');
        _orderStatus = null;
      }
    } catch (e) {
      print('Error in fetchOrderStatus: $e');
      _setError('Failed to fetch order status: ${e.toString()}');
    } finally {
      if (showLoading) {
        _setLoading(false);
      }
    }
  }

  // Refresh order status
  Future<void> refreshOrderStatus() async {
    _setRefreshing(true);
    _lastFetchTime = null; // Force fresh data
    
    try {
      await fetchOrderStatus(showLoading: false);
    } finally {
      _setRefreshing(false);
    }
  }

  // Check if we should use cached data
  bool _shouldUseCachedData() {
    if (_lastFetchTime == null) return false;
    final now = DateTime.now();
    return now.difference(_lastFetchTime!) < _cacheTimeout;
  }

  // Set loading state
  void _setLoading(bool loading) {
    if (_isLoading != loading) {
      _isLoading = loading;
      notifyListeners();
    }
  }

  // Set refreshing state
  void _setRefreshing(bool refreshing) {
    if (_isRefreshing != refreshing) {
      _isRefreshing = refreshing;
      notifyListeners();
    }
  }

  // Set error message
  void _setError(String message) {
    _errorMessage = message;
    print('OrderStatusProvider Error: $message');
    notifyListeners();
  }

  // Clear error message
  void _clearError() {
    if (_errorMessage != null) {
      _errorMessage = null;
      notifyListeners();
    }
  }

  // Get status timeline with proper sorting
  List<StatusTimeline> get sortedStatusTimeline {
    if (statusTimeline.isEmpty) return [];
    
    final sorted = List<StatusTimeline>.from(statusTimeline);
    sorted.sort((a, b) {
      final aTime = a.parsedTimestamp;
      final bTime = b.parsedTimestamp;
      if (aTime == null || bTime == null) return 0;
      return aTime.compareTo(bTime); // Ascending order (oldest first)
    });
    return sorted;
  }

  // Get formatted timeline for UI display
  List<Map<String, dynamic>> get formattedTimeline {
    return sortedStatusTimeline.map((timeline) {
      return {
        'status': timeline.status,
        'message': timeline.message,
        'timestamp': timeline.parsedTimestamp,
        'isCompleted': true, // All items in timeline are completed
        'isCurrent': timeline.isLatestIn(statusTimeline),
      };
    }).toList();
  }

  // Get total medicine count
  int get totalMedicineQuantity {
    return medicines.fold(0, (sum, medicine) => sum + medicine.quantity);
  }

  // Get total order value
  int get totalOrderValue {
    return medicines.fold(0, (sum, medicine) => sum + medicine.totalPrice);
  }

  // Search for specific status in timeline
  StatusTimeline? getStatusByType(String statusType) {
    return statusTimeline.firstWhere(
      (timeline) => timeline.status.toLowerCase() == statusType.toLowerCase(),
      orElse: () => StatusTimeline(
        status: '',
        message: '',
        timestamp: '',
        id: '',
      ),
    );
  }

  // Check if a specific status exists
  bool hasStatus(String statusType) {
    return statusTimeline.any(
      (timeline) => timeline.status.toLowerCase() == statusType.toLowerCase(),
    );
  }

  // Get estimated delivery time (if available in the timeline)
  DateTime? get estimatedDeliveryTime {
    // Look for delivery-related status
    final deliveryStatus = statusTimeline.firstWhere(
      (timeline) => timeline.status.toLowerCase().contains('delivery') ||
                   timeline.status.toLowerCase().contains('estimated'),
      orElse: () => StatusTimeline(status: '', message: '', timestamp: '', id: ''),
    );
    
    return deliveryStatus.parsedTimestamp;
  }

  // Auto-refresh functionality
  void startAutoRefresh() {
    // Refresh every 30 seconds if order is active
    if (hasActiveOrder && !isOrderCompleted) {
      Future.delayed(const Duration(seconds: 30), () {
        if (hasActiveOrder && !isOrderCompleted) {
          refreshOrderStatus();
          startAutoRefresh(); // Continue refreshing
        }
      });
    }
  }

  // Stop auto-refresh
  void stopAutoRefresh() {
    // Auto-refresh will stop naturally when order is completed
  }

  // Clear all data
  void clearData() {
    _orderStatus = null;
    _currentUserId = null;
    _errorMessage = null;
    _lastFetchTime = null;
    _isLoading = false;
    _isRefreshing = false;
    notifyListeners();
  }

  // Reset and reload
  Future<void> reset() async {
    clearData();
    await initialize();
  }

  @override
  void dispose() {
    stopAutoRefresh();
    super.dispose();
  }

  // Debug method
  void debugPrint() {
    print('=== ORDER STATUS PROVIDER DEBUG ===');
    print('Current User ID: $_currentUserId');
    print('Has Order Status: $hasOrderStatus');
    print('Is Loading: $_isLoading');
    print('Is Refreshing: $_isRefreshing');
    print('Error Message: $_errorMessage');
    print('Current Status: $currentStatusText');
    print('Status Timeline Count: ${statusTimeline.length}');
    print('Medicines Count: ${medicines.length}');
    print('Last Fetch Time: $_lastFetchTime');
    print('=== END DEBUG ===');
  }
}