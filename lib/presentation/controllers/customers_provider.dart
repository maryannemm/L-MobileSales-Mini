import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import '../../data/models/customer.dart';

final customersProvider =
    StateNotifierProvider<CustomersNotifier, List<Customer>>(
      (ref) => CustomersNotifier(),
    );

class CustomersNotifier extends StateNotifier<List<Customer>> {
  CustomersNotifier() : super([]) {
    loadCustomers();
  }

  Future<void> loadCustomers() async {
    final box = await Hive.openBox<Customer>('customersBox');
    state = box.values.toList();
  }
}
