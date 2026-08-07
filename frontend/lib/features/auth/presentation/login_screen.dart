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
        _errorMessage = 'Authentication Error: Please check your backend connection.';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
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
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppTheme.secondaryColor, Color(0xFF0F1E1E)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Language Switcher Top Bar
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        DropdownButton<AppLanguage>(
                          value: widget.currentLanguage,
                          dropdownColor: AppTheme.secondaryColor,
                          icon: const Icon(Icons.language, color: Colors.white),
                          underline: Container(),
                          items: const [
                            DropdownMenuItem(value: AppLanguage.fr, child: Text('Français', style: TextStyle(color: Colors.white))),
                            DropdownMenuItem(value: AppLanguage.en, child: Text('English', style: TextStyle(color: Colors.white))),
                            DropdownMenuItem(value: AppLanguage.ar, child: Text('العربية', style: TextStyle(color: Colors.white))),
                          ],
                          onChanged: (lang) {
                            if (lang != null) widget.onLanguageChanged(lang);
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Brand Logo/Header
                    Image.asset(
                      'assets/images/logo.png',
                      height: 120,
                      fit: BoxFit.contain,
                    ),
                    Text(
                      loc.translate('app_subtitle'),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Role selector container
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: _buildRoleTab(loc.translate('client_b2c'), 'Client', Icons.person),
                          ),
                          Expanded(
                            child: _buildRoleTab(loc.translate('agency_b2b'), 'Agency', Icons.storefront),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Card block for actions
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 15,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            _selectedRole == 'Client'
                                ? loc.translate('client_login_desc')
                                : loc.translate('agency_login_desc'),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimaryColor,
                            ),
                          ),
                          const SizedBox(height: 24),

                          if (_errorMessage != null) ...[
                            Text(
                              _errorMessage!,
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: Colors.red, fontSize: 13),
                            ),
                            const SizedBox(height: 16),
                          ],

                          if (_isLoading)
                            const Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primaryColor),
                              ),
                            )
                          else ...[
                            ElevatedButton.icon(
                              onPressed: _handleGoogleSignIn,
                              icon: const Icon(Icons.login),
                              label: const Text('Google Sign-In'),
                            ),
                            const SizedBox(height: 12),
                            OutlinedButton(
                              onPressed: _bypassSignInWithMockData,
                              child: Text(loc.translate('mock_dev_access')),
                            ),
                          ],
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      loc.translate('cgu_notice'),
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white54, fontSize: 11),
                    )
                  ],
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
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : Colors.white70,
              size: 18,
            ),
            const SizedBox(width: 6),
            Flexible(
              child: Text(
                displayTitle,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.white70,
                  fontWeight: FontWeight.bold,
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
