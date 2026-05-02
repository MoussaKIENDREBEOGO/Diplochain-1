import 'package:flutter/material.dart';

/// Singleton global pour les réglages de l'application.
/// Utilise des ValueNotifiers pour une réactivité sans dépendance externe.
class AppSettings {
  static final AppSettings _instance = AppSettings._internal();
  factory AppSettings() => _instance;
  AppSettings._internal();

  final ValueNotifier<ThemeMode> themeMode = ValueNotifier(ThemeMode.light);
  final ValueNotifier<bool> notificationsEnabled = ValueNotifier(true);
  final ValueNotifier<bool> biometricEnabled = ValueNotifier(false);
  final ValueNotifier<String> language = ValueNotifier('Français');

  bool get isDark => themeMode.value == ThemeMode.dark;

  void toggleDarkMode(bool value) {
    themeMode.value = value ? ThemeMode.dark : ThemeMode.light;
  }
}

/// Instance globale accessible partout dans l'app
final appSettings = AppSettings();
