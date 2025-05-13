import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import '../../data/models/notification.dart';

final notificationsProvider =
    StateNotifierProvider<NotificationsNotifier, List<AppNotification>>(
      (ref) => NotificationsNotifier(),
    );

class NotificationsNotifier extends StateNotifier<List<AppNotification>> {
  NotificationsNotifier() : super([]) {
    loadNotifications();
  }

  Future<void> loadNotifications() async {
    final box = await Hive.openBox<AppNotification>('notificationsBox');
    state = box.values.toList().reversed.toList();
  }

  Future<void> addNotification(AppNotification notification) async {
    final box = await Hive.openBox<AppNotification>('notificationsBox');
    await box.put(notification.id, notification);
    state = [notification, ...state];
  }

  Future<void> markAsRead(String id) async {
    final box = await Hive.openBox<AppNotification>('notificationsBox');
    final notification = box.get(id);
    if (notification != null) {
      notification.isRead = true;
      await notification.save();
      loadNotifications();
    }
  }

  Future<void> clearOldNotifications() async {
    final box = await Hive.openBox<AppNotification>('notificationsBox');
    await box.clear();
    state = [];
  }
}
