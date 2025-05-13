import 'package:flutter/material.dart';

/// @widget: LCustomerCategoryBadge
/// @created-date: 12-05-2025
/// @leysco-version: 1.0.0
/// @description: Badge displaying customer category (A, A+, B, C, etc.)
class LCustomerCategoryBadge extends StatelessWidget {
  final String category;

  const LCustomerCategoryBadge({super.key, required this.category});

  Color _getColor() {
    switch (category) {
      case 'A+':
        return Colors.green.shade800;
      case 'A':
        return Colors.green;
      case 'B':
        return Colors.orange;
      case 'C':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _getColor(),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        category,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
