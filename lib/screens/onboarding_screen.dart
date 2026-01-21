import 'dart:ui';
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import 'role_selection_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingData> _pages = [
    OnboardingData(
      icon: Icons.fitness_center,
      title: 'Expert Fitness Programs',
      description:
          'Access premium workout programs designed by certified trainers to help you achieve your fitness goals.',
    ),
    OnboardingData(
      icon: Icons.track_changes,
      title: 'Track Your Progress',
      description:
          'Monitor your journey with detailed progress tracking. See how far you\'ve come and stay motivated.',
    ),
    OnboardingData(
      icon: Icons.restaurant_menu,
      title: 'Personalized Plans',
      description:
          'Get customized workout and nutrition plans tailored to your body type and fitness level.',
    ),
    OnboardingData(
      icon: Icons.people_outline,
      title: 'Join Our Community',
      description:
          'Connect with like-minded fitness enthusiasts. Share your journey and inspire others.',
    ),
  ];

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOutCubic,
      );
    } else {
      _goToRoleSelection();
    }
  }

  void _goToRoleSelection() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => const RoleSelectionScreen(),
        transitionsBuilder: (_, animation, __, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 400),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
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
            // Background decorations
            Positioned(
              top: -80,
              left: -80,
              child: Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.1),
                ),
              ),
            ),
            Positioned(
              bottom: -100,
              right: -50,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.08),
                ),
              ),
            ),

            // Main content
            SafeArea(
              child: Column(
                children: [
                  // Skip Button
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: GestureDetector(
                        onTap: _goToRoleSelection,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.white.withValues(alpha: 0.2),
                                Colors.white.withValues(alpha: 0.1),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.3),
                            ),
                          ),
                          child: const Text(
                            'Skip',
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Page View
                  Expanded(
                    child: PageView.builder(
                      controller: _pageController,
                      onPageChanged: (index) {
                        setState(() => _currentPage = index);
                      },
                      itemCount: _pages.length,
                      itemBuilder: (context, index) {
                        return _buildPage(_pages[index]);
                      },
                    ),
                  ),

                  // Bottom Section
                  Padding(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      children: [
                        // Page Indicators
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            _pages.length,
                            (index) => AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              width: _currentPage == index ? 32 : 10,
                              height: 10,
                              decoration: BoxDecoration(
                                color: _currentPage == index
                                    ? AppColors.white
                                    : Colors.white.withValues(alpha: 0.3),
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: _currentPage == index
                                    ? [
                                        BoxShadow(
                                          color: Colors.white.withValues(alpha: 0.5),
                                          blurRadius: 8,
                                        ),
                                      ]
                                    : null,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),

                        // Next/Get Started Button
                        GestureDetector(
                          onTap: _nextPage,
                          child: Container(
                            width: double.infinity,
                            height: 60,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.white.withValues(alpha: 0.25),
                                  Colors.white.withValues(alpha: 0.1),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.4),
                                width: 1.5,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.1),
                                  blurRadius: 20,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        _currentPage == _pages.length - 1
                                            ? 'Get Started'
                                            : 'Next',
                                        style: const TextStyle(
                                          color: AppColors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      const Icon(
                                        Icons.arrow_forward_rounded,
                                        color: AppColors.white,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Powered by Tryeno
                        Text(
                          'Powered by Tryeno',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.7),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPage(OnboardingData data) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Glass Icon Container
          Container(
            width: 160,
            height: 160,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white.withValues(alpha: 0.25),
                  Colors.white.withValues(alpha: 0.1),
                ],
              ),
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.3),
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 30,
                  offset: const Offset(0, 15),
                ),
              ],
            ),
            child: ClipOval(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Icon(
                  data.icon,
                  size: 80,
                  color: AppColors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 50),

          // Title
          Text(
            data.title,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: AppColors.white,
              letterSpacing: 0.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),

          // Description in glass container
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white.withValues(alpha: 0.15),
                  Colors.white.withValues(alpha: 0.05),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.2),
              ),
            ),
            child: Text(
              data.description,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white.withValues(alpha: 0.9),
                height: 1.6,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingData {
  final IconData icon;
  final String title;
  final String description;

  OnboardingData({
    required this.icon,
    required this.title,
    required this.description,
  });
}
