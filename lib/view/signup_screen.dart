import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:medical_user_app/view/home_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Color(0xFFE87722),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 579,
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Sign Up',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: 342,
                    height: 48,
                    child: TextField(
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        hintText: "Enter your name",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: 342,
                    height: 48,
                    child: TextField(
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        hintText: "Enter your mobile number",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: 342,
                    height: 48,
                    child: TextField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: "Enter Email",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 60),
                  SizedBox(
                      height: 46,
                      width: 350,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()));
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero, // remove default padding
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 4,
                          backgroundColor:
                              Colors.transparent, // important for gradient
                          shadowColor: Colors.black.withOpacity(0.3),
                        ),
                        child: Ink(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFFE33629), // Red shade
                                Color(0xFFE87F2D), // Orange shade
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            constraints: const BoxConstraints(
                                minWidth: 120, minHeight: 48),
                            child: const Text(
                              'Signup',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(child: Divider(thickness: 1)),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Text('Or'),
                      ),
                      Expanded(child: Divider(thickness: 1)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildSocialIcon(
                        'https://cdn-icons-png.flaticon.com/512/2991/2991148.png',
                        onPressed: () {},
                      ),
                      const SizedBox(width: 16),
                      _buildSocialIcon(
                        'https://img.freepik.com/premium-vector/x-new-social-network-black-app-icon-twitter-rebranded-as-x-twitter-s-logo-was-changed_277909-568.jpg?semt=ais_hybrid&w=740',
                        onPressed: () {},
                      ),
                      const SizedBox(width: 16),
                      _buildSocialIcon(
                        'https://cdn-icons-png.flaticon.com/512/5968/5968764.png',
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialIcon(String imageUrl, {required VoidCallback onPressed}) {
    return CircleAvatar(
      backgroundColor: const Color.fromARGB(255, 255, 251, 251),
      radius: 25,
      child: IconButton(
        onPressed: onPressed,
        icon: Image.network(
          imageUrl,
          width: 28,
          height: 28,
        ),
      ),
    );
  }
}
