import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../constants/app_colors.dart';
import '../../services/firestore_service.dart';
import '../../services/google_sign_in_service.dart';
import '../../models/user_profile.dart';
import '../splash_screen.dart';
import 'edit_profile_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final FirestoreService _firestoreService = FirestoreService();
  final GoogleSignInService _googleSignInService = GoogleSignInService();

  UserProfile? _userProfile;
  bool _isLoading = true;

  static const String _supportEmail = 'fitnessapp.support@gmail.com';
  static const String _privacyPolicyUrl = 'https://www.google.com/policies/privacy/';
  static const String _termsUrl = 'https://www.google.com/policies/terms/';

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    final user = FirebaseAuth.instance.currentUser;

    await Future.delayed(const Duration(milliseconds: 300));

    if (mounted) {
      setState(() {
        if (user != null) {
          _userProfile = UserProfile(
            uid: user.uid,
            email: user.email ?? 'demo@example.com',
            displayName: user.displayName ?? 'Fitness User',
            photoUrl: user.photoURL ?? '',
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          );
        }
        _isLoading = false;
      });
    }
  }

  Future<void> _contactSupport() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: _supportEmail,
      queryParameters: {'subject': 'Support Request - FitLife Pro'},
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Could not open email app'),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        );
      }
    }
  }

  Future<void> _openUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Could not open link'),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        );
      }
    }
  }

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
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Colors.white,
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

  Future<void> _deleteAccount() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Icon(Icons.warning_amber_rounded, color: Colors.red[700]),
            const SizedBox(width: 8),
            const Text('Delete Account'),
          ],
        ),
        content: const Text(
          'This action cannot be undone. All your data including purchased programs will be permanently deleted.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red[700],
              foregroundColor: Colors.white,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        final user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          await _firestoreService.deleteUserAccount(user.uid);
          await user.delete();

          if (mounted) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => const SplashScreen()),
              (route) => false,
            );
          }
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error: $e'),
              backgroundColor: Colors.red[700],
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
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
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // Profile Card
                  _buildProfileCard(user),
                  const SizedBox(height: 24),

                  // Account Section
                  _buildSectionTitle('Account'),
                  const SizedBox(height: 12),
                  _buildSettingsCard([
                    _buildSettingsTile(
                      icon: Icons.person_outline,
                      iconColor: AppColors.primary,
                      title: 'Edit Profile',
                      subtitle: 'Update your name and photo',
                      onTap: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => EditProfileScreen(userProfile: _userProfile),
                          ),
                        );
                        if (result == true) _loadUserProfile();
                      },
                    ),
                  ]),
                  const SizedBox(height: 24),

                  // Support Section
                  _buildSectionTitle('Support'),
                  const SizedBox(height: 12),
                  _buildSettingsCard([
                    _buildSettingsTile(
                      icon: Icons.mail_outline,
                      iconColor: AppColors.success,
                      title: 'Contact Support',
                      subtitle: _supportEmail,
                      onTap: _contactSupport,
                    ),
                  ]),
                  const SizedBox(height: 24),

                  // Legal Section
                  _buildSectionTitle('Legal'),
                  const SizedBox(height: 12),
                  _buildSettingsCard([
                    _buildSettingsTile(
                      icon: Icons.privacy_tip_outlined,
                      iconColor: AppColors.secondary,
                      title: 'Privacy Policy',
                      onTap: () => _openUrl(_privacyPolicyUrl),
                    ),
                    const Divider(height: 1, color: AppColors.grey200),
                    _buildSettingsTile(
                      icon: Icons.description_outlined,
                      iconColor: AppColors.warning,
                      title: 'Terms & Conditions',
                      onTap: () => _openUrl(_termsUrl),
                    ),
                  ]),
                  const SizedBox(height: 24),

                  // Danger Zone
                  _buildSectionTitle('Danger Zone'),
                  const SizedBox(height: 12),
                  _buildSettingsCard([
                    _buildSettingsTile(
                      icon: Icons.delete_forever_outlined,
                      iconColor: AppColors.error,
                      title: 'Delete Account',
                      subtitle: 'Permanently delete your account',
                      titleColor: AppColors.error,
                      onTap: _deleteAccount,
                    ),
                  ]),
                  const SizedBox(height: 40),

                  // Branding Footer
                  Center(
                    child: Column(
                      children: [
                        const Text(
                          'Taecaliso Health Heaven',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.grey600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Powered by Tryeno',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.grey500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
    );
  }

  Widget _buildProfileCard(User? user) {
    final displayName = _userProfile?.displayName ?? user?.displayName ?? 'User';
    final email = _userProfile?.email ?? user?.email ?? '';
    final photoUrl = _userProfile?.photoUrl ?? user?.photoURL ?? '';

    return Container(
      decoration: BoxDecoration(
        gradient: AppColors.splashGradient,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Background decoration circles
          Positioned(
            top: -30,
            right: -20,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.1),
              ),
            ),
          ),
          Positioned(
            bottom: -20,
            left: -20,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.08),
              ),
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
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
                    radius: 35,
                    backgroundColor: AppColors.white,
                    backgroundImage: photoUrl.isNotEmpty ? NetworkImage(photoUrl) : null,
                    child: photoUrl.isEmpty
                        ? Text(
                            displayName.isNotEmpty ? displayName[0].toUpperCase() : 'U',
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
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
                        displayName,
                        style: const TextStyle(
                          color: AppColors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 6),
                      // Glass email container
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.email_outlined,
                              size: 14,
                              color: Colors.white.withValues(alpha: 0.9),
                            ),
                            const SizedBox(width: 6),
                            Flexible(
                              child: Text(
                                email,
                                style: TextStyle(
                                  color: AppColors.white.withValues(alpha: 0.9),
                                  fontSize: 12,
                                ),
                                overflow: TextOverflow.ellipsis,
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
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColors.grey600,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildSettingsCard(List<Widget> children) {
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
      child: Column(children: children),
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required Color iconColor,
    required String title,
    String? subtitle,
    Color? titleColor,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: iconColor.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: iconColor, size: 22),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: titleColor ?? AppColors.black,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle,
              style: const TextStyle(color: AppColors.grey500, fontSize: 12),
            )
          : null,
      trailing: const Icon(Icons.chevron_right, color: AppColors.grey400),
      onTap: onTap,
    );
  }
}
