import 'package:flutter/material.dart';
import 'package:medical_user_app/providers/auth_provider.dart';
import 'package:medical_user_app/providers/language_provider.dart';
import 'package:medical_user_app/view/change_address_screen.dart';
import 'package:medical_user_app/view/login_screen.dart';
import 'package:medical_user_app/view/order_hystory_screen.dart';
import 'package:medical_user_app/view/personal_information_screen.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Header
              Row(
                children: [
                  // Profile Image
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.amber,
                      image: DecorationImage(
                        image: AssetImage('assets/profile.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
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
                          builder: (_) => PersonalInformationScreen()));
                },
              ),

              // Change Address
              _buildMenuTile(
                context: context,
                title: 'change_address',
                icon: Icons.location_on_outlined,
                iconColor: Colors.grey[600],
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => ChangeAddressScreen()));
                },
              ),

              // Order History
              _buildMenuTile(
                context: context,
                title: 'order_history',
                icon: Icons.history,
                iconColor: Colors.grey[600],
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => OrdersHistoryScreen()));
                },
              ),

              // Periodic Meds Plan
              _buildMenuTile(
                context: context,
                title: 'periodic_plan',
                icon: Icons.calendar_today_outlined,
                iconColor: Colors.grey[600],
                onTap: () {},
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
                onTap: () {},
              ),

              // Contact Us
              _buildMenuTile(
                context: context,
                title: 'contact_us',
                icon: Icons.phone_outlined,
                iconColor: Colors.grey[600],
                onTap: () {},
              ),

              // Logout
              _buildMenuTile(
                context: context,
                title: 'logout',
                icon: Icons.logout,
                iconColor: Colors.red,
                titleColor: Colors.red,
                onTap: () async {
                  await Provider.of<AuthProvider>(context, listen: false)
                      .logout();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => LoginScreen()),
                    (route) => false, // This removes all previous routes
                  );
                },
              ),
            ],
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
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        onTap: () => onTap(),
      ),
    );
  }
}
