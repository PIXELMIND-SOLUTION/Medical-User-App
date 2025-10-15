// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:medical_user_app/providers/category_provider.dart';
// import 'package:medical_user_app/providers/language_provider.dart';
// import 'package:medical_user_app/providers/services_provider.dart';

// class CategoryScreen extends StatefulWidget {
//   const CategoryScreen({super.key});

//   @override
//   State<CategoryScreen> createState() => _CategoryScreenState();
// }

// class _CategoryScreenState extends State<CategoryScreen> {
//   String _searchQuery = '';
//   String _selectedServiceId = '';

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       final langCode = Provider.of<LanguageProvider>(context, listen: false).locale.languageCode;
//       context.read<CategoryProvider>().loadAllCategories(langCode);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: const Text(
//           'All Categories',
//           style: TextStyle(
//             color: Colors.black,
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: Column(
//         children: [
//           // Search and Filter Section
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               children: [
//                 // Search Bar
//                 Container(
//                   decoration: BoxDecoration(
//                     color: Colors.grey[100],
//                     borderRadius: BorderRadius.circular(30),
//                   ),
//                   child: TextField(
//                     onChanged: (value) {
//                       setState(() {
//                         _searchQuery = value.toLowerCase();
//                       });
//                     },
//                     decoration: InputDecoration(
//                       hintText: 'Search categories...',
//                       prefixIcon: const Icon(Icons.search, color: Colors.grey),
//                       border: InputBorder.none,
//                       contentPadding: const EdgeInsets.symmetric(vertical: 12),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 16),
                
//                 // Service Filter Chips
//                 Consumer<ServiceProvider>(
//                   builder: (context, serviceProvider, child) {
//                     if (!serviceProvider.hasServices) {
//                       return const SizedBox.shrink();
//                     }
                    
//                     return SizedBox(
//                       height: 2,
//                       child: ListView(
//                         scrollDirection: Axis.horizontal,
//                         children: [
//                         ],
//                       ),
//                     );
//                   },
//                 ),
//               ],
//             ),
//           ),
          
//           // Categories Grid
//           Expanded(
//             child: Consumer<CategoryProvider>(
//               builder: (context, categoryProvider, child) {
//                 if (categoryProvider.isLoading) {
//                   return const Center(
//                     child: CircularProgressIndicator(
//                       color: Color(0xFF5931DD),
//                     ),
//                   );
//                 }

//                 if (categoryProvider.categories.isEmpty) {
//                   return Center(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(
//                           Icons.category_outlined,
//                           size: 64,
//                           color: Colors.grey[400],
//                         ),
//                         const SizedBox(height: 16),
//                         Text(
//                           'No categories found',
//                           style: TextStyle(
//                             fontSize: 16,
//                             color: Colors.grey[600],
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 }

//                 // Filter categories based on search query
//                 final filteredCategories = categoryProvider.categories
//                     .where((category) => 
//                         category.categoryName.toLowerCase().contains(_searchQuery))
//                     .toList();

//                 if (filteredCategories.isEmpty && _searchQuery.isNotEmpty) {
//                   return Center(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(
//                           Icons.search_off,
//                           size: 64,
//                           color: Colors.grey[400],
//                         ),
//                         const SizedBox(height: 16),
//                         Text(
//                           'No categories found for "$_searchQuery"',
//                           style: TextStyle(
//                             fontSize: 16,
//                             color: Colors.grey[600],
//                           ),
//                           textAlign: TextAlign.center,
//                         ),
//                       ],
//                     ),
//                   );
//                 }

//                 return Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                   child: GridView.builder(
//                     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 3,
//                       crossAxisSpacing: 16,
//                       mainAxisSpacing: 16,
//                       childAspectRatio: 0.85,
//                     ),
//                     itemCount: filteredCategories.length,
//                     itemBuilder: (context, index) {
//                       final category = filteredCategories[index];
//                       return _buildCategoryCard(category);
//                     },
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildCategoryCard(dynamic category) {
//     return GestureDetector(
//       onTap: () {
//         // Handle category selection
//         // You can navigate to a medicines screen filtered by this category
//         // or perform any other action based on category selection
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Selected: ${category.categoryName}'),
//             duration: const Duration(seconds: 1),
//             backgroundColor: const Color(0xFF5931DD),
//           ),
//         );
//       },
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(16),
//           border: Border.all(
//             color: Colors.grey.shade200,
//             width: 1,
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.1),
//               spreadRadius: 1,
//               blurRadius: 4,
//               offset: const Offset(0, 2),
//             ),
//           ],
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // Category Image
//             Expanded(
//               flex: 3,
//               child: Padding(
//                 padding: const EdgeInsets.all(12.0),
//                 child: _buildCategoryImage(category.image),
//               ),
//             ),
            
//             // Category Name
//             Expanded(
//               flex: 2,
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       category.categoryName,
//                       style: const TextStyle(
//                         fontSize: 13,
//                         fontWeight: FontWeight.w600,
//                         color: Colors.black87,
//                       ),
//                       textAlign: TextAlign.center,
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                     if (category.serviceName != null && category.serviceName.isNotEmpty) ...[
//                       const SizedBox(height: 4),
//                       Text(
//                         category.serviceName,
//                         style: TextStyle(
//                           fontSize: 10,
//                           color: Colors.grey[600],
//                         ),
//                         textAlign: TextAlign.center,
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ],
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildCategoryImage(String imagePath) {
//     if (imagePath.isEmpty) {
//       return Icon(
//         Icons.category,
//         size: 40,
//         color: Colors.grey[400],
//       );
//     }

//     if (imagePath.startsWith('http://') || imagePath.startsWith('https://')) {
//       return ClipRRect(
//         borderRadius: BorderRadius.circular(8),
//         child: Image.network(
//           imagePath,
//           fit: BoxFit.cover,
//           errorBuilder: (context, error, stackTrace) {
//             return Icon(
//               Icons.category,
//               size: 40,
//               color: Colors.grey[400],
//             );
//           },
//           loadingBuilder: (context, child, loadingProgress) {
//             if (loadingProgress == null) return child;
//             return Center(
//               child: CircularProgressIndicator(
//                 value: loadingProgress.expectedTotalBytes != null
//                     ? loadingProgress.cumulativeBytesLoaded /
//                         loadingProgress.expectedTotalBytes!
//                     : null,
//                 strokeWidth: 2,
//                 color: const Color(0xFF5931DD),
//               ),
//             );
//           },
//         ),
//       );
//     } else {
//       return ClipRRect(
//         borderRadius: BorderRadius.circular(8),
//         child: Image.asset(
//           imagePath,
//           fit: BoxFit.cover,
//           errorBuilder: (context, error, stackTrace) {
//             return Icon(
//               Icons.category,
//               size: 40,
//               color: Colors.grey[400],
//             );
//           },
//         ),
//       );
//     }
//   }
// }













// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:medical_user_app/providers/category_provider.dart';
import 'package:medical_user_app/providers/language_provider.dart';
import 'package:medical_user_app/providers/services_provider.dart';
import 'package:medical_user_app/providers/medicine_provider.dart';
import 'package:medical_user_app/view/scanned_medicine_screen.dart';
import 'package:medical_user_app/models/medicine_model.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  String _searchQuery = '';
  String _selectedServiceId = '';
  String? _selectedCategoryName;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final langCode = Provider.of<LanguageProvider>(context, listen: false).locale.languageCode;
      context.read<CategoryProvider>().loadAllCategories(langCode);
      // Load all medicines initially
      context.read<MedicineProvider>().loadMedicines();
    });
  }

  void _onCategorySelected(String categoryName) {
    setState(() {
      _selectedCategoryName = categoryName;
    });

    final medicineProvider = Provider.of<MedicineProvider>(context, listen: false);

    if (categoryName.toLowerCase() == 'all' || categoryName.isEmpty) {
      // Show all medicines
      medicineProvider.loadAllMedicines();
    } else {
      // Show medicines for selected category
      medicineProvider.loadMedicinesByCategory(categoryName);
    }

    // Show feedback to user
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Selected: $categoryName'),
        duration: const Duration(seconds: 1),
        backgroundColor: const Color(0xFF5931DD),
      ),
    );
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
          'All Categories',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Search and Filter Section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Search Bar
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFF3F7),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value.toLowerCase();
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Search categories...',
                      prefixIcon: const Icon(Icons.search, color: Colors.grey),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                
                // Service Filter Chips
                Consumer<ServiceProvider>(
                  builder: (context, serviceProvider, child) {
                    if (!serviceProvider.hasServices) {
                      return const SizedBox.shrink();
                    }
                    
                    return SizedBox(
                      height: 2,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          
          // Categories Grid
          Expanded(
            child: Consumer<CategoryProvider>(
              builder: (context, categoryProvider, child) {
                if (categoryProvider.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Color(0xFF5931DD),
                    ),
                  );
                }

                if (categoryProvider.categories.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.category_outlined,
                          size: 64,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No categories found',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  );
                }

                // Filter categories based on search query
                final filteredCategories = categoryProvider.categories
                    .where((category) => 
                        category.categoryName.toLowerCase().contains(_searchQuery))
                    .toList();

                if (filteredCategories.isEmpty && _searchQuery.isNotEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 64,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No categories found for "$_searchQuery"',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                }

                return Column(
                  children: [
                    // Categories Grid
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            childAspectRatio: 0.85,
                          ),
                          itemCount: filteredCategories.length,
                          itemBuilder: (context, index) {
                            final category = filteredCategories[index];
                            return _buildCategoryCard(category);
                          },
                        ),
                      ),
                    ),
                    
                    // Medicines Section (only show if a category is selected)
                    if (_selectedCategoryName != null) ...[
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        color: Colors.grey[50],
                        child: Text(
                          'Medicines in $_selectedCategoryName',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: _buildMedicineGrid(),
                      ),
                    ],
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMedicineGrid() {
    return Consumer<MedicineProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: Color(0xFF5931DD),
            ),
          );
        }

        if (provider.medicines.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.medical_services_outlined,
                  size: 64,
                  color: Colors.grey[400],
                ),
                const SizedBox(height: 16),
                Text(
                  _selectedCategoryName != null 
                    ? 'No medicines found in $_selectedCategoryName'
                    : 'No medicines available',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.65,
            ),
            itemCount: provider.medicines.length,
            itemBuilder: (context, index) {
              final medicine = provider.medicines[index];
              return _buildMedicineCard(medicine);
            },
          ),
        );
      },
    );
  }

  Widget _buildMedicineCard(MedicineModel medicine) {
    final String name = medicine.name;
    final String description = medicine.description;
    final String price = '₹${medicine.mrp}';
    final String imagePath = medicine.images.isNotEmpty ? medicine.images[0] : '';

    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>ScannedMedicineScreen(medicineId: medicine.medicineId,mrp: medicine.mrp,address: medicine.pharmacy.address,)));
      },
      child: Container(
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
            // Medicine Image
            Expanded(
              flex: 3,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                child: Stack(
                  children: [
                    imagePath.isNotEmpty
                        ? Image.network(
                            imagePath,
                            height: double.infinity,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                height: double.infinity,
                                width: double.infinity,
                                color: Colors.grey[200],
                                child: Icon(
                                  Icons.medical_services,
                                  size: 40,
                                  color: Colors.grey[400],
                                ),
                              );
                            },
                          )
                        : Container(
                            height: double.infinity,
                            width: double.infinity,
                            color: Colors.grey[200],
                            child: Icon(
                              Icons.medical_services,
                              size: 40,
                              color: Colors.grey[400],
                            ),
                          ),
                    // Price overlay
                    Positioned(
                      bottom: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          price,
                          style: const TextStyle(
                            color: Color(0xFF5931DD),
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            // Medicine Details
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          description,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    // Add to Cart Button
                    // SizedBox(
                    //   width: double.infinity,
                    //   height: 32,
                    //   child: ElevatedButton(
                    //     onPressed: () {
                    //       Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //           builder: (context) => ScannedMedicineScreen(
                    //             medicineId: medicine.medicineId,
                    //           ),
                    //         ),
                    //       );
                    //     },
                    //     style: ElevatedButton.styleFrom(
                    //       backgroundColor: const Color(0xFF5931DD),
                    //       shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.circular(8),
                    //       ),
                    //       padding: EdgeInsets.zero,
                    //     ),
                    //     child: const Text(
                    //       'View Details',
                    //       style: TextStyle(
                    //         color: Colors.white,
                    //         fontSize: 12,
                    //         fontWeight: FontWeight.w500,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard(dynamic category) {
    bool isSelected = _selectedCategoryName == category.categoryName;
    
    return GestureDetector(
      onTap: () {
        _onCategorySelected(category.categoryName);
      },
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF5931DD).withOpacity(0.1) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? const Color(0xFF5931DD) : Colors.grey.shade200,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Category Image
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: _buildCategoryImage(category.image),
              ),
            ),
            
            // Category Name
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      category.categoryName,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: isSelected ? const Color(0xFF5931DD) : Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (category.serviceName != null && category.serviceName.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        category.serviceName,
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey[600],
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryImage(String imagePath) {
    if (imagePath.isEmpty) {
      return Icon(
        Icons.category,
        size: 40,
        color: Colors.grey[400],
      );
    }

    if (imagePath.startsWith('http://') || imagePath.startsWith('https://')) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          imagePath,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Icon(
              Icons.category,
              size: 40,
              color: Colors.grey[400],
            );
          },
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                    : null,
                strokeWidth: 2,
                color: const Color(0xFF5931DD),
              ),
            );
          },
        ),
      );
    } else {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Icon(
              Icons.category,
              size: 40,
              color: Colors.grey[400],
            );
          },
        ),
      );
    }
  }
}