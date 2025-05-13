import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'customer.g.dart';

@HiveType(typeId: 2)
class Customer extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String category;

  @HiveField(3)
  String contactPerson;

  @HiveField(4)
  String phone;

  @HiveField(5)
  double creditLimit;

  @HiveField(6)
  double currentBalance;

  @HiveField(7)
  double latitude;

  @HiveField(8)
  double longitude;

  Customer({
    required this.id,
    required this.name,
    required this.category,
    required this.contactPerson,
    required this.phone,
    required this.creditLimit,
    required this.currentBalance,
    required this.latitude,
    required this.longitude,
  });
}
