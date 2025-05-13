import 'package:hive_flutter/hive_flutter.dart';
import 'package:mobilesalesmini/data/models/user.dart';

//root user
Future<void> seedUsers() async {
  final usersBox = await Hive.openBox<User>('usersBox');

  final user1 = User(
    id: '1',
    username: 'admin',
    password: 'admin123',
    firstName: 'Admin',
    lastName: 'User',
    role: 'admin',
    permissions: [
      'view_customers',
      'view_customer_map',
      'view_inventory',
      'view_inventory_transfer',
      'view_orders',
      'view_sales_orders',
      'view_sales',
      'view_receipts',
      'view_reports',
      'view_forgot_password',
    ],
    profileImage: '',
    token: '',
    lastLogin: DateTime.now(),
  );

  await usersBox.put(user1.id, user1);
}
