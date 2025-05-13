import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobilesalesmini/presentation/widgets/common/app_drawer.dart';
import '../../controllers/notification_provider.dart';

class NotificationCenter extends ConsumerWidget {
  const NotificationCenter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifications = ref.watch(notificationsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Notification Center')),
      drawer: AppDrawer(),
      body:
          notifications.isEmpty
              ? const Center(
                child: Text(
                  'No notifications.',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              )
              : ListView.builder(
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  final notification = notifications[index];
                  return ListTile(
                    leading: Icon(
                      _getIcon(notification.type),
                      color: _getColor(notification.type),
                    ),
                    title: Text(notification.title),
                    subtitle: Text(notification.message),
                    trailing:
                        notification.isRead
                            ? null
                            : const Icon(
                              Icons.circle,
                              size: 10,
                              color: Colors.red,
                            ),
                    onTap: () {
                      ref
                          .read(notificationsProvider.notifier)
                          .markAsRead(notification.id);
                    },
                  );
                },
              ),
    );
  }

  IconData _getIcon(String type) {
    switch (type) {
      case 'success':
        return Icons.check_circle;
      case 'error':
        return Icons.error;
      case 'warning':
        return Icons.warning;
      case 'info':
      default:
        return Icons.info;
    }
  }

  Color _getColor(String type) {
    switch (type) {
      case 'success':
        return Colors.green;
      case 'error':
        return Colors.red;
      case 'warning':
        return Colors.orange;
      case 'info':
      default:
        return Colors.blue;
    }
  }
}
