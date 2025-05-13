import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/sales_order.dart';
import '../../core/utils/leys_sales_formatter.dart';

final receiptOrderProvider = Provider<SalesOrder>((ref) {
  return SalesOrder(
    orderId: 'ORD-2025-05-001',
    customerId: 'CUS-001',
    orderDate: DateTime.now(),
    status: 'Delivered',
    totalAmount: 45650.00,
    items: [
      OrderItem(
        productId: 'PRD-001',
        quantity: 5,
        unitPrice: 4500.00,
        discountPercent: 5.0,
      ),
    ],
  );
});

class ReceiptPreviewScreen extends ConsumerWidget {
  const ReceiptPreviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final order = ref.watch(receiptOrderProvider);
    final netTotal = order.totalAmount;

    return Scaffold(
      appBar: AppBar(title: const Text('Receipt Preview')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Receipt No: ${order.orderId}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text('Date: ${order.orderDate}'),
            const Divider(),
            const Text('Items:'),
            ...order.items.map(
              (item) => ListTile(
                title: Text('Product: ${item.productId}'),
                subtitle: Text(
                  'Qty: ${item.quantity} @ ${LeysSalesFormatter.format(item.unitPrice)}',
                ),
                trailing: Text(
                  LeysSalesFormatter.format(
                    (item.unitPrice * item.quantity) *
                        (1 - (item.discountPercent / 100)),
                  ),
                ),
              ),
            ),
            const Divider(),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Total: ${LeysSalesFormatter.format(netTotal)}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Thank you for your business!',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }
}
