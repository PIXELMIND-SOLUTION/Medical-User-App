import 'package:flutter/material.dart';
import 'package:medical_user_app/view/medicine_scanner_screen.dart';

// Custom painter for the curved navigation bar
class NavBarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Draw the curved path for outline only (stroke)
    Paint linePaint = Paint()
      ..color = Colors.grey.shade400 // Slightly dark gray line
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5; // Thin line

    Path curvePath = Path();
    curvePath.moveTo(0, 0);
    curvePath.lineTo(size.width * 0.2, 0);

    // Left curve
    curvePath.quadraticBezierTo(
      size.width * 0.30,
      0,
      size.width * 0.38,
      30,
    );

    // Bottom of notch
    curvePath.quadraticBezierTo(
      size.width * 0.50,
      70,
      size.width * 0.62,
      30,
    );

    // Right curve
    curvePath.quadraticBezierTo(
      size.width * 0.70,
      0,
      size.width * 0.80,
      0,
    );

    curvePath.lineTo(size.width, 0);

    canvas.drawPath(curvePath, linePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class CustomBottomNavBar extends StatefulWidget {
  const CustomBottomNavBar({Key? key}) : super(key: key);

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: [
        // Custom curved navigation bar
        Container(
          height: 80,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.8),
                spreadRadius: 0,
                blurRadius: 0,
              ),
            ],
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // Custom curved shape for the navigation bar
              CustomPaint(
                size: Size(MediaQuery.of(context).size.width, 80),
                painter: NavBarPainter(),
              ),

              // Nav bar content
              Positioned.fill(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // Home button
                    Expanded(
                      child: InkWell(
                        onTap: () => _onItemTapped(0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.home,
                              color: _selectedIndex == 0
                                  ? Color(0XFF5931DD)
                                  : Colors.grey,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Home',
                              style: TextStyle(
                                color: _selectedIndex == 0
                                    ? Color(0XFF5931DD)
                                    : Colors.grey,
                                fontWeight: _selectedIndex == 0
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Empty space for the center button
                    const Expanded(child: SizedBox()),

                    // Cart button
                    Expanded(
                      child: InkWell(
                        onTap: () => _onItemTapped(1),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.shopping_cart,
                              color: _selectedIndex == 1
                                  ? Color(0XFF5931DD)
                                  : Colors.grey,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Cart',
                              style: TextStyle(
                                color: _selectedIndex == 1
                                    ? Color(0XFF5931DD)
                                    : Colors.grey,
                                fontWeight: _selectedIndex == 1
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Center scan button (positioned outside the curve)
        Positioned(
          top: -25, // Adjust to position the button outside the curve
          child: Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: Color(0XFF5931DD),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Color(0XFF5931DD).withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 8,
                ),
              ],
            ),
            child: IconButton(
              icon: const Icon(
                Icons.crop_free,
                color: Colors.white,
                size: 32,
              ),
              onPressed: () {
                // Add scan functionality here
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const MedicineScannerScreen(),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
