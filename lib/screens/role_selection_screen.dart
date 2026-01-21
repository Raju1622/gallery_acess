import 'dart:ui';
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../services/google_sign_in_service.dart';
import 'main_navigation_screen.dart';
import 'admin/admin_dashboard_screen.dart';

class RoleSelectionScreen extends StatefulWidget {
  const RoleSelectionScreen({super.key});

  @override
  State<RoleSelectionScreen> createState() => _RoleSelectionScreenState();
}

class _RoleSelectionScreenState extends State<RoleSelectionScreen> {
  final GoogleSignInService _googleSignInService = GoogleSignInService();
  String? _selectedRole;
  bool _isLoading = false;

  Future<void> _handleGoogleSignIn() async {
    if (_selectedRole == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please select a role first'),
          backgroundColor: AppColors.warning,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final success = await _googleSignInService.signInWithGoogle();

      if (success && mounted) {
        if (_selectedRole == 'admin') {
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (_, __, ___) => const AdminDashboardScreen(),
              transitionsBuilder: (_, animation, __, child) {
                return FadeTransition(opacity: animation, child: child);
              },
            ),
          );
        } else {
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (_, __, ___) => const MainNavigationScreen(),
              transitionsBuilder: (_, animation, __, child) {
                return FadeTransition(opacity: animation, child: child);
              },
            ),
          );
        }
      } else if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Sign in canceled'),
            backgroundColor: AppColors.warning,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString()}'),
            backgroundColor: AppColors.error,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: AppColors.splashGradient,
        ),
        child: Stack(
          children: [
            // Background decorations
            Positioned(
              top: -100,
              right: -80,
              child: Container(
                width: 280,
                height: 280,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.1),
                ),
              ),
            ),
            Positioned(
              bottom: -120,
              left: -60,
              child: Container(
                width: 320,
                height: 320,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.08),
                ),
              ),
            ),

            // Main content
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    const Spacer(),

                    // Glass Logo Container
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.white.withValues(alpha: 0.3),
                            Colors.white.withValues(alpha: 0.1),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.4),
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.2),
                            blurRadius: 25,
                            offset: const Offset(0, 12),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: const Icon(
                            Icons.fitness_center,
                            size: 50,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    const Text(
                      'Taecaliso Health Heaven',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.white,
                        letterSpacing: 1,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Select your role to continue',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white.withValues(alpha: 0.8),
                      ),
                    ),

                    const Spacer(),

                    // Role Selection Cards
                    Row(
                      children: [
                        Expanded(
                          child: _buildGlassRoleCard(
                            role: 'user',
                            icon: Icons.person,
                            title: 'User',
                            description: 'Access fitness programs',
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildGlassRoleCard(
                            role: 'admin',
                            icon: Icons.admin_panel_settings,
                            title: 'Admin',
                            description: 'Manage programs',
                          ),
                        ),
                      ],
                    ),

                    const Spacer(),

                    // Google Sign In Button
                    GestureDetector(
                      onTap: _isLoading ? null : _handleGoogleSignIn,
                      child: Container(
                        width: double.infinity,
                        height: 60,
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.15),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: _isLoading
                            ? const Center(
                                child: SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.5,
                                    color: AppColors.primary,
                                  ),
                                ),
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/images/google_logo.png',
                                    height: 24,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        width: 24,
                                        height: 24,
                                        decoration: BoxDecoration(
                                          gradient: AppColors.buttonGradient,
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                        child: const Center(
                                          child: Text('G',
                                              style: TextStyle(
                                                  color: AppColors.white,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                      );
                                    },
                                  ),
                                  const SizedBox(width: 12),
                                  const Text(
                                    'Continue with Google',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.black,
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Powered by Tryeno
                    Text(
                      'Powered by Tryeno',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.7),
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'By continuing, you agree to our Terms of Service',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.6),
                        fontSize: 11,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const Spacer(flex: 1),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGlassRoleCard({
    required String role,
    required IconData icon,
    required String title,
    required String description,
  }) {
    final isSelected = _selectedRole == role;

    return GestureDetector(
      onTap: () => setState(() => _selectedRole = role),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isSelected
                ? [
                    Colors.white.withValues(alpha: 0.35),
                    Colors.white.withValues(alpha: 0.15),
                  ]
                : [
                    Colors.white.withValues(alpha: 0.2),
                    Colors.white.withValues(alpha: 0.08),
                  ],
          ),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected
                ? Colors.white.withValues(alpha: 0.6)
                : Colors.white.withValues(alpha: 0.3),
            width: isSelected ? 2 : 1.5,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.white.withValues(alpha: 0.2),
                    blurRadius: 20,
                    offset: const Offset(0, 5),
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
            child: Column(
              children: [
                // Selection indicator
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.white : Colors.transparent,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.white,
                      width: 2,
                    ),
                  ),
                  child: isSelected
                      ? const Icon(Icons.check, size: 18, color: AppColors.primary)
                      : null,
                ),
                const SizedBox(height: 16),

                // Icon
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.white.withValues(alpha: 0.3),
                        Colors.white.withValues(alpha: 0.1),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Icon(icon, size: 35, color: AppColors.white),
                ),
                const SizedBox(height: 16),

                // Title
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),
                ),
                const SizedBox(height: 6),

                // Description
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white.withValues(alpha: 0.8),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
