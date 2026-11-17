import 'package:flutter/material.dart';

import '../data/portfolio_data.dart';
import '../theme/app_theme.dart';
import '../widgets/common.dart';
import '../widgets/spotlight_card.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final narrow = isNarrow(context);

    return ContentWidth(
      child: Padding(
        padding: EdgeInsets.only(top: narrow ? 72 : 100),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionHeading(
                eyebrow: 'Experience',
                title: 'Where I have worked',
              ),
              SizedBox(height: narrow ? 32 : 48),
              SpotlightCard(
                padding: EdgeInsets.symmetric(
                  horizontal: narrow ? 22 : 28,
                  vertical: narrow ? 8 : 12,
                ),
                child: Column(
                  children: [
                    for (var i = 0; i < PortfolioData.experience.length; i++)
                      _ExperienceRow(
                        PortfolioData.experience[i],
                        showDivider: i > 0,
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

class _ExperienceRow extends StatelessWidget {
  const _ExperienceRow(this.item, {required this.showDivider});

  final Experience item;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final narrow = isNarrow(context);
    final meta = item.location;
    const metaStyle = TextStyle(fontSize: 13, color: AppColors.subtle);

    final heading = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(item.company, style: textTheme.titleLarge),
        const SizedBox(height: 4),
        Text(
          item.role,
          style: const TextStyle(fontSize: 14.5, color: AppColors.text),
        ),
      ],
    );

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: narrow ? 20 : 24),
      decoration: BoxDecoration(
        border: showDivider
            ? const Border(top: BorderSide(color: AppColors.border))
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (narrow) ...[
            heading,
            if (meta != null) ...[
              const SizedBox(height: 6),
              Text(meta, style: metaStyle),
            ],
          ] else
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: heading),
                if (meta != null) ...[
                  const SizedBox(width: 16),
                  Padding(
                    padding: const EdgeInsets.only(top: 3),
                    child: Text(meta, style: metaStyle),
                  ),
                ],
              ],
            ),
          if (item.summary != null) ...[
            const SizedBox(height: 12),
            Text(item.summary!, style: textTheme.bodyMedium),
          ],
        ],
      ),
    );
  }
}
