import 'package:flutter/material.dart';
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
  List<String> _categories = ['Weight Loss', 'Muscle Building', 'Yoga', 'Cardio', 'HIIT'];
  bool _isLoading = true;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fitness Programs'),
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadData,
              child: CustomScrollView(
                slivers: [
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
                return Container(
                  width: 280,
                  margin: const EdgeInsets.only(right: 12),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.campaign, size: 20, color: Colors.deepPurple),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  announcement.title,
                                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Expanded(
                            child: Text(
                              announcement.description,
                              style: Theme.of(context).textTheme.bodySmall,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
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
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cover Image
            Expanded(
              flex: 3,
              child: program.coverImageUrl.isNotEmpty
                  ? Image.network(
                      program.coverImageUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          child: const Center(child: CircularProgressIndicator()),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) => _buildPlaceholderImage(program),
                    )
                  : _buildPlaceholderImage(program),
            ),
            // Program Info
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      program.title,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      program.trainerName,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.grey[600],
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '₹${program.price.toStringAsFixed(0)}',
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: _getDifficultyColor(program.difficultyLevel),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            program.difficultyLevel,
                            style: const TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
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
    );
  }

  Widget _buildPlaceholderImage(FitnessProgram program) {
    return Container(
      color: Theme.of(context).colorScheme.primaryContainer,
      child: Center(
        child: Icon(
          _getCategoryIcon(program.category),
          size: 48,
          color: Theme.of(context).colorScheme.primary,
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
