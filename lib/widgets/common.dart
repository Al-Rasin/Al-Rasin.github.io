import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data/portfolio_data.dart';
import '../theme/app_theme.dart';

const double kMaxContentWidth = 1120;

/// Web links open in a new tab; mailto/tel stay in place so the mail or
/// phone app opens without leaving a blank tab behind.
Future<void> openUrl(String url) => launchUrl(
  Uri.parse(url),
  webOnlyWindowName: url.startsWith('http') ? '_blank' : '_self',
);

bool isNarrow(BuildContext context) => MediaQuery.sizeOf(context).width < 800;

/// Centers its child and caps the width so lines stay readable on wide screens.
class ContentWidth extends StatelessWidget {
  const ContentWidth({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: kMaxContentWidth),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isNarrow(context) ? 20 : 40,
          ),
          child: child,
        ),
      ),
    );
  }
}

class GradientText extends StatelessWidget {
  const GradientText(
    this.text, {
    super.key,
    required this.style,
    this.gradient = AppColors.headlineGradient,
    this.textAlign,
  });

  final String text;
  final TextStyle? style;
  final Gradient gradient;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(bounds),
      child: Text(text, style: style, textAlign: textAlign),
    );
  }
}

/// Small bordered pill, e.g. the badge above the headline.
class Pill extends StatelessWidget {
  const Pill({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppColors.border),
      ),
      child: DefaultTextStyle.merge(
        style: const TextStyle(fontSize: 13, color: AppColors.muted),
        child: child,
      ),
    );
  }
}

class SectionHeading extends StatelessWidget {
  const SectionHeading({
    super.key,
    required this.eyebrow,
    required this.title,
    this.subtitle,
    this.center = false,
  });

  final String eyebrow;
  final String title;
  final String? subtitle;
  final bool center;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final align = center ? TextAlign.center : TextAlign.start;
    return Column(
      crossAxisAlignment: center
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        Text(
          eyebrow,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.accent,
          ),
        ),
        const SizedBox(height: 14),
        GradientText(
          title,
          textAlign: align,
          style: textTheme.headlineLarge?.copyWith(
            fontSize: isNarrow(context) ? 32 : 44,
          ),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 14),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: Text(
              subtitle!,
              textAlign: align,
              style: textTheme.bodyLarge,
            ),
          ),
        ],
      ],
    );
  }
}

/// Primary (white) or secondary (outlined) button.
class AppButton extends StatefulWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.primary = true,
    this.small = false,
  });

  final String label;
  final VoidCallback onPressed;
  final IconData? icon;
  final bool primary;
  final bool small;

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final primary = widget.primary;
    final fg = primary ? AppColors.bg : AppColors.text;
    final bg = primary
        ? (_hovered ? const Color(0xFFD9DADD) : AppColors.text)
        : (_hovered ? AppColors.surface : Colors.transparent);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: EdgeInsets.symmetric(
            horizontal: widget.small ? 16 : 22,
            vertical: widget.small ? 9 : 14,
          ),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(999),
            border: Border.all(
              color: primary
                  ? Colors.transparent
                  : (_hovered ? AppColors.borderHover : AppColors.border),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.label,
                style: TextStyle(
                  fontSize: widget.small ? 14 : 15,
                  fontWeight: FontWeight.w500,
                  color: fg,
                ),
              ),
              if (widget.icon != null) ...[
                const SizedBox(width: 8),
                AnimatedSlide(
                  offset: Offset(_hovered ? .2 : 0, 0),
                  duration: const Duration(milliseconds: 150),
                  child: Icon(widget.icon, size: 16, color: fg),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// Fades and slides its child in once, after [delay].
class Reveal extends StatefulWidget {
  const Reveal({super.key, required this.child, this.delay = Duration.zero});

  final Widget child;
  final Duration delay;

  @override
  State<Reveal> createState() => _RevealState();
}

class _RevealState extends State<Reveal> with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 700),
  );
  late final _curve = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeOutCubic,
  );

  @override
  void initState() {
    super.initState();
    Future.delayed(widget.delay, () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _curve,
      child: SlideTransition(
        position: Tween(
          begin: const Offset(0, .08),
          end: Offset.zero,
        ).animate(_curve),
        child: widget.child,
      ),
    );
  }
}

/// LinkedIn, Facebook and GitHub buttons.
class SocialLinks extends StatelessWidget {
  const SocialLinks({super.key, this.alignment = WrapAlignment.start});

  final WrapAlignment alignment;

  static const _links = [
    ('LinkedIn', PortfolioData.linkedin),
    ('Facebook', PortfolioData.facebook),
    ('GitHub', PortfolioData.github),
  ];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: alignment,
      spacing: 10,
      runSpacing: 10,
      children: [
        for (final (label, url) in _links)
          AppButton(
            label: label,
            icon: Icons.north_east_rounded,
            primary: false,
            small: true,
            onPressed: () => openUrl(url),
          ),
      ],
    );
  }
}
