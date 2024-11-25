import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _supabase = Supabase.instance.client;
  final RegExp _emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  // Sign up with email and password, then save profile data to Supabase.
  Future<void> signUpWithEmail(String email, String password, String name) async {
    try {
      if (!_emailRegex.hasMatch(email)) throw 'Invalid email format';
      if (password.length < 6) throw 'Password must be at least 6 characters';

      final AuthResponse response = await _supabase.auth.signUp(
        email: email,
        password: password,
        data: {'name': name},
      );

      if (response.user == null) throw 'Registration failed';

      // Save the user profile to Supabase.
      await _supabase.from('profiles').upsert({
        'id': response.user!.id,
        'email': email,
        'name': name,
        'created_at': DateTime.now().toIso8601String(),
      });

      Get.offAllNamed('/home');
      Get.snackbar('Success', 'Account created successfully!');
    } on AuthException catch (e) {
      Get.snackbar('Auth Error', e.message);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  // Log in with email and password.
  Future<void> loginWithEmail(String email, String password) async {
    try {
      final AuthResponse response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user == null) throw 'Login failed';
      Get.offAllNamed('/home');
    } on AuthException catch (e) {
      Get.snackbar('Auth Error', e.message);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  // Sign in with Google. On success, upsert a profile record.
  Future<void> signInWithGoogle() async {
    try {
      final AuthResponse response = (await _supabase.auth.signInWithOAuth(
        AuthProvider.google,
        redirectTo: kIsWeb
            ? 'https://dyiqtulauqrxgjgtqzyl.supabase.co/auth/v1/callback'
            : 'com.rajshaitown://login-callback',
      )) as AuthResponse;

      final user = response.user;
      if (user != null) {
        // Upsert the user's profile data.
        await _supabase.from('profiles').upsert({
          'id': user.id,
          'email': user.email,
          // If available from Google, save the full name; otherwise default to an empty string.
          'name': user.userMetadata?['full_name'] ?? '',
          'created_at': DateTime.now().toIso8601String(),
        });
      }
    } on AuthException catch (e) {
      Get.snackbar('Auth Error', e.message);
    } catch (e) {
      Get.snackbar('Error', 'Failed to sign in with Google: ${e.toString()}');
    }
  }

  // Retrieve the user's profile from Supabase.
  Future<Map<String, dynamic>> getProfile() async {
    try {
      final user = _supabase.auth.currentUser;
      if (user == null) throw 'Not logged in';
      final response = await _supabase
          .from('profiles')
          .select()
          .eq('id', user.id)
          .single();
      return response.data as Map<String, dynamic>;
    } on PostgrestException catch (e) {
      throw 'Database error: ${e.message}';
    } catch (e) {
      throw 'Failed to fetch profile: ${e.toString()}';
    }
  }

  // Update the user's profile data.
  Future<void> updateProfile({
    required String name,
    required String email,
    String? avatarUrl,
  }) async {
    try {
      final user = _supabase.auth.currentUser;
      if (user == null) throw 'Not logged in';

      // Update email via Supabase Auth if changed.
      if (email != user.email) {
        await _supabase.auth.updateUser(UserAttributes(email: email));
      }

      // Upsert the updated profile data.
      await _supabase.from('profiles').upsert({
        'id': user.id,
        'name': name,
        'email': email,
        'avatar_url': avatarUrl,
      });

      Get.snackbar('Success', 'Profile updated!');
    } on AuthException catch (e) {
      Get.snackbar('Auth Error', e.message);
    } on PostgrestException catch (e) {
      Get.snackbar('Database Error', e.message);
    }
  }

  // Sign out the user.
  Future<void> signOut() async {
    try {
      await _supabase.auth.signOut();
      Get.offAllNamed('/login');
    } on AuthException catch (e) {
      Get.snackbar('Logout Error', e.message);
    }
  }
}
