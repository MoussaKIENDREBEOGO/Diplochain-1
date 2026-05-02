import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:fl_chart/fl_chart.dart';
import '../theme/app_theme.dart';
import '../utils/role_picker.dart';
import 'settings_screen.dart';

class StudentDashboard extends StatefulWidget {
  const StudentDashboard({super.key});

  @override
  State<StudentDashboard> createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      _buildHomeTab(),
      _buildShareTab(),
      _buildAlertsTab(),
      _buildProfileTab(),
    ];

    final List<String> titles = [
      'MES DIPLÔMES',
      'PARTAGER',
      'ALERTES',
      'MON PROFIL'
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(titles[_currentIndex]),
        centerTitle: true,
        actions: [
          if (_currentIndex == 0)
            IconButton(
              icon: const Icon(LucideIcons.share2),
              onPressed: () {
                setState(() {
                  _currentIndex = 1;
                });
              },
            ),
          IconButton(
            icon: Icon(LucideIcons.list),
            onPressed: () => showRolePicker(context),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: PopScope(
        canPop: _currentIndex == 0,
        onPopInvokedWithResult: (didPop, result) {
          if (!didPop) {
            setState(() {
              _currentIndex = 0;
            });
          }
        },
        child: pages[_currentIndex],
      ),
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
          BottomNavigationBarItem(icon: Icon(LucideIcons.home), label: 'Mes Titres'),
          BottomNavigationBarItem(icon: Icon(LucideIcons.qrCode), label: 'Partager'),
          BottomNavigationBarItem(icon: Icon(LucideIcons.bell), label: 'Alertes'),
          BottomNavigationBarItem(icon: Icon(LucideIcons.user), label: 'Profil'),
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
          // User Header
          Row(
            children: [
              const CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=traore'),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Abdoulaye Traoré',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const Text(
                    'Diplômé certifié • Burkina Faso',
                    style: TextStyle(color: AppTheme.textSecondary, fontSize: 13),
                  ),
                ],
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppTheme.primaryGreen.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  children: [
                    Icon(LucideIcons.shieldCheck, color: AppTheme.primaryGreen, size: 14),
                    SizedBox(width: 4),
                    Text(
                      'VÉRIFIÉ',
                      style: TextStyle(color: AppTheme.primaryGreen, fontSize: 10, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 32),
          
          // Main Degree Card
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppTheme.primaryDark, AppTheme.primaryDark.withValues(alpha: 0.8)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.primaryDark.withValues(alpha: 0.3),
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(LucideIcons.graduationCap, color: Colors.white, size: 32),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _currentIndex = 1;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(LucideIcons.qrCode, color: Colors.white, size: 20),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                const Text(
                  'Master en Intelligence Artificielle',
                  style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Text(
                  'Université Joseph Ki-Zerbo',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('DATE D\'ÉMISSION', style: TextStyle(color: Colors.white54, fontSize: 10)),
                        Text('12 Mars 2024', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: AppTheme.primaryDark,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        minimumSize: Size.zero,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: const Text('DÉTAILS', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 32),
          
          // Stats Section
          const Text(
            'STATISTIQUES D\'ACCÈS',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppTheme.textSecondary, letterSpacing: 1.1),
          ),
          const SizedBox(height: 16),
          Container(
            height: 180,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey.shade100),
            ),
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: 10,
                barTouchData: BarTouchData(enabled: false),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        const titles = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'];
                        return Text(titles[value.toInt()], style: const TextStyle(fontSize: 10, color: AppTheme.textSecondary));
                      },
                    ),
                  ),
                  leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                gridData: const FlGridData(show: false),
                borderData: FlBorderData(show: false),
                barGroups: [
                  _buildBarGroup(0, 4),
                  _buildBarGroup(1, 7),
                  _buildBarGroup(2, 5),
                  _buildBarGroup(3, 8),
                  _buildBarGroup(4, 3),
                  _buildBarGroup(5, 6),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 32),
          
          // Audit Log
          const Text(
            'HISTORIQUE DE VÉRIFICATION',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppTheme.textSecondary, letterSpacing: 1.1),
          ),
          const SizedBox(height: 12),
          _buildAuditTile('Orange Burkina', 'Vérification RH', 'Il y a 2 jours', true),
          _buildAuditTile('Ministère de l\'Éducation', 'Validation Dossier', 'Il y a 1 semaine', true),
        ],
      ),
    );
  }

  Widget _buildShareTab() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 20, offset: const Offset(0, 10)),
                ],
              ),
              child: Column(
                children: [
                  const Icon(LucideIcons.qrCode, size: 150, color: AppTheme.primaryDark),
                  const SizedBox(height: 24),
                  const Text(
                    'Scannez pour vérifier',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.primaryDark),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'ID: DC-2024-001',
                    style: TextStyle(color: AppTheme.textSecondary),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Lien copié dans le presse-papiers !')),
                      );
                    },
                    icon: const Icon(LucideIcons.copy),
                    label: const Text('Copier le lien sécurisé'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryGreen,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              'Ce QR Code donne un accès temporaire de 24h à la version numérique de votre diplôme certifié.',
              textAlign: TextAlign.center,
              style: TextStyle(color: AppTheme.textSecondary, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAlertsTab() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text(
          'NOUVELLES ALERTES',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppTheme.textSecondary, letterSpacing: 1.1),
        ),
        const SizedBox(height: 16),
        _buildAuditTile('Université Joseph Ki-Zerbo', 'Nouveau document disponible (Relevé)', 'Il y a 2h', false),
        const SizedBox(height: 24),
        const Text(
          'VÉRIFICATIONS RÉCENTES',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppTheme.textSecondary, letterSpacing: 1.1),
        ),
        const SizedBox(height: 16),
        _buildAuditTile('Coris Bank International', 'Vérification de profil', 'Hier', true),
        _buildAuditTile('Orange Burkina', 'Vérification RH', 'Il y a 2 jours', true),
      ],
    );
  }

  Widget _buildProfileTab() {
    return const SettingsScreen(
      userRole: 'Étudiant',
      userName: 'Abdoulaye Traoré',
      userSubtitle: 'Diplômé · Université Joseph Ki-Zerbo',
      userIcon: LucideIcons.graduationCap,
    );
  }

  BarChartGroupData _buildBarGroup(int x, double y) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: AppTheme.primaryGreen,
          width: 12,
          borderRadius: BorderRadius.circular(4),
        ),
      ],
    );
  }

  Widget _buildAuditTile(String company, String reason, String date, bool isVerified) {
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
              color: isVerified ? AppTheme.primaryDark.withValues(alpha: 0.05) : Colors.blue.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(isVerified ? LucideIcons.shieldCheck : LucideIcons.fileText, 
              color: isVerified ? AppTheme.primaryDark : Colors.blue, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(company, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                Text(reason, style: const TextStyle(color: AppTheme.textSecondary, fontSize: 12)),
              ],
            ),
          ),
          Text(date, style: const TextStyle(color: AppTheme.textSecondary, fontSize: 11)),
        ],
      ),
    );
  }
}
