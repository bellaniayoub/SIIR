import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/presentation/login_screen.dart';
import 'features/fleet_search/presentation/search_screen.dart';
import 'features/chat/presentation/chat_screen.dart';

void main() {
  runApp(
    const ProviderScope(
      child: SIIRApp(),
    ),
  );
}

class SIIRApp extends StatelessWidget {
  const SIIRApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SIIR Car Rental',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: const AuthWrapper(),
    );
  }
}

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

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
      return LoginScreen(onAuthSuccess: _handleAuthSuccess);
    }
    return SIIRMainNavigation(
      sessionData: _sessionData!,
      onSignOut: _handleSignOut,
    );
  }
}

class SIIRMainNavigation extends StatefulWidget {
  final Map<String, dynamic> sessionData;
  final VoidCallback onSignOut;

  const SIIRMainNavigation({
    super.key,
    required this.sessionData,
    required this.onSignOut,
  });

  @override
  State<SIIRMainNavigation> createState() => _SIIRMainNavigationState();
}

class _SIIRMainNavigationState extends State<SIIRMainNavigation> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      SearchScreen(
        sessionData: widget.sessionData,
        onSignOut: widget.onSignOut,
      ),
      ChatScreen(
        sessionData: widget.sessionData,
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
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_car),
            label: 'Véhicules',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            label: 'Traducteur Chat',
          ),
        ],
      ),
    );
  }
}
