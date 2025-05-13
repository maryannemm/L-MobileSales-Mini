import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class User extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String username;

  @HiveField(2)
  String firstName;

  @HiveField(3)
  String lastName;

  @HiveField(4)
  String role;

  @HiveField(5)
  List<String> permissions;

  @HiveField(6)
  String profileImage;

  @HiveField(7)
  String token;

  @HiveField(8)
  DateTime lastLogin;

  @HiveField(9)
  String password;

  User({
    required this.id,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.role,
    required this.permissions,
    required this.profileImage,
    required this.token,
    required this.lastLogin,
    required this.password,
  });
}
