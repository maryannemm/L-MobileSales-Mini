// lib/presentation/controllers/auth_provider.dart
import 'dart:async';
import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import '../../data/models/user.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>(
  (ref) => AuthNotifier(ref),
);

class AuthState {
  final bool isLoading;
  final String? error;
  final User? user;

  AuthState({this.isLoading = false, this.error, this.user});

  AuthState copyWith({bool? isLoading, String? error, User? user}) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      user: user ?? this.user,
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  final Ref ref;
  Timer? _sessionTimer;

  AuthNotifier(this.ref) : super(AuthState()) {
    _loadSession();
  }

  Future<void> _loadSession() async {
    final settingsBox = await Hive.openBox('settingsBox');
    final userId = settingsBox.get('currentUser');
    if (userId != null) {
      final usersBox = await Hive.openBox<User>('usersBox');
      final user = usersBox.get(userId);
      if (user != null) {
        state = state.copyWith(user: user);
        _startSessionTimer();
      }
    }
  }

  Future<void> login(String username, String password, bool rememberMe) async {
    try {
      state = state.copyWith(isLoading: true, error: null);

      final usersBox = await Hive.openBox<User>('usersBox');
      final settingsBox = await Hive.openBox('settingsBox');

      // Safely search user
      final foundUser = usersBox.values.firstWhereOrNull(
        (user) => user.username == username && user.password == password,
      );

      if (foundUser != null) {
        await settingsBox.put('currentUser', foundUser.id);
        if (rememberMe) {
          await settingsBox.put('rememberMe', true);
        }
        state = state.copyWith(user: foundUser, isLoading: false);
        _startSessionTimer();
      } else {
        // User not found
        state = state.copyWith(
          isLoading: false,
          error: 'Invalid username or password',
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Login error: ${e.toString()}',
      );
    }
  }

  void logout() async {
    final settingsBox = await Hive.openBox('settingsBox');
    await settingsBox.delete('currentUser');
    state = AuthState();
    _cancelSessionTimer();
  }

  bool hasPermission(String permission) {
    return state.user?.permissions.contains(permission) ?? false;
  }

  void _startSessionTimer() {
    _cancelSessionTimer();
    _sessionTimer = Timer(const Duration(minutes: 15), () {
      logout();
    });
  }

  void _cancelSessionTimer() {
    _sessionTimer?.cancel();
    _sessionTimer = null;
  }
}
