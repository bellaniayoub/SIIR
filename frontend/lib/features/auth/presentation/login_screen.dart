import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/localization/app_localizations.dart';
import '../data/auth_repository.dart';

class LoginScreen extends StatefulWidget {
  final Function(Map<String, dynamic> sessionData) onAuthSuccess;
  final AppLanguage currentLanguage;
  final ValueChanged<AppLanguage> onLanguageChanged;

  const LoginScreen({
    super.key,
    required this.onAuthSuccess,
    required this.currentLanguage,
    required this.onLanguageChanged,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthRepository _authRepository = AuthRepository();
  String _selectedRole = 'Client';
  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _handleGoogleSignIn() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final result = await _authRepository.signInWithGoogle(_selectedRole);
      if (result != null) {
        widget.onAuthSuccess(result);
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Authentication Error: Unable to connect to backend server ($e).';
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _bypassSignInWithMockData() {
    widget.onAuthSuccess({
      'status': 'success',
      'message': 'Bypassed authentication (Mock Dev)',
      'role_assigned': _selectedRole,
      'token': 'mock-jwt-dev-token-xyz123',
      'user': {
        'email': _selectedRole == 'Client' ? 'tourist@siir.ma' : 'agency.rabat@siir.ma',
        'name': _selectedRole == 'Client' ? 'John Doe' : 'Atlas Rental Agadir',
        'picture': 'https://via.placeholder.com/150',
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFF091414),
      body: Stack(
        children: [
          // Background Gradient with Glow Accents
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF0D2523),
                    Color(0xFF071212),
                    Color(0xFF040A0A),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          Positioned(
            top: -60,
            right: -60,
            child: Container(
              width: 240,
              height: 240,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppTheme.primaryColor.withValues(alpha: 0.15),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.primaryColor.withValues(alpha: 0.15),
                    blurRadius: 90,
                    spreadRadius: 20,
                  ),
                ],
              ),
            ),
          ),

          SafeArea(
            child: TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0.0, end: 1.0),
              duration: const Duration(milliseconds: 700),
              curve: Curves.easeOutCubic,
              builder: (context, value, child) {
                return Opacity(
                  opacity: value,
                  child: child,
                );
              },
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Language Switcher Top Bar
                      Align(
                        alignment: loc.textDirection == TextDirection.rtl
                            ? Alignment.topLeft
                            : Alignment.topRight,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.08),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<AppLanguage>(
                              value: widget.currentLanguage,
                              dropdownColor: const Color(0xFF0D2523),
                              icon: const Icon(Icons.language, color: AppTheme.primaryColor, size: 20),
                              items: const [
                                DropdownMenuItem(
                                  value: AppLanguage.fr,
                                  child: Text('Français 🇫🇷', style: TextStyle(color: Colors.white, fontSize: 13)),
                                ),
                                DropdownMenuItem(
                                  value: AppLanguage.en,
                                  child: Text('English 🇬🇧', style: TextStyle(color: Colors.white, fontSize: 13)),
                                ),
                                DropdownMenuItem(
                                  value: AppLanguage.ar,
                                  child: Text('العربية 🇲🇦', style: TextStyle(color: Colors.white, fontSize: 13)),
                                ),
                              ],
                              onChanged: (lang) {
                                if (lang != null) widget.onLanguageChanged(lang);
                              },
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Brand Logo/Header
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withValues(alpha: 0.05),
                          border: Border.all(color: AppTheme.primaryColor.withValues(alpha: 0.3), width: 1.5),
                          boxShadow: [
                            BoxShadow(
                              color: AppTheme.primaryColor.withValues(alpha: 0.2),
                              blurRadius: 30,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Image.asset(
                          'assets/images/logo.png',
                          height: 85,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(height: 16),

                      Text(
                        loc.translate('app_subtitle'),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 36),

                      // Glassmorphic Main Card
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.07),
                          borderRadius: BorderRadius.circular(28),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.15),
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.4),
                              blurRadius: 25,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // Role selector container
                            Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.black.withValues(alpha: 0.3),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: _buildRoleTab(loc.translate('client_b2c'), 'Client', Icons.person_outline),
                                  ),
                                  Expanded(
                                    child: _buildRoleTab(loc.translate('agency_b2b'), 'Agency', Icons.storefront_outlined),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 24),

                            Text(
                              _selectedRole == 'Client'
                                  ? loc.translate('client_login_desc')
                                  : loc.translate('agency_login_desc'),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                height: 1.4,
                              ),
                            ),
                            const SizedBox(height: 24),

                            if (_errorMessage != null) ...[
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.red.withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: Colors.red.withValues(alpha: 0.4)),
                                ),
                                child: Text(
                                  _errorMessage!,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(color: Colors.redAccent, fontSize: 12),
                                ),
                              ),
                              const SizedBox(height: 16),
                            ],

                            if (_isLoading)
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 20),
                                child: Center(
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primaryColor),
                                  ),
                                ),
                              )
                            else ...[
                              // Premium Google Sign-In Button
                              ElevatedButton(
                                onPressed: _handleGoogleSignIn,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: Colors.black87,
                                  elevation: 4,
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 22,
                                      height: 22,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: Image.network(
                                        'https://upload.wikimedia.org/wikipedia/commons/5/53/Google_%22G%22_Logo.svg',
                                        height: 20,
                                        width: 20,
                                        errorBuilder: (context, error, stackTrace) =>
                                            const Icon(Icons.g_mobiledata, color: Colors.red, size: 24),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    const Text(
                                      'Continue with Google',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                        letterSpacing: 0.2,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 14),

                              // Developer Mock Mode Bypass
                              OutlinedButton.icon(
                                onPressed: _bypassSignInWithMockData,
                                icon: const Icon(Icons.developer_mode, size: 16, color: Colors.white70),
                                label: Text(
                                  loc.translate('mock_dev_access'),
                                  style: const TextStyle(color: Colors.white70, fontSize: 13),
                                ),
                                style: OutlinedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(vertical: 14),
                                  side: BorderSide(color: Colors.white.withValues(alpha: 0.25)),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      const SizedBox(height: 28),

                      // CGU & Privacy Policy Notice
                      Text(
                        loc.translate('cgu_notice'),
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.white38, fontSize: 11, height: 1.4),
                      )
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

  Widget _buildRoleTab(String displayTitle, String roleKey, IconData icon) {
    final isSelected = _selectedRole == roleKey;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedRole = roleKey;
          _errorMessage = null;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppTheme.primaryColor.withValues(alpha: 0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : Colors.white60,
              size: 18,
            ),
            const SizedBox(width: 6),
            Flexible(
              child: Text(
                displayTitle,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.white60,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
