import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../data/auth_repository.dart';

class LoginScreen extends StatefulWidget {
  final Function(Map<String, dynamic> sessionData) onAuthSuccess;

  const LoginScreen({super.key, required this.onAuthSuccess});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthRepository _authRepository = AuthRepository();
  String _selectedRole = 'Client'; // 'Client' or 'Agency'
  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _handleGoogleSignIn() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // For testing when not running on a real device with complete Google Sign-In certificates:
      // We will provide a fallback / mock authentication toggle in our UI.
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

  // Quick offline test mock to bypass real Google sign-in check on desktop/testing environment
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
    return Scaffold(
      body: Stack(
        children: [
          // Background Gradient decoration
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
                    // Brand Logo/Header
                    const Icon(
                      Icons.directions_car_filled_outlined,
                      size: 80,
                      color: AppTheme.primaryColor,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'siir',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                    const Text(
                      'La marketplace de location de voitures',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(height: 48),

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
                            child: _buildRoleTab('Client', Icons.person),
                          ),
                          Expanded(
                            child: _buildRoleTab('Agency', Icons.storefront),
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
                                ? 'Connectez-vous pour louer un véhicule'
                                : 'Accédez à votre espace agence vérifiée',
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
                              child: const Text('Mock Local Developer Access'),
                            ),
                          ],
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'En vous connectant, vous acceptez nos CGU & Charte de Confidentialité.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white54, fontSize: 11),
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

  Widget _buildRoleTab(String role, IconData icon) {
    final isSelected = _selectedRole == role;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedRole = role;
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
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              role == 'Client' ? 'Client (B2C)' : 'Agence (B2B)',
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.white70,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
