import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Glass card with a soft glow that follows the mouse.
class SpotlightCard extends StatefulWidget {
  const SpotlightCard({
    super.key,
    required this.child,
    this.onTap,
    this.padding = const EdgeInsets.all(24),
  });

  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsets padding;

  @override
  State<SpotlightCard> createState() => _SpotlightCardState();
}

class _SpotlightCardState extends State<SpotlightCard> {
  // Pointer position; null when the mouse is outside the card. A notifier
  // means moving the mouse only repaints the glow, not the card contents.
  final _pointer = ValueNotifier<Offset?>(null);

  @override
  void dispose() {
    _pointer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: MouseRegion(
        cursor: widget.onTap != null
            ? SystemMouseCursors.click
            : MouseCursor.defer,
        onHover: (e) => _pointer.value = e.localPosition,
        onExit: (_) => _pointer.value = null,
        child: GestureDetector(
          onTap: widget.onTap,
          child: ValueListenableBuilder<Offset?>(
            valueListenable: _pointer,
            builder: (context, pos, child) => DecoratedBox(
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: pos != null ? AppColors.borderHover : AppColors.border,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: CustomPaint(painter: _GlowPainter(pos), child: child),
              ),
            ),
            child: Padding(padding: widget.padding, child: widget.child),
          ),
        ),
      ),
    );
  }
}

class _GlowPainter extends CustomPainter {
  _GlowPainter(this.pos);

  final Offset? pos;

  @override
  void paint(Canvas canvas, Size size) {
    final p = pos;
    if (p == null) return;
    const r = 260.0;
    canvas.drawCircle(
      p,
      r,
      Paint()
        ..shader = RadialGradient(
          colors: [
            AppColors.accent.withValues(alpha: .13),
            AppColors.accent.withValues(alpha: 0),
          ],
        ).createShader(Rect.fromCircle(center: p, radius: r)),
    );
  }

  @override
  bool shouldRepaint(_GlowPainter old) => old.pos != pos;
}
