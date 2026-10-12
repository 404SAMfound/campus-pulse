import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// Simple sparkline / bar graph placeholder that renders an axis with no data.
/// Used to keep UI honest while backend is missing (nothing fake).
class SparklinePlaceholder extends StatelessWidget {
  final String caption;
  const SparklinePlaceholder({super.key, required this.caption});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 48,
          child: CustomPaint(painter: _DashPainter(), size: const Size(double.infinity, 48)),
        ),
        const SizedBox(height: 4),
        Text(
          caption,
          style: const TextStyle(fontFamily: 'Courier New', fontSize: 10, color: AppColors.muted),
        ),
      ],
    );
  }
}

class _DashPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()
      ..color = AppColors.terracotta.withValues(alpha: 0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    // dashed baseline = "no data yet"
    var x = 0.0;
    while (x < size.width) {
      canvas.drawLine(Offset(x, size.height / 2), Offset(x + 6, size.height / 2), p);
      x += 12;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Crowd curve skeleton: 8 empty slots with mono axis, no values.
class CrowdCurveSkeleton extends StatelessWidget {
  const CrowdCurveSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    const hours = ['8a', '10a', '12p', '2p', '4p', '6p', '8p', '10p'];
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(8, (i) {
            return Container(
              width: 22,
              height: 28 + (i % 3) * 8, // varied skeleton heights, not data
              decoration: BoxDecoration(
                color: AppColors.pastelFor(i),
                borderRadius: BorderRadius.circular(8),
              ),
            );
          }),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            for (var h in hours)
              Text(h, style: const TextStyle(fontFamily: 'Courier New', fontSize: 10, color: Color(0xFF667085))),
          ],
        ),
      ],
    );
  }
}
