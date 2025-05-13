import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'sales_order.g.dart';

@HiveType(typeId: 3)
class SalesOrder extends HiveObject {
  @HiveField(0)
  String orderId;

  @HiveField(1)
  String customerId;

  @HiveField(2)
  DateTime orderDate;

  @HiveField(3)
  String status;

  @HiveField(4)
  double totalAmount;

  @HiveField(5)
  List<OrderItem> items;

  SalesOrder({
    required this.orderId,
    required this.customerId,
    required this.orderDate,
    required this.status,
    required this.totalAmount,
    required this.items,
  });
}

@HiveType(typeId: 4)
class OrderItem extends HiveObject {
  @HiveField(0)
  String productId;

  @HiveField(1)
  int quantity;

  @HiveField(2)
  double unitPrice;

  @HiveField(3)
  double discountPercent;

  OrderItem({
    required this.productId,
    required this.quantity,
    required this.unitPrice,
    required this.discountPercent,
  });
}
