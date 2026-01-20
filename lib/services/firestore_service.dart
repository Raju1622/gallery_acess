import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/fitness_program.dart';
import '../models/announcement.dart';
import '../models/user_profile.dart';
import '../models/purchase.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Collection references
  CollectionReference get _programsCollection => _firestore.collection('programs');
  CollectionReference get _announcementsCollection => _firestore.collection('announcements');
  CollectionReference get _usersCollection => _firestore.collection('users');
  CollectionReference get _purchasesCollection => _firestore.collection('purchases');

  // ==================== PROGRAMS ====================

  Future<List<FitnessProgram>> getPrograms() async {
    try {
      final snapshot = await _programsCollection
          .where('isActive', isEqualTo: true)
          .orderBy('createdAt', descending: true)
          .get();

      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id;
        return FitnessProgram.fromJson(data);
      }).toList();
    } catch (e) {
      print('Error fetching programs: $e');
      return [];
    }
  }

  Future<List<FitnessProgram>> getProgramsByCategory(String category) async {
    try {
      final snapshot = await _programsCollection
          .where('isActive', isEqualTo: true)
          .where('category', isEqualTo: category)
          .orderBy('createdAt', descending: true)
          .get();

      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id;
        return FitnessProgram.fromJson(data);
      }).toList();
    } catch (e) {
      print('Error fetching programs by category: $e');
      return [];
    }
  }

  Future<FitnessProgram?> getProgramById(String id) async {
    try {
      final doc = await _programsCollection.doc(id).get();
      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id;
        return FitnessProgram.fromJson(data);
      }
      return null;
    } catch (e) {
      print('Error fetching program by id: $e');
      return null;
    }
  }

  Future<List<String>> getCategories() async {
    try {
      final snapshot = await _programsCollection
          .where('isActive', isEqualTo: true)
          .get();

      final categories = snapshot.docs
          .map((doc) => (doc.data() as Map<String, dynamic>)['category'] as String)
          .toSet()
          .toList();

      return categories;
    } catch (e) {
      print('Error fetching categories: $e');
      return [];
    }
  }

  // ==================== ANNOUNCEMENTS ====================

  Future<List<Announcement>> getAnnouncements() async {
    try {
      final snapshot = await _announcementsCollection
          .where('isActive', isEqualTo: true)
          .orderBy('date', descending: true)
          .get();

      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id;
        return Announcement.fromJson(data);
      }).toList();
    } catch (e) {
      print('Error fetching announcements: $e');
      return [];
    }
  }

  // ==================== USER PROFILE ====================

  Future<void> createOrUpdateUserProfile(UserProfile profile) async {
    try {
      await _usersCollection.doc(profile.uid).set(profile.toJson());
    } catch (e) {
      print('Error creating/updating user profile: $e');
      rethrow;
    }
  }

  Future<UserProfile?> getUserProfile(String uid) async {
    try {
      final doc = await _usersCollection.doc(uid).get();
      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>;
        return UserProfile.fromJson(data);
      }
      return null;
    } catch (e) {
      print('Error fetching user profile: $e');
      return null;
    }
  }

  Future<void> updateUserProfile(String uid, Map<String, dynamic> data) async {
    try {
      data['updatedAt'] = Timestamp.fromDate(DateTime.now());
      await _usersCollection.doc(uid).update(data);
    } catch (e) {
      print('Error updating user profile: $e');
      rethrow;
    }
  }

  Future<void> deleteUserAccount(String uid) async {
    try {
      // Delete user's purchases
      final purchasesSnapshot = await _purchasesCollection
          .where('userId', isEqualTo: uid)
          .get();

      for (final doc in purchasesSnapshot.docs) {
        await doc.reference.delete();
      }

      // Delete user profile
      await _usersCollection.doc(uid).delete();
    } catch (e) {
      print('Error deleting user account: $e');
      rethrow;
    }
  }

  // ==================== PURCHASES ====================

  Future<void> createPurchase(Purchase purchase) async {
    try {
      await _purchasesCollection.doc(purchase.id).set(purchase.toJson());
    } catch (e) {
      print('Error creating purchase: $e');
      rethrow;
    }
  }

  Future<List<Purchase>> getUserPurchases(String userId) async {
    try {
      final snapshot = await _purchasesCollection
          .where('userId', isEqualTo: userId)
          .orderBy('purchasedAt', descending: true)
          .get();

      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id;
        return Purchase.fromJson(data);
      }).toList();
    } catch (e) {
      print('Error fetching user purchases: $e');
      return [];
    }
  }

  Future<bool> hasPurchasedProgram(String userId, String programId) async {
    try {
      final snapshot = await _purchasesCollection
          .where('userId', isEqualTo: userId)
          .where('programId', isEqualTo: programId)
          .limit(1)
          .get();

      return snapshot.docs.isNotEmpty;
    } catch (e) {
      print('Error checking purchase: $e');
      return false;
    }
  }

  Future<void> updatePurchaseProgress(String purchaseId, int progress) async {
    try {
      await _purchasesCollection.doc(purchaseId).update({
        'progressPercentage': progress,
      });
    } catch (e) {
      print('Error updating purchase progress: $e');
      rethrow;
    }
  }
}
