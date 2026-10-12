import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// Differentiated radar: navy concentric rings + amber sweep (not Figma copy).
class RadarSweep extends StatelessWidget {
  final double size;
  const RadarSweep({super.key, this.size = 240});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(painter: _RadarPainter()),
    );
  }
}

class _RadarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final c = Offset(size.width / 2, size.height / 2);
    final maxR = size.width / 2;
    const fills = [
      AppColors.roseBg,
      AppColors.peachBg,
      AppColors.lilacBg,
      AppColors.greenBg,
    ];
    for (var i = 4; i >= 1; i--) {
      canvas.drawCircle(
        c,
        maxR * i / 4,
        Paint()..color = fills[4 - i],
      );
    }
    // rings
    for (var i = 1; i <= 4; i++) {
      canvas.drawCircle(
        c,
        maxR * i / 4,
        Paint()
          ..color = AppColors.cocoa.withValues(alpha: 0.25)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1,
      );
    }
    // terracotta sweep arc
    canvas.drawArc(
      Rect.fromCircle(center: c, radius: maxR * 0.75),
      -1.2,
      0.9,
      true,
      Paint()..color = AppColors.terracotta.withValues(alpha: 0.55),
    );
    // center
    canvas.drawCircle(c, 34, Paint()..color = AppColors.cocoa);
    canvas.drawCircle(c, 5, Paint()..color = Colors.white);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
