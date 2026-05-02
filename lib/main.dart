import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'screens/onboarding_screen.dart';
import 'screens/public_verification_portal.dart';
import 'screens/recruiter_dashboard.dart';
import 'screens/university_dashboard.dart';
import 'screens/student_dashboard.dart';
import 'services/isar_service.dart';
import 'models/diploma.dart';

final isarService = IsarService();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const DiploChainApp());
}

class DiploChainApp extends StatelessWidget {
  const DiploChainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DiploChain',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: FutureBuilder(
        future: _initApp(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return const OnboardingScreen();
          }
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(color: AppTheme.primaryGreen),
            ),
          );
        },
      ),
    );
  }

  Future<void> _initApp() async {
    try {
      debugPrint("Initializing Isar...");
      final existing = await isarService.getAllDiplomas();
      if (existing.isEmpty) {
        debugPrint("Seeding dummy data...");
        await isarService.saveDiploma(Diploma()
          ..uid = "DC-2024-001"
          ..studentName = "TRAORÉ Abdoulaye"
          ..degreeTitle = "Master en IA"
          ..institutionName = "Université Joseph Ki-Zerbo"
          ..dateIssued = DateTime(2024, 3, 12)
          ..status = "VERIFIED"
          ..qrData = "verified_001");
          
        await isarService.saveDiploma(Diploma()
          ..uid = "DC-2024-002"
          ..studentName = "ZONGO Ibrahim"
          ..degreeTitle = "Doctorat en Médecine"
          ..institutionName = "Université de Ouahigouya"
          ..dateIssued = DateTime(2023, 11, 20)
          ..status = "VERIFIED"
          ..qrData = "verified_002");
      }
      debugPrint("Isar initialized successfully.");
    } catch (e) {
      debugPrint("Error initializing Isar: $e");
    }
  }
}

class RoleSwitcher extends StatefulWidget {
  const RoleSwitcher({super.key});

  @override
  State<RoleSwitcher> createState() => _RoleSwitcherState();
}

class _RoleSwitcherState extends State<RoleSwitcher> {
  int _selectedRole = 0;

  final List<Widget> _screens = [
    const PublicVerificationPortal(),
    const RecruiterDashboard(),
    const UniversityDashboard(),
    const StudentDashboard(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedRole],
      floatingActionButton: FloatingActionButton(
        mini: true,
        onPressed: _showRolePicker,
        tooltip: 'Changer de Rôle',
        backgroundColor: AppTheme.primaryGreen,
        child: const Icon(Icons.switch_account),
      ),
    );
  }

  void _showRolePicker() {
    showModalBottomSheet(
      context: context,
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
                'SÉLECTIONNEZ UN RÔLE',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 24),
              _buildRoleOption(0, 'Portail Public (Vérification)', Icons.public),
              _buildRoleOption(1, 'Application Recruteur (Scan)', Icons.qr_code_scanner),
              _buildRoleOption(2, 'Université / Institution', Icons.account_balance),
              _buildRoleOption(3, 'Diplômé / Étudiant', Icons.school),
            ],
          ),
        );
      },
    );
  }

  Widget _buildRoleOption(int index, String title, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: AppTheme.primaryDark),
      title: Text(title),
      trailing: _selectedRole == index ? const Icon(Icons.check_circle, color: AppTheme.primaryGreen) : null,
      onTap: () {
        setState(() {
          _selectedRole = index;
        });
        Navigator.pop(context);
      },
    );
  }
}
