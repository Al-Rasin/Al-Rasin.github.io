import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Faint grid that fades out toward the edges, with a soft accent glow on top.
///
/// Static, so it paints once and is cached by the RepaintBoundary.
class HeroBackground extends StatelessWidget {
  const HeroBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Stack(
        fit: StackFit.expand,
        children: [
          ShaderMask(
            blendMode: BlendMode.dstIn,
            shaderCallback: (bounds) => const RadialGradient(
              center: Alignment(0, -.6),
              radius: .9,
              colors: [Colors.white, Colors.transparent],
            ).createShader(bounds),
            child: CustomPaint(painter: _GridPainter()),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: const Alignment(.5, -1.1),
                radius: 1.0,
                colors: [
                  AppColors.accent.withValues(alpha: .22),
                  AppColors.accent.withValues(alpha: 0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GridPainter extends CustomPainter {
  static const _cell = 64.0;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: .05)
      ..strokeWidth = 1;
    for (var x = 0.0; x <= size.width; x += _cell) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (var y = 0.0; y <= size.height; y += _cell) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(_GridPainter old) => false;
}
