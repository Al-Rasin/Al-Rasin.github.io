import 'dart:ui' show PointerDeviceKind;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../data/portfolio_data.dart';
import '../theme/app_theme.dart';
import 'common.dart';
import 'spotlight_card.dart';

class ProjectCard extends StatelessWidget {
  const ProjectCard({super.key, required this.project});

  final Project project;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SpotlightCard(
      onTap: () => openUrl(project.url),
      padding: const EdgeInsets.all(26),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: AppColors.bg,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.border),
                ),
                child: Icon(project.icon, size: 20, color: AppColors.text),
              ),
              const Spacer(),
              const Icon(
                Icons.north_east_rounded,
                size: 18,
                color: AppColors.subtle,
              ),
            ],
          ),
          const SizedBox(height: 22),
          Text(project.title, style: textTheme.titleLarge),
          const SizedBox(height: 8),
          Text(project.description, style: textTheme.bodyMedium),
          if (project.screenshots.isNotEmpty) ...[
            const SizedBox(height: 20),
            _ScreenshotStrip(screenshots: project.screenshots),
          ],
          const SizedBox(height: 18),
          Text(
            project.tags.join('  ·  '),
            style: const TextStyle(fontSize: 12.5, color: AppColors.subtle),
          ),
        ],
      ),
    );
  }
}

/// Lets mouse and trackpad drag scrollables too, not only touch.
class _DragScrollBehavior extends MaterialScrollBehavior {
  const _DragScrollBehavior();

  @override
  Set<PointerDeviceKind> get dragDevices => PointerDeviceKind.values.toSet();
}

const double _screenshotAspect = 480 / 1066;

class _ScreenshotStrip extends StatelessWidget {
  const _ScreenshotStrip({required this.screenshots});

  final List<String> screenshots;

  @override
  Widget build(BuildContext context) {
    const height = 150.0;
    const width = height * _screenshotAspect;

    return SizedBox(
      height: height,
      child: ScrollConfiguration(
        behavior: const _DragScrollBehavior(),
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: screenshots.length,
          separatorBuilder: (_, _) => const SizedBox(width: 10),
          itemBuilder: (context, i) => MouseRegion(
            cursor: SystemMouseCursors.zoomIn,
            child: GestureDetector(
              onTap: () => _showLightbox(context, screenshots, i),
              child: Container(
                width: width,
                decoration: BoxDecoration(
                  color: AppColors.bg,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.border),
                ),
                padding: const EdgeInsets.all(3),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(9),
                  child: Image.asset(
                    screenshots[i],
                    fit: BoxFit.cover,
                    cacheWidth: 240,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void _showLightbox(BuildContext context, List<String> images, int initial) {
  showDialog<void>(
    context: context,
    barrierColor: Colors.black.withValues(alpha: .88),
    builder: (_) => _Lightbox(images: images, initial: initial),
  );
}

class _Lightbox extends StatefulWidget {
  const _Lightbox({required this.images, required this.initial});

  final List<String> images;
  final int initial;

  @override
  State<_Lightbox> createState() => _LightboxState();
}

class _LightboxState extends State<_Lightbox> {
  late final _controller = PageController(initialPage: widget.initial);
  late int _index = widget.initial;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _go(int delta) {
    final target = (_index + delta).clamp(0, widget.images.length - 1);
    if (target == _index) return;
    _controller.animateToPage(
      target,
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final narrow = isNarrow(context);
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
          child: Stack(
            children: [
              Positioned.fill(
                child: ScrollConfiguration(
                  behavior: const _DragScrollBehavior(),
                  child: PageView.builder(
                    controller: _controller,
                    itemCount: count,
                    onPageChanged: (i) => setState(() => _index = i),
                    itemBuilder: (context, i) => GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => Navigator.of(context).pop(),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(
                          narrow ? 16 : 80,
                          64,
                          narrow ? 16 : 80,
                          56,
                        ),
                        child: Center(
                          child: GestureDetector(
                            onTap: () {},
                            child: AspectRatio(
                              aspectRatio: _screenshotAspect,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.bg,
                                  borderRadius: BorderRadius.circular(22),
                                  border: Border.all(
                                    color: AppColors.borderHover,
                                  ),
                                ),
                                padding: const EdgeInsets.all(5),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(17),
                                  child: Image.asset(
                                    widget.images[i],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 12,
                right: 12,
                child: _RoundIconButton(
                  icon: Icons.close_rounded,
                  tooltip: 'Close',
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              if (!narrow && count > 1) ...[
                Positioned(
                  left: 16,
                  top: 0,
                  bottom: 0,
                  child: Center(
                    child: _RoundIconButton(
                      icon: Icons.chevron_left_rounded,
                      tooltip: 'Previous',
                      onPressed: _index > 0 ? () => _go(-1) : null,
                    ),
                  ),
                ),
                Positioned(
                  right: 16,
                  top: 0,
                  bottom: 0,
                  child: Center(
                    child: _RoundIconButton(
                      icon: Icons.chevron_right_rounded,
                      tooltip: 'Next',
                      onPressed: _index < count - 1 ? () => _go(1) : null,
                    ),
                  ),
                ),
              ],
              if (count > 1)
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 22,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (var i = 0; i < count; i++)
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: i == _index ? 18 : 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: i == _index
                                ? AppColors.text
                                : AppColors.subtle,
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RoundIconButton extends StatelessWidget {
  const _RoundIconButton({
    required this.icon,
    required this.tooltip,
    required this.onPressed,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      tooltip: tooltip,
      icon: Icon(icon, size: 24),
      color: AppColors.text,
      disabledColor: AppColors.subtle,
      style: IconButton.styleFrom(
        backgroundColor: AppColors.surface,
        disabledBackgroundColor: AppColors.surface.withValues(alpha: .5),
        side: const BorderSide(color: AppColors.border),
      ),
    );
  }
}
