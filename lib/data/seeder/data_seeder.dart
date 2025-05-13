import 'package:hive/hive.dart';
import '../models/user.dart';

class DataSeeder {
  static Future<void> seedUsers() async {
    final usersBox = await Hive.openBox<User>('usersBox');
    if (usersBox.isEmpty) {
      usersBox.put(
        'USR-001',
        User(
          id: 'USR-001',
          username: 'LEYS-1001',
          firstName: 'David',
          lastName: 'Kariuki',
          role: 'Sales Manager',
          permissions: [
            'view_sales',
            'create_sales',
            'approve_sales',
            'view_reports',
            'view_customers',
            'create_customers',
            'view_inventory',
            'view_pricing',
          ],
          profileImage: 'david_kariuki.jpg',
          token: 'mocked-token-001',
          lastLogin: DateTime.now(),
          password: '1234',
        ),
      );

      usersBox.put(
        'USR-002',
        User(
          id: 'USR-002',
          username: 'LEYS-1002',
          firstName: 'Jane',
          lastName: 'Njoki',
          role: 'Senior Sales Representative',
          permissions: [
            'view_sales',
            'create_sales',
            'view_customers',
            'create_customers',
            'view_inventory',
            'view_pricing',
          ],
          profileImage: 'jane_njoki.jpg',
          token: 'mocked-token-002',
          lastLogin: DateTime.now(),
          password: '1234',
        ),
      );
    }
  }
}
