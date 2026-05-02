import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme/app_theme.dart';

import '../models/diploma.dart';
import '../main.dart';

class RecruiterDashboard extends StatefulWidget {
  const RecruiterDashboard({super.key});

  @override
  State<RecruiterDashboard> createState() => _RecruiterDashboardState();
}

class _RecruiterDashboardState extends State<RecruiterDashboard> {
  final TextEditingController _searchController = TextEditingController();
  List<Diploma> _recentVerifications = [];
  bool _isSearching = false;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadVerifications();
  }

  Future<void> _loadVerifications() async {
    final list = await isarService.getAllDiplomas();
    setState(() {
      _recentVerifications = list;
    });
  }

  Future<void> _handleSearch() async {
    if (_searchController.text.isEmpty) return;
    
    setState(() => _isSearching = true);
    
    await Future.delayed(const Duration(seconds: 1));
    
    final result = await isarService.getDiplomaByUid(_searchController.text);
    
    setState(() => _isSearching = false);

    if (result != null) {
      _showResultDialog(result);
    } else {
      _showErrorDialog();
    }
  }

  void _showResultDialog(Diploma diploma) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Row(
          children: [
            Icon(LucideIcons.checkCircle, color: AppTheme.primaryGreen),
            SizedBox(width: 10),
            Text('DIPLÔME AUTHENTIQUE'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(diploma.studentName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            Text(diploma.degreeTitle, style: const TextStyle(color: AppTheme.primaryGreen)),
            const Divider(height: 24),
            Text('Institution: ${diploma.institutionName}'),
            Text('Émis le: ${diploma.dateIssued.day}/${diploma.dateIssued.month}/${diploma.dateIssued.year}'),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('FERMER')),
        ],
      ),
    );
  }

  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Row(
          children: [
            Icon(LucideIcons.alertTriangle, color: AppTheme.error),
            SizedBox(width: 10),
            Text('DIPLÔME INCONNU'),
          ],
        ),
        content: const Text('Aucun diplôme correspondant n\'a été trouvé dans le registre national blockchain.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('RÉESSAYER')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      _buildHomeTab(),
      _buildHistoryTab(),
      _buildProfileTab(),
      _buildSettingsTab(),
    ];

    final List<String> titles = [
      'DIPLOCHAIN',
      'HISTORIQUE',
      'MON PROFIL',
      'RÉGLAGES'
    ];

    return Scaffold(
      appBar: AppBar(
        leading: _currentIndex == 0 ? Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(LucideIcons.graduationCap, size: 20),
          ),
        ) : null,
        title: Text(titles[_currentIndex]),
        centerTitle: _currentIndex != 0,
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.bell),
            onPressed: () {},
          ),
          if (_currentIndex == 0)
            const CircleAvatar(
              radius: 18,
              backgroundColor: Colors.white24,
              child: Icon(LucideIcons.user, color: Colors.white, size: 20),
            ),
          const SizedBox(width: 16),
        ],
      ),
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppTheme.primaryGreen,
        unselectedItemColor: AppTheme.textSecondary,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(icon: Icon(LucideIcons.home), label: 'Accueil'),
          BottomNavigationBarItem(icon: Icon(LucideIcons.history), label: 'Historique'),
          BottomNavigationBarItem(icon: Icon(LucideIcons.user), label: 'Profil'),
          BottomNavigationBarItem(icon: Icon(LucideIcons.settings), label: 'Réglages'),
        ],
      ),
    );
  }

  Widget _buildHomeTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Portail Recruteur',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppTheme.primaryGreen,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Vérification de Diplômes',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 24),
          
          // Scanner Card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: AppTheme.primaryDark,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.primaryDark.withValues(alpha: 0.2),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    LucideIcons.qrCode,
                    size: 64,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Scanner un QR Code',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Pointez votre caméra vers le diplôme pour une vérification instantanée',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.7),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: AppTheme.primaryDark,
                    minimumSize: const Size(double.infinity, 56),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(LucideIcons.camera),
                      SizedBox(width: 12),
                      Text('LANCER LE SCANNER'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 32),
          
          // Manual Input
          const Text(
            'RECHERCHE MANUELLE',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: AppTheme.textSecondary,
              letterSpacing: 1.1,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'ID Unique (ex: DC-2024-001)',
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              GestureDetector(
                onTap: _handleSearch,
                child: Container(
                  height: 56,
                  width: 56,
                  decoration: BoxDecoration(
                    color: AppTheme.primaryGreen,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: _isSearching 
                    ? const Padding(padding: EdgeInsets.all(16), child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                    : const Icon(LucideIcons.search, color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryTab() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text(
          'VÉRIFICATIONS RÉCENTES',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: AppTheme.textSecondary,
            letterSpacing: 1.1,
          ),
        ),
        const SizedBox(height: 16),
        if (_recentVerifications.isEmpty)
          const Center(child: Padding(
            padding: EdgeInsets.all(32.0),
            child: Text('Aucune vérification dans l\'historique', style: TextStyle(color: AppTheme.textSecondary)),
          ))
        else
          ..._recentVerifications.map((item) => _buildVerificationTile(
            item.studentName,
            item.degreeTitle,
            item.status,
            item.status == 'VERIFIED',
          )),
        const SizedBox(height: 16),
        const Text(
          'SEMAINE DERNIÈRE',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: AppTheme.textSecondary,
            letterSpacing: 1.1,
          ),
        ),
        const SizedBox(height: 16),
        _buildVerificationTile('Alice Kaboré', 'Licence en Droit', 'VERIFIED', true),
        _buildVerificationTile('Inconnu', 'Faux Diplôme Détecté', 'INVALID', false),
      ],
    );
  }

  Widget _buildProfileTab() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Center(
          child: CircleAvatar(
            radius: 50,
            backgroundColor: AppTheme.primaryDark,
            child: Icon(LucideIcons.building, size: 50, color: Colors.white),
          ),
        ),
        const SizedBox(height: 16),
        const Center(
          child: Text(
            'Coris Bank International',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppTheme.primaryDark),
          ),
        ),
        const Center(
          child: Text(
            'Compte Entreprise • Recrutement',
            style: TextStyle(color: AppTheme.textSecondary),
          ),
        ),
        const SizedBox(height: 32),
        _buildSettingsMenuItem(LucideIcons.users, 'Gestion des Accès RH'),
        _buildSettingsMenuItem(LucideIcons.fileText, 'Rapports de vérification'),
        _buildSettingsMenuItem(LucideIcons.creditCard, 'Abonnement et Facturation'),
        const SizedBox(height: 24),
        ElevatedButton.icon(
          onPressed: () {},
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
      ],
    );
  }

  Widget _buildSettingsTab() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text(
          'PRÉFÉRENCES',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppTheme.textSecondary, letterSpacing: 1.1),
        ),
        const SizedBox(height: 16),
        _buildSettingsToggleItem(LucideIcons.bell, 'Notifications Push', true),
        _buildSettingsToggleItem(LucideIcons.moon, 'Mode Sombre', false),
        _buildSettingsMenuItem(LucideIcons.globe, 'Langue (Français)'),
        const SizedBox(height: 32),
        const Text(
          'SÉCURITÉ',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppTheme.textSecondary, letterSpacing: 1.1),
        ),
        const SizedBox(height: 16),
        _buildSettingsToggleItem(LucideIcons.fingerprint, 'Authentification Biométrique', true),
        _buildSettingsMenuItem(LucideIcons.lock, 'Changer le mot de passe'),
        const SizedBox(height: 32),
        const Text(
          'A PROPOS',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppTheme.textSecondary, letterSpacing: 1.1),
        ),
        const SizedBox(height: 16),
        _buildSettingsMenuItem(LucideIcons.info, 'Conditions d\'utilisation'),
        _buildSettingsMenuItem(LucideIcons.shieldAlert, 'Politique de confidentialité'),
      ],
    );
  }

  Widget _buildSettingsMenuItem(IconData icon, String title) {
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
        onTap: () {},
      ),
    );
  }

  Widget _buildSettingsToggleItem(IconData icon, String title, bool value) {
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
        activeColor: AppTheme.primaryGreen,
        onChanged: (bool newValue) {},
      ),
    );
  }

  Widget _buildVerificationTile(String name, String detail, String status, bool isValid) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isValid ? AppTheme.primaryGreen.withValues(alpha: 0.1) : AppTheme.error.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              isValid ? LucideIcons.fileCheck : LucideIcons.fileX,
              color: isValid ? AppTheme.primaryGreen : AppTheme.error,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                Text(
                  detail,
                  style: const TextStyle(color: AppTheme.textSecondary, fontSize: 12),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: isValid ? AppTheme.primaryGreen.withValues(alpha: 0.1) : AppTheme.error.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              status,
              style: TextStyle(
                color: isValid ? AppTheme.primaryGreen : AppTheme.error,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
