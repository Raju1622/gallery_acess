import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../constants/app_colors.dart';
import 'onboarding_screen.dart';
import 'main_navigation_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.elasticOut),
      ),
    );

    _slideAnimation = Tween<double>(begin: 50, end: 0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 0.8, curve: Curves.easeOut),
      ),
    );

    _controller.forward();
    _navigateToNext();
  }

  Future<void> _navigateToNext() async {
    await Future.delayed(const Duration(seconds: 3));

    if (mounted) {
      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => const MainNavigationScreen(),
            transitionsBuilder: (_, animation, __, child) {
              return FadeTransition(opacity: animation, child: child);
            },
            transitionDuration: const Duration(milliseconds: 500),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => const OnboardingScreen(),
            transitionsBuilder: (_, animation, __, child) {
              return FadeTransition(opacity: animation, child: child);
            },
            transitionDuration: const Duration(milliseconds: 500),
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
            // Background decoration circles
            Positioned(
              top: -100,
              right: -100,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.1),
                ),
              ),
            ),
            Positioned(
              bottom: -150,
              left: -100,
              child: Container(
                width: 400,
                height: 400,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.08),
                ),
              ),
            ),

            // Main content
            SafeArea(
              child: Center(
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return FadeTransition(
                      opacity: _fadeAnimation,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Glass Logo Container
                          Transform.scale(
                            scale: _scaleAnimation.value,
                            child: Container(
                              width: 140,
                              height: 140,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Colors.white.withValues(alpha: 0.3),
                                    Colors.white.withValues(alpha: 0.1),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(40),
                                border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.4),
                                  width: 2,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.2),
                                    blurRadius: 30,
                                    offset: const Offset(0, 15),
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(40),
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                  child: const Icon(
                                    Icons.fitness_center,
                                    size: 70,
                                    color: AppColors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 40),

                          // App Name with slide animation
                          Transform.translate(
                            offset: Offset(0, _slideAnimation.value),
                            child: Column(
                              children: [
                                const Text(
                                  'Taecaliso',
                                  style: TextStyle(
                                    fontSize: 42,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.white,
                                    letterSpacing: 3,
                                  ),
                                ),
                                const Text(
                                  'Health Heaven',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w300,
                                    color: AppColors.white,
                                    letterSpacing: 6,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 60),

                          // Welcome text in glass container
                          Transform.translate(
                            offset: Offset(0, _slideAnimation.value),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.white.withValues(alpha: 0.2),
                                    Colors.white.withValues(alpha: 0.1),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.3),
                                ),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    'Welcome to Tryeno App',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.white.withValues(alpha: 0.95),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Your Fitness Journey Starts Here',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: AppColors.white.withValues(alpha: 0.8),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 80),

                          // Loading indicator
                          SizedBox(
                            width: 50,
                            height: 50,
                            child: CircularProgressIndicator(
                              strokeWidth: 3,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                AppColors.white.withValues(alpha: 0.8),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
