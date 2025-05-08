import 'package:flutter/material.dart';

class ChangeAddressScreen extends StatefulWidget {
  const ChangeAddressScreen({Key? key}) : super(key: key);

  @override
  State<ChangeAddressScreen> createState() => _ChangeAddressScreenState();
}

class _ChangeAddressScreenState extends State<ChangeAddressScreen> {
  // Sample saved locations
  final List<String> savedLocations = [
    'Kakinada',
    'Hyderabad',
    'Kakinada',
    'Hyderabad'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Change Address',
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
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30,),
            // Search Bar
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 12),
                  Icon(
                    Icons.search,
                    color: Colors.grey[600],
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Search your City',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Choose Location on Map Button
            Container(
              width: 230,
              height: 36,
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color.fromARGB(255, 187, 187, 187))
              ),
              child: const Row(
                children: [
                  Icon(Icons.my_location, size: 18),
                  SizedBox(width: 16),
                  Text(
                    'Choose Location On Map',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20,),

            const Divider(),

            // Saved Locations List
            Expanded(
              child: ListView.builder(
                itemCount: savedLocations.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ListTile(
                        contentPadding: const EdgeInsets.symmetric(vertical: 1),
                        leading:
                            const Icon(Icons.location_on_outlined, color: Colors.black),
                        title: Text(
                          savedLocations[index],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        onTap: () {
                          // Handle location selection
                        },
                      ),
                      const Divider(),
                    ],
                  );
                },
              ),
            ),

            // Save Button
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    // Save action would go here
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6A3DE8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Save',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
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
}
