import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'screens/onboarding_screen.dart';

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

