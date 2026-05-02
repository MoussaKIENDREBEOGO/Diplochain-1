import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme/app_theme.dart';
import '../main.dart';
import '../models/diploma.dart';
import '../utils/role_picker.dart';
import 'scanner_screen.dart';

class PublicVerificationPortal extends StatefulWidget {
  const PublicVerificationPortal({super.key});

  @override
  State<PublicVerificationPortal> createState() => _PublicVerificationPortalState();
}

class _PublicVerificationPortalState extends State<PublicVerificationPortal> {
  final TextEditingController _idController = TextEditingController();
  bool _isLoading = false;
  Diploma? _result;

  Future<void> _verify() async {
    if (_idController.text.isEmpty) return;
    
    setState(() {
      _isLoading = true;
      _result = null;
    });

    // Simulated blockchain verification delay
    await Future.delayed(const Duration(seconds: 2));

    final diploma = await isarService.getDiplomaByUid(_idController.text);
    
    setState(() {
      _isLoading = false;
      _result = diploma;
    });

    if (diploma == null) {
      _showError();
    }
  }

  void _showError() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Identifiant invalide ou diplôme non répertorié.'),
        backgroundColor: AppTheme.error,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 800;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: isDesktop ? 250 : 200,
            floating: false,
            pinned: true,
            backgroundColor: AppTheme.primaryDark,
            actions: [
              IconButton(
                icon: Icon(LucideIcons.list, color: Colors.white),
                onPressed: () => showRolePicker(context),
              ),
              const SizedBox(width: 8),
            ],
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('VÉRIFICATION PUBLIQUE', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 1.2, color: Colors.white)),
              centerTitle: true,
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppTheme.primaryDark, AppTheme.primaryGreen],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      right: -30,
                      top: -30,
                      child: Opacity(
                        opacity: 0.15,
                        child: Image.asset('assets/images/chevalier.png', width: 250, height: 250),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/chevalier.png',
                          height: 80,
                          errorBuilder: (context, error, stackTrace) => Icon(LucideIcons.shield, size: 64, color: Colors.white.withValues(alpha: 0.9)),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "Portail Transparent et Sécurisé",
                          style: TextStyle(color: Colors.white.withValues(alpha: 0.9), fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 800),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Registre National Blockchain',
                        style: TextStyle(color: AppTheme.primaryGreen, fontWeight: FontWeight.bold, fontSize: 14, letterSpacing: 1.1),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Vérifiez l\'authenticité d\'un titre académique',
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontSize: isDesktop ? 28 : 22, fontWeight: FontWeight.w800, color: AppTheme.primaryDark),
                      ),
                      const SizedBox(height: 32),
                      
                      // Search Box
                      Container(
                        padding: EdgeInsets.all(isDesktop ? 32 : 24),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 20, offset: const Offset(0, 10)),
                          ],
                          border: Border.all(color: AppTheme.primaryDark.withValues(alpha: 0.05)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'IDENTIFIANT UNIQUE DU DIPLÔME',
                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppTheme.textSecondary, letterSpacing: 1.2),
                            ),
                            const SizedBox(height: 16),
                            Flex(
                              direction: isDesktop ? Axis.horizontal : Axis.vertical,
                              crossAxisAlignment: isDesktop ? CrossAxisAlignment.start : CrossAxisAlignment.stretch,
                              children: [
                                Expanded(
                                  flex: isDesktop ? 2 : 0,
                                  child: TextField(
                                    controller: _idController,
                                    decoration: InputDecoration(
                                      hintText: 'Ex: DC-2024-001',
                                      prefixIcon: const Icon(LucideIcons.hash, color: AppTheme.primaryGreen),
                                      suffixIcon: IconButton(
                                        icon: const Icon(LucideIcons.scanLine, color: AppTheme.primaryDark),
                                        onPressed: () async {
                                          final scannedId = await Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => const ScannerScreen()),
                                          );
                                          if (scannedId != null && scannedId is String) {
                                            _idController.text = scannedId;
                                            _verify();
                                          }
                                        },
                                      ),
                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                                      filled: true,
                                      fillColor: AppTheme.background,
                                      contentPadding: const EdgeInsets.symmetric(vertical: 20),
                                    ),
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                  ),
                                ),
                                if (isDesktop) const SizedBox(width: 16) else const SizedBox(height: 16),
                                Expanded(
                                  flex: isDesktop ? 1 : 0,
                                  child: ElevatedButton(
                                    onPressed: _isLoading ? null : _verify,
                                    style: ElevatedButton.styleFrom(
                                      minimumSize: const Size(double.infinity, 60),
                                      backgroundColor: AppTheme.primaryDark,
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                      elevation: 0,
                                    ),
                                    child: _isLoading 
                                      ? const SizedBox(height: 24, width: 24, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 3))
                                      : const Text('VÉRIFIER', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, letterSpacing: 1.1)),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      
                      if (_result != null) ...[
                        const SizedBox(height: 40),
                        _buildResultCard(_result!),
                      ],
                      
                      const SizedBox(height: 40),
                      _buildTrustSection(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultCard(Diploma diploma) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFECFDF5),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppTheme.primaryGreen.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(LucideIcons.checkCircle, color: AppTheme.primaryGreen, size: 28),
              SizedBox(width: 12),
              Text(
                'DIPLÔME AUTHENTIQUE',
                style: TextStyle(color: AppTheme.primaryGreen, fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ],
          ),
          const Divider(height: 40, color: AppTheme.primaryGreen),
          _buildInfoRow('Titulaire', diploma.studentName),
          _buildInfoRow('Titre', diploma.degreeTitle),
          _buildInfoRow('Institution', diploma.institutionName),
          _buildInfoRow('Date d\'émission', '${diploma.dateIssued.day}/${diploma.dateIssued.month}/${diploma.dateIssued.year}'),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Icon(LucideIcons.binary, size: 16, color: AppTheme.textSecondary),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'HASH: 0x72a1...f892e',
                    style: TextStyle(fontFamily: 'monospace', fontSize: 12, color: AppTheme.textSecondary),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label.toUpperCase(), style: const TextStyle(fontSize: 10, color: AppTheme.textSecondary, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.primaryDark)),
        ],
      ),
    );
  }

  Widget _buildTrustSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.primaryDark.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Row(
        children: [
          Icon(LucideIcons.shieldCheck, color: AppTheme.primaryDark),
          SizedBox(width: 16),
          Expanded(
            child: Text(
              'Cette vérification est garantie par l\'Infrastructure Nationale Blockchain du Burkina Faso.',
              style: TextStyle(fontSize: 12, color: AppTheme.primaryDark, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}
