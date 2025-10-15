// import 'package:flutter/material.dart';
// import 'package:medical_user_app/providers/auth_provider.dart';
// import 'package:medical_user_app/providers/language_provider.dart';
// import 'package:medical_user_app/view/change_address_screen.dart';
// import 'package:medical_user_app/view/login_screen.dart';
// import 'package:medical_user_app/view/order_hystory_screen.dart';
// import 'package:medical_user_app/view/personal_information_screen.dart';
// import 'package:provider/provider.dart';

// class ProfileScreen extends StatelessWidget {
//   const ProfileScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[50],
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Profile Header
//               Row(
//                 children: [
//                   // Profile Image
//                   Container(
//                     width: 40,
//                     height: 40,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: Colors.amber,
//                       image: DecorationImage(
//                         image: AssetImage('assets/profile.png'),
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   // Profile Text
//                   const AppText(
//                     'profile',
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ],
//               ),

//               const SizedBox(height: 16),

//               // Account Text
//               AppText(
//                 'account',
//                 style: TextStyle(
//                   fontSize: 14,
//                   color: Colors.blue[700],
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),

//               const SizedBox(height: 8),

//               // Personal Information
//               _buildMenuTile(
//                 context: context,
//                 title: 'personal_information',
//                 icon: Icons.person_outline,
//                 iconColor: Colors.blue[700],
//                 onTap: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (_) => PersonalInformationScreen()));
//                 },
//               ),

//               // Change Address
//               _buildMenuTile(
//                 context: context,
//                 title: 'change_address',
//                 icon: Icons.location_on_outlined,
//                 iconColor: Colors.grey[600],
//                 onTap: () {
//                   Navigator.push(context,
//                       MaterialPageRoute(builder: (_) => ChangeAddressScreen()));
//                 },
//               ),

//               // Order History
//               _buildMenuTile(
//                 context: context,
//                 title: 'order_history',
//                 icon: Icons.history,
//                 iconColor: Colors.grey[600],
//                 onTap: () {
//                   Navigator.push(context,
//                       MaterialPageRoute(builder: (_) => OrdersHistoryScreen()));
//                 },
//               ),

//               // Periodic Meds Plan
//               _buildMenuTile(
//                 context: context,
//                 title: 'periodic_plan',
//                 icon: Icons.calendar_today_outlined,
//                 iconColor: Colors.grey[600],
//                 onTap: () {},
//               ),

//               const SizedBox(height: 16),

//               // Account Text (second)
//               AppText(
//                 'account',
//                 style: TextStyle(
//                   fontSize: 14,
//                   color: Colors.grey[700],
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),

//               const SizedBox(height: 8),

//               // Need Help?
//               _buildMenuTile(
//                 context: context,
//                 title: 'need_help',
//                 icon: Icons.help_outline,
//                 iconColor: Colors.grey[600],
//                 onTap: () {},
//               ),

//               // Contact Us
//               _buildMenuTile(
//                 context: context,
//                 title: 'contact_us',
//                 icon: Icons.phone_outlined,
//                 iconColor: Colors.grey[600],
//                 onTap: () {},
//               ),

//               // Logout
//               _buildMenuTile(
//                 context: context,
//                 title: 'logout',
//                 icon: Icons.logout,
//                 iconColor: Colors.red,
//                 titleColor: Colors.red,
//                 onTap: () async {
//                   await Provider.of<AuthProvider>(context, listen: false)
//                       .logout();
//                   Navigator.pushAndRemoveUntil(
//                     context,
//                     MaterialPageRoute(builder: (_) => LoginScreen()),
//                     (route) => false, // This removes all previous routes
//                   );
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildMenuTile({
//     required BuildContext context,
//     required String title,
//     required IconData icon,
//     required Function onTap,
//     Color? iconColor,
//     Color? titleColor,
//   }) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 8),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: Colors.grey.shade200),
//       ),
//       child: ListTile(
//         leading: Icon(
//           icon,
//           color: iconColor ?? Colors.grey[600],
//           size: 22,
//         ),
//         title: AppText(
//           title,
//           style: TextStyle(
//             fontSize: 14,
//             fontWeight: FontWeight.w500,
//             color: titleColor ?? Colors.black87,
//           ),
//         ),
//         trailing: Icon(
//           Icons.chevron_right,
//           color: Colors.grey[400],
//           size: 22,
//         ),
//         minLeadingWidth: 20,
//         contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
//         onTap: () => onTap(),
//       ),
//     );
//   }
// }



// ignore_for_file: use_build_context_synchronously

// import 'package:flutter/material.dart';
// import 'package:medical_user_app/providers/auth_provider.dart';
// import 'package:medical_user_app/providers/profile_provider.dart';
// import 'package:medical_user_app/providers/language_provider.dart';
// import 'package:medical_user_app/view/addquery/add_query_screen.dart';
// import 'package:medical_user_app/view/change_address_screen.dart';
// import 'package:medical_user_app/view/detail/periodic_detail.dart';
// import 'package:medical_user_app/view/login_screen.dart';
// import 'package:medical_user_app/view/order_hystory_screen.dart';
// import 'package:medical_user_app/view/personal_information_screen.dart';
// import 'package:medical_user_app/view/prescription/prescription_screen.dart';
// import 'package:medical_user_app/view/userneeds/need_help_screen.dart';
// import 'package:medical_user_app/view/welcome_back_screen.dart';
// import 'package:provider/provider.dart';

// class ProfileScreen extends StatelessWidget {
//   const ProfileScreen({Key? key}) : super(key: key);

// Widget _buildProfileImage(ProfileProvider profileProvider) {
//   return Container(
//     width: 40,
//     height: 40,
//     decoration: const BoxDecoration(
//       shape: BoxShape.circle,
//       color: Color.fromARGB(255, 142, 142, 142), 
//     ),
//     child: ClipOval(
//       child: profileProvider.hasProfileImage()
//           ? Image.network(
//               profileProvider.getProfileImageUrl()!,
//               fit: BoxFit.cover,
//               errorBuilder: (context, error, stackTrace) {
//                 return const SizedBox.shrink(); // keep it empty if error
//               },
//             )
//           : const SizedBox.shrink(), // no asset image, just circle
//     ),
//   );
// }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[50],
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(16.0),
//           child: Consumer<ProfileProvider>(
//             builder: (context, profileProvider, child) {
//               return Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Profile Header
//                   Row(
//                     children: [
//                       // Profile Image - Now dynamic
//                       _buildProfileImage(profileProvider),
//                       const SizedBox(width: 12),
//                       // Profile Text
//                       const AppText(
//                         'profile',
//                         style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),

//                   const SizedBox(height: 16),

//                   // Account Text
//                   AppText(
//                     'account',
//                     style: TextStyle(
//                       fontSize: 14,
//                       color: Colors.blue[700],
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),

//                   const SizedBox(height: 8),

//                   // Personal Information
//                   _buildMenuTile(
//                     context: context,
//                     title: 'personal_information',
//                     icon: Icons.person_outline,
//                     iconColor: Colors.blue[700],
//                     onTap: () {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (_) =>const PersonalInformationScreen()));
//                     },
//                   ),

//                   // Change Address
//                   _buildMenuTile(
//                     context: context,
//                     title: 'change_address',
//                     icon: Icons.location_on_outlined,
//                     iconColor: Colors.grey[600],
//                     onTap: () {
//                       Navigator.push(context,
//                           MaterialPageRoute(builder: (_) =>const  ChangeAddressScreen()));
//                     },
//                   ),

//                   // Order History
//                   _buildMenuTile(
//                     context: context,
//                     title: 'order_history',
//                     icon: Icons.history,
//                     iconColor: Colors.grey[600],
//                     onTap: () {
//                       Navigator.push(context,
//                           MaterialPageRoute(builder: (_) =>const OrdersHistoryScreen()));
//                     },
//                   ),

//                   // Periodic Meds Plan
//                   GestureDetector(
//                     child: _buildMenuTile(
//                       context: context,
//                       title: 'Periodic Detail',
//                       icon: Icons.calendar_today_outlined,
//                       iconColor: Colors.grey[600],
//                       onTap: () {
//                          Navigator.push(context, MaterialPageRoute(builder: (context)=>const PeriodicDetail()));
//                       },
//                     ),
//                   ),

//                    GestureDetector(
//                     child: _buildMenuTile(
//                       context: context,
//                       title: 'Add Query',
//                       icon: Icons.medical_information,
//                       iconColor: Colors.grey[600],
//                       onTap: () {
//                          Navigator.push(context, MaterialPageRoute(builder: (context)=>const AddQueryScreen()));
//                       },
//                     ),
//                   ),

//                   GestureDetector(
//                     child: _buildMenuTile(
//                       context: context,
//                       title: 'Upload Prescription',
//                       icon: Icons.file_upload,
//                       iconColor: Colors.grey[600],
//                       onTap: () {
//                          Navigator.push(context, MaterialPageRoute(builder: (context)=>const PrescriptionScreen()));
//                       },
//                     ),
//                   ),


//                   const SizedBox(height: 16),

//                   // Account Text (second)
//                   AppText(
//                     'account',
//                     style: TextStyle(
//                       fontSize: 14,
//                       color: Colors.grey[700],
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),

//                   const SizedBox(height: 8),

//                   // Need Help?
//                   _buildMenuTile(
//                     context: context,
//                     title: 'need_help',
//                     icon: Icons.help_outline,
//                     iconColor: Colors.grey[600],
//                     onTap: () {
//                       Navigator.push(context, MaterialPageRoute(builder: (context)=>const  NeedHelpScreen()));
//                     },
//                   ),

//                   // Contact Us
//                   // _buildMenuTile(
//                   //   context: context,
//                   //   title: 'contact_us',
//                   //   icon: Icons.phone_outlined,
//                   //   iconColor: Colors.grey[600],
//                   //   onTap: () {
//                   //     Navigator.push(context, MaterialPageRoute(builder: (context)=>ContactScreen()));
//                   //   },
//                   // ),

//                   // Logout
//                   _buildMenuTile(
//                     context: context,
//                     title: 'logout',
//                     icon: Icons.logout,
//                     iconColor: Colors.red,
//                     titleColor: Colors.red,
//                     onTap: () async {
//                       await Provider.of<AuthProvider>(context, listen: false)
//                           .logout();
//                       Navigator.pushAndRemoveUntil(
//                         context,
//                         MaterialPageRoute(builder: (_) =>const LoginScreen()),
//                         (route) => false, 
//                       );
//                     },
//                   ),
//                 ],
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildMenuTile({
//     required BuildContext context,
//     required String title,
//     required IconData icon,
//     required Function onTap,
//     Color? iconColor,
//     Color? titleColor,
//   }) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 8),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: Colors.grey.shade200),
//       ),
//       child: ListTile(
//         leading: Icon(
//           icon,
//           color: iconColor ?? Colors.grey[600],
//           size: 22,
//         ),
//         title: AppText(
//           title,
//           style: TextStyle(
//             fontSize: 14,
//             fontWeight: FontWeight.w500,
//             color: titleColor ?? Colors.black87,
//           ),
//         ),
//         trailing: Icon(
//           Icons.chevron_right,
//           color: Colors.grey[400],
//           size: 22,
//         ),
//         minLeadingWidth: 20,
//         contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
//         onTap: () => onTap(),
//       ),
//     );
//   }
// }










import 'package:flutter/material.dart';
import 'package:medical_user_app/providers/auth_provider.dart';
import 'package:medical_user_app/providers/profile_provider.dart';
import 'package:medical_user_app/providers/language_provider.dart';
import 'package:medical_user_app/view/addquery/add_query_screen.dart';
import 'package:medical_user_app/view/change_address_screen.dart';
import 'package:medical_user_app/view/detail/periodic_detail.dart';
import 'package:medical_user_app/view/login_screen.dart';
import 'package:medical_user_app/view/order_hystory_screen.dart';
import 'package:medical_user_app/view/personal_information_screen.dart';
import 'package:medical_user_app/view/prescription/prescription_screen.dart';
import 'package:medical_user_app/view/userneeds/need_help_screen.dart';
import 'package:medical_user_app/view/welcome_back_screen.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  Widget _buildProfileImage(ProfileProvider profileProvider) {
    return Container(
      width: 40,
      height: 40,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color.fromARGB(255, 142, 142, 142),
      ),
      child: ClipOval(
        child: profileProvider.hasProfileImage()
            ? Image.network(
                profileProvider.getProfileImageUrl()!,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const SizedBox.shrink();
                },
              )
            : const SizedBox.shrink(),
      ),
    );
  }

  void _showLogoutConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await Provider.of<AuthProvider>(context, listen: false)
                    .logout();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const WelcomeBackScreen()),
                  (route) => false,
                );
              },
              child: const Text(
                'Logout',
                style: TextStyle(color: Colors.red),
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
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Consumer<ProfileProvider>(
            builder: (context, profileProvider, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile Header
                  Row(
                    children: [
                      // Profile Image - Now dynamic
                      _buildProfileImage(profileProvider),
                      const SizedBox(width: 12),
                      // Profile Text
                      const AppText(
                        'profile',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Account Text
                  AppText(
                    'account',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.blue[700],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Personal Information
                  _buildMenuTile(
                    context: context,
                    title: 'personal_information',
                    icon: Icons.person_outline,
                    iconColor: Colors.blue[700],
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) =>
                                  const PersonalInformationScreen()));
                    },
                  ),

                  // Change Address
                  _buildMenuTile(
                    context: context,
                    title: 'change_address',
                    icon: Icons.location_on_outlined,
                    iconColor: Colors.grey[600],
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const ChangeAddressScreen()));
                    },
                  ),

                  // Order History
                  _buildMenuTile(
                    context: context,
                    title: 'order_history',
                    icon: Icons.history,
                    iconColor: Colors.grey[600],
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const OrdersHistoryScreen()));
                    },
                  ),

                  // Periodic Meds Plan
                  GestureDetector(
                    child: _buildMenuTile(
                      context: context,
                      title: 'Periodic Order Detail',
                      icon: Icons.calendar_today_outlined,
                      iconColor: Colors.grey[600],
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const PeriodicDetail()));
                      },
                    ),
                  ),

                  GestureDetector(
                    child: _buildMenuTile(
                      context: context,
                      title: 'Add Query',
                      icon: Icons.medical_information,
                      iconColor: Colors.grey[600],
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const AddQueryScreen()));
                      },
                    ),
                  ),

                  GestureDetector(
                    child: _buildMenuTile(
                      context: context,
                      title: 'Upload Prescription',
                      icon: Icons.file_upload,
                      iconColor: Colors.grey[600],
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const PrescriptionScreen()));
                      },
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Account Text (second)
                  AppText(
                    'account',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Need Help?
                  _buildMenuTile(
                    context: context,
                    title: 'need_help',
                    icon: Icons.help_outline,
                    iconColor: Colors.grey[600],
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const NeedHelpScreen()));
                    },
                  ),

                  // Logout
                  _buildMenuTile(
                    context: context,
                    title: 'logout',
                    icon: Icons.logout,
                    iconColor: Colors.red,
                    titleColor: Colors.red,
                    onTap: () {
                      _showLogoutConfirmation(context);
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildMenuTile({
    required BuildContext context,
    required String title,
    required IconData icon,
    required Function onTap,
    Color? iconColor,
    Color? titleColor,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: iconColor ?? Colors.grey[600],
          size: 22,
        ),
        title: AppText(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: titleColor ?? Colors.black87,
          ),
        ),
        trailing: Icon(
          Icons.chevron_right,
          color: Colors.grey[400],
          size: 22,
        ),
        minLeadingWidth: 20,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        onTap: () => onTap(),
      ),
    );
  }
}