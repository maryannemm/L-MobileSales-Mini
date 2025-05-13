import 'package:hive/hive.dart';
import '../models/sales_order.dart';

class SalesSeeder {
  static Future<void> seedSales() async {
    final salesBox = await Hive.openBox<SalesOrder>('salesBox');

    salesBox.put(
      'ORD-2025-05-001',
      SalesOrder(
        orderId: 'ORD-2025-05-001',
        customerId: 'CUS-001',
        orderDate: DateTime.now().subtract(const Duration(days: 1)),
        status: 'Processing',
        totalAmount: 45650.00,
        items: [
          OrderItem(
            productId: 'PRD-001',
            quantity: 10,
            unitPrice: 4500.00,
            discountPercent: 5.0,
          ),
        ],
      ),
    );

    salesBox.put(
      'ORD-2025-05-002',
      SalesOrder(
        orderId: 'ORD-2025-05-002',
        customerId: 'CUS-002',
        orderDate: DateTime.now(),
        status: 'Delivered',
        totalAmount: 76500.00,
        items: [
          OrderItem(
            productId: 'PRD-002',
            quantity: 15,
            unitPrice: 5000.00,
            discountPercent: 10.0,
          ),
        ],
      ),
    );
  }
}
