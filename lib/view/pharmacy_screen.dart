import 'package:flutter/material.dart';
import 'package:medical_user_app/view/cart_screen.dart';
import 'package:medical_user_app/widgets/bottom_navigation.dart';

class PharmacyScreen extends StatefulWidget {
  const PharmacyScreen({super.key});

  @override
  State<PharmacyScreen> createState() => _PharmacyScreenState();
}

class _PharmacyScreenState extends State<PharmacyScreen> {
  int _selectedCategoryIndex = 0;

  final List<Map<String, dynamic>> _categories = [
    {'icon': Icons.medication_outlined, 'title': 'Tablets'},
    {'icon': Icons.baby_changing_station_outlined, 'title': 'Baby Care'},
    {'icon': Icons.medical_services_outlined, 'title': 'Syrups'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildPharmacyHeader(),
                SizedBox(
                  height: 24,
                ),
                _buildSearchBar(),
                SizedBox(
                  height: 24,
                ),
                const Text(
                  "Categories",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildCategoryItem(
                      imagePath: 'assets/icons/tablets.png',
                      label: "Tablets",
                      isSelected: true,
                    ),
                    _buildCategoryItem(
                      imagePath: 'assets/icons/babyCare.png',
                      label: "Baby\ncare",
                    ),
                    _buildCategoryItem(
                      imagePath: 'assets/icons/syrup.png',
                      label: "Syrup",
                    ),
                    _buildCategoryItem(
                      imagePath: 'assets/icons/tablets.png',
                      label: "Tablets",
                    ),
                  ],
                ),
                SizedBox(
                  height: 24,
                ),
                _buildSectionTitle(),
                _buildAllMedicineCardGrid(),
              ],
            ),
          ),
        ),
);
  }

  Widget _buildPharmacyHeader() {
    return Container(
      height: 246,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0XFFEFF3F7),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade100,
            blurRadius: 5,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              InkWell(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.arrow_back_ios_new, size: 18),
                ),
              ),
              const Spacer(),
              Container(
                padding: EdgeInsets.all(8),
                child: Column(
                  children: [
                    Icon(Icons.location_on, size: 24, color: Colors.black54),
                    Text(
                      "Kakinada",
                      style: TextStyle(fontSize: 10),
                    )
                  ],
                ),
              ),
              SizedBox(width: 12),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.grey[100],
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
                child: Icon(Icons.translate_outlined,
                    size: 24, color: Colors.black54),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    'assets/pharmacy.png',
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Apollo\nPharmacy',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.location_on,
                            size: 16, color: Colors.indigo.shade700),
                        const SizedBox(width: 4),
                        Text(
                          'Gandhi nagar, Kakinada',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAllMedicineCardGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        childAspectRatio: 0.65,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        children: List.generate(
          4,
          (index) => _buildMedicineCardItem(),
        ),
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
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>CartScreen()));
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

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              height: 48,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                children: [
                  Icon(Icons.search, color: Colors.grey.shade600),
                  const SizedBox(width: 8),
                  Text(
                    'Search Medicine,Pharmacy...',
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              color: const Color(0xFF6434E0),
              borderRadius: BorderRadius.circular(24),
            ),
            child: const Icon(
              Icons.mic,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryItem({
    required String imagePath,
    required String label,
    bool isSelected = false,
  }) {
    return Container(
      width: 75,
      height: 96,
      decoration: BoxDecoration(
          color: Color(0XFFEFF3F7),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
              color: isSelected
                  ? Colors.black
                  : const Color.fromARGB(255, 188, 188, 188))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 42,
                height: 42,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30)),
                child: Image.asset(
                  imagePath,
                  width: 28,
                  height: 28,
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
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: const Color.fromARGB(
                      255, 0, 0, 0), // Color white if selected
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

  Widget _buildCategorySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
          child: Text(
            'Category',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _categories.length,
            itemBuilder: (context, index) {
              final category = _categories[index];
              final bool isSelected = _selectedCategoryIndex == index;

              return Container(
                width: 90,
                margin: const EdgeInsets.only(right: 12),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedCategoryIndex = index;
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: isSelected
                                ? Colors.red.shade300
                                : Colors.grey.shade300,
                          ),
                          borderRadius: BorderRadius.circular(16),
                          color: isSelected
                              ? const Color(0xFFFFECEC)
                              : Colors.white,
                        ),
                        child: Icon(
                          category['icon'],
                          color: isSelected
                              ? Colors.red.shade300
                              : Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        category['title'],
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Text(
            _categories[_selectedCategoryIndex]['title'],
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
