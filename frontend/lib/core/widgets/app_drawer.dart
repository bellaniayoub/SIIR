import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../localization/app_localizations.dart';

class AppDrawer extends StatelessWidget {
  final Map<String, dynamic> sessionData;
  final AppLanguage currentLanguage;
  final ValueChanged<AppLanguage> onLanguageChanged;
  final VoidCallback onSignOut;

  const AppDrawer({
    super.key,
    required this.sessionData,
    required this.currentLanguage,
    required this.onLanguageChanged,
    required this.onSignOut,
  });

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final user = sessionData['user'] as Map<String, dynamic>?;
    final userName = user?['name'] ?? 'Utilisateur SIIR';
    final userEmail = user?['email'] ?? 'utilisateur@siir.ma';
    final role = sessionData['role_assigned'] ?? 'Client';

    return Drawer(
      child: Column(
        children: [
          // Drawer Header with Profile Details & Role Badge
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppTheme.secondaryColor, Color(0xFF0F1E1E)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundColor: AppTheme.primaryColor,
              child: Text(
                userName.isNotEmpty ? userName[0].toUpperCase() : 'U',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
            ),
            accountName: Row(
              children: [
                Expanded(
                  child: Text(
                    userName,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    role,
                    style: const TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            accountEmail: Text(
              userEmail,
              style: const TextStyle(color: Colors.white70, fontSize: 12),
            ),
          ),

          // Menu Link: Agency Directory Marketplace Home
          ListTile(
            leading: const Icon(Icons.storefront, color: AppTheme.primaryColor),
            title: Text(loc.translate('agencies_home')),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          const Divider(),

          // Language Selector Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                const Icon(Icons.language, color: AppTheme.secondaryColor, size: 20),
                const SizedBox(width: 12),
                Text(
                  loc.translate('language'),
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  _buildLangChip(context, AppLanguage.fr, 'Français'),
                  _buildLangChip(context, AppLanguage.en, 'English'),
                  _buildLangChip(context, AppLanguage.ar, 'العربية'),
                ],
              ),
            ),
          ),

          const Spacer(),
          const Divider(),

          // Sign Out Action
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.redAccent),
            title: Text(
              loc.translate('sign_out'),
              style: const TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.pop(context);
              onSignOut();
            },
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildLangChip(BuildContext context, AppLanguage lang, String label) {
    final isSelected = currentLanguage == lang;
    return Expanded(
      child: GestureDetector(
        onTap: () => onLanguageChanged(lang),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? AppTheme.primaryColor : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.white : AppTheme.textPrimaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
