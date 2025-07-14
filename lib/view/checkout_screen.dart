import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medical_user_app/providers/language_provider.dart';
import 'package:medical_user_app/view/near_pharmacy_screen.dart';
import 'package:medical_user_app/widgets/bottom_navigation.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
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
                        const SizedBox(height: 20),
                        _buildFrequencyToggle(),
                        const SizedBox(height: 34),
                        _buildMedicationList(),
                        const SizedBox(height: 24),
                        const Text(
                          "Select Date For Meds Delivery",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(5, (index) {
                            DateTime today = DateTime.now();
                            DateTime date =
                                DateTime.now().add(Duration(days: index));

                            String day = DateFormat('d').format(date);
                            String month = DateFormat('MMM').format(date);

                            // Check if this card's date is today
                            bool isToday = date.day == today.day &&
                                date.month == today.month &&
                                date.year == today.year;

                            // Calendar icon
                            if (index == 4) {
                              return GestureDetector(
                                onTap: () =>
                                    _selectFromCalendar(isStartDate: true),
                                child: Stack(
                                  alignment: Alignment.topCenter,
                                  children: [
                                    Positioned(
                                      top: 0,
                                      child: Container(
                                        height: 6,
                                        width: 50,
                                        decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(top: 4),
                                      height: 80,
                                      width: 55,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8),
                                        border:
                                            Border.all(color: Colors.black12),
                                      ),
                                      child: const Icon(
                                          Icons.calendar_month_sharp),
                                    ),
                                  ],
                                ),
                              );
                            }

                            return GestureDetector(
                              onTap: () {},
                              child: Stack(
                                alignment: Alignment.topCenter,
                                children: [
                                  Positioned(
                                    top: 0,
                                    child: Container(
                                      height: 6,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        color: isToday
                                            ? const Color(0XFF120698)
                                            : Colors.black,
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: 4),
                                    height: 80,
                                    width: 60,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12),
                                    decoration: BoxDecoration(
                                      color: isToday
                                          ? const Color(0XFF5931DD)
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(color: Colors.black12),
                                    ),
                                    child: Column(
                                      children: [
                                        Text(
                                          day,
                                          style: TextStyle(
                                            color: isToday
                                                ? Colors.white
                                                : Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          month,
                                          style: TextStyle(
                                            color: isToday
                                                ? Colors.white
                                                : Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                        ),
                        const SizedBox(height: 34),
                        _buildDeliveryNote(),
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
        color: Color.fromARGB(255, 237, 234, 245), // Light violet color for center background
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

  Widget _buildDeliveryNote() {
    return SizedBox(
      width: double.infinity,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // First line: “Note: Your Medicines Will be Delivery on”
            RichText(
              text: TextSpan(
                style: TextStyle(color: Colors.grey.shade800, fontSize: 14),
                children: const [
                  TextSpan(
                    text: 'Note: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: 'Your Medicines Will be Delivery on',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 4),

            // Second line: the date
            Text(
              '22/03/2025',
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 14,
              ),
            ),
          ],
        ),
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
            Navigator.push(context, MaterialPageRoute(builder: (context)=>NearPharmacyScreen()));
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF5931DD),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const AppText(
            'checkout',
            style: TextStyle(
              fontSize: 16,
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
}
