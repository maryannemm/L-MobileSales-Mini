import 'package:flutter/material.dart';

class LOrderStatusTimeline extends StatelessWidget {
  final List<OrderStatusStep> steps;

  const LOrderStatusTimeline({super.key, required this.steps});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: steps.length,
      itemBuilder: (context, index) {
        final step = steps[index];
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                CircleAvatar(
                  radius: 12,
                  backgroundColor:
                      step.isCompleted ? Colors.green : Colors.grey,
                  child: Icon(step.icon, size: 16, color: Colors.white),
                ),
                if (index != steps.length - 1)
                  Container(width: 2, height: 50, color: Colors.grey),
              ],
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    step.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: step.isCompleted ? Colors.green : Colors.black,
                    ),
                  ),
                  Text(step.description),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class OrderStatusStep {
  final String title;
  final String description;
  final IconData icon;
  final bool isCompleted;

  OrderStatusStep({
    required this.title,
    required this.description,
    required this.icon,
    required this.isCompleted,
  });
}
