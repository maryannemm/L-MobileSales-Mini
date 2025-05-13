import 'package:hive/hive.dart';

part 'notification.g.dart';

@HiveType(typeId: 5)
class AppNotification extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String type;

  @HiveField(2)
  String title;

  @HiveField(3)
  String message;

  @HiveField(4)
  DateTime timestamp;

  @HiveField(5)
  bool isRead;

  AppNotification({
    required this.id,
    required this.type,
    required this.title,
    required this.message,
    required this.timestamp,
    required this.isRead,
  });
}
