// // // import 'dart:io';
// // // import 'dart:convert';
// // // import 'package:flutter/material.dart';
// // // import 'package:http/http.dart' as http;
// // // import 'package:medical_user_app/utils/shared_preferences_helper.dart';

// // // class ResultScreen extends StatefulWidget {
// // //   final File imageFile;
// // //   const ResultScreen({super.key, required this.imageFile});

// // //   @override
// // //   State<ResultScreen> createState() => _ResultScreenState();
// // // }

// // // class _ResultScreenState extends State<ResultScreen> {
// // //   bool _isUploading = false;

// // //   Future<void> _uploadPrescription() async {
// // //     if (_isUploading) return;

// // //     try {
// // //       setState(() {
// // //         _isUploading = true;
// // //       });

// // //       final user = await SharedPreferencesHelper.getUser();
// // //       if (user == null || user.id.isEmpty) {
// // //         _showError('User not found. Please login again.');
// // //         return;
// // //       }

// // //       final uri = Uri.parse('http://31.97.206.144:7021/api/users/sendprescription/${user.id}');
// // //       final request = http.MultipartRequest('POST', uri);

// // //             print('rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr$uri');

// // //       final imageFile = await http.MultipartFile.fromPath(
// // //         'prescriptionFile',
// // //         widget.imageFile.path,
// // //         filename: 'prescription_${DateTime.now().millisecondsSinceEpoch}.jpg',
// // //       );
// // //       request.files.add(imageFile);

// // //       final token = await SharedPreferencesHelper.getToken();
// // //       if (token != null && token.isNotEmpty) {
// // //         request.headers['Authorization'] = 'Bearer $token';
// // //       }

// // //       final streamedResponse = await request.send().timeout(
// // //         const Duration(seconds: 30),
// // //         onTimeout: () {
// // //           throw Exception('Upload timeout. Please check your internet connection.');
// // //         },
// // //       );
// // //       final response = await http.Response.fromStream(streamedResponse);

// // //       print('response bodyyyyyyyyyyy ${response.body}');
// // //       if (mounted) {

// // //         print('hhhhhhhhhhhhhhhhhhhhh${response.statusCode}');
// // //         if (response.statusCode == 200 || response.statusCode == 201) {
// // //           ScaffoldMessenger.of(context).showSnackBar(
// // //             const SnackBar(
// // //               content: Text('Prescription uploaded successfully!'),
// // //               backgroundColor: Colors.green,
// // //               duration: Duration(seconds: 3),
// // //             ),
// // //           );

// // //           // Navigate back to the main screen (pop all screens)
// // //           Navigator.popUntil(context, (route) => route.isFirst);
// // //         } else {
// // //           try {
// // //             final errorData = json.decode(response.body);
// // //             _showError(errorData['message'] ?? 'Failed to upload prescription');
// // //           } catch (e) {
// // //             _showError('Failed to upload prescription. Status: ${response.statusCode}');
// // //           }
// // //         }
// // //       }
// // //     } catch (e) {
// // //       if (mounted) {
// // //         _showError('Network error: $e');
// // //       }
// // //     } finally {
// // //       if (mounted) {
// // //         setState(() {
// // //           _isUploading = false;
// // //         });
// // //       }
// // //     }
// // //   }

// // //   void _showError(String message) {
// // //     if (mounted) {
// // //       ScaffoldMessenger.of(context).showSnackBar(
// // //         SnackBar(
// // //           content: Text(message),
// // //           backgroundColor: Colors.red,
// // //           duration: const Duration(seconds: 4),
// // //         ),
// // //       );
// // //     }
// // //   }

// // //   void _retakePicture() {
// // //     // Navigate back to cropper screen
// // //     Navigator.pop(context);
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       backgroundColor: Colors.grey[50],
// // //       appBar: AppBar(
// // //         title: const Text(
// // //           "Review Image",
// // //           style: TextStyle(
// // //             color: Colors.white,
// // //             fontWeight: FontWeight.w600,
// // //           ),
// // //         ),
// // //         backgroundColor: Colors.blue.shade600,
// // //         elevation: 0,
// // //         leading: IconButton(
// // //           icon: const Icon(Icons.arrow_back, color: Colors.white),
// // //           onPressed: () => Navigator.pop(context),
// // //         ),
// // //       ),
// // //       body: Column(
// // //         children: [
// // //           // Image preview section
// // //           Expanded(
// // //             flex: 3,
// // //             child: Container(
// // //               width: double.infinity,
// // //               margin: const EdgeInsets.all(16),
// // //               decoration: BoxDecoration(
// // //                 color: Colors.white,
// // //                 borderRadius: BorderRadius.circular(12),
// // //                 boxShadow: [
// // //                   BoxShadow(
// // //                     color: Colors.grey.withOpacity(0.2),
// // //                     spreadRadius: 2,
// // //                     blurRadius: 8,
// // //                     offset: const Offset(0, 2),
// // //                   ),
// // //                 ],
// // //               ),
// // //               child: ClipRRect(
// // //                 borderRadius: BorderRadius.circular(12),
// // //                 child: Image.file(
// // //                   widget.imageFile,
// // //                   fit: BoxFit.contain,
// // //                   width: double.infinity,
// // //                   height: double.infinity,
// // //                 ),
// // //               ),
// // //             ),
// // //           ),

// // //           // Instructions section
// // //           Expanded(
// // //             flex: 1,
// // //             child: Padding(
// // //               padding: const EdgeInsets.symmetric(horizontal: 24),
// // //               child: Column(
// // //                 children: [
// // //                   Container(
// // //                     padding: const EdgeInsets.all(16),
// // //                     decoration: BoxDecoration(
// // //                       color: Colors.blue.shade50,
// // //                       borderRadius: BorderRadius.circular(8),
// // //                       border: Border.all(color: Colors.blue.shade200),
// // //                     ),
// // //                     child: Row(
// // //                       children: [
// // //                         Icon(Icons.info_outline, color: Colors.blue.shade600),
// // //                         const SizedBox(width: 12),
// // //                         Expanded(
// // //                           child: Text(
// // //                             'Please review your prescription image before uploading',
// // //                             style: TextStyle(
// // //                               color: Colors.blue.shade800,
// // //                               fontSize: 14,
// // //                               fontWeight: FontWeight.w500,
// // //                             ),
// // //                           ),
// // //                         ),
// // //                       ],
// // //                     ),
// // //                   ),
// // //                   const Spacer(),
// // //                 ],
// // //               ),
// // //             ),
// // //           ),

// // //           // Action buttons section - FIXED LAYOUT
// // //           Container(
// // //             width: double.infinity,
// // //             padding: const EdgeInsets.all(20),
// // //             decoration: BoxDecoration(
// // //               color: Colors.white,
// // //               boxShadow: [
// // //                 BoxShadow(
// // //                   color: Colors.grey.withOpacity(0.1),
// // //                   spreadRadius: 1,
// // //                   blurRadius: 4,
// // //                   offset: const Offset(0, -2),
// // //                 ),
// // //               ],
// // //             ),
// // //             child: Column(
// // //               mainAxisSize: MainAxisSize.min,
// // //               children: [
// // //                 // Submit button (primary action on top)
// // //                 SizedBox(
// // //                   width: double.infinity,
// // //                   height: 52,
// // //                   child: ElevatedButton(
// // //                     onPressed: _isUploading ? null : _uploadPrescription,
// // //                     style: ElevatedButton.styleFrom(
// // //                       backgroundColor: Colors.blue.shade600,
// // //                       foregroundColor: Colors.white,
// // //                       shape: RoundedRectangleBorder(
// // //                         borderRadius: BorderRadius.circular(8),
// // //                       ),
// // //                       elevation: 2,
// // //                       disabledBackgroundColor: Colors.grey.shade300,
// // //                     ),
// // //                     child: _isUploading
// // //                         ? const SizedBox(
// // //                             width: 20,
// // //                             height: 20,
// // //                             child: CircularProgressIndicator(
// // //                               color: Colors.white,
// // //                               strokeWidth: 2,
// // //                             ),
// // //                           )
// // //                         : const Row(
// // //                             mainAxisAlignment: MainAxisAlignment.center,
// // //                             children: [
// // //                               Icon(Icons.cloud_upload_outlined, size: 20),
// // //                               SizedBox(width: 8),
// // //                               Text(
// // //                                 'Submit Prescription',
// // //                                 style: TextStyle(
// // //                                   fontSize: 16,
// // //                                   fontWeight: FontWeight.w600,
// // //                                 ),
// // //                               ),
// // //                             ],
// // //                           ),
// // //                   ),
// // //                 ),

// // //                 const SizedBox(height: 12),

// // //                 // Retake button (secondary action)
// // //                 SizedBox(
// // //                   width: double.infinity,
// // //                   height: 48,
// // //                   child: OutlinedButton(
// // //                     onPressed: _isUploading ? null : _retakePicture,
// // //                     style: OutlinedButton.styleFrom(
// // //                       side: BorderSide(color: Colors.grey.shade400),
// // //                       shape: RoundedRectangleBorder(
// // //                         borderRadius: BorderRadius.circular(8),
// // //                       ),
// // //                     ),
// // //                     child: Row(
// // //                       mainAxisAlignment: MainAxisAlignment.center,
// // //                       children: [
// // //                         Icon(Icons.crop, color: Colors.grey.shade600, size: 18),
// // //                         const SizedBox(width: 8),
// // //                         Text(
// // //                           'Re-crop Image',
// // //                           style: TextStyle(
// // //                             color: Colors.grey.shade700,
// // //                             fontSize: 15,
// // //                             fontWeight: FontWeight.w500,
// // //                           ),
// // //                         ),
// // //                       ],
// // //                     ),
// // //                   ),
// // //                 ),
// // //               ],
// // //             ),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // // }

// // import 'dart:io';
// // import 'dart:convert';
// // import 'package:flutter/material.dart';
// // import 'package:http/http.dart' as http;
// // import 'package:medical_user_app/models/pharmacy_model.dart';
// // import 'package:medical_user_app/utils/shared_preferences_helper.dart';

// // class ResultScreen extends StatefulWidget {
// //   final File imageFile;
// //   const ResultScreen({super.key, required this.imageFile});

// //   @override
// //   State<ResultScreen> createState() => _ResultScreenState();
// // }

// // class _ResultScreenState extends State<ResultScreen> {
// //   bool _isUploading = false;
// //   bool _isLoadingPharmacies = false;
// //   List<Pharmacy> _pharmacies = [];
// //   Pharmacy? _selectedPharmacy;

// //   @override
// //   void initState() {
// //     super.initState();
// //     _loadPharmacies();
// //   }

// //   Future<void> _loadPharmacies() async {
// //     try {
// //       setState(() {
// //         _isLoadingPharmacies = true;
// //       });

// //       final token = await SharedPreferencesHelper.getToken();
// //       final response = await http.get(
// //         Uri.parse('http://31.97.206.144:7021/api/pharmacy/getallpjarmacy'), // Adjust endpoint as needed
// //         headers: {
// //           'Content-Type': 'application/json',
// //           if (token != null && token.isNotEmpty) 'Authorization': 'Bearer $token',
// //         },
// //       ).timeout(
// //         const Duration(seconds: 15),
// //         onTimeout: () {
// //           throw Exception('Request timeout. Please check your internet connection.');
// //         },
// //       );

// //       if (response.statusCode == 200) {
// //         final pharmacyResponse = PharmacyResponse.fromJson(json.decode(response.body));
// //         setState(() {
// //           _pharmacies = pharmacyResponse.pharmacies;
// //         });
// //       } else {
// //         _showError('Failed to load pharmacies');
// //       }
// //     } catch (e) {
// //       _showError('Error loading pharmacies: $e');
// //     } finally {
// //       setState(() {
// //         _isLoadingPharmacies = false;
// //       });
// //     }
// //   }

// //   Future<void> _uploadPrescription() async {
// //     if (_isUploading) return;

// //     if (_selectedPharmacy == null) {
// //       _showError('Please select a pharmacy before uploading');
// //       return;
// //     }

// //     try {
// //       setState(() {
// //         _isUploading = true;
// //       });

// //       final user = await SharedPreferencesHelper.getUser();
// //       if (user == null || user.id.isEmpty) {
// //         _showError('User not found. Please login again.');
// //         return;
// //       }

// //       // Updated API endpoint with pharmacyId
// //       final uri = Uri.parse('http://31.97.206.144:7021/api/users/sendprescription/${user.id}/${_selectedPharmacy!.id}');
// //       final request = http.MultipartRequest('POST', uri);

// //       print('Upload URL: $uri');

// //       final imageFile = await http.MultipartFile.fromPath(
// //         'prescriptionFile',
// //         widget.imageFile.path,
// //         filename: 'prescription_${DateTime.now().millisecondsSinceEpoch}.jpg',
// //       );
// //       request.files.add(imageFile);

// //       final token = await SharedPreferencesHelper.getToken();
// //       if (token != null && token.isNotEmpty) {
// //         request.headers['Authorization'] = 'Bearer $token';
// //       }

// //       final streamedResponse = await request.send().timeout(
// //         const Duration(seconds: 30),
// //         onTimeout: () {
// //           throw Exception('Upload timeout. Please check your internet connection.');
// //         },
// //       );
// //       final response = await http.Response.fromStream(streamedResponse);

// //       print('Response body: ${response.body}');

// //       if (mounted) {
// //         print('Status code: ${response.statusCode}');
// //         if (response.statusCode == 200 || response.statusCode == 201) {
// //           ScaffoldMessenger.of(context).showSnackBar(
// //             SnackBar(
// //               content: Text('Prescription uploaded successfully to ${_selectedPharmacy!.name}!'),
// //               backgroundColor: Colors.green,
// //               duration: const Duration(seconds: 3),
// //             ),
// //           );

// //           // Navigate back to the main screen (pop all screens)
// //           Navigator.popUntil(context, (route) => route.isFirst);
// //         } else {
// //           try {
// //             final errorData = json.decode(response.body);
// //             _showError(errorData['message'] ?? 'Failed to upload prescription');
// //           } catch (e) {
// //             _showError('Failed to upload prescription. Status: ${response.statusCode}');
// //           }
// //         }
// //       }
// //     } catch (e) {
// //       if (mounted) {
// //         _showError('Network error: $e');
// //       }
// //     } finally {
// //       if (mounted) {
// //         setState(() {
// //           _isUploading = false;
// //         });
// //       }
// //     }
// //   }

// //   void _showError(String message) {
// //     if (mounted) {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(
// //           content: Text(message),
// //           backgroundColor: Colors.red,
// //           duration: const Duration(seconds: 4),
// //         ),
// //       );
// //     }
// //   }

// //   void _retakePicture() {
// //     // Navigate back to cropper screen
// //     Navigator.pop(context);
// //   }

// //   void _showPharmacySelectionDialog() {
// //     showModalBottomSheet(
// //       context: context,
// //       isScrollControlled: true,
// //       backgroundColor: Colors.transparent,
// //       builder: (context) => Container(
// //         height: MediaQuery.of(context).size.height * 0.7,
// //         decoration: const BoxDecoration(
// //           color: Colors.white,
// //           borderRadius: BorderRadius.only(
// //             topLeft: Radius.circular(20),
// //             topRight: Radius.circular(20),
// //           ),
// //         ),
// //         child: Column(
// //           children: [
// //             Container(
// //               padding: const EdgeInsets.all(20),
// //               decoration: BoxDecoration(
// //                 color: Colors.blue.shade600,
// //                 borderRadius: const BorderRadius.only(
// //                   topLeft: Radius.circular(20),
// //                   topRight: Radius.circular(20),
// //                 ),
// //               ),
// //               child: Row(
// //                 children: [
// //                   const Expanded(
// //                     child: Text(
// //                       'Select Pharmacy',
// //                       style: TextStyle(
// //                         color: Colors.white,
// //                         fontSize: 18,
// //                         fontWeight: FontWeight.w600,
// //                       ),
// //                     ),
// //                   ),
// //                   IconButton(
// //                     onPressed: () => Navigator.pop(context),
// //                     icon: const Icon(Icons.close, color: Colors.white),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //             Expanded(
// //               child: _isLoadingPharmacies
// //                   ? const Center(child: CircularProgressIndicator())
// //                   : _pharmacies.isEmpty
// //                       ? const Center(
// //                           child: Text(
// //                             'No pharmacies available',
// //                             style: TextStyle(fontSize: 16),
// //                           ),
// //                         )
// //                       : ListView.builder(
// //                           padding: const EdgeInsets.all(16),
// //                           itemCount: _pharmacies.length,
// //                           itemBuilder: (context, index) {
// //                             final pharmacy = _pharmacies[index];
// //                             final isSelected = _selectedPharmacy?.id == pharmacy.id;

// //                             return Container(
// //                               margin: const EdgeInsets.only(bottom: 12),
// //                               decoration: BoxDecoration(
// //                                 border: Border.all(
// //                                   color: isSelected ? Colors.blue.shade600 : Colors.grey.shade300,
// //                                   width: isSelected ? 2 : 1,
// //                                 ),
// //                                 borderRadius: BorderRadius.circular(12),
// //                                 color: isSelected ? Colors.blue.shade50 : Colors.white,
// //                               ),
// //                               child: ListTile(
// //                                 contentPadding: const EdgeInsets.all(12),
// //                                 leading: Container(
// //                                   width: 50,
// //                                   height: 50,
// //                                   decoration: BoxDecoration(
// //                                     borderRadius: BorderRadius.circular(8),
// //                                     color: Colors.grey.shade200,
// //                                   ),
// //                                   child: pharmacy.image.isNotEmpty
// //                                       ? ClipRRect(
// //                                           borderRadius: BorderRadius.circular(8),
// //                                           child: Image.network(
// //                                             pharmacy.image,
// //                                             fit: BoxFit.cover,
// //                                             errorBuilder: (context, error, stackTrace) =>
// //                                                 Icon(Icons.local_pharmacy, color: Colors.grey.shade600),
// //                                           ),
// //                                         )
// //                                       : Icon(Icons.local_pharmacy, color: Colors.grey.shade600),
// //                                 ),
// //                                 title: Text(
// //                                   pharmacy.name,
// //                                   style: TextStyle(
// //                                     fontWeight: FontWeight.w600,
// //                                     color: isSelected ? Colors.blue.shade800 : Colors.black87,
// //                                   ),
// //                                 ),
// //                                 subtitle: Column(
// //                                   crossAxisAlignment: CrossAxisAlignment.start,
// //                                   children: [
// //                                     const SizedBox(height: 4),
// //                                     Text(
// //                                       pharmacy.address,
// //                                       style: TextStyle(
// //                                         color: Colors.grey.shade600,
// //                                         fontSize: 13,
// //                                       ),
// //                                     ),
// //                                     if (pharmacy.categories.isNotEmpty) ...[
// //                                       const SizedBox(height: 4),
// //                                       Text(
// //                                         'Categories: ${pharmacy.categories.map((c) => c.name).join(', ')}',
// //                                         style: TextStyle(
// //                                           color: Colors.grey.shade500,
// //                                           fontSize: 12,
// //                                         ),
// //                                         maxLines: 1,
// //                                         overflow: TextOverflow.ellipsis,
// //                                       ),
// //                                     ],
// //                                   ],
// //                                 ),
// //                                 trailing: isSelected
// //                                     ? Icon(Icons.check_circle, color: Colors.blue.shade600)
// //                                     : Icon(Icons.radio_button_unchecked, color: Colors.grey.shade400),
// //                                 onTap: () {
// //                                   setState(() {
// //                                     _selectedPharmacy = pharmacy;
// //                                   });
// //                                   Navigator.pop(context);
// //                                 },
// //                               ),
// //                             );
// //                           },
// //                         ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.grey[50],
// //       appBar: AppBar(
// //         title: const Text(
// //           "Review Image",
// //           style: TextStyle(
// //             color: Colors.white,
// //             fontWeight: FontWeight.w600,
// //           ),
// //         ),
// //         backgroundColor: Colors.blue.shade600,
// //         elevation: 0,
// //         leading: IconButton(
// //           icon: const Icon(Icons.arrow_back, color: Colors.white),
// //           onPressed: () => Navigator.pop(context),
// //         ),
// //       ),
// //       body: Column(
// //         children: [
// //           // Image preview section
// //           Expanded(
// //             flex: 3,
// //             child: Container(
// //               width: double.infinity,
// //               margin: const EdgeInsets.all(16),
// //               decoration: BoxDecoration(
// //                 color: Colors.white,
// //                 borderRadius: BorderRadius.circular(12),
// //                 boxShadow: [
// //                   BoxShadow(
// //                     color: Colors.grey.withOpacity(0.2),
// //                     spreadRadius: 2,
// //                     blurRadius: 8,
// //                     offset: const Offset(0, 2),
// //                   ),
// //                 ],
// //               ),
// //               child: ClipRRect(
// //                 borderRadius: BorderRadius.circular(12),
// //                 child: Image.file(
// //                   widget.imageFile,
// //                   fit: BoxFit.contain,
// //                   width: double.infinity,
// //                   height: double.infinity,
// //                 ),
// //               ),
// //             ),
// //           ),

// //           // Pharmacy selection section
// //           Container(
// //             margin: const EdgeInsets.symmetric(horizontal: 16),
// //             child: Card(
// //               elevation: 2,
// //               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
// //               child: InkWell(
// //                 onTap: _showPharmacySelectionDialog,
// //                 borderRadius: BorderRadius.circular(12),
// //                 child: Padding(
// //                   padding: const EdgeInsets.all(16),
// //                   child: Row(
// //                     children: [
// //                       Container(
// //                         padding: const EdgeInsets.all(8),
// //                         decoration: BoxDecoration(
// //                           color: Colors.blue.shade100,
// //                           borderRadius: BorderRadius.circular(8),
// //                         ),
// //                         child: Icon(
// //                           Icons.local_pharmacy,
// //                           color: Colors.blue.shade600,
// //                           size: 24,
// //                         ),
// //                       ),
// //                       const SizedBox(width: 12),
// //                       Expanded(
// //                         child: Column(
// //                           crossAxisAlignment: CrossAxisAlignment.start,
// //                           children: [
// //                             Text(
// //                               _selectedPharmacy != null ? _selectedPharmacy!.name : 'Select Pharmacy',
// //                               style: TextStyle(
// //                                 fontWeight: FontWeight.w600,
// //                                 fontSize: 16,
// //                                 color: _selectedPharmacy != null ? Colors.black87 : Colors.grey.shade600,
// //                               ),
// //                             ),
// //                             if (_selectedPharmacy != null) ...[
// //                               const SizedBox(height: 4),
// //                               Text(
// //                                 _selectedPharmacy!.address,
// //                                 style: TextStyle(
// //                                   color: Colors.grey.shade600,
// //                                   fontSize: 13,
// //                                 ),
// //                                 maxLines: 1,
// //                                 overflow: TextOverflow.ellipsis,
// //                               ),
// //                             ] else
// //                               Text(
// //                                 'Choose where to send your prescription',
// //                                 style: TextStyle(
// //                                   color: Colors.grey.shade600,
// //                                   fontSize: 13,
// //                                 ),
// //                               ),
// //                           ],
// //                         ),
// //                       ),
// //                       Icon(Icons.arrow_forward_ios, color: Colors.grey.shade400, size: 16),
// //                     ],
// //                   ),
// //                 ),
// //               ),
// //             ),
// //           ),

// //           // Instructions section
// //           Expanded(
// //             flex: 1,
// //             child: Padding(
// //               padding: const EdgeInsets.all(24),
// //               child: Column(
// //                 children: [
// //                   Container(
// //                     padding: const EdgeInsets.all(11),
// //                     decoration: BoxDecoration(
// //                       color: Colors.blue.shade50,
// //                       borderRadius: BorderRadius.circular(8),
// //                       border: Border.all(color: Colors.blue.shade200),
// //                     ),
// //                     child: Row(
// //                       children: [
// //                         Icon(Icons.info_outline, color: Colors.blue.shade600),
// //                         const SizedBox(width: 12),
// //                         Expanded(
// //                           child: Text(
// //                             'Review your prescription and select a pharmacy before uploading',
// //                             style: TextStyle(
// //                               color: Colors.blue.shade800,
// //                               fontSize: 12,
// //                               fontWeight: FontWeight.w500,
// //                             ),
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                   const Spacer(),
// //                 ],
// //               ),
// //             ),
// //           ),

// //           // Action buttons section
// //           Container(
// //             width: double.infinity,
// //             padding: const EdgeInsets.all(20),
// //             decoration: BoxDecoration(
// //               color: Colors.white,
// //               boxShadow: [
// //                 BoxShadow(
// //                   color: Colors.grey.withOpacity(0.1),
// //                   spreadRadius: 1,
// //                   blurRadius: 4,
// //                   offset: const Offset(0, -2),
// //                 ),
// //               ],
// //             ),
// //             child: Column(
// //               mainAxisSize: MainAxisSize.min,
// //               children: [
// //                 // Submit button (primary action on top)
// //                 SizedBox(
// //                   width: double.infinity,
// //                   height: 52,
// //                   child: ElevatedButton(
// //                     onPressed: (_isUploading || _selectedPharmacy == null) ? null : _uploadPrescription,
// //                     style: ElevatedButton.styleFrom(
// //                       backgroundColor: Colors.blue.shade600,
// //                       foregroundColor: Colors.white,
// //                       shape: RoundedRectangleBorder(
// //                         borderRadius: BorderRadius.circular(8),
// //                       ),
// //                       elevation: 2,
// //                       disabledBackgroundColor: Colors.grey.shade300,
// //                     ),
// //                     child: _isUploading
// //                         ? const SizedBox(
// //                             width: 20,
// //                             height: 20,
// //                             child: CircularProgressIndicator(
// //                               color: Colors.white,
// //                               strokeWidth: 2,
// //                             ),
// //                           )
// //                         : Row(
// //                             mainAxisAlignment: MainAxisAlignment.center,
// //                             children: [
// //                               const Icon(Icons.cloud_upload_outlined, size: 20),
// //                               const SizedBox(width: 8),
// //                               Text(
// //                                 _selectedPharmacy != null
// //                                     ? 'Submit to ${_selectedPharmacy!.name}'
// //                                     : 'Submit Prescription',
// //                                 style: const TextStyle(
// //                                   fontSize: 16,
// //                                   fontWeight: FontWeight.w600,
// //                                 ),
// //                               ),
// //                             ],
// //                           ),
// //                   ),
// //                 ),

// //                 const SizedBox(height: 12),

// //                 // Retake button (secondary action)
// //                 SizedBox(
// //                   width: double.infinity,
// //                   height: 48,
// //                   child: OutlinedButton(
// //                     onPressed: _isUploading ? null : _retakePicture,
// //                     style: OutlinedButton.styleFrom(
// //                       side: BorderSide(color: Colors.grey.shade400),
// //                       shape: RoundedRectangleBorder(
// //                         borderRadius: BorderRadius.circular(8),
// //                       ),
// //                     ),
// //                     child: Row(
// //                       mainAxisAlignment: MainAxisAlignment.center,
// //                       children: [
// //                         Icon(Icons.crop, color: Colors.grey.shade600, size: 18),
// //                         const SizedBox(width: 8),
// //                         Text(
// //                           'Re-crop Image',
// //                           style: TextStyle(
// //                             color: Colors.grey.shade700,
// //                             fontSize: 15,
// //                             fontWeight: FontWeight.w500,
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// import 'dart:io';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:medical_user_app/models/pharmacy_model.dart';
// import 'package:medical_user_app/utils/shared_preferences_helper.dart';

// class ResultScreen extends StatefulWidget {
//   final File imageFile;
//   const ResultScreen({super.key, required this.imageFile});

//   @override
//   State<ResultScreen> createState() => _ResultScreenState();
// }

// class _ResultScreenState extends State<ResultScreen> {
//   bool _isUploading = false;
//   bool _isLoadingPharmacies = false;
//   List<Pharmacy> _pharmacies = [];
//   Pharmacy? _selectedPharmacy;
//   final TextEditingController _noteController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     _loadPharmacies();
//   }

//   @override
//   void dispose() {
//     _noteController.dispose();
//     super.dispose();
//   }

//   Future<void> _loadPharmacies() async {
//     try {
//       setState(() {
//         _isLoadingPharmacies = true;
//       });

//       final token = await SharedPreferencesHelper.getToken();
//       final response = await http.get(
//         Uri.parse('http://31.97.206.144:7021/api/pharmacy/getallpjarmacy'),
//         headers: {
//           'Content-Type': 'application/json',
//           if (token != null && token.isNotEmpty)
//             'Authorization': 'Bearer $token',
//         },
//       ).timeout(
//         const Duration(seconds: 15),
//         onTimeout: () {
//           throw Exception(
//               'Request timeout. Please check your internet connection.');
//         },
//       );

//       if (response.statusCode == 200) {
//         final pharmacyResponse =
//             PharmacyResponse.fromJson(json.decode(response.body));
//         setState(() {
//           _pharmacies = pharmacyResponse.pharmacies;
//         });
//       } else {
//         _showError('Failed to load pharmacies');
//       }
//     } catch (e) {
//       _showError('Error loading pharmacies: $e');
//     } finally {
//       setState(() {
//         _isLoadingPharmacies = false;
//       });
//     }
//   }

//   Future<void> _uploadPrescription() async {
//     if (_isUploading) return;

//     if (_selectedPharmacy == null) {
//       _showError('Please select a pharmacy before uploading');
//       return;
//     }

//     try {
//       setState(() {
//         _isUploading = true;
//       });

//       final user = await SharedPreferencesHelper.getUser();
//       if (user == null || user.id.isEmpty) {
//         _showError('User not found. Please login again.');
//         return;
//       }

//       final uri = Uri.parse(
//           'http://31.97.206.144:7021/api/users/sendprescription/${user.id}/${_selectedPharmacy!.id}');
//       final request = http.MultipartRequest('POST', uri);

//       print('Upload URL: $uri');

//       final imageFile = await http.MultipartFile.fromPath(
//         'prescriptionFile',
//         widget.imageFile.path,
//         filename: 'prescription_${DateTime.now().millisecondsSinceEpoch}.jpg',
//       );
//       request.files.add(imageFile);

//       // Add note to the request if it's not empty
//       if (_noteController.text.trim().isNotEmpty) {
//         request.fields['note'] = _noteController.text.trim();
//       }

//       final token = await SharedPreferencesHelper.getToken();
//       if (token != null && token.isNotEmpty) {
//         request.headers['Authorization'] = 'Bearer $token';
//       }

//       final streamedResponse = await request.send().timeout(
//         const Duration(seconds: 30),
//         onTimeout: () {
//           throw Exception(
//               'Upload timeout. Please check your internet connection.');
//         },
//       );
//       final response = await http.Response.fromStream(streamedResponse);

//       print('Response body: ${response.body}');

//       if (mounted) {
//         print('Status code: ${response.statusCode}');
//         if (response.statusCode == 200 || response.statusCode == 201) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text(
//                   'Prescription uploaded successfully to ${_selectedPharmacy!.name}!'),
//               backgroundColor: Colors.green,
//               duration: const Duration(seconds: 3),
//             ),
//           );

//           Navigator.popUntil(context, (route) => route.isFirst);
//         } else {
//           try {
//             final errorData = json.decode(response.body);
//             _showError(errorData['message'] ?? 'Failed to upload prescription');
//           } catch (e) {
//             _showError(
//                 'Failed to upload prescription. Status: ${response.statusCode}');
//           }
//         }
//       }
//     } catch (e) {
//       if (mounted) {
//         _showError('Network error: $e');
//       }
//     } finally {
//       if (mounted) {
//         setState(() {
//           _isUploading = false;
//         });
//       }
//     }
//   }

//   void _showError(String message) {
//     if (mounted) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(message),
//           backgroundColor: Colors.red,
//           duration: const Duration(seconds: 4),
//         ),
//       );
//     }
//   }

//   void _retakePicture() {
//     Navigator.pop(context);
//   }

//   void _showPharmacySelectionDialog() {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: Colors.transparent,
//       builder: (context) => Container(
//         height: MediaQuery.of(context).size.height * 0.7,
//         decoration: const BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(20),
//             topRight: Radius.circular(20),
//           ),
//         ),
//         child: Column(
//           children: [
//             Container(
//               padding: const EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                 color: Colors.blue.shade600,
//                 borderRadius: const BorderRadius.only(
//                   topLeft: Radius.circular(20),
//                   topRight: Radius.circular(20),
//                 ),
//               ),
//               child: Row(
//                 children: [
//                   const Expanded(
//                     child: Text(
//                       'Select Pharmacy',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 18,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ),
//                   IconButton(
//                     onPressed: () => Navigator.pop(context),
//                     icon: const Icon(Icons.close, color: Colors.white),
//                   ),
//                 ],
//               ),
//             ),
//             Expanded(
//               child: _isLoadingPharmacies
//                   ? const Center(child: CircularProgressIndicator())
//                   : _pharmacies.isEmpty
//                       ? const Center(
//                           child: Text(
//                             'No pharmacies available',
//                             style: TextStyle(fontSize: 16),
//                           ),
//                         )
//                       : ListView.builder(
//                           padding: const EdgeInsets.all(16),
//                           itemCount: _pharmacies.length,
//                           itemBuilder: (context, index) {
//                             final pharmacy = _pharmacies[index];
//                             final isSelected =
//                                 _selectedPharmacy?.id == pharmacy.id;

//                             return Container(
//                               margin: const EdgeInsets.only(bottom: 12),
//                               decoration: BoxDecoration(
//                                 border: Border.all(
//                                   color: isSelected
//                                       ? Colors.blue.shade600
//                                       : Colors.grey.shade300,
//                                   width: isSelected ? 2 : 1,
//                                 ),
//                                 borderRadius: BorderRadius.circular(12),
//                                 color: isSelected
//                                     ? Colors.blue.shade50
//                                     : Colors.white,
//                               ),
//                               child: ListTile(
//                                 contentPadding: const EdgeInsets.all(12),
//                                 leading: Container(
//                                   width: 50,
//                                   height: 50,
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(8),
//                                     color: Colors.grey.shade200,
//                                   ),
//                                   child: pharmacy.image.isNotEmpty
//                                       ? ClipRRect(
//                                           borderRadius:
//                                               BorderRadius.circular(8),
//                                           child: Image.network(
//                                             pharmacy.image,
//                                             fit: BoxFit.cover,
//                                             errorBuilder: (context, error,
//                                                     stackTrace) =>
//                                                 Icon(Icons.local_pharmacy,
//                                                     color:
//                                                         Colors.grey.shade600),
//                                           ),
//                                         )
//                                       : Icon(Icons.local_pharmacy,
//                                           color: Colors.grey.shade600),
//                                 ),
//                                 title: Text(
//                                   pharmacy.name,
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.w600,
//                                     color: isSelected
//                                         ? Colors.blue.shade800
//                                         : Colors.black87,
//                                   ),
//                                 ),
//                                 subtitle: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     const SizedBox(height: 4),
//                                     Text(
//                                       pharmacy.address,
//                                       style: TextStyle(
//                                         color: Colors.grey.shade600,
//                                         fontSize: 13,
//                                       ),
//                                     ),
//                                     if (pharmacy.categories.isNotEmpty) ...[
//                                       const SizedBox(height: 4),
//                                       Text(
//                                         'Categories: ${pharmacy.categories.map((c) => c.name).join(', ')}',
//                                         style: TextStyle(
//                                           color: Colors.grey.shade500,
//                                           fontSize: 12,
//                                         ),
//                                         maxLines: 1,
//                                         overflow: TextOverflow.ellipsis,
//                                       ),
//                                     ],
//                                   ],
//                                 ),
//                                 trailing: isSelected
//                                     ? Icon(Icons.check_circle,
//                                         color: Colors.blue.shade600)
//                                     : Icon(Icons.radio_button_unchecked,
//                                         color: Colors.grey.shade400),
//                                 onTap: () {
//                                   setState(() {
//                                     _selectedPharmacy = pharmacy;
//                                   });
//                                   Navigator.pop(context);
//                                 },
//                               ),
//                             );
//                           },
//                         ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[50],
//       appBar: AppBar(
//         title: const Text(
//           "Review Image",
//           style: TextStyle(
//             color: Colors.white,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         backgroundColor: Colors.blue.shade600,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.white),
//           onPressed: () => Navigator.pop(context),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             // Image preview section
//             Container(
//               width: double.infinity,
//               height: MediaQuery.of(context).size.height * 0.35,
//               margin: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(12),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey.withOpacity(0.2),
//                     spreadRadius: 2,
//                     blurRadius: 8,
//                     offset: const Offset(0, 2),
//                   ),
//                 ],
//               ),
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(12),
//                 child: Image.file(
//                   widget.imageFile,
//                   fit: BoxFit.contain,
//                   width: double.infinity,
//                   height: double.infinity,
//                 ),
//               ),
//             ),

//             // Pharmacy selection section
//             Container(
//               margin: const EdgeInsets.symmetric(horizontal: 16),
//               child: Card(
//                 elevation: 2,
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12)),
//                 child: InkWell(
//                   onTap: _showPharmacySelectionDialog,
//                   borderRadius: BorderRadius.circular(12),
//                   child: Padding(
//                     padding: const EdgeInsets.all(16),
//                     child: Row(
//                       children: [
//                         Container(
//                           padding: const EdgeInsets.all(8),
//                           decoration: BoxDecoration(
//                             color: Colors.blue.shade100,
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           child: Icon(
//                             Icons.local_pharmacy,
//                             color: Colors.blue.shade600,
//                             size: 24,
//                           ),
//                         ),
//                         const SizedBox(width: 12),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 _selectedPharmacy != null
//                                     ? _selectedPharmacy!.name
//                                     : 'Select Pharmacy',
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.w600,
//                                   fontSize: 16,
//                                   color: _selectedPharmacy != null
//                                       ? Colors.black87
//                                       : Colors.grey.shade600,
//                                 ),
//                               ),
//                               if (_selectedPharmacy != null) ...[
//                                 const SizedBox(height: 4),
//                                 Text(
//                                   _selectedPharmacy!.address,
//                                   style: TextStyle(
//                                     color: Colors.grey.shade600,
//                                     fontSize: 13,
//                                   ),
//                                   maxLines: 1,
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                               ] else
//                                 Text(
//                                   'Choose where to send your prescription',
//                                   style: TextStyle(
//                                     color: Colors.grey.shade600,
//                                     fontSize: 13,
//                                   ),
//                                 ),
//                             ],
//                           ),
//                         ),
//                         Icon(Icons.arrow_forward_ios,
//                             color: Colors.grey.shade400, size: 16),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),

//             const SizedBox(height: 16),

//             // Note section
//             Container(
//               margin: const EdgeInsets.symmetric(horizontal: 16),
//               child: Card(
//                 elevation: 2,
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12)),
//                 child: Padding(
//                   padding: const EdgeInsets.all(16),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         children: [
//                           Container(
//                             padding: const EdgeInsets.all(8),
//                             decoration: BoxDecoration(
//                               color: Colors.orange.shade100,
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             child: Icon(
//                               Icons.note_alt_outlined,
//                               color: Colors.orange.shade600,
//                               size: 24,
//                             ),
//                           ),
//                           const SizedBox(width: 12),
//                           const Text(
//                             'Add Note (Optional)',
//                             style: TextStyle(
//                               fontWeight: FontWeight.w600,
//                               fontSize: 16,
//                               color: Colors.black87,
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 12),
//                       TextField(
//                         controller: _noteController,
//                         maxLines: 3,
//                         maxLength: 200,
//                         decoration: InputDecoration(
//                           hintText:
//                               'Add any special instructions or notes for the pharmacy...',
//                           hintStyle: TextStyle(
//                               color: Colors.grey.shade500, fontSize: 14),
//                           filled: true,
//                           fillColor: Colors.grey.shade50,
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(8),
//                             borderSide: BorderSide(color: Colors.grey.shade300),
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(8),
//                             borderSide: BorderSide(color: Colors.grey.shade300),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(8),
//                             borderSide: BorderSide(
//                                 color: Colors.blue.shade600, width: 2),
//                           ),
//                           contentPadding: const EdgeInsets.all(12),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),

//             const SizedBox(height: 16),

//             // Instructions section
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               child: Container(
//                 padding: const EdgeInsets.all(12),
//                 decoration: BoxDecoration(
//                   color: Colors.blue.shade50,
//                   borderRadius: BorderRadius.circular(8),
//                   border: Border.all(color: Colors.blue.shade200),
//                 ),
//                 child: Row(
//                   children: [
//                     Icon(Icons.info_outline, color: Colors.blue.shade600),
//                     const SizedBox(width: 12),
//                     Expanded(
//                       child: Text(
//                         'Review your prescription and select a pharmacy before uploading',
//                         style: TextStyle(
//                           color: Colors.blue.shade800,
//                           fontSize: 12,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),

//             const SizedBox(height: 16),

//             // Action buttons section
//             Container(
//               width: double.infinity,
//               padding: const EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey.withOpacity(0.1),
//                     spreadRadius: 1,
//                     blurRadius: 4,
//                     offset: const Offset(0, -2),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   // Submit button
//                   SizedBox(
//                     width: double.infinity,
//                     height: 52,
//                     child: ElevatedButton(
//                       onPressed: (_isUploading || _selectedPharmacy == null)
//                           ? null
//                           : _uploadPrescription,
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.blue.shade600,
//                         foregroundColor: Colors.white,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         elevation: 2,
//                         disabledBackgroundColor: Colors.grey.shade300,
//                       ),
//                       child: _isUploading
//                           ? const SizedBox(
//                               width: 20,
//                               height: 20,
//                               child: CircularProgressIndicator(
//                                 color: Colors.white,
//                                 strokeWidth: 2,
//                               ),
//                             )
//                           : Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 const Icon(Icons.cloud_upload_outlined,
//                                     size: 20),
//                                 const SizedBox(width: 8),
//                                 Text(
//                                   _selectedPharmacy != null
//                                       ? 'Submit to ${_selectedPharmacy!.name}'
//                                       : 'Submit Prescription',
//                                   style: const TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                     ),
//                   ),

//                   const SizedBox(height: 12),

//                   // Retake button
//                   SizedBox(
//                     width: double.infinity,
//                     height: 48,
//                     child: OutlinedButton(
//                       onPressed: _isUploading ? null : _retakePicture,
//                       style: OutlinedButton.styleFrom(
//                         side: BorderSide(color: Colors.grey.shade400),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(Icons.crop,
//                               color: Colors.grey.shade600, size: 18),
//                           const SizedBox(width: 8),
//                           Text(
//                             'Re-crop Image',
//                             style: TextStyle(
//                               color: Colors.grey.shade700,
//                               fontSize: 15,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }















import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:medical_user_app/models/pharmacy_model.dart';
import 'package:medical_user_app/utils/shared_preferences_helper.dart';

class ResultScreen extends StatefulWidget {
  final File imageFile;
  const ResultScreen({super.key, required this.imageFile});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  bool _isUploading = false;
  bool _isLoadingPharmacies = false;
  List<Pharmacy> _pharmacies = [];
  Pharmacy? _selectedPharmacy;
  final TextEditingController _noteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadPharmacies();
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _loadPharmacies() async {
    try {
      setState(() {
        _isLoadingPharmacies = true;
      });

      final token = await SharedPreferencesHelper.getToken();
      final response = await http.get(
        Uri.parse('http://31.97.206.144:7021/api/pharmacy/getallpjarmacy'),
        headers: {
          'Content-Type': 'application/json',
          if (token != null && token.isNotEmpty)
            'Authorization': 'Bearer $token',
        },
      ).timeout(
        const Duration(seconds: 15),
        onTimeout: () {
          throw Exception(
              'Request timeout. Please check your internet connection.');
        },
      );

      if (response.statusCode == 200) {
        final pharmacyResponse =
            PharmacyResponse.fromJson(json.decode(response.body));
        setState(() {
          _pharmacies = pharmacyResponse.pharmacies;
        });
      } else {
        _showError('Failed to load pharmacies');
      }
    } catch (e) {
      _showError('Error loading pharmacies: $e');
    } finally {
      setState(() {
        _isLoadingPharmacies = false;
      });
    }
  }

  Future<void> _uploadPrescription() async {
    if (_isUploading) return;

    if (_selectedPharmacy == null) {
      _showError('Please select a pharmacy before uploading');
      return;
    }

    try {
      setState(() {
        _isUploading = true;
      });

      final user = await SharedPreferencesHelper.getUser();
      if (user == null || user.id.isEmpty) {
        _showError('User not found. Please login again.');
        return;
      }

      final uri = Uri.parse(
          'http://31.97.206.144:7021/api/users/sendprescription/${user.id}/${_selectedPharmacy!.id}');
      final request = http.MultipartRequest('POST', uri);

      print('Upload URL: $uri');

      final imageFile = await http.MultipartFile.fromPath(
        'prescriptionFile',
        widget.imageFile.path,
        filename: 'prescription_${DateTime.now().millisecondsSinceEpoch}.jpg',
      );
      request.files.add(imageFile);

      // Add note to the request if it's not empty
      if (_noteController.text.trim().isNotEmpty) {
        request.fields['note'] = _noteController.text.trim();
      }

      final token = await SharedPreferencesHelper.getToken();
      if (token != null && token.isNotEmpty) {
        request.headers['Authorization'] = 'Bearer $token';
      }

      final streamedResponse = await request.send().timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          throw Exception(
              'Upload timeout. Please check your internet connection.');
        },
      );
      final response = await http.Response.fromStream(streamedResponse);

      print('Response body: ${response.body}');

      if (mounted) {
        print('Status code: ${response.statusCode}');
        if (response.statusCode == 200 || response.statusCode == 201) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  'Prescription uploaded successfully to ${_selectedPharmacy!.name}!'),
              backgroundColor: Colors.green,
              duration: const Duration(seconds: 3),
            ),
          );

          Navigator.popUntil(context, (route) => route.isFirst);
        } else {
          try {
            final errorData = json.decode(response.body);
            _showError(errorData['message'] ?? 'Failed to upload prescription');
          } catch (e) {
            _showError(
                'Failed to upload prescription. Status: ${response.statusCode}');
          }
        }
      }
    } catch (e) {
      if (mounted) {
        _showError('Network error: $e');
      }
    } finally {
      if (mounted) {
        setState(() {
          _isUploading = false;
        });
      }
    }
  }

  void _showError(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 4),
        ),
      );
    }
  }

  void _retakePicture() {
    Navigator.pop(context);
  }

  void _showPharmacySelectionDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
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
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blue.shade600,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Select Pharmacy',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close, color: Colors.white),
                  ),
                ],
              ),
            ),
            Expanded(
              child: _isLoadingPharmacies
                  ? const Center(child: CircularProgressIndicator())
                  : _pharmacies.isEmpty
                      ? const Center(
                          child: Text(
                            'No pharmacies available',
                            style: TextStyle(fontSize: 16),
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: _pharmacies.length,
                          itemBuilder: (context, index) {
                            final pharmacy = _pharmacies[index];
                            final isSelected =
                                _selectedPharmacy?.id == pharmacy.id;

                            return Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: isSelected
                                      ? Colors.blue.shade600
                                      : Colors.grey.shade300,
                                  width: isSelected ? 2 : 1,
                                ),
                                borderRadius: BorderRadius.circular(12),
                                color: isSelected
                                    ? Colors.blue.shade50
                                    : Colors.white,
                              ),
                              child: ListTile(
                                contentPadding: const EdgeInsets.all(12),
                                leading: Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.grey.shade200,
                                  ),
                                  child: pharmacy.image.isNotEmpty
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: Image.network(
                                            pharmacy.image,
                                            fit: BoxFit.cover,
                                            errorBuilder: (context, error,
                                                    stackTrace) =>
                                                Icon(Icons.local_pharmacy,
                                                    color:
                                                        Colors.grey.shade600),
                                          ),
                                        )
                                      : Icon(Icons.local_pharmacy,
                                          color: Colors.grey.shade600),
                                ),
                                title: Text(
                                  pharmacy.name,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: isSelected
                                        ? Colors.blue.shade800
                                        : Colors.black87,
                                  ),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 4),
                                    Text(
                                      pharmacy.address,
                                      style: TextStyle(
                                        color: Colors.grey.shade600,
                                        fontSize: 13,
                                      ),
                                    ),
                                    if (pharmacy.categories.isNotEmpty) ...[
                                      const SizedBox(height: 4),
                                      Text(
                                        'Categories: ${pharmacy.categories.map((c) => c.name).join(', ')}',
                                        style: TextStyle(
                                          color: Colors.grey.shade500,
                                          fontSize: 12,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ],
                                ),
                                trailing: isSelected
                                    ? Icon(Icons.check_circle,
                                        color: Colors.blue.shade600)
                                    : Icon(Icons.radio_button_unchecked,
                                        color: Colors.grey.shade400),
                                onTap: () {
                                  setState(() {
                                    _selectedPharmacy = pharmacy;
                                  });
                                  Navigator.pop(context);
                                },
                              ),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          "Review Image",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.blue.shade600,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Scrollable content
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Image preview section
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.35,
                    margin: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.file(
                        widget.imageFile,
                        fit: BoxFit.contain,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                  ),

                  // Pharmacy selection section
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    child: Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      child: InkWell(
                        onTap: _showPharmacySelectionDialog,
                        borderRadius: BorderRadius.circular(12),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.blue.shade100,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(
                                  Icons.local_pharmacy,
                                  color: Colors.blue.shade600,
                                  size: 24,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _selectedPharmacy != null
                                          ? _selectedPharmacy!.name
                                          : 'Select Pharmacy',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                        color: _selectedPharmacy != null
                                            ? Colors.black87
                                            : Colors.grey.shade600,
                                      ),
                                    ),
                                    if (_selectedPharmacy != null) ...[
                                      const SizedBox(height: 4),
                                      Text(
                                        _selectedPharmacy!.address,
                                        style: TextStyle(
                                          color: Colors.grey.shade600,
                                          fontSize: 13,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ] else
                                      Text(
                                        'Choose where to send your prescription',
                                        style: TextStyle(
                                          color: Colors.grey.shade600,
                                          fontSize: 13,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              Icon(Icons.arrow_forward_ios,
                                  color: Colors.grey.shade400, size: 16),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Note section
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    child: Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.orange.shade100,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Icon(
                                    Icons.note_alt_outlined,
                                    color: Colors.orange.shade600,
                                    size: 24,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                const Text(
                                  'Add Note (Optional)',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            TextField(
                              controller: _noteController,
                              maxLines: 3,
                              maxLength: 200,
                              decoration: InputDecoration(
                                hintText:
                                    'Add any special instructions or notes for the pharmacy...',
                                hintStyle: TextStyle(
                                    color: Colors.grey.shade500, fontSize: 14),
                                filled: true,
                                fillColor: Colors.grey.shade50,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade300),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade300),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                      color: Colors.blue.shade600, width: 2),
                                ),
                                contentPadding: const EdgeInsets.all(12),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Instructions section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.blue.shade200),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.info_outline, color: Colors.blue.shade600),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'Review your prescription and select a pharmacy before uploading',
                              style: TextStyle(
                                color: Colors.blue.shade800,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),

          // Fixed action buttons section at bottom with safe area
          SafeArea(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Submit button
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: (_isUploading || _selectedPharmacy == null)
                          ? null
                          : _uploadPrescription,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade600,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 2,
                        disabledBackgroundColor: Colors.grey.shade300,
                      ),
                      child: _isUploading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.cloud_upload_outlined,
                                    size: 20),
                                const SizedBox(width: 8),
                                Text(
                                  _selectedPharmacy != null
                                      ? 'Submit to ${_selectedPharmacy!.name}'
                                      : 'Submit Prescription',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Retake button
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: OutlinedButton(
                      onPressed: _isUploading ? null : _retakePicture,
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.grey.shade400),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.crop,
                              color: Colors.grey.shade600, size: 18),
                          const SizedBox(width: 8),
                          Text(
                            'Re-crop Image',
                            style: TextStyle(
                              color: Colors.grey.shade700,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}