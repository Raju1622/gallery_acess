import 'package:flutter/material.dart';
import '../../models/purchase.dart';
import '../../models/fitness_program.dart';
import '../program/program_details_screen.dart';

class MyProgramsScreen extends StatefulWidget {
  const MyProgramsScreen({super.key});

  @override
  State<MyProgramsScreen> createState() => _MyProgramsScreenState();
}

class _MyProgramsScreenState extends State<MyProgramsScreen> {
  List<Purchase> _purchases = [];
  bool _isLoading = true;

  // Hardcoded sample purchases for demo
  final List<Purchase> _samplePurchases = [
    Purchase(
      id: 'p1',
      userId: 'demo_user',
      programId: '1',
      programTitle: 'Fat Burn Challenge',
      programCoverImageUrl: 'https://images.unsplash.com/photo-1517836357463-d25dfeac3438?w=400',
      price: 999,
      paymentId: 'pay_demo_001',
      purchasedAt: DateTime.now().subtract(const Duration(days: 10)),
      progressPercentage: 45,
    ),
    Purchase(
      id: 'p2',
      userId: 'demo_user',
      programId: '3',
      programTitle: 'Morning Yoga Flow',
      programCoverImageUrl: 'https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?w=400',
      price: 699,
      paymentId: 'pay_demo_002',
      purchasedAt: DateTime.now().subtract(const Duration(days: 5)),
      progressPercentage: 20,
    ),
    Purchase(
      id: 'p3',
      userId: 'demo_user',
      programId: '4',
      programTitle: 'HIIT Extreme',
      programCoverImageUrl: 'https://images.unsplash.com/photo-1434682881908-b43d0467b798?w=400',
      price: 1299,
      paymentId: 'pay_demo_003',
      purchasedAt: DateTime.now().subtract(const Duration(days: 2)),
      progressPercentage: 10,
    ),
  ];

  // Program details mapping for demo
  final Map<String, Map<String, String>> _programDetails = {
    '1': {
      'duration': '4 Weeks',
      'difficulty': 'Beginner',
      'trainer': 'Rahul Sharma',
      'description': 'A comprehensive 4-week program designed to help you burn fat effectively through a combination of cardio and strength training exercises.',
    },
    '3': {
      'duration': '30 Days',
      'difficulty': 'Beginner',
      'trainer': 'Priya Patel',
      'description': 'Start your day with energy and peace. This yoga program includes daily 30-minute sessions focusing on flexibility, balance, and mindfulness.',
    },
    '4': {
      'duration': '6 Weeks',
      'difficulty': 'Advanced',
      'trainer': 'Amit Kumar',
      'description': 'High-intensity interval training for maximum calorie burn. Short, intense workouts that fit into your busy schedule.',
    },
  };

  @override
  void initState() {
    super.initState();
    _loadPurchases();
  }

  Future<void> _loadPurchases() async {
    setState(() => _isLoading = true);

    await Future.delayed(const Duration(milliseconds: 500));

    if (mounted) {
      setState(() {
        _purchases = List.from(_samplePurchases);
        _isLoading = false;
      });
    }
  }

  Future<void> _updateProgress(Purchase purchase, int newProgress) async {
    final index = _purchases.indexWhere((p) => p.id == purchase.id);
    if (index != -1) {
      setState(() {
        _purchases[index] = purchase.copyWith(progressPercentage: newProgress);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Progress updated to $newProgress%!'),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 1),
        ),
      );
    }
  }

  void _showProgressDialog(Purchase purchase) {
    int tempProgress = purchase.progressPercentage;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle bar
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 24),

              Text(
                'Update Progress',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                purchase.programTitle,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[600],
                    ),
              ),
              const SizedBox(height: 32),

              // Progress Circle
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: CircularProgressIndicator(
                      value: tempProgress / 100,
                      strokeWidth: 12,
                      backgroundColor: Colors.grey[300],
                      color: _getProgressColor(tempProgress),
                    ),
                  ),
                  Text(
                    '$tempProgress%',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: _getProgressColor(tempProgress),
                        ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Slider
              Slider(
                value: tempProgress.toDouble(),
                min: 0,
                max: 100,
                divisions: 20,
                activeColor: _getProgressColor(tempProgress),
                label: '$tempProgress%',
                onChanged: (value) {
                  setDialogState(() => tempProgress = value.toInt());
                },
              ),
              const SizedBox(height: 24),

              // Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.all(16),
                      ),
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        _updateProgress(purchase, tempProgress);
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(16),
                        backgroundColor: _getProgressColor(tempProgress),
                      ),
                      child: const Text('Save'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Color _getProgressColor(int progress) {
    if (progress < 30) return Colors.red;
    if (progress < 70) return Colors.orange;
    return Colors.green;
  }

  void _viewProgramDetails(Purchase purchase) {
    final details = _programDetails[purchase.programId] ?? {};

    final program = FitnessProgram(
      id: purchase.programId,
      title: purchase.programTitle,
      description: details['description'] ?? 'Continue your fitness journey with this amazing program!',
      coverImageUrl: purchase.programCoverImageUrl,
      price: purchase.price,
      duration: details['duration'] ?? '4 Weeks',
      difficultyLevel: details['difficulty'] ?? 'Beginner',
      trainerName: details['trainer'] ?? 'Fitness Trainer',
      category: 'Fitness',
      createdAt: purchase.purchasedAt,
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProgramDetailsScreen(program: program),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Programs'),
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _purchases.isEmpty
              ? _buildEmptyState()
              : RefreshIndicator(
                  onRefresh: _loadPurchases,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _purchases.length,
                    itemBuilder: (context, index) => _buildPurchaseCard(_purchases[index]),
                  ),
                ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.fitness_center_outlined,
                size: 64,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'No Programs Yet',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'Purchase a program from Home to start your fitness journey!',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPurchaseCard(Purchase purchase) {
    final details = _programDetails[purchase.programId] ?? {};
    final progressColor = _getProgressColor(purchase.progressPercentage);

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      clipBehavior: Clip.antiAlias,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () => _viewProgramDetails(purchase),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cover Image with Progress Overlay
            Stack(
              children: [
                SizedBox(
                  height: 160,
                  width: double.infinity,
                  child: purchase.programCoverImageUrl.isNotEmpty
                      ? Image.network(
                          purchase.programCoverImageUrl,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Container(
                              color: Theme.of(context).colorScheme.primaryContainer,
                              child: const Center(child: CircularProgressIndicator()),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) => _buildPlaceholderImage(),
                        )
                      : _buildPlaceholderImage(),
                ),
                // Progress Badge
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: progressColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${purchase.progressPercentage}% Complete',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                // Difficulty Badge
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      details['difficulty'] ?? 'Beginner',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Program Info
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title and View Details
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          purchase.programTitle,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                      Icon(Icons.chevron_right, color: Colors.grey[400]),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Trainer and Duration
                  Row(
                    children: [
                      Icon(Icons.person_outline, size: 16, color: Colors.grey[600]),
                      const SizedBox(width: 4),
                      Text(
                        details['trainer'] ?? 'Trainer',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.grey[600],
                            ),
                      ),
                      const SizedBox(width: 16),
                      Icon(Icons.access_time, size: 16, color: Colors.grey[600]),
                      const SizedBox(width: 4),
                      Text(
                        details['duration'] ?? '4 Weeks',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.grey[600],
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Progress Bar with Edit Button
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Your Progress',
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                                Text(
                                  '${purchase.progressPercentage}%',
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: progressColor,
                                      ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: LinearProgressIndicator(
                                value: purchase.progressPercentage / 100,
                                backgroundColor: Colors.grey[200],
                                color: progressColor,
                                minHeight: 8,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: IconButton(
                          onPressed: () => _showProgressDialog(purchase),
                          icon: Icon(
                            Icons.edit,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          tooltip: 'Update Progress',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholderImage() {
    return Container(
      color: Theme.of(context).colorScheme.primaryContainer,
      child: Center(
        child: Icon(
          Icons.fitness_center,
          size: 48,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}
