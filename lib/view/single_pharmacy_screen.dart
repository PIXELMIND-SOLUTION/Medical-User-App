// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:medical_user_app/constant/api_constants.dart';
// import 'package:medical_user_app/models/pharmacy_model.dart'; // Updated import
// import 'package:medical_user_app/providers/cart_provider.dart';
// import 'package:provider/provider.dart';
// import 'dart:convert';
// import 'package:medical_user_app/view/cart_screen.dart';
// import 'package:medical_user_app/view/payment_screen.dart';

// class SinglePharmacyScreen extends StatefulWidget {
//   final String? pharmacyId;
  
//   const SinglePharmacyScreen({
//     Key? key, 
//     this.pharmacyId,
//   }) : super(key: key);

//   @override
//   State<SinglePharmacyScreen> createState() => _SinglePharmacyScreenState();
// }

// class _SinglePharmacyScreenState extends State<SinglePharmacyScreen> {
//   Pharmacy? pharmacy; // Changed from MedicineModel to Pharmacy
//   bool isLoading = true;
//   String? errorMessage;
//   int currentImageIndex = 0;
//   bool isAddingToCart = false;

//   @override
//   void initState() {
//     super.initState();
//     // Only fetch if pharmacyId is provided
//     if (widget.pharmacyId != null && widget.pharmacyId!.isNotEmpty) {
//       fetchPharmacyDetails();
//     } else {
//       setState(() {
//         isLoading = false;
//         errorMessage = 'No pharmacy ID provided';
//       });
//     }
//   }

//   Future<void> fetchPharmacyDetails() async {
//     try {
//       setState(() {
//         isLoading = true;
//         errorMessage = null;
//       });

//       // Check if pharmacyId is null
//       if (widget.pharmacyId == null || widget.pharmacyId!.isEmpty) {
//         setState(() {
//           errorMessage = 'Pharmacy ID is required';
//           isLoading = false;
//         });
//         return;
//       }

//       // Replace the placeholder in the URL with actual pharmacyId
//       final String url = ApiConstants.singlePharmacy.replaceAll(':pharmacyId', widget.pharmacyId!);
      
//       print('Fetching pharmacy from URL: $url'); // Debug log
      
//       final response = await http.get(
//         Uri.parse(url),
//         headers: {
//           'Content-Type': 'application/json',
//           // Add authorization header if needed
//           // 'Authorization': 'Bearer $token',
//         },
//       );

//       print('Response status: ${response.statusCode}'); // Debug log
//       print('Response body: ${response.body}'); // Debug log

//       if (response.statusCode == 200) {
//         final Map<String, dynamic> data = json.decode(response.body);
        
//         // Debug: Print the actual API response structure
//         print('API Response structure: $data');
        
//         // Handle different API response structures
//         Map<String, dynamic>? pharmacyData;
        
//         if (data.containsKey('pharmacy') && data['pharmacy'] != null) {
//           pharmacyData = data['pharmacy'] as Map<String, dynamic>;
//         } else if (data.containsKey('data') && data['data'] != null) {
//           pharmacyData = data['data'] as Map<String, dynamic>;
//         } else if (data.containsKey('result') && data['result'] != null) {
//           pharmacyData = data['result'] as Map<String, dynamic>;
//         } else {
//           // Assume the entire response is the pharmacy data
//           pharmacyData = data;
//         }
        
//         if (pharmacyData != null) {
//           setState(() {
//             pharmacy = Pharmacy.fromJson(pharmacyData!);
//             isLoading = false;
//           });
//         } else {
//           setState(() {
//             errorMessage = 'Invalid API response structure';
//             isLoading = false;
//           });
//         }
        
//       } else {
//         setState(() {
//           errorMessage = 'Failed to load pharmacy details. Status: ${response.statusCode}\nResponse: ${response.body}';
//           isLoading = false;
//         });
//       }
//     } catch (e, stackTrace) {
//       print('Error fetching pharmacy details: $e'); // Debug log
//       print('Stack trace: $stackTrace'); // Debug log
      
//       setState(() {
//         errorMessage = 'Error: ${e.toString()}';
//         isLoading = false;
//       });
//     }
//   }

//   Future<void> _addToCart() async {
//     if (pharmacy == null || widget.pharmacyId == null) return;

//     setState(() {
//       isAddingToCart = true;
//     });

//     final cartProvider = Provider.of<CartProvider>(context, listen: false);
//     final success = await cartProvider.addToCart(widget.pharmacyId!);

//     setState(() {
//       isAddingToCart = false;
//     });

//     if (success) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('${pharmacy!.name} added to cart'),
//           backgroundColor: Colors.green,
//           duration: const Duration(seconds: 2),
//         ),
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(cartProvider.errorMessage ?? 'Failed to add to cart'),
//           backgroundColor: Colors.red,
//           duration: const Duration(seconds: 3),
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: isLoading
//             ? const Center(child: CircularProgressIndicator())
//             : errorMessage != null
//                 ? Center(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(
//                           Icons.error_outline,
//                           size: 64,
//                           color: Colors.grey[400],
//                         ),
//                         const SizedBox(height: 16),
//                         Text(
//                           errorMessage!,
//                           textAlign: TextAlign.center,
//                           style: const TextStyle(
//                             fontSize: 16,
//                             color: Colors.grey,
//                           ),
//                         ),
//                         const SizedBox(height: 16),
//                         ElevatedButton(
//                           onPressed: fetchPharmacyDetails,
//                           child: const Text('Retry'),
//                         ),
//                       ],
//                     ),
//                   )
//                 : SingleChildScrollView(
//                     child: Column(
//                     children: [
//                       Stack(
//                         children: [
//                           // Pharmacy Image
//                           Container(
//                             height: 300,
//                             width: double.infinity,
//                             child: pharmacy!.image.isNotEmpty
//                                 ? Container(
//                                     decoration: BoxDecoration(
//                                       image: DecorationImage(
//                                         image: NetworkImage(pharmacy!.image),
//                                         fit: BoxFit.cover,
//                                         onError: (exception, stackTrace) {
//                                           // Fallback to asset image if network image fails
//                                         },
//                                       ),
//                                     ),
//                                   )
//                                 : Container(
//                                     decoration: const BoxDecoration(
//                                       image: DecorationImage(
//                                         image: AssetImage('assets/pharmacy_placeholder.png'), // Updated placeholder
//                                         fit: BoxFit.cover,
//                                       ),
//                                     ),
//                                   ),
//                           ),
//                           // Back Button
//                           Positioned(
//                             top: 16,
//                             left: 16,
//                             child: Container(
//                               decoration: BoxDecoration(
//                                 color: Colors.white.withOpacity(0.8),
//                                 shape: BoxShape.circle,
//                               ),
//                               child: IconButton(
//                                 icon: const Icon(Icons.arrow_back),
//                                 onPressed: () {
//                                   Navigator.pop(context);
//                                 },
//                               ),
//                             ),
//                           ),
//                           // Cart Button with Badge
//                           Positioned(
//                             top: 16,
//                             right: 16,
//                             child: Consumer<CartProvider>(
//                               builder: (context, cartProvider, child) {
//                                 return Container(
//                                   decoration: BoxDecoration(
//                                     color: Colors.white.withOpacity(0.8),
//                                     shape: BoxShape.circle,
//                                   ),
//                                   child: Stack(
//                                     children: [
//                                       IconButton(
//                                         icon: const Icon(Icons.shopping_cart_outlined),
//                                         onPressed: () {
//                                           Navigator.push(
//                                             context, 
//                                             MaterialPageRoute(builder: (context) =>  CartScreen(amount: cartProvider.totalAmount.toInt(),))
//                                           );
//                                         },
//                                       ),
//                                       if (cartProvider.itemCount > 0)
//                                         Positioned(
//                                           right: 8,
//                                           top: 8,
//                                           child: Container(
//                                             padding: const EdgeInsets.all(2),
//                                             decoration: const BoxDecoration(
//                                               color: Colors.red,
//                                               shape: BoxShape.circle,
//                                             ),
//                                             constraints: const BoxConstraints(
//                                               minWidth: 16,
//                                               minHeight: 16,
//                                             ),
//                                             child: Text(
//                                               '${cartProvider.itemCount}',
//                                               style: const TextStyle(
//                                                 color: Colors.white,
//                                                 fontSize: 10,
//                                                 fontWeight: FontWeight.bold,
//                                               ),
//                                               textAlign: TextAlign.center,
//                                             ),
//                                           ),
//                                         ),
//                                     ],
//                                   ),
//                                 );
//                               },
//                             ),
//                           ),
//                         ],
//                       ),

//                       // Pharmacy Details
//                       Padding(
//                         padding: const EdgeInsets.all(16.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             // Pharmacy Name
//                             Text(
//                               pharmacy!.name,
//                               style: const TextStyle(
//                                 fontSize: 24,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),

//                             const SizedBox(height: 8),

//                             // Location Info
//                             Row(
//                               children: [
//                                 const Icon(Icons.location_on,
//                                     size: 16, color: Colors.grey),
//                                 const SizedBox(width: 4),
//                                 Expanded(
//                                   child: Text(
//                                     'Lat: ${pharmacy!.latitude.toStringAsFixed(6)}, Lng: ${pharmacy!.longitude.toStringAsFixed(6)}',
//                                     style: const TextStyle(
//                                       fontSize: 14,
//                                       color: Colors.grey,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),

//                             const SizedBox(height: 16),

//                             // Stats Row
//                             Container(
//                               width: double.infinity,
//                               height: 62,
//                               padding: const EdgeInsets.all(5),
//                               decoration: BoxDecoration(
//                                 color: const Color(0xFFEFF3F7),
//                                 borderRadius: BorderRadius.circular(10)
//                               ),
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                 children: [
//                                   // Categories Count
//                                   Column(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       Text(
//                                         '${pharmacy!.categories.length}',
//                                         style: const TextStyle(
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                       const Text(
//                                         'Categories',
//                                         style: TextStyle(
//                                           fontSize: 12,
//                                           color: Colors.grey,
//                                         ),
//                                       ),
//                                     ],
//                                   ),

//                                   const SizedBox(
//                                     height: 40,
//                                     width: 1,
//                                     child: DecoratedBox(
//                                       decoration: BoxDecoration(color: Colors.grey),
//                                     ),
//                                   ),

//                                   // Products Count
//                                   Column(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       Text(
//                                         '${pharmacy!.products.length}',
//                                         style: const TextStyle(
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                       const Text(
//                                         'Products',
//                                         style: TextStyle(
//                                           fontSize: 12,
//                                           color: Colors.grey,
//                                         ),
//                                       ),
//                                     ],
//                                   ),

//                                   const SizedBox(
//                                     height: 40,
//                                     width: 1,
//                                     child: DecoratedBox(
//                                       decoration: BoxDecoration(color: Colors.grey),
//                                     ),
//                                   ),

//                                   // Delivery Time (static for now)
//                                   const Column(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       Row(
//                                         children: [
//                                           Icon(
//                                             Icons.access_time_filled,
//                                             color: Color.fromARGB(255, 31, 17, 136),
//                                             size: 16,
//                                           ),
//                                           Text(
//                                             '15 min',
//                                             style: TextStyle(
//                                               fontSize: 16,
//                                               fontWeight: FontWeight.bold,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       Text(
//                                         'Delivery',
//                                         style: TextStyle(
//                                           fontSize: 12,
//                                           color: Colors.grey,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),

//                             const SizedBox(height: 24),

//                             // Categories Section
//                             if (pharmacy!.categories.isNotEmpty) ...[
//                               const Text(
//                                 'Available Categories',
//                                 style: TextStyle(
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               const SizedBox(height: 12),
//                               SizedBox(
//                                 height: 100,
//                                 child: ListView.builder(
//                                   scrollDirection: Axis.horizontal,
//                                   itemCount: pharmacy!.categories.length,
//                                   itemBuilder: (context, index) {
//                                     final category = pharmacy!.categories[index];
//                                     return Container(
//                                       width: 80,
//                                       margin: const EdgeInsets.only(right: 12),
//                                       child: Column(
//                                         children: [
//                                           Container(
//                                             width: 60,
//                                             height: 60,
//                                             decoration: BoxDecoration(
//                                               shape: BoxShape.circle,
//                                               color: Colors.grey[200],
//                                               image: category.image.isNotEmpty
//                                                   ? DecorationImage(
//                                                       image: NetworkImage(category.image),
//                                                       fit: BoxFit.cover,
//                                                     )
//                                                   : null,
//                                             ),
//                                             child: category.image.isEmpty
//                                                 ? const Icon(
//                                                     Icons.category,
//                                                     color: Colors.grey,
//                                                   )
//                                                 : null,
//                                           ),
//                                           const SizedBox(height: 8),
//                                           Text(
//                                             category.name,
//                                             style: const TextStyle(
//                                               fontSize: 12,
//                                               fontWeight: FontWeight.w500,
//                                             ),
//                                             textAlign: TextAlign.center,
//                                             maxLines: 2,
//                                             overflow: TextOverflow.ellipsis,
//                                           ),
//                                         ],
//                                       ),
//                                     );
//                                   },
//                                 ),
//                               ),
//                               const SizedBox(height: 16),
//                             ],

//                             // Description Section (using pharmacy name as description for now)
//                             const Text(
//                               'About Pharmacy',
//                               style: TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             const SizedBox(height: 8),
//                             Text(
//                               'Welcome to ${pharmacy!.name}. We provide quality healthcare products and medicines with fast delivery service. Our pharmacy offers a wide range of categories including ${pharmacy!.categories.map((c) => c.name).take(3).join(", ")}${pharmacy!.categories.length > 3 ? " and more" : ""}.',
//                               style: const TextStyle(
//                                 fontSize: 14,
//                                 color: Colors.grey,
//                                 height: 1.5,
//                               ),
//                             ),

//                             const SizedBox(height: 24),
//                             // Action Buttons
//                             Consumer<CartProvider>(
//                               builder: (context, cartProvider, child) {
//                                 final isInCart = widget.pharmacyId != null 
//                                     ? cartProvider.isInCart(widget.pharmacyId!) 
//                                     : false;
                                
//                                 return Row(
//                                   children: [
//                                     // Add to Cart Button
//                                     Expanded(
//                                       child: OutlinedButton(
//                                         onPressed: isAddingToCart || cartProvider.isLoading 
//                                             ? null 
//                                             : _addToCart,
//                                         style: OutlinedButton.styleFrom(
//                                           padding: const EdgeInsets.symmetric(vertical: 12),
//                                           side: BorderSide(
//                                             color: isInCart ? Colors.green : Colors.black,
//                                           ),
//                                           shape: RoundedRectangleBorder(
//                                             borderRadius: BorderRadius.circular(30),
//                                           ),
//                                         ),
//                                         child: isAddingToCart
//                                             ? const SizedBox(
//                                                 width: 20,
//                                                 height: 20,
//                                                 child: CircularProgressIndicator(
//                                                   strokeWidth: 2,
//                                                   valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
//                                                 ),
//                                               )
//                                             : Text(
//                                                 isInCart 
//                                                     ? 'In Cart (${cartProvider.getItemQuantity(widget.pharmacyId!)})'
//                                                     : 'Add to Cart',
//                                                 style: TextStyle(
//                                                   color: isInCart ? Colors.green : Colors.black,
//                                                   fontWeight: FontWeight.bold,
//                                                 ),
//                                               ),
//                                       ),
//                                     ),

//                                     const SizedBox(width: 12),

//                                     // Order Now Button
//                                     Expanded(
//                                       child: ElevatedButton(
//                                         onPressed: isAddingToCart || cartProvider.isLoading
//                                             ? null
//                                             : () {
//                                                 Navigator.push(
//                                                   context, 
//                                                   MaterialPageRoute(builder: (context) => const PaymentScreen())
//                                                 );
//                                               },
//                                         style: ElevatedButton.styleFrom(
//                                           padding: const EdgeInsets.symmetric(vertical: 12),
//                                           backgroundColor: Colors.deepPurple,
//                                           shape: RoundedRectangleBorder(
//                                             borderRadius: BorderRadius.circular(30),
//                                           ),
//                                         ),
//                                         child: const Text(
//                                           'Order Now',
//                                           style: TextStyle(
//                                             color: Colors.white,
//                                             fontWeight: FontWeight.bold,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 );
//                               },
//                             ),
//                             const SizedBox(height: 16), // Extra bottom padding
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//       ),
//     );
//   }
// }