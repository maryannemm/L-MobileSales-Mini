import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import '../../data/models/product.dart';

final inventoryProvider =
    StateNotifierProvider<InventoryNotifier, List<Product>>(
      (ref) => InventoryNotifier(),
    );

class InventoryNotifier extends StateNotifier<List<Product>> {
  InventoryNotifier() : super([]) {
    loadInventory();
  }

  Future<void> loadInventory() async {
    final box = await Hive.openBox<Product>('productsBox');
    state = box.values.toList();
  }
}
