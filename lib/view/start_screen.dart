import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:medical_user_app/view/login_screen.dart';
import 'package:medical_user_app/view/otp_screen.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 74,
          ),
          Image.asset('assets/ad_img.png'),
          SizedBox(
            height: 20,
          ),
          Text(
            'Get Started',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            'Start with Login Or Signup',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 180,
          ),
          SizedBox(
            height: 46,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                // if (mobile.isEmpty) return;
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));

              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF5931DD),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                "Login",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
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
