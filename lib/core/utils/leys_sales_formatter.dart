import 'package:intl/intl.dart';

class LeysSalesFormatter {
  static String format(double amount) {
    final formatter = NumberFormat('#,##0.00', 'en_KE');
    final formatted = formatter.format(amount);
    return 'KES $formatted /=';
  }
}
