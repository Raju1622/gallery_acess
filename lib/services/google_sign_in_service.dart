import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GoogleSignInService {
  // Google Sign-In configuration - serverClientId will be auto-detected from google-services.json
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
  );
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> signInWithGoogle() async {
    try {
      // Sign out first to clear any existing session
      await _googleSignIn.signOut();

      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        // User canceled the sign-in
        return false;
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Ensure we have both tokens
      if (googleAuth.accessToken == null || googleAuth.idToken == null) {
        throw Exception('Failed to get authentication tokens from Google');
      }

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google credential
      // Catch any errors during sign-in but check if user is actually signed in
      try {
        await _auth.signInWithCredential(credential);
      } catch (signInError) {
        // Even if there's an error, check if user is signed in
        // (sometimes sign-in succeeds but returns error due to type casting)
        if (_auth.currentUser != null) {
          print('Sign-in succeeded (user is authenticated)');
          return true;
        }
        rethrow;
      }

      // Verify sign-in was successful by checking current user
      await Future.delayed(const Duration(milliseconds: 500));
      return _auth.currentUser != null;
    } catch (e, stackTrace) {
      print('Error signing in with Google: $e');
      print('Stack trace: $stackTrace');

      // Check if user is actually signed in despite the error
      if (_auth.currentUser != null) {
        print('User is signed in despite error - sign-in successful');
        return true;
      }

      // If it's a type cast error, try alternative approach
      if (e.toString().contains('type cast') ||
          e.toString().contains('PigeonUserDetails')) {
        print('Type casting error detected, checking authentication state...');
        // Wait a bit and check if user is signed in
        await Future.delayed(const Duration(milliseconds: 1000));
        if (_auth.currentUser != null) {
          print('User authenticated successfully despite type casting error');
          return true;
        }
      }

      rethrow;
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }

  User? getCurrentUser() {
    return _auth.currentUser;
  }
}
