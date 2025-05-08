import 'package:flutter/material.dart';
import 'package:medical_user_app/view/login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingContent> _contents = [
    OnboardingContent(
      image: 'assets/ad_img.png',
      title: 'Order Medicines To\nYour Door Steps',
      description: 'Get your medications delivered straight to your doorstep with just a few taps',
    ),
    OnboardingContent(
      image: 'assets/ad_img.png',
      title: 'Consult With\nSpecialists Online',
      description: 'Connect with healthcare professionals anytime, anywhere through secure video calls',
    ),
    OnboardingContent(
      image: 'assets/ad_img.png',
      title: 'Track Your\nHealth Progress',
      description: 'Monitor your health metrics and medication schedules all in one place',
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToLoginScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: _goToLoginScreen,
                  child: const Text(
                    'Skip',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF5931DD),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (value) {
                  setState(() {
                    _currentPage = value;
                  });
                },
                itemCount: _contents.length,
                itemBuilder: (context, index) {
                  return OnboardingPage(
                    content: _contents[index],
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 60),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _contents.length,
                      (index) => _buildDotIndicator(index),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: const Color(0xFF5931DD),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: IconButton(
                      onPressed: () {
                        if (_currentPage == _contents.length - 1) {
                          _goToLoginScreen();
                        } else {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                      icon: const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDotIndicator(int index) {
    return Container(
      height: 10,
      width: _currentPage == index ? 25 : 10,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: _currentPage == index
            ? const Color(0xFF5931DD)
            : const Color(0xFFD9D9D9),
      ),
    );
  }
}

class OnboardingContent {
  final String image;
  final String title;
  final String description;

  OnboardingContent({
    required this.image,
    required this.title,
    required this.description,
  });
}

class OnboardingPage extends StatelessWidget {
  final OnboardingContent content;

  const OnboardingPage({
    super.key,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: Image.asset(
              content.image,
              fit: BoxFit.contain,
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Text(
                  content.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  content.description,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}