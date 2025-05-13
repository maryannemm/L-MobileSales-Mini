class OrderNumberGenerator {
  static String generateOrderNumber(int existingOrdersCount) {
    final now = DateTime.now();
    final datePart = '${now.year}-${_twoDigits(now.month)}';
    final orderPart = (existingOrdersCount + 1).toString().padLeft(3, '0');
    return 'ORD-$datePart-$orderPart';
  }

  static String _twoDigits(int n) => n.toString().padLeft(2, '0');
}
