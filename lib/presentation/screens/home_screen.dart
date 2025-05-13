import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobilesalesmini/presentation/widgets/common/app_drawer.dart';
import 'package:mobilesalesmini/presentation/widgets/common/notification_badge_icon.dart';
import '../controllers/auth_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour >= 5 && hour < 12) {
      return 'Good Morning';
    } else if (hour >= 12 && hour < 17) {
      return 'Good Afternoon';
    } else if (hour >= 17 && hour < 21) {
      return 'Good Evening';
    } else {
      return 'Good Night';
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final authNotifier = ref.read(authProvider.notifier);

    final user = authState.user;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          NotificationBadgeIcon(
            onPressed: () {
              context.go('/notifications');
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              authNotifier.logout();
              context.go('/login');
            },
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body:
          user == null
              ? const Center(child: Text('No user logged in.'))
              : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${_getGreeting()}, ${user.firstName} ${user.lastName}',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 10),
                    Text('Username: ${user.username}'),
                    Text('Role: ${user.role}'),
                    Text('Last Login: ${user.lastLogin}'),
                    const SizedBox(height: 30),
                    ElevatedButton.icon(
                      onPressed: () {
                        context.go('/inventory');
                      },
                      icon: const Icon(Icons.inventory),
                      label: const Text('Go to Inventory'),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        context.go('/sales');
                      },
                      icon: const Icon(Icons.point_of_sale),
                      label: const Text('Go to Sales'),
                    ),
                  ],
                ),
              ),
    );
  }
}
