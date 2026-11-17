import 'dart:ui' show PointerDeviceKind;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme/app_theme.dart';
import 'common.dart';

/// Lets mouse users drag the strip sideways, not just trackpad/touch.
class _DragScrollBehavior extends MaterialScrollBehavior {
  const _DragScrollBehavior();

  @override
  Set<PointerDeviceKind> get dragDevices => PointerDeviceKind.values.toSet();
}

/// Phone screenshots in a horizontal strip. Click one to see it large.
class ScreenshotRow extends StatelessWidget {
  const ScreenshotRow({
    super.key,
    required this.images,
    this.aspect = 480 / 1066,
  });

  final List<String> images;

  /// Width / height of the images in this row.
  final double aspect;

  @override
  Widget build(BuildContext context) {
    final height = isNarrow(context) ? 220.0 : 280.0;
    final width = height * aspect;
    return SizedBox(
      height: height,
      child: ScrollConfiguration(
        behavior: const _DragScrollBehavior(),
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: images.length,
          separatorBuilder: (_, _) => const SizedBox(width: 12),
          itemBuilder: (context, i) => MouseRegion(
            cursor: SystemMouseCursors.zoomIn,
            child: GestureDetector(
              onTap: () => showScreenshots(context, images, i),
              child: Container(
                width: width,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.line),
                ),
                child: Image.asset(
                  images[i],
                  fit: BoxFit.cover,
                  cacheWidth: (width * 2).round(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> showScreenshots(
  BuildContext context,
  List<String> images,
  int start,
) => showDialog(
  context: context,
  barrierColor: AppColors.bg.withValues(alpha: 0.97),
  builder: (_) => _Viewer(images: images, start: start),
);

class _Viewer extends StatefulWidget {
  const _Viewer({required this.images, required this.start});

  final List<String> images;
  final int start;

  @override
  State<_Viewer> createState() => _ViewerState();
}

class _ViewerState extends State<_Viewer> {
  late final _controller = PageController(initialPage: widget.start);
  late int _index = widget.start;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _go(int delta) {
    final next = _index + delta;
    if (next < 0 || next >= widget.images.length) return;
    _controller.animateToPage(
      next,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final count = widget.images.length;
    return CallbackShortcuts(
      bindings: {
        const SingleActivator(LogicalKeyboardKey.arrowLeft): () => _go(-1),
        const SingleActivator(LogicalKeyboardKey.arrowRight): () => _go(1),
      },
      child: Focus(
        autofocus: true,
        child: Material(
          type: MaterialType.transparency,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text('${_index + 1} / $count', style: AppText.code),
                      const Spacer(),
                      TextLink(
                        'Close',
                        style: AppText.small,
                        onTap: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ScrollConfiguration(
                      behavior: const _DragScrollBehavior(),
                      child: PageView.builder(
                        controller: _controller,
                        itemCount: count,
                        onPageChanged: (i) => setState(() => _index = i),
                        itemBuilder: (_, i) => Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(14),
                            child: Image.asset(widget.images[i]),
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (count > 1) ...[
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Opacity(
                          opacity: _index > 0 ? 1 : 0.3,
                          child: TextLink(
                            '← Previous',
                            style: AppText.small,
                            onTap: () => _go(-1),
                          ),
                        ),
                        const SizedBox(width: 32),
                        Opacity(
                          opacity: _index < count - 1 ? 1 : 0.3,
                          child: TextLink(
                            'Next →',
                            style: AppText.small,
                            onTap: () => _go(1),
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
