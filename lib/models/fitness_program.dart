import 'package:cloud_firestore/cloud_firestore.dart';

class FitnessProgram {
  final String id;
  final String title;
  final String description;
  final String coverImageUrl;
  final double price;
  final String duration;
  final String difficultyLevel;
  final String trainerName;
  final String category;
  final bool isActive;
  final DateTime createdAt;

  FitnessProgram({
    required this.id,
    required this.title,
    required this.description,
    required this.coverImageUrl,
    required this.price,
    required this.duration,
    required this.difficultyLevel,
    required this.trainerName,
    required this.category,
    this.isActive = true,
    required this.createdAt,
  });

  factory FitnessProgram.fromJson(Map<String, dynamic> json) {
    return FitnessProgram(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      coverImageUrl: json['coverImageUrl'] as String? ?? '',
      price: (json['price'] as num).toDouble(),
      duration: json['duration'] as String,
      difficultyLevel: json['difficultyLevel'] as String,
      trainerName: json['trainerName'] as String,
      category: json['category'] as String,
      isActive: json['isActive'] as bool? ?? true,
      createdAt: json['createdAt'] is Timestamp
          ? (json['createdAt'] as Timestamp).toDate()
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'coverImageUrl': coverImageUrl,
      'price': price,
      'duration': duration,
      'difficultyLevel': difficultyLevel,
      'trainerName': trainerName,
      'category': category,
      'isActive': isActive,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}
