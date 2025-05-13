import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../data/models/sales_order.dart';

class SalesOrderDetailScreen extends StatelessWidget {
  final SalesOrder order;
  const SalesOrderDetailScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Order #${order.orderId}')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              'Customer ID: ${order.customerId}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Order Date: ${DateFormat('dd MMM yyyy').format(order.orderDate)}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Status: ${order.status}',
              style: const TextStyle(fontSize: 16),
            ),
            const Divider(height: 30),
            const Text(
              'Order Items:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ...order.items.map(
              (item) => Card(
                child: ListTile(
                  title: Text('Product: ${item.productId}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Quantity: ${item.quantity}'),
                      Text('Unit Price: ${item.unitPrice.toStringAsFixed(2)}'),
                      Text('Discount: ${item.discountPercent}%'),
                      Text(
                        'Line Total: ${(item.unitPrice * item.quantity * (1 - item.discountPercent / 100)).toStringAsFixed(2)}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Divider(height: 30),
            Text(
              'Total Amount: ${order.totalAmount.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
