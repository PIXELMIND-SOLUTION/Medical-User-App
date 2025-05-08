// import 'package:flutter/material.dart';
// import 'package:medical_user_app/widgets/all_medicines.dart';
// import 'package:medical_user_app/widgets/bottom_navigation.dart';
// import 'package:medical_user_app/widgets/periodic_plans.dart';
// import 'package:medical_user_app/widgets/previous_order.dart';
// import 'package:medical_user_app/widgets/progress_bar.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   int _selectedIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Profile and notification row
//                 Row(
//                   children: [
//                     CircleAvatar(
//                       radius: 24,
//                       backgroundImage: AssetImage('assets/profile.png'),
//                       backgroundColor: Colors.grey[300],
//                     ),
//                     SizedBox(width: 12),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text("Hello",
//                             style: TextStyle(
//                                 fontSize: 16, color: Colors.grey[600])),
//                         Text("Manoj Kumar",
//                             style: TextStyle(
//                                 fontSize: 18, fontWeight: FontWeight.bold)),
//                       ],
//                     ),
//                     Spacer(),
//                     Container(
//                       padding: EdgeInsets.all(8),
//                       decoration: BoxDecoration(
//                         color: Colors.grey[100],
//                         shape: BoxShape.circle,
//                       ),
//                       child: Icon(Icons.translate,
//                           size: 24, color: Colors.black54),
//                     ),
//                     SizedBox(width: 12),
//                     Container(
//                       padding: EdgeInsets.all(8),
//                       decoration: BoxDecoration(
//                         color: Colors.grey[100],
//                         shape: BoxShape.circle,
//                       ),
//                       child: Icon(Icons.notifications_none,
//                           size: 24, color: Colors.black54),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 24),

//                 // Search row
//                 Row(
//                   children: [
//                     Expanded(
//                       child: TextField(
//                         decoration: InputDecoration(
//                           hintText: 'Search your Medicine',
//                           prefixIcon: Icon(Icons.search, color: Colors.grey),
//                           contentPadding: EdgeInsets.symmetric(vertical: 12),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(30),
//                             borderSide: BorderSide(color: Colors.grey[300]!),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(30),
//                             borderSide:
//                                 BorderSide(color: Color(0xFF5931DD), width: 2),
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(30),
//                             borderSide: BorderSide(color: Colors.grey[300]!),
//                           ),
//                           fillColor: Colors.white,
//                           filled: true,
//                         ),
//                       ),
//                     ),
//                     SizedBox(width: 12),
//                     Container(
//                       padding: EdgeInsets.all(12),
//                       decoration: BoxDecoration(
//                         color: Color(0xFF5931DD),
//                         shape: BoxShape.circle,
//                       ),
//                       child: Icon(Icons.mic, color: Colors.white),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 24),

//                 Container(
//                   width: double.infinity,
//                   height: 180,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(16),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Color(0x40000000),
//                         blurRadius: 7,
//                         offset: Offset(0, 3),
//                       ),
//                     ],
//                   ),
//                   child: Stack(
//                     children: [
//                       Positioned(
//                         right: 0,
//                         bottom: 0,
//                         child: Image.asset(
//                           'assets/deliveryBoy.png',
//                           height: 120,
//                           fit: BoxFit.contain,
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(20.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   "Order your Medicine!",
//                                   style: TextStyle(
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.bold,
//                                     color:
//                                         const Color.fromARGB(255, 17, 17, 17),
//                                   ),
//                                 ),
//                                 SizedBox(height: 8),
//                                 Text(
//                                   "We deliver medicines at your\ndoorstep in no time",
//                                   style: TextStyle(
//                                     fontSize: 14,
//                                     color: Color(0XFF000000),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(height: 6),
//                             ElevatedButton(
//                               onPressed: () {},
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: Color(0xFF5931DD),
//                                 foregroundColor: Colors.white,
//                                 textStyle:
//                                     TextStyle(fontWeight: FontWeight.bold),
//                                 padding: EdgeInsets.symmetric(
//                                     horizontal: 20, vertical: 10),
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(20),
//                                 ),
//                               ),
//                               child: Text("Order Now"),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 24),

//                 const Text(
//                   "Services",
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),

//                 SizedBox(height: 24),

//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     _buildServicesItem(
//                       imagePath: 'assets/icons/pharmacy.png',
//                       label: "Pharmacy",
//                     ),
//                   ],
//                 ),

//                 SizedBox(height: 24),

//                 // Category section
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const Text(
//                       "Categories",
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     Row(
//                       children: [
//                         Text(
//                           "See All",
//                           style: TextStyle(
//                             fontSize: 14,
//                             color: Colors.grey[600], // gray color
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                         const SizedBox(
//                             width: 4), // small space between text and icon
//                         Icon(
//                           Icons.arrow_forward_ios,
//                           size: 14,
//                           color: Colors.grey[600], // gray color
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),

//                 const SizedBox(height: 16),

//                 // Category icons row
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     _buildCategoryItem(
//                       imagePath: 'assets/icons/all.png',
//                       label: "All",
//                       isSelected: true,
//                     ),
//                     _buildCategoryItem(
//                       imagePath: 'assets/icons/skin.png',
//                       label: "Skin\nCare",
//                     ),
//                     _buildCategoryItem(
//                       imagePath: 'assets/icons/dental.png',
//                       label: "Dental",
//                     ),
//                     _buildCategoryItem(
//                       imagePath: 'assets/icons/homeo.png',
//                       label: "Homeo",
//                     ),
//                   ],
//                 ),

//                 SizedBox(height: 24),

//                 // Previous orders
//                 Container(
//                   width: double.infinity,
//                   padding: const EdgeInsets.all(16),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(12),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.grey.withOpacity(0.1),
//                         spreadRadius: 1,
//                         blurRadius: 4,
//                         offset: const Offset(0, 1),
//                       ),
//                     ],
//                   ),
//                   child: Stack(
//                     children: [
//                       // Main Content Column
//                       Column(
//                         children: [
//                           // Header Row
//                           Row(
//                             children: [
//                               // App Icon and Order Status
//                               Container(
//                                 width: 60,
//                                 height: 60,
//                                 decoration: BoxDecoration(
//                                   color: Colors.blue[50],
//                                   borderRadius: BorderRadius.circular(12),
//                                 ),
//                                 child: ClipRRect(
//                                   borderRadius: BorderRadius.circular(12),
//                                   child: Image.asset(
//                                     "assets/tablet.png",
//                                     width: 60,
//                                     height: 60,
//                                     fit: BoxFit.cover,
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(width: 8),
//                               Text(
//                                 "Your Order will be\ndelivery in 10 min.",
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 14,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 16),
//                           // Progress Bar
//                           CustomProgressBar(currentStep: 2, totalSteps: 3),
//                           const SizedBox(height: 16),
//                           // Order Status Icons
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceAround,
//                             children: [
//                               // Order Placed
//                               _buildStepItem(
//                                 imagePath: 'assets/icons/cart.png',
//                                 label: 'Order\nPlaced',
//                               ),

//                               // Order Pickup
//                               _buildStepItem(
//                                 imagePath: 'assets/icons/pickup.png',
//                                 label: 'Order\nPickup',
//                               ),

//                               // Order Delivery (active)
//                               _buildStepItem(
//                                 imagePath: 'assets/icons/order.png',
//                                 label: 'Order\nDelivery',
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                       // Updated Time Text - positioned at top right
//                       Positioned(
//                         top: 0,
//                         right: 0,
//                         child: Text(
//                           "Updated 6 sec ago",
//                           style: TextStyle(
//                             fontSize: 12,
//                             color: Colors.grey[600],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),

//                 const SizedBox(height: 24),

//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const Text(
//                       "Previous Orders",
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     Row(
//                       children: [
//                         Text(
//                           "See All",
//                           style: TextStyle(
//                             fontSize: 14,
//                             color: Colors.grey[600], // gray color
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                         const SizedBox(
//                             width: 4), // small space between text and icon
//                         Icon(
//                           Icons.arrow_forward_ios,
//                           size: 14,
//                           color: Colors.grey[600], // gray color
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),

//                 // Previous Orders Section
//                 MedicationOrdersList(),

//                 SizedBox(height: 24),

//                 // Periodic Meds Plan
//                 PeriodicMedsPlanCardSimple(),
//                 SizedBox(height: 24),

//                 // All Medicines
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       "All Medicines",
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     Text(
//                       "Filter",
//                       style: TextStyle(
//                         fontSize: 14,
//                         color: Color(0xFF5931DD),
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 16),

//                 // Medicine grid
//                 _buildAllMedicineCardGrid()
//               ],
//             ),
//           ),
//         ),
//       ),
//       bottomNavigationBar: CustomBottomNavBar()
//     );
//   }

//   Widget _buildAllMedicineCardGrid() {
//     return GridView.count(
//       crossAxisCount: 2,
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       childAspectRatio: 0.65, // Reduced from 0.75 to give more height
//       crossAxisSpacing: 16,
//       mainAxisSpacing: 16,
//       children: List.generate(
//         4,
//         (index) => _buildMedicineCardItem(),
//       ),
//     );
//   }

//   Widget _buildMedicineCardItem() {
//     return Container(
//       height: 292,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(12),
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.2),
//             spreadRadius: 1,
//             blurRadius: 4,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Image container
//           ClipRRect(
//             borderRadius: const BorderRadius.only(
//               topLeft: Radius.circular(12),
//               topRight: Radius.circular(12),
//             ),
//             child: Stack(
//               children: [
//                 Image.asset(
//                   'assets/tablet.png',
//                   height: 120,
//                   width: double.infinity,
//                   fit: BoxFit.cover,
//                 ),
//                 Positioned(
//                   bottom: 8,
//                   left: 8,
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 8,
//                       vertical: 2,
//                     ),
//                     decoration: BoxDecoration(
//                       color: Colors.white.withOpacity(0.9),
//                       borderRadius: BorderRadius.circular(4),
//                     ),
//                     child: const Text(
//                       '₹250',
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           // Medicine information
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   'DOLO 500',
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 const Text(
//                   'Appolo Pharmacy',
//                   style: TextStyle(
//                     fontSize: 14,
//                     color: Colors.black87,
//                   ),
//                 ),
//                 const SizedBox(height: 6),
//                 Row(
//                   children: const [
//                     Icon(
//                       Icons.location_on,
//                       color: Colors.deepPurple,
//                       size: 14,
//                     ),
//                     SizedBox(width: 4),
//                     Text(
//                       'Kakinada',
//                       style: TextStyle(
//                         fontSize: 12,
//                         color: Colors.grey,
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 8),
//                 ElevatedButton(
//                   onPressed: () {},
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.deepPurple,
//                     minimumSize: const Size(double.infinity, 36),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                   child: const Text(
//                     'Add On',
//                     style: TextStyle(
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// Widget _buildStepItem({
//   required String imagePath,
//   required String label,
// }) {
//   return Column(
//     children: [
//       Container(
//         width: 44,
//         height: 44,
//         padding: EdgeInsets.all(10),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(50),
//           border: Border.all(
//             color: Colors.grey.shade300,
//             width: 2,
//           ),
//         ),
//         child: Image.asset(
//           imagePath,
//           width: 24,
//           height: 24,
//         ),
//       ),
//       const SizedBox(height: 6),
//       Text(
//         label,
//         textAlign: TextAlign.center,
//         style: TextStyle(
//           fontSize: 12,
//           fontWeight: FontWeight.normal,
//           color: Colors.grey[600],
//         ),
//       ),
//     ],
//   );
// }

// Widget _buildCategoryItem({
//   required String imagePath,
//   required String label,
//   bool isSelected = false,
// }) {
//   return Container(
//     width: 75,
//     height: 89,
//     decoration: BoxDecoration(
//       color: isSelected ? Color(0xFF5931DD) : Colors.grey[100],
//       borderRadius: BorderRadius.circular(16),
//     ),
//     child: Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Expanded(
//           flex: 2,
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: ColorFiltered(
//               colorFilter: isSelected
//                   ? ColorFilter.mode(Colors.white, BlendMode.srcIn)
//                   : ColorFilter.mode(Colors.grey.shade600, BlendMode.srcIn),
//               child: Image.asset(
//                 imagePath,
//                 fit: BoxFit.contain,
//               ),
//             ),
//           ),
//         ),
//         Expanded(
//           flex: 1,
//           child: Center(
//             child: Text(
//               label,
//               style: TextStyle(
//                 fontSize: 11,
//                 fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
//                 color: isSelected
//                     ? Colors.white
//                     : Colors.grey[600], // Color white if selected
//               ),
//               textAlign: TextAlign.center,
//               maxLines: 2,
//               overflow: TextOverflow.ellipsis,
//             ),
//           ),
//         ),
//       ],
//     ),
//   );
// }

// Widget _buildServicesItem({
//   required String imagePath,
//   required String label,
// }) {
//   return Container(
//     width: 90,
//     height: 110,
//     decoration: BoxDecoration(
//       color: Colors.grey[100],
//       borderRadius: BorderRadius.circular(16),
//       border: Border.all(
//         color: Color(0xFF5931DD), // Purple border
//         width: 1,
//       ),
//     ),
//     child: Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Container(
//           width: 48,
//           height: 48,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             shape: BoxShape.circle,
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Image.asset(
//               imagePath,
//               fit: BoxFit.contain,
//             ),
//           ),
//         ),
//         SizedBox(height: 8),
//         Text(
//           label,
//           style: TextStyle(
//             fontSize: 13,
//             fontWeight: FontWeight.bold,
//             color: Color(0xFF5931DD), // Purple text
//           ),
//           textAlign: TextAlign.center,
//         ),
//       ],
//     ),
//   );
// }

// Widget _buildMedicineCard({
//   required String name,
//   required String description,
//   required String price,
//   required String image,
// }) {
//   return Container(
//     decoration: BoxDecoration(
//       color: Colors.white,
//       borderRadius: BorderRadius.circular(16),
//       boxShadow: [
//         BoxShadow(
//           color: Colors.grey.withOpacity(0.1),
//           spreadRadius: 1,
//           blurRadius: 4,
//           offset: Offset(0, 1),
//         ),
//       ],
//     ),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Expanded(
//           child: Container(
//             width: double.infinity,
//             decoration: BoxDecoration(
//               color: Colors.blue[50],
//               borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//             ),
//             child: Center(
//               child: Image.asset(
//                 image,
//                 height: 100,
//                 fit: BoxFit.contain,
//               ),
//             ),
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.all(12.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 name,
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 16,
//                 ),
//               ),
//               Text(
//                 description,
//                 style: TextStyle(
//                   fontSize: 12,
//                   color: Colors.grey[600],
//                 ),
//               ),
//               SizedBox(height: 8),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     price,
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 16,
//                       color: Color(0xFF5931DD),
//                     ),
//                   ),
//                   Container(
//                     padding: EdgeInsets.all(6),
//                     decoration: BoxDecoration(
//                       color: Color(0xFF5931DD),
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: Icon(
//                       Icons.add,
//                       color: Colors.white,
//                       size: 16,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ],
//     ),
//   );
// }

import 'package:flutter/material.dart';
import 'package:medical_user_app/view/checkout_screen.dart';
import 'package:medical_user_app/widgets/all_medicines.dart';
import 'package:medical_user_app/widgets/bottom_navigation.dart';
import 'package:medical_user_app/widgets/periodic_plans.dart';
import 'package:medical_user_app/widgets/previous_order.dart';
import 'package:medical_user_app/widgets/progress_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // Method to show bottom modal with medicine details
  void _showMedicineDetailsModal(
    BuildContext context, {
    required String name,
    required String description,
    required String price,
    required String location,
    required String imagePath,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => MedicineDetailsModal(
        name: name,
        description: description,
        price: price,
        location: location,
        imagePath: imagePath,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile and notification row
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundImage: AssetImage('assets/profile.png'),
                        backgroundColor: Colors.grey[300],
                      ),
                      SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Hello",
                              style: TextStyle(
                                  fontSize: 16, color: Colors.grey[600])),
                          Text("Manoj Kumar",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Spacer(),
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.translate,
                            size: 24, color: Colors.black54),
                      ),
                      SizedBox(width: 12),
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.notifications_none,
                            size: 24, color: Colors.black54),
                      ),
                    ],
                  ),
                  SizedBox(height: 24),

                  // Search row
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search your Medicine',
                            prefixIcon: Icon(Icons.search, color: Colors.grey),
                            contentPadding: EdgeInsets.symmetric(vertical: 12),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(color: Colors.grey[300]!),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                  color: Color(0xFF5931DD), width: 2),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(color: Colors.grey[300]!),
                            ),
                            fillColor: Colors.white,
                            filled: true,
                          ),
                        ),
                      ),
                      SizedBox(width: 12),
                      Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Color(0xFF5931DD),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.mic, color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(height: 24),

                  Container(
                    width: double.infinity,
                    height: 180,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x40000000),
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Image.asset(
                            'assets/deliveryBoy.png',
                            height: 120,
                            fit: BoxFit.contain,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Order your Medicine!",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color:
                                          const Color.fromARGB(255, 17, 17, 17),
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    "We deliver medicines at your\ndoorstep in no time",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0XFF000000),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 6),
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFF5931DD),
                                  foregroundColor: Colors.white,
                                  textStyle:
                                      TextStyle(fontWeight: FontWeight.bold),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                child: Text("Order Now"),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24),

                  const Text(
                    "Services",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 24),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _buildServicesItem(
                        imagePath: 'assets/icons/pharmacy.png',
                        label: "Pharmacy",
                      ),
                    ],
                  ),

                  SizedBox(height: 24),

                  // Category section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Categories",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "See All",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600], // gray color
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(
                              width: 4), // small space between text and icon
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 14,
                            color: Colors.grey[600], // gray color
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Category icons row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildCategoryItem(
                        imagePath: 'assets/icons/all.png',
                        label: "All",
                        isSelected: true,
                      ),
                      _buildCategoryItem(
                        imagePath: 'assets/icons/skin.png',
                        label: "Skin\nCare",
                      ),
                      _buildCategoryItem(
                        imagePath: 'assets/icons/dental.png',
                        label: "Dental",
                      ),
                      _buildCategoryItem(
                        imagePath: 'assets/icons/homeo.png',
                        label: "Homeo",
                      ),
                    ],
                  ),

                  SizedBox(height: 24),

                  // Previous orders
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 4,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
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

                  const SizedBox(height: 24),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Previous Orders",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "See All",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600], // gray color
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(
                              width: 4), // small space between text and icon
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 14,
                            color: Colors.grey[600], // gray color
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  // Previous Orders Section
                  MedicationOrdersList(),

                  SizedBox(height: 24),

                  // Periodic Meds Plan
                  PeriodicMedsPlanCardSimple(),
                  SizedBox(height: 24),

                  // All Medicines
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "All Medicines",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Filter",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF5931DD),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),

                  // Medicine grid
                  _buildAllMedicineCardGrid()
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: CustomBottomNavBar());
  }

  Widget _buildAllMedicineCardGrid() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 0.65, // Reduced from 0.75 to give more height
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      children: List.generate(
        4,
        (index) => _buildMedicineCardItem(),
      ),
    );
  }

  Widget _buildMedicineCardItem() {
    // Sample medicine data
    final String name = 'DOLO 500';
    final String description = 'Appolo Pharmacy';
    final String price = '₹250';
    final String location = 'Kakinada';
    final String imagePath = 'assets/tablet.png';

    return Container(
      height: 292,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image container
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            child: Stack(
              children: [
                Image.asset(
                  imagePath,
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  bottom: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      price,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Medicine information
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: Colors.deepPurple,
                      size: 14,
                    ),
                    SizedBox(width: 4),
                    Text(
                      location,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    // Show the medicine details modal when Add On button is clicked
                    _showMedicineDetailsModal(
                      context,
                      name: name,
                      description: description,
                      price: price,
                      location: location,
                      imagePath: imagePath,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    minimumSize: const Size(double.infinity, 36),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Add On',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Helper methods for building UI components
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

Widget _buildCategoryItem({
  required String imagePath,
  required String label,
  bool isSelected = false,
}) {
  return Container(
    width: 75,
    height: 89,
    decoration: BoxDecoration(
      color: isSelected ? Color(0xFF5931DD) : Colors.grey[100],
      borderRadius: BorderRadius.circular(16),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ColorFiltered(
              colorFilter: isSelected
                  ? ColorFilter.mode(Colors.white, BlendMode.srcIn)
                  : ColorFilter.mode(Colors.grey.shade600, BlendMode.srcIn),
              child: Image.asset(
                imagePath,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected
                    ? Colors.white
                    : Colors.grey[600], // Color white if selected
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildServicesItem({
  required String imagePath,
  required String label,
}) {
  return Container(
    width: 90,
    height: 110,
    decoration: BoxDecoration(
      color: Colors.grey[100],
      borderRadius: BorderRadius.circular(16),
      border: Border.all(
        color: Color(0xFF5931DD), // Purple border
        width: 1,
      ),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              imagePath,
              fit: BoxFit.contain,
            ),
          ),
        ),
        SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: Color(0xFF5931DD), // Purple text
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

// Medicine Details Modal Widget
class MedicineDetailsModal extends StatelessWidget {
  final String name;
  final String description;
  final String price;
  final String location;
  final String imagePath;

  const MedicineDetailsModal({
    Key? key,
    required this.name,
    required this.description,
    required this.price,
    required this.location,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          // Modal header with close button
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 2,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Periodic Meds Plan',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),

          // Search bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(30),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search your Medicine',
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  suffixIcon: Container(
                    margin: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                      color: Color(0xFF5931DD),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.mic, color: Colors.white, size: 20),
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ),

          // Medicine card
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image.asset(
                    imagePath,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),

                // Use a Column here instead of title + subtitle
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name, // e.g. "Some Drug Store"
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12, // same size as your bold drug name
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Paracetamol", // your drug name
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12, // same size as the title
                      ),
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 14,
                          color: Colors.grey[600],
                        ),
                        SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            location, // e.g. "Somewhere, City"
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                trailing: Checkbox(
                  value: true,
                  activeColor: const Color(0xFF5931DD),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  onChanged: (value) {},
                ),
              ),
            ),
          ),

          const Spacer(),

          // Continue button
          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context)=>CheckoutScreen()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF5931DD),
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: const Text(
                'Continue',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
