import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobilesalesmini/presentation/widgets/common/app_drawer.dart';
import '../../data/models/sales_order.dart';
import '../controllers/sales_provider.dart';
import '../widgets/common/l_pull_refresh_list.dart';
import '../../core/utils/leys_sales_formatter.dart';

class SalesScreen extends ConsumerStatefulWidget {
  const SalesScreen({super.key});

  @override
  ConsumerState<SalesScreen> createState() => _SalesScreenState();
}

class _SalesScreenState extends ConsumerState<SalesScreen> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final orders = ref.watch(salesProvider);
    final notifier = ref.read(salesProvider.notifier);

    final filteredOrders =
        orders.where((order) {
          return order.orderId.toLowerCase().contains(
                _searchQuery.toLowerCase(),
              ) ||
              order.status.toLowerCase().contains(_searchQuery.toLowerCase()) ||
              order.customerId.toLowerCase().contains(
                _searchQuery.toLowerCase(),
              );
        }).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Sales Orders')),
      drawer: AppDrawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Search Order ID, Status, or Customer...',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),
          Expanded(
            child: LPullRefreshList<SalesOrder>(
              onRefresh: notifier.loadSales,
              items: filteredOrders,
              itemBuilder:
                  (context, order) => Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    child: ListTile(
                      title: Text(order.orderId),
                      subtitle: Text('Status: ${order.status}'),
                      trailing: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            LeysSalesFormatter.format(order.totalAmount),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          _statusBadge(order.status),
                        ],
                      ),
                      onTap: () {
                        context.go('/inventory/detail');
                      },
                    ),
                  ),
              emptyMessage: 'No sales orders found',
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.go('/sales/orders/form');
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _statusBadge(String status) {
    Color color;
    switch (status.toLowerCase()) {
      case 'delivered':
        color = Colors.green;
        break;
      case 'processing':
        color = Colors.orange;
        break;
      case 'approved':
        color = Colors.blue;
        break;
      default:
        color = Colors.grey;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
