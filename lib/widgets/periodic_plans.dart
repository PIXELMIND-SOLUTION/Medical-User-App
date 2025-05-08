import 'package:flutter/material.dart';

class PeriodicMedsPlanCardSimple extends StatelessWidget {
  const PeriodicMedsPlanCardSimple({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 160,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none, // Allow overflow for buttons
        children: [
          // Purple curved background
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            child: ClipPath(
              clipper: CurvedClipper(),
              child: Container(
                width: 150,
                decoration: const BoxDecoration(
                  color: Color(0xFF5931DD),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Image.asset(
                      'assets/doctor.png',
                      width: 80,
                      height: 80,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Content (text + buttons)
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Periodic Meds",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                const Text(
                  "Plan",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),

                // Buttons row (without limiting width too much)
                Row(
                  children: [
                    // Activate button
                    Expanded(
                      flex: 5,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF5931DD),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        child: const Text(
                          "Activate",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),

                    // Details button (allow overlap)
                    Expanded(
                      flex: 4,
                      child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xFF5931DD)),
                          foregroundColor: const Color(0xFF5931DD),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          backgroundColor: Colors.white,
                          elevation: 0,
                        ),
                        child: const Text(
                          "Details",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
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
}

class CurvedClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    path.moveTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.quadraticBezierTo(
      size.width * 0.3, size.height * 0.85,
      size.width * 0.2, size.height * 0.5,
    );
    path.quadraticBezierTo(
      size.width * 0.3, size.height * 0.15,
      size.width, 0,
    );
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
