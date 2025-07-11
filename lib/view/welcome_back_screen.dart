// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:medical_user_app/view/otp_screen.dart';

// class WelcomeBackScreen extends StatefulWidget {
//   const WelcomeBackScreen({super.key});

//   @override
//   State<WelcomeBackScreen> createState() => _WelcomeBackScreenState();
// }

// class _WelcomeBackScreenState extends State<WelcomeBackScreen> {
//   final mobileController = TextEditingController();

//   @override
//   void dispose() {
//     mobileController.dispose();
//     super.dispose();
//   }

//   void _getOtp() {
//     if (mobileController.text.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please enter your mobile number')),
//       );
//       return;
//     }

//     // Navigate to OTP verification screen
//     // Navigator.push(
//     //   context,
//     //   MaterialPageRoute(builder: (context) => OtpVerificationScreen(
//     //     phoneNumber: mobileController.text,
//     //   )),
//     // );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: const Text(
//           'Back',
//           style: TextStyle(
//             color: Colors.black,
//             fontSize: 16,
//             fontWeight: FontWeight.normal,
//           ),
//         ),
//         titleSpacing: -10,
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 24.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               const SizedBox(height: 20),

//               // Illustration
//               Align(
//                 alignment: Alignment.center,
//                 child: SizedBox(
//                   width: 330,
//                   height: 278,
//                   child: Image.asset("assets/welcome.png"),
//                 ),
//               ),

//               const SizedBox(height: 30),

//               // Title
//               const Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   'Welcome back',
//                   style: TextStyle(
//                     fontSize: 36,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 8),

//               // Subtitle (aligned left)
//               const Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   'Key! Good to see you again',
//                   style: TextStyle(
//                     fontSize: 16,
//                     color: Colors.black54,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),

//               const SizedBox(height: 30),

//               // Mobile Number Input
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     'Mobile Number',
//                     style: TextStyle(
//                       fontSize: 14,
//                       fontWeight: FontWeight.w500,
//                       color: Colors.black87,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   TextField(
//                     controller: mobileController,
//                     keyboardType: TextInputType.phone,
//                     inputFormatters: [
//                       FilteringTextInputFormatter.digitsOnly,
//                       LengthLimitingTextInputFormatter(10),
//                     ],
//                     decoration: InputDecoration(
//                       hintText: 'Enter your Mobile Number',
//                       hintStyle: const TextStyle(
//                         color: Colors.black38,
//                         fontSize: 14,
//                       ),
//                       filled: true,
//                       fillColor: Colors.grey.withOpacity(0.05),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8),
//                         borderSide: BorderSide.none,
//                       ),
//                       contentPadding: const EdgeInsets.symmetric(
//                         horizontal: 16,
//                         vertical: 16,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),

//               const SizedBox(height: 30),

//               // Get OTP Button
//               SizedBox(
//                 width: double.infinity,
//                 height: 50,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     Navigator.push(context,
//                         MaterialPageRoute(builder: (context) => OtpScreen()));
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xFF5E35B1),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     elevation: 0,
//                   ),
//                   child: const Text(
//                     'Get OTP',
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 30),

//               // Or divider
//               Row(
//                 children: [
//                   Expanded(
//                     child: Container(
//                       height: 1,
//                       color: Colors.grey.withOpacity(0.3),
//                     ),
//                   ),
//                   const Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 16.0),
//                     child: Text(
//                       'Or',
//                       style: TextStyle(
//                         color: Colors.grey,
//                         fontSize: 14,
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     child: Container(
//                       height: 1,
//                       color: Colors.grey.withOpacity(0.3),
//                     ),
//                   ),
//                 ],
//               ),

//               const SizedBox(height: 30),

//               // Social Login buttons
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   _socialLoginButton('assets/icons/google.png', () {}),
//                   const SizedBox(width: 24),
//                   _socialLoginButton('assets/icons/facebook.png', () {}),
//                   const SizedBox(width: 24),
//                   _socialLoginButton('assets/icons/x.png', () {}),
//                 ],
//               ),

//               const SizedBox(height: 30),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _socialLoginButton(String assetName, VoidCallback onPressed) {
//     return InkWell(
//       onTap: onPressed,
//       child: Container(
//         width: 34,
//         height: 34,
//         decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           border: Border.all(
//             color: Colors.grey.withOpacity(0.3),
//             width: 1,
//           ),
//         ),
//         child: Center(
//           child: Image.asset(
//             assetName,
//             width: 24, // Adjust the size based on your needs
//             height: 24, // Adjust the size based on your needs
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildFallbackIllustration() {
//     return SizedBox(
//       width: 220,
//       height: 220,
//       child: Stack(
//         alignment: Alignment.center,
//         children: [
//           // Phone outline
//           Container(
//             width: 100,
//             height: 180,
//             decoration: BoxDecoration(
//               color: Colors.indigo.shade100,
//               borderRadius: BorderRadius.circular(12),
//               border: Border.all(color: Colors.indigo.shade900, width: 2),
//             ),
//           ),

//           // Phone screen
//           Positioned(
//             top: 40,
//             child: Container(
//               width: 80,
//               height: 120,
//               decoration: BoxDecoration(
//                 color: Colors.indigo.shade800,
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   // User icon
//                   Container(
//                     padding: const EdgeInsets.all(8),
//                     decoration: const BoxDecoration(
//                       color: Colors.white,
//                       shape: BoxShape.circle,
//                     ),
//                     child: const Icon(
//                       Icons.person,
//                       color: Colors.indigo,
//                       size: 20,
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                   // Password field
//                   Container(
//                     width: 60,
//                     height: 10,
//                     color: Colors.white60,
//                   ),
//                   const SizedBox(height: 10),
//                   // Lock icon
//                   const Icon(
//                     Icons.lock,
//                     color: Colors.white,
//                     size: 20,
//                   ),
//                 ],
//               ),
//             ),
//           ),

//           // Person figure
//           Positioned(
//             left: 30,
//             bottom: 40,
//             child: Column(
//               children: [
//                 Container(
//                   width: 20,
//                   height: 20,
//                   decoration: const BoxDecoration(
//                     color: Colors.black,
//                     shape: BoxShape.circle,
//                   ),
//                 ),
//                 Container(
//                   width: 40,
//                   height: 60,
//                   decoration: BoxDecoration(
//                     color: Colors.lightBlue,
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           // Shield
//           Positioned(
//             right: 40,
//             bottom: 30,
//             child: Container(
//               width: 40,
//               height: 50,
//               decoration: const BoxDecoration(
//                 color: Colors.blue,
//                 shape: BoxShape.circle,
//               ),
//               child: const Icon(
//                 Icons.check,
//                 color: Colors.white,
//                 size: 24,
//               ),
//             ),
//           ),

//           // Gear icons
//           Positioned(
//             right: 30,
//             top: 30,
//             child: Icon(
//               Icons.settings,
//               color: Colors.grey.shade700,
//               size: 24,
//             ),
//           ),
//           Positioned(
//             right: 60,
//             top: 60,
//             child: Icon(
//               Icons.settings,
//               color: Colors.grey.shade700,
//               size: 16,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }









import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:medical_user_app/view/otp_screen.dart';
import 'package:medical_user_app/view/home_screen.dart';
import 'package:medical_user_app/providers/auth_provider.dart';

class WelcomeBackScreen extends StatefulWidget {
  const WelcomeBackScreen({super.key});

  @override
  State<WelcomeBackScreen> createState() => _WelcomeBackScreenState();
}

class _WelcomeBackScreenState extends State<WelcomeBackScreen> {
  final mobileController = TextEditingController();
  bool _isValidPhoneNumber = false;

  @override
  void initState() {
    super.initState();
    mobileController.addListener(_validatePhoneNumber);
    
    // Listen to auth state changes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      authProvider.addListener(_handleAuthStateChange);
    });
  }

  void _validatePhoneNumber() {
    setState(() {
      _isValidPhoneNumber = mobileController.text.length == 10;
    });
  }

  void _handleAuthStateChange() {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    
    if (authProvider.isAuthenticated && mounted) {
      // User successfully logged in, navigate to home
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
        (route) => false,
      );
    }
  }

  @override
  void dispose() {
    mobileController.removeListener(_validatePhoneNumber);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    authProvider.removeListener(_handleAuthStateChange);
    mobileController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_isValidPhoneNumber) {
      _showErrorSnackBar('Please enter a valid 10-digit mobile number');
      return;
    }

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    
    try {
      final success = await authProvider.login(mobile: mobileController.text);
      
      if (success) {
        // Success handled by listener
        _showSuccessSnackBar('Otp Send successful!');
        Navigator.push(context, MaterialPageRoute(builder: (context)=>OtpScreen()));
      } else {
        // Show error message from provider
        _showErrorSnackBar(authProvider.errorMessage.isNotEmpty 
          ? authProvider.errorMessage 
          : 'Login failed. Please try again.');
      }
    } catch (e) {
      _showErrorSnackBar('An error occurred. Please try again.');
    }
  }

  void _showErrorSnackBar(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void _showSuccessSnackBar(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void _showComingSoonDialog(String feature) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(feature),
          content: Text('$feature is coming soon!'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'OK',
                style: TextStyle(color: Color(0xFF5E35B1)),
              ),
            ),
          ],
        );
      },
    );
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

              // Illustration
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: 330,
                  height: 278,
                  child: Image.asset("assets/welcome.png"),
                ),
              ),

              const SizedBox(height: 30),

              // Title
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Welcome back',
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
                  'Hey! Good to see you again',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
              ),
              const SizedBox(height: 50),

              // Mobile Number Input
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Mobile Number',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: mobileController,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(10),
                    ],
                    decoration: InputDecoration(
                      hintText: 'Enter your Mobile Number',
                      hintStyle: const TextStyle(
                        color: Colors.black38,
                        fontSize: 14,
                      ),
                      filled: true,
                      fillColor: Colors.grey.withOpacity(0.05),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: _isValidPhoneNumber 
                            ? Colors.green.withOpacity(0.3)
                            : Colors.grey.withOpacity(0.3),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: Color(0xFF5E35B1),
                          width: 2,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      suffixIcon: _isValidPhoneNumber
                        ? const Icon(Icons.check_circle, color: Colors.green)
                        : null,
                    ),
                  ),
                  if (mobileController.text.isNotEmpty && !_isValidPhoneNumber)
                    const Padding(
                      padding: EdgeInsets.only(top: 4),
                      child: Text(
                        'Please enter a valid 10-digit mobile number',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 12,
                        ),
                      ),
                    ),
                ],
              ),

              const SizedBox(height: 30),

              // Login Button with loading state
              Consumer<AuthProvider>(
                builder: (context, authProvider, child) {
                  return SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: authProvider.isLoading || !_isValidPhoneNumber 
                        ? null 
                        : _handleLogin,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF5E35B1),
                        disabledBackgroundColor: Colors.grey.shade300,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 0,
                      ),
                      child: authProvider.isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : const Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 20),

              // Alternative OTP option
              // Consumer<AuthProvider>(
              //   builder: (context, authProvider, child) {
              //     return TextButton(
              //       onPressed: authProvider.isLoading 
              //         ? null 
              //         : () {
              //             if (!_isValidPhoneNumber) {
              //               _showErrorSnackBar('Please enter a valid mobile number first');
              //               return;
              //             }
              //             Navigator.push(
              //               context,
              //               MaterialPageRoute(
              //                 builder: (context) => OtpScreen(
              //                   phoneNumber: mobileController.text,
              //                 ),
              //               ),
              //             );
              //           },
              //       child: const Text(
              //         'Or verify with OTP instead',
              //         style: TextStyle(
              //           color: Color(0xFF5E35B1),
              //           fontSize: 14,
              //         ),
              //       ),
              //     );
              //   },
              // ),

              const SizedBox(height: 20),

              // Error message display
              // Consumer<AuthProvider>(
              //   builder: (context, authProvider, child) {
              //     if (authProvider.state == AuthState.error) {
              //       return Container(
              //         width: double.infinity,
              //         padding: const EdgeInsets.all(12),
              //         margin: const EdgeInsets.only(bottom: 20),
              //         decoration: BoxDecoration(
              //           color: Colors.red.shade50,
              //           borderRadius: BorderRadius.circular(8),
              //           border: Border.all(color: Colors.red.shade200),
              //         ),
              //         child: Row(
              //           children: [
              //             Icon(Icons.error_outline, color: Colors.red.shade600, size: 20),
              //             const SizedBox(width: 8),
              //             Expanded(
              //               child: Text(
              //                 authProvider.errorMessage,
              //                 style: TextStyle(
              //                   color: Colors.red.shade600,
              //                   fontSize: 14,
              //                 ),
              //               ),
              //             ),
              //             IconButton(
              //               onPressed: () => authProvider.clearError(),
              //               icon: Icon(Icons.close, color: Colors.red.shade600, size: 16),
              //               padding: EdgeInsets.zero,
              //               constraints: const BoxConstraints(),
              //             ),
              //           ],
              //         ),
              //       );
              //     }
              //     return const SizedBox.shrink();
              //   },
              // ),

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

              const SizedBox(height: 30),

              // Social Login buttons
              Consumer<AuthProvider>(
                builder: (context, authProvider, child) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _socialLoginButton(
                        'assets/icons/google.png', 
                        authProvider.isLoading ? null : () => _showComingSoonDialog('Google Login'),
                        authProvider.isLoading,
                      ),
                      const SizedBox(width: 24),
                      _socialLoginButton(
                        'assets/icons/facebook.png', 
                        authProvider.isLoading ? null : () => _showComingSoonDialog('Facebook Login'),
                        authProvider.isLoading,
                      ),
                      const SizedBox(width: 24),
                      _socialLoginButton(
                        'assets/icons/x.png', 
                        authProvider.isLoading ? null : () => _showComingSoonDialog('X Login'),
                        authProvider.isLoading,
                      ),
                    ],
                  );
                },
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _socialLoginButton(String assetName, VoidCallback? onPressed, bool isDisabled) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 34,
        height: 34,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: isDisabled 
              ? Colors.grey.withOpacity(0.1)
              : Colors.grey.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Center(
          child: Opacity(
            opacity: isDisabled ? 0.5 : 1.0,
            child: Image.asset(
              assetName,
              width: 24,
              height: 24,
            ),
          ),
        ),
      ),
    );
  }
}