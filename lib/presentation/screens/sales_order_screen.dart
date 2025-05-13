import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobilesalesmini/presentation/controllers/sales_provider.dart';
import 'package:mobilesalesmini/presentation/screens/order_detail_screen.dart';
import 'package:mobilesalesmini/presentation/widgets/common/app_drawer.dart';

class SalesOrderListScreen extends ConsumerWidget {
  const SalesOrderListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final salesOrders = ref.watch(salesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Sales Orders')),
      drawer: AppDrawer(),
      body:
          salesOrders.isEmpty
              ? const Center(child: Text('No orders available.'))
              : ListView.builder(
                itemCount: salesOrders.length,
                itemBuilder: (context, index) {
                  final order = salesOrders[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text(order.customerId.substring(0, 1)),
                      ),
                      title: Text('Order #${order.orderId}'),
                      subtitle: Text('Status: ${order.status}'),
                      trailing: Text(order.totalAmount.toStringAsFixed(2)),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) =>
                                    SalesOrderDetailScreen(order: order),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
    );
  }
}
