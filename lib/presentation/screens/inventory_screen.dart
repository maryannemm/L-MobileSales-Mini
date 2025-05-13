import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobilesalesmini/presentation/widgets/common/app_drawer.dart';
import '../controllers/inventory_provider.dart';
import '../../data/models/product.dart';
import '../widgets/common/l_pull_refresh_list.dart';

class InventoryScreen extends ConsumerStatefulWidget {
  const InventoryScreen({super.key});

  @override
  ConsumerState<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends ConsumerState<InventoryScreen> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final products = ref.watch(inventoryProvider);
    final notifier = ref.read(inventoryProvider.notifier);

    final filteredProducts =
        products.where((product) {
          return product.name.toLowerCase().contains(
                _searchQuery.toLowerCase(),
              ) ||
              product.sku.toLowerCase().contains(_searchQuery.toLowerCase());
        }).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Inventory')),
      drawer: AppDrawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Search Product or SKU...',
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
            child: LPullRefreshList<Product>(
              onRefresh: notifier.loadInventory,
              items: filteredProducts,
              itemBuilder:
                  (context, product) => Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor:
                            product.stockPerWarehouse.values.fold(
                                      0,
                                      (a, b) => a + b,
                                    ) >
                                    0
                                ? Colors.green
                                : Colors.red,
                        child: Text(product.name[0].toUpperCase()),
                      ),
                      title: Text(product.name),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('SKU: ${product.sku}'),
                          Text(
                            'Stock Total: ${product.stockPerWarehouse.values.fold(0, (a, b) => a + b)}',
                          ),
                        ],
                      ),
                      onTap: () {
                        context.go('/inventory/detail');
                      },
                    ),
                  ),
              emptyMessage: 'No products found',
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
