import 'package:google_sign_in/google_sign_in.dart';
import '../../../core/network/api_client.dart';

class AuthRepository {
  final ApiClient _apiClient = ApiClient();
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
  );

  Future<Map<String, dynamic>?> signInWithGoogle(String rolePreference) async {
    try {
      // Trigger local Google sign-in flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return null; // User cancelled
      }

      // Retrieve credentials
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final String? idToken = googleAuth.idToken;

      if (idToken == null) {
        throw Exception('Failed to retrieve Google ID Token.');
      }

      // Send ID token to FastAPI backend
      final backendResponse = await _apiClient.postGoogleAuth(
        idToken: idToken,
        rolePreference: rolePreference,
      );

      return backendResponse;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
  }
}
