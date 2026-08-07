import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_theme.dart';
import 'core/localization/app_localizations.dart';
import 'features/auth/presentation/login_screen.dart';
import 'features/agency_store/presentation/agency_store_list_screen.dart';

void main() {
  runApp(
    const ProviderScope(
      child: SIIRApp(),
    ),
  );
}

class SIIRApp extends StatefulWidget {
  const SIIRApp({super.key});

  @override
  State<SIIRApp> createState() => _SIIRAppState();
}

class _SIIRAppState extends State<SIIRApp> {
  AppLanguage _currentLanguage = AppLanguage.fr;

  void _changeLanguage(AppLanguage language) {
    setState(() {
      _currentLanguage = language;
    });
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations(_currentLanguage);

    return Directionality(
      textDirection: localizations.textDirection,
      child: MaterialApp(
        title: 'SIIR Car Rental',
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        locale: Locale(_currentLanguage.name),
        home: AppLocalizationsProvider(
          localizations: localizations,
          child: AuthWrapper(
            currentLanguage: _currentLanguage,
            onLanguageChanged: _changeLanguage,
          ),
        ),
      ),
    );
  }
}

class AuthWrapper extends StatefulWidget {
  final AppLanguage currentLanguage;
  final ValueChanged<AppLanguage> onLanguageChanged;

  const AuthWrapper({
    super.key,
    required this.currentLanguage,
    required this.onLanguageChanged,
  });

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  Map<String, dynamic>? _sessionData;

  void _handleAuthSuccess(Map<String, dynamic> sessionData) {
    setState(() {
      _sessionData = sessionData;
    });
  }

  void _handleSignOut() {
    setState(() {
      _sessionData = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_sessionData == null) {
      return LoginScreen(
        onAuthSuccess: _handleAuthSuccess,
        currentLanguage: widget.currentLanguage,
        onLanguageChanged: widget.onLanguageChanged,
      );
    }

    return AgencyStoreListScreen(
      sessionData: _sessionData!,
      currentLanguage: widget.currentLanguage,
      onLanguageChanged: widget.onLanguageChanged,
      onSignOut: _handleSignOut,
    );
  }
}
