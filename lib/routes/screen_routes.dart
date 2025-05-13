import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobilesalesmini/presentation/screens/forgot_password_screen.dart';
import 'package:mobilesalesmini/presentation/screens/inventory_detail_screen.dart';
import 'package:mobilesalesmini/presentation/screens/inventory_transfer_screen.dart';
import 'package:mobilesalesmini/presentation/screens/sales_order_form.dart';
import 'package:mobilesalesmini/presentation/screens/sales_order_screen.dart';
import 'package:mobilesalesmini/presentation/widgets/common/notification_center.dart';
import '../presentation/screens/customer_map_screen.dart';
import '../presentation/screens/login_screen.dart';
import '../presentation/screens/home_screen.dart';
import '../presentation/screens/inventory_screen.dart';
import '../presentation/screens/receipt_preview_screen.dart';
import '../presentation/screens/sales_screen.dart';
import '../presentation/screens/customers_screen.dart';
import '../presentation/controllers/auth_provider.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    refreshListenable: GoRouterRefreshStream(
      ref.watch(authProvider.notifier).stream,
    ),
    redirect: (context, state) async {
      final authState = ref.read(authProvider);
      final isLoggedIn = authState.user != null;
      if (!isLoggedIn && state.location != '/') {
        return '/';
      }
      if (isLoggedIn && state.location == '/') {
        return '/home';
      }
      return null;
    },
    routes: [
      GoRoute(path: '/', builder: (context, state) => const LoginScreen()),
      GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
      GoRoute(
        path: '/reset',
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: '/notifications',
        builder: (context, state) => const NotificationCenter(),
      ),
      GoRoute(
        path: '/inventory',
        builder: (context, state) {
          final hasAccess = ref
              .read(authProvider.notifier)
              .hasPermission('view_inventory');
          return hasAccess
              ? const InventoryScreen()
              : const Scaffold(
                body: Center(child: Text('Access Denied: No Permission')),
              );
        },
      ),
      GoRoute(
        path: '/inventory-transfer',
        builder: (context, state) {
          final hasAccess = ref
              .read(authProvider.notifier)
              .hasPermission('view_inventory_transfer');
          return hasAccess
              ? const InventoryScreen()
              : const Scaffold(
                body: Center(child: Text('Access Denied: No Permission')),
              );
        },
      ),
      GoRoute(
        path: '/sales',
        builder: (context, state) {
          final hasAccess = ref
              .read(authProvider.notifier)
              .hasPermission('view_sales');
          return hasAccess
              ? const SalesScreen()
              : const Scaffold(
                body: Center(child: Text('Access Denied: No Permission')),
              );
        },
      ),
      GoRoute(
        path: '/customers',
        builder: (context, state) {
          final hasAccess = ref
              .read(authProvider.notifier)
              .hasPermission('view_customers');
          return hasAccess
              ? const CustomersScreen()
              : const Scaffold(
                body: Center(child: Text('Access Denied: No Permission')),
              );
        },
      ),
      GoRoute(
        path: '/inventory/detail',
        builder:
            (context, state) =>
                hasPermission(ref as WidgetRef, 'inventory.detail')
                    ? InventoryDetailScreen()
                    : const ForbiddenScreen(),
      ),
      GoRoute(
        path: '/inventory/transfer',
        builder:
            (context, state) =>
                hasPermission(ref as WidgetRef, 'inventory.transfer')
                    ? const InventoryTransferScreen()
                    : const ForbiddenScreen(),
      ),
      GoRoute(
        path: '/sales',
        builder:
            (context, state) =>
                hasPermission(ref as WidgetRef, 'sales.view')
                    ? const SalesScreen()
                    : const ForbiddenScreen(),
      ),
      GoRoute(
        path: '/sales/orders',
        builder:
            (context, state) =>
                hasPermission(ref as WidgetRef, 'sales.orders')
                    ? const SalesOrderListScreen()
                    : const ForbiddenScreen(),
      ),
      GoRoute(
        path: '/sales/orders/form',
        builder:
            (context, state) =>
                hasPermission(ref as WidgetRef, 'sales.orders.create')
                    ? const SalesOrderFormScreen()
                    : const ForbiddenScreen(),
      ),

      GoRoute(
        path: '/receipt/preview',
        builder:
            (context, state) =>
                hasPermission(ref as WidgetRef, 'receipt.preview')
                    ? const ReceiptPreviewScreen()
                    : const ForbiddenScreen(),
      ),
      GoRoute(
        path: '/customers',
        builder:
            (context, state) =>
                hasPermission(ref as WidgetRef, 'customers.view')
                    ? const CustomersScreen()
                    : const ForbiddenScreen(),
      ),
      GoRoute(
        path: '/customers/map',
        builder:
            (context, state) =>
                hasPermission(ref as WidgetRef, 'customers.map')
                    ? const CustomerMapScreen()
                    : const ForbiddenScreen(),
      ),
    ],
  );
});

class ForbiddenScreen extends StatelessWidget {
  const ForbiddenScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('403 Forbidden - No Permission')),
    );
  }
}

bool hasPermission(WidgetRef ref, String permission) {
  final user = ref.read(authProvider).user;
  if (user == null) return false;
  return user.permissions.contains(permission);
}

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen((event) {
      notifyListeners();
    });
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
