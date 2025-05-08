import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medical_user_app/view/near_pharmacy_screen.dart';
import 'package:medical_user_app/view/payment_screen.dart';
import 'package:medical_user_app/widgets/bottom_navigation.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool isWeeklySelected = true;
  List<Map<String, dynamic>> medications = [
    {"name": "DOLO 500", "quantity": "1 Strip", "count": 1},
    {"name": "DOLO 500", "quantity": "1 Strip", "count": 1},
    {"name": "DOLO 500", "quantity": "1 Strip", "count": 1},
  ];
  int selectedDateIndex = 0;
  List<String> dates = ["22 Mar", "22 Mar", "22 Mar", "22 Mar"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[50],
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                  color: Color(0XFFEFF3F7),
                                  borderRadius: BorderRadius.circular(48)),
                              child: const Icon(Icons.shopping_cart),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "My Cart",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        const SizedBox(height: 34),
                        _buildMedicationList(),
                        const SizedBox(height: 34),
                        _buildCouponInputField(),
                        const SizedBox(height: 34),
                        _buildCheckoutContainer(),
                      ],
                    ),
                  ),
                ),
              ),
              _buildCheckoutButton(),
              const SizedBox(height: 40),
            ],
          ),
        ),
);
  }

  Future<void> _selectFromCalendar({required bool isStartDate}) async {
    final DateTime today = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: today,
      firstDate: today,
      lastDate: DateTime(today.year + 1),
    );
  }

  Widget _buildFrequencyToggle() {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromARGB(
            255, 237, 234, 245), // Light violet color for center background
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(24),
          right: Radius.circular(24),
        ),
      ),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              setState(() {
                isWeeklySelected = true;
              });
            },
            child: Container(
              height: 48,
              width: 166,
              decoration: BoxDecoration(
                color: isWeeklySelected
                    ? const Color(0xFF5931DD)
                    : Colors.transparent,
                borderRadius: const BorderRadius.horizontal(
                  left: Radius.circular(24),
                  right: Radius.circular(24),
                ),
                border: Border.all(
                  color: const Color(0xFF5931DD),
                  width: 1,
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                'Weekly',
                style: TextStyle(
                  color: isWeeklySelected ? Colors.white : Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                isWeeklySelected = false;
              });
            },
            child: Container(
              height: 48,
              width: 166,
              decoration: BoxDecoration(
                color: !isWeeklySelected
                    ? const Color(0xFF5931DD)
                    : Colors.transparent,
                borderRadius: const BorderRadius.horizontal(
                  left: Radius.circular(24),
                  right: Radius.circular(24),
                ),
                border: Border.all(
                  color: const Color(0xFF5931DD),
                  width: 1,
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                'Monthly',
                style: TextStyle(
                  color: !isWeeklySelected ? Colors.white : Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMedicationList() {
    return Column(
      children: List.generate(
        medications.length * 2 - 1,
        (i) {
          if (i.isEven) {
            final med = medications[i ~/ 2];
            return _buildMedicationItem(med);
          } else {
            return const Divider(
              color: Color.fromARGB(255, 221, 221, 221),
              height: 1,
              thickness: 1,
            );
          }
        },
      ),
    );
  }

  Widget _buildMedicationItem(Map<String, dynamic> medication) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.blue.shade100,
              borderRadius: BorderRadius.circular(8),
              image: const DecorationImage(
                image: AssetImage('assets/tablet.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  medication["name"],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Text(
                  'Qty: ${medication["quantity"]}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 221, 221, 221),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  icon: const Icon(Icons.remove, size: 20),
                  onPressed: () {
                    if (medication["count"] > 1) {
                      setState(() {
                        medication["count"]--;
                      });
                    }
                  },
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '0${medication["count"]}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 8),
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: const Color(0xFF5931DD),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  icon: const Icon(Icons.add, size: 16, color: Colors.white),
                  onPressed: () {
                    setState(() {
                      medication["count"]++;
                    });
                  },
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ),
              const SizedBox(width: 25),
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: const Color.fromARGB(255, 221, 221, 221)),
                  color: const Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  icon: Icon(MdiIcons.trashCanOutline,
                      color: Colors.red.shade400, size: 20),
                  onPressed: () {
                    setState(() {
                      medications.remove(medication);
                    });
                  },
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDateSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select Date For Meds Delivery',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: List.generate(
            dates.length,
            (index) => Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedDateIndex = index;
                  });
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: selectedDateIndex == index
                          ? const Color(0xFF5931DD)
                          : Colors.grey.shade300,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: selectedDateIndex == index
                              ? const Color(0xFF5931DD)
                              : Colors.grey.shade100,
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(8),
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          dates[index].split(' ')[0],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: selectedDateIndex == index
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          dates[index].split(' ')[1],
                          style: const TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCouponInputField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Enter Coupon Code',
                border: InputBorder.none,
              ),
            ),
          ),
          Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              color: const Color(0xFF6C4DFF), // Purple color
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_forward, color: Colors.white),
              onPressed: () {
                // Handle coupon submission here
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckoutButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => PaymentScreen()));
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF5931DD),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text(
            'Checkout',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavPlaceholder() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(Icons.home_outlined, color: Colors.grey),
            onPressed: () {},
          ),
          const SizedBox(width: 24),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF5931DD),
              borderRadius: BorderRadius.circular(8),
            ),
            child:
                const Icon(Icons.shopping_cart_outlined, color: Colors.white),
          ),
          const SizedBox(width: 24),
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined, color: Colors.grey),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

Widget _buildCheckoutContainer() {
  return Container(
    width: 343,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: const Color(0xFFEFF3F7),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildPriceRow('Total Items', '03'),
        const SizedBox(height: 8),
        _buildPriceRow('Sub Total', '₹225.00'),
        const SizedBox(height: 8),
        _buildPriceRow('Platform fee', '₹10.00'),
        const SizedBox(height: 8),
        _buildPriceRow('Delivery charge', '₹22.00'),
        const Divider(height: 24, thickness: 1),
        _buildPriceRow('Total Payable', '₹247.00',
            isTotal: true), // Highlighted row
      ],
    ),
  );
}

Widget _buildPriceRow(String label, String value, {bool isTotal = false}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        label,
        style: TextStyle(
          fontSize: 14,
          fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
          color: isTotal ? const Color(0xFF5931DD) : Colors.black.withOpacity(0.5),
        ),
      ),
      Text(
        value,
        style: TextStyle(
          fontSize: 14,
          fontWeight: isTotal ? FontWeight.bold : FontWeight.bold,
          color: isTotal ? const Color(0xFF5931DD) : Colors.black,
        ),
      ),
    ],
  );
}

}
