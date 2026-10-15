import 'package:flutter/material.dart';

import '../data/portfolio_data.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';
import '../widgets/hero_background.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({
    super.key,
    required this.onSeeWork,
    required this.onContact,
  });

  final VoidCallback onSeeWork;
  final VoidCallback onContact;

  @override
  Widget build(BuildContext context) {
    final narrow = isNarrow(context);

    return Stack(
      children: [
        const Positioned.fill(child: HeroBackground()),
        ContentWidth(
          child: Padding(
            padding: EdgeInsets.only(
              top: narrow ? 56 : 100,
              bottom: narrow ? 64 : 120,
            ),
            child: SizedBox(
              width: double.infinity,
              child: _Intro(onSeeWork: onSeeWork, onContact: onContact),
            ),
          ),
        ),
      ],
    );
  }
}

class _Intro extends StatelessWidget {
  const _Intro({required this.onSeeWork, required this.onContact});

  final VoidCallback onSeeWork;
  final VoidCallback onContact;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final narrow = isNarrow(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Reveal(
          child: Pill(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    color: AppColors.accent,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                const Text('Open to new opportunities'),
              ],
            ),
          ),
        ),
        const SizedBox(height: 28),
        Reveal(
          delay: const Duration(milliseconds: 100),
          child: GradientText(
            'Crafting smooth\nFlutter apps.',
            style: textTheme.displayLarge?.copyWith(
              fontSize: narrow
                  ? (MediaQuery.sizeOf(context).width < 420 ? 40 : 46)
                  : 72,
              letterSpacing: narrow ? -1.8 : -3,
            ),
          ),
        ),
        const SizedBox(height: 24),
        Reveal(
          delay: const Duration(milliseconds: 200),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Text(
              "I'm ${PortfolioData.name}, a Flutter developer from "
              'Dhaka. I build fast, polished cross-platform apps with '
              'Flutter, Dart and Firebase.',
              style: textTheme.bodyLarge,
            ),
          ),
        ),
        const SizedBox(height: 36),
        Reveal(
          delay: const Duration(milliseconds: 300),
          child: Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              AppButton(
                label: 'See my work',
                icon: Icons.arrow_forward_rounded,
                onPressed: onSeeWork,
              ),
              AppButton(
                label: 'Contact me',
                primary: false,
                onPressed: onContact,
              ),
            ],
          ),
        ),
        const SizedBox(height: 28),
        const Reveal(delay: Duration(milliseconds: 400), child: SocialLinks()),
      ],
    );
  }
}
