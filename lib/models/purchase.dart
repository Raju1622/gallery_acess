import 'package:cloud_firestore/cloud_firestore.dart';

class Purchase {
  final String id;
  final String userId;
  final String programId;
  final String programTitle;
  final String programCoverImageUrl;
  final double price;
  final String paymentId;
  final DateTime purchasedAt;
  final int progressPercentage;

  Purchase({
    required this.id,
    required this.userId,
    required this.programId,
    required this.programTitle,
    required this.programCoverImageUrl,
    required this.price,
    required this.paymentId,
    required this.purchasedAt,
    this.progressPercentage = 0,
  });

  factory Purchase.fromJson(Map<String, dynamic> json) {
    return Purchase(
      id: json['id'] as String,
      userId: json['userId'] as String,
      programId: json['programId'] as String,
      programTitle: json['programTitle'] as String,
      programCoverImageUrl: json['programCoverImageUrl'] as String? ?? '',
      price: (json['price'] as num).toDouble(),
      paymentId: json['paymentId'] as String,
      purchasedAt: json['purchasedAt'] is Timestamp
          ? (json['purchasedAt'] as Timestamp).toDate()
          : DateTime.now(),
      progressPercentage: json['progressPercentage'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'programId': programId,
      'programTitle': programTitle,
      'programCoverImageUrl': programCoverImageUrl,
      'price': price,
      'paymentId': paymentId,
      'purchasedAt': Timestamp.fromDate(purchasedAt),
      'progressPercentage': progressPercentage,
    };
  }

  Purchase copyWith({int? progressPercentage}) {
    return Purchase(
      id: id,
      userId: userId,
      programId: programId,
      programTitle: programTitle,
      programCoverImageUrl: programCoverImageUrl,
      price: price,
      paymentId: paymentId,
      purchasedAt: purchasedAt,
      progressPercentage: progressPercentage ?? this.progressPercentage,
    );
  }
}
