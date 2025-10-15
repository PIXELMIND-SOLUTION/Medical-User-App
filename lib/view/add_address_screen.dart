import 'package:flutter/material.dart';

class AddAddressScreen extends StatelessWidget {
  const AddAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              // Title
              const Text(
                "Add Address",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              // Address type buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildTypeButton(Icons.add, "", true),
                  const SizedBox(width: 8),
                  _buildTypeButton(Icons.home, "Home", false),
                  const SizedBox(width: 8),
                  _buildTypeButton(Icons.work, "Office", false),
                  const SizedBox(width: 8),
                  _buildTypeButton(Icons.people, "Friend House", false),
                ],
              ),

              const SizedBox(height: 20),

              // Text fields
              _buildTextField("country", "Ma"),
              const SizedBox(height: 10),
              _buildTextField("state", "Ma"),
              const SizedBox(height: 10),
              _buildTextField("city", "Ma"),
              const SizedBox(height: 10),
              _buildTextField("pincode", "Ma"),
              const SizedBox(height: 10),
              _buildTextField("House", "Ma"),
              const SizedBox(height: 10),
              _buildTextField("street", "Ma"),

              const SizedBox(height: 20),

              // Save button
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    "Save Address",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _buildTypeButton(IconData icon, String label, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: isSelected ? Colors.white : Colors.transparent,
        border: Border.all(color: Colors.black26),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16),
          if (label.isNotEmpty) ...[
            const SizedBox(width: 4),
            Text(label, style: const TextStyle(fontSize: 14)),
          ]
        ],
      ),
    );
  }

  static Widget _buildTextField(String label, String hint) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      ),
    );
  }
}

