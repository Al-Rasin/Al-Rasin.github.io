import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../theme/app_theme.dart';

const double kMaxPageWidth = 1180;

/// Web links open in a new tab; mailto/tel stay in place so the mail or
/// phone app opens without leaving a blank tab behind.
Future<void> openUrl(String url) => launchUrl(
  Uri.parse(url),
  webOnlyWindowName: url.startsWith('mailto') ? '_self' : '_blank',
);

double screenWidth(BuildContext context) => MediaQuery.sizeOf(context).width;
bool isNarrow(BuildContext context) => screenWidth(context) < 700;
bool isWide(BuildContext context) => screenWidth(context) >= 960;
double sidePad(BuildContext context) => isNarrow(context) ? 20 : 40;

class PageWidth extends StatelessWidget {
  const PageWidth({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final pad = sidePad(context);
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: kMaxPageWidth + pad * 2),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: pad),
          child: child,
        ),
      ),
    );
  }
}

/// Text link with an orange underline that fills in on hover.
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
            padding: const EdgeInsets.only(bottom: 2),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 1.5,
                  color: AppColors.accent.withValues(alpha: _hover ? 1 : 0.45),
                ),
              ),
            ),
            child: Text(
              widget.label,
              style: style.copyWith(
                color: _hover ? AppColors.accent : style.color,
                height: 1.2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LinkRow extends StatelessWidget {
  const LinkRow(this.links, {super.key});

  final List<Widget> links;

  @override
  Widget build(BuildContext context) {
    return Wrap(spacing: 24, runSpacing: 12, children: links);
  }
}

/// Section: a mono index on the rule, a big condensed title, then content.
class Section extends StatelessWidget {
  const Section({
    super.key,
    required this.index,
    required this.title,
    required this.child,
  });

  final String index;
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final size = (screenWidth(context) * 0.1).clamp(48.0, 112.0);
    return Padding(
      padding: EdgeInsets.only(top: isNarrow(context) ? 88 : 140),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(index, style: AppText.code),
              const SizedBox(width: 14),
              Expanded(child: Container(height: 1, color: AppColors.line)),
            ],
          ),
          const SizedBox(height: 20),
          Text(title, style: AppText.headline(size)),
          SizedBox(height: isNarrow(context) ? 40 : 64),
          child,
        ],
      ),
    );
  }
}
