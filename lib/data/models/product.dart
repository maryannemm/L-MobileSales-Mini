import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'product.g.dart';

@HiveType(typeId: 1)
class Product extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String sku;

  @HiveField(3)
  String category;

  @HiveField(4)
  double price;

  @HiveField(5)
  Map<String, int> stockPerWarehouse;

  @HiveField(6)
  List<String> images;

  Product({
    required this.id,
    required this.name,
    required this.sku,
    required this.category,
    required this.price,
    required this.stockPerWarehouse,
    required this.images,
  });
}
