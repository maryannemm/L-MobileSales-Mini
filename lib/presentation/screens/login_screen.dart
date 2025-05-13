import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobilesalesmini/presentation/screens/forgot_password_screen.dart';
import '../controllers/auth_provider.dart';

final rememberMeProvider = StateProvider<bool>((ref) => false);

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final authNotifier = ref.read(authProvider.notifier);

    final usernameController = TextEditingController();
    final passwordController = TextEditingController();
    final rememberMe = ref.watch(rememberMeProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            Row(
              children: [
                Checkbox(
                  value: rememberMe,
                  onChanged: (value) {
                    ref.read(rememberMeProvider.notifier).state =
                        value ?? false;
                  },
                ),
                const Text('Remember Me'),
              ],
            ),
            if (authState.error != null) ...[
              Text(authState.error!, style: const TextStyle(color: Colors.red)),
            ],
            ElevatedButton(
              onPressed:
                  authState.isLoading
                      ? null
                      : () async {
                        await authNotifier.login(
                          usernameController.text,
                          passwordController.text,
                          rememberMe,
                        );
                        if (ref.read(authProvider).user != null) {
                          context.go('/home');
                        }
                      },
              child:
                  authState.isLoading
                      ? const CircularProgressIndicator()
                      : const Text('Login'),
            ),
            SizedBox(height: 30),
            InkWell(
              child: Text('Forgot Password?'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ForgotPasswordScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
