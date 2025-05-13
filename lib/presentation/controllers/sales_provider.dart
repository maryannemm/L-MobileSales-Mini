import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import '../../data/models/sales_order.dart';

final salesProvider = StateNotifierProvider<SalesNotifier, List<SalesOrder>>(
  (ref) => SalesNotifier(),
);

class SalesNotifier extends StateNotifier<List<SalesOrder>> {
  SalesNotifier() : super([]) {
    loadSales();
  }

  Future<void> loadSales() async {
    final box = await Hive.openBox<SalesOrder>('salesBox');
    state = box.values.toList();
  }
}
