import 'package:flutter/material.dart';
import 'package:medical_user_app/view/home_screen.dart';
import 'package:medical_user_app/widgets/progress_bar.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Notifications',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.arrow_back_ios_new, size: 18),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                      width: 1,
                      color: const Color.fromARGB(255, 192, 192, 192))),
              child: Stack(
                children: [
                  // Main Content Column
                  Column(
                    children: [
                      // Header Row
                      Row(
                        children: [
                          // App Icon and Order Status
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.blue[50],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset(
                                "assets/tablet.png",
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "Your Order will be\ndelivery in 10 min.",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // Progress Bar
                      CustomProgressBar(currentStep: 2, totalSteps: 3),
                      const SizedBox(height: 16),
                      // Order Status Icons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          // Order Placed
                          _buildStepItem(
                            imagePath: 'assets/icons/cart.png',
                            label: 'Order\nPlaced',
                          ),

                          // Order Pickup
                          _buildStepItem(
                            imagePath: 'assets/icons/pickup.png',
                            label: 'Order\nPickup',
                          ),

                          // Order Delivery (active)
                          _buildStepItem(
                            imagePath: 'assets/icons/order.png',
                            label: 'Order\nDelivery',
                          ),
                        ],
                      ),
                    ],
                  ),
                  // Updated Time Text - positioned at top right
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Text(
                      "Updated 6 sec ago",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            _orderId(),
            const Spacer(),

            // Proceed button
            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomeScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0XFF5931DD),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Go To Home',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepItem({
    required String imagePath,
    required String label,
  }) {
    return Column(
      children: [
        Container(
          width: 44,
          height: 44,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(50),
            border: Border.all(
              color: Colors.grey.shade300,
              width: 2,
            ),
          ),
          child: Image.asset(
            imagePath,
            width: 24,
            height: 24,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.normal,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _orderId() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                  width: 1, color: const Color.fromARGB(255, 192, 192, 192))),
          child: Stack(
            children: [
              // Main Content Column
              Column(
                children: [
                  // Header Row
                  Row(
                    children: [
                      // App Icon and Order Status
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.blue[50],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            "assets/tablet.png",
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "Your order ID:\n12345678943",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Positioned(
                top: 0,
                right: 0,
                child: Column(
                  children: [
                    Text(
                      "6 sec ago",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                    Icon(Icons.keyboard_arrow_down)
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
