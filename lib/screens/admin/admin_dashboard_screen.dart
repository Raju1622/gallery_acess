import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../constants/app_colors.dart';
import '../../services/google_sign_in_service.dart';
import '../splash_screen.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  final GoogleSignInService _googleSignInService = GoogleSignInService();
  final user = FirebaseAuth.instance.currentUser;

  // Sample stats for demo
  final Map<String, int> _stats = {
    'Total Programs': 12,
    'Total Users': 156,
    'Active Subscriptions': 89,
    'Total Revenue': 45600,
  };

  Future<void> _logout() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.white,
            ),
            child: const Text('Logout'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await _googleSignInService.signOut();
      if (mounted) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const SplashScreen()),
          (route) => false,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        centerTitle: true,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              color: AppColors.error.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              onPressed: _logout,
              icon: const Icon(Icons.logout, color: AppColors.error),
              tooltip: 'Logout',
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Glass Welcome Card
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: AppColors.splashGradient,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.35),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  // Background decoration
                  Positioned(
                    top: -40,
                    right: -30,
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withValues(alpha: 0.1),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -30,
                    left: -20,
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withValues(alpha: 0.08),
                      ),
                    ),
                  ),
                  // Content
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            // Glass avatar container
                            Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.white.withValues(alpha: 0.4),
                                    Colors.white.withValues(alpha: 0.1),
                                  ],
                                ),
                                border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.5),
                                  width: 2,
                                ),
                              ),
                              child: CircleAvatar(
                                radius: 30,
                                backgroundColor: AppColors.white,
                                backgroundImage: user?.photoURL != null
                                    ? NetworkImage(user!.photoURL!)
                                    : null,
                                child: user?.photoURL == null
                                    ? const Icon(
                                        Icons.admin_panel_settings,
                                        color: AppColors.primary,
                                        size: 30,
                                      )
                                    : null,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Welcome Admin,',
                                    style: TextStyle(
                                      color: AppColors.white.withValues(alpha: 0.9),
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    user?.displayName ?? 'Admin',
                                    style: const TextStyle(
                                      color: AppColors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        // Glass branding container
                        ClipRRect(
                          borderRadius: BorderRadius.circular(14),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.white.withValues(alpha: 0.2),
                                    Colors.white.withValues(alpha: 0.1),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.25),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.fitness_center,
                                    size: 18,
                                    color: AppColors.white,
                                  ),
                                  const SizedBox(width: 10),
                                  const Text(
                                    'Taecaliso Health Heaven',
                                    style: TextStyle(
                                      color: AppColors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    '• by Tryeno',
                                    style: TextStyle(
                                      color: AppColors.white.withValues(alpha: 0.7),
                                      fontSize: 11,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Stats Grid
            Text(
              'Overview',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 1.3,
              children: [
                _buildStatCard(
                  'Total Programs',
                  _stats['Total Programs'].toString(),
                  Icons.fitness_center,
                  AppColors.primary,
                ),
                _buildStatCard(
                  'Total Users',
                  _stats['Total Users'].toString(),
                  Icons.people,
                  AppColors.success,
                ),
                _buildStatCard(
                  'Subscriptions',
                  _stats['Active Subscriptions'].toString(),
                  Icons.subscriptions,
                  AppColors.warning,
                ),
                _buildStatCard(
                  'Revenue',
                  '₹${_stats['Total Revenue']}',
                  Icons.currency_rupee,
                  AppColors.accent,
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Quick Actions
            Text(
              'Quick Actions',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            _buildActionTile(
              icon: Icons.add_circle_outline,
              title: 'Add New Program',
              subtitle: 'Create a new fitness program',
              color: AppColors.primary,
              onTap: () => _showComingSoon('Add Program'),
            ),
            const SizedBox(height: 12),
            _buildActionTile(
              icon: Icons.campaign,
              title: 'Post Announcement',
              subtitle: 'Send announcement to all users',
              color: AppColors.accent,
              onTap: () => _showComingSoon('Post Announcement'),
            ),
            const SizedBox(height: 12),
            _buildActionTile(
              icon: Icons.people_outline,
              title: 'Manage Users',
              subtitle: 'View and manage user accounts',
              color: AppColors.success,
              onTap: () => _showComingSoon('Manage Users'),
            ),
            const SizedBox(height: 12),
            _buildActionTile(
              icon: Icons.analytics_outlined,
              title: 'View Reports',
              subtitle: 'Analytics and performance reports',
              color: AppColors.warning,
              onTap: () => _showComingSoon('View Reports'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const Spacer(),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.grey600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(color: AppColors.grey500, fontSize: 12),
        ),
        trailing: const Icon(Icons.chevron_right, color: AppColors.grey400),
        onTap: onTap,
      ),
    );
  }

  void _showComingSoon(String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$feature - Coming Soon!'),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
