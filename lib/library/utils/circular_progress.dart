import 'package:flutter/material.dart';

class CircleProgressBar extends CustomPainter {
  final double percentage;

  CircleProgressBar({required this.percentage});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 10.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    double radius = size.width / 2;
    Offset center = Offset(size.width / 2, size.height / 2);

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -0.5 * 3.14,
      percentage * 2 * 3.14,
      false,
      paint,
    );

    TextSpan span = TextSpan(
      style: const TextStyle(
        color: Colors.black,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
      text: '${(percentage * 100).toStringAsFixed(0)}%',
    );
    TextPainter tp = TextPainter(
      text: span,
      textDirection: TextDirection.ltr,
    );
    tp.layout();
    Offset textOffset = Offset(center.dx - tp.width / 2, center.dy - tp.height / 2);
    tp.paint(canvas, textOffset);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}