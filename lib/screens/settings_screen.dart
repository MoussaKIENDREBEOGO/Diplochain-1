// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme/app_theme.dart';
import '../services/app_settings.dart';
import 'onboarding_screen.dart';

/// Écran de réglages complet et réutilisable par tous les dashboards.
class SettingsScreen extends StatefulWidget {
  final String userRole; // 'student', 'recruiter', 'university'
  final String userName;
  final String userSubtitle;
  final IconData userIcon;

  const SettingsScreen({
    super.key,
    required this.userRole,
    required this.userName,
    required this.userSubtitle,
    required this.userIcon,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // Local state mirroring AppSettings (reactive)
  bool _notif = true;
  bool _biometric = false;
  bool _darkMode = false;
  String _language = 'Français';
  String _selectedLanguage = 'Français';

  @override
  void initState() {
    super.initState();
    _notif = appSettings.notificationsEnabled.value;
    _biometric = appSettings.biometricEnabled.value;
    _darkMode = appSettings.isDark;
    _language = appSettings.language.value;
    _selectedLanguage = _language;
  }

  void _showPasswordDialog() {
    final oldPwController = TextEditingController();
    final newPwController = TextEditingController();
    final confirmPwController = TextEditingController();
    bool obscure = true;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(28))),
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setModal) => Padding(
          padding: EdgeInsets.only(
            left: 24,
            right: 24,
            top: 24,
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Changer le mot de passe',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 24),
              TextField(
                controller: oldPwController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Mot de passe actuel',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  prefixIcon: const Icon(LucideIcons.lock),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: newPwController,
                obscureText: obscure,
                decoration: InputDecoration(
                  labelText: 'Nouveau mot de passe',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                prefixIcon: const Icon(LucideIcons.key),
                  suffixIcon: IconButton(
                    icon: Icon(obscure ? LucideIcons.eyeOff : LucideIcons.eye),
                    onPressed: () => setModal(() => obscure = !obscure),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: confirmPwController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Confirmer le nouveau mot de passe',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  prefixIcon: const Icon(LucideIcons.shieldCheck),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (newPwController.text != confirmPwController.text) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Les mots de passe ne correspondent pas !')));
                    return;
                  }
                  if (newPwController.text.length < 6) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Le mot de passe doit contenir au moins 6 caractères !')));
                    return;
                  }
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: const Text('✅ Mot de passe mis à jour avec succès !'),
                    backgroundColor: AppTheme.primaryGreen,
                  ));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryGreen,
                  minimumSize: const Size(double.infinity, 56),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: const Text('METTRE À JOUR', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialog) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text('Choisir la langue'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: ['Français', 'English', 'Moore', 'Dioula'].map((lang) {
              return RadioListTile<String>(
                title: Text(lang),
                value: lang,
                groupValue: _selectedLanguage,
                activeColor: AppTheme.primaryGreen,
                onChanged: (val) {
                  setDialog(() => _selectedLanguage = val!);
                },
              );
            }).toList(),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('ANNULER'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _language = _selectedLanguage;
                });
                appSettings.language.value = _selectedLanguage;
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Langue changée : $_selectedLanguage'),
                  backgroundColor: AppTheme.primaryGreen,
                ));
              },
              style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryGreen),
              child: const Text('APPLIQUER', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  void _showInfoDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Icon(LucideIcons.shield, color: AppTheme.primaryGreen),
            const SizedBox(width: 12),
            const Text('DiploChain'),
          ],
        ),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Version : 1.0.0 (Phase 2 — Demi-finale)'),
            SizedBox(height: 8),
            Text('Plateforme de certification de diplômes sur Blockchain au Burkina Faso.'),
            SizedBox(height: 8),
            Text('© 2024 DiploChain BF · ODD 4 · ODD 8 · ODD 16'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('FERMER'),
          ),
        ],
      ),
    );
  }

  void _showTermsDialog(String title, String content) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(28))),
      builder: (ctx) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.95,
        minChildSize: 0.4,
        expand: false,
        builder: (ctx, scroll) => ListView(
          controller: scroll,
          padding: const EdgeInsets.all(24),
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(title,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Text(content, style: const TextStyle(height: 1.8)),
          ],
        ),
      ),
    );
  }

  void _showPersonalInfoSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(28))),
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
          left: 24, right: 24, top: 24,
          bottom: MediaQuery.of(ctx).viewInsets.bottom + 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Informations Personnelles',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            _buildInfoField('Nom complet', widget.userName),
            const SizedBox(height: 16),
            _buildInfoField('Rôle', widget.userRole),
            const SizedBox(height: 16),
            _buildInfoField('Email', '${widget.userRole.toLowerCase()}@diplochain.bf'),
            const SizedBox(height: 16),
            _buildInfoField('Téléphone', '+226 70 00 00 00'),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: const Text('Informations mises à jour !'),
                  backgroundColor: AppTheme.primaryGreen,
                ));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryGreen,
                minimumSize: const Size(double.infinity, 56),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: const Text('ENREGISTRER', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoField(String label, String value) {
    return TextField(
      readOnly: false,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      controller: TextEditingController(text: value),
    );
  }

  void _handleLogout() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Se déconnecter ?'),
        content: const Text('Voulez-vous vraiment quitter DiploChain ?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('ANNULER')),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              // Redirect to Onboarding
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const OnboardingScreen()),
                (route) => false,
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('DÉCONNECTER', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        // Profile Header
        Center(
          child: CircleAvatar(
            radius: 50,
            backgroundColor: AppTheme.primaryDark,
            child: Icon(widget.userIcon, size: 50, color: Colors.white),
          ),
        ),
        const SizedBox(height: 16),
        Center(
          child: Text(
            widget.userName,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppTheme.primaryDark),
          ),
        ),
        Center(
          child: Text(widget.userSubtitle, style: const TextStyle(color: AppTheme.textSecondary)),
        ),
        const SizedBox(height: 32),

        // === MON COMPTE ===
        _buildSectionTitle('MON COMPTE'),
        _buildMenuItem(LucideIcons.user, 'Informations Personnelles', onTap: _showPersonalInfoSheet),
        _buildMenuItem(LucideIcons.lock, 'Changer le mot de passe', onTap: _showPasswordDialog),

        const SizedBox(height: 24),

        // === PRÉFÉRENCES ===
        _buildSectionTitle('PRÉFÉRENCES'),
        _buildToggleItem(
          LucideIcons.bell,
          'Notifications Push',
          _notif,
          onChanged: (val) {
            setState(() => _notif = val);
            appSettings.notificationsEnabled.value = val;
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(val ? '🔔 Notifications activées' : '🔕 Notifications désactivées'),
              duration: const Duration(seconds: 1),
            ));
          },
        ),
        _buildToggleItem(
          LucideIcons.moon,
          'Mode Sombre',
          _darkMode,
          onChanged: (val) {
            setState(() => _darkMode = val);
            appSettings.toggleDarkMode(val);
          },
        ),
        _buildMenuItem(
          LucideIcons.globe,
          'Langue : $_language',
          onTap: _showLanguageDialog,
        ),

        const SizedBox(height: 24),

        // === SÉCURITÉ ===
        _buildSectionTitle('SÉCURITÉ'),
        _buildToggleItem(
          LucideIcons.fingerprint,
          'Authentification Biométrique',
          _biometric,
          onChanged: (val) {
            setState(() => _biometric = val);
            appSettings.biometricEnabled.value = val;
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(val ? '✅ Biométrie activée' : '🔒 Biométrie désactivée'),
              backgroundColor: val ? AppTheme.primaryGreen : Colors.grey,
              duration: const Duration(seconds: 1),
            ));
          },
        ),

        const SizedBox(height: 24),

        // === À PROPOS ===
        _buildSectionTitle('À PROPOS'),
        _buildMenuItem(LucideIcons.info, 'Version et informations', onTap: _showInfoDialog),
        _buildMenuItem(
          LucideIcons.fileText,
          "Conditions d'utilisation",
          onTap: () => _showTermsDialog(
            "Conditions d'utilisation",
            "DiploChain est une plateforme dédiée à la certification numérique des diplômes au Burkina Faso. En utilisant cette application, vous acceptez les présentes conditions d'utilisation.\n\nL'utilisation de faux diplômes ou la tentative de fraude au système est un délit puni par la loi burkinabè (Article 389 du Code Pénal).\n\nLes données enregistrées sur la blockchain sont immuables et seront conservées conformément à la réglementation en vigueur.\n\nDiploChain se réserve le droit de suspendre tout compte soupçonné d'utilisation frauduleuse sans préavis.",
          ),
        ),
        _buildMenuItem(
          LucideIcons.shieldAlert,
          'Politique de confidentialité',
          onTap: () => _showTermsDialog(
            "Politique de confidentialité",
            "Vos données personnelles sont traitées conformément au RGPD et à la loi burkinabè sur la protection des données.\n\nNous collectons uniquement les informations nécessaires à la vérification des diplômes : nom, prénom, établissement, intitulé du diplôme et date d'émission.\n\nVos données ne sont jamais revendues à des tiers.\n\nVous disposez d'un droit d'accès, de rectification et de suppression de vos données en contactant notre équipe.\n\nLes données sont chiffrées et stockées de manière sécurisée sur la blockchain, ce qui garantit leur inviolabilité.",
          ),
        ),
        _buildMenuItem(LucideIcons.helpCircle, 'Aide et Support', onTap: () {
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              title: const Text('Aide & Support'),
              content: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(leading: Icon(LucideIcons.mail), title: Text('support@diplochain.bf')),
                  ListTile(leading: Icon(LucideIcons.phone), title: Text('+226 25 36 00 00')),
                  ListTile(leading: Icon(LucideIcons.globe), title: Text('www.diplochain.bf')),
                ],
              ),
              actions: [TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('FERMER'))],
            ),
          );
        }),

        const SizedBox(height: 32),

        // Logout
        ElevatedButton.icon(
          onPressed: _handleLogout,
          icon: const Icon(LucideIcons.logOut),
          label: const Text('Se déconnecter'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red.withValues(alpha: 0.1),
            foregroundColor: Colors.red,
            elevation: 0,
            minimumSize: const Size(double.infinity, 56),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: AppTheme.textSecondary,
          letterSpacing: 1.1,
        ),
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, {VoidCallback? onTap}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: ListTile(
        leading: Icon(icon, color: AppTheme.primaryDark),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
        trailing: const Icon(LucideIcons.chevronRight, color: AppTheme.textSecondary, size: 20),
        onTap: onTap,
      ),
    );
  }

  Widget _buildToggleItem(IconData icon, String title, bool value,
      {required ValueChanged<bool> onChanged}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: SwitchListTile(
        secondary: Icon(icon, color: AppTheme.primaryDark),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
        value: value,
        activeThumbColor: AppTheme.primaryGreen,
        onChanged: onChanged,
      ),
    );
  }
}
