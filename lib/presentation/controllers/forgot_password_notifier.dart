import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import '../../data/models/user.dart';

class ForgotPasswordState {
  final bool isLoading;
  final String? error;
  final String? success;

  ForgotPasswordState({this.isLoading = false, this.error, this.success});

  ForgotPasswordState copyWith({
    bool? isLoading,
    String? error,
    String? success,
  }) {
    return ForgotPasswordState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      success: success,
    );
  }
}

class ForgotPasswordNotifier extends StateNotifier<ForgotPasswordState> {
  ForgotPasswordNotifier() : super(ForgotPasswordState());

  Future<void> changePassword(String username, String newPassword) async {
    if (username.trim().isEmpty || newPassword.trim().isEmpty) {
      state = state.copyWith(
        error: 'Username and new password cannot be empty',
        success: null,
      );
      return;
    }

    state = state.copyWith(isLoading: true, error: null, success: null);

    try {
      final usersBox = await Hive.openBox<User>('usersBox');
      final users = usersBox.values.toList();

      final foundUser = users.firstWhere(
        (user) => user.username == username.trim(),
        orElse: () => throw Exception('User not found'),
      );

      foundUser.password = newPassword.trim();
      await foundUser.save();

      state = state.copyWith(
        success: 'Password changed successfully',
        isLoading: false,
        error: null,
      );
    } catch (e) {
      state = state.copyWith(
        error: e.toString().replaceFirst('Exception: ', ''),
        isLoading: false,
        success: null,
      );
    }
  }
}

final forgotPasswordProvider =
    StateNotifierProvider<ForgotPasswordNotifier, ForgotPasswordState>(
      (ref) => ForgotPasswordNotifier(),
    );
