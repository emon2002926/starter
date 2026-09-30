import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../util/storage_service.dart';


class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final role = StorageService.userRole ?? 'owner';
    
    String name = 'Avery Scott';
    String roleDisplay = 'Managing Principal & Founder';
    
    if (role == 'finance' || role == 'pm' || role == 'field_super') {
      name = 'Sarah Johnson';
      if (role == 'finance') roleDisplay = 'Finance';
      if (role == 'pm') roleDisplay = 'Project Manager';
      if (role == 'field_super') roleDisplay = 'Field Superintendent';
    }

    // Determine visibility based on role
    // For Punch List: everyone except finance
    final showPunchList = role != 'finance';
    
    // For Team Directory: let's assume everyone has it EXCEPT field_super 
    // (based on my analysis that field super might only have milestone and punch list)
    final showTeamDirectory = role != 'field_super';

    return Drawer(
      backgroundColor: Colors.white,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: const BoxDecoration(
                      color: Color(0xFF2563EB),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        _getInitials(name),
                        style: GoogleFonts.plusJakartaSans(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: GoogleFonts.plusJakartaSans(
                            color: Colors.black87,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          roleDisplay,
                          style: GoogleFonts.plusJakartaSans(
                            color: Colors.grey.shade500,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1, thickness: 1, color: Color(0xFFF1F5F9), indent: 20, endIndent: 20),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'COMPANY OPERATIONS',
                style: GoogleFonts.plusJakartaSans(
                  color: Colors.grey.shade500,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            const SizedBox(height: 12),
            _buildDrawerItem(
              icon: Icons.flag_outlined,
              label: 'Milestone Tracker',
              onTap: () {
                Get.back(); // Close drawer
                // Get.to(() => const MilestonesScreen());
              },
            ),
            if (showPunchList)
              _buildDrawerItem(
                icon: Icons.check_box_outlined,
                label: 'Punch List',
                onTap: () {
                  Get.back();
                  // Get.to(() => const PunchListScreen());
                },
                iconColor: const Color(0xFFD97706),
                bgColor: const Color(0xFFFFFBEB),
              ),
            if (showTeamDirectory)
              _buildDrawerItem(
                icon: Icons.people_outline,
                label: 'Team Directory',
                onTap: () {
                  Get.back();
                  // Get.to(() => const TeamScreen());
                },
                iconColor: const Color(0xFF2563EB),
                bgColor: const Color(0xFFEFF6FF),
              ),
            const Spacer(),
            const Divider(height: 1, thickness: 1, color: Color(0xFFF1F5F9)),
            InkWell(
              onTap: () async {
                await StorageService.logout();
                // Get.offAll(() => const RoleSelectionScreen());
              },
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Icon(Icons.logout, color: Colors.grey.shade600, size: 20),
                    const SizedBox(width: 12),
                    Text(
                      'Sign Out',
                      style: GoogleFonts.plusJakartaSans(
                        color: Colors.grey.shade800,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getInitials(String name) {
    List<String> names = name.split(" ");
    String initials = "";
    int numWords = 2;
    if (names.length < 2) {
      numWords = names.length;
    }
    for (var i = 0; i < numWords; i++) {
      initials += names[i][0];
    }
    return initials.toUpperCase();
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    Color iconColor = const Color(0xFF2563EB),
    Color bgColor = const Color(0xFFEFF6FF),
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: iconColor, size: 16),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                style: GoogleFonts.plusJakartaSans(
                  color: Colors.black87,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Icon(Icons.chevron_right, color: Colors.grey.shade300, size: 20),
          ],
        ),
      ),
    );
  }
}
