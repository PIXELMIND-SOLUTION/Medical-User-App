import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final invitationController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    mobileController.dispose();
    invitationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Back',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.normal,
          ),
        ),
        titleSpacing: -10,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),

              // Center the image using Align
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: 150,
                  height: 173.5,
                  child: Image.asset("assets/signup.png"),
                ),
              ),
              const SizedBox(height: 16),

              // Title (aligned left)
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Signup Account',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 8),

              // Subtitle (aligned left)
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Hello! Let\'s Join with Us',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Name Field
              _buildInputField(
                label: 'Name',
                hint: 'Enter your Name',
                controller: nameController,
              ),
              const SizedBox(height: 5),

              // Mobile Number Field
              _buildInputField(
                label: 'Mobile Number',
                hint: 'Enter your Mobile Number',
                controller: mobileController,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 5),

              // Invitation Code Field
              _buildInputField(
                label: 'Invitation Code ( Optional )',
                hint: 'Enter Invitation Code',
                controller: invitationController,
              ),
              const SizedBox(height: 20),

              // Signup Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    // Handle signup logic
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF5E35B1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Signup',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Or divider
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 1,
                      color: Colors.grey.withOpacity(0.3),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'Or',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 1,
                      color: Colors.grey.withOpacity(0.3),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),

              // Social Login buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _socialLoginButton('assets/icons/google.png', () {}),
                  const SizedBox(width: 24),
                  _socialLoginButton('assets/icons/facebook.png', () {}),
                  const SizedBox(width: 24),
                  _socialLoginButton('assets/icons/x.png', () {}),
                ],
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required String hint,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(
              color: Colors.black38,
              fontSize: 14,
            ),
            filled: true,
            fillColor: Colors.grey.withOpacity(0.05),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
        ),
      ],
    );
  }

  Widget _socialLoginButton(String assetName, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 34,
        height: 34,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.grey.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Center(
          child: Image.asset(
            assetName,
            width: 24, // Adjust the size based on your needs
            height: 24, // Adjust the size based on your needs
          ),
        ),
      ),
    );
  }
}
