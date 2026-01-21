import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../constants/app_colors.dart';
import '../../models/fitness_program.dart';
import '../../models/announcement.dart';
import '../program/program_details_screen.dart';
import '../announcements/announcements_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  List<FitnessProgram> _programs = [];
  List<Announcement> _announcements = [];
  final List<String> _categories = ['Weight Loss', 'Muscle Building', 'Yoga', 'Cardio', 'HIIT'];
  bool _isLoading = true;
  final user = FirebaseAuth.instance.currentUser;

  TabController? _tabController;

  // Hardcoded sample programs
  final List<FitnessProgram> _samplePrograms = [
    FitnessProgram(
      id: '1',
      title: 'Fat Burn Challenge',
      description: 'A comprehensive 4-week program designed to help you burn fat effectively through a combination of cardio and strength training exercises. Perfect for beginners looking to start their fitness journey.',
      coverImageUrl: 'https://images.unsplash.com/photo-1517836357463-d25dfeac3438?w=400',
      price: 999,
      duration: '4 Weeks',
      difficultyLevel: 'Beginner',
      trainerName: 'Rahul Sharma',
      category: 'Weight Loss',
      createdAt: DateTime.now(),
    ),
    FitnessProgram(
      id: '2',
      title: 'Muscle Mass Builder',
      description: 'Build lean muscle mass with this 8-week intensive program. Includes detailed workout plans, nutrition guide, and progressive overload techniques for maximum gains.',
      coverImageUrl: 'https://images.unsplash.com/photo-1581009146145-b5ef050c149a?w=400',
      price: 1499,
      duration: '8 Weeks',
      difficultyLevel: 'Intermediate',
      trainerName: 'Vikram Singh',
      category: 'Muscle Building',
      createdAt: DateTime.now(),
    ),
    FitnessProgram(
      id: '3',
      title: 'Morning Yoga Flow',
      description: 'Start your day with energy and peace. This yoga program includes daily 30-minute sessions focusing on flexibility, balance, and mindfulness.',
      coverImageUrl: 'https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?w=400',
      price: 699,
      duration: '30 Days',
      difficultyLevel: 'Beginner',
      trainerName: 'Priya Patel',
      category: 'Yoga',
      createdAt: DateTime.now(),
    ),
    FitnessProgram(
      id: '4',
      title: 'HIIT Extreme',
      description: 'High-intensity interval training for maximum calorie burn. Short, intense workouts that fit into your busy schedule. Get results in just 20 minutes a day!',
      coverImageUrl: 'https://images.unsplash.com/photo-1434682881908-b43d0467b798?w=400',
      price: 1299,
      duration: '6 Weeks',
      difficultyLevel: 'Advanced',
      trainerName: 'Amit Kumar',
      category: 'HIIT',
      createdAt: DateTime.now(),
    ),
    FitnessProgram(
      id: '5',
      title: 'Cardio Blast',
      description: 'Improve your cardiovascular health with this fun and engaging cardio program. Includes dance workouts, running plans, and cycling routines.',
      coverImageUrl: 'https://images.unsplash.com/photo-1538805060514-97d9cc17730c?w=400',
      price: 799,
      duration: '4 Weeks',
      difficultyLevel: 'Beginner',
      trainerName: 'Sneha Gupta',
      category: 'Cardio',
      createdAt: DateTime.now(),
    ),
    FitnessProgram(
      id: '6',
      title: 'Advanced Yoga',
      description: 'Take your yoga practice to the next level with advanced poses, inversions, and meditation techniques. For experienced practitioners only.',
      coverImageUrl: 'https://images.unsplash.com/photo-1506126613408-eca07ce68773?w=400',
      price: 1199,
      duration: '8 Weeks',
      difficultyLevel: 'Advanced',
      trainerName: 'Priya Patel',
      category: 'Yoga',
      createdAt: DateTime.now(),
    ),
    FitnessProgram(
      id: '7',
      title: 'Strength Foundation',
      description: 'Learn proper form and build a strong foundation for weight training. Perfect for those new to the gym who want to lift safely and effectively.',
      coverImageUrl: 'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?w=400',
      price: 1099,
      duration: '6 Weeks',
      difficultyLevel: 'Beginner',
      trainerName: 'Vikram Singh',
      category: 'Muscle Building',
      createdAt: DateTime.now(),
    ),
    FitnessProgram(
      id: '8',
      title: 'Total Body Transform',
      description: 'Complete body transformation program combining weight loss, muscle toning, and flexibility. Includes meal plans and weekly check-ins.',
      coverImageUrl: 'https://images.unsplash.com/photo-1571019614242-c5c5dee9f50b?w=400',
      price: 2499,
      duration: '12 Weeks',
      difficultyLevel: 'Intermediate',
      trainerName: 'Rahul Sharma',
      category: 'Weight Loss',
      createdAt: DateTime.now(),
    ),
  ];

  // Hardcoded sample announcements
  final List<Announcement> _sampleAnnouncements = [
    Announcement(
      id: '1',
      title: 'New Year Sale - 50% Off!',
      description: 'Start your fitness journey with our biggest sale of the year. All programs at 50% discount. Limited time offer!',
      date: DateTime.now(),
    ),
    Announcement(
      id: '2',
      title: 'New Program Launch',
      description: 'Introducing our new "Total Body Transform" program. 12 weeks to a new you!',
      date: DateTime.now().subtract(const Duration(days: 2)),
    ),
    Announcement(
      id: '3',
      title: 'Live Session Tomorrow',
      description: 'Join trainer Priya Patel for a free live yoga session tomorrow at 7 AM.',
      date: DateTime.now().subtract(const Duration(days: 5)),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);

    // Use hardcoded data
    await Future.delayed(const Duration(milliseconds: 500)); // Simulate loading

    if (mounted) {
      setState(() {
        _programs = _samplePrograms;
        _announcements = _sampleAnnouncements;
        _isLoading = false;

        _tabController?.dispose();
        _tabController = TabController(
          length: _categories.length + 1,
          vsync: this,
        );
      });
    }
  }

  List<FitnessProgram> _getFilteredPrograms(int tabIndex) {
    if (tabIndex == 0) return _programs;
    final category = _categories[tabIndex - 1];
    return _programs.where((p) => p.category == category).toList();
  }

  void _showAnnouncementDetails(Announcement announcement) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.5,
        minChildSize: 0.3,
        maxChildSize: 0.8,
        expand: false,
        builder: (context, scrollController) => SingleChildScrollView(
          controller: scrollController,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Handle bar
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Icon and Title
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.campaign,
                        color: Theme.of(context).colorScheme.primary,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        announcement.title,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Date
                Text(
                  _formatDate(announcement.date),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[600],
                      ),
                ),
                const SizedBox(height: 24),

                // Description
                Text(
                  announcement.description,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        height: 1.6,
                      ),
                ),
                const SizedBox(height: 24),

                // Close button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Close'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    final userName = user?.displayName?.split(' ').first ?? 'User';

    return Scaffold(
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadData,
              child: CustomScrollView(
                slivers: [
                  // Custom App Bar with Welcome Header
                  SliverToBoxAdapter(
                    child: _buildWelcomeHeader(userName),
                  ),

                  // Announcements Section
                  if (_announcements.isNotEmpty)
                    SliverToBoxAdapter(
                      child: _buildAnnouncementsSection(),
                    ),

                  // Category Tabs
                  if (_tabController != null)
                    SliverToBoxAdapter(
                      child: _buildCategoryTabs(),
                    ),

                  // Programs Grid
                  SliverPadding(
                    padding: const EdgeInsets.all(16),
                    sliver: _buildProgramsGrid(),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildWelcomeHeader(String userName) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 16,
        left: 20,
        right: 20,
        bottom: 24,
      ),
      decoration: BoxDecoration(
        gradient: AppColors.splashGradient,
      ),
      child: Stack(
        children: [
          // Background decoration circles
          Positioned(
            top: -60,
            right: -40,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.1),
              ),
            ),
          ),
          Positioned(
            bottom: -30,
            left: -30,
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hello $userName,',
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: AppColors.white,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Welcome to your fitness journey',
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.white.withValues(alpha: 0.9),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Glass Avatar Container
                  Container(
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          Colors.white.withValues(alpha: 0.4),
                          Colors.white.withValues(alpha: 0.1),
                        ],
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 26,
                      backgroundColor: AppColors.white,
                      backgroundImage: user?.photoURL != null
                          ? NetworkImage(user!.photoURL!)
                          : null,
                      child: user?.photoURL == null
                          ? Text(
                              userName.isNotEmpty ? userName[0].toUpperCase() : 'U',
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                              ),
                            )
                          : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Glass branding card
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.white.withValues(alpha: 0.25),
                          Colors.white.withValues(alpha: 0.1),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(Icons.fitness_center, size: 20, color: AppColors.white),
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Taecaliso Health Heaven',
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                'Your Fitness Partner',
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          'by Tryeno',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.7),
                            fontSize: 10,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAnnouncementsSection() {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Announcements',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const AnnouncementsScreen(),
                    ),
                  );
                },
                child: const Text('View All'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _announcements.length > 3 ? 3 : _announcements.length,
              itemBuilder: (context, index) {
                final announcement = _announcements[index];
                return GestureDetector(
                  onTap: () => _showAnnouncementDetails(announcement),
                  child: Container(
                    width: 280,
                    margin: const EdgeInsets.only(right: 12),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          AppColors.primary.withValues(alpha: 0.15),
                          AppColors.secondary.withValues(alpha: 0.08),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AppColors.primary.withValues(alpha: 0.2),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: 0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                gradient: AppColors.buttonGradient,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(Icons.campaign, size: 16, color: AppColors.white),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                announcement.title,
                                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primary,
                                    ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Expanded(
                          child: Text(
                            announcement.description,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: AppColors.grey600,
                                ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryTabs() {
    return TabBar(
      controller: _tabController,
      isScrollable: true,
      onTap: (index) => setState(() {}),
      tabs: [
        const Tab(text: 'All'),
        ..._categories.map((c) => Tab(text: c)),
      ],
    );
  }

  Widget _buildProgramsGrid() {
    final filteredPrograms = _getFilteredPrograms(_tabController?.index ?? 0);

    if (filteredPrograms.isEmpty) {
      return const SliverFillRemaining(
        child: Center(
          child: Text('No programs available'),
        ),
      );
    }

    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) => _buildProgramCard(filteredPrograms[index]),
        childCount: filteredPrograms.length,
      ),
    );
  }

  Widget _buildProgramCard(FitnessProgram program) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProgramDetailsScreen(program: program),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.08),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Cover Image with gradient overlay
              Expanded(
                flex: 3,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    program.coverImageUrl.isNotEmpty
                        ? Image.network(
                            program.coverImageUrl,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      AppColors.primary.withValues(alpha: 0.3),
                                      AppColors.secondary.withValues(alpha: 0.2),
                                    ],
                                  ),
                                ),
                                child: const Center(
                                  child: CircularProgressIndicator(
                                    color: AppColors.white,
                                    strokeWidth: 2,
                                  ),
                                ),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) => _buildPlaceholderImage(program),
                          )
                        : _buildPlaceholderImage(program),
                    // Gradient overlay at bottom
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withValues(alpha: 0.3),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Difficulty badge
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: _getDifficultyColor(program.difficultyLevel),
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: _getDifficultyColor(program.difficultyLevel).withValues(alpha: 0.4),
                              blurRadius: 6,
                            ),
                          ],
                        ),
                        child: Text(
                          program.difficultyLevel,
                          style: const TextStyle(
                            fontSize: 9,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Program Info
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        program.title,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.person_outline,
                            size: 12,
                            color: AppColors.grey500,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              program.trainerName,
                              style: const TextStyle(
                                fontSize: 11,
                                color: AppColors.grey500,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              gradient: AppColors.buttonGradient,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              '₹${program.price.toStringAsFixed(0)}',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.schedule,
                                size: 12,
                                color: AppColors.grey500,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                program.duration,
                                style: const TextStyle(
                                  fontSize: 10,
                                  color: AppColors.grey500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlaceholderImage(FitnessProgram program) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary.withValues(alpha: 0.4),
            AppColors.secondary.withValues(alpha: 0.3),
          ],
        ),
      ),
      child: Center(
        child: Icon(
          _getCategoryIcon(program.category),
          size: 48,
          color: AppColors.white,
        ),
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'weight loss':
        return Icons.local_fire_department;
      case 'muscle building':
        return Icons.fitness_center;
      case 'yoga':
        return Icons.self_improvement;
      case 'cardio':
        return Icons.directions_run;
      case 'hiit':
        return Icons.flash_on;
      default:
        return Icons.sports_gymnastics;
    }
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'beginner':
        return Colors.green;
      case 'intermediate':
        return Colors.orange;
      case 'advanced':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
