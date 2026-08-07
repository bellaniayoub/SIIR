import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_theme.dart';
import 'core/localization/app_localizations.dart';
import 'features/auth/presentation/login_screen.dart';
import 'features/fleet_search/presentation/search_screen.dart';
import 'features/chat/presentation/chat_screen.dart';
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

    return Localizations(
      locale: Locale(_currentLanguage.name),
      delegates: const [
        DefaultMaterialLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
      ],
      child: Directionality(
        textDirection: localizations.textDirection,
        child: MaterialApp(
          title: 'SIIR Car Rental',
          theme: AppTheme.lightTheme,
          debugShowCheckedModeBanner: false,
          builder: (context, child) {
            return Localizations.override(
              context: context,
              child: child!,
            );
          },
          home: AppLocalizationsWrapper(
            localizations: localizations,
            child: AuthWrapper(
              currentLanguage: _currentLanguage,
              onLanguageChanged: _changeLanguage,
            ),
          ),
        ),
      ),
    );
  }
}

class AppLocalizationsWrapper extends InheritedWidget {
  final AppLocalizations localizations;

  const AppLocalizationsWrapper({
    super.key,
    required this.localizations,
    required super.child,
  });

  static AppLocalizations of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppLocalizationsWrapper>()!.localizations;
  }

  @override
  bool updateShouldNotify(AppLocalizationsWrapper oldWidget) {
    return oldWidget.localizations.language != localizations.language;
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
    return SIIRMainNavigation(
      sessionData: _sessionData!,
      currentLanguage: widget.currentLanguage,
      onLanguageChanged: widget.onLanguageChanged,
      onSignOut: _handleSignOut,
    );
  }
}

class SIIRMainNavigation extends StatefulWidget {
  final Map<String, dynamic> sessionData;
  final AppLanguage currentLanguage;
  final ValueChanged<AppLanguage> onLanguageChanged;
  final VoidCallback onSignOut;

  const SIIRMainNavigation({
    super.key,
    required this.sessionData,
    required this.currentLanguage,
    required this.onLanguageChanged,
    required this.onSignOut,
  });

  @override
  State<SIIRMainNavigation> createState() => _SIIRMainNavigationState();
}

class _SIIRMainNavigationState extends State<SIIRMainNavigation> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);

    final List<Widget> screens = [
      SearchScreen(
        sessionData: widget.sessionData,
        currentLanguage: widget.currentLanguage,
        onLanguageChanged: widget.onLanguageChanged,
        onSignOut: widget.onSignOut,
      ),
      const AgencyStoreListScreen(),
      ChatScreen(
        sessionData: widget.sessionData,
        currentLanguage: widget.currentLanguage,
        onLanguageChanged: widget.onLanguageChanged,
        onSignOut: widget.onSignOut,
      ),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: AppTheme.primaryColor,
        unselectedItemColor: AppTheme.textSecondaryColor,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.directions_car),
            label: loc.translate('vehicles'),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.storefront),
            label: loc.translate('agencies'),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.chat_bubble_outline),
            label: loc.translate('chat'),
          ),
        ],
      ),
    );
  }
}
