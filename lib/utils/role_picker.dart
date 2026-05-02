import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../screens/public_verification_portal.dart';
import '../screens/recruiter_dashboard.dart';
import '../screens/university_dashboard.dart';
import '../screens/student_dashboard.dart';

void showRolePicker(BuildContext context) {
  showModalBottomSheet(
    context: context,
    constraints: const BoxConstraints(maxWidth: double.infinity), // Force full width on desktop so it doesn't float
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'SÉLECTIONNEZ UN PORTAIL',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 24),
            _buildRoleOption(context, 'Portail Public (Vérification)', Icons.public, const PublicVerificationPortal()),
            _buildRoleOption(context, 'Application Recruteur (Scan)', Icons.qr_code_scanner, const RecruiterDashboard()),
            _buildRoleOption(context, 'Université / Institution', Icons.account_balance, const UniversityDashboard()),
            _buildRoleOption(context, 'Diplômé / Étudiant', Icons.school, const StudentDashboard()),
          ],
        ),
      );
    },
  );
}

Widget _buildRoleOption(BuildContext context, String title, IconData icon, Widget destination) {
  return ListTile(
    leading: Icon(icon, color: AppTheme.primaryDark),
    title: Text(title),
    trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
    onTap: () {
      Navigator.pop(context); // Close bottom sheet
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => destination),
      );
    },
  );
}
