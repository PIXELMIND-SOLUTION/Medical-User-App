import 'package:flutter/material.dart';
import 'package:medical_user_app/models/medicine_model.dart';
import 'package:medical_user_app/providers/category_provider.dart';
import 'package:medical_user_app/providers/medicine_provider.dart';
import 'package:medical_user_app/providers/services_provider.dart';
import 'package:medical_user_app/view/checkout_screen.dart';
import 'package:medical_user_app/view/profile_screen.dart';
import 'package:medical_user_app/widgets/all_medicines.dart';
import 'package:medical_user_app/widgets/bottom_navigation.dart';
import 'package:medical_user_app/widgets/periodic_plans.dart';
import 'package:medical_user_app/widgets/previous_order.dart';
import 'package:medical_user_app/widgets/progress_bar.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    // Fetch services when the screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ServiceProvider>().fetchAllServices();
      context.read<CategoryProvider>().fetchCategories(serviceName: "");
      context.read<MedicineProvider>().loadMedicines();
    });
  }

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
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfileScreen()));
                      },
                      child: CircleAvatar(
                        radius: 24,
                        backgroundImage: AssetImage('assets/profile.png'),
                        backgroundColor: Colors.grey[300],
                      ),
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
                            borderSide:
                                BorderSide(color: Color(0xFF5931DD), width: 2),
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

                // const Text(
                //   "Services",
                //   style: TextStyle(
                //     fontSize: 18,
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),

                // SizedBox(height: 24),

                // Row(
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   children: [
                //     _buildServicesItem(
                //       imagePath: 'assets/icons/pharmacy.png',
                //       label: "Pharmacy",
                //     ),
                //   ],
                // ),

                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Services",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // Add refresh button for services
                    // Consumer<ServiceProvider>(
                    //   builder: (context, serviceProvider, child) {
                    //     return GestureDetector(
                    //       onTap: () {
                    //         serviceProvider.refreshServices();
                    //       },
                    //       child: Icon(
                    //         Icons.refresh,
                    //         color: Color(0xFF5931DD),
                    //         size: 20,
                    //       ),
                    //     );
                    //   },
                    // ),
                  ],
                ),

                const SizedBox(height: 24),

                Consumer<ServiceProvider>(
                  builder: (context, serviceProvider, child) {
                    if (serviceProvider.isLoading) {
                      return Container(
                        height: 110,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Color(0xFF5931DD),
                          ),
                        ),
                      );
                    }

                    if (serviceProvider.hasError) {
                      return Container(
                        height: 110,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Error loading services',
                                style:
                                    TextStyle(color: Colors.red, fontSize: 14),
                              ),
                              SizedBox(height: 8),
                              ElevatedButton(
                                onPressed: () {
                                  serviceProvider.fetchAllServices();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFF5931DD),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                ),
                                child: Text(
                                  'Retry',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    if (!serviceProvider.hasServices) {
                      return Container(
                        height: 110,
                        child: Center(
                          child: Text(
                            'No services available',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ),
                      );
                    }

                    // Display services in a horizontal scrollable list
                    return Container(
                      height: 110,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: serviceProvider.services.length,
                        itemBuilder: (context, index) {
                          final service = serviceProvider.services[index];
                          return Padding(
                            padding: EdgeInsets.only(
                              right: index < serviceProvider.services.length - 1
                                  ? 12
                                  : 0,
                            ),
                            child: _buildServicesItem(
                              imagePath: service.image.isNotEmpty
                                  ? service.image
                                  : 'assets/icons/pharmacy.png', // fallback image
                              label: service.servicesName,
                              serviceId: service.id,
                            ),
                          );
                        },
                      ),
                    );
                  },
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
Consumer<CategoryProvider>(
  builder: (context, categoryProvider, child) {
    // Debug prints
    print("=== Debug Info ===");
    print("isShowingAllCategories: ${categoryProvider.isShowingAllCategories}");
    print("selectedServiceName: '${categoryProvider.selectedServiceName}'");
    print("==================");
    
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: GestureDetector(
              onTap: () {
                print("Tapped All button");
                categoryProvider.loadAllCategories();
              },
              child: _buildCategoryItem(
                imagePath: 'assets/icons/all.png',
                label: "All",
                isSelected: categoryProvider.isShowingAllCategories,
              ),
            ),
          ),
          ...categoryProvider.categories.map((category) {
            bool isSelected = categoryProvider.selectedServiceName == category.serviceName;
            print("Category: ${category.categoryName}, Service: ${category.serviceName}, Selected: $isSelected");
            
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: GestureDetector(
                onTap: () {
                  print("Tapped category: ${category.categoryName}, Service: ${category.serviceName}");
                  categoryProvider.loadCategoriesByService(category.serviceName);
                },
                child: _buildCategoryItem(
                  imagePath: category.image.isNotEmpty
                      ? category.image
                      : 'assets/icons/default_category.png',
                  label: category.categoryName,
                  isSelected: isSelected,
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  },
),

                SizedBox(height: 24),

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
                _buildAllMedicineCardGrid(context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAllMedicineCardGrid(BuildContext context) {
    return Consumer<MedicineProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (provider.medicines.isEmpty) {
          return const Center(child: Text("No medicines available."));
        }

        return GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: 0.65,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: List.generate(
            provider.medicines.length,
            (index) =>
                _buildMedicineCardItem(context, provider.medicines[index]),
          ),
        );
      },
    );
  }

  Widget _buildMedicineCardItem(BuildContext context, MedicineModel medicine) {
    final String name = medicine.name;
    final String description = medicine.description;
    final String price = '₹${medicine.price}';
    final String location =
        'Unknown Pharmacy'; // Replace when pharmacy is added
    final String imagePath =
        medicine.images.isNotEmpty ? medicine.images[0] : '';

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
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            child: Stack(
              children: [
                imagePath.isNotEmpty
                    ? Image.network(
                        imagePath,
                        height: 120,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      )
                    : Container(
                        height: 120,
                        width: double.infinity,
                        color: Colors.grey[300],
                        child: const Icon(Icons.image_not_supported),
                      ),
                Positioned(
                  bottom: 8,
                  left: 8,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      price,
                      style: const TextStyle(
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(
                  '${description.split(' ').take(3).join(' ')}...',
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.location_on,
                        color: Colors.deepPurple, size: 14),
                    const SizedBox(width: 4),
                    Text(location,
                        style:
                            const TextStyle(fontSize: 12, color: Colors.grey)),
                  ],
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
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
                  child: const Text('Add On',
                      style: TextStyle(color: Colors.white)),
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
      color:
          isSelected ? Color(0XFFEFF3F7) : Color.fromARGB(255, 255, 255, 255),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(
        color: isSelected ? Color(0xFF5931DD) : Colors.grey,
      ),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: _buildImageWidget(imagePath),
          ),
        ),
        Expanded(
          flex: 1,
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? Color(0xFF5931DD) : Colors.grey[600],
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

// // Helper method to handle both network and asset images
Widget _buildImageWidget(String imagePath) {
  print("iiiiiiiiiiiiiiiiiiiiiiiiiiiiiii$imagePath");
  if (imagePath.startsWith('http://') || imagePath.startsWith('https://')) {
    // Network image
    return Image.network(
      imagePath,
      fit: BoxFit.contain,
      // errorBuilder: (context, error, stackTrace) {
      //   return Image.asset(
      //     'assets/icons/default_category.png',
      //     fit: BoxFit.contain,
      //   );
      // },
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                : null,
            strokeWidth: 2,
          ),
        );
      },
    );
  } else {
    // Asset image
    return Image.asset(
      imagePath,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        return Icon(
          Icons.category,
          size: 24,
          color: Colors.grey,
        );
      },
    );
  }
}

Widget _buildServicesItem({
  required String imagePath,
  required String label,
  required String serviceId,
}) {
  return GestureDetector(
    onTap: () {
      _categoryFilter(serviceName: label);
    },
    child: Container(
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
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipOval(
                child: Image.network(
                  imagePath,
                  fit: BoxFit
                      .cover, // Use cover instead of fill for better aspect ratio
                ),
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
    ),
  );
}

void _categoryFilter({required String serviceName}) {
  print('oooooooooooooooooooooooooooooooo$serviceName');
  try {
    CategoryProvider categoryProvider = CategoryProvider();
    categoryProvider.fetchCategories(serviceName: serviceName);
  } catch (e) {
    print("Errrrrrrrrrrrrrrrrrrrrrrrrrrrr$e");
  }
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
                  child: Image.network(
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CheckoutScreen()));
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
