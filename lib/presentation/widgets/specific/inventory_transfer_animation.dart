import 'package:flutter/material.dart';

class LInventoryTransferAnimation extends StatefulWidget {
  final String fromWarehouse;
  final String toWarehouse;

  const LInventoryTransferAnimation({
    super.key,
    required this.fromWarehouse,
    required this.toWarehouse,
  });

  @override
  State<LInventoryTransferAnimation> createState() =>
      _LInventoryTransferAnimationState();
}

class _LInventoryTransferAnimationState
    extends State<LInventoryTransferAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    _animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _controller.repeat(reverse: false);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DottedTransferPainter(_animation),
      size: const Size(double.infinity, 200),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(widget.fromWarehouse),
            const SizedBox(height: 20),
            const Icon(Icons.local_shipping, size: 40, color: Colors.blue),
            const SizedBox(height: 20),
            Text(widget.toWarehouse),
          ],
        ),
      ),
    );
  }
}

class _DottedTransferPainter extends CustomPainter {
  final Animation<double> animation;
  _DottedTransferPainter(this.animation) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = Colors.grey
          ..strokeWidth = 2
          ..style = PaintingStyle.stroke;

    final path = Path();
    path.moveTo(size.width * 0.2, size.height * 0.5);
    path.lineTo(size.width * 0.8, size.height * 0.5);

    final dashWidth = 10;
    final dashSpace = 5;
    double distance = 0;
    final totalLength = size.width * 0.6;

    while (distance < totalLength) {
      canvas.drawLine(
        Offset(size.width * 0.2 + distance, size.height * 0.5),
        Offset(
          size.width * 0.2 + distance + dashWidth * animation.value,
          size.height * 0.5,
        ),
        paint,
      );
      distance += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
