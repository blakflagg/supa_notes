// auth_notifier.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthState {
  final User? user;
  final bool isLoading;
  final String? error;
  final AuthChangeEvent? event;
  final bool isAuth;

  AuthState({
    this.user,
    this.isLoading = false,
    this.error,
    this.event,
    this.isAuth = false,
  });

  AuthState copyWith({
    User? user,
    bool? isLoading,
    String? error,
    AuthChangeEvent? event,
    bool? isAuth,
  }) {
    return AuthState(
      user: user,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      event: event ?? this.event,
      isAuth: isAuth ?? this.isAuth,
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthService _authService;

  AuthNotifier(this._authService) : super(AuthState()) {
    _authService.authStateChanges.listen((data) {
      state = state.copyWith(
          user: data?.user,
          event: data?.event,
          isAuth: data?.event == AuthChangeEvent.signedIn);
    });
  }

  Future<void> signIn(String email, String password) async {
    state = state.copyWith(isLoading: true);
    try {
      await _authService.signIn(email, password);
      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> signOut() async {
    state = state.copyWith(isLoading: true);
    try {
      await _authService.signOut();
      state = state.copyWith(isLoading: false, isAuth: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}

final authNotifierProvider = StateNotifierProvider<AuthNotifier, AuthState>(
  (ref) {
    final authService = ref.watch(authServiceProvider);
    return AuthNotifier(authService);
  },
);
