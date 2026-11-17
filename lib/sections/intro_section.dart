import 'package:flutter/material.dart';

import '../data/portfolio_data.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';
import '../widgets/screenshots.dart';

/// Thin bar on top: name on the left, jump links on the right.
class TopBar extends StatelessWidget {
  const TopBar({super.key, required this.onJump});

  /// Called with 'work', 'projects' or 'contact'.
  final void Function(String) onJump;

  @override
  Widget build(BuildContext context) {
    final style = AppText.small.copyWith(color: AppColors.text);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Row(
        children: [
          Text('AL RASIN', style: AppText.code.copyWith(color: AppColors.text)),
          const SizedBox(width: 16),
          Expanded(
            child: Wrap(
              alignment: WrapAlignment.end,
              spacing: isNarrow(context) ? 16 : 28,
              runSpacing: 8,
              children: [
                if (!isNarrow(context))
                  TextLink('Work', style: style, onTap: () => onJump('work')),
                TextLink(
                  'Projects',
                  style: style,
                  onTap: () => onJump('projects'),
                ),
                TextLink(
                  'Contact',
                  style: style,
                  onTap: () => onJump('contact'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final w = screenWidth(context);
    final size = (w * 0.2).clamp(64.0, 250.0);
    final narrow = isNarrow(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: narrow ? 48 : 88),
        Row(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: AppColors.accent,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 10),
            Flexible(
              child: Text(
                'Mobile app developer, Dhaka. Open to remote work.',
                style: AppText.code.copyWith(color: AppColors.text),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerLeft,
          child: Text('AL RASIN', style: AppText.headline(size)),
        ),
        SizedBox(height: narrow ? 28 : 40),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'I build apps people actually open.',
                style: AppText.lead.copyWith(fontSize: narrow ? 24 : 34),
              ),
              const SizedBox(height: 20),
              Text(PortfolioData.intro, style: AppText.muted),
              const SizedBox(height: 32),
              LinkRow([
                TextLink('Email me', url: 'mailto:${PortfolioData.email}'),
                const TextLink('CV (PDF)', url: PortfolioData.cv),
                const TextLink('GitHub', url: PortfolioData.github),
                const TextLink('LinkedIn', url: PortfolioData.linkedin),
              ]),
            ],
          ),
        ),
      ],
    );
  }
}

/// A long row of phones that slides sideways as the page scrolls.
class PhoneStrip extends StatelessWidget {
  const PhoneStrip({super.key, required this.scroll});

  final ScrollController scroll;

  static const _images = [
    'assets/images/apps/tubeonai-1.jpg',
    'assets/images/projects/transcribr-home.jpg',
    'assets/images/apps/tubeonai-2.jpg',
    'assets/images/projects/tvuart-home.jpg',
    'assets/images/projects/jimi-chat.jpg',
    'assets/images/apps/tubeonai-3.jpg',
    'assets/images/projects/focusguard-home.jpg',
    'assets/images/projects/transcribr-transcript.jpg',
    'assets/images/apps/hellotask-1.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    final phone = isNarrow(context) ? 150.0 : 230.0;
    const aspect = 480 / 1000;
    final height = phone / aspect + phone * 0.08 + 8;
    return SizedBox(
      height: height,
      child: ClipRect(
        child: AnimatedBuilder(
          animation: scroll,
          builder: (context, child) {
            final y = scroll.hasClients ? scroll.offset : 0.0;
            return Transform.translate(
              offset: Offset(sidePad(context) - y * 0.45, 0),
              child: child,
            );
          },
          child: RepaintBoundary(
            child: OverflowBox(
              alignment: Alignment.topLeft,
              maxWidth: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (final (i, img) in _images.indexed)
                    Padding(
                      padding: EdgeInsets.only(
                        right: 20,
                        top: i.isOdd ? 0 : phone * 0.08,
                      ),
                      child: PhoneFrame(
                        image: img,
                        width: phone,
                        aspect: aspect,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ToolsSection extends StatelessWidget {
  const ToolsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Section(
      index: PortfolioData.blogPosts.isEmpty ? '03' : '04',
      title: 'Tools',
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 760),
        child: Text(PortfolioData.tools, style: AppText.lead),
      ),
    );
  }
}
