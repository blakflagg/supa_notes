// auth_service.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import './auth_event.dart';

class AuthService {
  final SupabaseClient _supabaseClient = Supabase.instance.client;

  User? get user => _supabaseClient.auth.currentUser;

  Stream<AuthEvent?> get authStateChanges =>
      _supabaseClient.auth.onAuthStateChange.map((data) => AuthEvent(
          session: data.session, event: data.event, user: data.session?.user));

  Future<void> signIn(String email, String password) async {
    try {
      final response = await _supabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      print(e);
    }
  }

  Future<void> signOut() async {
    final response = await _supabaseClient.auth.signOut();
  }
}

final authServiceProvider = Provider<AuthService>((ref) => AuthService());
