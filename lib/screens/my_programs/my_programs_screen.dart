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
  ];

  @override
  void initState() {
    super.initState();
    _loadPurchases();
  }

  Future<void> _loadPurchases() async {
    setState(() => _isLoading = true);

    // Use hardcoded sample data for demo
    await Future.delayed(const Duration(milliseconds: 500));

    if (mounted) {
      setState(() {
        _purchases = _samplePurchases;
        _isLoading = false;
      });
    }
  }

  Future<void> _updateProgress(Purchase purchase, int newProgress) async {
    // Update locally for demo
    final index = _purchases.indexWhere((p) => p.id == purchase.id);
    if (index != -1) {
      setState(() {
        _purchases[index] = purchase.copyWith(progressPercentage: newProgress);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Progress updated!'),
          duration: Duration(seconds: 1),
        ),
      );
    }
  }

  void _showProgressDialog(Purchase purchase) {
    int tempProgress = purchase.progressPercentage;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('Update Progress'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${tempProgress}%',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
              const SizedBox(height: 16),
              Slider(
                value: tempProgress.toDouble(),
                min: 0,
                max: 100,
                divisions: 20,
                label: '$tempProgress%',
                onChanged: (value) {
                  setDialogState(() => tempProgress = value.toInt());
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _updateProgress(purchase, tempProgress);
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _viewProgramDetails(Purchase purchase) async {
    // Create a FitnessProgram from purchase data for demo
    final program = FitnessProgram(
      id: purchase.programId,
      title: purchase.programTitle,
      description: 'This is your purchased program. Continue your fitness journey!',
      coverImageUrl: purchase.programCoverImageUrl,
      price: purchase.price,
      duration: '4 Weeks',
      difficultyLevel: 'Beginner',
      trainerName: 'Fitness Trainer',
      category: 'Fitness',
      createdAt: purchase.purchasedAt,
    );

    if (mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ProgramDetailsScreen(program: program),
        ),
      );
    }
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.fitness_center_outlined,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'No programs yet',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.grey[600],
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Purchase a program to start your fitness journey',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[500],
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildPurchaseCard(Purchase purchase) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => _viewProgramDetails(purchase),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cover Image
            SizedBox(
              height: 150,
              width: double.infinity,
              child: purchase.programCoverImageUrl.isNotEmpty
                  ? Image.network(
                      purchase.programCoverImageUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
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

            // Program Info
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    purchase.programTitle,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Purchased on ${_formatDate(purchase.purchasedAt)}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey[600],
                        ),
                  ),
                  const SizedBox(height: 16),

                  // Progress Section
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
                                  'Progress',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                Text(
                                  '${purchase.progressPercentage}%',
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            LinearProgressIndicator(
                              value: purchase.progressPercentage / 100,
                              backgroundColor: Colors.grey[300],
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      IconButton(
                        onPressed: () => _showProgressDialog(purchase),
                        icon: const Icon(Icons.edit),
                        tooltip: 'Update Progress',
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

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
