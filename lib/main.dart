import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'screens/onboarding_screen.dart';
import 'screens/public_verification_portal.dart';
import 'screens/recruiter_dashboard.dart';
import 'screens/university_dashboard.dart';
import 'screens/student_dashboard.dart';
import 'services/isar_service.dart';
import 'services/app_settings.dart';
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
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: appSettings.themeMode,
      builder: (context, themeMode, _) {
        return MaterialApp(
          title: 'DiploChain',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeMode,
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
      },
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

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sélection du Profil'),
        centerTitle: true,
        backgroundColor: AppTheme.primaryDark,
        foregroundColor: Colors.white,
      ),
      body: Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Bienvenue sur DiploChain',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppTheme.primaryDark),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              'Choisissez votre portail d\'accès pour continuer',
              style: TextStyle(fontSize: 16, color: AppTheme.textSecondary),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 48),
            _buildRoleCard(
              context,
              'Portail Public',
              'Vérifier l\'authenticité d\'un diplôme',
              Icons.public,
              const PublicVerificationPortal(),
            ),
            const SizedBox(height: 16),
            _buildRoleCard(
              context,
              'Espace Recruteur',
              'Scanner et valider des candidatures',
              Icons.qr_code_scanner,
              const RecruiterDashboard(),
            ),
            const SizedBox(height: 16),
            _buildRoleCard(
              context,
              'Portail Institution',
              'Émettre et gérer les diplômes certifiés',
              Icons.account_balance,
              const UniversityDashboard(),
            ),
            const SizedBox(height: 16),
            _buildRoleCard(
              context,
              'Espace Étudiant',
              'Consulter et partager vos attestations',
              Icons.school,
              const StudentDashboard(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoleCard(BuildContext context, String title, String subtitle, IconData icon, Widget destination) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destination),
        );
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.primaryGreen.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: AppTheme.primaryGreen, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: AppTheme.primaryDark)),
                  const SizedBox(height: 4),
                  Text(subtitle, style: const TextStyle(fontSize: 13, color: AppTheme.textSecondary)),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, color: AppTheme.textSecondary, size: 16),
          ],
        ),
      ),
    );
  }
}
