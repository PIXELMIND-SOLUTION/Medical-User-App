import 'package:flutter/material.dart';
import 'package:medical_user_app/view/scanned_medicine_screen.dart';
import 'package:medical_user_app/widgets/bottom_navigation.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'dart:ui';

void main() {
  runApp(const MedicineScannerApp());
}

class MedicineScannerApp extends StatelessWidget {
  const MedicineScannerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MedicineScannerScreen(),
    );
  }
}

class MedicineScannerScreen extends StatefulWidget {
  const MedicineScannerScreen({super.key});

  @override
  State<MedicineScannerScreen> createState() => _MedicineScannerScreenState();
}

class _MedicineScannerScreenState extends State<MedicineScannerScreen>
    with SingleTickerProviderStateMixin {
  late MobileScannerController scannerController;
  bool _isScanning = true;
  String? _scannedResult;

  // Animation controller for the scanning line
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    scannerController = MobileScannerController(
      detectionSpeed: DetectionSpeed.normal,
      facing: CameraFacing.back,
    );

    // Initialize animation controller
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true); // Makes the animation go back and forth

    // Create animation that moves from top (0.0) to bottom (1.0) of container
    _animation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    scannerController.dispose();
    super.dispose();
  }

  void _onBarcodeDetected(BarcodeCapture capture) {
    final List<Barcode> barcodes = capture.barcodes;
    if (barcodes.isNotEmpty && _isScanning) {
      setState(() {
        _isScanning = false; // Stop multiple triggers
        _scannedResult = barcodes.first.rawValue ?? 'Unknown';
      });

      // Resume scanning after short delay (optional)
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          _isScanning = true;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/background_image.png',
              fit: BoxFit.cover,
            ),
          ),

          // Blur effect on top of image
          Positioned.fill(
            child: BackdropFilter(
              filter:
                  ImageFilter.blur(sigmaX: 83.6, sigmaY: 83.6), // heavy blur
              child: Container(
                color: Colors.black
                    .withOpacity(0), // Required for BackdropFilter to work
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                // Top toolbar
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 18.0, vertical: 12.0),
                  child: Container(
                    height: 44,
                    width: 343,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10), // <-- added this
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.flash_on, color: Colors.blue),
                          onPressed: () {
                            scannerController.toggleTorch();
                          },
                        ),
                        const Icon(Icons.photo_library, color: Colors.purple),
                        const Icon(Icons.sync, color: Colors.black54),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 10.0),

                const Text(
                  'Scan the Medicine',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),

                const SizedBox(height: 20.0),

                // Scanner View Area
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Container(
                    height: 320,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: MobileScanner(
                            controller: scannerController,
                            onDetect: _onBarcodeDetected,
                          ),
                        ),

                        // Animated scanning line
                        AnimatedBuilder(
                          animation: _animation,
                          builder: (context, child) {
                            return Positioned(
                              top: _animation.value *
                                  270, // Adjust the multiplier to control the range of motion
                              child: Container(
                                width: 280,
                                height: 5,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.greenAccent.withOpacity(0.7),
                                      Colors.green.withOpacity(0.7)
                                    ],
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                          Colors.greenAccent.withOpacity(0.5),
                                      blurRadius: 12,
                                      spreadRadius: 2,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),

                        // Scanner corners
                        _buildCorner(Alignment.topLeft),
                        _buildCorner(Alignment.topRight),
                        _buildCorner(Alignment.bottomLeft),
                        _buildCorner(Alignment.bottomRight),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20.0),

                SizedBox(
                  height: 36,
                  width: 160,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black87,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: const Text(
                      'Cancel Scanning',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),

                SizedBox(height: 20,),

                // Display scan result if available
                if (_scannedResult != null)
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 24.0, vertical: 10.0),
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: const DecorationImage(
                              image: AssetImage(
                                  'assets/tablet.png'), // Your asset image here
                              fit: BoxFit
                                  .cover, // Or BoxFit.fill depending on your image
                            ),
                          ),
                          child: const Icon(
                            Icons.medication_outlined,
                            color: Colors.blue,
                            size: 30,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'DOLO 500\nparacetamol',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on_outlined,
                                    color: Colors.deepPurple,
                                  ),
                                  Text("Kakinada")
                                ],
                              )
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.arrow_forward_ios, size: 16),
                          onPressed: () {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ScannedMedicineScreen()));
                          },
                        ),
                      ],
                    ),
                  ),

                const Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to create corners
  Widget _buildCorner(Alignment alignment) {
    return Align(
      alignment: alignment,
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          border: Border(
            top: (alignment == Alignment.topLeft ||
                    alignment == Alignment.topRight)
                ? BorderSide(color: Colors.black, width: 3)
                : BorderSide.none,
            bottom: (alignment == Alignment.bottomLeft ||
                    alignment == Alignment.bottomRight)
                ? BorderSide(color: Colors.black, width: 3)
                : BorderSide.none,
            left: (alignment == Alignment.topLeft ||
                    alignment == Alignment.bottomLeft)
                ? BorderSide(color: Colors.black, width: 3)
                : BorderSide.none,
            right: (alignment == Alignment.topRight ||
                    alignment == Alignment.bottomRight)
                ? BorderSide(color: Colors.black, width: 3)
                : BorderSide.none,
          ),
        ),
      ),
    );
  }
}
