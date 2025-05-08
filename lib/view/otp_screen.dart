import 'package:flutter/material.dart';
import 'package:medical_user_app/view/signup_screen.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final List<TextEditingController> _controllers = List.generate(
    4,
    (index) => TextEditingController(),
  );

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
              height: 595,
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
                  const SizedBox(height: 10),
                  const Text(
                    "OTP Verification",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Center(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('assets/profile.png'),
                    ),
                  ),
                  const SizedBox(height: 50),
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      "We have sent a verification code to your phone\nat 123456789",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                  ),
                  const SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(4, (index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        width: 40,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          maxLength: 1,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: InputDecoration(
                            counterText: "",
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 2,
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors
                                    .orange, // Optional: highlight color on focus
                                width: 2,
                              ),
                            ),
                            isCollapsed: true,
                            contentPadding: EdgeInsets.zero,
                          ),
                          readOnly: index == 0,
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 18),
                  Align(
                    alignment: Alignment.topRight,
                    child: RichText(
                      text: const TextSpan(
                        style: TextStyle(fontSize: 14, color: Colors.black54),
                        children: [
                          TextSpan(
                            text: "Resend OTP",
                            style: TextStyle(
                              color: Color(0XFF7F7F7F),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                      height: 46,
                      width: 350,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>SignupScreen()));
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
                              'Verify',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      )),
                      SizedBox(height: 20,),
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
                  SizedBox(height: 20,),
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
