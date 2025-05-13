import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobilesalesmini/presentation/widgets/common/app_drawer.dart';
import '../../data/models/customer.dart';
import '../../presentation/controllers/customers_provider.dart';
import '../widgets/common/l_pull_refresh_list.dart';
import '../widgets/common/customer_category_badge.dart';

class CustomersScreen extends ConsumerStatefulWidget {
  const CustomersScreen({super.key});

  @override
  ConsumerState<CustomersScreen> createState() => _CustomersScreenState();
}

class _CustomersScreenState extends ConsumerState<CustomersScreen> {
  String _searchQuery = '';
  String _selectedCategory = 'All';

  @override
  Widget build(BuildContext context) {
    final customers = ref.watch(customersProvider);
    final notifier = ref.read(customersProvider.notifier);

    final filteredCustomers =
        customers.where((customer) {
          final matchesCategory =
              _selectedCategory == 'All' ||
              customer.category == _selectedCategory;
          final matchesSearch = customer.name.toLowerCase().contains(
            _searchQuery.toLowerCase(),
          );
          return matchesCategory && matchesSearch;
        }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Customers'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _showCategoryFilter,
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Search Customers...',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),
          Expanded(
            child: LPullRefreshList<Customer>(
              onRefresh: notifier.loadCustomers,
              items: filteredCustomers,
              itemBuilder:
                  (context, customer) => Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    child: ListTile(
                      title: Text(customer.name),
                      subtitle: LCustomerCategoryBadge(
                        category: customer.category,
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.map),
                        onPressed: () {
                          context.go('/customer_map');
                        },
                      ),
                      onTap: () {
                        context.go('/customers');
                      },
                    ),
                  ),
              emptyMessage: 'No customers found',
            ),
          ),
        ],
      ),
    );
  }

  void _showCategoryFilter() {
    showModalBottomSheet(
      context: context,
      builder:
          (context) => Column(
            mainAxisSize: MainAxisSize.min,
            children:
                ['All', 'A+', 'A', 'B', 'C']
                    .map(
                      (category) => ListTile(
                        title: Text(category),
                        onTap: () {
                          setState(() {
                            _selectedCategory = category;
                          });
                          Navigator.pop(context);
                        },
                      ),
                    )
                    .toList(),
          ),
    );
  }
}
