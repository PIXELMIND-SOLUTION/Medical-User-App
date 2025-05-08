import 'package:flutter/material.dart';
import 'package:medical_user_app/view/pharmacy_screen.dart';
import 'package:medical_user_app/widgets/bottom_navigation.dart';

class NearPharmacyScreen extends StatelessWidget {
  const NearPharmacyScreen({super.key});

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
                        child: Column(
                          children: [
                            Icon(Icons.location_on,
                                size: 24, color: Colors.black54),
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
                            borderRadius: BorderRadius.circular(5)),
                        child: Icon(Icons.translate_outlined,
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
                            hintText: 'Search your Medicine,Pharmacy...',
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

                  // Nearby Pharmacies Section
                  Text(
                    "Nearby Pharmacies",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 16),

                  // Pharmacy List Items
                  _buildPharmacyItem(context),
                  SizedBox(height: 10),
                  _buildPharmacyItem(context),
                  SizedBox(height: 10),
                  _buildPharmacyItem(context),
                  SizedBox(height: 10),
                  _buildPharmacyItem(context),
                ],
              ),
            ),
          ),
        ),
);
  }

  Widget _buildPharmacyItem(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(width: 1,color:Color.fromARGB(255, 205, 205, 205) ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                // Pharmacy Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    'assets/pharmacy.png',
                    width: 90,
                    height: 90,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 16),

                // Pharmacy Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Apollo Pharmacy",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 16,
                            color: Colors.indigo,
                          ),
                          SizedBox(width: 4),
                          Text(
                            "Gandhi Nagar",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Arrow Icon
                IconButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>PharmacyScreen()));
                }, icon: Icon(
                  Icons.chevron_right,
                  color: Colors.grey,
                  size: 24,
                ),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
