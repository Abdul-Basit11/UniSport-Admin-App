import 'package:flutter/material.dart';

import '../const/colors.dart';

class DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double dashWidth = 4.0, dashSpace = 3.0, startX = 0.0;
    final paint = Paint()
      ..color = AppColors.kGrey.withOpacity(0.5)
      ..strokeWidth = 2;
    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(double.infinity, 0), // You can change the size as needed
      painter: DashedLinePainter(),
    );
  }
}
