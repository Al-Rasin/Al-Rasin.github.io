import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../theme/app_theme.dart';

/// One readable column; about 70 characters of body text per line.
const double kMaxContentWidth = 640;

/// Web links open in a new tab; mailto/tel stay in place so the mail or
/// phone app opens without leaving a blank tab behind.
Future<void> openUrl(String url) => launchUrl(
  Uri.parse(url),
  webOnlyWindowName: url.startsWith('mailto') ? '_self' : '_blank',
);

bool isNarrow(BuildContext context) => MediaQuery.sizeOf(context).width < 700;

class ContentWidth extends StatelessWidget {
  const ContentWidth({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: kMaxContentWidth + (isNarrow(context) ? 40 : 48),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: isNarrow(context) ? 20 : 24),
          child: child,
        ),
      ),
    );
  }
}

/// Plain text link: thin rust underline that darkens on hover.
class TextLink extends StatefulWidget {
  const TextLink(this.label, {super.key, this.url, this.onTap, this.style});

  final String label;
  final String? url;
  final VoidCallback? onTap;
  final TextStyle? style;

  @override
  State<TextLink> createState() => _TextLinkState();
}

class _TextLinkState extends State<TextLink> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final style = widget.style ?? AppText.body;
    return Semantics(
      link: true,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _hover = true),
        onExit: (_) => setState(() => _hover = false),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: widget.onTap ?? () => openUrl(widget.url!),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 120),
            padding: const EdgeInsets.only(bottom: 1),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: AppColors.accent.withValues(alpha: _hover ? 1 : 0.4),
                ),
              ),
            ),
            child: Text(
              widget.label,
              style: style.copyWith(
                color: _hover ? AppColors.accent : style.color,
                height: 1.25,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// A row of text links separated by spacing, wrapping on small screens.
class LinkRow extends StatelessWidget {
  const LinkRow(this.links, {super.key});

  final List<Widget> links;

  @override
  Widget build(BuildContext context) {
    return Wrap(spacing: 20, runSpacing: 10, children: links);
  }
}

/// Section: hairline rule, a plain heading, then content.
class Section extends StatelessWidget {
  const Section({super.key, required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: isNarrow(context) ? 56 : 72),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(height: 1, color: AppColors.line),
          const SizedBox(height: 14),
          Text(title, style: AppText.sectionTitle),
          const SizedBox(height: 28),
          child,
        ],
      ),
    );
  }
}
