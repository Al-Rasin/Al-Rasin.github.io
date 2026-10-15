import 'package:flutter/material.dart';

import '../data/portfolio_data.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';
import '../widgets/spotlight_card.dart';

class LiveAppsSection extends StatelessWidget {
  const LiveAppsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ContentWidth(
      child: Padding(
        padding: EdgeInsets.only(top: isNarrow(context) ? 40 : 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeading(
              eyebrow: 'Live apps',
              title: 'Published on the stores',
              subtitle:
                  'Flutter apps I worked on that real people use '
                  'every day.',
            ),
            SizedBox(height: isNarrow(context) ? 32 : 48),
            LayoutBuilder(
              builder: (context, constraints) {
                const gap = 16.0;
                final columns = constraints.maxWidth >= 700 ? 2 : 1;
                final cardWidth =
                    (constraints.maxWidth - gap * (columns - 1)) / columns;

                return Wrap(
                  spacing: gap,
                  runSpacing: gap,
                  children: [
                    for (final app in PortfolioData.liveApps)
                      SizedBox(width: cardWidth, child: _LiveAppCard(app)),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _LiveAppCard extends StatelessWidget {
  const _LiveAppCard(this.app);

  final LiveApp app;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SpotlightCard(
      padding: EdgeInsets.all(isNarrow(context) ? 22 : 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.accent.withValues(alpha: .12),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.accent.withValues(alpha: .35),
                  ),
                ),
                child: Icon(app.icon, size: 22, color: AppColors.accent),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(app.title, style: textTheme.titleLarge),
                    const SizedBox(height: 2),
                    Text(
                      app.publisher,
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.subtle,
                      ),
                    ),
                  ],
                ),
              ),
              const Pill(child: Text('Live')),
            ],
          ),
          const SizedBox(height: 20),
          Text(app.description, style: textTheme.bodyMedium),
          const SizedBox(height: 24),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              if (app.appStoreUrl != null)
                AppButton(
                  label: 'App Store',
                  icon: Icons.apple,
                  primary: false,
                  small: true,
                  onPressed: () => openUrl(app.appStoreUrl!),
                ),
              if (app.playStoreUrl != null)
                AppButton(
                  label: 'Google Play',
                  icon: Icons.android_rounded,
                  primary: false,
                  small: true,
                  onPressed: () => openUrl(app.playStoreUrl!),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
