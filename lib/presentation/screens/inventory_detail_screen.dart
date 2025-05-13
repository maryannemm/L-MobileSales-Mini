import 'package:flutter/material.dart';
import 'package:mobilesalesmini/presentation/widgets/common/app_drawer.dart';
import '../../data/models/product.dart';

class InventoryDetailScreen extends StatelessWidget {
  final Product? product;

  const InventoryDetailScreen({super.key, this.product});

  @override
  Widget build(BuildContext context) {
    final totalStock = product?.stockPerWarehouse.values.fold(
      0,
      (a, b) => a + b,
    );

    return Scaffold(
      appBar: AppBar(title: Text(product!.name)),
      drawer: AppDrawer(),
      body: ListView(
        children: [
          SizedBox(
            height: 250,
            child: PageView.builder(
              itemCount: product?.images.length,
              itemBuilder:
                  (context, index) =>
                      Image.asset(product!.images[index], fit: BoxFit.cover),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product!.name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text('SKU: ${product!.sku}'),
                const SizedBox(height: 10),
                Text('Category: ${product!.category}'),
                const Divider(),
                Text(
                  'Price: KES ${product!.price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Divider(),
                Text(
                  'Stock Per Warehouse:',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                ...product!.stockPerWarehouse.entries.map(
                  (entry) => ListTile(
                    leading: const Icon(Icons.warehouse),
                    title: Text(entry.key),
                    trailing: Text('Qty: ${entry.value}'),
                  ),
                ),
                const Divider(),
                Text(
                  'Total Stock: $totalStock',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
