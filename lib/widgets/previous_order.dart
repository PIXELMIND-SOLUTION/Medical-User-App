import 'package:flutter/material.dart';

class MedicationOrdersList extends StatelessWidget {
  const MedicationOrdersList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Sample medication data
    final List<Map<String, dynamic>> medications = [
      {
        'name': 'DOLO 500',
        'price': '₹250',
        'pharmacy': 'Appolo Pharmacy',
        'location': 'Kakinada',
        'status': 'Delivered',
        'image': 'assets/tablet.png',
      },
      {
        'name': 'Paracetamol 500',
        'price': '₹120',
        'pharmacy': 'MedPlus',
        'location': 'Hyderabad',
        'status': 'Delivered',
        'image': 'assets/tablet.png',
      },
      {
        'name': 'Aspirin 300',
        'price': '₹180',
        'pharmacy': 'Wellness Forever',
        'location': 'Mumbai',
        'status': 'Delivered',
        'image': 'assets/tablet.png',
      },
    ];

    return Container(
      width: double.infinity,
      height: 190, // Adjust based on your card height
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: medications.length,
        itemBuilder: (context, index) {
          final medication = medications[index];
          return Container(
            width: 303,
            height: 163,
            margin: EdgeInsets.all(5), // Fixed width for each card
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Colors.grey.shade300, width: 2
              )
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top section with image, name, and price
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Medicine Image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          medication['image'],
                          width: 75,
                          height: 75,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Name and pharmacy details
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              medication['name'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              medication['pharmacy'],
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 4),
                            // Location with icon
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: Color(0xFF5931DD),
                                  size: 16,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  medication['location'],
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: 5,),
                            // Status with icon
                            Row(
                              children: [
                                Icon(
                                  Icons.access_time_rounded,
                                  color: Colors.grey[600],
                                  size: 16,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  medication['status'],
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // Price
                      Text(
                        medication['price'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Buttons
                  Row(
                    children: [
                      // Re-Order Button
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF5931DD),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 12),
                          ),
                          child: Text(
                            'Re-Order',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Details Button
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Color(0xFF5931DD),
                            side: BorderSide(color: Color(0xFF5931DD)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 12),
                          ),
                          child: Text(
                            'Details',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}