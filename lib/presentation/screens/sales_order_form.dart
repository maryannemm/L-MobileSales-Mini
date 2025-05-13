import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import '../../data/models/sales_order.dart';
import '../../core/utils/order_number_generator.dart';
import '../controllers/sales_provider.dart';

class SalesOrderFormScreen extends ConsumerStatefulWidget {
  const SalesOrderFormScreen({super.key});

  @override
  ConsumerState<SalesOrderFormScreen> createState() =>
      _SalesOrderFormScreenState();
}

class _SalesOrderFormScreenState extends ConsumerState<SalesOrderFormScreen> {
  final _formKey = GlobalKey<FormState>();
  String customerId = '';
  double totalAmount = 0.0;
  List<OrderItem> items = [];

  final _productController = TextEditingController();
  final _quantityController = TextEditingController();
  final _priceController = TextEditingController();
  final _discountController = TextEditingController();

  @override
  void dispose() {
    _productController.dispose();
    _quantityController.dispose();
    _priceController.dispose();
    _discountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Sales Order')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Customer ID'),
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? 'Enter Customer ID'
                            : null,
                onSaved: (value) => customerId = value!,
              ),
              const SizedBox(height: 20),
              const Text(
                'Add Items',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextFormField(
                controller: _productController,
                decoration: const InputDecoration(labelText: 'Product ID'),
              ),
              TextFormField(
                controller: _quantityController,
                decoration: const InputDecoration(labelText: 'Quantity'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(labelText: 'Unit Price'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _discountController,
                decoration: const InputDecoration(labelText: 'Discount %'),
                keyboardType: TextInputType.number,
              ),
              ElevatedButton(
                onPressed: _addItem,
                child: const Text('Add Item'),
              ),
              const SizedBox(height: 20),
              ...items.map(
                (item) => ListTile(
                  title: Text('Product: ${item.productId}'),
                  subtitle: Text(
                    'Qty: ${item.quantity}, Price: ${item.unitPrice}, Discount: ${item.discountPercent}%',
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _removeItem(item),
                  ),
                ),
              ),
              const Divider(),
              ElevatedButton(
                onPressed: _saveOrder,
                child: const Text('Save Order'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _addItem() {
    if (_productController.text.isEmpty ||
        _quantityController.text.isEmpty ||
        _priceController.text.isEmpty ||
        _discountController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all item fields')),
      );
      return;
    }

    final item = OrderItem(
      productId: _productController.text,
      quantity: int.tryParse(_quantityController.text) ?? 1,
      unitPrice: double.tryParse(_priceController.text) ?? 0.0,
      discountPercent: double.tryParse(_discountController.text) ?? 0.0,
    );

    setState(() {
      items.add(item);
      _productController.clear();
      _quantityController.clear();
      _priceController.clear();
      _discountController.clear();
    });
  }

  void _removeItem(OrderItem item) {
    setState(() {
      items.remove(item);
    });
  }

  void _saveOrder() async {
    if (_formKey.currentState?.validate() ?? false) {
      if (items.isEmpty) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Add at least one item')));
        return;
      }

      _formKey.currentState?.save();

      totalAmount = items.fold(0.0, (sum, item) {
        final discountedPrice =
            item.unitPrice * item.quantity * (1 - item.discountPercent / 100);
        return sum + discountedPrice;
      });

      final salesBox = await Hive.openBox<SalesOrder>('salesBox');
      final todayOrders = salesBox.values.where(
        (order) =>
            order.orderDate.year == DateTime.now().year &&
            order.orderDate.month == DateTime.now().month &&
            order.orderDate.day == DateTime.now().day,
      );

      final newOrderNumber = OrderNumberGenerator.generateOrderNumber(
        todayOrders.length,
      );

      final newOrder = SalesOrder(
        orderId: newOrderNumber,
        customerId: customerId,
        orderDate: DateTime.now(),
        status: 'Processing',
        totalAmount: totalAmount,
        items: items,
      );

      await salesBox.put(newOrderNumber, newOrder);

      ref.read(salesProvider.notifier).loadSales();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Order Created Successfully')),
        );
        Navigator.pop(context);
      }
    }
  }
}
