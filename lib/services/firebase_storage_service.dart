import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseStorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String?> uploadPhoto(File file, String fileName) async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        throw Exception('User not authenticated');
      }

      // Create reference path: users/{userId}/photos/{fileName}
      final ref = _storage.ref().child('users/${user.uid}/photos/$fileName');

      // Upload file
      final uploadTask = ref.putFile(file);

      // Wait for upload to complete
      final snapshot = await uploadTask;

      // Get download URL
      final downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      throw Exception('Error uploading photo: $e');
    }
  }

  Future<List<String>> uploadMultiplePhotos(
    List<File> files, {
    required Function(int current, int total) onProgress,
  }) async {
    final uploadedUrls = <String>[];
    final total = files.length;

    for (int i = 0; i < files.length; i++) {
      try {
        final file = files[i];
        final fileName =
            'photo_${DateTime.now().millisecondsSinceEpoch}_$i.jpg';
        final url = await uploadPhoto(file, fileName);
        if (url != null) {
          uploadedUrls.add(url);
        }
        onProgress(i + 1, total);
      } catch (e) {
        print('Error uploading file $i: $e');
        // Continue with next file even if one fails
        onProgress(i + 1, total);
      }
    }

    return uploadedUrls;
  }
}
