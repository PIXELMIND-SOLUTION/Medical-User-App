import 'package:flutter/material.dart';
import 'package:medical_user_app/constant/api_constants.dart';
import 'package:medical_user_app/models/order_model.dart';
import 'package:medical_user_app/models/user_model.dart';
import 'package:medical_user_app/utils/shared_preferences_helper.dart';
import 'package:medical_user_app/providers/order_provider.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ReorderDetailScreen extends StatefulWidget {
  final OrderModel order;

  const ReorderDetailScreen({Key? key, required this.order}) : super(key: key);

  @override
  State<ReorderDetailScreen> createState() => _ReorderDetailScreenState();
}

class _ReorderDetailScreenState extends State<ReorderDetailScreen> {
  late Razorpay razorpay;
  bool _isProcessingOrder = false;
  String _selectedPaymentMethod = "Cash on Delivery";

  @override
  void initState() {
    super.initState();
    
    // Initialize Razorpay
    razorpay = Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccessResponse);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWalletSelected);
  }

  @override
  void dispose() {
    super.dispose();
    razorpay.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Reorder Details',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Order Summary Card
                  _buildOrderSummaryCard(),
                  const SizedBox(height: 20),
                  
                  // Items List
                  _buildItemsList(),
                  const SizedBox(height: 20),
                  
                  // Delivery Address
                  _buildDeliveryAddress(),
                  const SizedBox(height: 20),
                  
                  // Payment Method Selection
                  _buildPaymentMethodSection(),
                  const SizedBox(height: 20),
                  
                  // Price Breakdown
                  _buildPriceBreakdown(),
                ],
              ),
            ),
          ),
          
          // Bottom Place Order Button
          _buildBottomButton(),
        ],
      ),
    );
  }

  Widget _buildOrderSummaryCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF5931DD).withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF5931DD).withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF5931DD),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.refresh,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Reordering Previous Order',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF5931DD),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Order ID: #${widget.order.id.substring(0, 8)}...',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemsList() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Items (${widget.order.orderItems.length})',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Divider(height: 1),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.order.orderItems.length,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final item = widget.order.orderItems[index];
              return Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: item.imageUrl != null
                          ? Image.network(
                              item.imageUrl!,
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                  'assets/tablet.png',
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.cover,
                                );
                              },
                            )
                          : Image.asset(
                              'assets/tablet.png',
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.name,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Quantity: ${item.quantity}',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                     Text(
                      '₹${widget.order.totalAmount.toStringAsFixed(0)}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF5931DD),
                      ),
                    ),
                    // Text(
                    //   '₹${item.price.toStringAsFixed(0)}',
                    //   style: const TextStyle(
                    //     fontSize: 16,
                    //     fontWeight: FontWeight.bold,
                    //     color: Color(0xFF5931DD),
                    //   ),
                    // ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryAddress() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.location_on, color: Color(0xFF5931DD), size: 20),
              SizedBox(width: 8),
              Text(
                'Delivery Address',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            widget.order.deliveryAddress.city ?? 'No address provided',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Payment Method',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          
          // Cash on Delivery Option
          _buildPaymentOption(
            title: 'Cash on Delivery',
            subtitle: 'Pay when you receive',
            icon: Icons.money,
            value: 'Cash on Delivery',
          ),
          
          const SizedBox(height: 12),
          
          // Razorpay Option
          _buildPaymentOption(
            title: 'Pay Online',
            subtitle: 'UPI, Card, Wallet & More',
            icon: Icons.payment,
            value: 'Razorpay',
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentOption({
    required String title,
    required String subtitle,
    required IconData icon,
    required String value,
  }) {
    final isSelected = _selectedPaymentMethod == value;
    
    return InkWell(
      onTap: () {
        setState(() {
          _selectedPaymentMethod = value;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF5931DD).withOpacity(0.1) : Colors.grey[50],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? const Color(0xFF5931DD) : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF5931DD) : Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: isSelected ? Colors.white : Colors.grey[600],
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? const Color(0xFF5931DD) : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Radio<String>(
              value: value,
              groupValue: _selectedPaymentMethod,
              onChanged: (val) {
                setState(() {
                  _selectedPaymentMethod = val!;
                });
              },
              activeColor: const Color(0xFF5931DD),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceBreakdown() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          _buildPriceRow('Subtotal', widget.order.totalAmount),
          const SizedBox(height: 8),
          // _buildPriceRow('Delivery Fee', 0),
          const SizedBox(height: 8),
          const Divider(),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total Amount',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '₹${widget.order.totalAmount.toStringAsFixed(0)}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF5931DD),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRow(String label, double amount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[700],
          ),
        ),
        Text(
          '₹${amount.toStringAsFixed(0)}',
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildBottomButton() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: SafeArea(
        child: ElevatedButton(
          onPressed: _isProcessingOrder ? null : _handlePlaceOrder,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF5931DD),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16),
            minimumSize: const Size(double.infinity, 50),
          ),
          child: _isProcessingOrder
              ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              : Text(
                  _selectedPaymentMethod == "Cash on Delivery"
                      ? 'Place Order - ₹${widget.order.totalAmount.toStringAsFixed(0)}'
                      : 'Pay Now - ₹${widget.order.totalAmount.toStringAsFixed(0)}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ),
      ),
    );
  }

  void _handlePlaceOrder() {
    if (_selectedPaymentMethod == "Cash on Delivery") {
      // Process order with COD
      _processOrder(null);
    } else {
      // Open Razorpay for payment
      _initiateRazorpayPayment();
    }
  }

  void _initiateRazorpayPayment() {
    var options = {
      'key': 'rzp_test_BxtRNvflG06PTV',
      'amount': (widget.order.totalAmount * 100).toInt(),
      'name': 'Medical App',
      'description': 'Medicine Reorder Payment',
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {
        'contact': "9961593179",
        'email': "user@example.com",
      },
      'external': {
        'wallets': ['paytm']
      }
    };
    
    try {
      setState(() {
        _isProcessingOrder = true;
      });
      razorpay.open(options);
    } catch (e) {
      setState(() {
        _isProcessingOrder = false;
      });
      _showErrorSnackBar("Failed to open payment gateway: $e");
    }
  }

  Future<void> _processOrder(String? paymentId) async {
    try {
      setState(() {
        _isProcessingOrder = true;
      });

      User? user = await SharedPreferencesHelper.getUser();
      if (user == null || user.id.isEmpty) {
        throw Exception("User not logged in");
      }

      final String apiUrl = '${ApiConstants.baseUrl}/users/reorder/${user.id}/${widget.order.id}';
      
      final Map<String, dynamic> payload = {
        "paymentMethod": _selectedPaymentMethod == "Cash on Delivery" ? "Cash on Delivery" : "Cash on Delivery",
        "transactionId": paymentId ?? ""
      };

      print("Making reorder API call to: $apiUrl");
      print("Payload: ${jsonEncode(payload)}");

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(payload),
      );

      print("API Response Status: ${response.statusCode}");
      print("API Response Body: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        
        setState(() {
          _isProcessingOrder = false;
        });

        // Refresh orders in OrderProvider
        final orderProvider = Provider.of<OrderProvider>(context, listen: false);
        orderProvider.refreshOrders();

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Order placed successfully!'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 3),
          ),
        );

        // Navigate back
        Navigator.pop(context);

      } else {
        String errorMessage = "Failed to place order";
        try {
          final errorData = jsonDecode(response.body);
          errorMessage = errorData['message'] ?? errorMessage;
        } catch (e) {
          // Use default message
        }
        
        setState(() {
          _isProcessingOrder = false;
        });
        
        _showErrorSnackBar("Order failed: $errorMessage");
      }

    } catch (e) {
      setState(() {
        _isProcessingOrder = false;
      });
      print("Error in _processOrder: $e");
      _showErrorSnackBar("Order processing failed: ${e.toString()}");
    }
  }

  void handlePaymentErrorResponse(PaymentFailureResponse response) {
    setState(() {
      _isProcessingOrder = false;
    });
    _showErrorSnackBar("Payment Failed: ${response.message}");
  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse response) async {
    try {
      await _processOrder(response.paymentId);
    } catch (e) {
      setState(() {
        _isProcessingOrder = false;
      });
      _showErrorSnackBar("Order processing failed after payment: $e");
    }
  }

  void handleExternalWalletSelected(ExternalWalletResponse response) {
    setState(() {
      _isProcessingOrder = false;
    });
    _showErrorSnackBar("External wallet selected: ${response.walletName}");
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 4),
      ),
    );
  }
}