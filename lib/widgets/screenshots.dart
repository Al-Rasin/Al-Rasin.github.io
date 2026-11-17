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

/// A screenshot inside a plain black phone body with a small camera pill.
/// [width] is the outer width; height follows the image aspect.
class PhoneFrame extends StatefulWidget {
  const PhoneFrame({
    super.key,
    required this.image,
    required this.width,
    this.aspect = 480 / 1066,
    this.onTap,
  });

  final String image;
  final double width;
  final double aspect;
  final VoidCallback? onTap;

  @override
  State<PhoneFrame> createState() => _PhoneFrameState();
}

class _PhoneFrameState extends State<PhoneFrame> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final bezel = widget.width * 0.035;
    final inner = widget.width - bezel * 2;
    final radius = widget.width * 0.14;
    return MouseRegion(
      cursor: widget.onTap == null
          ? MouseCursor.defer
          : SystemMouseCursors.zoomIn,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedSlide(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          offset: Offset(0, _hover && widget.onTap != null ? -0.015 : 0),
          child: Container(
            width: widget.width,
            padding: EdgeInsets.all(bezel),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(radius),
              border: Border.all(color: const Color(0xFF34332E), width: 1.2),
            ),
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(radius - bezel),
                  child: SizedBox(
                    width: inner,
                    height: inner / widget.aspect,
                    child: Image.asset(
                      widget.image,
                      fit: BoxFit.cover,
                      cacheWidth: (inner * 2).round(),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: inner * 0.03),
                  child: Container(
                    width: inner * 0.26,
                    height: inner * 0.065,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(inner),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Phones side by side in a strip you can drag. Click one to see it large.
class PhoneRow extends StatelessWidget {
  const PhoneRow({
    super.key,
    required this.images,
    this.aspect = 480 / 1066,
    this.phoneWidth,
  });

  final List<String> images;
  final double aspect;
  final double? phoneWidth;

  @override
  Widget build(BuildContext context) {
    final width = phoneWidth ?? (isNarrow(context) ? 150.0 : 190.0);
    final bezel = width * 0.035;
    final height = (width - bezel * 2) / aspect + bezel * 2 + 3;
    return SizedBox(
      height: height,
      child: ScrollConfiguration(
        behavior: const _DragScrollBehavior(),
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          clipBehavior: Clip.none,
          itemCount: images.length,
          separatorBuilder: (_, _) => const SizedBox(width: 16),
          itemBuilder: (context, i) => PhoneFrame(
            image: images[i],
            width: width,
            aspect: aspect,
            onTap: () => showScreenshots(context, images, i),
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
  barrierColor: AppColors.bg.withValues(alpha: 0.96),
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
