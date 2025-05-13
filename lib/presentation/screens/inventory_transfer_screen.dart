import 'package:flutter/material.dart';
import '../widgets/specific/inventory_transfer_animation.dart';

class InventoryTransferScreen extends StatelessWidget {
  const InventoryTransferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Inventory Transfer')),
      body: Column(
        children: [
          const SizedBox(height: 40),
          const Text(
            'Transferring Items',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          const Expanded(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: LInventoryTransferAnimation(
                fromWarehouse: 'Nairobi Central Warehouse',
                toWarehouse: 'Mombasa Regional Warehouse',
              ),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Transfer simulation complete')),
              );
            },
            child: const Text('Simulate Transfer Completion'),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
