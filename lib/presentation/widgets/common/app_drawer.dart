import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text(
              'Menu',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () => context.go('/home'),
          ),
          ListTile(
            leading: const Icon(Icons.people),
            title: const Text('Customers'),
            onTap: () => context.go('/customers'),
          ),
          ListTile(
            leading: const Icon(Icons.map),
            title: const Text('Customer Map'),
            onTap: () => context.go('/customer-map'),
          ),
          ListTile(
            leading: const Icon(Icons.inventory),
            title: const Text('Inventory'),
            onTap: () => context.go('/inventory'),
          ),
          ListTile(
            leading: const Icon(Icons.compare_arrows),
            title: const Text('Inventory Transfer'),
            onTap: () => context.go('/inventory-transfer'),
          ),
          ListTile(
            leading: const Icon(Icons.receipt_long),
            title: const Text('Sales Orders'),
            onTap: () => context.go('/sales-orders'),
          ),
          ListTile(
            leading: const Icon(Icons.point_of_sale),
            title: const Text('Sales'),
            onTap: () => context.go('/sales'),
          ),
          ListTile(
            leading: const Icon(Icons.receipt_outlined),
            title: const Text('Receipt Preview'),
            onTap: () => context.go('/receipt-preview'),
          ),
        ],
      ),
    );
  }
}
