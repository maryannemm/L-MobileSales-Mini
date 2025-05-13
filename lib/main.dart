import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobilesalesmini/core/themes/theme_provider.dart';
import 'package:mobilesalesmini/data/seeder/sales_seeder.dart';
import 'package:mobilesalesmini/data/seeder/users_seeder.dart';
import 'routes/screen_routes.dart';
import 'data/models/user.dart';
import 'data/models/product.dart';
import 'data/models/customer.dart';
import 'data/models/sales_order.dart';
import 'data/models/notification.dart';
import 'data/seeder/data_seeder.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Register Hive Adapters
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(ProductAdapter());
  Hive.registerAdapter(CustomerAdapter());
  Hive.registerAdapter(SalesOrderAdapter());
  Hive.registerAdapter(OrderItemAdapter());
  Hive.registerAdapter(AppNotificationAdapter());
  await Hive.initFlutter();

  await DataSeeder.seedUsers();
  await SalesSeeder.seedSales();
  await seedUsers();

  runApp(const LMobileSalesApp());
}

class LMobileSalesApp extends StatelessWidget {
  const LMobileSalesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: Consumer(
        builder:
            (context, ref, _) => MaterialApp.router(
              theme: ThemeData.light(),
              darkTheme: ThemeData.dark(),
              themeMode: ref.watch(themeProvider),
              routerConfig: ref.watch(routerProvider),
              debugShowCheckedModeBanner: false,
            ),

        //       themeMode: ref.watch(themeProvider),
      ),
    );
  }
}
