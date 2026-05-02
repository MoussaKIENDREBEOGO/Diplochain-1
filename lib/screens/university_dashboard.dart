import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme/app_theme.dart';

import '../main.dart';
import '../models/diploma.dart';
import 'settings_screen.dart';

class UniversityDashboard extends StatefulWidget {
  const UniversityDashboard({super.key});

  @override
  State<UniversityDashboard> createState() => _UniversityDashboardState();
}

class _UniversityDashboardState extends State<UniversityDashboard> {
  int _totalEmitted = 0;
  List<Diploma> _recentEmissions = [];
  int _currentIndex = 0;

  // Controllers for Emission Tab
  final TextEditingController _studentNameController = TextEditingController();
  final TextEditingController _degreeController = TextEditingController();

  // Controllers for Search Tab
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final list = await isarService.getAllDiplomas();
    setState(() {
      _totalEmitted = list.length;
      _recentEmissions = list;
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
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
              child: const Row(
                children: [
                  Icon(LucideIcons.binary, size: 14, color: AppTheme.textSecondary),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Signature Crypto: 0x8f4d...3a1c9',
                      style: TextStyle(fontFamily: 'monospace', fontSize: 11, color: AppTheme.textSecondary),
                    ),
                  ),
                ],
              ),
            ),
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

  Future<void> _handleEmission() async {
    if (_studentNameController.text.isEmpty || _degreeController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Veuillez remplir tous les champs')),
      );
      return;
    }

    final newId = 'DC-2024-00${_totalEmitted + 1}';
    final newDiploma = Diploma()
      ..uid = newId
      ..studentName = _studentNameController.text
      ..degreeTitle = _degreeController.text
      ..institutionName = "Université Joseph Ki-Zerbo"
      ..dateIssued = DateTime.now()
      ..status = "VERIFIED"
      ..qrData = "verified_$newId";

    await isarService.saveDiploma(newDiploma);
    _studentNameController.clear();
    _degreeController.clear();
    
    await _loadData();

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Diplôme $newId émis et enregistré sur la blockchain !'),
          backgroundColor: AppTheme.primaryGreen,
        ),
      );
      setState(() {
        _currentIndex = 0; // Go back to dashboard
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      _buildHomeTab(),
      _buildEmissionTab(),
      _buildSearchTab(),
      _buildSettingsTab(),
    ];

    final List<String> titles = [
      'DIPLOCHAIN',
      'NOUVELLE ÉMISSION',
      'RECHERCHE',
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
            child: const Icon(LucideIcons.landmark, size: 20),
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
        selectedItemColor: AppTheme.primaryGreen,
        unselectedItemColor: AppTheme.textSecondary,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(LucideIcons.layoutDashboard), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(LucideIcons.filePlus), label: 'Émission'),
          BottomNavigationBarItem(icon: Icon(LucideIcons.search), label: 'Recherche'),
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
            'Portail Institutionnel',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppTheme.primaryGreen,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Gestion des Diplômes',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 24),
          
          ElevatedButton(
            onPressed: () {
              setState(() {
                _currentIndex = 1;
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryGreen,
              minimumSize: const Size(double.infinity, 64),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(LucideIcons.plusCircle, color: Colors.white),
                SizedBox(width: 12),
                Text('ÉMETTRE UN NOUVEAU DIPLÔME', style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
          
          const SizedBox(height: 24),
          
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  'Diplômes Émis',
                  '$_totalEmitted',
                  '+${_totalEmitted > 0 ? "100" : "0"}%',
                  LucideIcons.fileBadge,
                  Colors.blue,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildStatCard(
                  'En Attente',
                  '28',
                  'Urgent',
                  LucideIcons.clock,
                  Colors.orange,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildStatCard(
            'Taux de Vérification',
            '99.9%',
            'Fiable',
            LucideIcons.shieldCheck,
            AppTheme.primaryGreen,
            isFullWidth: true,
          ),
          
          const SizedBox(height: 32),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'DERNIÈRES ÉMISSIONS',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textSecondary,
                  letterSpacing: 1.1,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text('Voir tout'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (_recentEmissions.isEmpty)
            const Center(child: Text('Aucune émission récente'))
          else
            ..._recentEmissions.map((item) => _buildEmissionTile(
              item.studentName,
              item.degreeTitle,
              'SIGNÉ',
              true,
            )),
        ],
      ),
    );
  }

  Widget _buildEmissionTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppTheme.primaryDark.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Row(
              children: [
                Icon(LucideIcons.info, color: AppTheme.primaryDark),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Les diplômes émis seront encryptés et ajoutés au registre blockchain de manière immuable.',
                    style: TextStyle(fontSize: 13, color: AppTheme.primaryDark),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          const Text('Nom de l\'étudiant', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          TextField(
            controller: _studentNameController,
            decoration: InputDecoration(
              hintText: 'Ex: ZONGO Ibrahim',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
          const SizedBox(height: 24),
          const Text('Intitulé du Diplôme', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          TextField(
            controller: _degreeController,
            decoration: InputDecoration(
              hintText: 'Ex: Licence en Informatique',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
          const SizedBox(height: 48),
          ElevatedButton.icon(
            onPressed: _handleEmission,
            icon: const Icon(LucideIcons.penTool, color: Colors.white),
            label: const Text('SIGNER ET ÉMETTRE', style: TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryGreen,
              minimumSize: const Size(double.infinity, 60),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchTab() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Rechercher un document dans le registre',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.primaryDark),
          ),
          const SizedBox(height: 24),
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
          const SizedBox(height: 32),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(LucideIcons.database, size: 80, color: Colors.grey.shade300),
                  const SizedBox(height: 16),
                  Text(
                    'Entrez un ID pour rechercher',
                    style: TextStyle(color: Colors.grey.shade500),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsTab() {
    return const SettingsScreen(
      userRole: 'Université',
      userName: 'Université Joseph Ki-Zerbo',
      userSubtitle: 'Institution Accréditée · Burkina Faso',
      userIcon: LucideIcons.landmark,
    );
  }


  Widget _buildStatCard(String title, String value, String trend, IconData icon, Color color, {bool isFullWidth = false}) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: trend == 'Urgent' ? Colors.red.withValues(alpha: 0.1) : AppTheme.primaryGreen.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  trend,
                  style: TextStyle(
                    color: trend == 'Urgent' ? Colors.red : AppTheme.primaryGreen,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            value,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Text(
            title,
            style: const TextStyle(color: AppTheme.textSecondary, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildEmissionTile(String name, String degree, String status, bool isSigned) {
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
              color: isSigned ? AppTheme.primaryGreen.withValues(alpha: 0.1) : Colors.orange.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              isSigned ? LucideIcons.checkCircle : LucideIcons.clock,
              color: isSigned ? AppTheme.primaryGreen : Colors.orange,
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
                  degree,
                  style: const TextStyle(color: AppTheme.textSecondary, fontSize: 12),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: isSigned ? AppTheme.primaryGreen.withValues(alpha: 0.1) : Colors.orange.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              status,
              style: TextStyle(
                color: isSigned ? AppTheme.primaryGreen : Colors.orange,
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
